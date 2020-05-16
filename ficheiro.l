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
time ([0-1]?[0-9]|2[0-3])\:[0-5][0-9]\:([0-5][0-9]|60)
	//data e hora em formato 2003-05-17 15:45:23
datetime {date}" "{time}
	//etgas 
etag (w\/)?(w\/)?[0-9a-z"]+

%%
					// chave : valor da chave

"\"kind\": "[a-zA-Z\"#]+ 					{return KIND;}

"\"etag\": "{etag}						{return	ETAG;}

"\"id\": "{integer}						{return ID;}

"\"name\": "{string}						{return NAME;}

"\"summary\": "{string}						{return SUMMARY;}

"\"backgroundColor\": "{hex_color}				{return BACKGROUNDCOLOR;}

"\"email\": "{email}						{return EMAIL;}

"\"location\": "{string}					{return LOCATION;}

"\"timeZone\": "{string}					{return TIMEZONE;}

"\"hidden\": "{boolean}						{return HIDDEN;}

"\"date\": "{date}						{return DATE;}

"\"createdon\": "{datetime}					{return CREATEDON;}

"\"url\": "{url}						{return URL;}

"\"Link\": "{url}						{return LINK;}

"\"time\": "{time}						{return	TIME;}

"\"additionalGuests\": "{integer}				{return ADD_GUEST;}

"\"code\": "{string}						{return CODE;}

"(key): "{palavras_reservadas}					{return KEY;}

"\"type\": "{string}						{return TYPE;}

{palavras_reservadas}						{return RESERVED;}

[a-zA-Z]+							{return OBJECT;}

[,{}:\[\]"]							{return (yytext[0]);}

[ \t\n]								;

.								{printf("Token invalido\n");}

%%
