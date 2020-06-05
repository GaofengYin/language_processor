void htmlBegin();
void htmlEnd();
void style();
void beginTable();
void endTable();

void htmlBegin(){
	printf("<!DOCTYPE html>\n<html>\n<head>\n");
	style();
	printf("</head>\n");
	printf("<body>\n\n");
	printf("<h1>Google calendar info</h1>\n\n");
}
void beginTable(){
	printf("<table>\n");
}
void endTable(){
printf("</table>\n\n");
}
void htmlEnd(){
	printf("</body>\n");
	printf("</html>\n");
}
void style(){
	printf("<style>\n");
	printf("table {\n");
	printf("   font-family: arial, sans-serif;\n");
	printf("   border-collapse: collapse;\n");
	printf("   width: 100%%;\n}\n");
	printf("td, th {\n");
	printf("   border: 1px solid #dddddd;\n");
	printf("   text-align: left;\n");
	printf("   padding: 8px;\n}\n");
	printf("tr:nth-child(even) {\n");
	printf("background-color: #dddddd;\n}\n");
	printf("</style>\n");
}
