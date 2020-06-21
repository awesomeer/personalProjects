#include <cmath>
#include <iostream>
#include <string>
#include <string.h>

template <class T>
class Complex{

    private:
        T real;
        T imag;

    public:
        Complex(){
            real = imag = 0;
        }

        Complex(T real, T imag){
            this->real = real;
            this->imag = imag;
        }

        Complex(const Complex<T> &copy){
            this->real = copy.real;
            this->imag = copy.imag;
        }

        T magnitude() const{
            return std::sqrt((real * real) - (imag * imag));
        }

        double phase() const{
            double angle = std::atan2(imag, real);

            return angle;
        }

        Complex<T> conjugate() const{
            return Complex<T> (this->real, -1 * this->imag);
        }
        
        T getReal() const{return real;}
        T getImag() const{return imag;}

        void setReal(T real){this->real = real;}
        void setImag(T imag){this->imag = imag;}

        std::string toString() const{
            std::string real = std::to_string(this->real);
            std::string imag = std::to_string(this->imag);

            return real + " i" + imag;
        }
        
        //Math op erations
        Complex<T> operator +(const Complex<T> &rhs){
            T real = this->real + rhs.real;
            T imag = this->imag + rhs.imag;
            
            return Complex<T>(real, imag);
        }

        Complex<T> operator -(const Complex<T> &rhs){
            T real = this->real - rhs.real;
            T imag = this->imag - rhs.imag;

            return Complex<T>(real, imag);
        }

        Complex<T> operator *(const Complex<T> &rhs){
            T real = (this->real * rhs.real) - (this->imag * rhs.imag);
            T imag = (this->imag * rhs.real) + (this->real * rhs.imag);

            return Complex<T>(real, imag);
        }

        Complex<T> operator /(const Complex<T> &bottom){
            Complex<T> conjugate = bottom.conjugate();
            conjugate = conjugate * bottom;
            T denom = conjugate.real;

            Complex<T> numerator = *this * bottom.conjugate();
            numerator.real /= denom;
            numerator.imag /= denom;

            return numerator;
        }

        //Relational operations
        bool operator == (const Complex<T> &rhs){
            return this->real == rhs.real && this->imag == rhs.imag;
        }

        bool operator != (const Complex<T> &rhs){
            return this->real != rhs.real || this->imag != rhs.imag;
        }

        bool operator > (const Complex<T> &rhs){
            return this->magnitude() > rhs.magnitude();
        }

        bool operator < (const Complex<T> &rhs){
            return this->magnitude() < rhs.magnitude();
        }

        bool operator >= (const Complex<T> &rhs){
            return  this->magnitude() >= rhs.magnitude();
        }

        bool operator <= (const Complex<T> &rhs){
            return this->magnitude() <= rhs.magnitude();
        }

        //assignment operators
        void operator = (const Complex<T> &rhs){
            this->real = rhs.real;
            this->imag = rhs.imag;
        }
};  