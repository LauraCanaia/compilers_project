%{
#include <stdio.h>
#include "y.tab.h"
int c;
%}

NUMBER 0|[1-9]+[0-9]*

%%
{NUMBER}   {yylval.stringa = strndup(yytext, yyleng); return NUMBER;}

[ \t\r]

\n     return '\n';
.      return yytext[0];
%%
