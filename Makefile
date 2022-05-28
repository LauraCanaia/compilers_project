# A Makefile for simple lex and yacc examples

# Comment out the proper lines below according to the scanner and
# parser generators available in your system

LEX = lex
YACC = yacc -d
# LEX = flex 
# YACC = bison -d

# We assume that your C-compiler is called cc

CC = cc
FILE_NAME = taxyway

# taxyway is the final object that we will generate, it is produced by
# the C compiler from the y.tab.o and from the lex.yy.o

taxyway: y.tab.c lex.yy.c
	$(CC) -o ${FILE_NAME} y.tab.c lex.yy.c -lfl 

# These dependency rules indicate that (1) lex.yy.o depends on
# lex.yy.c and y.tab.h and (2) lex.yy.o and y.tab.o depend on taxyway.h.
# Make uses the dependencies to figure out what rules must be run when
# a file has changed.

lex.yy.o: lex.yy.c y.tab.h
lex.yy.o y.tab.o: ${FILE_NAME}.h

## This rule will use yacc to generate the files y.tab.c and y.tab.h
## from our file taxyway.y

y.tab.c y.tab.h: ${FILE_NAME}.y
	$(YACC) -d ${FILE_NAME}.y

## this is the make rule to use lex to generate the file lex.yy.c from
## our file taxyway.l

lex.yy.c: ${FILE_NAME}.l
	$(LEX) ${FILE_NAME}.l

## Make clean will delete all of the generated files so we can start
## from scratch

clean:
	-rm -f *.o lex.yy.c *.tab.* ${FILE_NAME} *.output

