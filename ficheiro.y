
%{
	#include <stdio.h>
	int variavel = 0;
	int yylex();
	int yyerror(char*);
	extern int yylineno;
%}

%start program
%token KIND ETAG ID SUMMARY NAME BACKGROUNDCOLOR TYPE EMAIL LOCATION KEY 
%token TIMEZONE TIME HIDDEN RESERVED OBJECT LINK DATE CREATEDON URL ADD_GUEST CODE


%%
			/*programa começa com duas chavetas que abrange todo ficheiro json,
			entro desses chavetas estão os objetos.*/ 
program		:    '{' objetos '}'
		;
			/*recursiva a direita.Existe pelo menos 1 ou mais objetos.*/
objetos		:    objeto objetos
			|
		;
			/*objecto são as chaves e o respectivo valor associado. 
			podem ser arrays em que desdobrei para melhor hieraquizar a informação
			a "comma" no fim de cada chave é para dizer que as chaves podem aparecer 
			com virgula ou sem no fim e para evitar escrever tudo outra vez sem virgula
			optei por criar um não terminal que pode ser ',' ou nada.*/
objeto		: 	  normal
			|	  array
		;

normal 		: 	  KIND comma
			|	  ETAG comma
			|	  ID comma
			|	  NAME comma
			|	  SUMMARY comma
			|	  BACKGROUNDCOLOR comma
			|	  EMAIL comma
			|	  LOCATION comma
			|	  TIMEZONE comma
			|	  HIDDEN comma
			|	  DATE comma
			|	  CREATEDON comma
			|     URL comma
			|	  LINK comma	
			|	  TIME comma
			|	  ADD_GUEST comma
			|	  CODE comma
			|	  TYPE comma
			|	  KEY comma
			|	  RESERVED comma
		;

array		:	  '"' OBJECT '"' ':' '{' objetos '}' comma
			|	  '"' OBJECT '"' ':' '[' objetos ']' comma
			|	  '"' OBJECT '"' ':' '[' program ']' comma
		;

comma 		: ','
			|
		;

		
%%
/*o yyerror para identificar a linha onde ocorreu o erro caso haja alguma */
int yyerror(char *msg){
	fprintf(stderr, "ERRO(%d):%s\n",yylineno, msg);
	variavel = 1;
	return 0;
}
/*caso esteja tudo bem é executado o comando de printf dentro do if*/
int main(){
	yyparse();
	if(variavel != 1){
	printf("Processado com sucesso!\n");
	}
	return 0;
}
