
%{
	#include <stdio.h>
	int variavel = 0;
	int yylex();
	int yyerror(char*);
	extern int yylineno;
%}
%union {char valores[100];}
	//ponto da partida
%start program
	//tokens para identificar terminais 
%token<valores> KIND ETAG ID SUMMARY NAME BACKGROUNDCOLOR TYPE EMAIL LOCATION KEY TIMEZONE TIME HIDDEN RESERVED OBJECT LINK DATE CREATEDON URL ADD_GUEST CODE;

%%
			/*programa começa com duas chavetas que abrange todo ficheiro json,
			dentro desses chavetas estão os dados.*/ 
program 		:    '{' datas '}'
		;

			/*recursiva a direita.Existe pelo menos 1 ou mais objetos.*/
datas			:    data datas
		|    		 data
		;

			/*os dados podem ser key , array , object ou array_object comforme o dado processado*/
data			:    key comma 
		|   		 array comma
		|   		 object comma
		|   		 array_object comma
		;

			/*o array podem ter varios valores dentro ou array multidimensional */
array			:    '"' OBJECT '"' ':' '[' datas ']'
		;

			/*dentro de array pode ter objetos */
array_object	:    '"' OBJECT '"' ':' '[' program ']'	
		;

			/*um objeto*/
object 			:    '"' OBJECT '"' ':' '{' datas '}'
		;	

			/*a "comma" no fim de cada chave é para dizer que as chaves podem aparecer 
			com virgula ou sem e para evitar escrever tudo outra vez sem virgula então
			optei por criar um não terminal que pode ser ',' ou nada. */
key 			:    KIND 				{printf("%s \n", $1 );}
		|    		 ETAG 				{printf("%s \n", $1 );}
		|   		 ID   				{printf("%s \n", $1 );}
		|   		 NAME				{printf("%s \n", $1 );}
		|   		 SUMMARY			{printf("%s \n", $1 );}
		|    		 BACKGROUNDCOLOR	{printf("%s \n", $1 );}
		|    		 EMAIL				{printf("%s \n", $1 );}
		|    		 LOCATION			{printf("%s \n", $1 );}
		|   		 TIMEZONE			{printf("%s \n", $1 );}
		|   		 HIDDEN				{printf("%s \n", $1 );}
		|   		 DATE				{printf("%s \n", $1 );}
		|    		 CREATEDON			{printf("%s \n", $1 );}
		|    		 URL				{printf("%s \n", $1 );}
		|    		 LINK				{printf("%s \n", $1 );}
		|   		 TIME 				{printf("%s \n", $1 );}
		|   		 ADD_GUEST			{printf("%s \n", $1 );}
		|   	 	 CODE				{printf("%s \n", $1 );}
		|    		 TYPE				{printf("%s \n", $1 );}
		|   		 KEY 				{printf("%s \n", $1 );}
		|   		 RESERVED			{printf("%s \n", $1 );}
		;
			// é uma virgula ou não é nada
comma 			:    ','
		|
		;

		
%%
/*o yyerror para identificar a linha onde ocorreu o erro caso haja alguma */
int yyerror(char *msg){
	fprintf(stderr, "ERRO(%d):%s\n",yylineno, msg);
	//variavel = 1;
	return 0;
}
/*caso esteja tudo bem é executado o comando de printf dentro do if*/
int main(){
	yyparse();
	/*if(variavel != 1){
	//printf("Processado com sucesso!\n");
	}*/
	return 0;
}
