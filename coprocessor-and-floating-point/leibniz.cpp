#include <bits/stdc++.h>

using namespace std;

/**
 * Calcula el valor de pi con el metodo de Leibniz
 * @param m Entero que representa el numero de iteraciones que se haran en la serie
 * @return El valor de pi calculado
 */
double leibniz(int m) {
    // Declara una variable para almacenar el resultado
    double resultado = 0.0;
    // Loop con m iteraciones
    for (int i = 0; i < m; ++i) {
        // Calcula el numerador: 
        // Multiplica -1 tantas veces como el valor de la iteración
        double numerador = pow(-1, i);
        // Calcula el denominador: 
        // Multiplica el número de la iteración por 2, posteriormente se le suma 1
        double denominador = 2 * i + 1;
        // Divide el numerador entre el denominador
        double division = numerador / denominador;
        // Suma el resultado de la división al resultado total
        resultado += division;
    }
    // Multiplica el resultado por 4
    return resultado * 4;
}

/**
 * Ejercicio 01
 */
int main() {
    int m; // Declara una variable para almacenar el valor de m
    cout << "Pon el valor de m: "; // Pide al usuario el valor de m
    cin >> m; // Guarda el valor de m en la variable
    double pi = leibniz(m); // Calcula el valor de pi con el método de Leibniz
    cout << pi << endl; // Imprime el valor de pi
    return 0; // Termina el programa
}