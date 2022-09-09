program SENHA;
uses CRT;
var nome: string[10];
    senha1, senha2:string[6];
    I, CONT1, CONT: integer;
    letra: char;
   procedure teste (s: string);
    begin
     if (s <> '123456') then
     begin
       gotoxy(25,8);
       writeln('Senha incorreta!');
       gotoxy(25,9);
       readkey;
       gotoxy(25,9);
       clreol;
       gotoxy(25,8);
       clreol;
     end
       else if (s = '123456') then
       begin
        gotoxy(25,9);
        writeln('Senha correta!');
        cont := 6;
        gotoxy(25,10);
        writeln('Pressione qualquer tecla para sair...');
        gotoxy(25,11);
        readkey;
       end;
    end;
begin
  CONT:= 0;
  CONT1:= 1;
  while (true) do
  begin
   clrscr;
   if (nome = 'fim') or (nome = 'FIM') or (cont>5)
   then break;
   gotoxy(25,4);
   writeln('** PROGRAMA SENHA **');
   gotoxy(25,6);
   writeln('DIGITE SEU NOME: ');
   gotoxy(25,7);
   readln(nome);
   gotoxy(25,7);
   clreol;
   gotoxy(25,6);
   clreol;
   while (CONT <= 5) do
   begin
    for I:= 1 to length (nome) do
    nome[I]:= upcase(nome[I]);
    gotoxy(25,6);
    writeln(nome,' DIGITE A SENHA: ');
    senha2:= '';
    gotoxy(25,7);
    for  CONT1:= 1 to 6 do
    begin
     letra:= readkey;
     senha2 := senha2 + letra;
     write('*');
    end;
    if (senha2 <> '123456') then
    CONT:= CONT + 1;
    teste (senha2);
    gotoxy(25,7);
    clreol;
   end;
  end;
end.