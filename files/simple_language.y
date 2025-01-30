%{
#include <iostream>
#include <string>
#include <map>
extern int yylineno;
static std::map<std::string, int> vars;
inline void yyerror(const char *str) {
    std::cerr << "Error de sintaxis: " << str << " en línea " << yylineno << std::endl;
}
int yylex();
%}

%union { int num; std::string *str; }

%token<num> NUMBER
%token<str> ID
%type<num> expression
%type<num> assignment

%right '='
%left '*' '/'
%left '+' '-'
%nonassoc '(' ')'

%%

program: statement_list
    | error {
       yyerror("Error de sintaxis: Token inesperado.");
       yyclearin;
       yyerrok;
    }
    ;

statement_list: statement
    | statement_list statement
    ;

statement: assignment ':'
    | expression ':' { std::cout << $1 << std::endl; }
    ;

assignment: ID '=' expression
    { 
        printf("Assign %s = %d\n", $1->c_str(), $3); 
        $$ = vars[*$1] = $3; 
        delete $1;
    }
    ;

expression: NUMBER                  { $$ = $1; }
    | ID {
        if (vars.find(*$1) == vars.end()) {
            yyerror(("Error semántico: Variable '" + *$1 + "' no declarada.").c_str());
            $$ = 0;
        } else {
            $$ = vars[*$1];
        }
        delete $1;
    }
    | expression '+' expression     { $$ = $1 + $3; }
    | expression '-' expression     { $$ = $1 - $3; }
    | expression '*' expression     { $$ = $1 * $3; }
    | expression '/' expression     { $$ = $1 / $3; }
    | '('expression')'              { $$ = $2; }
    ;

%%

int main() {
    yyparse();
    return 0;
}