/**
 * Ma librairie student.h à partager
 * Header : déclarations uniquement, pas d'implémentations (encapsulation) ! 
 * Ce que verront les utilisateurs de ma librairie. 
 */

/**
 * Forward declaration : ma librairie manipule cette structure de données
 */
struct Student;

/**
 * Instancie une struct Student
*/
struct Student* createStudent(double, const char*, const char*);

/**
 * Détruit une struct Student
*/
void destroyStudent(struct Student *);

//Imprime les détails d'un étudiant sur la sorties standard
void printStudent(struct Student *);