lexer grammar DecafLexer;

@header {
package decaf;
}

options
{
  language=Java;
}
tokens
{
  TK_class
}

LCURLY : '{';
RCURLY : '}';
LSQUARE : '[';
RSQUARE : ']';
LPARENT : '('; 
RPARENT : ')';

// Palavras reservadas
RESERVED : 
'boolean' |
'callout' |
'class' |
'else' |
'if' |
'int' |
'return' |
'void' |
'for' |
'break' |
'continue' ;

BOOLEANLITERAL : 'true' | 'false';

// Operadores
OP : '+' | '-' | '*' | '<' | '>' | '>=' | '<=' | '!=' | '&&' | '=' | '==' | '||';

ID  : ('_' | LETTER)('_' | LETTER | DIGIT)*;

WS_ : (' ' | '\n' ) -> skip;

SL_COMMENT : '//' (~'\n')* '\n' -> skip;

STRINGLITERAL : '"' (ESC|~('"'|'\''))* '"';
INTLITERAL :  DECLITERAL | HEXLITERAL;
DECLITERAL : DIGIT+;
HEXLITERAL : '0x'(DIGIT | 'a'..'f' | 'A'..'F')+;
HEXERROR : '0x';

DIGIT : ('0'..'9');
LETTER : ('a'..'z' | 'A'..'Z');
SEPARATOR: (',' | ';');

CHARLITERAL : '\'' (ESC|~'\'') '\'';

fragment
ESC :  '\\' ('n'|'"'| 't' | '\\' | '\'');
