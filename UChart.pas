unit UChart;

interface

type
  TInfo = record   //���������� � ����������
    CntCompare: Integer;    //���������� ���������
    CntMove: Integer;       //���������� �����������
  end;

  //�� �������� ����� ������� ���������� ���������� � ����������
  function Culc(N: Integer): TInfo;

implementation



//������� ����� ��������� � �����������
function Culc(N: integer): TInfo;
var
  mas: array of Integer;
  i, tmp: integer;
  firstIndex, lastIndex: integer;
  k: integer;     //������ ��������� ������������
begin
  SetLength(mas,N);
  for i:= 0 to N-1 do  //������� � ��������� ������ ���������� ����������
    mas[i]:=  Random(100);

  with Result do
    begin
      CntCompare:= 0;    //���������
      CntMove:= 0;    //�����������
      firstIndex:= 1;    //������ ������� �������� ������� ����
      lastIndex:= N;     //������ ���������� �������� ������� ����
      k:= N-1;
      repeat
        //������ ����� �������
        for i:= firstIndex to lastIndex-1 do
          begin
            Inc(CntCompare);
            if mas[i] > mas[i+1] then
              begin
                Inc(CntMove); 

                //����� ���������
                tmp:= mas[i];
                mas[i]:= mas[i+1];
                mas[i+1]:= tmp;
              end;
          end;

        lastIndex:= k;   //��������� ��������������� �������
        Dec(k);
      until (firstIndex >= lastIndex);
    end;
end;

end.
