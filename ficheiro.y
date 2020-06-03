
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
data			:    key comma  {printf("</tr>\n");}
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
key 			:    KIND 				{printf("<tr>\n<th>Key</th>\n<th>value</th>\n</tr>\n"); 
										 printf("<tr>\n<th>KIND</th>\n<th>%s</th> \n", $1 );}
		|    		 ETAG 				{printf("<tr>\n<th>ETAG</th>\n<th>%s</th> \n", $1 );}
		|   		 ID   				{printf("<tr>\n<th>ID</th>\n<th>%s</th> \n", $1 );}
		|   		 NAME				{printf("<tr>\n<th>NAME</th>\n<th>%s</th> \n", $1 );}
		|   		 SUMMARY			{printf("<tr>\n<th>SUMMARY</th>\n<th>%s</th> \n", $1 );}
		|    		 BACKGROUNDCOLOR	{printf("<tr>\n<th>BACKGROUNDCOLOR</th>\n<th>%s</th> \n", $1 );}
		|    		 EMAIL				{printf("<tr>\n<th>EMAIL</th>\n<th>%s</th> \n", $1 );}
		|    		 LOCATION			{printf("<tr>\n<th>LOCATION</th>\n<th>%s</th> \n", $1 );}
		|   		 TIMEZONE			{printf("<tr>\n<th>TIMEZONE</th>\n<th>%s</th> \n", $1 );}
		|   		 HIDDEN				{printf("<tr>\n<th>HIDDEN</th>\n<th>%s</th> \n", $1 );}
		|   		 DATE				{printf("<tr>\n<th>DATE</th>\n<th>%s</th> \n", $1 );}
		|    		 CREATEDON			{printf("<tr>\n<th>CREATEDON</th>\n<th>%s</th> \n", $1 );}
		|    		 URL				{printf("<tr>\n<th>URL</th>\n<th>%s</th> \n", $1 );}
		|    		 LINK				{printf("<tr>\n<th>LINK</th>\n<th>%s</th> \n", $1 );}
		|   		 TIME 				{printf("<tr>\n<th>TIME</th>\n<th>%s</th> \n", $1 );}
		|   		 ADD_GUEST			{printf("<tr>\n<th>ADD_GUEST</th>\n<th>%s</th> \n", $1 );}
		|   	 	 CODE				{printf("<tr>\n<th>CODE</th>\n<th>%s</th> \n", $1 );}
		|    		 TYPE				{printf("<tr>\n<th>TYPE</th>\n<th>%s</th> \n", $1 );}
		|   		 KEY 				{printf("<tr>\n<th>KEY</th>\n<th>%s</th> \n", $1 );}
		|   		 RESERVED			{printf("<tr>\n<th>RESERVED</th>\n<th>%s</th> \n", $1 );}
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
void htmlBegin(){
	printf("<!DOCTYPE html>\n<html>\n<head>\n");
	printf("<title>Google calendar info</title>\n");
	printf("</head>\n<body>\n");
	printf("<h2>HTML Table</h2>\n");
	printf("<table>\n");
}
void htmlEnd(){
	printf("</table>\n</body>\n</html>\n");
}
/*caso esteja tudo bem é executado o comando de printf dentro do if*/
int main(){
	htmlBegin();
	yyparse();
	/*if(variavel != 1){
	//printf("Processado com sucesso!\n");
	}*/
	htmlEnd();
	return 0;
}
