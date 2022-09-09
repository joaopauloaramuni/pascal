PROGRAM NOTA;
USES CRT;
VAR N1,N2,N3:REAL;
BEGIN
     CLRSCR;
     WRITE('Digite o primeiro numero: ');
     READLN(N1);
     WRITE('Digite o segundo numero: ');
     READLN(N2);
     WRITE('Digite o terceiro numero: ');
     READLN(N3);
     WRITELN('MEDIA:',((N1+N2+N3)/3):6:0);
     DELAY(5000);
END.

