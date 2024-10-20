#include<stdio.h>
#include<stdlib.h>
// #include<string.h>
#include<math.h>

// Bandera para la media aritmética
#define ARITMETICA 'A'
// Bandera para la media armónica
#define ARMONICA 'H'
// Bandera para la media geométrica
#define GEOMETRICA 'G'

// Modo de uso
#define USO "Uso: %s <tipo de media> <dato1> <dato2> ...\n"
// Error si el tipo de media no es reconocido
#define ERROR_MEDIA "Error: Tipo de media no reconocido\n"

float media_aritmetica(float datos[], int n);
float media_armonica(float datos[], int n);
float media_geometrica(float datos[], int n);
void llenaDatos(int n, char* argv[], float datos[]);

/**
 * Calcula la media aritmética de un conjunto de datos.
 * @param datos[] Conjunto de datos
 * @param n Número de datos
 * @return Media aritmética
 */
float media_aritmetica(float datos[], int n) {
  float suma = 0.0;
  for (int i = 0; i < n; i++) {
    suma += datos[i];
  }
  return suma / n;
}

/**
 * Calcula la media armónica de un conjunto de datos.
 * @param datos[] Conjunto de datos
 * @param n Número de datos
 * @return Media armónica
 */
float media_armonica(float datos[], int n) {
  float suma = 0.0;
  for (int i = 0; i < n; i++) {
    suma += 1 / datos[i];
  }
  return n / suma;
}

/**
 * Calcula la media geométrica de un conjunto de datos.
 * @param datos[] Conjunto de datos
 * @param n Número de datos
 * @return Media geométrica
 */
float media_geometrica(float datos[], int n) {
  float producto = 1.0;
  for (int i = 0; i < n; i++) {
    producto *= datos[i];
  }
  return pow(producto, 1.0 / n);
}

/**
 * Llena un arreglo de datos con los argumentos de la entrada.
 * @param n Número de datos
 * @param argv Argumentos de la entrada
 * @param datos[] Arreglo de datos
 */
void llenaDatos(int n, char* argv[], float datos[]) {
  for (int i = 0; i < n; i++) {
    datos[i] = atof(argv[i+2]);
  }
}

/**
 * Práctica 2: Introducción a C
 * @param argc Número de argumentos
 * @param argv Argumentos, con el orden:
 * - Nombre del programa, argv[0]
 * - Tipo de media, argv[1]
 * - Datos de la entrada, argv[2], argv[3], ...
 * @return 0 si no hay errores
 */
int main (int argc, char* argv[]) {
  // Verifica que haya al menos 3 argumentos
  if (argc < 3) {
    printf(USO, argv[0]);
    return 1;
  }
  // Índice donde comienzan los datos
  int n = argc - 2;
  // Conjunto de datos
  float datos[n];
  llenaDatos(n, argv, datos);
  switch (argv[1][0]) {
  case ARITMETICA:
    printf("Media aritmética: %.2f\n", media_aritmetica(datos, n));
    break;
  case ARMONICA:
    printf("Media armónica: %.2f\n", media_armonica(datos, n));
    break;
  case GEOMETRICA:
    printf("Media geométrica: %.2f\n", media_geometrica(datos, n));
    break;
  default:
    printf(ERROR_MEDIA);
    return 1;
  }
  
  return 0;
}
