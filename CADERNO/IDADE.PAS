PROGRAM IDADE;
USES CRT;
VAR IDA:REAL;
    CONT,I:INTEGER;
BEGIN
     CLRSCR;
     I:=1;
     CONT:=0;
     WHILE(I<=10)DO
         BEGIN
           WRITE('DIGITE SUA IDADE: ');
           READLN(IDA);
             IF(IDA>18)THEN
             CONT:=CONT+1;
             I:=I+1;
         END;
     WRITELN('O N�MERO DE PESSOAS COM MAIS DE 18 ANOS �: ',CONT);
     DELAY(5000);
END.