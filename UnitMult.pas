unit UnitMult;


interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.MPlayer;

type
    TForm2 = class(TForm)
    Timer1: TTimer;
    MediaPlayer1: TMediaPlayer;
    procedure Timer1Timer(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure DrawBackground();
    procedure FormActivate(Sender: TObject);
    procedure DrawRoad();


  private

    { Private declarations }
  public
    { Public declarations }
  end;


var
  Form2: TForm2;

implementation
{$R *.dfm}

uses UnitTogether;

var centerX, centerY, count, countRunning, runnerX, runnerY: integer;
    runnerScale: real;// коэффициент для размеров бегуна
    cloudX1, cloudX2, cloudX3: integer;
    Man: TMan;
    cloudX, cloudY: integer;
    C: TColor;
    perspectiveK: real;
    runningFrame: humanFrame;
const
      ManSize = 240;
      startX = 800;
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






procedure TForm2.DrawRoad;
begin
     Canvas.Brush.Color := RGB(232, 32, 49);
  Canvas.Pen.Color := RGB(232, 32, 49);;
  Canvas.Rectangle(-1, 270, Self.ClientWidth, 300);
  Canvas.Brush.Color := RGB(247, 235, 236);
  Canvas.Pen.Color := RGB(247, 235, 236);;
  Canvas.Rectangle(-1, 284, Self.ClientWidth, 286);
end;

procedure TForm2.FormActivate(Sender: TObject);
begin

  Man := TMan.Create(startX, startY, ManSize);
  DrawBackground();
  centerX := ClientWidth div 2+ClientWidth div 8;
  centerY := ClientHeight div 2;

  perspectiveK := 0.0001;
  cloudX1 := -150;
  cloudX2 := -250;
  cloudX3 := ClientWidth;
  Man.posX := startX;
  Man.posY := startY;
  Man.StartPos;
  runnerX := 50;
  runnerY := 200;
  //Man.Paint(Self.Canvas);
  count := 0;
  countRunning := 0;
  i := 0;
  step := 0;
  d := 0;
  runnerScale := 1;

  Timer1.Enabled:=true;
end;

procedure TForm2.FormPaint(Sender: TObject);
begin
Canvas.Brush.Color := clBlue;
 Color := clWhite;
end;


procedure TForm2.DrawBackground();
begin
  Canvas.Brush.Color := clSkyBlue;
  Canvas.Pen.Color := clSkyBlue;
  Canvas.Rectangle(-1, -1, Self.ClientWidth, 250);
  Canvas.Pen.Color := RGB(10, 200, 50);
  Canvas.Brush.Color := RGB(10, 200, 50);
  Canvas.Rectangle(-1, 250, Self.ClientWidth, Self.ClientHeight);
  Canvas.Brush.Color := RGB(210, 130, 225);
  Canvas.Pen.Color := RGB(210, 130, 225);
  Canvas.Polygon([Point(centerX - 200, centerY + 150),
                   Point(centerX - 150, centerY + 50),
                    Point(centerX + 150, centerY + 50),
                     Point(centerX + 200, centerY + 150)]);
  Canvas.Brush.Color := clRed;      //button
  Canvas.Pen.Color := clRed;
  Canvas.Rectangle(centerX + 60, centerY - 4, centerX + 10 + 60, centerY);

  Canvas.Brush.Color := RGB(210, 90, 90);
  Canvas.Pen.Color := RGB(210, 90, 90);
  Canvas.Rectangle(centerX + 60, centerY, centerX + 80 + 60, centerY + 40);

  Canvas.Brush.Color := RGB(35, 55, 70);
  Canvas.Pen.Color := RGB(35, 55, 70);
  Canvas.Ellipse(centerX + 5 + 60, centerY + 5, centerX + 35 + 60, centerY + 35);
  Canvas.Ellipse(centerX + 45 + 60, centerY + 5, centerX + 75 + 60, centerY + 35);
  Canvas.Brush.Color := RGB(252, 186, 3);
  Canvas.Pen.Color := RGB(252, 186, 3);
  //MC.Circle(50,400,50);
  Canvas.Ellipse(ClientWidth-150 -40, 70 -40, ClientWidth-150 +40, 70 + 40);
  Canvas.Brush.Color := clWhite;
  Canvas.Pen.Color := clWhite;
  //cloud 1
  Canvas.Ellipse(cloudX1 + 10,10,cloudX1 +  200,80);
  Canvas.Ellipse(cloudX1 + 110,10,cloudX1 +  200,60);
  Canvas.Ellipse(cloudX1 + 50,40,cloudX1 +  250,110);
  Inc(cloudX1,3);
  //cloud 2
  Canvas.Ellipse(cloudX2 + 15,180,cloudX2 +  100,210);
  Canvas.Ellipse(cloudX2 + 70,180,cloudX2 +  100,190);
  Canvas.Ellipse(cloudX2 + 50,190,cloudX2 +  150,230);
  Inc(cloudX2,5);
  //cloud3
  Canvas.Ellipse(cloudX3 + 15,120,cloudX3 +  200,155);
  Canvas.Ellipse(cloudX3 + 70,120,cloudX3 +  210,150);
  Canvas.Ellipse(cloudX3 + 50,115,cloudX3 +  150,150);
  Dec(cloudX3,10);

end;




procedure CheckClouds(form: TForm);
begin
  if cloudX1 > (form.ClientWidth+50)  then cloudX1:=-150;
  if cloudX2 > (form.ClientWidth+50)  then cloudX2:=-150;
  if cloudX3 < -150  then cloudX3:= form.ClientWidth;
end;

procedure TForm2.Timer1Timer(Sender: TObject);
 begin
  {}
  CheckClouds(Self);
  DrawBackground();
  DrawRoad;
  Canvas.Brush.Color := clWhite;
  Man.Paint(Self.Canvas);
  Turnik(Self);
  /////////////////////////////////////////////////////////////
  ///
    if (step < 50) and (count < 135) then

    begin
      hozhdenie1(Self);
      step:=step+25;
      d:=d+1
      end
    else  begin
      if (count < 135) then
      begin
         inc(i);
         case i of
          1,26: polozh1(Self);
          2: ruk1(Self);
          3: ruk2(Self);
          4: polozh1(Self);
          5: polozh2(Self);
          6: polozh3(Self);
          7,21: polozh4(Self);
          8,22: polozh5(Self);
          9: polozh6(Self);
          14:polozh13(Self);
          15:polozh14(Self);
          16:polozh15(Self);
          17:polozh16(Self);
          18,20:polozh17(Self);
          19:polozh18(Self);
          10,13: polozh7(Self);
          11: polozh8(Self);
          12: polozh9(Self);
          23:polozh10(Self);
          24:polozh11(Self);
          25:polozh12(Self);
         end;
        if (i=26) then i:=0;
      end
      else if count >= 135 then
           
      begin
        Hozhdenie1(self);
        step := step - 25;
        dec(d);
      end;
    end;



  ///////////////////////////////////////////////////
  if count >= 18 then
  begin
    countRunning := (countRunning + 1) mod 3;
    case countRunning of
    0: runningFrame := step1;
    1: runningFrame := step2;
    2: runningFrame := jump;
    end;
    Inc(runnerX, 10);
    drawHuman(runnerX, runnerY, runningFrame, runnerScale, Self.Canvas);
  end;

  if count in [0..18] then
  begin
     Man.Size := trunc(perspectiveK * ManSize);
     Man.posX := Man.posX + (centerX - startX) div 19;
     Man.posY := Man.posY + (centerY - startY) div 19;
     perspectiveK := perspectiveK + 0.05;
     Man.WalkAnim();
  end;
  if count=19 then
  begin
      Man.posX := centerX;
      Man.posY := centerY;
      Man.TurnOnMusic();
  end;
  if count = 20 then
  begin
    MediaPlayer1.Play;
  end;
  if count in [20..35] then
  begin
      Man.HeadTiltAnim();
  end;
  if count in [35..50] then
  begin
      Man.BodyTiltAnim();
  end;
  if (count in [51..66]) then
  begin
     Man.VypadAnimRight();
  end;
  if (count in [67..80]) then
  begin
      Man.VypadAnimLeft();
  end;
  if count in[81..94] then
  begin
    Man.ShpagatAnim();
  end;
  if count in[95..108] then
  begin
      Man.JumpAnim();
  end;
  if  count in[109..130] then
  begin
    Man.KolesoAnim();
  end;
  if count = 131 then
  begin
     Man.TurnOnMusic();
  end;
  if count = 132 then
  begin
    MediaPlayer1.Pause;
  end;
  if count in [132..149] then
  begin
     Man.Size := trunc(perspectiveK * ManSize);
     Man.posX := Man.posX + (finishX - centerX) div 19;
     Man.posY := Man.posY + (finishy - centerY) div 19;
     perspectiveK := perspectiveK - 0.05;
     Man.WalkAnim();
  end;
  if count > 150 then Timer1.Enabled := False;

  Inc(count);
end;


end.
