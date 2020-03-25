unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ScrollBox,
  FMX.Memo, FMX.StdCtrls, FMX.Controls.Presentation,System.ioutils,FMX.Helpers.Android
  ,Androidapi.JNI.JavaTypes,AndroidApi.JNI.Telephony,Androidapi.helpers;

type
  TForm1 = class(TForm)
    Button4: TButton;
    Memo1: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}
{$R *.NmXhdpiPh.fmx ANDROID}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.LgXhdpiTb.fmx ANDROID}

procedure TForm1.Button4Click(Sender: TObject);
var
  I: Integer;
  manager:JsmsManager;
   smsTo:Jstring;
   message:Jstring;
   list:TStringList;
   crashes:integer;
begin
  manager:=TJSmsManager.JavaClass.getDefault;
  crashes :=0;
  list := TStringList.create;
  ExtractStrings([';'], [], PChar(TFile.ReadAllText(TPath.Combine(TPath.GetSharedDownloadsPath, 'f.txt'))), list);
  message:=stringtojstring(Memo1.Text);
  //Memo2.Text := list[1];
  Application.ProcessMessages;
 for I := 0 to list.Count  - 1  do begin
    smsTo:=stringtojstring(Trim(list[i]));
    try
        manager.sendTextMessage(smsTo,nil,message,nil,nil);
        sleep(500);
    except
     showmessage('Xatolik ' + list[i]);
    end;
 end;
 ShowMessage('Rassilka tugadi');
 Label1.Text:='Sms ketgan raqamlar soni = '+list.Count.ToString +' ketmaganlar: '+ crashes.ToString;
end;





end.
