program Pacman;
uses crt;

const 
  filas = 10;
  columnas = 20;

type
  t_matriz = array [1..filas, 1..columnas] of char;
  t_pacman = record
    x,y: integer;
    puntos: integer;
  end;

var 
  map: t_matriz;
  pac: t_pacman;
  tecla: char;
  puntos_totales: integer;
  salir: boolean;

procedure InicializarMapa(var m: t_matriz; var p: t_pacman; var total: integer);
var
  i, j: integer;
begin
  total := 0;
  for i := 1 to filas do
    for j := 1 to columnas do
    begin
      if (i = 1) or (i = filas) then
        m[i,j] := '-'   
      else if (j = 1) or (j = columnas) then
        m[i,j] := '|'   
      else
      begin
        m[i,j] := '.';  
        inc(total);
      end;
    end;

  p.x := 5;
  p.y := 10;
  p.puntos := 0;
  m[p.x, p.y] := 'C';
end;

procedure DibujarMapa(const m: t_matriz; const p: t_pacman);
var
  i, j: integer;
begin
  clrscr;
  for i := 1 to filas do
  begin
    for j := 1 to columnas do
      write(m[i,j]);
    writeln;
  end;
  writeln('Puntos: ', p.puntos, ' / ', puntos_totales);
  writeln('Controles: W A S D | Q para salir');
end;

procedure MoverPacman(var m: t_matriz; var p: t_pacman; tecla: char);
var
  nuevaX, nuevaY: integer;
begin
  nuevaX := p.x;
  nuevaY := p.y;

  case tecla of
    'w','W': dec(nuevaX);
    's','S': inc(nuevaX);
    'a','A': dec(nuevaY);
    'd','D': inc(nuevaY);
  end;

  if (m[nuevaX, nuevaY] <> '-') and (m[nuevaX, nuevaY] <> '|') then
  begin
    if m[nuevaX, nuevaY] = '.' then
      inc(p.puntos);

    m[p.x, p.y] := ' ';
    p.x := nuevaX;
    p.y := nuevaY;
    m[p.x, p.y] := 'C';
  end;
end;


begin
  clrscr;
  InicializarMapa(map, pac, puntos_totales);
  salir := false;

  repeat
    DibujarMapa(map, pac);

    if keypressed then
    begin
      tecla := readkey;
      if tecla in ['q','Q'] then
        salir := true
      else
        MoverPacman(map, pac, tecla);
    end;

    delay(1000);
  until salir or (pac.puntos = puntos_totales);

//hola mundo
//tutorial a sofi 

  clrscr;
  writeln('Juego terminado!');
  writeln('Puntaje final: ', pac.puntos, ' / ', puntos_totales);
  if pac.puntos = puntos_totales then
    writeln('¡Ganaste!');
  writeln('Presiona una tecla para salir...');
  readkey;
end.



{toresi}
//juan taverna gay
//olaaaaaaaa