/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    KIND = 258,
    ETAG = 259,
    ID = 260,
    SUMMARY = 261,
    NAME = 262,
    BACKGROUNDCOLOR = 263,
    TYPE = 264,
    EMAIL = 265,
    LOCATION = 266,
    KEY = 267,
    TIMEZONE = 268,
    TIME = 269,
    HIDDEN = 270,
    RESERVED = 271,
    OBJECT = 272,
    LINK = 273,
    DATE = 274,
    CREATEDON = 275,
    URL = 276,
    ADD_GUEST = 277,
    CODE = 278
  };
#endif
/* Tokens.  */
#define KIND 258
#define ETAG 259
#define ID 260
#define SUMMARY 261
#define NAME 262
#define BACKGROUNDCOLOR 263
#define TYPE 264
#define EMAIL 265
#define LOCATION 266
#define KEY 267
#define TIMEZONE 268
#define TIME 269
#define HIDDEN 270
#define RESERVED 271
#define OBJECT 272
#define LINK 273
#define DATE 274
#define CREATEDON 275
#define URL 276
#define ADD_GUEST 277
#define CODE 278

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 12 "ficheiro.y" /* yacc.c:1909  */
char valores[100];

#line 103 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
