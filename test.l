%{
#include <stdio.h>
#include <string.h>
#include "test.tab.h"
void showError();
%}

numbers     ([0-9])+
alpha       ([a-zA-Z])+

%%
{alpha]     {sscanf(yytext, "%s", yyval.name); return (STRING);}
{numbers}   {yyval.number = atoi(yytext); return (NUM);}
";"         {return (SEMICOLON);}
.           {showError(); return(OTHER);}

%%

void showError() {
    printf("Other input\n");
}

