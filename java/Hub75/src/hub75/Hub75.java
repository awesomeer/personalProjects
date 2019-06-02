/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hub75;

import java.awt.Color;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import javax.imageio.ImageIO;
import static java.lang.Math.toIntExact;

/**
 *
 * @author mithilesh
 */
public class Hub75 {

    public static long r1 = 0,r2 = 0,g1 = 0,g2 = 0,b1 = 0,b2 = 0;
    public static int w =0;
    public static FileOutputStream out;
    
    public static void main(String args[]) throws IOException{
        BufferedImage pic = ImageIO.read(new File("C:\\Users\\mithilesh\\Desktop\\0.png"));
        out = new FileOutputStream(new File("C:\\Users\\mithilesh\\Desktop\\0.txt"));
        int h = pic.getHeight();
        w = pic.getWidth();
        out.write(w);
        out.write(h);
        System.out.println(w+"x"+h);
        int red[][] = new int[w][h];
        int green[][] = new int[w][h];
        int blue[][] = new int[w][h];
        for (int i = 0; i < w; i++) {
            for (int j = 0; j < h; j++) {
                Color color = new Color(pic.getRGB(i, j));
                red[i][j] = color.getRed();
                green[i][j] = color.getGreen();
                blue[i][j] = color.getBlue();
            }
        }
        int row = h/2;
        for (int n = 0; n < 8; n++) { //Traverse through all the bits
            for (int j = 0; j < row; j++) {// compute shift data for each row pair row = image height / 2 image height must be a power of 2
                r1=r2=g1=g2=b1=b2=0;
                for (int i = 0; i < w; i++) {//compute shift for each pixel w = image width; width must be either 32 or 64
                    r1 = r1 << 1;
                    r2 = r2 << 1;
                    g1 = g1 << 1;
                    g2 = g2 << 1;
                    b1 = b1 << 1;
                    b2 = b2 << 1;
                    if((red[i][j] & (1 << n)) == (1 << n)){ //check the bit n for each pixel and shift left
                        r1 = r1 | 1;
                    }
                    if((red[i][j+row] & (1 << n)) == (1 << n)){
                        r2 = r2 | 1;
                    }
                    if((green[i][j] & (1 << n)) == (1 << n)){
                        g1 = g1 | 1;
                    }
                    if((green[i][j+row] & (1 << n)) == (1 << n)){
                        g2 = g2 | 1;
                    }
                    if((blue[i][j] & (1 << n)) == (1 << n)){
                        b1 = b1 | 1;
                    }
                    if((blue[i][j+row] & (1 << n)) == (1 << n)){
                        b2 = b2 | 1;
                    }
                }
                System.out.println("Pixel Bit: "+n+" Line Number: "+j);
                if(w == 32){
                    out32();
                }
                else {
                    out64();
                }
                System.out.println();
               
            }
        }
        out.close();
    }
    
    public static void out32() throws IOException{
        int ri1 = (int) (r1 & 0xffffffff);
        int ri2 = (int) (r2 & 0xffffffff);
        int gi1 = (int) (g1 & 0xffffffff);
        int gi2 = (int) (g2 & 0xffffffff);
        int bi1 = (int) (b1 & 0xffffffff);
        int bi2 = (int) (b2 & 0xffffffff);
        System.out.println(format32(Integer.toBinaryString(ri1),32)+" "+format32(Integer.toBinaryString(gi1),32)+" "+format32(Integer.toBinaryString(bi1),32));
        System.out.println(format32(Integer.toBinaryString(ri2),32)+" "+format32(Integer.toBinaryString(gi2),32)+" "+format32(Integer.toBinaryString(bi2),32));
        int out[] = {ri1, gi1, bi1, ri2, gi2, bi2};
        for (int i = 0; i < out.length; i++) {
            Hub75.out.write(out[i] >> 24);
            Hub75.out.write(out[i] >> 16);
            Hub75.out.write(out[i] >> 8);
            Hub75.out.write(out[i]);
        }
    }
    
    public static void out64() throws IOException{
        System.out.println(format32(Long.toBinaryString(r1),64)+" "+format32(Long.toBinaryString(g1),64)+" "+format32(Long.toBinaryString(b1),64));
        System.out.println(format32(Long.toBinaryString(r2),64)+" "+format32(Long.toBinaryString(g2),64)+" "+format32(Long.toBinaryString(b2),64));
        long out[] = {r1,g1,b1,r2,g2,b2};
        for (int i = 0; i < out.length; i++) {
            byte write[] = new byte[8];
            for (int j = 7; j >= 0; j--) {
                write[j] = (byte) (out[i] & 0xff);
                out[i] >>= 8;
            }
            Hub75.out.write(write);
        }
    }
    public static String format32(String out, int len){
        String format = "0000000000000000000000000000000000000000000000000000000000000000";
        format = format.substring(0,len-out.length())+out;
        return format;
    }
    
}
