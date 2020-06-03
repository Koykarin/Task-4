unit UMainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DBCtrls, TeEngine, Series, TeeProcs, Chart,
  ComCtrls, USort, UChart;

type
  TMainForm = class(TForm)
    PageControl: TPageControl;
    tsSort: TTabSheet;
    tsGraphics: TTabSheet;
    Chart: TChart;
    Line1: TLineSeries;
    Line2: TLineSeries;
    pnlChart: TPanel;
    btnGraph: TButton;
    lstSort: TListBox;
    edtMas: TEdit;
    lbl1: TLabel;
    btnGenerateMas: TButton;
    lbl2: TLabel;
    btnSort: TButton;
    rgCountElems: TRadioGroup;
    btnExit: TButton;
    procedure btnExitClick(Sender: TObject);
    procedure btnGraphClick(Sender: TObject);
    procedure btnGenerateMasClick(Sender: TObject);
    procedure btnSortClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure ShowMas(mas: TMas);
    procedure ShowMasToLb(mas: TMas);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  mas: TMas;

implementation

{$R *.dfm}

procedure TMainForm.btnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.btnGraphClick(Sender: TObject);
const
  count = 20; //количество измерений
var
  info: TInfo;
  N, MaxN, step: Integer;
begin
  //перерисовать график
  case rgCountElems.ItemIndex of
    0: MaxN:= 100;
    1: MaxN:= 1000;
    2: MaxN:= 10000;
  end;
  step:= MaxN div count;
  N:= step;
  Chart.Series[0].Clear; //сравнения
  Chart.Series[1].Clear; //перемещения
  Chart.Series[0].AddXY(0,0);
  Chart.Series[1].AddXY(0,0);
  while N <= MaxN do
    begin
      info:= Culc(N);
      chart.Series[0].AddXY(N, info.CntCompare);
      chart.Series[1].AddXY(N, info.CntMove);
      N:= N + step;
    end;
end;

//вывод массива mas на edit
procedure TMainForm.ShowMas(mas: TMas);
begin
  edtMas.Text:= ToString(mas);
end;

//генерирует массив чисел и выводит его на edit
procedure TMainForm.btnGenerateMasClick(Sender: TObject);
begin
  RandomFill(mas);
  ShowMas(mas);
  btnSort.Enabled:= True;
end;

//вывести сгенерированный массив на listbox для сортировки
procedure TMainForm.ShowMasToLb(mas: TMas);
var
  i: Integer;
begin
  for i:= 1 to N do
    lstSort.Items.Add(IntToStr(mas[i]));
end;

procedure TMainForm.btnSortClick(Sender: TObject);
begin
  btnSort.Enabled:= False;
  btnGenerateMas.Enabled:= False;
  btnExit.Enabled:= False;
  lstSort.Clear;
  ShowMasToLb(mas);
  lstSort.Visible:= True;
  lbl2.Visible:= True;
  Application.ProcessMessages;
  sleep(SlpDur);

  BubleSort(mas,lstSort);

  ShowMessage('Готово!');
  btnGenerateMas.Enabled:= True;
  btnExit.Enabled:= True;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  rgCountElems.ItemIndex:= 1;
  btnGraphClick(Sender);
  PageControl.ActivePageIndex:= 0;
end;

end.
