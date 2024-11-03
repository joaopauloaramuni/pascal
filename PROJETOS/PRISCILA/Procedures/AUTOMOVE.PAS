program AUTO;
uses CRT;

var MARCA, MODELO: string[20];
    ANO, VALOR: real;
    OK: char;
    MAT: array[1..99,1..3] of string[20];
    I, J, Z: integer;
    ANOS: string[4];
    IS: string[3];
    VALORS : string[8];


procedure ERRO (MSG: string);
begin
    writeln ('Erro ao digitar o campo: ', MSG, '!');

end;


procedure CONSISTE_ANO;
begin
  if (ANO < 1960) or (ANO > 2030) or (ANO <> int(ANO)) then
    begin
      OK := 'N';
      ERRO ('ANO DE FABRICACAO');
    END
  else OK := 'S';
end;

procedure CONSISTE_VALOR;
begin
  if (VALOR < 1) or (VALOR > 800000) then
  begin
     OK := 'N';
     ERRO ('VALOR DO VEICULO');
  end
  else OK := 'S';
end;


begin

  I:= 1;

  while (true) do
  begin
   clrscr;
   writeln ('LOCADORA DE VEICULOS');
   writeln;
   writeln ('Para sair digite FIM');
   writeln;

   write ('Digite a marca: ');
   readln (MARCA);

   if (MARCA = 'FIM') or (MARCA = 'fim') then break;

   write ('Digite o modelo: ');
   readln (MODELO);

   repeat
    write ('Digite o ano de fabricacao: ');
    readln (ANO);
    CONSISTE_ANO;
   until (OK = 'S');

   repeat
    write ('Digite o valor: ');
    readln (VALOR);
    CONSISTE_VALOR;
   until (OK = 'S');

   str (ANO:4:0, ANOS);
   str (I, IS);
   str (VALOR:10:2, VALORS);

   MAT[I,1] := MARCA[1] + MODELO[1] + ANOS + IS;
   MAT[I,2] := MARCA + '/' + MODELO;
   MAT[I,3] := VALORS;

   I := I + 1;

  end;

clrscr;

writeln ('RESULTADOS FINAIS');
writeln;
writeln;

writeln ('COD. VEIC        MARCA/MODELO        VALOR (R$)');

for J:= 1 to I-1 do
begin
    val (MAT[J,3], VALOR, Z);

    if (VALOR <= 100000)
      then writeln (MAT[J,1], '          ', MAT[J,2], '         ', MAT[J,3]);

end;

readkey;

end.