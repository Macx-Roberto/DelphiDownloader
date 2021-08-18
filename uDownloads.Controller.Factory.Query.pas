unit uDownloads.Controller.Factory.Query;

interface

uses
  uDownloads.Controller.Factory.Interfaces, uDownloads.Model.Interfaces;

type

  TControllerFactoryQuery = class(TInterfacedObject, IFactoryQuery)
  public
    function GetQuery(Connection: IConexao): IQuery;
    class function New: IFactoryQuery;
    destructor Destroy; override;
  end;

implementation

uses
  uDownloads.Model.Query.Firedac;

class function TControllerFactoryQuery.New: IFactoryQuery;
begin
  Result := Self.Create;
end;

function TControllerFactoryQuery.GetQuery(Connection: IConexao): IQuery;
begin
  Result := TModelQueryFiredac.New(Connection);
end;

destructor TControllerFactoryQuery.Destroy;
begin
  inherited;
end;

end.
