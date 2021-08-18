unit uDownloads.Model.Conexao.Firedac;

interface

uses
  System.SysUtils, uDownloads.Model.Interfaces,
  Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait, FireDAC.Comp.Client;

type

  EErroConexao = class(Exception)
  public
    constructor Create(AcMensagem: String); overload;
  end;

  TModelConexaoFiredac = class(TInterfacedObject, IConexao)
  private
    FoConexao: TFDConnection;
  public
    class function New: IConexao;
    constructor Create;
    function Connection: TCustomConnection;
    destructor Destroy; override;
  end;

implementation

const
  _databasePath = 'C:\sqlite\teste.db';
  _driverNameSQLITE = 'SQLITE';

class function TModelConexaoFiredac.New: IConexao;
begin
  Result := Self.Create;
end;

constructor TModelConexaoFiredac.Create;
begin
  try
    FoConexao := TFDConnection.Create(nil);
    FoConexao.DriverName        := _driverNameSQLITE;
    FoConexao.Params.DataBase   := _databasePath;
    FoConexao.Connected := True;        
  except
    on E: Exception do
      raise EErroConexao.Create(E.Message);
  end;
end;

function TModelConexaoFiredac.Connection: TCustomConnection;
begin
  Result := FoConexao;
end;

destructor TModelConexaoFiredac.Destroy;
begin
  if System.Assigned(FoConexao) then
    System.SysUtils.FreeAndNil(FoConexao);

  inherited;
end;


{ EErroConexao }

constructor EErroConexao.Create(AcMensagem: String);
begin
  Self.Message := 'Ocorreu o seguinte erro ao se conectar com o banco de dados: '
    + AcMensagem;
end;

end.
