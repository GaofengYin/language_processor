
%{
	#include <stdio.h>
	#include <string.h>
	#include "html.c"
	int yylex();
	int yyerror(char*);
	extern int yylineno;
	int contador = 0;
	char str[100];
%}
%union {
	char valores[100];
}
	//ponto da partida
%start program
	//tokens para identificar terminais 
%token<valores> KIND ETAG ID SUMMARY NAME BACKGROUNDCOLOR TYPE EMAIL LOCATION KEY 
%token<valores> TIMEZONE TIME HIDDEN RESERVED OBJECT LINK DATE CREATEDON URL ADD_GUEST CODE;

%%
			/*programa começa com duas chavetas que abrange todo ficheiro json,
			dentro desses chavetas estão os dados.*/ 
program 		:    '{' datas '}'
		;

			/*recursiva a direita.Existe pelo menos 1 ou mais objetos.*/
datas			:    data datas		
		|    		 data 	
		;

			/*os dados podem ser key , array , object ou array_object comforme o dado processado
			a "comma" no fim de cada chave é para dizer que as chaves podem aparecer 
			com virgula ou sem e para evitar escrever tudo outra vez sem virgula então
			optei por criar um não terminal que pode ser ',' ou nada. */
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
			/* -tr é a linha, th é o header e o td é data de cada linha.
			 -Sempre que é identificado um key , é incrementado o valor do contador.
			 -o valor da cor em hexadecimal é mostrado em texto no fim.
			 -Na pagina ao carregar no endereço de email, é aberto caixa de correio para enviar mail
			 -o link redireciona para pagina em outra separador
			  */
key 			:    KIND 				{printf("  <tr>\n    <th>Identificador</th>\n    <th>Valor</th>\n  </tr>\n"); 
										 printf("  <tr>\n    <td>Kind</td>\n    <td>%s</td> \n", $1 ); contador++;}
		|    		 ETAG 				{printf("  <tr>\n    <td>ETAG</td>\n    <td>%s</td> \n", $1 ); contador++;}
		|   		 ID   				{printf("  <tr>\n    <td>ID</td>\n    <td>%s</ttony d> \n", $1 ); contador++;}
		|   		 NAME				{printf("  <tr>\n    <td>Name</td>\n    <td>%s</td> \n", $1 ); contador++;}
		|   		 SUMMARY			{printf("  <tr>\n    <td>Summary</td>\n    <td>%s</td> \n", $1 );contador++;}
		|    		 BACKGROUNDCOLOR	{printf("  <tr>\n    <td>Color</td>\n    <td>%s</td> \n", $1 );  strcpy(str, $1); contador++;}
		|    		 EMAIL				{printf("  <tr>\n    <td>Email</td>\n    <td><a href=\"mailto:%s\">%s</a></td> \n", $1,$1 );contador++;}
		|    		 LOCATION			{printf("  <tr>\n    <td>Location</td>\n    <td>%s</td> \n", $1 ); contador++;}
		|   		 TIMEZONE			{printf("  <tr>\n    <td>Timezone</td>\n    <td>%s</td> \n", $1 ); contador++;}
		|   		 HIDDEN				{printf("  <tr>\n    <td>Hidden</td>\n    <td>%s</td> \n", $1 ); contador++;}
		|   		 DATE				{printf("  <tr>\n    <td>Date</td>\n    <td>%s</td> \n", $1 ); contador++;}
		|    		 CREATEDON			{printf("  <tr>\n    <td>Created on</td>\n    <td>%s</td> \n", $1 );contador++;}
		|    		 URL				{printf("  <tr>\n    <td>URL</td>\n    <td><a href=\"%s\" target=\"_blank\">%s</a></td> \n", $1,$1 ); contador++;}
		|    		 LINK				{printf("  <tr>\n    <td>Link</td>\n    <td><a href=\"%s\" target=\"_blank\">%s</a></td> \n", $1,$1 );contador++;}
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
	//as funções estão no ficheiro html.c para melhor organização do código
	htmlBegin();
	beginTable();
	yyparse();
	endTable();
	contadorDeIdenty(contador);
	corDaLetra(str);
	htmlEnd();
	return 0;
}

//consultei a seguinte pagina para tirar umas referências
//https://www.w3schools.com/html/tryit.asp?filename=tryhtml_table_intro