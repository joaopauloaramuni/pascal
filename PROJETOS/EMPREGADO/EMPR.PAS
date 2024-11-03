PROGRAM EMPREGADO;
USES CRT;
VAR
    I,J,A:INTEGER;
    NOME,COD:STRING[20];
    FSAL,PECAS,SOMA,MEDIA:REAL;
    FCOD:BOOLEAN;
    X:ARRAY[1..100,1..3]of string[20];

FUNCTION FUNCAOSAL(PECAS:REAL):real;
var SALARIO:real;
begin
if(PECAS>=0)AND(PECAS<=200)THEN
SALARIO:=PECAS*2;
if(PECAS>=201)AND(PECAS<=400)THEN
SALARIO:=PECAS*2.3;
if(PECAS>400)THEN
SALARIO:=PECAS*2.5;

FUNCAOSAL:=SALARIO;

END;

FUNCTION CODIGO(COD:string):boolean;
var A1,A2,A3,Z:integer;
    B:char;
begin

B:=COD[1];
B:=UPCASE(B);
if(NOT(B IN ['A'..'Z']))then

CODIGO:=FALSE;

B:=COD[2];
B:=UPCASE(B);
if(NOT(B IN ['A'..'Z']))then

CODIGO:=FALSE;

         val(COD[3],A1,Z);
         val(COD[4],A2,Z);
         val(COD[5],A3,Z);

if(Z=1)then

CODIGO:=FALSE;

end;

BEGIN
SOMA:=0;
I:=1;
A:=12;
WHILE(TRUE)DO
BEGIN
CLRSCR;
GOTOXY(10,5);
WRITE('Programa Empregados');
repeat
GOTOXY(10,10);
WRITE('Digite o seu nome: ');
READLN(NOME);
GOTOXY(10,10);
CLREOL;
until(NOME<>'');

IF(NOME='FIM')or(NOME='fim')THEN
BREAK;

X[I,1]:=NOME;

repeat
FCOD:=TRUE;
GOTOXY(10,10);
WRITE('Digite o codigo: ');
READLN(COD);
GOTOXY(10,10);
CLREOL;
FCOD:=CODIGO(COD);
until(FCOD<>FALSE)AND(COD<>'')AND(LENGTH(COD)=5);

repeat
GOTOXY(10,10);
WRITE('Digite o numero de pecas: ');
READLN(PECAS);
GOTOXY(10,10);
CLREOL;
until(PECAS>=0)AND(PECAS=INT(PECAS));

FSAL:=FUNCAOSAL(PECAS);

SOMA:=SOMA+FSAL;

STR(FSAL:5:2,X[I,2]);

MEDIA:=SOMA/(I);

I:=I+1;

END;

FOR J:=1 TO (I-1)DO
BEGIN
str(MEDIA:5:2,X[J,3]);
END;

IF(I<>1)THEN

begin
GOTOXY(10,10);
WRITE('NOME');
GOTOXY(30,10);
WRITE('SALARIO');
GOTOXY(50,10);
WRITE('MEDIA');
FOR J:=1 TO (I-1)DO
BEGIN
GOTOXY(10,A);
WRITE(X[J,1]);
GOTOXY(30,A);;
WRITE(X[J,2]);
GOTOXY(50,A);
WRITE(X[J,3]);
A:=A+1;
END;

end;
GOTOXY(10,A+4);
WRITE('TOTAL: ',SOMA:5:2);
GOTOXY(10,A+8);
WRITE('Pressione qualquer tecla para sair...');
READKEY;
END.
