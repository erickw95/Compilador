parser grammar DecafParser;

@header {
package decaf;
}

options
{
  language=Java;
  tokenVocab=DecafLexer;
}


program : classDecl EOF;


classDecl : CLASS IDENTIFIER LCURLY fieldDecl* methodDecl* RCURLY;


fieldDecl :
	TYPE 
	(IDENTIFIER |
		IDENTIFIER LSQUARE INTLITERAL RSQUARE ) // vetor-array ex.: i[10]
	SEMICOLON;

	
methodDecl : (TYPE | VOID) IDENTIFIER LPARENT args? RPARENT block;
args : TYPE IDENTIFIER (COMMA args)*;
block : LCURLY RCURLY ;