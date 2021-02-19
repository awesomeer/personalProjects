#include "OS.hpp"

void OS::inc(){
    this->threads++;
    OS::a.inc();
}