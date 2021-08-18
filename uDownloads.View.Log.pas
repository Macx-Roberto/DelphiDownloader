unit uDownloads.View.Log;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  uDownloads.Model.Interfaces;

type
  TFrmLog = class(TForm)
    GridLog: TDBGrid;
    dsLog: TDataSource;
  private
    { Private declarations }
    procedure ConsutarLog;
  protected
    FoLog: IEntidadeLogDowload;
  public
    { Public declarations }
    class function New(oEntidade: IEntidadeLogDowload): TFrmLog;
  end;

var
  FrmLog: TFrmLog;

implementation

{$R *.dfm}

class function TFrmLog.New(oEntidade: IEntidadeLogDowload): TFrmLog;
begin
  if (not System.Assigned(Application.FindComponent('FrmLog'))) then
    Application.CreateForm(TFrmLog, FrmLog);
  FrmLog.FoLog := oEntidade;
  FrmLog.ConsutarLog;
  Result := FrmLog;
end;

procedure TFrmLog.ConsutarLog;
begin
  FoLog.Listar(dsLog);
end;

end.
