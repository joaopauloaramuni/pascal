PROGRAM PASSAGENS;
USES CRT;
VAR
   CIDA: ARRAY[1..20] OF STRING[25];
   DIST: ARRAY[1..20] OF REAL;
   A:STRING[25];
   J,I:INTEGER;
BEGIN
CLRSCR;
I:=1;
J:=0;
WHILE(TRUE)DO
  BEGIN
   CLRSCR;
   WRITELN('');
   WRITELN('PROGRAMA PASSAGENS AEREAS');
   WRITELN('Digite FIM no nome da cidade para sair');
  REPEAT
    WRITELN('Digite o nome da cidade desejada: ');
    READLN(CIDA[I]);
  UNTIL(CIDA[I]<>'');
   IF (I=20) OR (CIDA[I]='FIM')
    THEN BREAK;
     REPEAT
      WRITELN('Digite a distancia: ');
      READLN(DIST[I]);
     UNTIL(DIST[I]>=100);
      I:=I+1;
END;
    WRITELN('Digite o nome da cidade a ser procurada: ');
    READLN(A);
    FOR I:=1 TO 20 DO
      BEGIN
       IF (CIDA[I]=A)THEN
          BEGIN
           J:=1;
           WRITELN('O Preco da passagem ‚: ',(DIST[I]*0.87):4:0);
           WRITELN('O Tempo de voo ‚: ',(800/DIST[I]):2:1);
           WRITELN('O numero de escalas do percurso ‚: ',(INT(DIST[I])/2400):4:0);
          END;
   END;
   IF(J=0)THEN
   WRITELN('Cidade Incorreta');
READKEY;
END.