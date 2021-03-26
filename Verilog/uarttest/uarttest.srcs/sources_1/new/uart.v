`timescale 1ns / 1ps


module top
(
    input clk,
    
    //TX
    input start_tx,
    output tx_ready_led,
    input [7:0] sw,
    output usb_tx,
    
    //RX
    output [7:0] io_led,
    output rx_data_ready,
    input usb_rx
);

    
    
    uart_tx tx(clk, start_tx, tx_ready_led, sw, usb_tx);
    
    uart_rx rx(clk, rx_data_ready, io_led, usb_rx);

endmodule

module uart_rx
(
    input clk,
    output reg data_ready,
    output reg [7:0] data,
    input rx
);
    
    parameter CLK = 100000000;
    parameter BAUD = 115200;
    parameter RATE = ((CLK)/(2*BAUD)) - 1;
    
// UART CLK Generation
    reg uartClk;
    reg [31:0] counter;
    initial begin
        uartClk <= 1'b0;
        counter <= 32'd0;
    end
    
    always @(posedge clk) begin
        if(counter == RATE) begin
            uartClk <= ~uartClk;
            counter <= 0;
        end
        else counter <= counter + 1;
    end
//END UART CLK Generation

    parameter [3:0] RX_IDLE = 4'd0,
                    RX_LOOP = 4'd1,
                    RX_STOP = 4'd2;
                    
                    
    reg [3:0] state, n_state;
    reg [7:0] dataCount, n_dataCount;
    reg [7:0] n_data;
    reg n_data_ready;
    initial begin
        state <= 4'd0;
        n_state <= 4'd0;
        
        dataCount <= 8'd0;
        n_dataCount <= 8'd0;
        
        data <= 8'd0;
        n_data <= 8'd0;
        
        data_ready <= 1'b0;
        n_data_ready <= 1'b0;
    end
    
    
    always @(*) begin
        case(state)
        
            RX_IDLE: begin

                n_dataCount <= 8'd0;
                n_data_ready <= 1'b0;
                
                if(~rx) begin
                    n_state <= RX_LOOP;
                    n_data <= {rx, data[7:1]};
                end
                else begin
                    n_state <= RX_IDLE;
                    n_data <= data;
                end
                
            end
            RX_LOOP: begin
                n_data <= {rx, data[7:1]};
                n_data_ready = 1'b0;
                
                if(dataCount == 8'd7) begin
                    n_state <= RX_STOP;
                    n_dataCount <= 8'd0;
                end
                else begin
                    n_state <= RX_LOOP;
                    n_dataCount <= dataCount + 1;
                end

            end
            RX_STOP: begin
                n_state <= RX_IDLE;
                n_data <= data;
                n_dataCount <= 8'd0;
                n_data_ready <= 1'b1;
            end
            
        endcase
    end
    
    always @(posedge uartClk) begin
        state <= n_state;
        data <= n_data;
        dataCount <= n_dataCount;
        data_ready <= n_data_ready;
    end
    

endmodule


module uart_tx
(   
    input clk,
    input start,
    output ready,
    input [7:0] data,
    output tx
);

    parameter CLK = 100000000;
    parameter BAUD = 115200;
    parameter RATE = ((CLK)/(2*BAUD)) - 1;

// UART CLK Generation
    reg uartClk;
    reg [31:0] counter;
    initial begin
        uartClk <= 1'b0;
        counter <= 32'd0;
    end
    
    always @(posedge clk) begin
        if(counter == RATE) begin
            uartClk <= ~uartClk;
            counter <= 0;
        end
        else counter <= counter + 1;
    end
//END UART CLK Generation
    
    parameter [3:0] TX_IDLE = 4'h0,
                    TX_START = 4'h1,
                    TX_LOOP = 4'h2,
                    TX_STOP = 4'h3;
    
    reg [3:0] state, n_state;
    
    reg [3:0] dataCount, n_dataCount;
    
    reg [9:0] tx_shift, n_tx_shift;
    
    initial begin
        state <= TX_IDLE;
        n_state <= TX_IDLE;
        
        dataCount <= 0;
        n_dataCount <= 0;
        
        tx_shift <= 10'b0000000001;
        n_tx_shift <= 10'b0000000001;
    end
    
    assign tx = tx_shift[0];
    assign ready = state == TX_IDLE;
    
    always @(*) begin
        case(state)
            TX_IDLE: begin
                if(start) n_state <= TX_START;
                else n_state <= TX_IDLE;
                
                n_tx_shift <= tx_shift;
                n_dataCount <= dataCount;
            end
            TX_START: begin
                n_tx_shift <= {data, 2'b01};
                n_dataCount <= 4'h0;
                n_state <= TX_LOOP;
            end
            TX_LOOP: begin
                if(dataCount == 4'd10) begin
                    n_tx_shift <= tx_shift;
                    n_dataCount <= dataCount;
                    n_state <= TX_STOP;
                end
                else begin
                    n_tx_shift <= {1'b1, tx_shift[9:1]};
                    n_dataCount <= dataCount + 1;
                    n_state <= TX_LOOP;
                end
            end
            TX_STOP: begin
                if(start) n_state <= TX_STOP;
                else n_state <= TX_IDLE;
                
                n_tx_shift <= tx_shift;
                n_dataCount <= dataCount;
            end
            default begin
                n_state <= state;
                n_tx_shift <= tx_shift;
                n_dataCount <= dataCount;
            end
        endcase
    end
    
    always @(posedge uartClk) begin
        state <= n_state;
        dataCount <= n_dataCount;
        tx_shift <= n_tx_shift;
    end
    
    
endmodule
