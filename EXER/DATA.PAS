PROGRAM DATA;
USES CRT;
VAR DIA,ANO:REAL;
    MES:STRING[10];
BEGIN
     CLRSCR;
     WRITE('Digite o dia: ');
     READLN(DIA);
     WRITE('Digite o màs: ');
     READLN(MES);
     WRITE('Digite o ano: ');
     READLN(ANO);
     WRITELN('Hoje s∆o ',DIA:2:0,' de ',MES,' de ',ANO:4:0);
     DELAY(5000);
END.