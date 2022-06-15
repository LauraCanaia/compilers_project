%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>

  typedef struct SyntaxTree
  {
    char* content; 
    int numchild;
    struct SyntaxTree **child;
  } SyntaxTree;


  void yyerror();
  int yylex();
  
  SyntaxTree* newNode(char* character);
  void addChild(char* stringa, SyntaxTree *node, SyntaxTree *child);
  
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
line: E'\n' 
    ;

E: E'+'T        
  |E'-'T 
  |T   
  ;  

T: T'*'F 
  |T'/'F 
  |T'%'F 
  |F  
  ;   

F: NUMBER       
  |'('E')'      
  ;

%%

void yyerror(char const *s){
  fprintf(stderr,"%s\n",s);
}

void main(){
  yyparse();
}

SyntaxTree* newNode(char* stringa) {
    SyntaxTree *node = (SyntaxTree*) malloc(sizeof(SyntaxTree));
    node -> content = strcpy((char *)malloc(strlen(stringa)+1),stringa);
    node -> numchild = 0;
    node->child = NULL;
    return node;
}

void addChild(char* stringa, SyntaxTree *node, SyntaxTree *child)
{
    SyntaxTree *nodeChild;
    nodeChild = newNode(stringa);
    
    nodeChild -> child = (SyntaxTree **) realloc(nodeChild -> child, sizeof(SyntaxTree*)*(nodeChild -> numchild + 1));
    nodeChild -> child[nodeChild -> numchild] = nodeChild;
    nodeChild -> numchild++;
}


void printTree(SyntaxTree* expr) {
  int counter = 0;
  printf("%s",expr->content);
}

