%{
	#include "y.tab.h"
%}

%option noyywrap
%option yylineno

	//expressão regular de uma string
string [a-zA-Z0-9\/ ]+
	//expressão regular que identifica cores em hexadecimal
hex_color #(?:[0-9a-fA-F]{3}){1,2}
	//expressão regular para websites
url (http:|https:)?(\/\/)?(www\.)?[a-zA-Z0-9\/\.\#]+
	//expressão regular que identifica email
email [a-zA-Z@\.\-_0-9]+
	//valor padrão do boolean
boolean "false"|"true"
	//valor padrão de certos chaves
palavras_reservadas "eventHangout"|"eventNamedHangout"|"hangoutsMeet"|"addOn"
	//numeros inteiros positivos ou 0
integer 0|[0-9]+
	//data em formato 1996-07-13
date (1|2)[0-9]+\-((0)[1-9]|1[012])\-(0[1-9]|[12][0-9]|3[01]) 
	//hora em formato 23:50:46
time ([0-1]?[0-9]|2[0-3])\:[0-5][0-9]\:([0-5][0-9]|60)(pm|am)?
	//data e hora em formato 2003-05-17 15:45:23
datetime {date}" "{time}
	//etgas 
etag (w\/)?(w\/)?[0-9a-z"]+
	//kind
kind [a-zA-Z]+"#"[a-zA-Z]+

%%
					// chave : valor da chave

"\"kind\": "\"{kind}\" 						{	
												char *aux = yytext;
												int i;
												for(i=0; i<8; i++){aux++;}
												strcpy(yylval.valores, aux);
												return KIND;
											}

"\"etag\": "{etag}							{	
												char *aux = yytext;
												int i;
												for(i=0; i<8; i++){aux++;}
												strcpy(yylval.valores, aux);
												return	ETAG;
											}

"\"id\": "{integer}							{	
												char *aux = yytext;
												int i;
												for(i=0; i<6; i++){aux++;}
												strcpy(yylval.valores, aux);
												return ID;
											}

"\"name\": "{string}						{	
												char *aux = yytext;
												int i;
												for(i=0; i<8; i++){aux++;}
												strcpy(yylval.valores, aux);	
												return NAME;
											}

"\"summary\": "{string}						{	
												char *aux = yytext;
												int i;		
												for(i=0; i<11; i++){aux++;}
												strcpy(yylval.valores, aux);
												return SUMMARY;
											}

"\"backgroundColor\": "{hex_color}			{	
												char *aux = yytext;
												int i;
												for(i=0; i<19; i++){aux++;}
												strcpy(yylval.valores, aux);
												return BACKGROUNDCOLOR;
											}

"\"email\": "{email}						{	
												char *aux = yytext;
												int i;
												for(i=0; i<9; i++){aux++;}
												strcpy(yylval.valores, aux);	
												return EMAIL;
											}

"\"location\": "{string}					{	
												char *aux = yytext;
												int i;
												for(i=0; i<12; i++){aux++;}
												strcpy(yylval.valores, aux);	
												return LOCATION;
											}

"\"timeZone\": "{string}					{	
												char *aux = yytext;
												int i;
												for(i=0; i<12; i++){aux++;}
												strcpy(yylval.valores, aux);	
												return TIMEZONE;
											}

"\"hidden\": "{boolean}						{	
												char *aux = yytext;
												int i;
												for(i=0; i<10; i++){aux++;}
												strcpy(yylval.valores, aux);
												return HIDDEN;
											}

"\"date\": "{date}							{	
												char *aux = yytext;
												int i;
												for(i=0; i<8; i++){aux++;}
												strcpy(yylval.valores, aux);
												return DATE;
											}

"\"createdon\": "{datetime}					{	
												char *aux = yytext;
												int i;
												for(i=0; i<13; i++){aux++;}
												strcpy(yylval.valores, aux);
												return CREATEDON;
											}

"\"url\": "{url}							{	
												char *aux = yytext;
												int i;
												for(i=0; i<7; i++){aux++;}
												strcpy(yylval.valores, aux);
												return URL;
											}

"\"Link\": "{url}							{	
												char *aux = yytext;	
												int i;
												for(i=0; i<8; i++){aux++;}
												strcpy(yylval.valores, aux);
												return LINK;
											}

"\"time\": "{time}							{	
												char *aux = yytext;
												int i;
												for(i=0; i<8; i++){aux++;}
												strcpy(yylval.valores, aux);	
												return	TIME;
											}

"\"additionalGuests\": "{integer}			{	
												char *aux = yytext;
												int i;
												for(i=0; i<20; i++){aux++;}
												strcpy(yylval.valores, aux);
												return ADD_GUEST;
											}

"\"code\": "{string}						{	
												char *aux = yytext;
												int i;
												for(i=0; i<8; i++){aux++;}
												strcpy(yylval.valores, aux);
												return CODE;
											}

"(key): "{palavras_reservadas}				{	
												char *aux = yytext;
												int i;
												for(i=0; i<7; i++){aux++;}
												strcpy(yylval.valores, aux);
												return KEY;
											}

"\"type\": "{string}						{	
												char *aux = yytext;
												int i;
												for(i=0; i<8; i++){aux++;}
												strcpy(yylval.valores, aux);
												return TYPE;
											}

{palavras_reservadas}						{	
												strcpy(yylval.valores, yytext);
												return RESERVED;
											}

[a-zA-Z]+									{	strcpy(yylval.valores, yytext);
												return OBJECT;
											}

[,{}:\[\]"]									{	strcpy(yylval.valores, yytext);
												return (yytext[0]);
											}

[ \t\n]										;

.											{printf("Token invalido\n");}

%%