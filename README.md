# Compilador

Projeto da disciplina de Construção de Compiladores UniCEUB 2017/01.
Compilador para a linguagem DECAF construído com [ANTLR4](https://github.com/antlr/antlr4).

- [Erick Weissenstein](https://github.com/erickw95)
- [Felipe P. Silva](https://github.com/felipepsilva)

## Uso
Formato da linha de comando:
```
java -jar dist/Compiler.jar [argumentos] arquivo.dcf
```
Interface de linha de comando disponibiliza o argumento `-target`, que pode ser `-lexer`, `-parser` e `-inter`, para executar análise léxica, sintática e semântica, respectivamente. Exemplo de linha pra rodar:
```
java -jar dist/Compiler.jar -target inter arquivo.dcf
```




