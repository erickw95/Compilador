package decaf;

import java.io.*;
//import antlr.Token;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;
import org.antlr.v4.runtime.Token;
//import org.antlr.v4.runtime.ANTLRInputStream;
//import org.antlr.v4.runtime.CommonTokenStream;
import java6035.tools.CLI.*;

class Main {


    	public static void main(String[] args)
	{
        try
		{
        	CLI.parse (args, new String[0]);

        	InputStream inputStream = args.length == 0 ?
                    System.in : new java.io.FileInputStream(CLI.infile);

        	if (CLI.target == CLI.SCAN)
        	{
        		DecafLexer lexer = new DecafLexer(new ANTLRInputStream(inputStream));

        		Token token = null;
        		boolean done = false;
        		while (!done)
        		{
		        	try
					{
						for (token=lexer.nextToken(); token.getType()!=Token.EOF; token=lexer.nextToken())
			        	{
			        		String type = "";
			        		String text = token.getText();
	
		        			switch (token.getType())
		        			{
							case DecafLexer.CHARLITERAL:
								type = " CHARLITERAL";
								break;
							case DecafLexer.INTLITERAL:
								type = " INTLITERAL";	
								break;
							case DecafLexer.HEXERROR:
								type = " HEXERROR";
								break;
							case DecafLexer.STRINGLITERAL:
								type = " STRINGLITERAL";
								break;
							case DecafLexer.IDENTIFIER:
								type = " IDENTIFIER";
								break;
							case DecafLexer.PROGRAM:
							case DecafLexer.CLASS:
							case DecafLexer.TYPE:
							case DecafLexer.CALLOUT:
							case DecafLexer.IF:
							case DecafLexer.ELSE:
							case DecafLexer.FOR:
							case DecafLexer.VOID:
							case DecafLexer.RETURN:
							case DecafLexer.BREAK:
							case DecafLexer.CONTINUE:
								type = "";
								break;
							case DecafLexer.BOOLEANLITERAL:
								type = " BOOLEANLITERAL";	
								break;
							case DecafLexer.BINARYOP:
							case DecafLexer.UNARY:
							case DecafLexer.NEG:
							case DecafLexer.EQUAL:
							case DecafLexer.ASSIGNOP:
							case DecafLexer.RCURLY:
							case DecafLexer.LCURLY:
							case DecafLexer.RSQUARE:
							case DecafLexer.LSQUARE:
							case DecafLexer.LPARENT:
							case DecafLexer.RPARENT:
							case DecafLexer.COMMA:
							case DecafLexer.SEMICOLON:
								type = "";
								break;
		        			}
							
		        			System.out.println (token.getLine() + type + " " + text);
		        		}
		        		done = true;
        			}
					catch(Exception e)
					{
						// print the error:
						System.out.println(CLI.infile+" "+e);
						lexer.skip();
					}
				}
        	}
        	else if (CLI.target == CLI.PARSE || CLI.target == CLI.DEFAULT)
        	{
        		DecafLexer lexer = new DecafLexer(new ANTLRInputStream(inputStream));
			CommonTokenStream tokens = new CommonTokenStream(lexer);
        		DecafParser parser = new DecafParser(tokens);
			
			parser.program();
        	}
		else if (CLI.target == CLI.INTER)
		{
        		DecafLexer lexer = new DecafLexer(new ANTLRInputStream(inputStream));
			CommonTokenStream tokens = new CommonTokenStream(lexer);
        		DecafParser parser = new DecafParser(tokens);
			
			ParseTree tree = parser.program();
			if(CLI.debug)
				System.out.println(tree.toStringTree(parser));

			ParseTreeWalker walker = new ParseTreeWalker();
			DecafTreeListener listener = new DecafTreeListener();
			walker.walk(listener, tree);
		}

        	
        } catch(Exception e) {
        	// print the error:
            System.out.println(CLI.infile+" "+e);
        }
    }
}

