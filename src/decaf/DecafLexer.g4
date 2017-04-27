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

WS_ : (' ' | '\n' | '\r' | '\t' ) -> skip;
SL_COMMENT : '//' (~'\n')* '\n' -> skip;

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

LCURLY    : '{' ;
RCURLY    : '}' ;
LSQUARE   : '[' ;
RSQUARE   : ']' ;
LPARENT   : '(' ; 
RPARENT   : ')' ;
COMMA     : ',' ;
SEMICOLON : ';';

OP : '+' | '-' | '*' | '<' | '>' | '>=' | '<=' | '!=' | '&&' | '=' | '==' | '||';

IDENTIFIER  : ('_' | LETTER)('_' | LETTER | DIGIT)* ;
fragment LETTER : ('a'..'z' | 'A'..'Z');

INTLITERAL : HEXLITERAL | DECLITERAL ;
fragment HEXLITERAL : '0x'(DIGIT | 'a'..'f' | 'A'..'F')+ ;
fragment DECLITERAL : DIGIT+;
fragment DIGIT : ('0'..'9');

HEXERROR: '0x'; // captura a construção incorreta

STRINGLITERAL : '"' ( ESCCHAR | VALIDCHAR )* '"';
CHARLITERAL : '\'' ( ESCCHAR | VALIDCHAR ) '\'' ;


fragment VALIDCHAR : ' ' | '!' | '#'..'&' | '('..'[' | ']'..'~' ;
fragment ESCCHAR :  '\\' ('r' | 'n' | 't' | '\'' | '"' | '\\' ) ;