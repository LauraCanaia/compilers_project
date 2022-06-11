%{
  #include <stdio.h>

  typedef struct SyntaxTree
  {
    char* content; 
    struct SyntaxTree **child;
  } SyntaxTree;


  void yyerror();
  int yylex();
  void printTree(SyntaxTree* expr);
  SyntaxTree* newNode(char* character, SyntaxTree* firstChild, SyntaxTree* secondChild);
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
%start line
%type <tree> E T F

%%
line: E'\n' {printTree($1);}

E: E'+'T {$$=newNode('+', $1, $3);}
  |E'-'T {$$=newNode('-', $1, $3);}
  |T     {$$=newNode($1->content, $1, (SyntaxTree *)NULL);}

T: T'*'F {$$=newNode('*', $1, $3);}
  |T'/'F {$$=newNode('/', $1, $3);}
  |T'%'F {$$=newNode('%', $1, $3);}
  |F     {$$=newNode($1->content, $1, (SyntaxTree *)NULL);}

F: NUMBER  {$$=newNode($1, (SyntaxTree *)NULL, (struct SyntaxTree *)NULL);}
  |'-'F    {$$=newNode('-', $2, (SyntaxTree *)NULL);}
  |'+'F    {$$=newNode('+', $2, (SyntaxTree *)NULL);}
  |'('E')' {$$=newNode($2->content, (SyntaxTree *)NULL, (SyntaxTree *)NULL);}

%%

void yyerror(char const *s){
  fprintf(stderr,"%s\n",s);
}

void main(){
  yyparse();
}

SyntaxTree* newNode(char* character, SyntaxTree* firstChild, SyntaxTree* secondChild) {
  SyntaxTree *node = (SyntaxTree*) malloc(sizeof(SyntaxTree));
  node->child = (SyntaxTree **) malloc(sizeof(SyntaxTree) * 2);
  node->content = character; 
  node->child[0] = firstChild;
  node->child[1] = secondChild;
}

void printTree(SyntaxTree* expr) {
  int counter = 0;
  printf("%s",expr->content);
}