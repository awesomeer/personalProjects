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
    
    final static int ALL = -1;
    final static int CABLE = 0;
    final static int MICROCONTROLLER = 1;
    final static int LOGIC = 2;
    final static int MATERIAL = 3;
    final static int COMPONENT = 4;
    final static int POWER = 5;
    final static int MISC = 6;
    
    private String name;
    private String desc;
    private int quantity;
    private box location;
    private int type;
    
    item(){
        name = desc = "INVALID";
        quantity = 0;
        location = null;
        type = 5;
    }
    
    item(String name, String desc, int quan, box location, int type){
        this.name = name;
        this.desc = desc;
        this.quantity = quan;
        this.location = location;
        this.type = type;
    }
    
    
    public boolean isStrInName(String in){
        return name.toLowerCase().contains(in.toLowerCase());
    }
    
    public boolean isStrInDesc(String in){
        return desc.toLowerCase().contains(in.toLowerCase());
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
    public int getType(){
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
    public void setType(int set){
        type = set;
    }
    
    public boolean equals(item check){
        return (name.toLowerCase().equals(check.getName().toLowerCase())) 
            && (desc.toLowerCase().equals(check.getDesc().toLowerCase()));
    }
}
