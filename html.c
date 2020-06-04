void htmlBegin();
void htmlEnd();
void style();

void htmlBegin(){
	printf("<!DOCTYPE html>\n<html>\n<head>\n");
	printf("<title>Google calendar info</title>\n");
	style();
	printf("</head>\n<body>\n");
	printf("<h2>HTML Table</h2>\n");
	printf("<table>\n");
}
void htmlEnd(){
	printf("</table>\n</body>\n</html>\n");
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