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



