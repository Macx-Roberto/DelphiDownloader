unit uDownloads.Controller.Factory.Interfaces;

interface

uses
  uDownloads.Model.Interfaces;

type

  IFactoryQuery = interface
  ['{7C3F1761-350A-486C-A7A4-48E96A60B1D9}']
    function GetQuery(Connection: IConexao): IQuery;
  end;

implementation

end.
