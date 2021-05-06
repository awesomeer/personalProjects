#include <iostream>
#include <vector>
using namespace std;

template <class T>
class LinkedList{


	private:
	
		typedef struct node {
			T data;
			node * next;
		} node_t;

		node_t * head;
        int size;
        

	public:

		LinkedList(){
			head = nullptr;
			size = 0;
		}

		LinkedList(T * arr, unsigned int len){
			size = len;
			if(len >= 1){
				head = new node_t{*arr, nullptr};
			}
			else if(len == 0){
				head = nullptr;
				return;
			}
			
			node_t * temp = head;
			for(int i = 1; i < len; i++){
				node_t * add = new node_t{arr[i], nullptr};
				temp->next = add;
				temp = add;
			}

		}
        
        LinkedList(vector<T> arr){
            size = arr.size();
            if(size >= 1){
                head = new node_t{arr[0], nullptr};
            }
            else if(size == 0){
                head == nullptr;
                return;
            }
            
            node_t * temp = head;
            for(int i = 1; i < size; i++){
                node_t * add = new node_t{arr[i], nullptr};
                temp->next = add;
                temp = add;
            }
                
        }
        
        /*
            Modifiers
        */
        
        bool set(T prevData, T newData){
            
            node_t * curr = head;
            while(curr->data != prevData){
                curr = curr->next;
                if(curr == nullptr)
                    return false;
            }
            
            curr->data = newData;
            return true;
        }
        
        bool set(T data, unsigned int index){
        
            if(index >= size)
                return false;
                
            
            node_t * curr = head;
            for(int i = 0; i < index; i++)
                curr = curr->next;
            
            curr->data = data;
            return true;
        }
        
        /*
            Insertions and Deletions
        */
        
        bool insert(T data){
            
            node_t * add = new node_t{data, nullptr};
            if(add == nullptr)
                return false;
            node_t * temp = head;
            while(temp->next != nullptr){
                temp = temp->next;
            }
            
            temp->next = add;
            this->size++;
            return true;
        }
        
        bool deleteElement(T &data){
            
            node_t * temp = head;
            if(head->data == data){
                head = head->next;
                delete temp;
                return true;
            }
            
            while(temp->next != nullptr){
                if(temp->next->data == data){
                    node_t * remove = temp->next;
                    temp->next = remove->next;
                    delete remove;
                    return true;
                }
                temp = temp->next;
            }
            
            return false;
        }
        
        bool deleteIndex(unsigned int index){
            
            if(index >= size)
                return false;
                
            node * temp = head;
            if(index == 0){
                head = head->next;
                delete temp;
                return true;
            }
            
            for(int i = 1; i < index; i++){
                temp = temp->next;
            }
            
            node * remove = temp->next;
            temp->next = remove->next;
            
            delete remove;
        }
        
        
        void clear(){
            
            size = 0;
            
            if(head == nullptr)
                return;
                
            node_t * curr = head;
            node_t * prev = head;
            
            while(curr != nullptr){
                prev = curr;
                curr = curr->next;  
                delete prev;
            }

            head = nullptr;
        }
        
        /*
            Output as arrays
        */
        
        T * toArray(){
            T * arr = new T[size];
            node_t * curr = head;
            int index = 0;
            while(curr != nullptr){
                arr[index++] = curr->data;
                curr = curr->next;
            }
             
            return arr;          
        }
        
        
        vector<T> toVector(){
        	vector<T> arr(size);
        	node_t * curr = head;
        	while(curr != nullptr){
        	    arr.push_back(curr->data);
        	    curr = curr->next;
        	}
        	
        	return arr;
        }
        
        
        
        ~LinkedList(){
            this->clear();
        }
        
        
        T& operator[] (unsigned int index){
            node_t * temp = head;
            for(int i = 0; i < index; i++){
                temp = temp->next;
            }
            
            return temp->data;
        }
        
        friend ostream& operator<<(ostream &out, const LinkedList<T> &list){
            
            node_t * curr = list.head;
            while(curr->next != nullptr){
                out << curr->data << " ";
                curr = curr->next;
            }
            out << curr->data;
            
            return out;
        }
        
        /*
            Comparison operators
        */
        
        bool operator == (const LinkedList<T> &rhs){
            return this->size == rhs.size;
        }
        bool operator != (const LinkedList<T> &rhs){
            return this->size != rhs.size;
        }
        bool operator < (const LinkedList<T> &rhs){
            return this->size < rhs.size;
        }
        bool operator > (const LinkedList<T> &rhs){
            return this->size > rhs.size;
        }
        bool operator <= (const LinkedList<T> &rhs){
            return this->size <= rhs.size;
        }
        bool operator >= (const LinkedList<T> &rhs){
            return this->size >= rhs.size;
        }
};









