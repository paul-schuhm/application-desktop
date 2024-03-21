#include "student.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>


 /**
 * Détails d’implémentation de la structure Student
 */
struct Student
{
    char firstName[50];
    char lastName[50];
    double grade;
};

//Instancie une structure Student
struct Student* createStudent(double grade, const char* firstName, const char* lastName) {
    struct Student *student = (struct Student*)malloc(sizeof(struct Student));
    if (student != NULL) {
        student->grade = grade;
        strncpy(student->firstName, firstName, 49);
        student->firstName[49] = '\0';
        strncpy(student->lastName, lastName, 49);
        student->lastName[49] = '\0';
    }
    return student;
}

//Libérer la mémoire d'un student
void destroyStudent(struct Student *student)
{
    if (student != NULL)
    {
        free(student);
    }
}

//Imprime les détails d'un étudiant sur la sorties standard
void printStudent(struct Student* student){
    if (student != NULL)
    {
        printf("Student : %s %s. Grade : %f\n", student->firstName, student->lastName, student->grade);
    }
    return;
}

//Retourne le student avec la note la plus élevée
struct Student* compare(struct Student *a, struct Student *b)
{
    if(a->grade > b->grade)
        return a;
    return b;
}