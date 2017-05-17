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
	fieldIdentifierDecl (COMMA fieldIdentifierDecl)* 
	SEMICOLON;

fieldIdentifierDecl : 
	(IDENTIFIER |
		IDENTIFIER LSQUARE INTLITERAL RSQUARE ); // vetor-array ex.: i[10]	

methodDecl : (TYPE | VOID) IDENTIFIER LPARENT args? RPARENT block;
args : TYPE IDENTIFIER (COMMA args)*;

block : LCURLY (varDecl)* (statement)* RCURLY ;

varDecl : TYPE IDENTIFIER (COMMA IDENTIFIER)*;

statement : location OP expr;
	| methodCall;
	| IF (expr) block (ELSE block)*;
	| FOR IDENTIFIER OP expr , expr block; // OP? ","?
	| RETURN expr*;
	| BREAK;
	| CONTINUE;
	| block

methodCall : methodName ( expr (COMMA expr)* )
	| CALLOUT ( STRINGLITERAL ) calloutArgs*;
	
methodName : IDENTIFIER;

location : IDENTIFIER
	| IDENTIFIER LSQUARE expr RSQUARE;

expr : location
	| methodCall
	| literal
	| expr binOP expr
	| - expr
	| ! expr
	| (expr);
