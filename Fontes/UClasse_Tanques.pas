unit UClasse_Tanques;

interface

uses
  FireDAC.Comp.Client;

type
  TClasse_Tanques = class
  private
    FConexao : TFDConnection;
    FId: Integer;
    FTipo: Integer;
  public
    property Conexao : TFDConnection read  FConexao write FConexao;
    property dsTipo : Integer read  FTipo write FTipo;

    constructor Create(Conexao: TFDConnection);
    destructor Destroy; override;

    procedure prc_Inserir;
    procedure prc_Deletar(iId : Integer);
    function fnc_Consulta_id(iId : String) : String;
  end;

implementation

{ TClasse_Tanques }

uses Umodulo;

constructor TClasse_Tanques.Create(Conexao: TFDConnection);
begin
  FConexao := Conexao;
end;

destructor TClasse_Tanques.Destroy;
begin

  inherited;
end;

function TClasse_Tanques.fnc_Consulta_id(iId: String): String;
 var QryConsulta : TFDQuery;
begin
  Dm.conexao.Connected := False;
  Dm.conexao.Connected := True;

  QryConsulta := TFDQuery.Create(nil);
  QryConsulta.Connection :=  Dm.conexao;
  QryConsulta.Close;
  QryConsulta.SQL.Clear;

  QryConsulta.SQL.Add('SELECT CASE WHEN TIPO = 1 THEN ''GASOLINA'' ');
  QryConsulta.SQL.Add('ELSE ''�LEO DIESEL'' END AS DESCRICAO ');
  QryConsulta.SQL.Add('FROM TBTANQUE WHERE id = :p_id ');
  QryConsulta.ParamByName('p_id').AsString := iId;
  QryConsulta.Open;

  Result :=  QryConsulta.FieldByName('DESCRICAO').AsString;
end;


procedure TClasse_Tanques.prc_Deletar(iId: Integer);
begin
    Dm.conexao.Connected := False;
    Dm.conexao.Connected := True;

    // Deleta o registro
    Dm.conexao.ExecSQL ('Delete from TBTANQUE where id = :iId ',[iId]);

end;

procedure TClasse_Tanques.prc_Inserir;
 var QryManutencao : TFDQuery;
begin
  // Inserir Dados

  Dm.conexao.Connected := False;
  Dm.conexao.Connected := True;

  QryManutencao := TFDQuery.Create(nil);
  QryManutencao.Connection :=  Dm.conexao;
  QryManutencao.Close;
  QryManutencao.SQL.Clear;

  QryManutencao.SQL.Add(' Insert into TBTANQUE (TIPO) Values ');
  QryManutencao.SQL.Add(' (:p_Tipo) ');
  QryManutencao.ParamByName('p_Tipo').AsInteger := FTipo;
  QryManutencao.ExecSQL;
end;

end.