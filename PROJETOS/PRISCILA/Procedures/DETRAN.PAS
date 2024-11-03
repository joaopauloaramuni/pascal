program DETRAN;
uses CRT;

var placa: string[7];
    data, mediac, valorc: string[10];
    soma, valor, dia, mes, ano, media: real;
    parametro_erro: string[5];
    z, cont, validaplaca : integer;
    ok: char;
    relat : array [1..100,1..3] of string[10];

procedure erro (msg:string);
begin
    writeln ('Dado digitado errado: ', msg, '. Digite novamente.');
    writeln;
end;

procedure consiste_data_multa;
begin
    OK:= 'N';
    val (data[1]+data[2], dia, z);
    val (data[4]+data[5], mes, z);
    val (data[7]+data[8]+data[9]+data[10], ano, z);

    if (dia < 1) or (dia > 31) or (mes < 1) or (mes > 12) or (ano < 1980) or (ano > 2009) then
         begin
           parametro_erro := 'DATA';
           erro (parametro_erro);
           ok := 'N';
         end
         else ok := 'S';
end;

begin
clrscr;
cont := 0;
soma := 0;

writeln ('              DEPARTAMENTO DE TRANSITO DE MINAS GERAIS');
writeln ('                   Para sair digite placa = 000');
writeln;
writeln;
writeln;

 while (true) do
  begin
     writeln;
     writeln;
     write ('Digite a placa: ');
     readln (placa);

     if (placa = '000') then break;

     val (placa[4]+placa[5]+placa[6]+placa[7], validaplaca, z);

     while (upcase(placa[1]) < 'A') or (upcase(placa[1]) > 'Z') or (upcase(placa[2]) < 'A') or (upcase(placa[2]) > 'Z')
     or (upcase(placa[3]) < 'A') or (upcase(placa[3]) > 'Z') or (z <> 0) or (length (placa) <> 7) do
     begin
          parametro_erro := 'PLACA';
          erro (parametro_erro);
          readln (placa);
          val (placa[4]+placa[5]+placa[6]+placa[7], validaplaca, z);
     end;

     writeln;
     writeln;

     ok := 'N';

     while (ok <> 'S') do
     begin
        write ('Digite a data da multa (dd/mm/aaaa): ');
        readln (data);
        consiste_data_multa;
     end;

     writeln;
     writeln;

     valor := -1;

     while (valor <= 0) do
     begin
       write ('Digite o valor da multa: R$');
       readln (valor);
       if (valor < 0) then
        begin
          parametro_erro := 'VALOR DA MULTA';
          erro (parametro_erro);
        end;
     end;

     soma := soma + valor;
     cont := cont + 1;

     str (valor:8:2, valorc);

     relat[cont,1] := placa;
     relat[cont,2] := data;
     relat[cont,3] := valorc;

  end;

  {Relat¢rio Final}
  if (cont > 0) then
  begin
     media := soma / cont;
     clrscr;
     writeln ('             RESULTADOS FINAIS');
     writeln;
     writeln;
     writeln;
     writeln ('Media de valores das multas: R$', media:8:2);
     writeln ('Soma de valores das multas: R$', soma:8:2);
     writeln;
     writeln;
     writeln;
     writeln ('PLACA           DATA DA MULTA     VALOR (R$)');

     for z:= 1 to cont do
       begin
           str (media:8:2, mediac);
           if (relat[z,3] > mediac) then
             begin
               writeln (relat[z,1],'          ',relat[z,2],'       ',relat[z,3]);
             end;
       end;

  end;


readkey;
end.