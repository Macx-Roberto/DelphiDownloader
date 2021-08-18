unit uDownloads.Controller.Interfaces;

interface

uses
  System.Net.HttpClient;

type

  IDownloadsController = interface
    ['{2420ea4c-35b9-445f-a2e7-a0b9ca5f2363}']
    function IniciarDownload(cUrl: String;
      OnReceiveData: TReceiveDataEvent): IDownloadsController;
    function HistoricoDownloads: IDownloadsController;
  end;

implementation

end.
