class OS{

    public:
    typedef struct awd{
        int x;
        void inc(){
            this->x++;
        }
    } awd_t;

    private:
        int threads;
        static awd_t a;

    public:
    class Semaphore{
        private:
            int lock;
        
        public:
            Semaphore(){
                lock = 1;
            }
            int getThreads(OS *os){
                return os->threads;
            }

    };

    public:
        OS(){
            threads = 0;
        }
        void inc();

};