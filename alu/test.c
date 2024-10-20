// Comentar el main de practica4.c, de lo contrario no compilará
// Compilación de test: gcc practica4.c test.c -o test.out
// Ejecución de test: ./test.out

// NOTA: Manejamos las cadenas sin signo, a excepción de la resta que maneja el complemento a 2
#include <assert.h>
#include <stdio.h>
#include <string.h>

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

char* alu(char* opA, char* opB, char* op);
char* and(char* opA, char* opB);
char* and(char* opA, char* opB);
char* or(char* opA, char* opB);
char* add(char* opA, char* opB);
char* sub(char* opA, char* opB);
char* eq(char* opA, char* opB);
char* mq(char* opA, char* opB);

void test_and();
void test_or();
void test_add();
void test_sub();
void test_eq();
void test_mq();

int main() {
    test_and();
    test_or();
    test_add();
    test_sub();
    test_eq();
    test_mq();
    return 0;
}

void test_and() {
    assert(strcmp(and(TRUE, FALSE), FALSE) == 0);
    assert(strcmp(and(FALSE, TRUE), FALSE) == 0);
    assert(strcmp(and(TRUE, TRUE), TRUE) == 0);
    assert(strcmp(and(FALSE, FALSE), FALSE) == 0);
    assert(strcmp(and("11111111111111111111111111111111", "00000000000000000000000000000011"), "00000000000000000000000000000011") == 0);
    printf("Test and passed\n");
}

void test_or() {
    assert(strcmp(or(TRUE, FALSE), TRUE) == 0);
    assert(strcmp(or(FALSE, TRUE), TRUE) == 0);
    assert(strcmp(or(TRUE, TRUE), TRUE) == 0);
    assert(strcmp(or(FALSE, FALSE), FALSE) == 0);
    assert(strcmp(or("11111111111111111111111111111000", "00000000000000000000000000000111"), TRUE) == 0);
    printf("Test or passed\n");
}

void test_add() {
    assert(strcmp(add(TRUE, FALSE), TRUE) == 0);
    assert(strcmp(add(FALSE, TRUE), TRUE) == 0);
    assert(strcmp(add(FALSE, FALSE), FALSE) == 0);
    // NO maneja desbordamiento
    assert(strcmp(add(TRUE, TRUE), "11111111111111111111111111111110") == 0);
    // 7 + 1 = 8
    assert(strcmp(add("00000000000000000000000000000111", "00000000000000000000000000000001"), "00000000000000000000000000001000") == 0);
    printf("Test add passed\n");
}

void test_sub() {
    assert(strcmp(sub(TRUE, FALSE), TRUE) == 0);
    assert(strcmp(sub(TRUE, TRUE), FALSE) == 0);
    assert(strcmp(sub(FALSE, FALSE), FALSE) == 0);
    // No maneja el desbordamiento
    assert(strcmp(sub(FALSE, TRUE), "00000000000000000000000000000001") == 0);
    // 7 - 1 = 6
    assert(strcmp(sub("00000000000000000000000000000111", "00000000000000000000000000000001"), "00000000000000000000000000000110") == 0);
    // 6 - 8 = -2
    assert(strcmp(sub("00000000000000000000000000000110", "00000000000000000000000000001000"), "11111111111111111111111111111110") == 0);
    printf("Test sub passed\n");
}

void test_eq() {
    assert(strcmp(eq(TRUE, FALSE), FALSE) == 0);
    assert(strcmp(eq(TRUE, TRUE), TRUE) == 0);
    assert(strcmp(eq(FALSE, FALSE), TRUE) == 0);
    assert(strcmp(eq(FALSE, TRUE), FALSE) == 0);
    // 0 == 1 > false
    assert(strcmp(eq("00000000000000000000000000000000", "00000000000000000000000000000001"), FALSE) == 0);
    printf("Test eq passed\n");
}

void test_mq() {
    assert(strcmp(mq(TRUE, FALSE), FALSE) == 0);
    assert(strcmp(mq(TRUE, TRUE), FALSE) == 0);
    assert(strcmp(mq(FALSE, FALSE), FALSE) == 0);
    assert(strcmp(mq(FALSE, TRUE), TRUE) == 0);
    // 0 < 1 > true
    assert(strcmp(mq("00000000000000000000000000000000", "00000000000000000000000000000001"), TRUE) == 0);
    // 1 < 0 > false
    assert(strcmp(mq("00000000000000000000000000000001", "00000000000000000000000000000000"), FALSE) == 0);
    printf("Test mq passed\n");
}