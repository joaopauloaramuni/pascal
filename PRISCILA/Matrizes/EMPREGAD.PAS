PROGRAM EMPREGADO;
USES CRT;

VAR MAT: ARRAY [1..99,1..4] OF STRING[20];
    REG, DIA, MES, ANO: REAL;
    I, J: INTEGER;
    REGC : STRING[3];
    DIAC, MESC: STRING[2];
    ANOC: STRING[4];

BEGIN

I:= 1;

    CLRSCR;
    WRITELN ('EMPRESA DELTA');

    WHILE (TRUE) DO
    BEGIN

       WRITELN ('DIGITE O NOME DO EMPREGADO: ');
       READLN (MAT[I,1]);

       IF (MAT[I,1] = 'FIM') OR (MAT[I,1] = 'fim')
         THEN BREAK;


       REPEAT
        WRITELN ('DIGITE O REGISTRO DO EMPREGADO: ');
        READLN (REG);
       UNTIL (REG >= 0) AND (REG <= 999) AND (REG = INT(REG));

       STR (REG:0:0, REGC);

       IF (REG <= 9)
          THEN MAT[I,2] := '00' + REGC
          ELSE IF (REG >= 10) AND (REG <= 99)
                  THEN MAT[I,2] := '0' + REGC
                  ELSE MAT[I,2] := REGC;

       REPEAT
          WRITELN ('DIGITE O DIA: ');
          READLN (DIA);
       UNTIL (DIA >= 1) AND (DIA <= 31) AND (DIA = INT(DIA));

       REPEAT
          WRITELN ('DIGITE O MES: ');
          READLN (MES);
       UNTIL (MES >= 1) AND (MES <= 12) AND (MES = INT(MES));

       REPEAT
          WRITELN ('DIGITE O ANO: ');
          READLN (ANO);
      UNTIL (ANO >= 1960) AND (ANO <= 2010) AND (ANO = INT (ANO));

      STR (DIA:2:0, DIAC);
      STR (MES:2:0, MESC);
      STR (ANO:4:0, ANOC);

      MAT[I,3] := DIAC + '/' + MESC + '/' + ANOC;
      MAT[I,4] := ANOC;

    I:= I + 1;

    END;

    CLRSCR;

    WRITELN ('RESULTADOS FINAIS');
    WRITELN;
    WRITELN ('NOME         REGISTRO        DATA ADMISSAO');

    FOR J:= 1 TO I-1 DO
    BEGIN
       IF (MAT[J,4] = '2009') THEN
         BEGIN
            WRITELN (MAT[J,1], '           ', MAT[J,2], '           ', MAT[J,3]);
         END;
    END;


READKEY;
END.
