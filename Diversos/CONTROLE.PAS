program control2;   { programa exemplo de controle de informacoes de mercadorias }
uses crt;

type item = record                      { declaracao da estrutura do arquivo }
               STATUS     : char;
               CODIGO     : string[4];
               DESCRICAO  : string[20];
               QUANTIDADE : integer;
               PRECO      : real;
            end;

var
   EST           : file of item;  { declaracao da identificacao do arquivo baseado na formatacao do registro item }
   BUFREG        : item;          { buffer para trabalho em memoria com formatacao igual ao registro item }
   OPCAO , ABRIU, RESP : char;


{******* CHAMADA DOS ARQUIVOS DE INCLUSAO *******}
{$I GERAL}   {PROCEDURES E FUNCOES COMUNS AOS 4 PROGRAMAS SEGUINTES}
{$I INC}     {PROCEDURE DE INCLUSAO DE REGISTROS}
{$I ALT}     {PROCEDURE DE ALTERACAO DE REGISTROS}
{$I EXC}     {PROCEDURE DE EXCLUSAO DE REGISTROS}
{$I PES}     {PROCEDURE DE PESQUISA SEQUENCIAL E APRESENTACAO DE REGISTROS NA TELA}


{******* PROGRAMA PRINCIPAL *****************************************************************}
begin
   clrscr;
   gotoxy(3,4);writeln( 'SISTEMA EXEMPLO DE CONTROLE DE CADASTRO DE MERCADORIAS');
   assign (EST,'ESTOQUE.DAT');  { associa identificador EST (p/ ser utilizado no programa) com o nome do arquivo no disco }
   (*$I-*);                     { desativacao da diretiva do compilador p/ verificacao de erros de entrada/saida }
   reset (EST);                 { abertura do arquivo de dados }
   (*$I+*);                     { ativacao da diretiva de verificacao de erros de entrada/saida }
   if ioresult <> 0 then        { se houve erro na abertura do arquivo, ou seja, se nao existe o arquivo }
      begin
         writeln(chr(7));
         gotoxy(05,22); writeln('Arquivo "ESTOQUE.DAT" Nao foi encontrado para ser aberto.');
         gotoxy(05,23); write  ('Deseja cria-lo (S/N) ? ');
         repeat
            RESP := upcase(readkey);
         until RESP in ['S','N'];
         if RESP = 'S' then
            begin
               rewrite(EST);      { funcao para criar o arquivo }
            end
         else
            begin
               write(chr(7));
               gotoxy(05,23); write('*** Finalizando o processamento....<ENTER>');
               repeat until keypressed;
               halt;       { termina o processamento }
            end;
      end;

   repeat
      clrscr;
      gotoxy(10,4);writeln( '*** SISTEMA EXEMPLO DE CONTROLE DE CADASTRO DE MERCADORIAS ***');
      gotoxy(31,09); writeln(' 1]  Incluir    ');
      gotoxy(31,11); writeln(' 2]  Alterar    ');
      gotoxy(31,13); writeln(' 3]  Excluir    ');
      gotoxy(31,15); writeln(' 4]  Pesquisar  ');
      gotoxy(31,17); writeln(' 5]  Finalizar  ');
      gotoxy(31,19); write  (' **  Opcao ?    ');
      repeat
            OPCAO := readkey;
      until OPCAO in ['1'..'5'];
      case OPCAO of
              '1' : INCLUIR;
              '2' : ALTERAR;
              '3' : EXCLUIR;
              '4' : PESQUISA;
              '5' : clrscr;
      end; {case}
   until OPCAO = '5';
   close(EST);  { fecha o arquivo no disco }
end.
