%{
  #include <stdio.h>
  #include <math.h>

  void yyerror();
  int memory = 0;
  int yylex();

%}
%union{
    int number;
    char *string;
}

%define parse.error verbose
%token <number> NUMBER
%token <string> DIRECTION
 
 %%
 
  lines: lines line|line;
  line: expr'\n'
  expr: DIRECTION NUMBER

 
 %%

 void yyerror(char const *s){
  fprintf(stderr,"%s\n",s);
}

void main(){
  yyparse();
 }
