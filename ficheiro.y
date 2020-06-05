
%{
	#include <stdio.h>
	#include "html.c"
	int variavel = 0;
	int yylex();
	int yyerror(char*);
	extern int yylineno;
	int contador = 0;
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
data			:    key comma  {printf("  </tr>\n");}
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
key 			:    KIND 				{printf("  <tr>\n    <th>Identificador</th>\n    <th>Valor</th>\n  </tr>\n"); 
										 printf("  <tr>\n    <td>KIND</td>\n    <td>%s</td> \n", $1 ); contador++;}
		|    		 ETAG 				{printf("  <tr>\n    <td>ETAG</td>\n    <td>%s</td> \n", $1 ); contador++;}
		|   		 ID   				{printf("  <tr>\n    <td>ID</td>\n    <td>%s</td> \n", $1 ); contador++;}
		|   		 NAME				{printf("  <tr>\n    <td>NAME</td>\n    <td>%s</td> \n", $1 ); contador++;}
		|   		 SUMMARY			{printf("  <tr>\n    <td>SUMMARY</td>\n    <td>%s</td> \n", $1 ); contador++;}
		|    		 BACKGROUNDCOLOR	{printf("  <tr>\n    <td>BACKGROUNDCOLOR</td>\n    <td>%s</td> \n", $1 ); contador++;}
		|    		 EMAIL				{printf("  <tr>\n    <td>EMAIL</td>\n    <td><a href=\"mailto:%s\">%s</a></td> \n", $1,$1 ); contador++;}
		|    		 LOCATION			{printf("  <tr>\n    <td>LOCATION</td>\n    <td>%s</td> \n", $1 ); contador++;}
		|   		 TIMEZONE			{printf("  <tr>\n    <td>TIMEZONE</td>\n    <td>%s</td> \n", $1 ); contador++;}
		|   		 HIDDEN				{printf("  <tr>\n    <td>HIDDEN</td>\n    <td>%s</td> \n", $1 ); contador++;}
		|   		 DATE				{printf("  <tr>\n    <td>DATE</td>\n    <td>%s</td> \n", $1 ); contador++;}
		|    		 CREATEDON			{printf("  <tr>\n    <td>CREATEDON</td>\n    <td>%s</td> \n", $1 ); contador++;}
		|    		 URL				{printf("  <tr>\n    <td>URL</td>\n    <td><a href=\"%s\">%s</a></td> \n", $1,$1 ); contador++;}
		|    		 LINK				{printf("  <tr>\n    <td>LINK</td>\n    <td><a href=\"%s\">%s</a></td> \n", $1,$1 ); contador++;}
		|   		 TIME 				{printf("  <tr>\n    <td>TIME</td>\n    <td>%s</td> \n", $1 ); contador++;}
		|   		 ADD_GUEST			{printf("  <tr>\n    <td>ADD_GUEST</td>\n    <td>%s</td> \n", $1 ); contador++;}
		|   	 	 CODE				{printf("  <tr>\n    <td>CODE</td>\n    <td>%s</td> \n", $1 ); contador++;}
		|    		 TYPE				{printf("  <tr>\n    <td>TYPE</td>\n    <td>%s</td> \n", $1 ); contador++;}
		|   		 KEY 				{printf("  <tr>\n    <td>KEY</td>\n    <td>%s</td> \n", $1 ); contador++;}
		|   		 RESERVED			{printf("  <tr>\n    <td>RESERVED</td>\n    <td>%s</td> \n", $1 ); contador++;}
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
	htmlBegin();
	yyparse();
	/*if(variavel != 1){
	//printf("Processado com sucesso!\n");
	}*/
	htmlEnd();
	return 0;
}
//consultar isto 
//https://www.w3schools.com/html/tryit.asp?filename=tryhtml_table_intro