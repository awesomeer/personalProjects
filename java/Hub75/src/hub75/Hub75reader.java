/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hub75;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

/**
 *
 * @author mithilesh
 */
public class Hub75reader {
    
    public static void main(String args[]) throws FileNotFoundException, IOException{
        FileInputStream in = new FileInputStream(new File("C:\\Users\\mithilesh\\Desktop\\0.txt"));
        System.out.println(Byte.toString((byte) in.read())+"x"+Byte.toString((byte) in.read()));
        for(int l = 0; l < 8; l++){
            for (int j = 0; j < 32; j++) {
                System.out.println("Pixel bit: "+l+" Line Number "+j);
                for (int i = 0; i < 6; i++) {
                    byte read[] = new byte[8];
                    in.read(read);
                    for (int h = 0; h < read.length; h++) {
                        System.out.print(format(read[h]));
                    }    
                    if(i ==2)
                        System.out.print("\n");
                    else System.out.print(" ");
                }
                System.out.println("\n");
            }
        }
    }
    public static String format(Byte in){
        String out = "";
        for (int i = 0; i < 8; i++) {
            if((in & (1 << i)) == (1 << i)){
                out = "1"+out;
            }
            else out = "0"+out;
        }
        return out;
    }
}
