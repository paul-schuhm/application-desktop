#include<stdio.h>
#include"student.h"

int main(){
    printf("hello, world\n");
     // J'utilise la librairie mylib
    struct Student *john = createStudent(13, "John","Doe");
    struct Student *jane = createStudent(15, "Jane", "Doe");
    printStudent(john);

    //Libération de la mémoire
    destroyStudent(john);
    destroyStudent(jane);
    printf("Done\n");
    return 0;
}