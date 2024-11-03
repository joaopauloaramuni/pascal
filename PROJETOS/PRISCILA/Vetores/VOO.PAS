 program VOO;
 uses CRT;

 var CIDADE : array [1..20] of string [50];
     DIST : array [1..20] of real;
     PROC : string [50];
     PRECO, TEMPO, ESCALAS: real;
     I: integer;
     CONF, ACHOU: char;

 label PROCURA, FIM;

 begin

   clrscr;
   gotoxy (10, 2);
   writeln ('****************************************');
   gotoxy (10, 3);
   writeln ('*********** CIA AEREA VOE BEM  *********');
   gotoxy (10, 4);
   writeln ('****************************************');


   for I:= 1 to 20 do
       begin
            repeat
                  gotoxy (10, 7);
                  write ('Digite o nome da cidade numero ', I, ' para cadastro: ');
                  readln (CIDADE [I]);

                  if (CIDADE [I] = '') then
                     begin
                          gotoxy (10, 13);
                          write ('ERRO! Nome da cidade e obrigatorio!');
                          readkey;
                          gotoxy (10, 13);
                          clreol;
                     end;

            until CIDADE [I] <> '';

            if (CIDADE [I] = 'fim') or (CIDADE [I] = 'FIM') then {break}
            goto PROCURA;

            repeat
                  gotoxy (10, 9);
                  clreol;
                  write ('Digite a distancia de BH a ', CIDADE [I], ': ');
                  readln (DIST [I]);

                  if (DIST [I] < 450) then
                     begin
                          gotoxy (10, 13);
                          write ('ERRO! Digite um valor maior que 450');
                          readkey;
                          gotoxy (10, 13);
                          clreol;
                     end;

            until DIST [I] >= 450;

            gotoxy (10, 7);
            clreol;
            gotoxy (10, 9);
            clreol;

            if (I = 20) then
            begin
                 repeat
                       gotoxy (10, 13);
                       clreol;
                       write('Chegamos ao final do cadastro. Deseja fazer procura? ');
                       readln (CONF);
                       CONF:= upcase (CONF);
                       if (CONF <> 'S') and (CONF <> 'N') then
                       begin
                          gotoxy (10, 15);
                          write ('ERRO! Letra invalida. Digite S ou N!');
                          readkey;
                          gotoxy (10, 15);
                          clreol;
                       end;
                 until (CONF = 'S') or (CONF = 'N');

                 case CONF of
                      'S': goto PROCURA;
                      'N': goto FIM;
                 end;

            end;

       end;


PROCURA:

   clrscr;
   gotoxy (10, 2);
   writeln ('****************************************');
   gotoxy (10, 3);
   writeln ('*********** CIA AEREA VOE BEM  *********');
   gotoxy (10, 4);
   writeln ('****************************************');

   while (true) do
      begin
           gotoxy (10, 7);
           write ('Digite o nome da cidade que deseja procurar: ');
           readln (PROC);
           if (PROC = 'fim') or (PROC = 'FIM') then goto FIM;

           for I := 1 to 20 do
               begin

                    if (PROC = CIDADE [I]) then
                       begin
                         ACHOU := 'S';
                         PRECO := DIST [I] * 0.87;
                         TEMPO := DIST [I] * 60 / 800;

                         if (DIST [I] > 2400) then ESCALAS := int (DIST[I] / 2400);

                         gotoxy (10, 13);
                         write ('Preco da Passagem de BH a ', PROC, ': R$', PRECO:8:2);
                         gotoxy (10, 14);
                         write ('Tempo de Voo de BH a ', PROC, ': ', TEMPO:8:2, ' minutos / ', (TEMPO/60):6:2, ' horas.');
                         gotoxy (10, 15);
                         write ('Numero de escalas de BH a  ', PROC, ': ', ESCALAS:6:0);
                         gotoxy (10, 17);
                         write ('Tecle ENTER para continuar...');
                         readkey;
                         goto PROCURA;

                       end
                          else ACHOU := 'N';

               end;


      if (ACHOU = 'N') then
         begin
              gotoxy (10, 13);
              write ('ERRO! Cidade nao encontrada!');
              readkey;
              gotoxy (10, 13);
              clreol;
              goto PROCURA;
         end;

   end;

FIM:

gotoxy (10, 13);
clreol;
write ('Finalizando o programa. . .');
readkey;

end.