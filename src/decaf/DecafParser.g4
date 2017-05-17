parser grammar DecafParser;

@header {
package decaf;
}

options
{
  language=Java;
  tokenVocab=DecafLexer;
}


program : CLASS PROGRAM classBody EOF;
classBody : LCURLY fieldDecl* methodDecl* RCURLY;

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

varDecl : TYPE IDENTIFIER (COMMA IDENTIFIER)* SEMICOLON;

statement : location (EQUAL|ASSIGNOP) expr SEMICOLON
	| methodCall SEMICOLON
	| IF LPARENT expr RPARENT block (ELSE block)?
	| FOR IDENTIFIER EQUAL expr COMMA expr block
	| RETURN expr? SEMICOLON
	| BREAK SEMICOLON
	| CONTINUE SEMICOLON
	| block;

methodCall : methodName LPARENT methodCallArgs? RPARENT
	| CALLOUT LPARENT STRINGLITERAL (COMMA calloutArgs)* RPARENT;
methodCallArgs: expr (COMMA expr)*;

calloutArgs : expr | STRINGLITERAL;
	
methodName : IDENTIFIER;

location : IDENTIFIER
	| IDENTIFIER LSQUARE expr RSQUARE;

expr : location
	| methodCall
	| literal
	| expr (BINARYOP|UNARY) expr
	| UNARY expr
	| NEG expr
	| LPARENT expr RPARENT;
 
literal: BOOLEANLITERAL | INTLITERAL | CHARLITERAL;
