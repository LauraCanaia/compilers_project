
DIGIT [0-9]+
DIRECTION "UP"|"DOWN"|"RIGHT"|"LEFT"
%%

{DIRECTION} {yylval.stringa = strndup(yytext, yyleng); return STRING;}
{DIGIT} {yylval.numero = atoi(yytext); return NUMBER;}
.
%%
/*
void main(int argc, char **argv) {
    if (argc > 1) {
        yyin = fopen (argv[1], "r");
    }
    else {
        printf("Reading from Keyboard:\n");
        yyin = stdin;
    }
    yylex();
}*/