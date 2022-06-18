%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include <stdbool.h>

  typedef struct SyntaxTree
  {
    char* content; 
    int numchild;
    struct SyntaxTree *left;
    struct SyntaxTree *right;
  } SyntaxTree;


  void yyerror();
  int yylex();
  
  void printTree();
  SyntaxTree* newNode(char* character);
  void addChild(SyntaxTree *node, SyntaxTree *left, SyntaxTree *right);
  char* getPointer(int character, bool parethesis);
%}


%define parse.error verbose


/*
union mi permette dato in input stabilire il tipo, 
posso ricevere una string in questo caso
*/
%union{
    char *stringa;
    struct SyntaxTree *tree;
}

%token <stringa> NUMBER
%start line
%type <tree> E T F

%%
line: E'\n' {printTree($1, 0);printf("\n");exit(0);} 
    ;

E: E'+'T    {$$=newNode(getPointer('+', false));addChild($$,$1,$3);}
  |E'-'T    {$$=newNode(getPointer('-', false));addChild($$,$1,$3);}
  |T        {$$=$1;}
  ;  


T: T'*'F    {$$=newNode(getPointer('*', false));addChild($$,$1,$3);}
  |T'/'F    {$$=newNode(getPointer('/', false));addChild($$,$1,$3);}
  |T'%'F    {$$=newNode(getPointer('%', false));addChild($$,$1,$3);}
  |F        {$$=$1;}
  ;   

F: NUMBER   {$$=newNode($1);} 
  |'('E')'  {$$=$2;}
  | '-'F    {$$=newNode(getPointer('-', true));addChild($$,$2,NULL);}
  | '+'F    {$$=newNode(getPointer('+', true));addChild($$,$2,NULL);}
  ;

%%

void yyerror(char const *s){
  fprintf(stderr,"%s\n",s);
}

void main(){
  yyparse();
}

char* getPointer(int character, bool parethesis) {
  if (parethesis) {
    char* content = calloc(4, sizeof(char));
    content[0] = '(';
    content[1] = (char)character;
    content[2] = ')';
    return content;
  } else {
    char* content = calloc(2, sizeof(char));
    content[0] = (char)character;
    return content;
  }
}

SyntaxTree* newNode(char* stringa) {
    SyntaxTree *node = (SyntaxTree*) malloc(sizeof(SyntaxTree));
    node -> content = strcpy((char *)malloc(strlen(stringa)+1),stringa);
    node -> numchild = 0;
    node->left = NULL;
    node->right = NULL;
    return node;
}

void addChild(SyntaxTree *node, SyntaxTree *left, SyntaxTree *right)
{
    node -> left = left;
    node -> right = right;
    
    node -> numchild++;
}


void printTree(SyntaxTree* node, int indent) {
  for (int i=0;i<indent;i++)
    printf("  ");
  
  printf("%s", node->content);
  if (node->left != NULL) {
   printf("\n");
   printTree(node->left, indent+1);
  }
  if (node->right != NULL) {
   printf("\n");
   printTree(node->right, indent+1);
  }
}

