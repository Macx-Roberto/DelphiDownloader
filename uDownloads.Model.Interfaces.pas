unit uDownloads.Model.Interfaces;

interface

uses
  Data.DB;

type

  IConexao = interface
    ['{7A16F3A1-0238-416C-8871-8829FB67AA77}']
    function Connection : TCustomConnection;
  end;

  IQuery = interface
    ['{AFEF6A40-7CEA-4E90-A42C-FCD437CDB241}']
    function SQL(Value: String): IQuery;
    function DataSet: TDataSet;
    function Execute(AcSql: String): IQuery;
  end;

  IEntidadeLogDowload = interface
    ['{AFEF6A40-7CEA-4E90-A42C-FCD437CDB241}']
    function Listar(ADataSource: TDataSource): IEntidadeLogDowload;
    function Inserir(AcUrl: String): Integer;
    function AtualizarHoraFinal(AnIdLog: Integer): IEntidadeLogDowload;
  end;

implementation

end.
