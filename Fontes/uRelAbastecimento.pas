unit uRelAbastecimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrame_Relatorio, Vcl.StdCtrls, Vcl.Mask,System.StrUtils,
  Datasnap.Provider, Data.DB, Datasnap.DBClient, Umodulo, Vcl.DBCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Moni.Base,
  FireDAC.Moni.RemoteClient, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Grids, Vcl.DBGrids,DateUtils, UClasse_Tanques, Vcl.ExtCtrls ;

type
  TFRelAbastecimento = class(TForm)
    FFrame_Relatorio1: TFFrame_Relatorio;
    Label5: TLabel;
    edDataIni: TMaskEdit;
    edDataFim: TMaskEdit;
    Label3: TLabel;
    Label1: TLabel;
    cbTipo: TComboBox;
    QRelatorio: TFDQuery;
    cdsRelAbaste: TClientDataSet;
    dspRelAbaste: TDataSetProvider;
    cdsRelAbasteDATA_ABASTECIMENTO: TDateField;
    cdsRelAbasteQTD: TBCDField;
    cdsRelAbasteVALOR: TBCDField;
    cdsRelAbasteVALOR_iMPOSTO: TBCDField;
    cdsRelAbasteNUM_BOMBA: TIntegerField;
    cdsRelAbasteTIPO: TIntegerField;
    dsRelAbaste: TDataSource;
    cdsRelAbasteCalTanques: TStringField;
    cdsRelAbasteID: TIntegerField;
    RgRel: TRadioGroup;
    procedure FormShow(Sender: TObject);
    procedure FFrame_Relatorio1btSairClick(Sender: TObject);
    procedure FFrame_Relatorio1btIncluirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cdsRelAbasteCalcFields(DataSet: TDataSet);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    ConsTanques : TClasse_Tanques;
  end;

var
  FRelAbastecimento: TFRelAbastecimento;

implementation

{$R *.dfm}

uses URelAbaste, Uprinc;

procedure TFRelAbastecimento.cdsRelAbasteCalcFields(DataSet: TDataSet);
begin
  cdsRelAbasteCalTanques.AsString := ConsTanques.fnc_Consulta_id(cdsRelAbasteID.AsString);
end;

procedure TFRelAbastecimento.FFrame_Relatorio1btIncluirClick(Sender: TObject);
begin
  if (edDataIni.Text = '  /  /    ') then
  begin
    Application.MessageBox('Preenchimento obrigat�rio !','Aten��o',MB_ICONEXCLAMATION);
    edDataIni.SetFocus;
    Abort;
  end;

  if Length(Trim(AnsiReplaceStr(edDataIni.Text,'/','' ))) <> 8 then
  begin
    Application.MessageBox('Data inv�lida!','Aten��o',MB_ICONEXCLAMATION);
    edDataIni.SetFocus;
    Abort;
  end;

  try
    StrToDate(edDataIni.Text);
  except
    on E: Exception do
    begin
      Application.MessageBox('Data inv�lida !','Aten��o',MB_ICONEXCLAMATION);
      edDataIni.SetFocus;
      Abort;
    end;
  end;

  if (edDataFim.Text = '  /  /    ') then
  begin
    Application.MessageBox('Preenchimento obrigat�rio !','Aten��o',MB_ICONEXCLAMATION);
    edDataFim.SetFocus;
    Abort;
  end;

  if Length(Trim(AnsiReplaceStr(edDataFim.Text,'/','' ))) <> 8 then
  begin
    Application.MessageBox('Data inv�lida!','Aten��o',MB_ICONEXCLAMATION);
    edDataFim.SetFocus;
    Abort;
  end;

  try
    StrToDate(edDataFim.Text);
  except
    on E: Exception do
    begin
      Application.MessageBox('Data inv�lida !','Aten��o',MB_ICONEXCLAMATION);
      edDataFim.SetFocus;
      Abort;
    end;
  end;

  if StrToDate(edDataIni.Text) > StrToDate(edDataFim.Text) then
   begin
    Application.MessageBox('Data Final � maior que a data Inicial !','Aten��o',MB_ICONEXCLAMATION);
    edDataFim.SetFocus;
    Abort;
  end;

  if Trim(cbTipo.Text) = '' then
  begin
    Application.MessageBox('Preenchimento obrigat�rio !','Aten��o',MB_ICONEXCLAMATION);
    cbTipo.SetFocus;
    Abort;
  end;

  with QRelatorio do
  begin
    close;
    sql.Clear;
    sql.Add('select abe.data_abastecimento ,abe.qtd, ');
    sql.Add('abe.valor,abe.valor_imposto,bomb.NUM_BOMBA,TBTANQUE.TIPO,TBTANQUE.ID ');
    sql.Add('FROM TBABASTECIMENTOS as abe ');
    sql.Add('inner join TBBOMBAS as bomb on  bomb.id = abe.bomba_id ');
    sql.Add('inner join TBTANQUE on  TBTANQUE.ID =  bomb.TANQUE_ID ');
    sql.Add('where 1=1 ');
    sql.Add('AND data_abastecimento BETWEEN :dataini AND :datafim ');

    if cbTipo.ItemIndex <> 2 then
    begin
      sql.Add('AND tipo = :Tipo ');
    end;

    if RgRel.ItemIndex <> 2 then
      sql.Add('order by TBTANQUE.TIPO ')
    else
     sql.Add('order by abe.data_abastecimento ');

    ParamByName('dataini').AsDateTime := StrToDateTime(edDataIni.Text);
    ParamByName('datafim').AsDateTime := StrToDateTime(edDataFim.Text);

    if cbTipo.ItemIndex <> 2 then
    begin
       ParamByName('Tipo').AsInteger := cbTipo.ItemIndex + 1;
    end;

    Open;
  end;

  cdsRelAbaste.Close;
  cdsRelAbaste.Open;

  if cdsRelAbaste.RecordCount = 0 then
  begin
    Application.MessageBox('N�o h� dados a imprimir !','Aten��o',MB_ICONEXCLAMATION);
    Abort;
  end
  else
  begin
     try
         Application.CreateForm(TFRelAbaste,FRelAbaste);

         case RgRel.ItemIndex of
          0: FRelAbaste.RelGpData.PreviewModal;
          1: FRelAbaste.RelGpTipo.PreviewModal;
          2: FRelAbaste.RelAbastecimentos.PreviewModal;
          end;

     finally
          FreeAndNil(FRelAbaste);
     end;
  end;

end;

procedure TFRelAbastecimento.FFrame_Relatorio1btSairClick(Sender: TObject);
begin
  Fprinc.FechaForm(Self);
  Fprinc.FormRel := False;
  Fprinc.VerificasAbas;
  Close;
end;

procedure TFRelAbastecimento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ConsTanques.Destroy;
end;

procedure TFRelAbastecimento.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and not (ActiveControl is TMemo) then
  begin
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TFRelAbastecimento.FormShow(Sender: TObject);
var
  DataInicialMes: TDateTime;
begin
  ConsTanques := TClasse_Tanques.Create(Dm.conexao);

  FFrame_Relatorio1.pnlNome.Caption := 'Relat�rio de Abastecimentos';
  DataInicialMes := EncodeDate(YearOf(Now), MonthOf(Now), 1);

  edDataIni.Text := FormatDateTime('dd/mm/yyyy', DataInicialMes);
  edDataFim.Text := FormatDateTime('dd/mm/yyyy', Now);
  cbTipo.ItemIndex := 2;
  RgRel.ItemIndex := 2;
  edDataIni.SetFocus;
end;

end.
