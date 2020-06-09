void htmlBegin();
void htmlEnd();
void style();
void beginTable();
void endTable();
void corDaLetra();
void contadorDeIdenty();

void htmlBegin(){
	printf("<!DOCTYPE html>\n<html>\n<head>\n");
	style();
	printf("</head>\n");
	printf("<body style=\"background-color:rgb(192, 192, 192)\">\n\n");
	printf("<h1>Google calendar info</h1>\n\n");
}
void beginTable(){
	printf("<details>\n<summary>SPOILER</summary>\n");
	printf("<table class=\"center\">\n");
}
void endTable(){
	printf("</table>\n\n");
	printf("</details>\n");
}
void htmlEnd(){
	printf("</body>\n");
	printf("</html>\n");
}
void style(){
	printf("<style>\n");
	printf("h1, p, summary {text-align: center;}\n");
	printf("table {\n");
	printf("   font-family: arial, sans-serif;\n");
	printf("   border-collapse: collapse;\n");
	printf("   width: 40%%;\n}\n");
	printf("   table.center {\n");
	printf("   margin-left: auto;\n");
	printf("   margin-right: auto;\n}\n");
	printf("td, th {\n");
	printf("   border: 1px solid #dddddd;\n");
	printf("   text-align: left;\n");
	printf("   padding: 8px;\n}\n");
	printf("tr:nth-child(even) {\n");
	printf("background-color: #dddddd;\n}\n");
	printf("</style>\n");
}

void contadorDeIdenty(int i){
	printf("<h1>Numero de chaves %d</h1>\n",i);
}

void corDaLetra(char *str){
	printf("<p style=\"color:%s;\">O valor em hexadecimal para colorir este paragrafo foi retirado da tabela acima. gri gri gri</p>\n",str);
}
