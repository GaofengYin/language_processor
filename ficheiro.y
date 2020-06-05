
%{
	#include <stdio.h>
	#include "html.c"
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
										 printf("  <tr>\n    <td>Kind</td>\n    <td>%s</td> \n", $1 ); contador++;}
		|    		 ETAG 				{printf("  <tr>\n    <td>ETAG</td>\n    <td>%s</td> \n", $1 ); contador++;}
		|   		 ID   				{printf("  <tr>\n    <td>ID</td>\n    <td>%s</td> \n", $1 ); contador++;}
		|   		 NAME				{printf("  <tr>\n    <td>Name</td>\n    <td>%s</td> \n", $1 ); contador++;}
		|   		 SUMMARY			{printf("  <tr>\n    <td>Summary</td>\n    <td>%s</td> \n", $1 );contador++;}
		|    		 BACKGROUNDCOLOR	{printf("  <tr>\n    <td>Background color</td>\n    <td>%s</td> \n", $1 );contador++;}
		|    		 EMAIL				{printf("  <tr>\n    <td>Email</td>\n    <td><a href=\"mailto:%s\">%s</a></td> \n", $1,$1 );contador++;}
		|    		 LOCATION			{printf("  <tr>\n    <td>Location</td>\n    <td>%s</td> \n", $1 ); contador++;}
		|   		 TIMEZONE			{printf("  <tr>\n    <td>Timezone</td>\n    <td>%s</td> \n", $1 ); contador++;}
		|   		 HIDDEN				{printf("  <tr>\n    <td>Hidden</td>\n    <td>%s</td> \n", $1 ); contador++;}
		|   		 DATE				{printf("  <tr>\n    <td>Date</td>\n    <td>%s</td> \n", $1 ); contador++;}
		|    		 CREATEDON			{printf("  <tr>\n    <td>Created on</td>\n    <td>%s</td> \n", $1 );contador++;}
		|    		 URL				{printf("  <tr>\n    <td>URL</td>\n    <td><a href=\"%s\">%s</a></td> \n", $1,$1 ); contador++;}
		|    		 LINK				{printf("  <tr>\n    <td>Link</td>\n    <td><a href=\"%s\">%s</a></td> \n", $1,$1 );contador++;}
		|   		 TIME 				{printf("  <tr>\n    <td>Time</td>\n    <td>%s</td> \n", $1 ); contador++;}
		|   		 ADD_GUEST			{printf("  <tr>\n    <td>Added guest</td>\n    <td>%s</td> \n", $1 );contador++;}
		|   	 	 CODE				{printf("  <tr>\n    <td>Code</td>\n    <td>%s</td> \n", $1 );contador++;}
		|    		 TYPE				{printf("  <tr>\n    <td>Type</td>\n    <td>%s</td> \n", $1 );contador++;}
		|   		 KEY 				{printf("  <tr>\n    <td>Key</td>\n    <td>%s</td> \n", $1 ); contador++;}
		|   		 RESERVED			{printf("  <tr>\n    <td>Reserved</td>\n    <td>%s</td> \n", $1 );contador++;}
		;
			// é uma virgula ou não é nada
comma 			:    ','
		|
		;

		
%%
int yyerror(char *msg){
	fprintf(stderr, "ERRO(%d):%s\n",yylineno, msg);
	return 0;
}
int main(){
	htmlBegin();
	beginTable();
	yyparse();
	endTable();
	printf("<h1>Numero de chaves %d</h1>\n",contador);
	htmlEnd();
	return 0;
}
//consultar isto 
//https://www.w3schools.com/html/tryit.asp?filename=tryhtml_table_intro