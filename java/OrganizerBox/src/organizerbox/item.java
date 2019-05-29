/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package organizerbox;

/**
 *
 * @author mithilesh
 */
public class item {
    
    private String name;
    private String desc;
    private int quantity;
    
    item(){
        name = desc = "INVALID";
        quantity = -1;
    }
    
    item(String name, String desc, int quan){
        this.name = name;
        this.desc = desc;
        this.quantity = quan;
    }
    
    
    public boolean isStrInName(String in){
        return name.contains(in);
    }
    
    public boolean isStrInDesc(String in){
        return name.contains(in);
    }
    
    //GETTERS SETTERS
    public String getName(){
        return name;
    }
    public String getDesc(){
        return desc;
    }
    public int getQuantity(){
        return quantity;
    }
    
    public void setName(String set){
        name = set;
    }
    public void setDesc(String set){
        desc = set;
    }
    public void setQuantity(int set){
        quantity = set;
    }
    
    public boolean equals(item check){
        return (name.toLowerCase().equals(check.getName().toLowerCase())) && (desc.toLowerCase().equals(check.getDesc().toLowerCase()));
    }
}
