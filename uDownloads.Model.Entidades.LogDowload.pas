unit uDownloads.Model.Entidades.LogDowload;

interface

uses
  uDownloads.Model.Interfaces, Data.DB, System.SysUtils;

type

  TModelEntidadesLogDowload = class(TInterfacedObject, IEntidadeLogDowload)
  private
    FoQuery: IQuery;
    function RetornarDataLog: String;
    function ConsultarIDLog: Integer;
  public
    class function New: IEntidadeLogDowload;
    constructor Create;
    destructor Destroy; override;

    function Listar(ADataSource: TDataSource): IEntidadeLogDowload;
    function Inserir(AcUrl: String): Integer;
    function AtualizarHoraFinal(AnIdLog: Integer): IEntidadeLogDowload;
  end;

implementation

uses
  uDownloads.Controller.Factory.Query;

class function TModelEntidadesLogDowload.New: IEntidadeLogDowload;
begin
  Result := Create;
end;

constructor TModelEntidadesLogDowload.Create;
begin
  FoQuery := TControllerFactoryQuery.New.GetQuery(nil);
end;

function TModelEntidadesLogDowload.Listar(ADataSource: TDataSource): IEntidadeLogDowload;
begin
  Result := Self;
  FoQuery.SQL('SELECT * FROM LOGDOWNLOAD');
  ADataSource.DataSet := FoQuery.DataSet;
end;

function TModelEntidadesLogDowload.Inserir(AcUrl: String): Integer;
begin
  FoQuery.Execute(Format('INSERT INTO LOGDOWNLOAD (URL, DATAINICIO) VALUES (%s, %s)',
                   [QuotedStr(AcUrl), RetornarDataLog]));
  Result := ConsultarIDLog;
end;

function TModelEntidadesLogDowload.AtualizarHoraFinal(AnIdLog: Integer): IEntidadeLogDowload;
begin
  Result := Self;
  FoQuery.Execute(Format('UPDATE LOGDOWNLOAD SET DATAFIM = %s WHERE CODIGO = %d',
                  [RetornarDataLog, AnIdLog]));
end;

function TModelEntidadesLogDowload.RetornarDataLog: String;
begin
 Result := QuotedStr(FormatDateTime('YYYY-MM-DD', Now));
end;

function TModelEntidadesLogDowload.ConsultarIDLog: Integer;
begin
  Result := FoQuery.SQL(
    'SELECT MAX(CODIGO) AS CODIGO FROM LOGDOWNLOAD'
  ).DataSet.FieldByName('CODIGO').AsInteger;
end;

destructor TModelEntidadesLogDowload.Destroy;
begin
  inherited;
end;

end.
