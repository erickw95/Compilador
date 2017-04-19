package decaf;

import java.io.*;
//import antlr.Token;
import org.antlr.v4.runtime.*;
//import org.antlr.v4.runtime.Token;
//import org.antlr.v4.runtime.ANTLRInputStream;
//import org.antlr.v4.runtime.CommonTokenStream;
import java6035.tools.CLI.*;

class Main {
	
	public static class ErrorDecafLexer extends DecafLexer
	{
		public ErrorDecafLexer(CharStream input) { super(input); }

		public void recover(LexerNoViableAltException e) {
			throw new RuntimeException(e);
		}
	}


    public static void main(String[] args) {
        try {
        	CLI.parse (args, new String[0]);

        	InputStream inputStream = args.length == 0 ?
                    System.in : new java.io.FileInputStream(CLI.infile);

        	if (CLI.target == CLI.SCAN)
        	{
        		//DecafLexer lexer = new DecafLexer(new ANTLRInputStream(inputStream));
			ErrorDecafLexer lexer = new ErrorDecafLexer(new ANTLRInputStream(inputStream));
			lexer.removeErrorListeners();

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
	        				case DecafLexer.ID:
	        					type = " IDENTIFIER";
	        					break;
						case DecafLexer.CHAR:
							type = " CHARLITERAL";
							break;
						//case DecafLexer.
	        				}
	        				System.out.println (token.getLine() + type + " " + text);
	        			}
	        			done = true;
				}
				catch(RuntimeException e)
				{
					System.out.println("erro lexico");
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
        	
        } catch(Exception e) {
        	// print the error:
            System.out.println(CLI.infile+" "+e);
        }
    }
}

