program REVISAO;
uses CRT;

type XYZ = record
  cpf: string[11];
  nome: string[20];
  endereco: string[40];
end;

ARQ = file of XYZ;

var ARQUI: ARQ;
    REG: XYZ;
    CPF: string[11];
    NOME: string[20];
    ENDERECO: string[40];
    OP, K, I, J: integer;
    ACHOU: boolean;


begin

   assign (ARQUI, 'g:\revisao.dat');

   (*$I-*)
   reset (ARQUI);
   (*$I+*)

   if (ioresult <> 0) then rewrite (ARQUI);

   while (true) do
   begin
      clrscr;
      writeln ('Revisao');
      writeln;
      writeln ('Digite a opcao: ');
      writeln ('1 - Incluir / 2 - Alterar / 3 - Excluir / 0 - Sair');
      readln (OP);

      case OP of
         0: break;

         1: begin
              writeln;
              writeln ('Digite o CPF: ');
              readln (CPF);
              writeln ('Digite o nome: ');
              readln (NOME);
              writeln ('Digite o endereco: ');
              readln (ENDERECO);

              K:= filesize (ARQUI);

              if (K = 0) then
              begin
                 seek (ARQUI, K);
                 REG.CPF := CPF;
                 REG.NOME := NOME;
                 REG.ENDERECO := ENDERECO;
                 write (ARQUI, REG);
                 writeln ('Registro incluido com sucesso!');
              end
              else
               begin
                   I:= 0;
                   ACHOU := false;
                   while (I < K) do
                   begin
                      seek (ARQUI, I);
                      read (ARQUI, REG);

                      if (REG.CPF = CPF) then
                      begin
                        ACHOU := true;
                        I := K + 1;
                        writeln ('O registro ', CPF, ' ja existe');
                        readkey;
                      end
                        else I := I + 1;
                   end;
               end;

               if (ACHOU = false) then
                 begin
                  seek (ARQUI, K);
                  REG.CPF := CPF;
                  REG.NOME := NOME;
                  REG.ENDERECO := ENDERECO;
                  write (ARQUI, REG);
                  writeln ('Registro incluido com sucesso!');
                  readkey;
                 end;
            end;

            2: begin

               K:= filesize (ARQUI);

               if (K = 0) then
                 writeln ('Nao existem dados a serem alterados')

                 else
                    begin

                       I:= 0;
                       writeln ('Digite o CPF que deseja alterar: ');
                       readln (CPF);

                      while (I < K) do
                       begin

                       seek (ARQUI, I);
                       read (ARQUI, REG);

                       if (REG.CPF = CPF) then
                       begin
                         writeln ('Digite o novo nome: ');
                         readln (NOME);

                         writeln ('Digite o novo endereco: ');
                         readln (ENDERECO);
                         seek (ARQUI, I);
                         REG.NOME := NOME;
                         REG.ENDERECO := ENDERECO;
                         write (ARQUI, REG);

                         writeln ('Registro alterado com sucesso');
                         readkey;
                         I := K + 1;
                      end
                      else I:= I + 1;

                     end;
                    end;

            end;

      end; {do case}

   end; {do while true}

close (ARQUI);
clrscr;

reset (ARQUI);
writeln ('Relatorio Geral');
writeln;
writeln ('CPF         NOME             ENDERECO');

J:= 0;

while not eof (ARQUI) do
begin
  seek (ARQUI, J);
  read (ARQUI, REG);
  writeln (REG.CPF, '          ', REG.NOME, '       ', REG.ENDERECO);
  J:= J + 1;
end;

readkey;
end.