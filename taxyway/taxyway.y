%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int yylex();
void yyerror();
int xa = 0, ya = 0;
int xb = 5, yb = 6;

void direction(char* direction, int steps);
void checkVictory();

%}

%define parse.error verbose
%start line

%union{
  int number;
  char *string;
}

%token <string> MOVEMENT
%token <number> DIGIT

%%

line : expr'\n'                {checkVictory();}
;

expr : command expr        
| command        
;

command : MOVEMENT DIGIT    {direction($1, $2);}
;

%%

void yyerror(char const *s){
  fprintf(stderr,"%s\n",s);
}

void main()
{
    yyparse();
}

void direction(char* direction, int steps)
{

    if(strcmp(direction, "UP") == 0)
        ya = ya + steps;
    else if(strcmp(direction, "DOWN") == 0)
        ya = ya - steps;
    else if(strcmp(direction, "RIGHT") == 0)
        xa = xa + steps;
    else if(strcmp(direction, "LEFT") == 0)
        xa = xa + steps;
    else
        printf("Unexpected error\n");

}

void checkVictory()
{

    printf("Arrival point: X: %d, Y: %d\n", xa, ya);
    printf("Goal : X: %d, Y: %d\n", xb, yb);
    
    if(xa == xb && ya == yb)
        printf("GREAT! You reached the goal!\n");
    else
    {
        printf("Sorry, you didn't reach the goal.\n");
        printf("To your sequence of movement you could have add the following steps to reach the goal:\n");
        if(ya > yb)
            printf("- DOWN %d\n", ya - yb);
        if(ya < yb)
            printf("- UP %d\n", yb - ya);
        if(xa > xb)
            printf("- LEFT %d\n", xa - xb);
        if(xa < xb)
            printf("- RIGHT %d\n", xb - xa);
    }
    exit(0);
}
