# Flex/Bison Tutorial

link to source tutorial I used: https://www.youtube.com/watch?v=pu0hX5lftQU  (sanwade)

## Why do this?

```
Its been a long time since I have used yacc and lex. So long in fact they were still called yacc and lex :-)

I have been looking at some parsing compilation approaches, and needed a refresher.  I have written a number of 
lexical analyzers --> parsers by hand, but it rapidly becomes complex and better tools are needed.

So, I found this (relatively) simple example online, and thought to give a try.

The development environment is ubuntu, I already do C++ development on it so all my C like tools are in place.
(Needed to grab bison and flex, see below)
```

## About the names

```
original unix came with YACC - yet another compiler compiler and LEX - lexcial analysis.
GNU created Bison and FLEX from these. 
(added this to explain the extensions on the files we use.)

```

## Install flex and bison (ubuntu)

I didn't have these in my C++ Dev box, so I grabbed them.

```
 sudo apt-get update
 sudo apt-get install flex
 sudo apt-get install bison
 which flex  /*Sanity check to make sure flex is installed*/
 which bison /*Sanity check to make sure bison is installed*/
```

## About flex

```
create a test.l (l == lex) 
```

Lex code has four (4) major sections

1. Stuff related to C; includes, external declarations, forward declarations etc
2. Regular expressions - patterns for regular inputs
3. Token specifications - maps matches to tokens
4. Any C functions  - should be related to lexical errors/handling.

```
yytext - happens to be the varible you get when you enter anything into the lex 
yyval - this is the union you will declare in your y file below.  
```

## about bison

```
create a test.y   ( y == yacc)
```

Bison sections:

1. C declaration section - includes, forwards declarations, etc.
2. Token declaration - %token
3. Type declaration - breaks down tokens
4. Your union (yyval) declaration.
5. Grammer...

### Grammer

```

Tokens -
 - Number (NUM)  :  [0-9]+
 - Operation (OP): [+,-,*,/]
 - Equal (EQU)   : [=]

So, what about:

// recognize equation?
12 + 5 = 17
NUM + NUM = NUM

But maybe not +, could be another.. so 

NUM OP NUM = NUM

But, = ? lets token that too

NUM OP NUM EQU NUM

But, there is a problem.

12 + 5 = 6 + 11

The grammer wont handle that
Need:

NUM OP NUM EQU NUM OP NUM

Will not work for both.

Ok, so how do we manage this?

Lets define, based on previous, and apply an OR (|):
- Statement (STMT) : NUM OP NUM | NUM

Ok, so STMT EQU STMT covers our previous examples

What about:

12+5+1+1 = 16+1

STMT OP STMT EQU STMT


This becomes

STMT EQU STMT

Hmm. A better solution is:

- Statement (STMT) : STMT OP NUM | NUM


```

### Specific grammer for test

```

STMTS : | STMT SEMICOLON STMTS 
STRING
NUM
OTH
SEMICOLON
STMT : STRING | NUM | OTH

Then we scan for STMTS....

NOTE:  ": |"  means Null is ok.
```


Note about the $# naming...

```
 28 stmt:
 29     STRING {
 30         printf("You entered a string - %s\n", $1);
 31     }

Why $1?
Imagine it was :
 28 stmt:
         $1     $2   $3
 29     STRING NUM STRING {
 30         printf("You entered a string - %s\n", $1);
 31     }
```

### Finishing up

Add the error handler and a main to the yacc (bison) file:

```

int yyerror(char *s) 
{
    printf("Syntax Error on line %s\n", s); 
    return 0;
}

int main()
{
    yyparse();
    return 0;
}

```

Add a Makefile:

```
$ cat Makefile 
default:
	clear
	flex -l test.l
	bison -dv test.y 
	gcc -o test test.tab.c lex.yy.c -lfl
```

Note the files you actually need are:

```
  Makefile
  test.l
  test.y
```
Everything else is an artifact of compilation.

# not a terrible way to spend a Sunday afternoon :-)

