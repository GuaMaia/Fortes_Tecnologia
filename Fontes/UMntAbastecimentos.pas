unit UMntAbastecimentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.DBCtrls,
  Datasnap.Provider, Data.DB, Datasnap.DBClient, Vcl.Mask, Vcl.NumberBox,
  UFrame_Cadastro,System.StrUtils,UClasse_Abastecimentos;

type
  TFMntAbastecimentos = class(TForm)
    Label1: TLabel;
    Shape1: TShape;
    Label2: TLabel;
    Panel1: TPanel;
    edId: TEdit;
    Label4: TLabel;
    cbNBomba: TDBLookupComboBox;
    Label3: TLabel;
    edData: TMaskEdit;
    Label5: TLabel;
    Label6: TLabel;
    FFrame_Cadastro1: TFFrame_Cadastro;
    Label7: TLabel;
    Panel2: TPanel;
    edimposto: TEdit;
    dpConsultaBomba: TDataSetProvider;
    cdsConsultaBomba: TClientDataSet;
    dsConsultaBomba: TDataSource;
    cdsConsultaBombaID: TIntegerField;
    cdsConsultaBombaTANQUE_ID: TIntegerField;
    cdsConsultaBombaNUM_BOMBA: TIntegerField;
    edQtd: TEdit;
    edValor: TEdit;
    EdTexto: TEdit;
    Panel3: TPanel;
    Ednome: TEdit;
    procedure FFrame_Cadastro1BtnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edQtdExit(Sender: TObject);
    procedure edValorExit(Sender: TObject);
    procedure edQtdKeyPress(Sender: TObject; var Key: Char);
    procedure FFrame_Cadastro1BtnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbNBombaClick(Sender: TObject);
  private
    { Private declarations }

    Valor : Currency;
  public
    { Public declarations }
    var_incluse : Boolean;
    iId : Integer;
    Abastecimentos :  TClasse_Abastecimentos;
    function ValidaDados : Boolean;
    procedure calcularImposto;
    procedure novo;
    procedure alterar( iId : Integer);
    function AjustaValor(const ValorStr: string): String;

  end;

var
  FMntAbastecimentos: TFMntAbastecimentos;

implementation

{$R *.dfm}

uses Umodulo;

procedure TFMntAbastecimentos.alterar(iId: Integer);
begin
  Abastecimentos.prc_BuscarDados(iId);

  edId.Text := IntToStr(Abastecimentos.dsId);
  EdTexto.Text :=  Abastecimentos.fnc_BuscarNumerodaBomba(strtoint( edId.Text)  );
  edData.Text := DateToStr(Abastecimentos.dsData);
  edQtd.Text := FormatFloat('###,##0.000',Abastecimentos.dsQtd);
  edValor.Text := FormatFloat('###,##0.000', Abastecimentos.dsValor);
  edimposto.Text := FormatFloat('###,##0.000',Abastecimentos.dsValor_Imposto);

  EdTexto.Visible := true;
  edData.TabStop := False;
  edData.ReadOnly := True;
  edData.Color :=clGray;
  EdTexto.Left := cbNBomba.Left;
  Ednome.Visible := FAlse;
  edQtd.SetFocus;

end;

procedure TFMntAbastecimentos.calcularImposto;
begin
  // 13% de imposto
  Valor := StrToCurr(edValor.Text ) * 0.13;
  edimposto.Text := FormatFloat('###,##0.000', Valor);
end;

procedure TFMntAbastecimentos.cbNBombaClick(Sender: TObject);
begin
  Ednome.Text := Abastecimentos.fnc_BuscarNomeCombustivel(cdsConsultaBombaID.AsInteger);
end;

procedure TFMntAbastecimentos.edQtdExit(Sender: TObject);
begin
  if Trim(edQtd.Text) = '' then
    exit;

  edQtd.Text := FormatFloat('###,##0.000', StrtoCurr(edQtd.Text));
end;

procedure TFMntAbastecimentos.edQtdKeyPress(Sender: TObject; var Key: Char);
begin
  if (key in ['0'..'9',','] = false)  then
    key := #0;
end;

procedure TFMntAbastecimentos.edValorExit(Sender: TObject);
begin
  if Trim(edValor.Text) = '' then
    exit;

  edValor.Text := FormatFloat('###,##0.000', StrtoCurr(edValor.Text));
  calcularImposto;
end;

procedure TFMntAbastecimentos.FFrame_Cadastro1BtnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFMntAbastecimentos.FFrame_Cadastro1BtnSalvarClick(Sender: TObject);

begin
  if ValidaDados = False then
    Abort;

  calcularImposto;

  Abastecimentos.dsQtd :=  StrToCurr(edQtd.Text);
  Abastecimentos.dsValor :=  StrToCurr(edValor.Text);
  Abastecimentos.dsValor_Imposto := StrToCurr(edimposto.Text);

  if var_incluse = True then
  begin
    Abastecimentos.dsId_Bomba := cdsConsultaBombaID.AsInteger;
    Abastecimentos.dsData := StrToDate(edData.Text);

    try
      Abastecimentos.prc_Inserir_Alterar('Inserir');
    except
      on E: Exception do
      begin
        ShowMessage('Ocorreu um erro: ' + E.Message);
      end;
    end;

  end
  else
  begin
    Abastecimentos.dsId := StrToInt(edId.Text);

    try
      Abastecimentos.prc_Inserir_Alterar('Alterar');
    except
      on E: Exception do
      begin
        ShowMessage('Ocorreu um erro: ' + E.Message);
      end;
    end;
  end;

  Close;
end;

procedure TFMntAbastecimentos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  cdsConsultaBomba.Close;
  Abastecimentos.Destroy;
  Action := caFree;
end;

procedure TFMntAbastecimentos.FormCreate(Sender: TObject);
begin
  Abastecimentos := TClasse_Abastecimentos.Create(Dm.conexao);
  cdsConsultaBomba.Open;
end;

procedure TFMntAbastecimentos.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and not (ActiveControl is TMemo) then
  begin
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TFMntAbastecimentos.FormShow(Sender: TObject);
begin
  If var_incluse = true then
    novo
  Else alterar(iId);
end;

procedure TFMntAbastecimentos.novo;
begin
  edId.Text := '0';
  edData.Clear;
  edQtd.Clear;
  edValor.Clear;
  edimposto.Clear;
  edData.SetFocus;
  edData.TabStop := True;
  edData.ReadOnly := False;
  EdTexto.Visible := FAlse;
  edData.Color :=clWindow;
  Ednome.Visible := True;
end;

function TFMntAbastecimentos.AjustaValor(const ValorStr: string): String;
begin
  // Substituir pontos por vazio e v�rgulas por pontos
  Result := TRim(AnsiReplaceStr(AnsiReplaceStr(ValorStr, '.', ''), ',', ''));
end;

function TFMntAbastecimentos.ValidaDados: Boolean;
var teste : String;
begin
  Result := True;

  if  (edData.Text = '  /  /    ') then
  begin
    Application.MessageBox('Preenchimento obrigat�rio !','Aten��o',MB_ICONEXCLAMATION);
    edData.SetFocus;
    Result := False;
    Abort;
  end;

  if Length(Trim(AnsiReplaceStr(edData.Text,'/','' ))) <> 8 then
  begin
    Application.MessageBox('Data inv�lida!','Aten��o',MB_ICONEXCLAMATION);
    edData.SetFocus;
    Result := False;
    Abort;
  end;

  try
    StrToDate(edData.Text);
  except
    on E: Exception do
    begin
      Application.MessageBox('Data inv�lida !','Aten��o',MB_ICONEXCLAMATION);
      edData.SetFocus;
      Result := False;
      Abort;
    end;
  end;

  if StrToDate(edData.Text) >  Date then
  begin
    Application.MessageBox('N�o h� possibilidade de lan�ar data futuras para o abastecimento !','Aten��o',MB_ICONEXCLAMATION);
    edData.SetFocus;
    Result := False;
    Abort;
  end;


  if (var_incluse = True) and (Trim(cbNBomba.Text) = '' ) then
  begin
    Application.MessageBox('Preenchimento obrigat�rio !','Aten��o',MB_ICONEXCLAMATION);
    cbNBomba.SetFocus;
    Result := False;
    Abort;
  end;

  if Trim(edQtd.Text) = '' then
  begin
    Application.MessageBox('Preenchimento obrigat�rio !','Aten��o',MB_ICONEXCLAMATION);
    edQtd.SetFocus;
    Result := False;
    Abort;
  end;

  teste := AjustaValor (edQtd.Text);

  if  (StrToInt( AjustaValor (edQtd.Text)) <= 0) then
  begin
    Application.MessageBox('Quandidade de litros inv�lido !','Aten��o',MB_ICONEXCLAMATION);
    edQtd.SetFocus;
    Result := False;
    Abort;
  end;

   if ( StrToInt( AjustaValor (edQtd.Text)) >= 1000000 ) then
  begin
    Application.MessageBox('Quandidade de litros inv�lido !','Aten��o',MB_ICONEXCLAMATION);
    edQtd.SetFocus;
    Result := False;
    Abort;
  end;

  if Trim(edValor.Text) = ''then
  begin
    Application.MessageBox('Preenchimento obrigat�rio !','Aten��o',MB_ICONEXCLAMATION);
    edValor.SetFocus;
    Result := False;
    Abort;
  end;

 if  (StrToInt( AjustaValor (edValor.Text)) <= 0) then
  begin
    Application.MessageBox('Quandidade de litros inv�lido !','Aten��o',MB_ICONEXCLAMATION);
    edValor.SetFocus;
    Result := False;
    Abort;
  end;

   if ( StrToInt( AjustaValor (edValor.Text)) >= 1000000 ) then
  begin
    Application.MessageBox('Quandidade de litros inv�lido !','Aten��o',MB_ICONEXCLAMATION);
    edValor.SetFocus;
    Result := False;
    Abort;
  end;
end;

end.
