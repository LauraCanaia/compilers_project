
%{
#include <stdio.h>
#include "y.tab.h"
%}
DIGIT [0-9]+
DIRECTION "UP"|"DOWN"|"RIGHT"|"LEFT"
%%

{DIRECTION} {yylval.string = strndup(yytext, yyleng); return DIRECTION;}
{DIGIT} {yylval.number = atoi(yytext); return NUMBER;}
.
%%