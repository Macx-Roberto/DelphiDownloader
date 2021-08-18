unit uDownloads.Service.HTTPDownload;

interface

uses
  System.Classes, System.Net.HttpClientComponent, System.IOUtils,
  System.SysUtils, System.Net.HttpClient;
type

  EErorHTTPDownload = class(Exception)
  public
    constructor Create(AcMensagem: String); overload;
  end;

  TThreadHTTPDownload = class(TThread)
  private
    FoHttpRequest: TNetHTTPRequest;
    FoHttpClient: TNetHTTPClient;
    FOnReceiveData: TReceiveDataEvent;
    FOnRequestCompleted: TRequestCompletedEvent;
    FcUrl: String;
    FbEmpProcesso: Boolean;
    function GetOnReceiveData: TReceiveDataEvent;
    function GetOnRequestCompleted: TRequestCompletedEvent;
    procedure SetOnReceiveData(AValue: TReceiveDataEvent);
    procedure SetOnRequestCompleted(AValue: TRequestCompletedEvent);
    procedure DoRequestCompletedExecute(const Sender: TObject;
      const AResponse: IHTTPResponse);
    procedure DoReciveDataExecute(const Sender: TObject;
      AContentLength: Int64; AReadCount: Int64; var AAbort: Boolean);

    procedure SetUrl(const Value: String);
  protected
    procedure Execute; override;
  public
    procedure AfterConstruction; override;

    property Url: String read FcUrl write SetUrl;
    property OnReceiveData: TReceiveDataEvent read GetOnReceiveData write SetOnReceiveData;
    property OnRequestCompleted: TRequestCompletedEvent read GetOnRequestCompleted write SetOnRequestCompleted;
  end;

implementation

{ TThreadHTTPDownload }

procedure TThreadHTTPDownload.Execute;
begin
  try
    inherited;
    if FbEmpProcesso then
      Exit;

    FoHttpRequest.Get(FcUrl, nil, nil);
    FbEmpProcesso := True;
    
  except
    on E: Exception do
      raise EErorHTTPDownload.Create(E.Message);
  end;
end;

procedure TThreadHTTPDownload.AfterConstruction;
begin
  FoHttpClient  := TNetHTTPClient.Create(nil);
  FoHttpRequest := TNetHTTPRequest.Create(nil);
  FoHttpRequest.Client := FoHttpClient;
  FoHttpRequest.OnReceiveData      := DoReciveDataExecute;
  FoHttpRequest.OnRequestCompleted := DoRequestCompletedExecute;
  FbEmpProcesso := False;
end;

procedure TThreadHTTPDownload.DoRequestCompletedExecute(const Sender: TObject; const AResponse: IHTTPResponse);
begin
  try
    FbEmpProcesso := False;
    if Assigned(OnRequestCompleted) then
      OnRequestCompleted(Self, AResponse);
  finally
    if Assigned(FoHttpRequest) then
      FreeAndNil(FoHttpRequest);
    if Assigned(FoHttpClient) then
      FreeAndNil(FoHttpClient);
  end;
end;

procedure TThreadHTTPDownload.DoReciveDataExecute(const Sender: TObject; AContentLength: Int64; AReadCount: Int64; var AAbort: Boolean);
begin
  if Assigned(OnReceiveData) then
    OnReceiveData(Self, AContentLength, AReadCount, AAbort);
end;

function TThreadHTTPDownload.GetOnReceiveData: TReceiveDataEvent;
begin
  Result := FOnReceiveData;
end;

function TThreadHTTPDownload.GetOnRequestCompleted: TRequestCompletedEvent;
begin
  Result := FOnRequestCompleted;
end;

procedure TThreadHTTPDownload.SetOnReceiveData(AValue: TReceiveDataEvent);
begin
  FOnReceiveData := AValue;
end;

procedure TThreadHTTPDownload.SetOnRequestCompleted(AValue: TRequestCompletedEvent);
begin
  FOnRequestCompleted := AValue;
end;

procedure TThreadHTTPDownload.SetUrl(const Value: String);
begin
  if (Value <> FcUrl) then
    FcUrl := Value;
end;

constructor EErorHTTPDownload.Create(AcMensagem: String);
begin
  Self.Message := 'Ocorreu o seguinte erro ao realizar o Download: '
    + AcMensagem;  
end;

end.
