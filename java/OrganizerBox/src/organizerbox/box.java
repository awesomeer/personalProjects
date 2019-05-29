/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package organizerbox;

import java.util.ArrayList;
/**
 *
 * @author mithilesh
 */
public class box {
    private ArrayList<item> list;
    private int x;
    private int y;
    
    box(){
        x = y = 0;
        list = null;
    }
    
    box(int x, int y){
        this.x = x;
        this.y = y;
        list = new <item>ArrayList();
    }
    
    /*
    true - added w/o error
    false - item already exists
    */
    public boolean addItem(item add){
        if(!itemInList(add)){
            list.add(add);
            return true;
        }
        return false;
    }
    
    /*
    true - item removed
    false - item was not found
    */
    public boolean removeItem(item remove){
        for (int i = 0; i < list.size(); i++) {
            if(remove.equals(list.get(i))){
                list.remove(i);
                return true;
            }
        }
        
        return false;
    }
    
    public boolean itemInList(item check){
        for (item object : list) {
            if(check.equals(object))
                return true;
        }
        
        return false;
    }
}
