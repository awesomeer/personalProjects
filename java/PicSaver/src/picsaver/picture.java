/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package picsaver;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import javax.imageio.ImageIO;
import javax.swing.ImageIcon;

/**
 *
 * @author mithilesh
 */
public class picture {
    
    public static  int HEIGHT;
    public static  int WIDTH;
    private String name, format;
    private File file;
    private ImageIcon icon;
    private int H,W;
    
    picture(){
        name = format = "";
        file = null;
        icon = null;
    }
    
    picture(File read){
        file = read;
        read();
    }
    
    picture(String filePath){
        file = new File(filePath);
        read();
    }
    
    private void read(){
        try{
            icon = new ImageIcon(ImageIO.read(file));
            H = icon.getIconHeight();
            W = icon.getIconWidth();
            
            name = file.getName().substring(0, file.getName().lastIndexOf("."));
            format = file.getName().substring(name.length()+1);
            
            icon = new ImageIcon(ImageIO.read(file).getScaledInstance(WIDTH, HEIGHT, Image.SCALE_SMOOTH));
        }catch(IOException e){
            System.out.println("Error in read() picture class ");
        }
    }
    
    //Get methods
    public String getName(){
        return name;
    }
    public String getFormat(){
        return format;
    }
    public File getFile(){
        return file;
    }
    public ImageIcon getIcon(){
        return icon;
    }
    public int getH(){
        return H;
    }
    public int getW(){
        return W;
    }
    
    public String getRes(){
        return W+"x"+H;
    }
}
