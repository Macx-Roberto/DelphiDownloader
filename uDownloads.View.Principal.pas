unit uDownloads.View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, uDownloads.Controller.Interfaces;

type
  TFrmPrincipal = class(TForm)
    btnDownload: TButton;
    btnExibirMensagem: TButton;
    btnPararDownload: TButton;
    btnHistorico: TButton;
    ProgressBar1: TProgressBar;
    memoURL: TMemo;
    Label1: TLabel;
    procedure btnDownloadClick(Sender: TObject);
    procedure btnExibirMensagemClick(Sender: TObject);
    procedure btnHistoricoClick(Sender: TObject);
    procedure btnPararDownloadClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FbCancelarDownload: Boolean;
    FoController: IDownloadsController;
    FPorcentagemDownload: Extended;
    procedure IniciarDownnload(const Text: TCaption);
    procedure oRequestReceiveData(const Sender: TObject; AContentLength,
      AReadCount: Int64; var AAbort: Boolean);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

uses
  uDownloads.Controller.DownloaderControler;

{$R *.dfm}

procedure TFrmPrincipal.btnDownloadClick(Sender: TObject);
begin
  IniciarDownnload(memoURL.Text);
end;

procedure TFrmPrincipal.btnExibirMensagemClick(Sender: TObject);
begin
  ShowMessageFmt('Downdoad em andamento % atual %n', [FPorcentagemDownload]);
end;

procedure TFrmPrincipal.btnHistoricoClick(Sender: TObject);
begin
  FoController.HistoricoDownloads;
end;

procedure TFrmPrincipal.btnPararDownloadClick(Sender: TObject);
begin
  FbCancelarDownload := True;
end;

procedure TFrmPrincipal.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
//  if oController.TestarDownloadEmAndamento then

  if (MessageDlg('Deseja realmente sair do programa?', mtCustom, [mbYes, mbNo], 0) = mrYes) then
    CanClose := True;
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  FoController := TDownloadsController.New;
end;

procedure TFrmPrincipal.oRequestReceiveData(const Sender: TObject; AContentLength,
 AReadCount: Int64; var AAbort: Boolean);
var
  nPositon: Int64;
begin
  if (AContentLength <= 0) then
    Exit;

  FPorcentagemDownload :=  (AReadCount / AContentLength) * 100;
  nPositon := System.Trunc(FPorcentagemDownload);
  if (nPositon > ProgressBar1.Position) then
    ProgressBar1.Position := nPositon;
  AAbort := FbCancelarDownload;
end;

procedure TFrmPrincipal.IniciarDownnload(const Text: TCaption);
begin
  FbCancelarDownload := False;
  FoController.IniciarDownload(Text, oRequestReceiveData);

  // btnDownload.Enabled := False;
  // btnExibirMensagem.Enabled := True;
  // btnPararDownload.Enabled := True;
  //enviar procedure tratando comps
end;

initialization
  ReportMemoryLeaksOnShutdown := true;

end.



