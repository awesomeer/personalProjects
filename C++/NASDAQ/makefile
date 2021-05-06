stock: object/main.o object/Stock.o
	g++ -g -std=c++11 object/main.o object/Stock.o -o stock
object/main.o: src/main.cpp
	g++ -g -std=c++11 -c src/main.cpp -o object/main.o
object/Stock.o: src/Stock.cpp inc/Stock.hpp
	g++ -g -std=c++11 -c src/Stock.cpp -o object/Stock.o
