unit UClasse_Bombas;

interface

uses
  FireDAC.Comp.Client;

type
  TClasse_Bombas = class
  private
    FConexao : TFDConnection;
    FId: Integer;
    FTanque_Id: Integer;
    FNum_Bomba: Integer;
    FNome_Tanque : String;
  public
    property Conexao : TFDConnection read  FConexao write FConexao;
    property ds_Id : Integer read  FId write FId;
    property dsTanque_Id : Integer read  FTanque_Id write FTanque_Id;
    property dsNum_Bomba : Integer read  FNum_Bomba write FNum_Bomba;
    property dsNome_Tanque : String read  FNome_Tanque write FNome_Tanque;

    constructor Create(Conexao: TFDConnection);
    destructor Destroy; override;

    procedure prc_Inserir_Alterar (sTipo:String);
    procedure prc_Deletar(iId : Integer);
    function fnc_ValidaCadBomba (sId,sidTanque,sidbomba : String) : String;
    procedure prc_BuscarDados(iId : Integer);
  end;

implementation

{ TClasse_Bombas }

uses Umodulo;

constructor TClasse_Bombas.Create(Conexao: TFDConnection);
begin
  FConexao := Conexao;
end;

destructor TClasse_Bombas.Destroy;
begin

  inherited;
end;

function TClasse_Bombas.fnc_ValidaCadBomba(sId,sidTanque,sidbomba: String): String;
   var QryConsulta : TFDQuery;
begin
  // Tem por objetivo de verificar se a bomba com o numero do bico
  Dm.conexao.Connected := False;
  Dm.conexao.Connected := True;

  QryConsulta := TFDQuery.Create(nil);
  QryConsulta.Connection :=  Dm.conexao;
  QryConsulta.Close;
  QryConsulta.SQL.Clear;

  QryConsulta.SQL.Add('SELECT count (id) as id');
  QryConsulta.SQL.Add('FROM TBBOMBAS WHERE id <> :p_id ');
  QryConsulta.SQL.Add(' and tanque_id = :p_idTanque ');
  QryConsulta.SQL.Add(' and num_bomba = :p_idBomba ');
  QryConsulta.ParamByName('p_id').AsString := sId;
  QryConsulta.ParamByName('p_idTanque').AsString := sidTanque;
  QryConsulta.ParamByName('p_idBomba').AsString := sidbomba;
  QryConsulta.Open;

  // Se a contagem for maior que zero, significa que o registro existe
  if QryConsulta.FieldByName('id').AsInteger > 0 then
   Result := 'O registro j� existe.'
  else
    Result := '';
end;

procedure TClasse_Bombas.prc_BuscarDados(iId: Integer);
  var QryConsulta : TFDQuery;
begin
  // tem por objetivo buscar o registro
  Dm.conexao.Connected := False;
  Dm.conexao.Connected := True;

  QryConsulta := TFDQuery.Create(nil);
  QryConsulta.Connection :=  Dm.conexao;
  QryConsulta.Close;
  QryConsulta.SQL.Clear;

  QryConsulta.SQL.Add('SELECT TBBOMBAS.id,TBBOMBAS.tanque_id,TBBOMBAS.num_bomba,');
  QryConsulta.SQL.Add(' CASE WHEN TBTANQUE.TIPO = 1 THEN ''GASOLINA'' ');
  QryConsulta.SQL.Add(' ELSE ''�LEO DIESEL'' END AS DESCRICAO ');
  QryConsulta.SQL.Add('FROM TBBOMBAS  ');
  QryConsulta.SQL.Add('inner join TBTANQUE on  TBTANQUE.ID =  TBBOMBAS.TANQUE_ID ');
  QryConsulta.SQL.Add(' WHERE TBBOMBAS.id = :p_id ');
  QryConsulta.ParamByName('p_id').AsInteger := iId;
  QryConsulta.Open;

  ds_Id := QryConsulta.FieldByName('id').AsInteger;
  dsTanque_Id := QryConsulta.FieldByName('tanque_id').AsInteger;
  dsNum_Bomba := QryConsulta.FieldByName('num_bomba').AsInteger;
  dsNome_Tanque := QryConsulta.FieldByName('DESCRICAO').AsString;
end;

procedure TClasse_Bombas.prc_Deletar(iId: Integer);
begin
  Dm.conexao.Connected := False;
  Dm.conexao.Connected := True;

  // Deleta o registro
  Dm.conexao.ExecSQL ('Delete from TBBOMBAS where id = :iId ',[iId]);
end;

procedure TClasse_Bombas.prc_Inserir_Alterar(sTipo:String);
var QryManutencao : TFDQuery;
begin
  // Inserir Dados

  Dm.conexao.Connected := False;
  Dm.conexao.Connected := True;

  QryManutencao := TFDQuery.Create(nil);
  QryManutencao.Connection :=  Dm.conexao;
  QryManutencao.Close;
  QryManutencao.SQL.Clear;

  if sTipo = 'Inserir' then
  begin
    QryManutencao.SQL.Add(' Insert into TBBOMBAS (TANQUE_ID,NUM_BOMBA) Values ');
    QryManutencao.SQL.Add(' (:p_IdTanque,:p_NBomba) ');
    QryManutencao.ParamByName('p_IdTanque').AsInteger := FTanque_Id;
    QryManutencao.ParamByName('p_NBomba').AsInteger := FNum_Bomba;
  end
  else
  begin
    QryManutencao.SQL.Add(' update TBBOMBAS set  ');
    QryManutencao.SQL.Add(' NUM_BOMBA =  :p_NBomba ');
    QryManutencao.SQL.Add(' WHERE TBBOMBAS.id = :p_id ');
    QryManutencao.ParamByName('p_id').AsInteger := FId;
    QryManutencao.ParamByName('p_NBomba').AsInteger := FNum_Bomba;
  end;


  QryManutencao.ExecSQL;
end;

end.
