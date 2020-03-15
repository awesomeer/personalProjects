/* Class for complex numbers */
#ifndef _COMPLEX_HPP_
#define _COMPLEX_HPP_

#include <string>
#include <cmath>

template <typename T>
class Complex{
	private:
		T real;
		T imag;

	public:
		Complex();
		Complex(T real, T imag);
		Complex(const Complex<T> &copy);
		
		double magnitude();
		Complex<T> conjugate();

		Complex<T> operator + (const Complex<T> &argu);
		Complex<T> operator - (const Complex<T> &argu);
		Complex<T> operator * (const Complex<T> &argu);
		//Complex<T> operator / (Complex<T> const &argu);
		
		bool operator == (const Complex<T> &argu);

		std::ostream& operator << (std::ostream& out){
			out << this->real << " " << this->imag;
			return out; 
		}
		
};

#endif