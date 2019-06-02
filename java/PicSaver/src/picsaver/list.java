/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package picsaver;

import java.io.File;
import java.util.ArrayList;

/**
 *
 * @author mithilesh
 */
public class list {
    
    private ArrayList<picture> list;
    
    list(){
        list = new <picture>ArrayList();
    }
    
    public void add(File file){
        list.add(new picture(file));
    }
    public void add(picture pic){
        list.add(pic);
    }
    
    public void remove(String name){
        list.remove(find(name));
    }
    
    public picture get(int i){
        return list.get(i);
    }
    
    public picture getStart(){
        return list.get(0);
    }
    
    public picture getEnd(){
        return list.get(list.size()-1);
    }
    
    public int find(String name){
        for (int i = 0; i < list.size(); i++) {
            if(list.get(i).getName().equals(name)){
                return i;
            }
        }
        return -1;
    }
    
    public int size(){
        return list.size();
    }
    
    public ArrayList getList(){
        return list;
    }
}
