unit UClasse_Abastecimentos;

interface

uses
  FireDAC.Comp.Client;

type
  TClasse_Abastecimentos = class
  private
    FConexao : TFDConnection;
    FId: Integer;
    FId_bomba: Integer;
    FData_Abastecimento : TDateTime;
    FQdt : Real;
    FValor : Real;
    FValor_Imposto : Real;

  public
    property Conexao : TFDConnection read  FConexao write FConexao;
    property dsId : Integer read  FId write FId;
    property dsId_Bomba : Integer read  FId_bomba write FId_bomba;
    property dsData :  TDateTime read  FData_Abastecimento write FData_Abastecimento;
    property dsQtd :  Real read  FQdt write FQdt;
    property dsValor :  Real read  FValor write FValor;
    property dsValor_Imposto :  Real read  FValor_Imposto write FValor_Imposto;

    constructor Create(Conexao: TFDConnection);
    destructor Destroy; override;

    procedure prc_Inserir_Alterar(sTipo:String);
    procedure prc_Deletar(iId : Integer);
    procedure prc_BuscarDados(iId : Integer);
    Function fnc_BuscarNumerodaBomba(iId : Integer) : String;
    Function fnc_BuscarNomeCombustivel(iId : Integer) : String;
  end;

implementation

{ TClasse_Abastecimentos }

uses Umodulo;

constructor TClasse_Abastecimentos.Create(Conexao: TFDConnection);
begin
  FConexao := Conexao;
end;

destructor TClasse_Abastecimentos.Destroy;
begin

  inherited;
end;

function TClasse_Abastecimentos.fnc_BuscarNomeCombustivel(iId: Integer): String;
var QryConsulta : TFDQuery;
begin
  // tem por objetivo buscar o registro
  Dm.conexao.Connected := False;
  Dm.conexao.Connected := True;

  QryConsulta := TFDQuery.Create(nil);
  QryConsulta.Connection :=  Dm.conexao;
  QryConsulta.Close;
  QryConsulta.SQL.Clear;

  QryConsulta.SQL.Add('select  ');
  QryConsulta.SQL.Add('CASE WHEN TIPO = 1 THEN ''GASOLINA'' ');
  QryConsulta.SQL.Add('ELSE ''�LEO DIESEL'' END AS DESCRICAO ');
  QryConsulta.SQL.Add(' FROM TBBOMBAS as bomb ');
  QryConsulta.SQL.Add(' inner join TBTANQUE on  TBTANQUE.ID =  bomb.TANQUE_ID  ');
  QryConsulta.SQL.Add(' WHERE bomb.id = :p_id ');
  QryConsulta.ParamByName('p_id').AsInteger := iId;
  QryConsulta.Open;

  Result := QryConsulta.FieldByName('DESCRICAO').AsString;

end;

function TClasse_Abastecimentos.fnc_BuscarNumerodaBomba(iId: Integer): String;
 var QryConsulta : TFDQuery;
begin
  // tem por objetivo buscar o registro
  Dm.conexao.Connected := False;
  Dm.conexao.Connected := True;

  QryConsulta := TFDQuery.Create(nil);
  QryConsulta.Connection :=  Dm.conexao;
  QryConsulta.Close;
  QryConsulta.SQL.Clear;

  QryConsulta.SQL.Add('select  bomb.NUM_BOMBA,  ');
  QryConsulta.SQL.Add('CASE WHEN TIPO = 1 THEN ''GASOLINA'' ');
  QryConsulta.SQL.Add('ELSE ''�LEO DIESEL'' END AS DESCRICAO ');
  QryConsulta.SQL.Add(' FROM TBABASTECIMENTOS as abe ');
  QryConsulta.SQL.Add(' inner join TBBOMBAS as bomb on bomb.id = abe.bomba_id  ');
  QryConsulta.SQL.Add(' inner join TBTANQUE on  TBTANQUE.ID =  bomb.TANQUE_ID  ');
  QryConsulta.SQL.Add(' WHERE abe.id = :p_id ');
  QryConsulta.ParamByName('p_id').AsInteger := iId;
  QryConsulta.Open;

  Result :=QryConsulta.FieldByName('NUM_BOMBA').AsString + ' - ' + QryConsulta.FieldByName('DESCRICAO').AsString;

end;

procedure TClasse_Abastecimentos.prc_BuscarDados(iId: Integer);
  var QryConsulta : TFDQuery;
begin
  // tem por objetivo buscar o registro
  Dm.conexao.Connected := False;
  Dm.conexao.Connected := True;

  QryConsulta := TFDQuery.Create(nil);
  QryConsulta.Connection :=  Dm.conexao;
  QryConsulta.Close;
  QryConsulta.SQL.Clear;

  QryConsulta.SQL.Add('select abe.id,abe.bomba_id, ');
  QryConsulta.SQL.Add(' abe.data_abastecimento ,abe.qtd, ');
  QryConsulta.SQL.Add('  abe.valor,abe.valor_imposto  ');
  QryConsulta.SQL.Add('FROM TBABASTECIMENTOS as abe  ');
  QryConsulta.SQL.Add(' WHERE abe.id = :p_id ');
  QryConsulta.ParamByName('p_id').AsInteger := iId;
  QryConsulta.Open;

  dsId := QryConsulta.FieldByName('id').AsInteger;
  dsId_Bomba := QryConsulta.FieldByName('bomba_id').AsInteger;
  dsData := QryConsulta.FieldByName('data_abastecimento').AsDateTime;
  dsQtd := QryConsulta.FieldByName('qtd').AsCurrency;
  dsValor := QryConsulta.FieldByName('valor').AsCurrency;
  dsValor_Imposto := QryConsulta.FieldByName('valor_imposto').AsCurrency;

end;

procedure TClasse_Abastecimentos.prc_Deletar(iId: Integer);
begin
  Dm.conexao.Connected := False;
  Dm.conexao.Connected := True;

  // Deleta o registro
  Dm.conexao.ExecSQL ('Delete from TBABASTECIMENTOS where id = :iId ',[iId]);
end;

procedure TClasse_Abastecimentos.prc_Inserir_Alterar(sTipo:String);
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
    QryManutencao.SQL.Add(' Insert into TBABASTECIMENTOS (BOMBA_ID,DATA_ABASTECIMENTO ');
    QryManutencao.SQL.Add(' ,QTD,VALOR,VALOR_iMPOSTO) Values ');
    QryManutencao.SQL.Add(' (:p_idBomba,:p_data,:p_qtd,:p_valor,:p_imposto) ');
    QryManutencao.ParamByName('p_idBomba').AsInteger := FId_bomba;
    QryManutencao.ParamByName('p_data').AsDate := FData_Abastecimento;
    QryManutencao.ParamByName('p_qtd').AsCurrency := FQdt;
    QryManutencao.ParamByName('p_valor').AsCurrency := FValor;
    QryManutencao.ParamByName('p_imposto').AsCurrency := FValor_Imposto;
  end
  else
  begin
    QryManutencao.SQL.Add(' update TBABASTECIMENTOS set  ');
    QryManutencao.SQL.Add(' QTD =  :p_qtd ');
    QryManutencao.SQL.Add(',VALOR =  :p_valor ');
    QryManutencao.SQL.Add(',VALOR_iMPOSTO =  :p_imposto ');
    QryManutencao.SQL.Add(' WHERE TBABASTECIMENTOS.id = :p_id ');
    QryManutencao.ParamByName('p_id').AsInteger := FId;
    QryManutencao.ParamByName('p_qtd').AsCurrency := FQdt;
    QryManutencao.ParamByName('p_valor').AsCurrency := FValor;
    QryManutencao.ParamByName('p_imposto').AsCurrency := FValor_Imposto;
  end;


  QryManutencao.ExecSQL;
end;

end.
