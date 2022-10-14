unit UnitTogether;

interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.MPlayer;
  type
  TMyCanvas = class(TCanvas)
    procedure Circle(Rad, X, Y: integer);
    procedure Square(Size, X, Y: integer);
  end;

  humanFrame = (step1, step2, jump);//для бега

  TArm = record
    angle1, angle2: integer;
  end;

  TLeg = record
    angle1, angle2, angle3: integer;
  end;

 //зарядка
  TMan = class
    Constructor Create(X, Y, ManSize: integer);
    procedure Paint(const Canvas: TCanvas);
    procedure PricedAnim();
    procedure JumpAnim();
    procedure VypadLeft();
    procedure VypadRight();
    procedure JumpUp();
    procedure Shpagat();
    procedure Priced();
    procedure HeadTiltRight();
    procedure HeadTiltLeft();
    procedure KolesoUp();
    procedure KolesoDown();
    procedure VypadAnimLeft();
    procedure VypadAnimRight();
    procedure ShpagatAnim();
    procedure StartPos();
    procedure KolesoAnim();
    procedure HeadTiltAnim();
    procedure TurnOnMusic();
    procedure WalkAnim();
    procedure BodyTiltRight;
    procedure BodyTiltLeft;
    procedure BodyTiltAnim;
    procedure Step1();
    procedure Step2();

    const
      ManSize = 240;
      startX = 100;
      startY = 250;
      finishX = 1000;
      finishY = 200;
      //коэффициенты для определения пропорций длины части тела относительно размера тела
      body = 0.4;
      shoulder = 0.75;//высота плеч относительно туловища
      arm = 0.18;
      leg = 0.2;
      head = 0.1;
      foot = 0.08;
      move = 0.2;

    private
      bodyX, bodyY, Y, X, bodySize, headAngle: integer;
      leftArm, rightArm: TArm;
      leftLeg, rightLeg: TLeg;
      stage: integer;
      armX, armY, legX, legY, headX, headY: integer;
      bodyAngle: integer;
      procedure SetX(const val: integer);
      procedure SetY(const val: integer);
    public
      Size: integer;
      property posX: integer read X write SetX;
      property posY: integer read Y write SetY;
  end;


  const
  // Турникмен
   ruk=30;
   x1 = 200; x2 = 200 ; y1 = 280; y2 = 370;  //koord tela
   k1 = 15; //koord golovy
   yruky1 = 20; yruky2 = 70; xruky = 50; //koord ruk
   ynog = 70; xnog = 40; //koord nog
   //hozhdenie
   xh1 = 55; xh2 = 55; yh1 = 330; yh2 = 465;  //koord tela
   kh1 = 18; //koord golovy
   yrukyh1 = 20; yrukyh2 = 110; xrukyh = 80; //koord ruk
   ynogh = 85; xnogh = 60; //koord nog

   xr1 = 71; yr1 = 68; xr2 = 20; //koord ruk 2
   yn1 = 35; yn2 = 18; //koord nog 2
   y_smen = 23;    //smeschenie vniz
   y_smen_up = 22;  //smechenie vverh
     y_smen_up1 = 8;// vverh polozh 3
     smen_2=55; // ruki polozh 5
     smesh=35;// vverh polozh5
     sm_1=110;// vverh polozh6
     sm_2=18;// vverh polozh7
     sm_x=30;// vverh polozh8
     sm_y=60;


   //фон
   horizont = 50; xd1 = 287; yd1 = 900;
     yd2 = 220; yd3 = 286; far_len = 50;  dx = 350;
     sunx1 = 50; suny1 = 30; sundiam = 80;
     rays = 10; lenray = 150; wdthray = 20;
 //    tournik_h = 197; tournik_l = 150; tournik_w = 10; dist = 150; centr = 525; turn=5; t=3;
     x_elka = 750; y_elka = 150; elka_dx1 = 20;
     elka_dx2 = 9; elka_dy = 45; len_stvol = 30; elki = 3;
     gross_x = 10; gross_y = 630; gross_len = 750; gross_height = 70;
     //
     kik=80;
     sm=40;
     odn=30;

     //турник

     LenTurnik = 140; xT = 170; yT = 188;


            //медведь
    x_head1 = 155; y_head1 = 180; x_head2 = 235; y_head2 = 260;
    x_uho1_l = 150; x_uhop_1 = 210; y_uho1 = 160; y_uho2 = 190; x_uho2_l = 180; x_uho2_p = 240;
    x_telo1 = 145 ;x_telo2 =  245;y_telo1 =  256;y_telo2 = 390;
    x_eye1_l = 170; x_eyep_1 = 200; y_eye1 = 195; y_eye2 = 215; x_eye2_l = 190; x_eye2_p = 220;
    x_ruka1_l = 70; x_rukap_1 = 240; y_ruka1 = 320; y_ruka2 = 300; x_ruka2_l = 150; x_ruka2_p = 320;
    x_lapa1_l = 115; x_lapap_1 = 195; y_lapa1 = 385; y_lapa2 = 405; x_lapa2_l = 195; x_lapa2_p = 275;
    x_zh1 = 155; x_zh2 = 235; y_zh1 = 270; y_zh2 = 370;
    x_nos1 = 185;  x_nos2 = 205; y_nos1 = 216; y_nos2 = 236;

    //Бегун

    elHumanHeight = 100;
    elBarrierHeight = elHumanHeight div 2;
    elBarrierWidth = Round(elHumanHeight / 2.1);
    sizeOfStand = Round(1.2 * elBarrierHeight);
    BarrierStep = elBarrierWidth div 5;
    barrierScale = 1.5;
    elFinishHeight = Round(1.2 * elHumanHeight);
    elFinishWidth = elBarrierWidth;

    var i, step, d: Integer;

  //Турникмен
  procedure hozhdenie1(Form2: TForm);
  procedure ruk1 (Form2: TForm);
  procedure ruk2 (Form2: TForm);
  procedure polozh1 (Form2: TForm);
  procedure polozh3 (Form2: TForm);
  procedure polozh2 (Form2: TForm);
  procedure polozh4 (Form2: TForm);
  procedure polozh5 (Form2: TForm);
  procedure polozh6 (Form2: TForm);
  procedure polozh7 (Form2: TForm);
  procedure polozh8 (Form2: TForm);
  procedure polozh9 (Form2: TForm);
  procedure polozh10 (Form2: TForm);
  procedure polozh11 (Form2: TForm);
  procedure polozh12 (Form2: TForm);
  procedure polozh13 (Form2: TForm);
  procedure polozh14 (Form2: TForm);
  procedure polozh15 (Form2: TForm);
  procedure polozh16 (Form2: TForm);
  procedure polozh17 (Form2: TForm);
  procedure polozh18 (Form2: TForm);
  procedure Turnik   (Form2: TForm);
  procedure Medved (Form2: TForm);
  //Бегун
  procedure DrawHuman(x, y: Integer; frame: humanFrame; scale: Real; Canvas: TCanvas);


implementation
var centerX, centerY, count: integer;
    Man: TMan;
    cloudX, cloudY: integer;
    C: TColor;
    perspectiveK: real;

procedure TMan.SetX(const val: integer);
 begin
   X := val;
   bodyX := val;
 end;
 procedure TMan.SetY(const val: integer);
 begin
   Y := val;
   bodyY := val;
 end;

procedure TMan.VypadLeft();
begin
  bodyY := Y + trunc(move * Size) + 2;
  LeftLeg.angle1 := 180;
  LeftLeg.angle2 := 90;
  LeftLeg.angle3 := 180;
  RightLeg.angle1 := 40;
  RightLeg.angle2 := 40;
  RightLeg.angle3 := 180;
  LeftArm.angle2 := 20;
  LeftArm.angle1 := 20;
  bodyAngle := 280;
  headAngle := 280;
end;

procedure TMan.VypadRight();
begin
  bodyY := Y + trunc(move * Size) + 2;
  LeftLeg.angle1 := 0;
  LeftLeg.angle2 := 90;
  LeftLeg.angle3 := 0;
  RightLeg.angle1 := 140;
  RightLeg.angle2 := 140;
  RightLeg.angle3 := 0;
  RightArm.angle2 := 160;
  RightArm.angle1 := 160;
  bodyAngle := 260;
  headAngle := 260;
end;

procedure TMan.Shpagat();
begin
          bodyY := Y + bodySize;
          LeftLeg.angle1 := 180;
          LeftLeg.angle2 := 180;
          LeftLeg.angle3 := 0;
          RightLeg.angle1 := 0;
          RightLeg.angle2 := 0;
          RightLeg.angle3 := 180;
end;

procedure TMan.Priced();
begin
          bodyY := Y + trunc(move * Size) + 2;
          LeftLeg.angle1 := 30;
          LeftLeg.angle2 := 110;
          LeftLeg.angle3 := 0;
          RightLeg.angle1 := 150;
          RightLeg.angle2 := 70;
          RightLeg.angle3 := 180;
          LeftArm.angle1 := 140;
          LeftArm.angle2 := 160;
          RightArm.angle1 := 40;
          RightArm.angle2 := 20;
end;

procedure TMan.HeadTiltRight();
begin
          StartPos();
          headAngle := 330;
end;
procedure TMan.HeadTiltLeft();
begin
          StartPos();
          headAngle := 210;
end;

procedure TMan.KolesoUp();
begin
              bodyangle := 90;

              leftLeg.angle1 := -80;
              leftLeg.angle2 := -80;
              leftLeg.angle3 := -0;
              rightLeg.angle1 := -100;
              rightLeg.angle2 := -100;
              rightLeg.angle3 := -180;

              RightArm.angle1 := 50;
              RightArm.angle2 := 50;
              LeftArm.angle1 := 130;
              LeftArm.angle2 := 130;
              headangle := 90;
              bodyy := bodyy - 10;
end;

procedure TMan.KolesoDown();
begin
              bodyangle := 90;

              leftLeg.angle1 := -80;
              leftLeg.angle2 := -80;
              leftLeg.angle3 := -0;
              rightLeg.angle1 := -100;
              rightLeg.angle2 := -100;
              rightLeg.angle3 := -180;

              RightArm.angle1 := 20;
              RightArm.angle2 := 90;
              LeftArm.angle1 := 160;
              LeftArm.angle2 := 90;
              headangle := 90;
              bodyy := bodyy + 10;
end;


procedure TMan.JumpUp();
begin
          bodyY := Y - trunc(move * Size);
          LeftLeg.angle1 := 40;
          LeftLeg.angle2 := 40;
          LeftLeg.angle3 := 0;
          RightLeg.angle1 := 140;
          RightLeg.angle2 := 140;
          RightLeg.angle3 := 180;
           LeftArm.angle1 := 230;
          LeftArm.angle2 := 230;
          RightArm.angle1 := 310;
          RightArm.angle2 := 310;
end;

Constructor TMan.Create(X: Integer; Y: Integer; ManSize: Integer);
begin
    Self.X := X;
    Self.Y := Y;
    Self.bodyX := X;
    Self.bodyY := Y;
    Self.Size := trunc(perspectiveK * ManSize);
    Self.bodySize :=  trunc(body * ManSize);
    Self.headAngle := 270;
    bodyAngle := 270;
    Self.leftArm.angle1 := 180;
    Self.leftArm.angle2 := 180;
    Self.rightArm.angle1 := 0;
    Self.rightArm.angle2 := 0;
    Self.leftLeg.angle1 := 60;
    Self.leftLeg.angle2 := 90;
    Self.leftLeg.angle3 := 0;
    Self.rightLeg.angle1 := 120;
    Self.rightLeg.angle2 := 90;
    Self.rightLeg.angle3 := 180;
    count := 0;
    stage := 1;
end;
procedure PaintHead(x, y, rad, angle: integer; const Canvas: TCanvas);
var MC: TMyCanvas;
    angleRadians: real;
begin
   angleRadians := angle * Pi / 180;   //перевод в радианы
   MC:=TMyCanvas.Create; // используем конструктор родительского класса
   MC.Handle:=Canvas.Handle; // назначаем холст окна областью вывода
   MC.Brush.Color := clBlack;
   MC.Circle(rad, x + trunc(rad*cos(angleRadians)), y + trunc(rad*sin(angleRadians)));       //head
   MC.Free;
end;

procedure PaintArm(x, y, len:integer; angle1, angle2: integer; const Canvas: TCanvas);
var X1, Y1, X2, Y2: integer;
    angleRadians1, angleRadians2: real;
begin
   angleRadians1 := angle1 * Pi / 180;   //перевод в радианы
   angleRadians2 := angle2 * Pi / 180;

   Canvas.MoveTo(X, Y);       //рисование рук
   X1 :=  X + trunc(len*cos(angleRadians1));
   Y1 :=  Y + trunc(len*sin(angleRadians1));
   Canvas.LineTo(X1, Y1);
   X2 :=  X1 + trunc(len*cos(angleRadians2));
   Y2 :=  Y1 + trunc(len*sin(angleRadians2));
   Canvas.LineTo(X2, Y2);
end;

 procedure PaintLeg(x, y, lenb, leng, lens, angle1, angle2, angle3: Integer;
const Canvas: TCanvas);
var AnglRadian1, anglRadian2, anglRadian3:Real;
x1,y1,x2,y2,x3,y3:Integer;
begin                                      //x y координаты откуда идут ноги
    anglRadian1 := angle1 * Pi/180;
    anglRadian2 := angle2 * Pi/180;
    anglRadian3 := angle3 * Pi/180;
    Canvas.MoveTo(x, y );; // ставим точку начала отрисовки ног
    x1 := x - trunc(lenb*cos(anglRadian1));
    y1:= y + trunc(lenb*sin(anglRadian1));
    Canvas.LineTo(x1, y1);
    x2 := x1 - trunc(leng*cos(anglRadian2));
    y2 := y1 + trunc(leng*sin(anglRadian2));
    Canvas.LineTo(x2,y2);
    x3 := x2 - trunc(lens*cos(anglRadian3));
    y3 := y2 + trunc(lens*sin(anglRadian3));
    Canvas.LineTo(x3,y3);
end;

procedure TMan.Paint(const Canvas: TCanvas);

begin

 bodySize := trunc(body * Size);

 legX := bodyX;
 legY := bodyY;

 headX := bodyX + trunc(bodySize * cos(bodyAngle*Pi/180));
 headY := bodyY + trunc(bodySize * sin(bodyAngle*Pi/180));

 armX := legX - trunc(shoulder*(legX - headX));
 armY := legY - trunc(shoulder*(legY - headY));

 PaintHead(headX, headY, trunc(head * Size), headAngle, Canvas);
 Canvas.MoveTo(headX, headY);  //body
 Canvas.LineTo(legX, legY);

 PaintLeg(legX, legY, trunc(leg * Size), trunc(leg * Size), trunc(foot * Size), leftLeg.angle1, LeftLeg.angle2, LeftLeg.angle3,Canvas);
 PaintLeg(legX, legY, trunc(leg * Size), trunc(leg * Size), trunc(foot * Size), rightLeg.angle1, rightLeg.angle2, rightLeg.angle3,Canvas);

 PaintArm(armX, armY, trunc(arm * Size), leftArm.angle1, leftArm.angle2, Canvas);
 PaintArm(armX, armY, trunc(arm * Size), rightArm.angle1, rightArm.angle2, Canvas);

end;


procedure TMan.PricedAnim();
begin
      case stage of
      1:
        begin
           stage := 2;
           startPos();
        end;
      2:
        begin
          Priced();
          stage := 1;
        end;
        else stage := 1;
      end;
end;

procedure TMan.ShpagatAnim();
begin
    case stage of
      1:
        begin
           stage := 2;
           startPos();
        end;
      2:
        begin
          Shpagat();
          stage := 1;
        end;
        else stage := 1;
      end;
end;

procedure TMan.StartPos();
begin
    bodyX := X;
    bodyY := Y;
    bodyAngle := 270;
    headAngle := 270;
    leftArm.angle1 := 135;
    leftArm.angle2 := 135;
    rightArm.angle1 := 45;
    rightArm.angle2 := 45;
    leftLeg.angle1 := 60;
    leftLeg.angle2 := 90;
    leftLeg.angle3 := 0;
    rightLeg.angle1 := 120;
    rightLeg.angle2 := 90;
    rightLeg.angle3 := 180;
end;

procedure TMan.VypadAnimLeft();
begin
    case stage of
      1:
        begin
           stage := 2;
           StartPos();
        end;
      2:
        begin
          VypadLeft();
          stage := 1
        end;
        else stage := 1;
    end;
end;

procedure TMan.VypadAnimRight();
begin
    case stage of
      1:
        begin
           stage := 2;
           StartPos();
        end;
      2:
        begin
          VypadRight();
          stage := 1;
        end;
        else stage := 1;
    end;
end;

procedure TMan.JumpAnim();
begin
    case stage of
      1:
        begin
           stage := 2;
           StartPos();
        end;
      2:
        begin
          JumpUp;
          stage := 1;
        end;
        else stage := 1;
    end;
end;


procedure TMan.KolesoAnim();
begin
      case stage of
          1:
          begin
              KolesoDown();
              stage := 2;
          end;
          2:
          begin
              KolesoUp();
              stage := 1;
          end;
          else stage := 1;
      end;
end;
procedure TMan.HeadTiltAnim();
begin
   case stage of
      1:
        begin
           startPos();
           inc(stage);
        end;
      2:
        begin
          HeadTiltRight();
          inc(stage);
        end;
      3:
        begin
          startPos();
          inc(stage);
        end;
      4:
        begin
          HeadTiltLeft();
          inc(stage);
        end;
      5:
        begin
           startPos();
           stage := 1;
        end;
        else stage := 1;
      end;
end;

procedure TMan.BodyTiltAnim;
begin
    case stage of
      1:
        begin
           stage := 3;
           BodyTiltRight();
        end;
      2:
        begin
          BodyTiltLeft();
          stage := 4;
        end;
       3:
       begin
         StartPos();
         stage := 2;
       end;
       4:
       begin
         StartPos();
         stage := 1;
       end
        else stage := 1;
    end;
end;

procedure TMan.BodyTiltLeft;
begin
    bodyangle := 40;
    headangle := 40;
    RightArm.Angle1 := 80;
    RightArm.Angle2 := 80;
    LeftArm.Angle1 := 100;
    LeftArm.Angle2 := 100;

end;

procedure TMan.BodyTiltRight;
begin
    bodyangle := 140;
    headangle := 140;
    RightArm.Angle1 := 100;
    RightArm.Angle2 := 100;
    LeftArm.Angle1 := 80;
    LeftArm.Angle2 := 80;

end;
procedure TMan.Step1();
begin
   bodyAngle := 270;
   headAngle := 270;
   LeftLeg.angle1 := 50;
   LeftLeg.angle2 := 90;
   LeftLeg.angle3 := 10;
   RightLeg.angle1 := 100;
   RightLeg.angle2 := 90;
   RightLeg.angle3 := 180;
   leftArm.angle1 := 120;
   leftArm.angle2 := 70;
   rightArm.angle1 := 70;
   rightArm.angle2 := 70;
end;

procedure TMan.Step2();
begin
          bodyAngle := 270;
          headAngle := 270;
          LeftLeg.angle1 := 80;
          LeftLeg.angle2 := 90;
          LeftLeg.angle3 := 0;
          RightLeg.angle1 := 130;
          RightLeg.angle2 := 90;
          RightLeg.angle3 := 170;

          RightArm.angle1 := 60;
          RightArm.angle2 := 110;
          LeftArm.angle1 :=  110;
          LeftArm.Angle2 :=  110;
end;

procedure TMan.WalkAnim();
begin
    case stage of
      1:
      begin
          Step1();
          stage := 2;
      end;
      2:
      begin
          Step2();
          stage := 1;
      end;
    end;
end;


procedure TMyCanvas.Circle(Rad, X, Y: integer);
begin
 Ellipse(X-Rad, Y-Rad, X+Rad, Y+Rad);
end;
procedure TMyCanvas.Square(Size, X, Y: integer);
begin
 Rectangle(X, Y, X+Size, Y+Size);
end;
procedure TMan.TurnOnMusic();
begin
    bodyX := X;
    bodyY := Y;
    bodyAngle := 285;
    headAngle := 285;
    leftArm.angle1 := 135;
    leftArm.angle2 := 135;
    rightArm.angle1 := 55;
    rightArm.angle2 := 55;
    leftLeg.angle1 := 60;
    leftLeg.angle2 := 90;
    leftLeg.angle3 := 0;
    rightLeg.angle1 := 120;
    rightLeg.angle2 := 90;
    rightLeg.angle3 := 180;
end;
/////////////////////////////////////////////////////////////////////////////
var n, j,kol:integer;
    l, x_o, y_o, x_c, y_c, r_c, koef, km: Integer;
    deg : Real;
    f:boolean;


procedure ruk1 (Form2: TForm);
begin
with Form2.Canvas do
   begin
      Pen.Color:=clBlack;
      //golova
      Ellipse(x1-k1, y1-2*k1, x1+k1, y1);
      //telo
      MoveTo (x1, y1);
      LineTo (x2, y2);
   //ruka l
    MoveTo (x1, y1+ yruky1);
    LineTo (x1 - xruky+(ruk div 2)+(ruk div 2), y1 + yruky2+(yruky2 div 4)-ruk-(ruk div 3));
    LineTo(x1 - xruky+(ruk div 3)+(ruk div 2),y1 + yruky2+(yruky2 div 4));
    //ruka pr
    MoveTo (x1, y1+ yruky1);
    LineTo (x1 - xruky+ruk+(ruk div 2), y1 + yruky2+(yruky2 div 4)-ruk);
    LineTo(x1 - xruky+(ruk div 3)+(ruk div 2)+(ruk div 8),y1 + yruky2+(yruky2 div 10));
    //noga l
    MoveTo (x2, y2);
    LineTo (x2- xnog, y2+ ynog);
    //noga pr
    MoveTo (x2, y2);
    LineTo (x2 + xnog, y2+ ynog);
   end;
end;

 procedure Turnik   (Form2: TForm);
 begin
    with Form2.Canvas do
    begin
        Pen.Color := clBlack;
        Pen.Width := 3;
        MoveTo(xT - LenTurnik div 2, yT);
        LineTo(xT - LenTurnik div 2, yT+Lenturnik+Lenturnik div 2);
        MoveTo(xT - LenTurnik div 2, yT);
        LineTo(xT + LenTurnik, yT);
        LineTo(xT+ LenTurnik, yT+LenTurnik+Lenturnik div 2);
        Pen.Width := 1;
    end;
 end;

procedure ruk2 (Form2: TForm);
begin
with Form2.Canvas do
   begin
      Pen.Color:=clBlack;
      //golova
      Ellipse(x1-k1, y1-2*k1, x1+k1, y1);
      //telo
      MoveTo (x1, y1);
      LineTo (x2, y2);
   //ruka l
    MoveTo (x1, y1+ yruky1);
    LineTo (x1 - xruky+(ruk div 2)+(ruk div 2), y1 + yruky2+(yruky2 div 4)-ruk-(ruk div 3));
     LineTo(x1 - xruky+(ruk div 3)+(ruk div 2)+(ruk div 5),y1 + yruky2+(yruky2 div 10));
    //ruka pr
    MoveTo (x1, y1+ yruky1);
    LineTo (x1 - xruky+ruk+(ruk div 2), y1 + yruky2+(yruky2 div 4)-ruk);
    LineTo(x1 - xruky+(ruk div 3)+(ruk div 2),y1 + yruky2+(yruky2 div 4));
       //noga l
    MoveTo (x2, y2);
    LineTo (x2- xnog, y2+ ynog);
    //noga pr
    MoveTo (x2, y2);
    LineTo (x2 + xnog, y2+ ynog);
   end;
end;

procedure polozh1 (Form2: TForm);
begin
with Form2.Canvas do
   begin
      Pen.Color:=clBlack;
      //golova
      Ellipse(x1-k1, y1-2*k1, x1+k1, y1);
      //telo
      MoveTo (x1, y1);
      LineTo (x2, y2);
   //ruka l
    MoveTo (x1, y1+ yruky1);
    LineTo (x1 - xruky, y1 + yruky2+(yruky2 div 4));
    //ruka pr
    MoveTo (x1, y1+ yruky1);
    LineTo (x1 + xruky, y1 + yruky2+(yruky2 div 4));
    //noga l
    MoveTo (x2, y2);
    LineTo (x2- xnog, y2+ ynog);
    //noga pr
    MoveTo (x2, y2);
    LineTo (x2 + xnog, y2+ ynog);
   end;
end;

procedure polozh2 (Form2: TForm);
begin
with Form2.Canvas do
  begin
     Pen.Color:=clBlack;
      //golova
      Ellipse(x1-k1, y1-2*k1+y_smen, x1+k1, y1+y_smen);
      //telo
      MoveTo (x1, y1+y_smen);
      LineTo (x2, y2+y_smen);
      //ruka l
    MoveTo (x1, y1+ yruky1+y_smen);
    LineTo (x1 - xruky, y1 + yruky2+y_smen+(yruky2 div 4));
    //ruka pr
    MoveTo (x1, y1+ yruky1+y_smen);
    LineTo (x1 + xruky, y1 + yruky2+y_smen+(yruky2 div 4));
    //noga l
    MoveTo (x2,y2+y_smen);
    LineTo (x2-xnog, y2+yn1+y_smen);
    LineTo (x2-xnog, y2+yn1+yn2+y_smen);
    //noga pr
    MoveTo (x2,y2+y_smen);
    LineTo (x2+xnog, y2+yn1+y_smen);
    LineTo (x2+xnog, y2+yn1+yn2+y_smen);

  end;
end;

procedure polozh3 (Form2: TForm);
begin
with Form2.Canvas do
   begin
      Pen.Color:=clBlack;
      //golova
      Ellipse(x1-k1, y1-2*k1-y_smen_up1, x1+k1, y1-y_smen_up1);
      //telo
      MoveTo (x1, y1-y_smen_up1);
      LineTo (x2, y2-y_smen_up1);
   //ruka l
    MoveTo (x1, y1+ yruky1-y_smen_up1);
    LineTo (x1 - xruky-3*y_smen_up1, y1 + yruky2-3*y_smen_up);
    //ruka pr
    MoveTo (x1, y1+ yruky1-y_smen_up1);
    LineTo (x1 + xruky+3*y_smen_up1, y1 + yruky2-3*y_smen_up);
    //noga l
    MoveTo (x2, y2-y_smen_up1);
    LineTo (x2- xnog, y2+ ynog-y_smen_up1);
    //noga pr
    MoveTo (x2, y2-y_smen_up1);
    LineTo (x2 + xnog, y2+ ynog-y_smen_up1);
   end;
end;

procedure polozh4 (Form2: TForm);
begin
with Form2.Canvas do
   begin
      Pen.Color:=clBlack;
      //golova
      Ellipse(x1-k1, y1-2*k1-y_smen_up, x1+k1, y1-y_smen_up);
      //telo
      MoveTo (x1, y1-y_smen_up);
      LineTo (x2, y2-y_smen_up);
   //ruka l
    MoveTo (x1, y1+ yruky1-y_smen_up);
    LineTo (x1 - xruky, y1 - yruky2-y_smen_up);
    //ruka pr
    MoveTo (x1, y1+ yruky1-y_smen_up);
    LineTo (x1 + xruky, y1 - yruky2-y_smen_up);
    //noga l
    MoveTo (x2, y2-y_smen_up);
    LineTo (x2- xnog, y2+ ynog-y_smen_up);
    //noga pr
    MoveTo (x2, y2-y_smen_up);
    LineTo (x2 + xnog, y2+ ynog-y_smen_up);
   end;
end;

procedure polozh5 (Form2: TForm);
begin
with Form2.Canvas do
   begin
      Pen.Color:=clBlack;
      //golova
      Ellipse(x1-k1, y1-2*k1-y_smen_up-smesh, x1+k1, y1-y_smen_up-smesh);
      //telo
      MoveTo (x1, y1-y_smen_up-smesh);
      LineTo (x2, y2-y_smen_up-smesh);
     //r_l
    MoveTo (x1, y1+ yruky1-y_smen_up-smesh);
    LineTo (x1-smen_2, y1+ yruky1-y_smen_up-smen_2);
    LineTo (x1-smen_2,y1 - yruky2-y_smen_up );
    //r_p
    MoveTo (x1, y1+ yruky1-y_smen_up-smesh);
    LineTo (x1+smen_2, y1+ yruky1-y_smen_up-smen_2);
    LineTo (x1+smen_2, y1 - yruky2-y_smen_up);

    //noga l
    MoveTo (x2, y2-y_smen_up-smesh);
    LineTo (x2- xnog, y2+ ynog-y_smen_up-smesh);
    //noga pr
    MoveTo (x2, y2-y_smen_up-smesh);
    LineTo (x2 + xnog, y2+ ynog-y_smen_up-smesh);
   end;
end;

procedure polozh6 (Form2: TForm);
begin
with Form2.Canvas do
   begin
      Pen.Color:=clBlack;
      //golova
      Ellipse(x1-k1, y1-2*k1-y_smen_up-smesh-sm_1, x1+k1, y1-y_smen_up-smesh-sm_1);
      //telo
      MoveTo (x1, y1-y_smen_up-smesh-sm_1);
      LineTo (x2, y2-y_smen_up-smesh-sm_1);
     //r_l
    MoveTo (x1, y1+ yruky1-y_smen_up-smesh-sm_1);
    LineTo (x1-smen_2, y1+ yruky1-y_smen_up-2*smesh +smen_2-sm_1);
    LineTo (x1-smen_2,y1+ 2*yruky1-y_smen_up-2*smesh+yruky2-sm_1);
    //r_p                                                         yruky1-smen_2 +yruky2
    MoveTo (x1, y1+ yruky1-y_smen_up-smesh-sm_1);
    LineTo (x1+smen_2, y1+ yruky1-y_smen_up-2*smesh +smen_2-sm_1);
    LineTo (x1+smen_2,y1+ 2*yruky1-y_smen_up-2*smesh+yruky2-sm_1);

    //noga l
    MoveTo (x2, y2-y_smen_up-smesh-sm_1);
    LineTo (x2- xnog, y2+ ynog-y_smen_up-smesh-sm_1);
    //noga pr
    MoveTo (x2, y2-y_smen_up-smesh-sm_1);
    LineTo (x2 + xnog, y2+ ynog-y_smen_up-smesh-sm_1);
   end;
end;

procedure polozh7 (Form2: TForm);
begin
 with Form2.Canvas do
   begin
      Pen.Color:=clBlack;
      //golova
      Ellipse(x1-k1, y1-2*k1-y_smen_up-smesh-sm_1-sm_2, x1+k1, y1-y_smen_up-smesh-sm_1-sm_2);
      //telo
      MoveTo (x1, y1-y_smen_up-smesh-sm_1-sm_2);
      LineTo (x2, y2-y_smen_up-smesh-sm_1-sm_2);
     //r_l
    MoveTo (x1, y1+ yruky1-y_smen_up-smesh-sm_1-sm_2);
    LineTo (x1-smen_2, y1+ 2*yruky1-y_smen_up-2*smesh+yruky2-sm_1);
    //r_p
    MoveTo (x1, y1+ yruky1-y_smen_up-smesh-sm_1-sm_2);
    LineTo (x1+smen_2,y1+ 2*yruky1-y_smen_up-2*smesh+yruky2-sm_1);

    //noga l
    MoveTo (x2, y2-y_smen_up-smesh-sm_1-sm_2);
    LineTo (x2- xnog, y2+ ynog-y_smen_up-smesh-sm_1-sm_2);
    //noga pr
    MoveTo (x2, y2-y_smen_up-smesh-sm_1-sm_2);
    LineTo (x2 + xnog, y2+ ynog-y_smen_up-smesh-sm_1-sm_2);
   end;
end;

procedure polozh8 (Form2: TForm);
begin
 with Form2.Canvas do
   begin
      Pen.Color:=clBlack;
      //golova
      Ellipse(x1+sm_x+(sm_x div 3), y1-y_smen_up-smesh-sm_1-sm_2+(sm_y div 6), x1+2*sm_x+(sm_x div 4), y1-y_smen_up-smesh-sm_1-sm_2+(sm_y div 2)+(sm_y div 12));
      //telo
      MoveTo (x1+sm_x+ (sm_x div 2), y1-y_smen_up-smesh-sm_1-sm_2+(sm_y div 2));
      LineTo (x2, y2-y_smen_up-smesh-sm_1-sm_2);
     //r_l
    MoveTo (x1+sm_x+(sm_x div 3),  y1-y_smen_up-smesh-sm_1-sm_2+sm_y-(sm_y div 3));
    LineTo (x1-smen_2+(sm_x div 10), y1+ 2*yruky1-y_smen_up-2*smesh+yruky2-sm_1-(sm_y div 10));
    //r_p
    MoveTo (x1+sm_x+(sm_x div 3),  y1-y_smen_up-smesh-sm_1-sm_2+sm_y-(sm_y div 3));
    LineTo (x1+smen_2,y1+ 2*yruky1-y_smen_up-2*smesh+yruky2-sm_1);
   //noga l
    MoveTo (x2, y2-y_smen_up-smesh-sm_1-sm_2);
    LineTo (x2- xnog-sm_x+(sm_x div 3) , y2+ ynog-y_smen_up-smesh-sm_1-sm_2-(sm_y div 2));
    //noga pr
    MoveTo (x2, y2-y_smen_up-smesh-sm_1-sm_2);
    LineTo (x2 + xnog-2*sm_x, y2+ ynog-y_smen_up-smesh-sm_1-sm_2-(sm_y div 6));
   end;
end;

procedure polozh9 (Form2: TForm);
begin
 with Form2.Canvas do
   begin
      Pen.Color:=clBlack;
      //golova
      Ellipse(x2 + xnog-3*sm_x, y2+ ynog-y_smen_up-smesh-sm_1-sm_2-(sm_y div 4), x2 + xnog-2*sm_x, y2+ ynog-y_smen_up-smesh-sm_1-sm_2+(sm_y div 5));
      //telo
      MoveTo (x2 + xnog-2*sm_x-(sm_x div 4), y2+ ynog-y_smen_up-smesh-sm_1-sm_2-(sm_y div 4));
      LineTo (x1+sm_x-(sm_x div 4), y1-y_smen_up-smesh-sm_1-sm_2+sm_y+(sm_y div 10));
     //r_l
    MoveTo (x2 + xnog-2*sm_x+(sm_x div 12), y2+ ynog-y_smen_up-smesh-sm_1-sm_2-(sm_y div 2));
    LineTo (x1-smen_2+(sm_x div 10), y1+ 2*yruky1-y_smen_up-2*smesh+yruky2-sm_1-(sm_y div 10));
    //r_p                                                         yruky1-smen_2 +yruky2
    MoveTo (x2 + xnog-2*sm_x+(sm_x div 12), y2+ ynog-y_smen_up-smesh-sm_1-sm_2-(sm_y div 2));
    LineTo (x1+smen_2,y1+ 2*yruky1-y_smen_up-2*smesh+yruky2-sm_1);

    //noga l
    MoveTo (x1+sm_x-(sm_x div 4), y1-y_smen_up-smesh-sm_1-sm_2+sm_y+(sm_y div 10));
    LineTo (x1+sm_x +(sm_x div 3), y1-y_smen_up-smesh-sm_1-sm_2+(sm_y div 5));
    //noga pr
    MoveTo (x1+sm_x-(sm_x div 4), y1-y_smen_up-smesh-sm_1-sm_2+sm_y+(sm_y div 10));
    LineTo (x1+3*sm_x, y1-y_smen_up-smesh-sm_1-sm_2+(sm_y div 2));
   end;
end;

procedure hozhdenie1(Form2: TForm);
begin
   with Form2.Canvas do
   begin
     Pen.Color:=clBlack;
     // Brush.Color := clGray;
   //   Pen.Width:=1;
      //golova
      Ellipse(xh1-kh1+4*step+d+koef div 2, yh1-2*kh1-step+d+koef, xh1+kh1+4*step-koef div 2, yh1-step);
      //telo
      MoveTo (xh1+4*step, yh1-step);
      LineTo (xh2+4*step, yh2-step-d-4*koef);
   //ruka l
    MoveTo (xh1+4*step, yh1+ yrukyh1-step-koef div 2);
    LineTo (xh1 - (xrukyh div 2)+4*step+2*d+koef  , yh1 + yrukyh2+(yrukyh2 div 4)-step-2*d-4*koef);
            //ruka pr
    MoveTo (xh1+4*step, yh1+ yrukyh1-step-koef div 2);
    LineTo (xh1 + xrukyh-(xrukyh div 3)+4*step-3*d-koef, yh1 + yrukyh2+(yrukyh2 div 4)-step-2*d-4*koef);
       //noga l
    MoveTo (xh2+4*step, yh2-step-2*d-4*koef);
    LineTo (xh2- (xnogh div 3)+4*step-2*d+koef div 2, yh2+ ynogh-step-2*d-6*koef );
    //noga pr
    MoveTo (xh2+4*step, yh2-step-d-4*koef);
    LineTo (xh2 + xnogh+4*step-2*d-2*koef, yh2+ ynogh-step-2*d-6*koef );
   end;
end;

procedure polozh10 (Form2: TForm);
begin
with Form2.Canvas do
   begin
      Pen.Color:=clBlack;
      //golova
      Ellipse(x1-k1, y1-2*k1-y_smen_up+kik-sm-(sm div 3) , x1+k1, y1-y_smen_up+kik-sm-(sm div 3));
      //telo
      MoveTo (x1, y1-y_smen_up-(kik div 3)-sm-(sm div 2) );
      LineTo (x2, y1-2*k1-y_smen_up+kik-sm-(sm div 3));
          //r_l
    MoveTo (x1, y1+ yruky1-y_smen_up-smesh);
    LineTo (x1-smen_2, y1+ yruky1-y_smen_up-smen_2);
    LineTo (x1-smen_2,y1 - yruky2-y_smen_up );
    //r_p
    MoveTo (x1, y1+ yruky1-y_smen_up-smesh);
    LineTo (x1+smen_2, y1+ yruky1-y_smen_up-smen_2);
    LineTo (x1+smen_2, y1 - yruky2-y_smen_up);
    //noga l
    MoveTo (x1, y1-y_smen_up-(kik div 3)-sm-(sm div 2) );
    LineTo (x2- xnog, y2+ ynog-3*kik-(kik div 2)-sm-(sm div 2));
    //noga pr
    MoveTo (x1, y1-y_smen_up-(kik div 3)-sm-(sm div 2));
    LineTo (x2 + xnog, y2+ ynog-3*kik-(kik div 2)-sm-(sm div 2));
   end;
end;

procedure polozh11 (Form2: TForm);
begin
with Form2.Canvas do
   begin
      Pen.Color:=clBlack;
      //golova
      Ellipse(x1-k1, y1-2*k1-y_smen_up+kik, x1+k1, y1-y_smen_up+kik);
      //telo
      MoveTo (x1, y1-y_smen_up-(kik div 3));
      LineTo (x2, y1-2*k1-y_smen_up+kik);
       //ruka l
    MoveTo (x1, y1+ yruky1-(kik div 5));
    LineTo (x1 - xruky, y1 + yruky2+(yruky2 div 4)-(kik div 5));
    //ruka pr
    MoveTo (x1, y1+ yruky1-(kik div 5));
    LineTo (x1 + xruky, y1 + yruky2+(yruky2 div 4)-(kik div 5));
    //noga l
    MoveTo (x1, y1-y_smen_up-(kik div 3));
    LineTo (x2- xnog, y2+ ynog-3*kik-(kik div 4));
    LineTo (x2- xnog,y1-y_smen_up-(kik div 3));
    //noga pr
    MoveTo (x1, y1-y_smen_up-(kik div 3));
    LineTo (x2 + xnog, y2+ ynog-3*kik-(kik div 4));
    LineTo (x2 + xnog, y1-y_smen_up-(kik div 3));
   end;
end;

procedure polozh12 (Form2: TForm);
begin
with Form2.Canvas do
   begin
      Pen.Color:=clBlack;
      //golova
      Ellipse(x1-k1+(kik div 15), y1-2*k1-y_smen_up+(kik div 2)+(kik div 4), x1+k1+(kik div 15), y1-y_smen_up+(kik div 6));
      //telo
      MoveTo (x1-k1+(kik div 4), y1-2*k1-y_smen_up+(kik div 2)+(kik div 6));
      LineTo (x1-k1+(kik div 15), y1-2*k1-y_smen_up+kik);
       //ruka l
    MoveTo (x1-k1+(kik div 4), y1-2*k1-y_smen_up+(kik div 2)+(kik div 4));
    LineTo (x1 - xruky, y1 + yruky2+(yruky2 div 4)-kik-(kik div 4) );
    //ruka pr
    MoveTo (x1-k1+(kik div 4), y1-2*k1-y_smen_up+(kik div 2)+(kik div 4));
    LineTo (x1 + xruky, y1 + yruky2+(yruky2 div 4)-kik);
    //noga l
    MoveTo (x1-k1+(kik div 15), y1-2*k1-y_smen_up+kik);
    LineTo (x1-k1-(kik div 3), y1-2*k1-y_smen_up+kik+(kik div 2)+(kik div 3));
    //noga pr
    MoveTo (x1-k1+(kik div 15), y1-2*k1-y_smen_up+(kik div 2)+(kik div 2));
    LineTo (x2+(kik div 10), y1-2*k1-y_smen_up+2*kik);
   end;
end;

procedure polozh13 (Form2: TForm);
begin
with Form2.Canvas do
   begin
      Pen.Color:=clBlack;
      //golova
      Ellipse(x1-k1, y1-2*k1-y_smen_up-smesh-sm_1, x1+k1, y1-y_smen_up-smesh-sm_1);
      //telo
      MoveTo (x1, y1-y_smen_up-smesh-sm_1);
      LineTo (x2, y2-y_smen_up-smesh-sm_1);
     //r_l
    MoveTo (x1, y1+ yruky1-y_smen_up-smesh-sm_1);
    LineTo (x1-smen_2, y1+ yruky1-y_smen_up-2*smesh +smen_2-sm_1);
    LineTo (x1-smen_2,y1+ 2*yruky1-y_smen_up-2*smesh+yruky2-sm_1);
    //r_p
    MoveTo (x1, y1+ yruky1-y_smen_up-smesh-sm_1);
    LineTo (x1+smen_2+odn, y1+ yruky1-y_smen_up-2*smesh +smen_2-sm_1+odn);

    //noga l
    MoveTo (x2, y2-y_smen_up-smesh-sm_1);
    LineTo (x2- xnog, y2+ ynog-y_smen_up-smesh-sm_1);
    //noga pr
    MoveTo (x2, y2-y_smen_up-smesh-sm_1);
    LineTo (x2 + xnog, y2+ ynog-y_smen_up-smesh-sm_1);
   end;
end;

procedure polozh14 (Form2: TForm);
begin
with Form2.Canvas do
   begin
      Pen.Color:=clBlack;
      //golova
      Ellipse(x1-k1+odn, y1-2*k1-y_smen_up-smesh-sm_1, x1+k1+odn, y1-y_smen_up-smesh-sm_1);
      //telo
      MoveTo (x1+odn, y1-y_smen_up-smesh-sm_1);
      LineTo (x2+odn, y2-y_smen_up-smesh-sm_1);
     //r_l
    MoveTo (x1+odn, y1+ yruky1-y_smen_up-smesh-sm_1);
    LineTo (x1-smen_2,y1+ 2*yruky1-y_smen_up-2*smesh+yruky2-sm_1);
    //r_p
    MoveTo (x1+odn, y1+ yruky1-y_smen_up-smesh-sm_1);
    LineTo (x1+smen_2+odn+(odn div 3), y1+ yruky1-y_smen_up-2*smesh +smen_2-sm_1);
    LineTo (x1+smen_2+odn+(odn div 3),y1+ 2*yruky1-y_smen_up-2*smesh+yruky2-sm_1);

    //noga l
    MoveTo (x2+odn, y2-y_smen_up-smesh-sm_1);
    LineTo (x2- xnog+odn, y2+ ynog-y_smen_up-smesh-sm_1);
    //noga pr
    MoveTo (x2+odn, y2-y_smen_up-smesh-sm_1);
    LineTo (x2 + xnog+odn, y2+ ynog-y_smen_up-smesh-sm_1);
   end;
end;

procedure polozh15 (Form2: TForm);
begin
with Form2.Canvas do
   begin
      Pen.Color:=clBlack;
      //golova
      Ellipse(x1-k1+odn, y1-2*k1-y_smen_up-smesh-sm_1, x1+k1+odn, y1-y_smen_up-smesh-sm_1);
      //telo
      MoveTo (x1+odn, y1-y_smen_up-smesh-sm_1);
      LineTo (x2+odn, y2-y_smen_up-smesh-sm_1);
     //r_l
    MoveTo (x1+odn, y1+ yruky1-y_smen_up-smesh-sm_1);
    LineTo (x1-smen_2+2*odn+(odn div 3), y1+ yruky1-y_smen_up-2*smesh +smen_2-sm_1-(odn div 2));
    LineTo (x1-smen_2+2*odn+(odn div 3) ,y1+ 2*yruky1-y_smen_up-2*smesh+yruky2-sm_1);
    //r_p
    MoveTo (x1+odn, y1+ yruky1-y_smen_up-smesh-sm_1);
    LineTo (x1+smen_2+odn+(odn div 3), y1+ yruky1-y_smen_up-2*smesh +smen_2-sm_1);
    LineTo (x1+smen_2+odn+(odn div 3),y1+ 2*yruky1-y_smen_up-2*smesh+yruky2-sm_1);

    //noga l
    MoveTo (x2+odn, y2-y_smen_up-smesh-sm_1);
    LineTo (x2- xnog+odn, y2+ ynog-y_smen_up-smesh-sm_1);
    //noga pr
    MoveTo (x2+odn, y2-y_smen_up-smesh-sm_1);
    LineTo (x2 + xnog+odn, y2+ ynog-y_smen_up-smesh-sm_1);
   end;
end;

procedure polozh16 (Form2: TForm);
begin
with Form2.Canvas do
   begin
      Pen.Color:=clBlack;
      //golova
      Ellipse(x1-k1+(odn div 3), y1-2*k1-y_smen_up-smesh-sm_1, x1+k1+(odn div 3), y1-y_smen_up-smesh-sm_1);
      //telo
      MoveTo (x1+(odn div 3), y1-y_smen_up-smesh-sm_1);
      LineTo (x2+(odn div 3), y2-y_smen_up-smesh-sm_1);
     //r_l
    MoveTo (x1+(odn div 3), y1+ yruky1-y_smen_up-smesh-sm_1);
    LineTo (x1-smen_2+2*odn+(odn div 3), y1+ yruky1-y_smen_up-2*smesh +smen_2-sm_1-(odn div 2));
    LineTo (x1-smen_2+2*odn+(odn div 3) ,y1+ 2*yruky1-y_smen_up-2*smesh+yruky2-sm_1);
    //r_p
    MoveTo (x1+(odn div 3), y1+ yruky1-y_smen_up-smesh-sm_1);
    LineTo (x1+smen_2-2*odn-(odn div 2), y1+ yruky1-y_smen_up-2*smesh +smen_2-sm_1-(odn div 2));
    LineTo (x1+smen_2-3*odn-(odn div 2)-(odn div 3), y1+ yruky1-y_smen_up-2*smesh +smen_2-sm_1+(odn div 2));

    //noga l
    MoveTo (x2+(odn div 3), y2-y_smen_up-smesh-sm_1);
    LineTo (x2- xnog+(odn div 3), y2+ ynog-y_smen_up-smesh-sm_1);
    //noga pr
    MoveTo (x2+(odn div 3), y2-y_smen_up-smesh-sm_1);
    LineTo (x2 + xnog+(odn div 3), y2+ ynog-y_smen_up-smesh-sm_1);
   end;
end;

procedure polozh17 (Form2: TForm);
begin
with Form2.Canvas do
   begin
      Pen.Color:=clBlack;
      //golova
      Ellipse(x1-k1-odn , y1-2*k1-y_smen_up-smesh-sm_1, x1+k1-odn, y1-y_smen_up-smesh-sm_1);
      //telo
      MoveTo (x1-odn, y1-y_smen_up-smesh-sm_1);
      LineTo (x2-odn, y2-y_smen_up-smesh-sm_1);
     //r_l
    MoveTo (x1-odn, y1+ yruky1-y_smen_up-smesh-sm_1);
    LineTo (x1-smen_2+2*odn+(odn div 3), y1+ yruky1-y_smen_up-2*smesh +smen_2-sm_1-(odn div 2));
    LineTo (x1-smen_2+2*odn+(odn div 3) ,y1+ 2*yruky1-y_smen_up-2*smesh+yruky2-sm_1);
    //r_p
    MoveTo (x1-odn, y1+ yruky1-y_smen_up-smesh-sm_1);
    LineTo (x1+smen_2-4*odn-(odn div 3), y1+ yruky1-y_smen_up-2*smesh +smen_2-sm_1-(odn div 2));
    LineTo (x1+smen_2-4*odn-(odn div 3), y1+ 2*yruky1-y_smen_up-2*smesh+yruky2-sm_1);
    //noga l
    MoveTo (x2-odn, y2-y_smen_up-smesh-sm_1);
    LineTo (x2- xnog-odn, y2+ ynog-y_smen_up-smesh-sm_1);
    //noga pr
    MoveTo (x2-odn, y2-y_smen_up-smesh-sm_1);
    LineTo (x2 + xnog-odn, y2+ ynog-y_smen_up-smesh-sm_1);
   end;
end;

procedure polozh18 (Form2: TForm);
begin
with Form2.Canvas do
   begin
   Pen.Color:=clBlack;
         //golova
      Ellipse(x1-k1-odn , y1-2*k1-y_smen_up-smesh-sm_1-odn-(odn div 5), x1+k1-odn, y1-y_smen_up-smesh-sm_1-odn-(odn div 5));
      //telo
      MoveTo (x1-odn, y1-y_smen_up-smesh-sm_1-odn-(odn div 5));
      LineTo (x2-odn, y2-y_smen_up-smesh-sm_1-odn-(odn div 4));
     //r_l
    MoveTo (x1-odn, y1+ yruky1-y_smen_up-smesh-sm_1-odn-(odn div 5));
    LineTo (x1-smen_2+2*odn ,y1+ 2*yruky1-y_smen_up-2*smesh+yruky2-sm_1);
    //r_p
    MoveTo (x1-odn, y1+ yruky1-y_smen_up-smesh-sm_1-odn-(odn div 5));
    LineTo (x1+smen_2-4*odn-(odn div 3), y1+ 2*yruky1-y_smen_up-2*smesh+yruky2-sm_1);
    //noga l
    MoveTo (x2-odn, y2-y_smen_up-smesh-sm_1-odn-(odn div 4));
    LineTo (x2- xnog-(odn div 2), y2+ ynog-y_smen_up-smesh-sm_1-2*odn-(odn div 3));
    LineTo (x2- xnog+odn, y2+ ynog-y_smen_up-smesh-sm_1-2*odn);
    //noga pr
    MoveTo (x2-odn, y2-y_smen_up-smesh-sm_1-odn-(odn div 4));
    LineTo (x2-odn+(odn div 4), y2+ ynog-y_smen_up-smesh-sm_1-odn);
   end;
end;
procedure Medved(Form2: TForm);

begin
with Form2.Canvas do
begin

Pen.Width := 0;
Pen.Color := clBlack;
Brush.Color := clCream;
Pen.Width := 1;
Brush.Style := bsClear;
//голова
Pen.Color := clBlack;
Brush.Color := RGB(101, 60, 33) ;
Ellipse(x_head1+km,y_head1,x_head2+km,y_head2);
//ухо левое
Pen.Color := clBlack;
Brush.Color := RGB(171, 135, 98);
Ellipse(x_uho1_l+km,y_uho1,x_uho2_l+km,y_uho2);
//ухо правое
Pen.Color := clBlack;
Brush.Color := RGB(171, 135, 98) ;
Ellipse(x_uhop_1+km,y_uho1,x_uho2_p+km,y_uho2);
//тело
Pen.Color := clBlack;
Brush.Color := RGB(101, 60, 33) ;
Ellipse(x_telo1+km,y_telo1,x_telo2+km,y_telo2);
//Левый глаз
Pen.Color := clBlack;
Brush.Color := RGB(240, 230, 220) ;
Ellipse(x_eye1_l+km,y_eye1,x_eye2_l+km,y_eye2);
Brush.Color := clblack ;
Ellipse(x_eye1_l+((x_eye2_l-x_eye1_l) div 4)+km,y_eye1+((y_eye2-y_eye1) div 4),x_eye2_l-((x_eye2_l-x_eye1_l) div 4)+km,y_eye2-((y_eye2-y_eye1) div 4));
//Правый глаз
Pen.Color := clBlack;
Brush.Color := RGB(240, 230, 220) ;
Ellipse(x_eyep_1+km,y_eye1,x_eye2_p+km,y_eye2);
Brush.Color := clblack ;
Ellipse(x_eyep_1+((x_eye2_p-x_eyep_1) div 4)+km,y_eye1+((y_eye2-y_eye1) div 4),x_eye2_p-((x_eye2_p-x_eyep_1) div 4)+km,y_eye2-((y_eye2-y_eye1) div 4));
// Внутерный живот
Pen.Color := clBlack;
Brush.Color := RGB(171, 135, 98) ;
Ellipse(x_zh1+km,y_zh1,x_zh2+km,y_zh2);
// Рука левая
Pen.Color := clBlack;
Brush.Color := RGB(101, 60, 33) ;
Ellipse(x_ruka1_l+km,y_ruka1,x_ruka2_l+km, y_ruka2);
// Рука правая
Pen.Color := clBlack;
Brush.Color := RGB(101, 60, 33) ;
Ellipse(x_rukap_1+km,y_ruka1,x_ruka2_p+km, y_ruka2);
//Нос
Pen.Width := 1;
Pen.Color := clBlack;
Brush.Color := RGB(56, 37, 14) ;
Ellipse(x_nos1+km,y_nos1,x_nos2+km,y_nos2);
//Лапа левая
Pen.Color := clBlack;
Brush.Color := RGB(101, 60, 33);
Ellipse(x_lapa1_l+km,y_lapa1,x_lapa2_l+km,y_lapa2);
//Лапа правая
Pen.Color := clBlack;
Brush.Color := RGB(101, 60, 33) ;
Ellipse(x_lapap_1+km,y_lapa1,x_lapa2_p+km,y_lapa2);
end;
end;

Procedure drawHuman(x, y: Integer; frame: humanFrame; scale: Real; Canvas: TCanvas);
const
    elHighSize = Round(elHumanHeight / 2.5);

var
    size: Integer;


procedure DrawStep1(x,y,size:integer);
var
    k:integer;
begin
    k := size div 32;//5

    x := x + 4 * k;

    Canvas.Ellipse(x,y,x + 16*k,y + 16*k);//голова
    Canvas.MoveTo(x + 8*k,y + 16*k);
    Canvas.LineTo(x - 8*k,y + 16*k + size);//bogy
    Canvas.LineTo(x - 12*k,y + 2*size);//left leg
    Canvas.LineTo(x - 22*k,y + 2*size + 8*k);
    Canvas.MoveTo(x - 8*k,y + size + 16*k);//right leg
    Canvas.LineTo(x + 16*k,y + 2*size);
    Canvas.LineTo(x + 20*k,y + 2*size + 16*k);
    Canvas.MoveTo(x + 5*k,y + 22*k);//right arm
    Canvas.LineTo(x + 16*k,y + size);
    Canvas.LineTo(x + size,y + size);
    Canvas.MoveTo(x + 5*k,y + 22*k);//left arm
    Canvas.LineTo(x - 8*k,y + size);
    Canvas.LineTo(x - 8*k,y + size + 16*k);
end;
procedure DrawStep2(x,y,size:integer);
var
    k:integer;
begin
    k := size div 32;//5

    x := x + 11 * k;

    Canvas.Ellipse(x,y,x + 16*k,y + 16*k);//голова
    Canvas.MoveTo(x + 8*k,y + 16*k);
    Canvas.LineTo(x + 6*k,y + size + 16*k);//bogy
    Canvas.LineTo(x + k,y + 2*size);//left leg
    Canvas.LineTo(x - 4*k,y + 2*size + 16*k);
    Canvas.MoveTo(x + 6*k,y + size + 16*k);//right leg
    Canvas.LineTo(x + 16*k,y + 2*size);
    Canvas.LineTo(x + 16*k,y + 2*size + 16*k);
    Canvas.MoveTo(x + 8*k,y + 22*k);//right arm
    Canvas.LineTo(x + 24*k,y + 24*k);
    Canvas.LineTo(x + 28*k,y + size + 6*k);
    Canvas.MoveTo(x + 8*k,y + 22*k);//left arm
    Canvas.LineTo(x + 4*k,y + size + 6*k);
    Canvas.LineTo(x + 28*k,y + size + 16*k);
end;
procedure DrawJump(x,y,size:integer);
var
    k:integer;
begin
    k := size div 32;//5

    x := x + 11 * k;

    Canvas.Ellipse(x,y,x + 16*k,y + 16*k);//голова
    Canvas.MoveTo(x + 8*k,y + 16*k);
    Canvas.LineTo(x + 6*k,y + size + 8*k);//bogy
    Canvas.LineTo(x - 16*k,y + size + 16*k);//left leg
    Canvas.LineTo(x - 24*k,y + size + 8*k);
    Canvas.MoveTo(x + 6*k,y + size +8*k);//right leg
    Canvas.LineTo(x + 28*k,y + size + 12*k);
    Canvas.LineTo(x + size + 8*k,y + size + 20*k);
    Canvas.MoveTo(x + 8*k,y + 22*k);//right arm
    Canvas.LineTo(x + 24*k,y + 12*k);
    Canvas.LineTo(x + 28*k,y + 3*k);
    Canvas.MoveTo(x + 8*k,y + 22*k);//left arm
    Canvas.LineTo(x - 8*k,y + size);
    Canvas.LineTo(x - 16*k,y + size + 8*k);
end;
begin
    Canvas.Brush.Color := clBlack;
    Canvas.Pen.Color := clBlack;
    Canvas.Pen.Width := 1;
    size := Round(Real(elHighSize) * scale);
    case frame of                            //frame?
    step1: DrawStep1(x, y, size);
    step2: DrawStep2(x, y, size);
    jump: DrawJump(x, y, size);
    end;
    Canvas.Pen.Width := 1;
end;



end.
