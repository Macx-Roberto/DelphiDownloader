program DelphiDownloader;

uses
  Vcl.Forms,
  uDownloads.View.Principal in 'uDownloads.View.Principal.pas' {FrmPrincipal},
  uDownloads.Controller.Interfaces in 'uDownloads.Controller.Interfaces.pas',
  uDownloads.Controller.DownloaderControler in 'uDownloads.Controller.DownloaderControler.pas',
  uDownloads.Service.HTTPDownload in 'uDownloads.Service.HTTPDownload.pas',
  uDownloads.Controller.Factory.Query in 'uDownloads.Controller.Factory.Query.pas',
  uDownloads.Model.Interfaces in 'uDownloads.Model.Interfaces.pas',
  uDownloads.Model.Conexao.Firedac in 'uDownloads.Model.Conexao.Firedac.pas',
  uDownloads.Model.Query.Firedac in 'uDownloads.Model.Query.Firedac.pas',
  uDownloads.Model.Entidades.LogDowload in 'uDownloads.Model.Entidades.LogDowload.pas',
  uDownloads.View.Log in 'uDownloads.View.Log.pas',
  uDownloads.Controller.Factory.Interfaces in 'uDownloads.Controller.Factory.Interfaces.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
