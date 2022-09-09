PROGRAM SALARIO;
USES CRT;
VAR SAL,SALM:REAL;
BEGIN
     CLRSCR;
     WRITE('Digite o valor do sal rio: ');
     READLN(SAL);
     WRITE('Digite o valor do sal rio m¡nimo: ');
     READLN(SALM);
     WRITELN('Vocˆ ganha',(SAL/SALM):2:0,' sal rio(s) m¡nimos(s).');
     DELAY(5000);
END.