#include<stdio.h>
#include<stdlib.h>
#include<string.h>

/* Códigos de operación */
// AND
#define AND "000"
// OR
#define OR "001"
// Adición
#define ADD "010"
// Sustracción
#define SUB "011"
// Igualdad
#define EQ "100"
// Menor que
#define MQ "101"
// TRUE
#define TRUE "11111111111111111111111111111111"
//FALSE
#define FALSE "00000000000000000000000000000000" 

void verificaTamano(char* op, int tamano);
char* alu(char* opA, char* opB, char* op);

/* Tipo de dato 'Operacion'. Es un apuntador a una función que recibe dos cadenas de bits y devuelve una cadena de bits */
typedef char* (*Operacion)(char*, char*);
char* and(char* opA, char* opB);
char* or(char* opA, char* opB);
char* add(char* opA, char* opB);
char* sub(char* opA, char* opB);
char* eq(char* opA, char* opB);
char* mq(char* opA, char* opB);

/**
 * Simulador de una ALU de 32 bits.
 * @param argc Número de argumentos
 * @param argv Argumentos de la línea de comandos
 */
int main(int argc, char* argv[]) {
    char* opA =(char*) malloc(33);
    char* opB = (char*) malloc(33);
    char* op = (char*) malloc(3);
    if (argc == 4) {
        op = argv[1];
        opA = argv[2];
        opB = argv[3];
    } else {
        printf("Error: número de argumentos incorrecto\n");
        printf("Uso: ./practica4 <operación> <operandoA> <operandoB>\n");
        exit(1);

    }
    printf("%s\n", alu(opA, opB, op));
    return 0;
}

/**
 * Verifica que la cadena op tenga el tamaño especificado
 */
void verificaTamano(char* op, int tamano) {
    if (strlen(op) != tamano) {
        printf("Error: el tamaño de la cadena debe ser de %d bits\n", tamano);
        exit(1);
    }
}

/**
 * Realiza la operación especificada en op entre los operandos opA y opB
 * @param opA Cadena de bits que representa el operando A
 * @param opB Cadena de bits que representa el operando B
 * @param op Cadena de bits que representa la operación a realizar
 */
char* alu(char* opA, char* opB, char* op) {
    // Verificamos que las operaciones y los operandos sean consistentes con las reglas de tamano
    verificaTamano(opA, 32);
    verificaTamano(opB, 32);
    verificaTamano(op, 3);

    // Definimos la operación a realizar según el código de operación
    Operacion operacion;
    //printf("--------- Operación: ");
    if (strcmp(op, AND) == 0) {
        // printf("AND\n");
        operacion = and;
    } else if (strcmp(op, OR) == 0) {
        // printf("OR\n");
        operacion = or;
    } else if (strcmp(op, ADD) == 0) {
        // printf("ADD\n");
        operacion = add;
    } else if (strcmp(op, SUB) == 0) {
        // printf("SUB\n");
        operacion = sub;
    } else if (strcmp(op, EQ) == 0) {
        // printf("EQ\n");
        operacion = eq;
    } else if (strcmp(op, MQ) == 0) {
        // printf("MQ\n");
        operacion = mq;
    } else {
        printf("Error: operación no soportada\n");
        exit(1);
    }
    // printf("--------- Resultado: ");
    return operacion(opA, opB);
}

/**
 * Simula la operación AND entre dos cadenas de bits
 * @param opA Cadena de bits que representa el operando A
 * @param opB Cadena de bits que representa el operando B
 * @return AND entre A y B
 */
char* and(char* opA, char* opB) {
    char* resultado = (char*) malloc(33);
    for (int i = 0; i < 32; i++) {
        if (opA[i] == '1' && opB[i] == '1') {
            resultado[i] = '1';
        } else {
            resultado[i] = '0';
        }
    }
    resultado[32] = '\0';
    return resultado;
}

/**
 * Simula la operación OR entre dos cadenas de bits
 * @param opA Cadena de bits que representa el operando A
 * @param opB Cadena de bits que representa el operando B
 * @return OR entre A y B
 */
char* or(char* opA, char* opB) {
    char* resultado = (char*) malloc(33);
    for (int i = 0; i < 32; i++) {
        if (opA[i] == '1' || opB[i] == '1') {
            resultado[i] = '1';
        } else {
            resultado[i] = '0';
        }
    }
    resultado[32] = '\0';
    return resultado;
}

/** 
 * Suma dos cadenas de bits.
 * Si el resultado es mayor a 32 bits, se trunca el bit más significativo
 * @param opA Cadena de bits que representa el operando A
 * @param opB Cadena de bits que representa el operando B
 * @return Suma de A más B
 */
char* add(char* opA, char* opB) {
    char* resultado = (char*) malloc(33);
    int acarreo = 0;
    for (int i = 31; i >= 0; i--) {
        // Nota: '0' es 48 y '1' es 49 en la tabla ASCII
        int suma = (opA[i] - '0') + (opB[i] - '0') + acarreo;
        resultado[i] = suma % 2 + '0';
        acarreo = suma >> 1;
    }
    resultado[32] = '\0';
    return resultado;
}

/**
 * Resta dos cadenas de bits.
 * Si el sustraendo (B) es mayor que el minuendo (A), el resultado se devuelve en complemento a 2.
 * @param opA Cadena de bits que representa el operando A
 * @param opB Cadena de bits que representa el operando B
 * @return Resta de A menos B
 */
char* sub(char* opA, char* opB) {
    char* opB_copia = (char*) malloc(33);
    char* resultado = (char*) malloc(33);
    strcpy(opB_copia, opB);

    int banderaYaPasoUnUno = 0;
    for (int i = 31; i >= 0; i--) {
        // Volteamos todos desde el primer 1
        if (banderaYaPasoUnUno == 1) {
           opB_copia[i] = (opB[i] == '0') ? '1' : '0';
        } else if (opB[i] == '1') {
            banderaYaPasoUnUno = 1;
        }
    }
    resultado = add(opA, opB_copia);
    resultado[32] = '\0';
    return resultado;
}

/**
 * Compara dos cadenas de bits para determinar si son iguales
 * @param opA Cadena de bits que representa el operando A
 * @param opB Cadena de bits que representa el operando B
 * @return TRUE si A es igual a B, FALSE en otro caso
 */
char* eq(char* opA, char* opB) {
    for (int i = 0; i < 32; i++) {
        if (opA[i] != opB[i]) {
            return FALSE;
        } 
    }
    return TRUE;
}

/**
 * Compara dos cadenas de bits para determinar si A es menor estricto que B
 * @param opA Cadena de bits que representa el operando A
 * @param opB Cadena de bits que representa el operando B
 * @return TRUE si A es menor que B, FALSE en otro caso
 */
char* mq(char* opA, char* opB) {
    char* resultado = (char*) malloc(33);
    if (eq (opA, opB) == TRUE) {
        return FALSE;
    }
    for (int i = 0; i < 32; i++) {
        if (opA[i] > opB[i]) {
            return FALSE;
        }
    }
    return TRUE;
}


