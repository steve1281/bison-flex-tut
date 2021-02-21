# Flex/Bison Tutorial

link: https://www.youtube.com/watch?v=pu0hX5lftQU  (sanwade)


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




