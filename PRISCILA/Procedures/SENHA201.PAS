program SENHAPROG;
uses CRT;

var NOME: string[10];
    SENHAC, SENHA: string[6];
    CONT, I, J: integer;
    LETRA: char;

procedure erro (nvezes: integer);
begin
    if (nvezes < 5) then
    begin
     writeln ('Senha incorreta. Tentativa: ', nvezes);
     writeln;
    end
    else writeln ('Numero de tentativas esgotada: 5 vezes');
end;


begin

CONT := 0;

    while (true) do
    begin

      clrscr;
      writeln ('PROGRAMA DE CADASTRAMENTO DE SENHA');
      writeln ('Para sair digite FIM no nome do usuario');
      writeln;
      writeln ('Digite o nome do usu rio: ');
      readln (NOME);

      for I:= 1 to length (NOME) do
      begin
           NOME[I] := upcase(NOME[I]);
      end;

      if (NOME = 'FIM') then break;

      writeln (NOME, ' digite a senha correta: ');

      SENHAC := '';

      for I := 1 to 6 do
      begin
         LETRA:= readkey;

         if (ord (LETRA) = 13)
           then break;

         write ('*');
         SENHAC:= SENHAC + LETRA;
      end;

      writeln;

      for J := 1 to 5 do
      begin
       writeln (NOME, ' confirme a senha digitada: ');

       SENHA := '';

      for I := 1 to 6 do
      begin
         LETRA:= readkey;

         if (ord (LETRA) = 13)
           then break;

         write ('*');
         SENHA:= SENHA + LETRA;
      end;

      writeln;

      if (SENHA <> SENHAC) then
      begin
          CONT := CONT + 1;
          erro (CONT);
      end
      else
        begin
          writeln ('Senha confirmada!');
          writeln ('Pressione qualquer tecla para continuar');
          writeln;
          readkey;
          break;
        end;

     end;

  end;

readkey;

end.