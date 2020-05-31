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

"\"kind\": "\"{kind}\" 						{	strcpy(yylval.valores, yytext);
												return KIND;
											}

"\"etag\": "{etag}							{	strcpy(yylval.valores, yytext);
												return	ETAG;
											}

"\"id\": "{integer}							{	strcpy(yylval.valores, yytext);
												return ID;
											}

"\"name\": "{string}						{	strcpy(yylval.valores, yytext);	
												return NAME;
											}

"\"summary\": "{string}						{	strcpy(yylval.valores, yytext);
												return SUMMARY;
											}

"\"backgroundColor\": "{hex_color}			{	strcpy(yylval.valores, yytext);
												return BACKGROUNDCOLOR;
											}

"\"email\": "{email}						{	strcpy(yylval.valores, yytext);	
												return EMAIL;
											}

"\"location\": "{string}					{	strcpy(yylval.valores, yytext);	
												return LOCATION;
											}

"\"timeZone\": "{string}					{	strcpy(yylval.valores, yytext);	
												return TIMEZONE;
											}

"\"hidden\": "{boolean}						{	strcpy(yylval.valores, yytext);
												return HIDDEN;
											}

"\"date\": "{date}							{	strcpy(yylval.valores, yytext);
												return DATE;
											}

"\"createdon\": "{datetime}					{	strcpy(yylval.valores, yytext);
												return CREATEDON;
											}

"\"url\": "{url}							{	strcpy(yylval.valores, yytext);
												return URL;
											}

"\"Link\": "{url}							{	strcpy(yylval.valores, yytext);
												return LINK;
											}

"\"time\": "{time}							{	strcpy(yylval.valores, yytext);	
												return	TIME;
											}

"\"additionalGuests\": "{integer}			{	strcpy(yylval.valores, yytext);
												return ADD_GUEST;
											}

"\"code\": "{string}						{	strcpy(yylval.valores, yytext);
												return CODE;
											}

"(key): "{palavras_reservadas}				{	strcpy(yylval.valores, yytext);
												return KEY;
											}

"\"type\": "{string}						{	strcpy(yylval.valores, yytext);
												return TYPE;
											}

{palavras_reservadas}						{	strcpy(yylval.valores, yytext);
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