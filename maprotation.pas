unit maprotation;
{
 procedures for bitmap rotation

  source bitmap is rotated to destination bitmap
  center of bitmap is also center of rotation
  bitmaps must be created / destroyed by other unit
  how to proceed:
  1. create source and destination bitmaps
     set width, height of source map
  2. call setmaps(sourcemap,destinationmap) to set
     - pixelformat to pf32bit
     - size of destinationmap to accomodate all rotations of source map
  3. a. paint or draw in sourcemap
        call coarse|medium|finerotate(angle) to rotate source to destination
     b. load sourcemap from file
        call setmaps(sourcemap,destinationmap) to adjust size of destination map
        call coarse|medium|finerotate(angle) to rotate source to destination
  note: angle is in degrees (0..360)

  work:
  1 - 11 - 2013
  coarse/medium : for loop for quadrants, common code function removed
  4 - 11 - 2013
  fine rotate code added
}

interface

uses graphics,types;

procedure setmaps(sm,dm : Tbitmap);
procedure CoarseRotate(deg : word);
procedure mediumRotate(deg : word);
procedure FineRotate(deg : word);

implementation

type PDW = ^dword;
     Toffset = record
                fx : single;
                fy : single;
               end;

const deg2rad = pi/180;

var SBM,DBM : Tbitmap;
    dcxy : word;     //destination center x = y
    scx,scy : word;  //center of source map
    PSBM : dword;    //pointer to source map
    Slinestep : dword;    //pointer difference between rows
    PDBM : dword;    //pointer to destination map
    Dlinestep : dword;    //...
//
    offset : array[1..4,0..8] of Toffset;//fine rotate offsets per quadrant

procedure setmaps(sm,dm : Tbitmap);
//select source bitmap, adjust size of destination map
var w,h : single;
begin
 SBM := sm;
 SBM.PixelFormat := pf32bit;
 DBM := dm;
 DBM.PixelFormat:= pf32bit;
 DBM.Canvas.Brush.Color := $ffffff;
 scx := (SBM.width-1) div 2;
 scy := (SBM.height-1) div 2;
 w := SBM.width;
 h := SBM.height;
 DBM.Width := trunc(sqrt( w*w + h*h)+2) or 1;//set odd dimensions
 DBM.Height := DBM.Width;
 dcXY := DBM.width div 2;
 PSBM := dword(sbm.scanline[0]);
 Slinestep := PSBM - dword(sbm.scanline[1]);
 PDBM := dword(dbm.scanline[0]);
 Dlinestep := PDBM - dword(dbm.scanline[1]);
end;

procedure CoarseRotate(deg : word);
//fast rotation
//scan pixels of source map and copy to destination map
var x,y,tx,ty,tt : word;
    xtx,xty,ytx,yty : single;
    radians,vsin,vcos : single;
    pix,Ybase1,Ybase2,PS,PD : dword;
    i : byte;
begin
 with dbm do with canvas do
  begin
   brush.Style := bsSolid;
   fillrect(rect(0,0,width,height)); //erase with existing brush
  end;
 radians := deg*deg2rad;
 vsin := sin(radians);
 vcos := cos(radians);
 for y := 0 to scy do
  begin
   yty := y*vcos;
   ytx := y*vsin;
   Ybase1 := PSBM - (scy + y)*Slinestep;
   tt := scy - y;
   Ybase2 := PSBM - tt*Slinestep;
   for x := 0 to scx do
    begin
     xtx := x*vcos;
     xty := x*vsin;
     for i := 1 to 4 do
      begin
       case i of
        1 : begin
             tx := dcxy + trunc(xtx - ytx);
             ty := dcxy + trunc(xty + yty);
             tt := scx + x;
             PS := Ybase1 + (tt shl 2);
            end;
        2 : begin
             tt := scx - x;
             PS := Ybase1 + (tt shl 2);
             tx := dcxy + trunc(-xtx - ytx);
             ty := dcxy + trunc(-xty + yty);
            end;
        3 : begin
             PS := Ybase2 + (tt shl 2);
             tx := dcxy + trunc(-xtx + ytx);
             ty := dcxy + trunc(-xty - yty);
            end;
        4 : begin
             tt := scx + x;
             PS := Ybase2 + (tt shl 2);
             tx := dcxy + trunc(xtx + ytx);
             ty := dcxy + trunc(xty - yty);
            end;
       end;//case
       pix := PDW(PS)^;
       PD := PDBM - ty*Dlinestep + (tx shl 2);
       PDW(PD)^ := pix;
      end;//for i
//
    end;//for x
  end;//for y
end;

procedure mediumrotate(deg : word); 
//medium quality rotation
//scan pixels of destination map and copy from source map
var x,y,tt : word;
    tx,ty,xtx,xty,ytx,yty : single;
    radians,vsin,vcos : single;
    pix,Ybase1,Ybase2,PS,PD,colr : dword;
    ttx,tty : word;
    trunctx,truncty : smallInt;
    var i : byte;
begin
 colr := DBM.canvas.brush.color;
 radians := deg2rad*deg;
 vsin := sin(radians);
 vcos := cos(radians);
 for y := 0 to dcxy do
  begin
   yty := y*vcos;
   ytx := y*vsin;
   Ybase1 := PDBM - (dcxy + y)*Dlinestep;
   tt := dcxy - y;
   Ybase2 := PDBM - tt*Dlinestep;
   for x := 0 to dcxy do
    begin
     xtx := x*vcos;
     xty := x*vsin;
//
     for i := 1 to 4 do          //for all quadrants
      begin
       case i of
        1 : begin
             PD := Ybase1 + ((dcxy+x) shl 2);
             tx := xtx + ytx;
             ty := -xty + yty;
            end;
        2 : begin
             tt := dcxy - x;
             PD := Ybase1 + (tt shl 2);
             tx := -xtx + ytx;
             ty := xty + yty;
            end;
         3 : begin
              PD := Ybase2 + (tt shl 2);
              tx := -xtx - ytx;
              ty := xty - yty;
             end;
         4 : begin
              PD := Ybase2 + ((dcxy + x) shl 2);
              tx := xtx - ytx;
              ty := -xty - yty;
             end;
       end;//case
       trunctx := trunc(tx);
       truncty := trunc(ty);
        if (abs(trunctx) > scx) or (abs(truncty) > scy) then PDW(PD)^ := colr
         else
          begin
           ttx := scx + trunctx;
           tty := scy + truncty;
           PS := PSBM - tty*Slinestep + (ttx shl 2);
           pix := PDW(PS)^;
           PDW(PD)^ := pix;
          end;
      end;//for i
//
    end;//for x
  end;//for y
end;

procedure FineRotate(deg : word);
//hi quality rotation
//scan destination map per quarter bit and copy from source map
var x,y,tt : word;
    tx,ty,xtx,xty,ytx,yty : single;
    radians,vsin,vcos : single;
    pix,Ybase1,Ybase2,PS,PD,colr : dword;
    ttx,tty : word;
    trunctx,truncty : smallInt;
    i,j,quad : byte;
    vi,vj : single;
    sumR,sumG,sumB : word;     //color sums
    bgR,bgG,bgB : byte;
begin
 colr := DBM.canvas.brush.color;
 bgR := (colr shr 16) and $ff;
 bgG := (colr shr 8) and $ff;
 bgB := colr and $ff;
 radians := deg2rad*deg;
 vsin := sin(radians);
 vcos := cos(radians);

// build offset table

 for j := 0 to 2 do             //offsets y
  begin
   vj := 0.333*j;
   yty := vj*vcos;
   ytx := vj*vsin;
   for i := 0 to 2 do            //       x
    begin
     vi := 0.333*i;
     xtx := vi*vcos;
     xty := vi*vsin;
     for quad := 1 to 4 do
      with offset[quad,i + 3*j] do
       case quad of
        1 : begin
             fx := xtx + ytx;
             fy := -xty + yty;
            end;
        2 : begin
             fx := -xtx + ytx;
             fy := xty + yty;
            end;
        3 : begin
             fx := -xtx - ytx;
             fy := xty - yty;
            end;
        4 : begin
             fx := xtx - ytx;
             fy := -xty - yty;
            end;
       end;//case
    end;//for j
  end;//for i

// pixel scanning

 for y := 0 to dcxy do
  begin
   yty := y*vcos;
   ytx := y*vsin;
   Ybase1 := PDBM - (dcxy + y)*Dlinestep;
   tt := dcxy - y;
   Ybase2 := PDBM - tt*Dlinestep;
   for x := 0 to dcxy do
    begin
     xtx := x*vcos;
     xty := x*vsin;
//
     for i := 1 to 4 do          //for all quadrants
      begin
       case i of
        1 : begin
             PD := Ybase1 + ((dcxy+x) shl 2);
             tx := xtx + ytx;
             ty := -xty + yty;
            end;
        2 : begin
             tt := dcxy - x;
             PD := Ybase1 + (tt shl 2);
             tx := -xtx + ytx;
             ty := xty + yty;
            end;
         3 : begin
              PD := Ybase2 + (tt shl 2);
              tx := -xtx - ytx;
              ty := xty - yty;
             end;
         4 : begin
              PD := Ybase2 + ((dcxy + x) shl 2);
              tx := xtx - ytx;
              ty := -xty - yty;
             end;
       end;//case

// subpixel scanning

       sumR := 0;
       sumG := 0;
       sumB := 0;
       for j := 0 to 8 do
        begin
         trunctx := trunc(tx + offset[i,j].fx);
         truncty := trunc(ty + offset[i,j].fy);
          if (abs(trunctx) > scx) or (abs(truncty) > scy) then
           begin
            sumR := sumR + bgR;
            sumG := sumG + bgG;
            sumB := sumB + bgB;
           end
           else
            begin
             ttx := scx + trunctx;
             tty := scy + truncty;
             PS := PSBM - tty*Slinestep + (ttx shl 2);
             pix := PDW(PS)^;
             sumR := sumR + ((pix shr 16) and$ff);
             sumG := sumG + ((pix shr 8) and $ff);
             sumB := sumB + (pix and $ff);
            end;
        end;//for j
        sumR := sumR div 9;
        sumG := sumG div 9;
        sumB := sumB div 9;
        pix := (sumR shl 16) or (sumG shl 8) or sumB;
        PDW(PD)^ := pix;
      end;//for i quadrants
//
    end;//for x
  end;//for y
end;

end.

