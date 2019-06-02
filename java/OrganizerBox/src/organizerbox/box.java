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
    private ArrayList<item> items;
    private int x;
    private int y;
    
    box(){
        x = y = 0;
        items = null;
    }
    
    box(int x, int y){
        this.x = x;
        this.y = y;
        items = new ArrayList<item>();
    }
    
    /*
    create an arraylist of items that have the str in
    their name and desc
    */
    public ArrayList<item> getItemsWithStrType(String str, int type){
        ArrayList<item> re = new ArrayList<item>();
        for (item object : items) {
            if((object.isStrInDesc(str) || object.isStrInName(str) || str.compareTo("") == 0) 
            && (object.getType() == type || type == item.ALL))
                re.add(object);
        }
        
        if(!re.isEmpty())
            return re;
        else
            return null;
    }
    
    /*
    true - added w/o error
    false - item already exists or items is null
    */
    public boolean addItem(item add){
        if(items == null)
            return false;
        
        if(isItemInBox(add) == null){
            items.add(add);
            return true;
        }
        return false;
    }
    
    /*
    true - item removed
    false - item was not found or items is null
    */
    public boolean removeItem(item remove){
        if(items == null)
            return false;
        
        for (int i = 0; i < items.size(); i++) {
            if(remove.equals(items.get(i))){
                items.remove(i);
                return true;
            }
        }
        
        return false;
    }
    
    /*
    true - item in items
    false - item not found
    */
    public item isItemInBox(item check){
        for (item object : items) {
            if(check.equals(object))
                return object;
        }
        
        return null;
    }
    
    //GETTERS and SETTERS
    public int getX(){
        return x;
    }
    public int getY(){
        return y;
    }
    public ArrayList<item> getItems(){
        return items;
    }
    
    public void setX(int x){
        this.x = x;
    }
    public void setY(int y){
        this.y = y;
    }
    public void setItems(ArrayList<item> items){
        this.items = items;
    }
    
    public boolean equals(box compare){
        return this.x == compare.getX() && this.y == compare.getY();
    }
    
    @Override
    public String toString(){
        return "Box: " + y + ", " + x;
    }
}
