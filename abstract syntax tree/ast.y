%{
  #include <stdio.h>

  void yyerror();
  int yylex();

  typedef struct SyntaxTree
  {
    char* content; 
    int numchild;
    struct SyntaxTree **child;
  } SyntaxTree;
%}


%define parse.error verbose


/*
union mi permette dato in input stabilire il tipo, 
posso ricevere un int o una string in questo caso
*/
%union{
    char *stringa;
    struct SyntaxTree *tree;
}

%token <stringa> NUMBER
%token <stringa> OPERATOR

%type <tree> E T F

%%

E: E '+'T
  |E '-'T
  |T

T: T' 'OPERATOR F
  |F

F: NUMBER
  |'-'F
  |'+'F
  |'('E')'

%%

void yyerror(char const *s){
  fprintf(stderr,"%s\n",s);
}

void main(){
  yyparse();
}

void addNode(struct SyntaxTree *father, ) {
  struct SyntaxTree *node = (struct SyntaxTree*) malloc(sizeof(struct SyntaxTree));
  struct SyntaxTree *children = (struct SyntaxTree *) malloc(sizeof(struct SyntaxTree) * 2)
  node-> 
}





