%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <malloc.h>
  #include <string.h>

  void yyerror();
  int yylex();
  int* getRelativeCoord(char*, int);
  int* sumCoord (int* coord1, int* coord2);
  void checkCoord(int* coordinates);
%}
%union{
    int number;
    char *string;
    int* coord;
}

/*
  TODO: remove debug printf
*/
// %start expressions
%define parse.error verbose
%token <number> NUMBER
%token <string> DIRECTION
%type <coord> expressions exp all

 %%
  all: expressions'\n' {checkCoord($$);}

  expressions: expressions exp{$$=sumCoord($1,$2);}
             | exp {$$=$1;};

  exp: DIRECTION NUMBER {$$=getRelativeCoord($1, $2);}
 %%

void yyerror(char const *s){
  fprintf(stderr,"%s\n",s);
}

void main(){
  yyparse();
}

int* getRelativeCoord(char* direction, int steps){
  int* result = (int*) calloc(2, sizeof(int));


  if (strcmp(direction, "UP") == 0) {
    //printf("UP");
    result[1] = result[1] + steps;
    return result;
  } 
  else if (strcmp(direction, "DOWN") == 0) {
    //printf("DOWN");
    result[1] = result[1] - steps;
    return result;
  }
  else if (strcmp(direction, "RIGHT") == 0) {
    //printf("RIGHT");
    result[0] = result[0] + steps;
    return result;
  }
  else if (strcmp(direction, "LEFT") == 0) {
    //printf("LEFT");
    result[0] = result[0] - steps;
    return result;
  }
  else {
    yyerror("Invalid direction");
    exit(1);
  }
}

int* sumCoord (int* coord1, int* coord2) {
    //printf("coord1(%d, %d)\n", coord1[0], coord1[1]);
    //printf("coord2(%d, %d)\n", coord2[0], coord2[1]);
    int* result = (int*) calloc(2, sizeof(int));
    result[0] = coord1[0]+coord2[0];
    result[1] = coord1[1]+coord2[1];
    //printf("result(%d, %d)\n", result[0], result[1]);
    return result;
}

void checkCoord(int* coordinates) {
  printf("\nSTARTING POINT: (0, 0)\n");
  printf("GOAL POINT: (5, 6)\n");
  printf("YOU ENDED UP IN: (%d, %d)\n", coordinates[0], coordinates[1]);


  if (coordinates[0] == 5 && coordinates[1] == 6) {
    printf("CONGRATS! YOU REACHED THE GOAL!");
  } else {
    printf("UNFORTUNATELY YOU DIDN'T REACHED THE GOAL");
  }
  
  exit(0);
}