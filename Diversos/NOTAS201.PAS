program NT;
uses CRT;

type NOTAS = record
  num, n1, n2: real;
  nome: string[20];
end;

TESTE = file of NOTAS;

var ARQ: TESTE;
    REG: NOTAS;
    NOME: string[20];
    N1, N2, NUM: real;
    X, I, Z: integer;
    ACHOU : boolean;

begin
    assign (ARQ, 'g:\n.dat');

    (*$I-*)
    reset (ARQ);
    (*$I+*)

    if (IORESULT <> 0) then
    begin
        writeln ('O arquivo nao existe e sera criado');
        rewrite (ARQ);
        readkey;
    end;

    while (true) do
    begin
       I := 0;
       X:= filesize (ARQ);

       clrscr;
       writeln ('ESCOLA ABC');
       writeln ('999 para sair');
       writeln;

       writeln ('Digite o numero do aluno: ');
       readln (NUM);

       if (NUM = 999)
        then break;

       writeln ('Digite o nome do aluno: ');
       readln (NOME);

       writeln ('Digite a nota 1 do aluno: ');
       readln (N1);

       writeln ('Digite a nota 2 do aluno: ');
       readln (N2);

       if (X = 0) then
         begin
             seek (ARQ, X);
             REG.NUM := NUM;
             REG.NOME := NOME;
             REG.N1 := N1;
             REG.N2 := N2;
             write (ARQ, REG);
             writeln ('Registro ', NUM:5:0, ' incluido com sucesso');
         end
         else
           begin
              while (I <= X-1) do
              begin
                 seek (ARQ, I);
                 read (ARQ, REG);
                 if (REG.NUM = NUM) then
                  begin
                     writeln ('A matricula ', NUM:4:0, ' ja existe');
                     READKEY;
                     ACHOU := true;
                     I := X + 1;
                  end
                  else
                   begin
                    I:= I + 1;
                    ACHOU := false;
                   end;
              end;
           end;

         if (ACHOU = FALSE) then
         begin
             seek (ARQ, X);
             REG.NUM := NUM;
             REG.NOME := NOME;
             REG.N1 := N1;
             REG.N2 := N2;
             write (ARQ, REG);
             writeln ('Registro ', NUM:5:0, ' incluido com sucesso');
         end;

   end;

   close (ARQ);

   {Impressao dos valores do arquivo}
   clrscr;
   writeln ('Escola ABC');
   writeln;
   reset (ARQ);
   Z:= 0;
   writeln ('NUM                NOME         N1         N2');

   while not eof (ARQ) do
   begin
     seek (ARQ, Z);
     read (ARQ, REG);
     writeln (REG.NUM:5:2, '    ', REG.NOME, '       ', REG.N1:5:1,'      ', REG.N2:5:1);
     Z := Z + 1;
   end;

   close (ARQ);

readkey;
end.