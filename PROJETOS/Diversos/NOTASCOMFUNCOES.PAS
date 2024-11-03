PROGRAM ALUNOS_FUMEC;
USES CRT;

TYPE NOTAS = RECORD
  NUM : REAL;
  NOME: STRING[30];
  N1, N2: REAL;
  FLAG: CHAR;
END;

ARQUIVO = FILE OF NOTAS;

VAR
   ARQ, AUX : ARQUIVO;
   REG, AUXREG : NOTAS;
   NUM, N1, N2: REAL;
   NOME: STRING[30];
   OP, I, J, K, POSICAO: INTEGER;
   ACHOU, RETORNO: BOOLEAN;


PROCEDURE ABRE_ARQ; {ESSA PROCEDURE E CHAMADA TODA VEZ QUE SE DESEJA ABRIR UM ARQUIVO}
BEGIN
    ASSIGN (ARQ, 'BD.DAT');
    (*$I-*);
    RESET (ARQ);
    (*$I+*);

    IF (IORESULT <> 0) THEN
      BEGIN
         WRITELN ('O ARQUIVO AINDA NAO EXISTE NO DISCO. SERA CRIADO AGORA');
         REWRITE (ARQ);
         WRITELN ('ARQUIVO CRIADO. PRESSIONE QUALQUER TECLA...');
         READKEY;
      END;

END;

PROCEDURE ABRE_ARQ_AUX;
BEGIN

    ASSIGN (AUX, 'AUXILIA.DAT');
    (*$I-*);
    RESET (AUX);
    (*$I+*);

    IF (IORESULT <> 0) THEN
      BEGIN
         WRITELN ('O ARQUIVO AUXILIAR AINDA NAO EXISTE NO DISCO. SERA CRIADO AGORA');
         REWRITE (AUX);
         WRITELN ('ARQUIVO CRIADO. PRESSIONE QUALQUER TECLA...');
         READKEY;
      END;

END;

PROCEDURE FECHA_ARQ; {PROCEDURE CHAMADA TODA VEZ QUE SE DESEJA FECHAR UM ARQUIVO}
BEGIN
  CLOSE (ARQ);
END;

PROCEDURE FECHA_ARQ_AUX; {PROCEDURE CHAMADA TODA VEZ QUE SE DESEJA FECHAR UM ARQUIVO}
BEGIN
  CLOSE (AUX);
END;

FUNCTION INCLUI : BOOLEAN;
BEGIN

  K := FILESIZE (ARQ);
  ACHOU := FALSE;

  WRITE ('DIGITE A MATRICULA DO ALUNO: ');
  READLN (NUM);

  WRITE ('DIGITE O NOME DO ALUNO: ');
  READLN (NOME);

  WRITE ('DIGITE A NOTA 1: ');
  READLN (N1);

  WRITE ('DIGITE A NOTA 2: ');
  READLN (N2);

  IF (K = 0) THEN
   BEGIN
     SEEK (ARQ, K);
     REG.NUM := NUM;
     REG.NOME := NOME;
     REG.N1 := N1;
     REG.N2 := N2;
     WRITE (ARQ, REG);
     INCLUI := TRUE;
   END
    ELSE
       BEGIN
          I:= 0;

          WHILE (I <= (K-1)) DO
          BEGIN
           SEEK (ARQ, I);
           READ (ARQ, REG);

           IF (REG.NUM = NUM) THEN
             BEGIN
                ACHOU := TRUE;
                I:= K + 1;
             END {DO IF}
              ELSE I := I + 1;

          END; {DO WHILE}

       END; {DO ELSE}

       IF (ACHOU = TRUE) THEN
        BEGIN
         WRITELN ('ALUNO JA EXISTENTE. O REGISTRO NAO FOI GRAVADO');
         WRITELN;
         INCLUI := FALSE;
        END
         ELSE
          BEGIN
             SEEK (ARQ, K);
             REG.NUM := NUM;
             REG.NOME := NOME;
             REG.N1 := N1;
             REG.N2 := N2;
             WRITE (ARQ, REG);
             INCLUI := TRUE;
          END;


END;

FUNCTION ALTERA : BOOLEAN;
VAR OP: CHAR;
BEGIN

  K := FILESIZE (ARQ);
  ACHOU := FALSE;

  WRITE ('DIGITE A MATRICULA DO ALUNO QUE DESEJA ALTERAR: ');
  READLN (NUM);

  IF (K = 0) THEN
   BEGIN
     WRITELN ('O ARQUIVO ESTA VAZIO. NAO E POSSIVEL ALTERAR NENHUM DADO');
   END
    ELSE
       BEGIN
          I:= 0;
          J:= 0;
          WHILE (I <= (K-1)) DO
          BEGIN
           SEEK (ARQ, I);
           READ (ARQ, REG);
           IF (REG.NUM = NUM) THEN
             BEGIN
                ACHOU := TRUE;
                POSICAO:= I;
                I:= K + 1;
             END {DO IF}
              ELSE I := I + 1;

          END; {DO WHILE}

       END; {DO ELSE}

       IF (ACHOU = TRUE) THEN
        BEGIN

         REPEAT
           WRITELN ('QUAL CAMPO DESEJA ALTERAR?');
           WRITELN ('(N) NOME');
           WRITELN ('(1) NOTA 1');
           WRITELN ('(2) NOTA 2');
           WRITELN;
           READLN (OP);
         UNTIL (UPCASE(OP) = 'N') OR (OP = '1') OR (OP = '2');

         IF (OP = 'N') THEN
            BEGIN
              WRITELN ('DIGITE O NOVO NOME: ');
              READLN (NOME);
              SEEK (ARQ, POSICAO);
              REG.NOME := NOME;
              WRITE (ARQ, REG);
              ALTERA := TRUE;
            END;

         IF (OP = '1') THEN
            BEGIN
              WRITELN ('DIGITE A NOVA NOTA 1: ');
              READLN (N1);
              SEEK (ARQ, POSICAO);
              REG.N1 := N1;
              WRITE (ARQ, REG);
              ALTERA := TRUE;
            END;

         IF (OP = '2') THEN
            BEGIN
              WRITELN ('DIGITE A NOVA NOTA 2: ');
              READLN (N2);
              SEEK (ARQ, POSICAO);
              REG.N2 := N2;
              WRITE (ARQ, REG);
              ALTERA := TRUE;
            END;

        END;
END;

FUNCTION EXCLUI_LOGICA: BOOLEAN;
BEGIN

   I:= 0;
   K:= FILESIZE (ARQ);
   ACHOU := FALSE;

   WRITELN ('DIGITE O NUMERO DA MATRICULA QUE DESEJA DELETAR: ');
   READLN (NUM);

   WHILE (I <= (K-1)) DO {ESSE WHILE SERVE PARA VERIFICAR SE NUM EXISTE}
   BEGIN
     SEEK (ARQ, I);
     READ (ARQ, REG);

     IF (REG.NUM = NUM)
       THEN BEGIN
             REG.FLAG := 'X';
             WRITE (ARQ, REG);
             I:= K + 1;
             ACHOU := TRUE;
            END
             ELSE I:= I + 1;
   END;

   IF (ACHOU = TRUE) THEN
    BEGIN
      EXCLUI_LOGICA := TRUE;
    END;

END;

FUNCTION EXCLUI : BOOLEAN;
BEGIN

   REWRITE (AUX);
   I:= 0;
   K:= FILESIZE (ARQ);
   ACHOU := FALSE;

   WRITELN ('DIGITE O NUMERO DA MATRICULA QUE DESEJA DELETAR: ');
   READLN (NUM);

   WHILE (I <= (K-1)) DO {ESSE WHILE SERVE PARA VERIFICAR SE NUM EXISTE}
   BEGIN
     SEEK (ARQ, I);
     READ (ARQ, REG);

     IF (REG.NUM = NUM)
       THEN BEGIN
             POSICAO := I;
             I:= K + 1;
             ACHOU := TRUE;
            END
            ELSE I:= I + 1;
   END;


   IF (ACHOU = TRUE) THEN
   BEGIN

    J:= 0;
    I:= 0;
    WHILE (J < POSICAO) DO
      BEGIN
         SEEK (ARQ, J);
         READ (ARQ, REG);
         SEEK (AUX, I);
         AUXREG.NUM := REG.NUM;
         AUXREG.NOME := REG.NOME;
         AUXREG.N1 := REG.N1;
         AUXREG.N2 := REG.N2;
         WRITE (AUX, AUXREG);
         J := J + 1;
         I := I + 1;
      END;

    K := POSICAO + 1;

    WHILE (K <= (FILESIZE(ARQ)-1)) DO
      BEGIN
         SEEK (ARQ, K);
         READ (ARQ, REG);
         SEEK (AUX, I);
         AUXREG.NUM := REG.NUM;
         AUXREG.NOME := REG.NOME;
         AUXREG.N1 := REG.N1;
         AUXREG.N2 := REG.N2;
         WRITE (AUX, AUXREG);
         K := K + 1;
         I := I + 1;
      END;

    END;

    REWRITE (ARQ); {APAGUEI TODO O CONTEUDO DE ARQ PARA SUBSTITUIR POR AUX}
    RESET (AUX);
    I:= 0;

    WHILE NOT EOF (AUX) DO
    BEGIN
     SEEK (AUX, I);
     READ (AUX, AUXREG);
     REG.NUM := AUXREG.NUM;
     REG.NOME := AUXREG.NOME;
     REG.N1 := AUXREG.N1;
     REG.N2 := AUXREG.N2;
     WRITE (ARQ, REG);
     I := I + 1;
     EXCLUI := TRUE;
   END;


END;

PROCEDURE CONSULTA;
BEGIN

I:= 0;

  WHILE NOT EOF (ARQ) DO
   BEGIN
     SEEK (ARQ, I);
     READ (ARQ, REG);

     IF (REG.FLAG <> 'X') THEN
     BEGIN
       WRITELN ('MATRICULA .....: ', REG.NUM:5:0);
       WRITELN ('NOME ..........: ', REG.NOME);
       WRITELN ('NOTA 1 ........: ', REG.N1:5:1);
       WRITELN ('NOTA 2 ........: ', REG.N2:5:1);
       WRITELN ('FLAG ..........: ', REG.FLAG);
       WRITELN;
       I:= I + 1;
     END;

  END;
END;

PROCEDURE CONSULTA_ESP;
BEGIN

I:= 0;
ACHOU := FALSE;

WRITELN ('DIGITE O NUMERO DA MATRICULA QUE DESEJA PESQUISAR: ');
READLN (NUM);

  WHILE NOT EOF (ARQ) DO
   BEGIN
     SEEK (ARQ, I);
     READ (ARQ, REG);

     IF (REG.NUM = NUM) THEN
     BEGIN
       WRITELN ('MATRICULA .....: ', REG.NUM:5:0);
       WRITELN ('NOME ..........: ', REG.NOME);
       WRITELN ('NOTA 1 ........: ', REG.N1:5:1);
       WRITELN ('NOTA 2 ........: ', REG.N2:5:1);
       WRITELN;
       ACHOU := TRUE;
     END;
       I:= I + 1;
  END;
  IF (ACHOU = FALSE)
    THEN BEGIN
           WRITELN ('O REGISTRO PESQUISADO NAO FOI ENCONTRADO');
           WRITELN ('PRESSIONE QUALQUER TECLA');
           READKEY;
           CLRSCR;
         END;
END;


BEGIN {PROGRAMA PRINCIPAL}

CLRSCR;
WRITELN ('             NOTAS DE ALUNOS - FUMEC');
WRITELN;
WRITELN;

  WHILE (TRUE) DO
  BEGIN
      WRITELN ('DIGITE A OPCAO DESEJADA: ');
      WRITELN ('1 - INCLUSAO');
      WRITELN ('2 - EXCLUSAO FISICA');
      WRITELN ('3 - CONSULTA GERAL');
      WRITELN ('4 - CONSULTA ESPECIFICA');
      WRITELN ('5 - ALTERAR REGISTRO');
      WRITELN ('6 - EXCLUSAO LOGICA');
      WRITELN ('0 - SAIR');
      WRITE ('--> ');
      READLN (OP);

      IF (OP = 0)
        THEN BREAK
          ELSE IF (OP = 1) THEN
                BEGIN
                   ABRE_ARQ;
                   RETORNO := INCLUI;
                   FECHA_ARQ;

                   IF (RETORNO = TRUE)
                     THEN BEGIN
                            WRITELN ('REGISTRO INCLUIDO COM SUCESSO');
                            READKEY;
                          END
                          ELSE
                            BEGIN
                              WRITELN ('HOUVE UM PROBLEMA AO TENTAR SALVAR O REGISTRO.');
                              READKEY;
                            END;

                END
                 ELSE IF (OP = 2) THEN
                        BEGIN
                          ABRE_ARQ_AUX;
                          ABRE_ARQ;
                          RETORNO := EXCLUI;
                          IF (RETORNO = TRUE)
                             THEN BEGIN
                                WRITELN ('REGISTRO EXCLUIDO COM SUCESSO');
                                READKEY;
                             END
                           ELSE
                            BEGIN
                              WRITELN ('HOUVE UM PROBLEMA AO TENTAR EXCLUIR O REGISTRO.');
                              READKEY;
                            END;

                          FECHA_ARQ;
                          FECHA_ARQ_AUX;
                        END
                         ELSE IF (OP = 3) THEN
                                BEGIN
                                 ABRE_ARQ;
                                 CONSULTA;
                                 FECHA_ARQ;
                                 WRITELN ('PRESSIONE QUALQUER TECLA PARA CONTINUAR...');
                                 READKEY;
                                END
                                  ELSE IF (OP = 4) THEN
                                        BEGIN
                                          ABRE_ARQ;
                                          CONSULTA_ESP;
                                          FECHA_ARQ;
                                          WRITELN ('PRESSIONE QUALQUER TECLA PARA CONTINUAR...');
                                          READKEY;
                                        END

                                 ELSE IF (OP = 5) THEN
                                        BEGIN
                                          ABRE_ARQ;
                                          RETORNO := ALTERA;

                                          IF (RETORNO = TRUE)
                                           THEN BEGIN
                                            WRITELN ('REGISTRO ALTERADO COM SUCESSO');
                                            READKEY;
                                           END
                                          ELSE
                                           BEGIN
                                            WRITELN ('HOUVE UM PROBLEMA AO TENTAR ALTERAR O REGISTRO.');
                                            READKEY;
                                           END;
                                          FECHA_ARQ;
                                          WRITELN ('PRESSIONE QUALQUER TECLA PARA CONTINUAR...');
                                          READKEY;
                                        END
                                        ELSE IF (OP = 6) THEN
                                          BEGIN
                                            ABRE_ARQ;
                                            RETORNO := EXCLUI_LOGICA;

                                          IF (RETORNO = TRUE)
                                           THEN BEGIN
                                            WRITELN ('REGISTRO EXCLUIDO COM SUCESSO');
                                            READKEY;
                                           END
                                          ELSE
                                           BEGIN
                                            WRITELN ('HOUVE UM PROBLEMA AO TENTAR EXCLUIR O REGISTRO.');
                                            READKEY;
                                           END;
                                          FECHA_ARQ;
                                          WRITELN ('PRESSIONE QUALQUER TECLA PARA CONTINUAR...');
                                          READKEY;
                                        END;



  CLRSCR;

  END;


WRITELN;
WRITE ('SAINDO ... PRESSIONE QUALQUER TECLA');
READKEY;

END.






