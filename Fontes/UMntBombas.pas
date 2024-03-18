unit UMntBombas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  UFrame_Cadastro, Vcl.NumberBox, UClasse_Bombas, Vcl.DBCtrls, Data.DB,
  Datasnap.DBClient, Datasnap.Provider;

type
  TFMntBombas = class(TForm)
    Label1: TLabel;
    Shape1: TShape;
    Label2: TLabel;
    Panel1: TPanel;
    edId: TEdit;
    Label3: TLabel;
    FFrame_Cadastro1: TFFrame_Cadastro;
    Label4: TLabel;
    edNumBomba: TNumberBox;
    cbTipo: TDBLookupComboBox;
    dspMntTanque: TDataSetProvider;
    cdsMntTanque: TClientDataSet;
    cdsMntTanqueID: TIntegerField;
    cdsMntTanqueTIPO: TIntegerField;
    cdsMntTanqueCalcTipo: TStringField;
    dsMntTanque: TDataSource;
    EdTexto: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FFrame_Cadastro1BtnSalvarClick(Sender: TObject);
    procedure cdsMntTanqueCalcFields(DataSet: TDataSet);
    procedure FFrame_Cadastro1BtnSairClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    var_incluse : Boolean;
    iId : Integer;
    Bombas : TClasse_Bombas;
    procedure novo;
    procedure alterar( iId : Integer);
    function ValidarDados : Boolean;
  end;

var
  FMntBombas: TFMntBombas;

implementation

{$R *.dfm}

uses Umodulo;

procedure TFMntBombas.alterar(iId: Integer);
begin
  Bombas.prc_BuscarDados(iId);

  edId.Text := IntToStr(Bombas.ds_Id);
  edNumBomba.Text := IntToStr(Bombas.dsNum_Bomba);

  cbTipo.Enabled := False;
  cbTipo.TabStop := True;
  EdTexto.Visible := True;
  EdTexto.Top := cbTipo.Top;
  EdTexto.Text :=  Bombas.dsNome_Tanque;
end;

procedure TFMntBombas.cdsMntTanqueCalcFields(DataSet: TDataSet);
begin
  if cdsMntTanqueTIPO.AsInteger = 1 then
    cdsMntTanqueCalcTipo.AsString := 'GASOLINA'
  else cdsMntTanqueCalcTipo.AsString := '�LEO DIESEL';
end;

procedure TFMntBombas.FFrame_Cadastro1BtnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFMntBombas.FFrame_Cadastro1BtnSalvarClick(Sender: TObject);
var sMsng : string;
begin
  if ValidarDados = False then
    Abort;

  // Passa na variavel pois mensagem esta dentro da fun��o
  sMsng := Bombas.fnc_ValidaCadBomba(edId.Text,cdsMntTanqueID.AsString,edNumBomba.Text);

  if Trim(sMsng) <> '' then
  begin
     Application.MessageBox(Pchar(sMsng),'Aten��o',MB_ICONEXCLAMATION);
    Abort;
  end;

  Bombas.dsNum_Bomba := StrToInt(edNumBomba.Text);

  if var_incluse = True then
  begin
    Bombas.dsTanque_Id := cdsMntTanqueID.AsInteger;
    try
      Bombas.prc_Inserir_Alterar('Inserir');
    except
      on E: Exception do
      begin
        ShowMessage('Ocorreu um erro: ' + E.Message);
      end;
    end;
  end
  else
  begin
    Bombas.ds_Id := StrToInt(edId.Text);

    try
      Bombas.prc_Inserir_Alterar('Alterar');
    except
      on E: Exception do
      begin
        ShowMessage('Ocorreu um erro: ' + E.Message);
      end;
    end;
  end;

  Close;
end;

procedure TFMntBombas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  cdsMntTanque.Close;
  Bombas.Destroy;
  Action := caFree;
end;

procedure TFMntBombas.FormCreate(Sender: TObject);
begin
  Bombas := TClasse_Bombas.Create(Dm.conexao);
  cdsMntTanque.Open;
end;

procedure TFMntBombas.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and not (ActiveControl is TMemo) then
   begin
     Perform(WM_NEXTDLGCTL,0,0);
   end;
end;

procedure TFMntBombas.FormShow(Sender: TObject);
begin
  If var_incluse = true then
          novo
  Else alterar(iId);
end;

procedure TFMntBombas.novo;
begin
  edId.Text := '0';
  edNumBomba.Clear;
  EdTexto.Visible := False;
  cdsMntTanque.First;
  cbTipo.SetFocus;
end;

function TFMntBombas.ValidarDados: Boolean;
begin
  Result := True;

  if (var_incluse = True) and (Trim(cbTipo.Text) = '' )then
  begin
    Application.MessageBox('Preenchimento obrigat�rio !','Aten��o',MB_ICONEXCLAMATION);
    cbTipo.SetFocus;
    Result := False;
    Abort;
  end;

  if Trim(edNumBomba.Text) = '' then
  begin
    Application.MessageBox('Preenchimento obrigat�rio !','Aten��o',MB_ICONEXCLAMATION);
    edNumBomba.SetFocus;
    Result := False;
    Abort;
  end;

  if StrToInt(edNumBomba.Text) <= 0 then
  begin
    Application.MessageBox('N�mero de Bomba Inv�lido !','Aten��o',MB_ICONEXCLAMATION);
    edNumBomba.SetFocus;
    Result := False;
    Abort;
  end;

end;

end.
