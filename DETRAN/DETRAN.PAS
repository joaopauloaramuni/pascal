PROGRAM DETRAN;
USES CRT;
VAR  MAT:ARRAY[1..999,1..3]OF STRING[10];
     TOTAL,MULTA,MEDIA,X1,X2,X3:REAL;
     PLACA:STRING[7];
     DATA:STRING[10];
     R1,R2,R3,SAIR:STRING;
     PL,Z,A,B,I,C:INTEGER;

PROCEDURE ERRADO(Y:REAL);
BEGIN
  GOTOXY(20,9);
  WRITE('O VALOR ESTA INCORRETO, DIGITE OUTRA VEZ!');
  READKEY;
  GOTOXY(20,9);
  CLREOL;
END;
PROCEDURE BARRA(X:STRING);
BEGIN
 IF(X[3]<>'/')OR(X[6]<>'/')THEN
   BEGIN
    GOTOXY(15,7);
    WRITE('Digite a data como no exemplo: 01/01/2000...');
    READKEY;
    GOTOXY(15,7);
    CLREOL;
   END;
END;
PROCEDURE DAT(X:REAL);
BEGIN
 IF(X<1) OR (X>31)THEN
  BEGIN
   GOTOXY(15,7);
   WRITE('O VALOR ',X:2:0,' PARA O DIA ESTA INCORRETO, DIGITE OUTRA VEZ!');
   READKEY;
   GOTOXY(15,7);
   CLREOL;
  END;
END;
PROCEDURE DAT2(X:REAL);
BEGIN
 IF(X<1) OR (X>12)THEN
  BEGIN
   GOTOXY(15,7);
   WRITE('O VALOR ',X:2:0,' PARA O MES ESTA INCORRETO, DIGITE OUTRA VEZ!');
   READKEY;
   GOTOXY(15,7);
   CLREOL;
  END;
END;
PROCEDURE DAT3(X:REAL);
BEGIN
 IF(X<1980) OR (X>2008)THEN
  BEGIN
   GOTOXY(15,7);
   WRITE('O VALOR ',X:4:0,' PARA O ANO ESTA INCORRETO, DIGITE OUTRA VEZ!');
   READKEY;
   GOTOXY(15,7);
   CLREOL;
 END;
END;
BEGIN
 TOTAL:=0;
 I:=1;
 C:=10;
 WHILE(TRUE)DO
  BEGIN
   CLRSCR;
   GOTOXY(27,3);
   WRITELN(' ');
   GOTOXY(27,4);
   WRITELN('** PROGRAMA DETRAN **');
   WRITELN(' ');
   IF(I>1)THEN
    BEGIN
     GOTOXY(20,6);
     WRITELN('Deseja visualizar os resultados finais?');
     GOTOXY(20,7);
     READLN(SAIR);
     GOTOXY(20,7);
     CLREOL;
     GOTOXY(20,6);
     CLREOL;
      IF(SAIR='SIM')OR(SAIR='S')OR(SAIR='sim')OR(SAIR='s')
      THEN BREAK;
    END;
    REPEAT
     GOTOXY(25,6);
     WRITELN('Digite a placa do veiculo:');
     GOTOXY(25,7);
     READLN(PLACA);
     GOTOXY(25,7);
     CLREOL;
     GOTOXY(25,6);
     CLREOL;
     PL:=LENGTH(PLACA);
     IF(PL<>7)THEN
      ERRADO(PL);
    UNTIL(PL=7);
    MAT[I,1]:=PLACA;
    REPEAT
     GOTOXY(25,6);
     WRITE('Digite a data da multa:');
     GOTOXY(25,7);
     READLN(DATA);
     GOTOXY(25,7);
     CLREOL;
     GOTOXY(25,6);
     CLREOL;
     BARRA(DATA);
     IF(DATA[3]='/')AND(DATA[6]='/')THEN
     BEGIN
      R1:=DATA[1]+DATA[2];
      VAL(R1,X1,Z);
      DAT(X1);
      R2:=DATA[4]+DATA[5];
      VAL(R2,X2,Z);
      DAT2(X2);
      R3:=DATA[7]+DATA[8]+DATA[9]+DATA[10];
      VAL(R3,X3,Z);
      DAT3(X3);
     END;
    UNTIL(DATA[3]='/')AND(DATA[6]='/')AND(X1>=1)AND(X1<=31)AND(X2>=1)AND(X2<=12)
    AND(X3>=1980)AND(X3<=2008);
    MAT[I,2]:=DATA;
    REPEAT
     GOTOXY(25,6);
     WRITE('Digite o valor da multa:');
     GOTOXY(25,7);
     READLN(MULTA);
     GOTOXY(25,7);
     CLREOL;
     GOTOXY(25,6);
     CLREOL;
     IF(MULTA<0)THEN
      ERRADO(MULTA);
    UNTIL(MULTA>=0);
    STR(MULTA:5:2,MAT[I,3]);
    TOTAL:=TOTAL+MULTA;
    I:=I+1;
  END;
  MEDIA:=TOTAL/(I-1);
  GOTOXY(20,6);
  WRITELN('A MEDIA DE VALOR DAS MULTAS: ',MEDIA:5:2);
  GOTOXY(20,8);
  WRITELN('*PLACA*');
  GOTOXY(30,8);
  WRITELN('*DATA*');
  GOTOXY(45,8);
  WRITELN('*VALOR*');
  FOR A:=1 TO (I-1)DO
   BEGIN
    FOR B:=1 TO 3 DO
     BEGIN
      IF (B=1) THEN
       BEGIN
        GOTOXY(20,C);
        WRITE(MAT[A,1]);
       END
       ELSE IF(B=2)THEN
              BEGIN
               GOTOXY(30,C);
               WRITE(MAT[A,2]);
              END
      ELSE IF(B=3)THEN
             BEGIN
              GOTOXY(45,C);
              WRITE(MAT[A,3]);
              C:=C+1;
             END;
    END;
 END;
 GOTOXY(20,C+1);
 WRITELN('TOTAL ',TOTAL:5:2);
 GOTOXY(20,C+3);
 WRITE('Pressione qualquer tecla para sair...');
 READKEY;
END.