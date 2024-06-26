program loderunner;
uses ptcgraph,ptccrt,SysUtils,Logger;
Type
   TSmallBitmapBuffer = packed record
                           width,
                           height,
                           reserved: longint;
                           data:     array[0..40000] of word;
                        end;
var men1,men2,men3,brick,lad,stone:Tsmallbitmapbuffer;
    ver:array[0..26,0..32] of string[1];
procedure firstscr;
var gd,gm:smallint;
    left:char;
begin
gd:=VGA;
gm:=VGAHi;
initgraph (gd,gm,'');
cleardevice;
settextstyle(1,0,9);
setcolor(1);
outtextxy(50,2,'LODE');
outtextxy(100,90,'RUNNER');
setlinestyle(0,0,3);
setcolor(red);
rectangle(450,200,600,210);
rectangle(450,215,600,225);
settextstyle(1,0,1);
setcolor(2);
outtextxy(40,250,'Spectrum version:Broderbund & Software Projects 1984');
outtextxy(200,270,'IBM version:Phane 1993');
readkey;
end;
procedure MEN;
var graphic:text;
    i,j,k:integer;
    elem:char;
    SIZE:INTEGER;
label l;
BEGIN
cleardevice;
assign(graphic,'graphic.dat');
reset(graphic);
for i:=0 to 2  do
begin
for j:=1 to 40 do
begin
for k:=1 to 32 do
begin
read(GRAPHIC,elem);
if elem='z' then putpixel(400+K,40*i+40+j,BROWN);
IF ELEM='r' THEN PUTPIXEL(400+K,40*i+40+J,RED);
IF ELEM='b' THEN PUTPIXEL(400+K,40*i+40+J,BLUE);
IF ELEM='a' THEN PUTPIXEL(400+K,40*i+40+J,WHITE);
if elem=#13 then goto l;
end;                                    
l:readln(graphic);
end;
end;
setcolor(brown);
setlinestyle(0,0,1);
moveto(442,40);
linerel(30,0);
linerel(0,20);
linerel(-30,0);
linerel(0,-20);
moveto(442,61);
linerel(30,0);
linerel(0,20);
linerel(-30,0);
linerel(0,-20);
moveto(442,71);
linerel(30,0);
moveto(449,61);
linerel(0,10);
moveto(465,71);
linerel(0,10);
setcolor(yellow);
moveto(442,83);
linerel(0,20);
moveto(472,83);
linerel(0,20);
moveto(442,93);
linerel(30,0);
size:=imagesize(400,40,440,80);
{getmem(men1,size);
getmem(men2,size);
getmem(men3,size);
getmem(brick,size);
getmem(stone,size);
getmem(lad,size);}
getimage(401,41,440,81,men1);
getimage(401,81,440,121,men2);
getimage(401,121,440,161,men3);
getimage(442,40,472,60,stone);
getimage(442,61,472,81,brick);
getimage(442,83,472,103,lad);
i:=400;
repeat
putimage(i,300,men1,0);
delay(60);
putimage(i-3,300,men2,0);
delay(100);
putimage(i-5,300,men3,0);
delay(60);
i:=i-8;
until i<0;
close(graphic);
end;
procedure menu;
const
q:array[1..8] of string=('B','Y',' ','P','H','A','N','E');
str='            AFTER ORIGINAL STORY OF LODERUNNER, PHANE MADE A REMAKE ON IBM MACHINES.            ';
str1='            NOW PRESS R-TO REDEFINE KEYS,S-TO START GAME OR A-TO ALTER SCREENS              ';

var substr,A,B,C,D:string;
    i,SUS:integer;
    p:pointer;
    size:word;
    HS:TEXT;
    UP,DOWN,FIRE,LEFT,RIGHT:LongInt;
procedure stars;
 var x,y,color:integer;
begin
x:=random(getmaxx);
y:=random(getmaxy);
color:=random(14)+1;
putpixel(x,y,color);
putpixel(x+1,y,color);
putpixel(x-1,y,color);
putpixel(x,y-1,color);
putpixel(x,y+1,color);
putpixel(x,y+2,color);
putpixel(x,y-2,color);
putpixel(x-2,y,color);
putpixel(x+2,y,color);
putpixel(x-1,y-1,color);
putpixel(x-1,y+1,color);
putpixel(x+1,y-1,color);
putpixel(x+1,y+1,color);
delay(150);
color:=0;
putpixel(x,y,color);
putpixel(x+1,y,color);
putpixel(x-1,y,color);
putpixel(x,y-1,color);
putpixel(x,y+1,color);
putpixel(x,y+2,color);
putpixel(x,y-2,color);
putpixel(x-2,y,color);
putpixel(x+2,y,color);
putpixel(x-1,y-1,color);
putpixel(x-1,y+1,color);
putpixel(x+1,y-1,color);
putpixel(x+1,y+1,color);
end;
procedure draws;
begin
setcolor(blue);
setlinestyle(solidln,0,1);
moveto(350,180);
linerel(-30,0);
linerel(-69,63);
linerel(0,20);
linerel(81,9);
linerel(18,-4);
linerel(0,-87);
linerel(-60,54);
linerel(30,4);
linerel(0,-9);
linerel(13,-13);
linerel(0,54);
linerel(0,-54);
linerel(-20,20);
linerel(7,-7);
linerel(0,21);
linerel(-67,-8);
setfillstyle(hatchfill,blue);
floodfill(340,182,blue);
setfillstyle(closedotfill,blue);
floodfill(260,245,blue);
end;
procedure fondu(j:integer);
var i:integer;
begin
for i:=1 to 15 do setpalette(i,j);
end;
procedure normal;
var i:integer;
begin
for i:=1 to 15 do setpalette(i,i);
setrgbpalette(1,0,0,31);
end;
procedure effect;
VAR I:INTEGER;
begin
FOR I:=1 TO 1000 DO
setpalette(random(14)+1,random(14)+1);
end;

FUNCTION GetKey:LONGINT;
VAR InKey: LONGINT;
BEGIN
 InKey:=ORD(ReadKey);
 IF InKey=0 THEN InKey:=ORD(ReadKey) SHL 8;
 
 {if InKey > 0 then
	Log.LogStatus(Format('Key: %d', [InKey]), 'GetKey');}
 
 GetKey:=InKey;
END;

procedure REDEFINE;forward;
procedure GAME;forward;
procedure KEYS;
var ch:char;
var key:longint;
begin
{
if keypressed then begin
                   ch:=readkey;
                   if ch=#114 then REDEFINE;
                   IF CH=#115 THEN GAME;
                   end
               else ch:=#0;
}

repeat
key:=GetKey;

{Log.LogStatus(Format('Key: %d', [key]), 'KEYS');}

case key of
	114: REDEFINE; { key: R }
	115: GAME;	{ key: S }
end;	

until key > 0;

end;

procedure REDEFINE;
begin
{
cleardevice;
settextstyle(1,0,2);
setcolor(5);
outtextxy(100,100,'Left');
left:=readkey;
SETCOLOR(4);
outtextxy(200,100,left);
delay(100);
SETCOLOR(5);
outtextxy(100,150,'RIGHT');
RIGHT:=READKEY;
SETCOLOR(4);
OUTTEXTXY(200,150,RIGHT);
DELAY(100);
SETCOLOR(5);
OUTTEXTXY(100,200,'UP');
UP:=READKEY;
SETCOLOR(4);
OUTTEXTXY(200,200,UP);
DELAY(100);
SETCOLOR(5);
OUTTEXTXY(100,250,'DOWN');
DOWN:=READKEY;
SETCOLOR(4);
OUTTEXTXY(200,250,DOWN);
DELAY(100);
SETCOLOR(5);
OUTTEXTXY(100,300,'FIRE');
FIRE:=READKEY;
SETCOLOR(4);
OUTtEXTXY(200,300,FIRE);
DELAY(1200);
MENU;
}
end;

procedure GAME;
VAR LEVEL:TEXT;
    IMG,ch:CHAR;
	key:LongInt;
    i,j,ox,oy,mx,my:integer;
label jm,gm;
BEGIN
cleardevice;
SETTEXTSTYLE(1,1,1);
ASSIGN(LEVEL,'LEVELS.DAT');
RESET(LEVEL);
FOR j:=0 TO 24 DO
BEGIN
FOR i:=0 TO 30 DO
BEGIN
READ(LEVEL,IMG);
if img='l' then begin
                putimage(i*20,j*20,lad,normalput);
                ver[j,i]:='l';
                end;
if img='s' then begin
               putimage(i*20,j*20,stone,normalput);
                ver[j,i]:='s';
                end;

if img='b' then begin
               putimage(i*20,j*20,brick,normalput);
                ver[j,i]:='b';
                end;

if img=#13 then goto jm;
END;
jm:readln(LEVEL);
END;
oy:=360;ox:=20;mx:=0;my:=20;i:=1;putimage(ox,oy,men1,1);

gm:
	key := GetKey;
	
               if key=left then begin
                               if i=1 then putimage(20*mx,20*my,men1,1);
                               if i=2 then putimage(ox,oy,men2,1);
                               if i=3 then putimage(ox,oy,men3,1);
                               ox:=ox-5;
                                 if ox div 20=int(oy div 20) then mx:=mx-1;
                               dec(i);
                               if i=0 then i:=3;
                               if i=1 then putimage(ox,oy,men1,1);
                               if i=2 then putimage(ox,oy,men2,1);
                               if i=3 then putimage(ox,oy,men3,1);
                               end;
                if key=right then begin
                               if i=1 then putimage(ox,oy,men1,1);
                               if i=2 then putimage(ox,oy,men2,1);
                               if i=3 then putimage(ox,oy,men3,1);
                               ox:=ox+5;
                               inc(i);
                               if ox div 20=int(oy div 20) then mx:=mx+1;
                               if i=4 then i:=1;
                               if i=1 then putimage(ox,oy,men1,1);
                               if i=2 then putimage(ox,oy,men2,1);
                               if i=3 then putimage(ox,oy,men3,1);
                               end;
                if key=up then begin
                                putimage(ox,oy,men1,1);
                                oy:=oy-5;
                                if oy div 20=int(oy div 20) then my:=my-1;
                                if ver[my,mx]='l' then begin putimage(ox,oy,men1,1);
                                                             end
                                                       else begin
                                                       oy:=oy+5;
                                                       putimage(ox,oy,men1,1);
                                                       end;
                              end;
               
goto gm;
readkey;
END;
label jump;
begin
{taste} 
left:=111; { 'o' }
right:=112; { 'p' }
up:=113; { 'q' }
down:=122; { 'z' }
fire:=109; { 'm' }
cleardevice;
game;
settextstyle(1,0,4);
setcolor(red);
outtextxy(180,2,'LODERUNNER ONE');
SUS:=1;
size:=imagesize(180,1,455,35);
getmem(p,size);
getimage(180,1,455,35,p^);
jump: for i:=SUS to 31 do putimage(180,i,p^,normalput);
SUS:=SuS+6;
for i:=31 downto SUS do putimage(180,i,p^,normalput);
if SUS<31 then goto jump;
setcolor(blue);
outtextxy(179,31,'LODERUNNER ONE');
settextstyle(1,0,2);
setcolor(red);
outtextxy(460,61,'BY PHANE');
setcolor(darkgray);
outtextxy(459,61,'BY PHANE');
draws;
size:=imagesize(0,0,120,10);
getmem(p,size);
getimage(0,0,120,10,p^);
for i:=15 to 120 do
begin
substr:=copy(str,i-14,14);
settextstyle(0,0,1);
setcolor(magenta);
stars;
keys;
putimage(250,300,p^,normalput);
outtextxy(250,300,substr);
END;
for i:=15 to 120 do
begin
substr:=copy(str1,i-14,14);
settextstyle(0,0,1);
setcolor(magenta);
KEYS;
putimage(250,300,p^,normalput);
outtextxy(250,300,substr);
stars;
end;
fondu(1);
for i:=31 downto 0 do begin
delay(5);
 setrgbpalette(1,0,0,i);
 end;
fondu(0);
cleardevice;
normal;
assign(hs,'high.dat');
reset(hs);
settextstyle(4,0,3);
outtextxy(200,100,'HIGH SCORE TABLE');
SETTEXTSTYLE(3,0,1);
FOR I:=1 TO 4 DO BEGIN
READLN(HS,A);
SETCOLOR(RANDOM(14)+1);
OUTTEXTXY(100,150+30*I,A);
SETCOLOR(RANDOM(14)+1);
READLN(HS,B);
OUTTEXTXY(300,150+30*I,B);
SETCOLOR(RANDOM(14)+1);
READLN(HS,C);
OUTTEXTXY(400,150+30*I,C);
END;
close(hs);
effect;
normal;
fondu(1);
for i:=31 downto 0 do begin
delay(5);
 setrgbpalette(1,0,0,i);
 end;
fondu(0);
cleardevice;
normal;
menu;
end;
begin
randomize;
firstscr;
men;
menu;
 end.