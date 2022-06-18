%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>

  typedef struct SyntaxTree
  {
    char* content; 
    int numchild;
    struct SyntaxTree **left;
    struct SyntaxTree **right;
  } SyntaxTree;


  void yyerror();
  int yylex();
  
  void printTree();
  SyntaxTree* newNode(char* character);
  void addChild(char* stringa1, char* stringa2, SyntaxTree *node, SyntaxTree *left, SyntaxTree *right);
  
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
//%type <tree> E T F

%%
line: E'\n'     {printTree();} 
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
    node->left = NULL;
    node->right = NULL;
    return node;
}

void addChild(char* stringa1, char* stringa2, SyntaxTree *node, SyntaxTree *left, SyntaxTree *right)
{
    SyntaxTree *nodeChildleft;
    nodeChildleft = newNode(stringa1);
    
    SyntaxTree *nodeChildright;
    nodeChildright = newNode(stringa2);
    
    node -> left = (SyntaxTree **) realloc(node -> left, sizeof(SyntaxTree*)*(node -> numchild + 1));
    node -> left[node -> numchild] = nodeChildleft;
    
    node -> right = (SyntaxTree **) realloc(node -> right, sizeof(SyntaxTree*)*(node -> numchild + 1));
    node -> right[node -> numchild] = nodeChildright;
    
    node -> numchild++;
}


void printTree() {
 //SyntaxTree* expr
  int counter = 0;
  SyntaxTree* node = newNode("mammt'");
  printf("%s",node->content);
  exit(0);
}

