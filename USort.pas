unit USort;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DBCtrls, TeEngine, Series, TeeProcs, Chart,
  ComCtrls;

const
  N = 10;   
  SlpDur = 1000;   //задержка
  tab = '      '; //отступ

type
  TIndex = 1..N;    //индекс
  TElem = Integer;  //лемент
  TMas = array[TIndex] of TElem;   //массив

  procedure RandomFill(var mas: TMas);  // рандомное заполнение массива 
  function ToString(mas: TMas): string;    //возвращат массива в виде строки
  procedure BubleSort(var mas: TMas; var lb: TListBox); //сортировка шелла с выводом процесса на listbox

implementation

//заполнение массива случайными числами (в диапазоне 1-99)
procedure RandomFill(var mas: TMas);
var
  i: Integer;
begin
  Randomize;
  for i:= 1 to N do
    mas[i]:= 1 + Random(99);
end;

//возвращат массив в виде строки
function ToString(mas: TMas): string;
var
  i: Integer;
begin
  Result:= '';
  for i:= 1 to N do
    Result:= Result + IntToStr(mas[i]) + ' ';
end;

//сдвигает i-ю строку в lb на отступ tab
procedure Move(var lb: TListBox; i: Integer);
var
  s: string;
begin
  s:= tab + Trim(lb.Items[i-1]);
  lb.Items[i-1]:= s;
end;

//удаляет отступ i-й строки в lb
procedure MoveBack(var lb: TListBox; i: Integer);
var
  s: string;
begin
  s:= Trim(lb.Items[i-1]);
  lb.Items[i-1]:= s;
end;

//меняет местами i-ю и j-ю строки в lb
procedure Swap(var lb: TListBox; i,j: Integer);
var
  s: string;
begin
  s:= lb.Items[i-1];
  lb.Items[i-1]:= lb.Items[j-1];
  lb.Items[j-1]:= s;
end;

procedure BubleSort(var mas: TMas; var lb: TListBox);
var
  i, tmp: integer;
  firstIndex, lastIndex: integer;
  k: integer;     //индекс последней перестановки
begin
  firstIndex:= 1;    //индекс первого элемента рабочей зоны
  lastIndex:= N;     //индекс последнего элемента рабочей зоны
  k:= N-1;
  repeat

    //действия с listbox
    Move(lb,firstIndex);
    Application.ProcessMessages;


    //проход слева направо (сверху вниз)
    for i:= firstIndex to lastIndex-1 do
      begin

        //действия с listbox
        Move(lb,i+1);
        Application.ProcessMessages;   //чтобы на listbox применились изменения
        sleep(SlpDur);

        if mas[i] > mas[i+1] then
          begin
            //обмен элементов
            tmp:= mas[i];
            mas[i]:= mas[i+1];
            mas[i+1]:= tmp;

            //действия с listbox
            Swap(lb,i,i+1);
            Application.ProcessMessages;
            sleep(SlpDur);

          end;

        //действия с listbox
        MoveBack(lb,i);
        Application.ProcessMessages;

      end;

    //действия с listbox
    MoveBack(lb,lastIndex);
    Application.ProcessMessages;
    sleep(SlpDur);

    lastIndex:= k;   //уменьшаем просматриваемую область
    Dec(k);
  until k<0;
end;

end.
