program HOSPEDE;
uses CRT, DOS;

var MAT: array[1..100,1..5] of string[20];
    OK: boolean;
    NOME: string[20];
    DTE, DTS: string[10];
    TIPO: char;
    I, J, DE, ME, AE, DS, MS, AS, Z: integer;
    HORA, MIN, SEG, X: word;
    VALOR, TOTAL, MEDIA: real;
    VALORS, MEDIAS: string[8];

procedure ERRO (msg: string);
begin
   writeln ('Erro: ', msg);
   writeln ('Pressione qualquer tecla para continuar');
   readkey;
   clreol;
end;

function CONSISTE_DATA (DATA:string): boolean;
var AA, MM, DD: integer;
begin

   val (DATA[1]+DATA[2], DD, Z);
   val (DATA[4]+DATA[5], MM, Z);
   val (DATA[7]+DATA[8]+DATA[9]+DATA[10], AA, Z);


   if (MM < 1) or (MM > 12)
     then CONSISTE_DATA := FALSE;

   if (MM in [1,3,5,7,8,10,12])
      and ((DD < 1) or (DD > 31))
      then CONSISTE_DATA := FALSE;

   if (MM = 2) and ((DD < 1) or (DD > 28))
      then CONSISTE_DATA := FALSE;

   if (MM in [4,6,9,11])
      and ((DD < 1) or (DD > 30))
      then CONSISTE_DATA := FALSE;

   if (AA > 2010)
     then CONSISTE_DATA := FALSE;


end;


begin
    I:= 1;

    TOTAL := 0;

    while (true) do
    begin


    GETTIME (HORA, MIN, SEG, X);

     clrscr;
     writeln ('-------------------------------------------------------------------------------');
     writeln ('                            HOTEL XYZ LTDA.                                    ');
     writeln ('-------------------------------------------------------------------------------');
     writeln ('                                                       ',HORA,':', MIN,':', SEG);
     writeln;

     write ('Digite o nome do hospede: ');
     readln (NOME);

     if (NOME = 'FIM') or (NOME = 'fim')
       then break;


     repeat

      repeat

       OK := TRUE;

       write ('Digite a data de entrada: ');
       readln (DTE);

       OK:= CONSISTE_DATA(DTE);

       if (OK = FALSE)
         then ERRO ('Data de Entrada');

      until (OK <> FALSE);

      repeat

       OK := TRUE;

       write ('Digite a data de saida: ');
       readln (DTS);

       OK:= CONSISTE_DATA(DTS);

       if (OK = FALSE)
         then ERRO ('Data de Saida');

      until (OK <> FALSE);


      val (DTE[1] + DTE[2], DE, Z);
      val (DTE[4] + DTE[5], ME, Z);
      val (DTE[7] + DTE[8] + DTE[9] + DTE[10], AE, Z);

      val (DTS[1] + DTS[2], DS, Z);
      val (DTS[4] + DTS[5], MS, Z);
      val (DTS[7] + DTS[8] + DTS[9] + DTS[10], AS, Z);

      if (AS <> AE) or (MS <> ME) or (DS < DE)
       then ERRO ('Mes ou ano de sa¡da diferente do de entrada!');

    until (AS = AE) and (MS = ME) and (DS >= DE);

     repeat
      write ('Digite o tipo do quarto (S(tandard) / L(uxo) / X(SuperLuxo)): ');
      readln (TIPO);

      if (upcase(TIPO) <> 'S') and (upcase(TIPO) <> 'L') and (upcase(TIPO) <> 'X')
        then ERRO ('Tipo de Quarto');

     until (upcase(TIPO) = 'S') or (upcase(TIPO) = 'L') or (upcase(TIPO) = 'X');

     case TIPO of
       'S': VALOR:= (DS - DE) * 120;
       'L': VALOR:= (DS - DE) * 150;
       'X': VALOR:= (DS - DE) * 180;
     end;

     TOTAL:= TOTAL + VALOR;

     str (VALOR:6:2, VALORS);

     MAT[I,1] := NOME;
     MAT[I,2] := DTE;
     MAT[I,3] := DTS;
     MAT[I,4] := TIPO;
     MAT[I,5] := VALORS;

     writeln;
     writeln ('O hospede ', NOME, ' pagara: R$', VALOR:6:2);
     writeln;
     writeln ('Pressione qualquer tecla para continuar');
     readkey;

     I := I + 1;

    end;

    if (I <> 1) then MEDIA := TOTAL / (I-1);

    str (MEDIA:6:2, MEDIAS);

    clrscr;
    writeln ('-------------------------------------------------------------------------------');
    writeln ('                            HOTEL XYZ LTDA.                                    ');
    writeln ('-------------------------------------------------------------------------------');
    writeln ('                                                       ',HORA,':', MIN,':', SEG);
    writeln;
    writeln ('NOME                DT.ENTRADA          DT.SAIDA        TIPO           VALOR');

    for J := 1 to (I-1) do
    begin
       if (MAT[J,5] > MEDIAS)
         then writeln (MAT[J,1], '      ',MAT[J,2], '      ',MAT[J,3], '       ',MAT[J,4], '        ',MAT[J,5]);
    end;

readkey;
end.