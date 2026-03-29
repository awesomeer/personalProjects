#include <ofdm.h>
#include <analog.h>
#include <arm_math.h>

typedef struct {
	q15_t real;
	q15_t imag;
} cq15_t;

typedef union {
	cq15_t * bins;
	q15_t * buff;
} pq15_t;

void ofdm_init(void)
{

}


static q15_t dac_dma_buf[2*(FFT_N + FFT_N/4)];
static q15_t ifft_iq_buff[FFT_N+2];
void ofdm_transmit(uint8_t *data, uint32_t len)
{
    arm_rfft_instance_q15 ifft;
    arm_status ifft_ret;
    (void) ifft_ret;
    ifft_ret = arm_rfft_init_q15(&ifft, FFT_N, 1, 1);

    pq15_t bins;
    bins.buff = ifft_iq_buff;
    
    int dma_buff_idx = FFT_N/4;
    while(len > 0) {

        for(int i = 0; i < 12; i++) {
            q15_t real;
            q15_t imag;
            if(i & 0x01) {
                real = (data[i>>1] >> 4) & 0x03;
                imag = (data[i>>1] >> 6) & 0x03;
            } else{
                real = (data[i>>1] >> 0) & 0x03;
                imag = (data[i>>1] >> 2) & 0x03;
            }
            
            // Sign-extend 2-bit values to Q15 format
            real = (real << 14) >> 14;
            imag = (imag << 14) >> 14;

            bins.bins[i+1].real = real * 0x2C0;
            bins.bins[i+1].imag = imag * 0x2C0;

            bins.bins[i+1].real += real ? 0x2C0 : 0;
            bins.bins[i+1].imag += imag ? 0x2C0 : 0;
        }

        bins.bins[0].real = 0;
        bins.bins[0].imag = 0;
        bins.buff[FFT_N] = (bins.buff[0] - bins.buff[1]) >> 1;
        bins.buff[FFT_N+1] = 0;

        // Generate IFFT output
        arm_rfft_q15(&ifft, bins.buff, &dac_dma_buf[dma_buff_idx]);
        for(int i = 0; i < FFT_N; i++) {
            dac_dma_buf[dma_buff_idx + i] += 0x800; // Scale down and shift to unsigned range
        }
        // Cyclic Prefix: Copy last quarter of IFFT output to the beginning of the DMA buffer
        memcpy(&dac_dma_buf[dma_buff_idx - FFT_N/4], &dac_dma_buf[dma_buff_idx + FFT_N - FFT_N/4], (FFT_N/4) * sizeof(q15_t));
        dma_buff_idx ^= FFT_N;

        dac_send_dma(&dac_dma_buf, 2*(FFT_N + FFT_N/4));

        data += 6;
        len -= 6;
    }
}