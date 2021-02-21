# Flex/Bison Tutorial

link: https://www.youtube.com/watch?v=pu0hX5lftQU  (sanwade)


## About the names

```
original unix came with YACC - yet another compiler compiler and LEX - lexcial analysis.
GNU created Bison and FLEX from these. 
(added this to explain the extensions on the files we use.)

```


## Install flex and bison (ubuntu)

```
 sudo apt-get update
 sudo apt-get install flex
 sudo apt-get install bison
 which flex  /*Sanity check to make sure flex is installed*/
 which bison /*Sanity check to make sure bison is installed*/
```

## about flex

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

## about bison

```
create a test.y   ( y == yacc)
```

Bison sections:

1. C declaration section - includes, forwards declarations, etc.
2. Token declaration - %token
3. Type declaration - breaks down tokens
4. Your union (yyval) declaration.


