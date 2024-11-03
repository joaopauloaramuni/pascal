PROGRAM LOCAFACIL;
USES CRT;

TYPE SEQ = RECORD
     STRAN : INTEGER;
     FLAG : CHAR;
END;

TYPE SEQ2 = RECORD
     SDVD : INTEGER;
     FLAG : CHAR;
END;

TYPE SEN = RECORD
     USER : STRING[15];
     SENHA : STRING[10];
     NOME : STRING[15];
     FLAG : CHAR;
END;

TYPE ARQFILME = RECORD
     CODTRANSACAO : STRING[6];
     TIPOTRANSACAO : STRING[2];
     NOMECLI : STRING[20];
     NOMEFILME : STRING[20];
     TIPOMIDIA : STRING[6];
     CPFCLI : STRING[14];
     DTLOCACAO : STRING[10];
     DTDEVOLUCAO : STRING[10];
     VLRPGRETIRADA : BOOLEAN;
     VLRPGDEVOLUCAO : BOOLEAN;
     VLRLOCACAO : REAL;
     FLAG : CHAR;
END;

TYPE ARQCLI = RECORD
     CPFCLI : STRING[11];
     NOMECLI : STRING[20];
     ENDERECOCLI : STRING[80];
     FLAG : CHAR;
END;

TYPE ARQDVD = RECORD
     CODDVD : STRING[20];
     NOMEDVD : STRING[20];
     TIPODVD : STRING[80];
     SITUACAO : STRING[2];
     FLAG : CHAR;
END;

CAD1 = FILE OF SEN;
CAD2 = FILE OF ARQFILME;
CAD3 = FILE OF ARQCLI;
CAD4 = FILE OF ARQDVD;
CAD5 = FILE OF SEQ;
CAD6 = FILE OF SEQ2;

VAR {VARIAVEIS GLOBAIS}
    GSENHA : CAD1;
    GFILME : CAD2;
    GCLI   : CAD3;
    GDVD   : CAD4;
    GSEQ   : CAD5;
    GSEQ2   : CAD6;

    {VARIAVEIS LOCAIS}
    LSENHA : SEN;
    LFILME : ARQFILME;
    LCLI   : ARQCLI;
    LDVD   : ARQDVD;
    LSEQ   : SEQ;
    LSEQ2  : SEQ2;

    {DEMAIS VARIAVEIS}
    X, BCK, OP, OK, P, R, I, K, Z, POSICAO, NCALC, CHECK, MOD1, MOD2, AUX1, AUX2 : INTEGER;
    LETRA, OPS, FLAG, NUM : CHAR;
    SIT, CONF, TIPOTRANSACAO : STRING[2];
    SENHAD : STRING[10];
    CODDVD : STRING[4];
    USER, CPFCLIS : STRING[15];
    TIPODVD, ENDERECOCLI : STRING[80];
    NOMEFILME, NOMECLI, NOMEDVD, NOME : STRING[20];
    TIPOMIDIA, CODTRANSACAO : STRING[6];
    DTLOCACAO, DTDEVOLUCAO : STRING[10];
    VLRPGRETIRADA, BDATA,
    ACHOU, VLRPGDEVOLUCAO, OKS : BOOLEAN;
    VLRLOCACAO: REAL;

LABEL CADA, PULO, ERRO, CAD, VOLTA, CPF;

PROCEDURE BV;
BEGIN
  CLRSCR;
  GOTOXY(30,3);
  WRITE('LOCAFACIL LTDA');
  GOTOXY(20,4);
  WRITELN('OLA ',NOME);
END;

PROCEDURE ERROR (X : STRING);
BEGIN
  BV;
  TEXTCOLOR(RED+16);
  GOTOXY(18,10);
  WRITELN(X);
  TEXTCOLOR(WHITE);
  READKEY;
END;

FUNCTION VALIDA_CPF : BOOLEAN;
VAR CALC1, CALC2, D1, D2, D3, D4, D5, D6, D7, D8, D9, D10, D11, Z, REST1, REST2 : INTEGER;

BEGIN
  VAL(CPFCLIS[1], D1, Z);
  VAL(CPFCLIS[2], D2, Z);
  VAL(CPFCLIS[3], D3, Z);
  VAL(CPFCLIS[5], D4, Z);
  VAL(CPFCLIS[6], D5, Z);
  VAL(CPFCLIS[7], D6, Z);
  VAL(CPFCLIS[9], D7, Z);
  VAL(CPFCLIS[10], D8, Z);
  VAL(CPFCLIS[11], D9, Z);
  VAL(CPFCLIS[13], D10, Z);
  VAL(CPFCLIS[14], D11, Z);

  {PRIMEIRA PARTE DA VALIDACAO CPF}
  CALC1 := D1 * 10;
  CALC1 := CALC1 + (D2 * 9);
  CALC1 := CALC1 + (D3 * 8);
  CALC1 := CALC1 + (D4 * 7);
  CALC1 := CALC1 + (D5 * 6);
  CALC1 := CALC1 + (D6 * 5);
  CALC1 := CALC1 + (D7 * 4);
  CALC1 := CALC1 + (D8 * 3);
  CALC1 := CALC1 + (D9 * 2);

  AUX1 := CALC1 MOD 11;

  IF (AUX1 >= 10) OR (AUX1 = 0) THEN MOD1 := 0
  ELSE MOD1 := 11 - AUX1;

  IF (MOD1 = D10) THEN
  BEGIN
    {SEGUNDA PARTE DA VALIDACAO CPF}
    CALC2 := D1 * 11;
    CALC2 := CALC2 + (D2 * 10);
    CALC2 := CALC2 + (D3 * 9);
    CALC2 := CALC2 + (D4 * 8);
    CALC2 := CALC2 + (D5 * 7);
    CALC2 := CALC2 + (D6 * 6);
    CALC2 := CALC2 + (D7 * 5);
    CALC2 := CALC2 + (D8 * 4);
    CALC2 := CALC2 + (D9 * 3);
    CALC2 := CALC2 + (D10 * 2);

    AUX2 := CALC2 MOD 11;

    IF (AUX2 >= 10) OR (AUX2 = 0) THEN MOD2 := 0
    ELSE MOD2 := 11 - AUX2;

    IF (MOD2 = D11) THEN VALIDA_CPF := TRUE ELSE VALIDA_CPF := FALSE;
  END ELSE VALIDA_CPF := FALSE;
END;

FUNCTION DVDCOD : STRING;
VAR CALC2  : STRING[6];
    SK0 : STRING[4];
    SK1 : STRING[4];
BEGIN
  CHECK := 0;
  RESET(GSEQ2);
  K := FILESIZE(GSEQ2);

  IF (FILESIZE(GSEQ2) = 0) THEN
  BEGIN
    LSEQ2.SDVD := 0;
    LSEQ2.SDVD := 000 + K;
    STR(K,SK0);
    SK1 := '000'+ SK0;
    WRITE(GSEQ2, LSEQ2);
  END
  ELSE IF (K > 0) AND (K < 10) THEN
      BEGIN
        SEEK(GSEQ2, K);
        LSEQ2.SDVD := 000 + K;
        STR(K,SK0);
        SK1 := '000'+ SK0;
        WRITE(GSEQ2, LSEQ2);
      END
      ELSE IF (K >= 10) AND (K < 100) THEN
             BEGIN
               SEEK(GSEQ2, K);
               LSEQ2.SDVD := 00 + K;
               STR(K,SK0);
               SK1 := '00'+ SK0;
               WRITE(GSEQ2, LSEQ2);
             END
      ELSE BEGIN
                  IF (K >= 100) AND (K < 1000) THEN
                    BEGIN
                      SEEK(GSEQ2, K);
                      LSEQ2.SDVD := 0 + K;
                      STR(K,SK0);
                      SK1 := '0'+ SK0;
                      WRITE(GSEQ2, LSEQ2);
                    END;
             END;

  CLOSE(GSEQ2);

  CALC2[1] := SK1[1];
  CALC2[2] := SK1[2];
  CALC2[3] := SK1[3];
  CALC2[4] := SK1[4];

  DVDCOD := CALC2;
END;

FUNCTION CODTRAN : STRING;
VAR CALC  : STRING[6];
    SK : STRING[4];
    SK2 : STRING[4];
    Z : INTEGER;
BEGIN

  CALC[1] := NOMEFILME[1];
  CALC[2] := NOMECLI[1];

  RESET(GSEQ);

  K := FILESIZE(GSEQ);

  IF (FILESIZE(GSEQ) = 0) THEN
  BEGIN
    LSEQ.STRAN := 0;
    LSEQ.STRAN := 000 + K;
    STR(K,SK);
    SK2 := '000'+ SK;
    WRITE(GSEQ, LSEQ);
  END
  ELSE IF (K > 0) AND (K < 10) THEN
      BEGIN
        SEEK(GSEQ, K);
        LSEQ.STRAN := 000 + K;
        STR(K,SK);
        SK2 := '000'+ SK;
        WRITE(GSEQ, LSEQ);
      END
      ELSE IF (K >= 10) AND (K < 100) THEN
             BEGIN
               SEEK(GSEQ, K);
               LSEQ.STRAN := 00 + K;
               STR(K,SK);
               SK2 := '00'+ SK;
               WRITE(GSEQ, LSEQ);
             END
      ELSE BEGIN
                  IF (K >= 100) AND (K < 1000) THEN
                    BEGIN
                      SEEK(GSEQ, K);
                      LSEQ.STRAN := 0 + K;
                      STR(K,SK);
                      SK2 := '0'+ SK;
                      WRITE(GSEQ, LSEQ);
                    END;
             END;


  CLOSE(GSEQ);

  CALC[3] := SK2[1];
  CALC[4] := SK2[2];
  CALC[5] := SK2[3];
  CALC[6] := SK2[4];

  CODTRAN := CALC;
END;

FUNCTION DATA : BOOLEAN;
VAR DIAS : STRING[2];
    MESS : STRING[2];
    ANOS : STRING[4];
    DIA, MES, ANO : REAL;
    Z : INTEGER;

LABEL ERRO, PULO;

BEGIN
  VAL(DTLOCACAO[1]+DTLOCACAO[2],DIA,Z);
  VAL(DTLOCACAO[4]+DTLOCACAO[5], MES, Z);
  VAL(DTLOCACAO[7]+DTLOCACAO[8]+DTLOCACAO[9]+DTLOCACAO[10], ANO, Z);

  IF (Z = 1) THEN
  BEGIN
    DATA := FALSE;
    GOTO ERRO;
  END;

  ERRO:
END;

PROCEDURE CAPTURACPF;
BEGIN
  GOTOXY(18,10);
  CLREOL;

  GOTOXY(18,10);
  WRITE('DIGITE SEU CPF: ');

  R := 34;
  REPEAT
    FOR P := 1 TO 3 DO
    BEGIN
      CPFCLIS[P] := READKEY;
      GOTOXY(R,10);
      WRITE(CPFCLIS[P]);
      R := R + 1;
    END;
  UNTIL (NOT(CPFCLIS[P] IN ['A'..'Z']));

  GOTOXY(37,10);
  WRITE('.');

  R := 38;
  FOR P := 5 TO 7 DO
  BEGIN
    CPFCLIS[P] := READKEY;
    GOTOXY(R,10);
    WRITE(CPFCLIS[P]);
    R := R + 1;
  END;

  GOTOXY(41,10);
  WRITE('.');

  R := 42;
  FOR P := 9 TO 11 DO
  BEGIN
    CPFCLIS[P] := READKEY;
    GOTOXY(R,10);
    WRITE(CPFCLIS[P]);
    R := R + 1;
  END;

  GOTOXY(45,10);
  WRITE('-');

  CPFCLIS[13] := READKEY;
  GOTOXY(46,10);
  WRITE(CPFCLIS[13]);

  CPFCLIS[14] := READKEY;
  GOTOXY(47,10);
  WRITE(CPFCLIS[14]);
  READKEY;
END;

PROCEDURE DATE;
BEGIN
  GOTOXY(18,10);
  WRITE('DIGITE A DATA');


END;

PROCEDURE PESQUISA;
BEGIN
  RESET(GDVD);
  K := FILESIZE(GDVD);
  I := 0;
  X := 10;
  WHILE (I <= K-1) DO
  BEGIN
    SEEK(GDVD, I);
    READ(GDVD, LDVD);
    IF (LDVD.FLAG <> 'X') THEN
    BEGIN
      NOMEFILME := LDVD.NOMEDVD;
      SIT := LDVD.SITUACAO;
      TIPOMIDIA := LDVD.TIPODVD;

      GOTOXY(10,X);
      WRITE('NOME: ',NOMEFILME,'.');

      GOTOXY(34,X);
      WRITE('SIT: ',SIT);

      GOTOXY(43,X);
      WRITE('GENERO: ',TIPOMIDIA,'.');
      X := X + 1;
      I := I + 1;
    END ELSE I := I + 1;
  END;
  READKEY;
  NOMEFILME := 'P';
  GOTOXY(33,8);
END;

{************************************************************************
****************************COMECO DO PROGRAMA***************************
*************************************************************************}
BEGIN

  ASSIGN(GSENHA, 'G:\LOCADORA\SENHA.DAT');
  ASSIGN(GFILME, 'G:\LOCADORA\FILMES.DAT');
  ASSIGN(GCLI, 'G:\LOCADORA\CLI.DAT');
  ASSIGN(GDVD, 'G:\LOCADORA\DVD.DAT');
  ASSIGN(GSEQ, 'G:\LOCADORA\SEQ.DAT');
  ASSIGN(GSEQ2, 'G:\LOCADORA\SEQ2.DAT');

  (*$I-*)
  RESET(GDVD);
  (*$I+*)

  IF (IORESULT <> 0) THEN
  BEGIN
    GOTOXY(2,2);
    WRITELN('O AQUIVO DOS DVDs AINDA NAO FOI CRIADO. SERA CRIADO AGORA...');
    REWRITE(GDVD);
    WRITELN('ARQUIVO CRIADO. PRESSIONE QUALQUER TECLA PARA CONTINUAR...');
    GOTOXY(2,3);
    READKEY;
    CLRSCR;
  END;

  (*$I-*)
  RESET(GCLI);
  (*$I+*)

  IF (IORESULT <> 0) THEN
  BEGIN
    GOTOXY(2,2);
    WRITELN('O AQUIVO DOS CLIENTES AINDA NAO FOI CRIADO. SERA CRIADO AGORA...');
    REWRITE(GCLI);
    WRITELN('ARQUIVO CRIADO. PRESSIONE QUALQUER TECLA PARA CONTINUAR...');
    GOTOXY(2,3);
    READKEY;
    CLRSCR;
  END;

  (*$I-*)
  RESET(GFILME);
  (*$I+*)

  IF (IORESULT <> 0) THEN
  BEGIN
    GOTOXY(2,2);
    WRITELN('O ARQUIVO DOS FILMES AINDA NAO FOI CRIADO. SERA CRIADO AGORA...');
    REWRITE(GFILME);
    WRITELN('ARQUIVO CRIADO. PRESSIONE QUALQUER TECLA PARA CONTINUAR...');
    GOTOXY(2,3);
    READKEY;
    CLRSCR;
  END;

  (*$I-*)
  RESET(GSEQ);
  (*$I+*)

  IF (IORESULT <> 0) THEN REWRITE(GSEQ);

  (*$I-*)
  RESET(GSEQ2);
  (*$I+*)

  IF (IORESULT <> 0) THEN
  BEGIN
    REWRITE(GSEQ2);
  END;

  (*$I-*)
  RESET(GSENHA);
  (*$I+*)

  IF (IORESULT <> 0) THEN REWRITE(GSENHA);

  OK := 1;
  OKS := FALSE;

  WHILE (OKS = FALSE) DO {COMECO DO LOGIN}
  BEGIN
    USER := '';
    RESET(GSENHA);

    IF (FILESIZE(GSENHA) = 0) THEN
    BEGIN
      LSENHA.USER := 'ADMIN';
      LSENHA.SENHA := 'ADMIN';
      LSENHA.NOME := 'ADMINISTRADOR';
      WRITE(GSENHA, LSENHA);
    END;

    SENHAD := '';
    USER := 'LOGIN';
    BV;
    GOTOXY(30,8);
    WRITE('LOGIN');

    GOTOXY(30,10);
    WRITE('DIGITE O USUARIO: ');
    READLN(USER);

    IF (USER = 'CADASTRAR') THEN   {CADASTRAR NOVOS USUARIOS}
    BEGIN
      BV;

      GOTOXY(30,10);
      WRITE('DIGITE O NOME DE USUARIO: ');
      READLN(USER);

      GOTOXY(30,12);
      WRITE('DIGITE O SEU NOME: ');
      READLN(NOME);

      GOTOXY(30,14);
      WRITE('DIGITE A SENHA: ');

      FOR K := 1 TO 10 DO
      BEGIN
        LETRA := READKEY;
        IF (ORD (LETRA) = 13) THEN BREAK;
        WRITE('*');
        SENHAD := SENHAD + LETRA;
      END;

      IF (FILESIZE(GSENHA) = 0) THEN
      BEGIN
        LSENHA.USER := USER;
        LSENHA.SENHA := SENHAD;
        LSENHA.NOME := NOME;
        GOTOXY(18,18);
        TEXTCOLOR(BLUE);
        WRITELN('USUARIO CADASTRADO COM SUCESSO!!');
        TEXTCOLOR(WHITE);
        WRITE(GSENHA, LSENHA);
      END ELSE
      BEGIN
        SEEK(GCLI, K+1);
        LSENHA.USER := USER;
        LSENHA.SENHA := SENHAD;
        LSENHA.NOME := NOME;
        GOTOXY(18,18);
        TEXTCOLOR(RED);
        WRITELN('USUARIO CADASTRADO COM SUCESSO!!');
        TEXTCOLOR(WHITE);
        WRITE(GSENHA, LSENHA);
      END;

    GOTO CAD;

    END; {END DO CADASTRO}

    IF (USER = 'FIM') THEN OKS := TRUE
    ELSE
  BEGIN
    VOLTA:
    SENHAD := '';
    GOTOXY(34,14);
    CLREOL;

    GOTOXY(30,14);
    WRITE('DIGITE A SENHA: ');

    FOR K := 1 TO 10 DO
    BEGIN
      LETRA := READKEY;
      IF (ORD (LETRA) = 13) THEN BREAK;
      IF (ORD (LETRA) = 8) THEN GOTO VOLTA;
      WRITE('*');
      SENHAD := SENHAD + LETRA;
    END;

    {VERIFICA NO ARQUIVO SE USER E SENHA ESTAO CORRETOS}
    K := FILESIZE(GSENHA);
    I := 0;
    WHILE (I < K) DO
    BEGIN
      SEEK(GSENHA, I);
      READ(GSENHA, LSENHA);
      IF (LSENHA.USER = USER) AND (LSENHA.SENHA = SENHAD) THEN
      BEGIN
        OKS := TRUE;
        GOTOXY(18,8);
        I := K + 1;
        NOME := LSENHA.NOME;
        CHECK := 3;

      END;
      I := I + 1;
    END;

  END;{END DO ELSE}
  CAD:
  CLOSE(GSENHA);

  R := 0;
  IF (CHECK = 3) THEN
  BEGIN
    WHILE (R < 2) DO
    BEGIN
      GOTOXY(30,20);
      CLREOL;
      GOTOXY(30,20);
      WRITE('LOGIN.');
      DELAY(1000);
      GOTOXY(30,20);
      WRITE('LOGIN..');
      DELAY(1000);
      GOTOXY(30,20);
      WRITE('LOGIN...');
      DELAY(1000);
      R := R + 1;
    END;
  END;
  END; {END DO WHILE SENHA}

  WHILE (OKS = TRUE) DO
  BEGIN
  RESET(GDVD);
  RESET(GFILME);
  RESET(GCLI);
  RESET(GSEQ);
     REPEAT
      BV;
      GOTOXY(16,1);
      WRITE('_____________________________________________________');

      GOTOXY(20,6);
      WRITE('DIGITE A OPCAO: ');

      FOR R := 2 TO 20 DO
      BEGIN
        GOTOXY(15,R);
        WRITE('|');

        GOTOXY(69,R);
        WRITE('|');
      END;

      GOTOXY(15,21);
      WRITE('|_____________________________________________________|');

      GOTOXY(17,8);
      WRITE('1 - Locacao');

      GOTOXY(17,10);
      WRITE('2 - Devolucao');

      GOTOXY(17,12);
      WRITE('3 - Cadastro/Alteracao/Exclusao de Cliente');

      GOTOXY(17,14);
      WRITE('4 - Cadastro/Alteracao/Exclusao de Filmes');

      GOTOXY(17,16);
      WRITE('5 - Relatorio Mensal');

      GOTOXY(17,18);
      WRITE('6 - Sair');

      GOTOXY(17,20);
      WRITE('7 - Deletar todos os arquivos');

      REPEAT
        GOTOXY(36,6);
        OPS := READKEY;
        VAL(OPS, OP, Z);
        WRITE(OPS);
        CONF := READKEY;
      UNTIL(OPS <> '') AND (Z = 0);
      READKEY;
    UNTIL (OP = 1) OR (OP = 2) OR (OP = 3) OR (OP = 4) OR
    (OP = 5) OR (OP = 6) OR (OP = 7);

    {************************DELETAR ARQUIVOS**************************}
    IF (OP = 7) THEN
    BEGIN
      REWRITE(GSENHA);
      REWRITE(GFILME);
      REWRITE(GCLI);
      REWRITE(GDVD);
      REWRITE(GSEQ);
      REWRITE(GSEQ2);

      BV;
      GOTOXY(18,8);
      TEXTCOLOR(RED+128);
      WRITE('ARQUIVOS DELETADOS');
      TEXTCOLOR(WHITE);
    END;

    {***************************LOCA€AO*********************************}
    IF (OP = 1) THEN
    BEGIN
      RESET(GFILME);
      RESET(GCLI);
      RESET(GDVD);

      BV;
      GOTOXY(30,4);
      WRITE('LOCACAO DE FILMES');

      REPEAT
        CAPTURACPF;
        IF (VALIDA_CPF = FALSE) THEN ERROR ('CPF INVALIDO');
      UNTIL (VALIDA_CPF = TRUE);

      VALIDA_CPF;
      READKEY;

      K := FILESIZE(GCLI);
      ACHOU := FALSE;
      I := 0;
      WHILE (I <= K-1) DO
      BEGIN
        SEEK(GCLI, I);
        READ(GCLI, LCLI);
        IF (LCLI.CPFCLI = CPFCLIS) THEN
        BEGIN
          BV;
          GOTOXY(30,4);
          WRITE('LOCACAO DE FILMES');
          NOMECLI := LCLI.NOMECLI;
          GOTOXY(18,9);
          WRITELN('CLIENTE LOCALIZADO: ', NOMECLI);
          ACHOU := TRUE;
          I := K + 1;
          READKEY;
        END;
        I := I + 1;
      END;

      CONF := 'N';

      IF (ACHOU <> TRUE) THEN
      BEGIN
        REPEAT
          BV;
          GOTOXY(30,6);
          WRITE('LOCACAO DE FILMES');
          GOTOXY(18,8);
          WRITE('CADASTRO NAO ENCONTRADO, DESEJA CADASTRAR? S/N: ');
          READLN(CONF);
        UNTIL (CONF = 'S') OR (CONF = 'N');
        IF (CONF = 'S') THEN
        BEGIN
          CHECK := 0;
          GOTO CADA;
        END;
      END ELSE
      BEGIN
        BV;
        GOTOXY(30,6);
        WRITE('LOCACAO DE FILMES');

        GOTOXY(40,7);
        WRITE('P - PESQUISAR');
        REPEAT
          GOTOXY(18,8);
          WRITE('NOME DO FILME: ');
          READLN(NOMEFILME);
          IF (NOMEFILME = 'P') THEN PESQUISA;
        UNTIL(NOMEFILME <> '') OR (NOMEFILME <> 'P');

        K := FILESIZE(GDVD);
        ACHOU := FALSE;
        I := 0;

        WHILE (I < K) DO
        BEGIN
          SEEK(GDVD, I);
          READ(GDVD, LDVD);
          IF (LDVD.NOMEDVD = NOMEFILME) THEN
          BEGIN
            IF (LDVD.SITUACAO = 'AU') THEN
            BEGIN
              ERROR('FILME JA LOCADO');
              GOTO PULO;
            END ELSE
            BEGIN
            TIPOMIDIA := LDVD.TIPODVD;
            GOTOXY(18,10);
            WRITELN('FILME LOCALIZADO: ', NOMEFILME);
            ACHOU := TRUE;

            SEEK(GDVD, I);
            LDVD.SITUACAO := 'AU';
            WRITE(GDVD,LDVD);
            I := K + 1;
            READKEY;
            GOTOXY(18,10);
            CLREOL;
            END;
          END ELSE I := I + 1;
        END;

        IF (ACHOU = FALSE) THEN
        BEGIN
          ERROR(' FILME NAO LOCALIZADO ');
        END ELSE
        BEGIN

          GOTOXY(18,10);
          WRITE('TIPO DO FILME: ', TIPOMIDIA);

          REPEAT
            GOTOXY(18,12);
            WRITE('DATA DE LOCACAO, DD/MM/AAAA: ');
            READLN(DTLOCACAO);
          UNTIL (BDATA = FALSE);

          CODTRANSACAO := CODTRAN;

          GOTOXY(18,14);
          WRITE('O CODIGO DE TRANSACAO : ',CODTRANSACAO);

          K := FILESIZE(GFILME);

          IF (FILESIZE(GFILME) = 0) THEN
          BEGIN
            SEEK(GFILME, K);
            LFILME.CODTRANSACAO := CODTRANSACAO;
            LFILME.TIPOTRANSACAO := TIPOTRANSACAO;
            LFILME.NOMECLI := NOMECLI;
            LFILME.NOMEFILME := NOMEFILME;
            LFILME.TIPOMIDIA := TIPOMIDIA;
            GOTOXY(18,16);
            TEXTCOLOR(RED);
            WRITELN('LOCACAO CADASTRADA!');
            GOTOXY(18,17);
            TEXTCOLOR(WHITE);
            WRITE(GFILME, LFILME);
          END ELSE
           BEGIN
             SEEK(GFILME, K);
             LFILME.CODTRANSACAO := CODTRANSACAO;
             LFILME.TIPOTRANSACAO := TIPOTRANSACAO;
             LFILME.NOMECLI := NOMECLI;
             LFILME.NOMEFILME := NOMEFILME;
             LFILME.TIPOMIDIA := TIPOMIDIA;

             GOTOXY(18,16);
             TEXTCOLOR(RED);
             WRITELN('LOCACAO CADASTRADA!');
             GOTOXY(18,17);
             TEXTCOLOR(WHITE);
             WRITE(GFILME, LFILME);
           END;
         END;

      PULO:
      CLOSE(GCLI);
      CLOSE(GDVD);
      CLOSE(GFILME);

      END;


    END;{END DA LOCACAO}

    {*****************************DEVOLUCAO*********************************}
    IF (OP = 2) THEN
    BEGIN

      RESET(GFILME);
      RESET(GCLI);
      RESET(GDVD);

      BV;
      GOTOXY(18,4);
      WRITE('DEVOLUCAO DE FILMES');

      GOTOXY(18,6);
      WRITE('PESQUISA POR:');
      GOTOXY(15,7);
      WRITE('1 - CPF DO CLIENTE / 2 - COD DE TRANSACAO');
      REPEAT
        GOTOXY(7,8);
        WRITE('OPCAO: ');
        READLN(OP);
      UNTIL(OP = 1) OR (OP = 2);

      IF (OP = 1) THEN
      BEGIN
        BV;
        GOTOXY(18,4);
        WRITE('DEVOLUCAO DE FILMES');

        CAPTURACPF;

        K := FILESIZE(GFILME);
        I := 0;
        R := 15;

        WHILE (I < K) DO
        BEGIN
          SEEK(GFILME, I);
          READ(GFILME, LFILME);
          IF (CPFCLIS = LFILME.CPFCLI) THEN
          BEGIN
            NOMECLI := LFILME.NOMECLI;
            GOTOXY(18,12);
            WRITELN('LOCACACOES ENCONTRADAS DO CLIENTE ',NOMECLI);

            CODTRANSACAO := LFILME.CODTRANSACAO;
            GOTOXY(18,R);
            WRITE('COD: ',CODTRANSACAO);

            NOMEFILME := LFILME.NOMEFILME;
            GOTOXY(30,R);
            WRITE('NOME: ',NOMEFILME);
          END;
          I := I + 1;
          R := R + 1;
        END;
      END;
    END;{END DA DEVOLUCAO}

    {************************CADASTRO DE CLIENTES***************************}
    IF (OP = 3) THEN
    BEGIN
      BV;
      GOTOXY(30,5);
      WRITE('BANCO DE DADOS DE CLIENTES');
      GOTOXY(7,6);
      WRITE('1 - INCLUIR CADASTRO / 2 - ALTERAR CADASTRO / 3 - EXCLUIR CADASTRO');

      GOTOXY(7,7);
      WRITE('OPCAO: ');
      READLN(OP);

      {---------------------------INCLUIR CADASTRO--------------------------}
      IF (OP = 1) THEN
      BEGIN
        CHECK := 1;
        CADA:

        RESET(GCLI);
        BV;
        GOTOXY(30,5);
        WRITE('LOCACAO DE FILMES');
        GOTOXY(18,8);
        WRITE('DIGITE O SEU NOME: ');
        READLN(NOMECLI);

        IF (CHECK = 0) THEN
        BEGIN
          REPEAT
            GOTOXY(18,10);
            WRITE('CONFIRMA CPF ',CPFCLIS,': S/N : ');
            READLN(CONF);
          UNTIL(CONF = 'S') OR (CONF = 'N');
        END;

        IF (CONF = 'N') OR (CHECK = 1)THEN
        BEGIN
          GOTOXY(18,10);
          CLREOL;
          CAPTURACPF;
        END;


        GOTOXY(18,12);
        WRITE('DIGITE SEU ENDERECO: ');
        READLN(ENDERECOCLI);

        K := FILESIZE(GCLI);

        IF (FILESIZE(GCLI) = 0) THEN
        BEGIN
          LCLI.NOMECLI := NOMECLI;
          LCLI.CPFCLI := CPFCLIS;
          LCLI.ENDERECOCLI := ENDERECOCLI;
          GOTOXY(18,14);
          TEXTCOLOR(RED);
          WRITELN('CLIENTE CADASTRADO COM SUCESSO!!');
          GOTOXY(18,15);
          TEXTCOLOR(WHITE);
          WRITE(GCLI, LCLI);
        END ELSE
         BEGIN
           SEEK(GCLI, K+1);
           LCLI.NOMECLI := NOMECLI;
           LCLI.CPFCLI := CPFCLIS;
           LCLI.ENDERECOCLI := ENDERECOCLI;
           GOTOXY(18,14);
           TEXTCOLOR(RED);
           WRITELN('CLIENTE CADASTRADO COM SUCESSO!!');
           GOTOXY(18,15);
           TEXTCOLOR(WHITE);
           WRITE(GCLI, LCLI);
         END;
      CLOSE(GCLI);
      END; {END DA OPCAO 3.1}

      {---------------------ALTERAR CADASTRO DE CLIENTES--------------------}
      IF (OP = 2) THEN
      BEGIN
        BV;
        GOTOXY(30,5);
        WRITE('ALTERACAO DE CLIENTES');
        GOTOXY(18,8);
        WRITE('DIGITE O SEU NOME: ');
        READLN(NOMECLI);

        POSICAO := 0;
        K:=FILESIZE(GCLI);
        I:=0;
        ACHOU:=FALSE;
        WHILE(I <= K - 1)DO
        BEGIN
          SEEK(GCLI,I);
          READ(GCLI,LCLI);
          IF(LCLI.NOMECLI = NOMECLI)THEN
          BEGIN
            POSICAO:=I;
            I:=K+1;
            ACHOU:=TRUE;
          END
          ELSE I:=I+1;
        END;

        IF(ACHOU = TRUE) THEN
        BEGIN
          GOTOXY(18,12);
          WRITE('DIGITE O NOVO NOME: ');
          READLN(NOMECLI);

          REPEAT
            CAPTURACPF;
          UNTIL (VALIDA_CPF = TRUE);

          GOTOXY(18,14);
          WRITE('DIGITE O NOVO ENDERECO: ');
          READLN(ENDERECOCLI);

          LCLI.NOMECLI:= NOMECLI;
          LCLI.CPFCLI:= CPFCLIS;
          LCLI.ENDERECOCLI:= ENDERECOCLI;
          SEEK(GCLI,POSICAO);
          WRITE(GCLI,LCLI);
          GOTOXY(18,16);
          TEXTCOLOR(RED);
          WRITELN('CADASTRO ALTERADO COM SUCESSO!!');
          GOTOXY(18,17);
          TEXTCOLOR(WHITE);
        END ELSE
        BEGIN
          GOTOXY(18,10);
          WRITE('CLIENTE NAO CADASTRADO');
          GOTOXY(18,11);
        END;
	CLOSE(GCLI);
      END; {END DA OPCAO 3.2}

      {-------------------EXCLUIR CADASTRO DE CLIENTES----------------------}
      IF (OP = 3) THEN
      BEGIN
        BV;
        GOTOXY(30,5);
        WRITE('EXCLUSAO DE CLIENTES');

        REPEAT
          CAPTURACPF;
        UNTIL (VALIDA_CPF = TRUE);

        I := 0;
        K := FILESIZE(GCLI);
        ACHOU := FALSE;

        WHILE (I <= (K-1)) DO
        BEGIN
          SEEK(GCLI, I);
          READ(GCLI, LCLI);

          IF (CPFCLIS = LCLI.CPFCLI) THEN
          BEGIN
            LCLI.FLAG := 'X';
            WRITE(GCLI, LCLI);
            I := K + 1;
            ACHOU := TRUE;
            GOTOXY(20,20);
            WRITE('ARQUIVO DELETADO COM SUCESSO');
          END ELSE I := I + 1;
        END;

      END;{END DA OPCAO 3.3}

    END; {END DA OPCAO 3}

    {*************************CADASTRO DE FILMES****************************}
    IF (OP = 4) THEN
    BEGIN

      BV;
      GOTOXY(30,5);
      WRITE('BANCO DE DADOS DO FILMES');
      GOTOXY(7,6);
      WRITE('1 - INCLUIR CADASTRO / 2 - ALTERAR CADASTRO / 3 - EXCLUIR CADASTRO');
      GOTOXY(7,7);
      WRITE('OPCAO: ');
      READLN(OP);

      {------------------------INCLUIR CADASTRO-----------------------------}
      IF (OP = 1) THEN
      BEGIN
       BV;
       GOTOXY(30,5);
       WRITE('BD FILMES-INCLUIR');

        CODDVD := DVDCOD;

        GOTOXY(10,5);
        WRITELN('COD: ',CODDVD);

        GOTOXY(30,5);
        WRITE('CADASTR(O DE FILMES');
        GOTOXY(18,6);
        WRITE('DIGITE O NOME DO FILME: ');
        READLN(NOMEDVD);

        GOTOXY(55,5);
        WRITELN('TER - Terror');
        GOTOXY(55,6);
        WRITELN('SUS - Suspense');
        GOTOXY(55,7);
        WRITELN('AVE - Aventura');
        GOTOXY(55,8);
        WRITELN('ACA - Acao');
        GOTOXY(55,9);
        WRITELN('ROM - Romance');
        GOTOXY(55,10);
        WRITELN('DRA - Drama');
        GOTOXY(55,11);
        WRITELN('DOC - Documentario');
        GOTOXY(55,12);
        WRITELN('GUE - Guerra');
        GOTOXY(55,13);
        WRITELN('WES - Western');

        GOTOXY(18,8);
        WRITE('DIGITE O TIPO DO FILME: ');
        READLN(TIPODVD);

        K := FILESIZE(GDVD);

        IF (FILESIZE(GDVD) = 0) THEN
        BEGIN
          LDVD.NOMEDVD := NOMEDVD;
          LDVD.TIPODVD := TIPODVD;
          LDVD.CODDVD := CODDVD;
          LDVD.SITUACAO := 'PR';

          GOTOXY(18,10);
          TEXTCOLOR(BLUE);
          WRITELN('FILME CADASTRADO COM SUCESSO!!');
          GOTOXY(18,11);
          TEXTCOLOR(WHITE);
          WRITE(GDVD, LDVD);
        END ELSE
        BEGIN
          SEEK(GDVD, K);
          LDVD.NOMEDVD := NOMEDVD;
          LDVD.TIPODVD := TIPODVD;
          LDVD.CODDVD := CODDVD;
          LDVD.SITUACAO := 'PR';


          GOTOXY(18,10);
          TEXTCOLOR(BLUE);
          WRITELN('FILME CADASTRADO COM SUCESSO!!');
          GOTOXY(18,11);
          TEXTCOLOR(WHITE);
          WRITE(GDVD, LDVD);
        END;
      CLOSE(GDVD);
      END; {END DA OPCAO 3.1}

      {------------------------ALTERAR CADASTRO-----------------------------}
      IF (OP = 2) THEN
      BEGIN
       BV;
        GOTOXY(30,5);
        WRITE('ALTERACAO DE FILMES');
        GOTOXY(18,7);
        WRITE('DIGITE O NOME DO FILME: ');
        READLN(NOMEDVD);

        K:=FILESIZE(GDVD);
        I:=0;
        ACHOU:=FALSE;
        WHILE(I <= K - 1)DO
        BEGIN
          SEEK(GDVD,I);
          READ(GDVD,LDVD);
          IF(LDVD.FLAG = 'X') THEN ERROR('FILME NAO ENCONTRADO')
          ELSE BEGIN
            IF(LDVD.NOMEDVD = NOMEDVD)THEN
            BEGIN
              POSICAO:=I;
              I:=K+1;
              ACHOU:=TRUE;
            END ELSE I:=I+1;
          END;
        END;

        IF(ACHOU = TRUE) THEN
        BEGIN
          GOTOXY(18,10);
          WRITE('DIGITE O NOVO NOME DO FILME: ');
          READLN(NOMEDVD);
          GOTOXY(18,12);
          WRITE('DIGITE O NOVO TIPO DE MIDIA: ');
          READLN(TIPODVD);
          LDVD.NOMEDVD:= NOMEDVD;
          LDVD.TIPODVD:= TIPODVD;
          SEEK(GDVD,POSICAO);
          WRITE(GDVD,LDVD);
          GOTOXY(18,16);
          TEXTCOLOR(RED);
          WRITELN('CADASTRO ALTERADO COM SUCESSO!!');
          GOTOXY(18,17);
          TEXTCOLOR(WHITE);
        END ELSE ERROR('FILME NAO ENCONTRADO');

	CLOSE(GDVD);
      END; {END DA OPCAO 3.2}

      {------------------------EXCLUIR CADASTRO-----------------------------}
      IF (OP = 3) THEN
      BEGIN
        BV;
        GOTOXY(30,5);
        WRITE('EXCLUSAO DE CLIENTES');

        REPEAT
          GOTOXY(18,7);
          WRITE('DIGITE O NOME DO FILME: ');
          READLN(NOMEDVD);
        UNTIL (NOMEDVD <> '');

        I := 0;
        K := FILESIZE(GDVD);
        ACHOU := FALSE;

        WHILE (I <= (K-1)) DO
        BEGIN
          SEEK(GDVD, I);
          READ(GDVD, LDVD);

          IF (NOMEDVD = LDVD.NOMEDVD) THEN
          BEGIN
            LDVD.FLAG := 'X';
            WRITE(GDVD, LDVD);
            I := K + 1;
            ACHOU := TRUE;
            GOTOXY(18,10);
            WRITE('ARQUIVO DELETADO COM SUCESSO');
          END ELSE I := I + 1;
        END;


      END;{END DA OPCAO 3.3}

    END;

    {****************************RELATORIO MENSAL***************************}
    IF (OP = 5) THEN
    BEGIN
      BV;
      WRITELN('TESTE');
    END;{END DO RELATORIO}

    IF (OP = 6) THEN OKS := FALSE;
    READKEY;
  END;
  CLRSCR;
END.