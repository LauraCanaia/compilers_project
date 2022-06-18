%{
#include <stdio.h>
#include "y.tab.h"
%}


DIGIT [0-9]+
MOVEMENT "UP"|"DOWN"|"RIGHT"|"LEFT"

%%

exit                         exit(0);
{MOVEMENT}                   {yylval.string = strndup(yytext, yyleng); return MOVEMENT;}
{DIGIT}                      {yylval.number=atoi(yytext); return DIGIT;}

[ \t\r]

\n     return '\n';
.      return yytext[0];

%%

