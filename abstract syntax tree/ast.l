%{
#include <stdio.h>
#include "y.tab.h"
int c;
%}

NUMBER 0|[1-9]+[0-9]*
OPERATORS [*/%]

%%
exit exit(0);
print {return PRINT;}
{NUMBER}   {yylval.stringa = strndup(yytext, yyleng); return NUMBER;}
{OPERATORS} {yylval.stringa = strndup(yytext, yyleng); return OPERATOR;}

[ \t\r]

\n     return '\n';
.      return yytext[0];
%%
