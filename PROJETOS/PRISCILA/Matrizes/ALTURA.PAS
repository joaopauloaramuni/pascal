PROGRAM MATRIZ_2;
USES CRT;
VAR MAIOR,MENOR,MEDIAG,MEDIAM,ALTURA,TOTAL,ALT:REAL;
    I,Z,A,B,CONTM,CONTF,TOTALGENTE:INTEGER;
    X:ARRAY[1..999,1..3] OF STRING[20];
    NOME:STRING[20];
    SEXO: CHAR;

BEGIN
ALT:=0;
MEDIAM:=0;
MEDIAG:=0;
TOTAL:=0;
TOTALGENTE:=0;
CONTF:=0;
CONTM:=0;
I:=1;
Z:=1;
B:=7;
MAIOR:=0;
MENOR:=999;
     WHILE(TRUE)DO
      BEGIN
       CLRSCR;
       GOTOXY(10,3);
       WRITE(' ');
       GOTOXY(10,4);
       WRITE('PROGRAMA ALTURAS...');
       GOTOXY(10,5);
       WRITE('PARA SAIR DIGITE FIM NO NOME');
       GOTOXY(10,7);
       WRITE('DIGITE O SEU NOME: ');
       READLN(NOME);
       GOTOXY(10,7);
       CLREOL;
       IF (NOME = 'FIM') OR (I=999) THEN BREAK;
        REPEAT
         GOTOXY(10,7);
         WRITE('DIGITE SEU SEXO F OU M: ');
         READLN(SEXO);
         GOTOXY(10,7);
         CLREOL;
         IF(SEXO<>'F') AND (SEXO<>'M')THEN
          BEGIN
           GOTOXY(10,7);
           WRITE('INCORRETO! DIGITE OUTRA VEZ');
           READKEY;
           GOTOXY(10,7);
           CLREOL;
          END;
         UNTIL(SEXO = 'F') OR (SEXO = 'M');
         REPEAT
          GOTOXY(10,7);
          WRITE('DIGITE SUA ALTURA: ');
          READLN(ALTURA);
          GOTOXY(10,7);
          CLREOL;
          IF (ALTURA<0) OR (ALTURA>2.5) THEN
           BEGIN
            GOTOXY(10,7);
            WRITE('INCORRETO! DIGITE OUTRA VEZ');
            READKEY;
            GOTOXY(10,7);
            CLREOL;
           END;
         UNTIL(ALTURA>0) AND (ALTURA<2.5);
         IF (ALTURA <= 1.80) THEN
          BEGIN
           X[I,1]:=NOME;
           X[I,2]:=SEXO;
           STR(ALTURA:3:2,X[I,3]);
          END;
         IF (SEXO = 'F') THEN
         CONTF:=CONTF+1
          ELSE IF (SEXO = 'M') THEN
           BEGIN
            CONTM:=CONTM+1;
            ALT:=ALT+ALTURA;
           END;
           IF (ALTURA>MAIOR) THEN
            MAIOR:=ALTURA;
           IF (ALTURA<MENOR)THEN
            MENOR:=ALTURA;

            TOTAL:=TOTAL + ALTURA;
            TOTALGENTE:=TOTALGENTE+1;
            I:=I+1;
     END;
     IF (CONTM>0)THEN
     MEDIAM:=ALT/CONTM;
     IF (TOTALGENTE>0)THEN
     MEDIAG:=TOTAL/TOTALGENTE;
     GOTOXY(10,7);
     WRITE('A MAIOR ALTURA ENCONTRADA FOI: ',MAIOR:3:2);
     GOTOXY(10,8);
     WRITE('A MENOR ALTURA ENCONTRADA FOI: ',MENOR:3:2);
     GOTOXY(10,9);
     WRITE('O NUMERO DE ATLETAS DO SEXO F ê: ',CONTF);
     GOTOXY(10,10);
     WRITE('A MEDIA DE ALTURA MASCULINA ê: ',MEDIAM:3:2);
     GOTOXY(10,11);
     WRITE('A MEDIA GERAL DE ALTURAS ê: ',MEDIAG:3:2);
     GOTOXY(10,12);
     WRITE(' ');
     GOTOXY(10,13);
     WRITE('PRESSIONE QUALQUER TECLA PARA VISUALIZAR A MATRIZ...');
     READKEY;
     CLRSCR;
     GOTOXY(10,3);
     WRITE(' ');
     GOTOXY(10,4);
     WRITE('PROGRAMA ALTURAS');
     FOR I:=1 TO (I-1) DO
     BEGIN
          FOR Z:=1 TO 3 DO
          BEGIN
               IF(Z=1)THEN
               BEGIN
               A:=10;
               GOTOXY(A,B);
               WRITE(X[I,Z]);
               END
               ELSE IF(Z=2)THEN
               BEGIN
               A:=A+10;
               GOTOXY(A,B);
               WRITE(X[I,Z]);
               END
               ELSE IF(Z=3)THEN
               BEGIN
               A:=A+10;
               GOTOXY(A,B);
               WRITE(X[I,Z]);
               B:=B+1;
               END;
          END;
       END;
       GOTOXY(10,B);
       WRITE(' ');
       GOTOXY(10,B+1);
       WRITE('PRESSIONE QUALQUE TECLA PARA SAIR...');
       READKEY;
END.