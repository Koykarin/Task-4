program n7b;

uses
  Forms,
  UMainForm in 'UMainForm.pas' {MainForm},
  USort in 'USort.pas',
  UChart in 'UChart.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
