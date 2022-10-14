program anime;

uses
  Vcl.Forms,
  UnitMult in 'UnitMult.pas' {Form2},
  UnitTogether in 'UnitTogether.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
