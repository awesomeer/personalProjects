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
    
    public enum Type{
        CABLE, MICROCONTROLLER, LOGIC, MATERIAL, COMPONENT, MISC
    }
    
    private String name;
    private String desc;
    private int quantity;
    private box location;
    private Type type;
    
    item(){
        name = desc = "INVALID";
        quantity = -1;
        location = null;
        type = null;
    }
    
    item(String name, String desc, int quan, box location, Type type){
        this.name = name;
        this.desc = desc;
        this.quantity = quan;
        this.location = location;
        this.type = type;
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
    public box getLocation(){
        return location;
    }
    public Type getType(){
        return type;
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
    public void setLocation(box set){
        location = set;
    }
    public void setType(Type set){
        type = set;
    }
    
    public boolean equals(item check){
        return (name.toLowerCase().equals(check.getName().toLowerCase())) 
            && (desc.toLowerCase().equals(check.getDesc().toLowerCase()));
    }
}
