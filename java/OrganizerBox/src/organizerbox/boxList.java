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
public class boxList {
    private ArrayList<box> list;
    
    boxList(){
        list = new ArrayList<box>();
    }
    
    
    public ArrayList<item> getItemsWithStrType(String str, item.Type type){
        ArrayList<item> re = new ArrayList<item>();
        for (box test : list) {
            ArrayList<item> append = test.getItemsWithStrType(str, type);
            for (item object : append) {
                re.add(object);
            }
        }
        
        return re;
    }
    /*
    true - box added
    false - box wasn't added
    */
    public boolean addBox(box add){
        if(!isBoxInList(add)){
            list.add(add);
            return true;
        }
        return false;
    }
    
    /*
    true - box was removed
    false - box wasn't removed or found
    */
    public boolean removeBox(box remove){
        for (int i = 0; i < list.size(); i++) {
            if(remove.equals(list.get(i))){
                list.remove(i);
                return true;
            }
        }
        return false;
    }
    
    /*
    true - box is in the list
    false - box was not found
    */
    public boolean isBoxInList(box compare){
        for (box object : list) {
            if(object.equals(compare))
                return true;
        }
        return false;
    }
    
    public boolean isItemInList(item compare){
        for (box object : list) {
            if(object.isItemInBox(compare))
                return true;
        }
        return false;
    }
    
    
    public ArrayList<box> getList(){
        return list;
    }
    public void setList(ArrayList<box> set){
        list = set;
    }
}
