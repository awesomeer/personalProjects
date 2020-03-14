#include "Complex.hpp"

/* Constructers*/
template <typename T>
Complex<T>::Complex(){
	real = 0;
	imag = 0;
}

template <typename T>
Complex<T>::Complex(T real, T imag){
	this->real = real;
	this->imag = imag;
}	

template <typename T>
Complex<T>::Complex(const Complex<T> &copy){
	this->real = copy.real;
	this->imag = copy.imag;
}

/* Public functions */
template <typename T>
double Complex<T>::magnitude(){
	return sqrt(real*real + imag*imag);
}

template <typename T>
Complex<T> Complex<T>::conjugate(){
	return Complex(this->real, this->imag * -1);
}

/* Operator overloads */
template <typename T>
Complex<T> Complex<T>::operator + (Complex<T> const &argu){
	return Complex(this->real + argu.real, this->imag + argu.imag);
}

template <typename T>
Complex<T> Complex<T>::operator - (Complex<T> const &argu){
	return Complex(this->real - argu.real, this->imag - argu.imag);
}

template <typename T>
Complex<T> Complex<T>::operator * (Complex<T> const &argu){
	return Complex((this->real * argu.real) - (this->imag * argu.imag), (this->real * argu.imag) + (this->imag * argu.real));
}

template <typename T>
bool Complex<T>::operator == (const Complex<T> &argu){
	return this->real == argu.real && this->imag == argu.imag;
}