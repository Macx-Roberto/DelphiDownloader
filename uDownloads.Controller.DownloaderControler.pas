unit uDownloads.Controller.DownloaderControler;

interface

uses
  uDownloads.Controller.Interfaces, System.Net.HttpClient,
  System.SysUtils, System.Classes, uDownloads.Service.HTTPDownload,
  uDownloads.View.Log, uDownloads.Model.Entidades.LogDowload,
  uDownloads.Model.Interfaces, System.IOUtils, Vcl.Dialogs;

type

  TDownloadsController = class(TInterfacedObject, IDownloadsController)
  private
    FIdLogAtual: Integer;
    procedure SalvarLog(AcUrl: String);
    procedure SalvarArquivo(AResponse: IHTTPResponse);
    procedure oRequestRequestCompleted(const Sender: TObject;
      const AResponse: IHTTPResponse);
    procedure AtualzarDataFimLog;
    function GetEntidadeLog: IEntidadeLogDowload;
  public
    destructor Destroy; override;
    class function New(): IDownloadsController;

    function IniciarDownload(cUrl: String; OnReceiveData: TReceiveDataEvent): IDownloadsController;
    function ExibirMensagem: IDownloadsController;
    function PararDownload: IDownloadsController;
    function HistoricoDownloads: IDownloadsController;
    function AbrirDiretorioDownload: IDownloadsController;
  end;

implementation

class function TDownloadsController.New: IDownloadsController;
begin
  Result := Self.Create();
end;

function TDownloadsController.IniciarDownload(cUrl: String; OnReceiveData: TReceiveDataEvent): IDownloadsController;
var
  oThreadHTTPDownload: TThreadHTTPDownload;
begin
  Result := Self;
  SalvarLog(cUrl);
  oThreadHTTPDownload := TThreadHTTPDownload.Create(True);
  oThreadHTTPDownload.OnReceiveData      := OnReceiveData;
  oThreadHTTPDownload.OnRequestCompleted := oRequestRequestCompleted;
  oThreadHTTPDownload.Url                := cUrl;
  oThreadHTTPDownload.Start;
end;

function TDownloadsController.ExibirMensagem: IDownloadsController;
begin
  Result := Self;
end;

function TDownloadsController.PararDownload: IDownloadsController;
begin
  Result := Self;
end;

function TDownloadsController.HistoricoDownloads: IDownloadsController;
var
  oForm: TFrmLog;
begin
  Result := Self;
  oForm := TFrmLog.New(
    GetEntidadeLog);
  try
    oForm.ShowModal;
  finally
    if Assigned(oForm) then
      FreeAndNil(oForm);
  end;
end;

function TDownloadsController.AbrirDiretorioDownload: IDownloadsController;
begin
  Result := Self;
end;

procedure TDownloadsController.SalvarLog(AcUrl: String);
begin
  FIdLogAtual := GetEntidadeLog.Inserir(AcUrl);
end;

procedure TDownloadsController.oRequestRequestCompleted(const Sender: TObject; const AResponse: IHTTPResponse);
begin
  try
    SalvarArquivo(AResponse);
    AtualzarDataFimLog;
  except
    on E: Exception do
      begin
      MessageDlg(E.Message, mtError, [mbOK], 0);
      Abort;
    end;
  end;
end;

procedure TDownloadsController.AtualzarDataFimLog;
begin
  GetEntidadeLog.AtualizarHoraFinal(FIdLogAtual);
end;

function TDownloadsController.GetEntidadeLog: IEntidadeLogDowload;
begin
  try
    Result := TModelEntidadesLogDowload.New;
  except
    on E: Exception do
    begin
      MessageDlg(E.Message, mtError, [mbOK], 0);
      Abort;
    end;
  end;
end;

procedure TDownloadsController.SalvarArquivo(AResponse: IHTTPResponse);
var
  oMemoryStream: TMemoryStream;
  cFileName: String;
begin
  try
    cFileName :=  TDirectory.GetCurrentDirectory + TPath.DirectorySeparatorChar +
                  TPath.GetRandomFileName + '.' + AResponse.MimeType.Split(['/'])[1];

    oMemoryStream := TMemoryStream.Create();
    oMemoryStream.LoadFromStream(AResponse.ContentStream);
    oMemoryStream.SaveToFile(cFileName);
  finally
    if Assigned(oMemoryStream) then
      FreeAndNil(oMemoryStream);
  end;
end;

destructor TDownloadsController.Destroy;
begin

  inherited;
end;

end.
