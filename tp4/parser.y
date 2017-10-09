/*** Definiciones ***/
%code top{
	#include <stdio.h>
	#include "scanner.h"
}
%code provides {
	void yyerror(const char *s);
	extern int nerrlex;
}
%defines "parser.h"
%output "parser.c"
%union {
	int    num;
	char   *str;
}
%token<str> IDENTIFICADOR
%token<num> CONSTANTE
%token RWORD_PROGRAMA
%token RWORD_VARIABLES
%token RWORD_CODIGO
%token RWORD_FIN
%token RWORD_DEFINIR
%token RWORD_LEER
%token RWORD_ESCRIBIR
%token ASIGNSYM
%token PUNTCHAR_PIZQ
%token PUNTCHAR_PDER
%token PUNTCHAR_PUNTOCOMA
%token PUNTCHAR_COMA
%token PUNTCHAR_COMENT
%token OPER_MAS
%token OPER_MENOS
%token OPER_MULT
%token OPER_DIV
%token ERROR_CONST
%token ERROR_IDENT
%token ERROR_DESC
%token FDT
%define parse.error verbose

%code {
	char *token_names[] = {"Identificador", "Constante", "programa", "variables", "codigo", "fin", "definir", "leer", "escribir", "asignacion", "abrir parentesis", "cerrar parentesis", "punto y coma", "coma", "comentario", "sumar", "restar", "multiplicar", "dividir", "error constante", "error identificador", "error desc", "fin de texto"};
}

%% /*** Reglas BNF ***/
todo	: programa { if (yynerrs || nerrlex) YYABORT;}

programa : RWORD_PROGRAMA sector_definicion_variables codigo RWORD_FIN

sector_definicion_variables : RWORD_VARIABLES definicion_variables

definicion_variables : RWORD_DEFINIR IDENTIFICADOR PUNTCHAR_PUNTOCOMA
			     | RWORD_DEFINIR IDENTIFICADOR PUNTCHAR_PUNTOCOMA definicion_variables
					 | error

codigo : RWORD_CODIGO conjunto_sentencias
			 | error

conjunto_sentencias : sentencia PUNTCHAR_PUNTOCOMA
										| sentencia PUNTCHAR_PUNTOCOMA conjunto_sentencias

sentencia : RWORD_LEER PUNTCHAR_PIZQ lista_identificadores PUNTCHAR_PDER
	  | RWORD_ESCRIBIR PUNTCHAR_PIZQ lista_expresiones PUNTCHAR_PDER
	  | IDENTIFICADOR ASIGNSYM expresion

lista_identificadores : IDENTIFICADOR
		      | IDENTIFICADOR PUNTCHAR_COMA lista_identificadores

lista_expresiones : expresion
		  | expresion PUNTCHAR_COMA lista_expresiones

expresion : termino
	  | expresion OPER_MAS termino
	  | expresion OPER_MENOS termino

termino : factor
	| termino OPER_MULT factor
	| termino OPER_DIV factor

factor: operando
      |	PUNTCHAR_PIZQ expresion PUNTCHAR_PDER
      | OPER_MENOS expresion

operando : IDENTIFICADOR | CONSTANTE

%%
