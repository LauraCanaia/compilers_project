%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <malloc.h>
  #include <string.h>

  void yyerror();
  int yylex();
  int* getRelativeCoord(char*, int);
  int* sumCoord (int* coord1, int* coord2);
%}
%union{
    int number;
    char *string;
    int* coord;
}

%start expressions
%define parse.error verbose
%token <number> NUMBER
%token <string> DIRECTION
%type <coord> expressions exp

 %%
  expressions:  expressions exp {$$=sumCoord($1,$2);}
              | exp {$$=$1;printf("(%d, %d)", $$[0], $$[1]);};

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
    printf("UP");
    result[1] = result[1] + steps;
    return result;
  } 
  else if (strcmp(direction, "DOWN") == 0) {
    printf("DOWN");
    result[1] = result[1] - steps;
    return result;
  }
  else if (strcmp(direction, "RIGHT") == 0) {
    printf("RIGHT");
    result[0] = result[0] + steps;
    return result;
  }
  else if (strcmp(direction, "LEFT") == 0) {
    printf("LEFT");
    result[0] = result[0] - steps;
    return result;
  }
  else {
    yyerror("Invalid direction");
    exit(1);
  }
}

int* sumCoord (int* coord1, int* coord2) {
    printf("coord1(%d, %d)\n", coord1[0], coord1[1]);
    printf("coord2(%d, %d)\n", coord2[0], coord2[1]);
    int* result = (int*) calloc(2, sizeof(int));
    result[0] = coord1[0]+coord2[0];
    result[1] = coord1[1]+coord2[1];
    printf("result(%d, %d)\n", result[0], result[1]);
    return result;
}
