unit uDownloads.Model.Query.Firedac;

interface

uses
  System.SysUtils, uDownloads.Model.Interfaces, FireDAC.DApt,
  Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait, FireDAC.Comp.Client;

type

  TModelQueryFiredac = class(TInterfacedObject, IQuery)
  private
    FoConexao: TFDConnection;
    FoQuery: TFDQuery;
    FParent: IConexao;
  public
    class function New(AParent: IConexao): IQuery;
    constructor Create(AParent: IConexao);
    function Connection: TCustomConnection;
    destructor Destroy; override;

    function SQL(Value: String): IQuery;


    function DataSet: TDataSet;
    function Execute(AcSql: String): IQuery;
  end;

implementation

uses
  uDownloads.Model.Conexao.Firedac;

class function TModelQueryFiredac.New(AParent: IConexao): IQuery;
begin
  Result := Self.Create(AParent);
end;

constructor TModelQueryFiredac.Create(AParent: IConexao);
begin
  inherited Create;
  if System.Assigned(AParent) then
    FParent := AParent
  else
    FParent := TModelConexaoFiredac.New;

  FoConexao := TFDConnection(FParent.Connection);
  FoQuery   := TFDQuery.Create(nil);
  FoQuery.Connection := FoConexao;
end;

function TModelQueryFiredac.Connection: TCustomConnection;
begin
  Result := FoConexao;
end;

function TModelQueryFiredac.SQL(Value: String): IQuery;
begin
  Result := Self;
  FoQuery.SQL.Clear;
  FoQuery.SQL.Add(Value);
  FoQuery.Active := True;
end;

function TModelQueryFiredac.DataSet: TDataSet;
begin
  Result := FoQuery;
end;

destructor TModelQueryFiredac.Destroy;
begin
  if System.Assigned(FoQuery) then
    System.SysUtils.FreeAndNil(FoQuery);

  inherited;
end;

function TModelQueryFiredac.Execute(AcSql: String): IQuery;
begin
  Result := Self;
  if (not AcSql.IsEmpty) then
    FoQuery.ExecSQL(AcSql);
end;

end.
