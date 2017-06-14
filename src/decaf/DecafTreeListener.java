package decaf;

import org.antlr.v4.runtime.misc.NotNull;
import org.antlr.v4.runtime.tree.*;
import java.util.List;
import java.util.Stack;

public class DecafTreeListener extends DecafParserBaseListener {

	Stack<String> escopo;

	@Override
	public void enterProgram(@NotNull DecafParser.ProgramContext ctx) {
		// inicia o escopo global
		escopo = new Stack<String>();
	}

	@Override
	public void enterVarDecl(@NotNull DecafParser.VarDeclContext ctx) {		
		// procura simbolo

		List<TerminalNode> ids = ctx.IDENTIFIER();
		//System.out.println("id: " + ctx.IDENTIFIER());
		for(int i = 0; i < ids.size(); i++) {
			String id = ids.get(i).toString();
			if(escopo.search(id) == -1)
				escopo.push(id); // insere
			else
				System.out.println("ERRO: Variavel '" + id  + "' ja declarada");
		}
	}

}

