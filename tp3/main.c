/*
 ============================================================================
 TP3 - 2017
 Titulo      : Trabajo Práctico N.o 3
 Grupo Nro.  : 03
 Integrantes : Decurgez Damian (149-341/3)
               Galliano Ignacio (156-363/4)
               Latasa Julian (150-163/0)
               Muscatiello Juan (156-098/0)
 ============================================================================
 */

#include <stdio.h>
#include <strings.h>
#include "src/scanner.h"
#include "src/tokens.h"

char *token_names[] = {
  "Fin de Archivo",
  "Programa",
  "Variables",
  "Código",
  "Fin",
  "Definir",
  "Leer",
  "Escribir",
  "Identificador",
  "Constante",
  "Asignación",
  "\'(\'", // Paréntesis izquierdo
  "\')\'", // Paréntesis derecho
  "\';\'", // Punto y coma
  "\',\'", // Coma
  "Comentario",
  "\'+\'", // Más
  "\'-\'", // Menos
  "\'*\'", // Por
  "\'/\'", // Dividir
};

int main() {
  enum token t = -1;
  while (t){
    t = yylex();
    switch(t){
      case IDENT:
      case CONST:
        printf("Token: %s\t\tLexema: %s\n", token_names[t], yytext);
        break;
      default:
        printf("Token: %s\n", token_names[t]);
        break;
    }
	}

	return 0;
}
