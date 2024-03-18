unit UGerAbastecimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrame_Gerenciador, Data.DB, Vcl.Grids,Vcl.StdCtrls,
  Vcl.DBGrids, Datasnap.Provider, Datasnap.DBClient, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, UClasse_Abastecimentos,
  Vcl.Buttons, Vcl.ExtCtrls;

type
  TFGerAbastecimento = class(TForm)
    FFrame_Gerenciador1: TFFrame_Gerenciador;
    dbAbastecimentos: TDBGrid;
    dsConsultaAbaste: TDataSource;
    cdsConsultaAbaste: TClientDataSet;
    dpsConsultaAbaste: TDataSetProvider;
    cdsConsultaAbasteID: TIntegerField;
    cdsConsultaAbasteBOMBA_ID: TIntegerField;
    cdsConsultaAbasteDATA_ABASTECIMENTO: TDateField;
    cdsConsultaAbasteQTD: TBCDField;
    cdsConsultaAbasteVALOR: TBCDField;
    cdsConsultaAbasteVALOR_iMPOSTO: TBCDField;
    cdsConsultaAbastecalcNUM_BOMBA: TStringField;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FFrame_Gerenciador1btSairClick(Sender: TObject);
    procedure FFrame_Gerenciador1btIncluirClick(Sender: TObject);
    procedure dbAbastecimentosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FFrame_Gerenciador1btAlterarClick(Sender: TObject);
    procedure FFrame_Gerenciador1btExcluirClick(Sender: TObject);
    procedure cdsConsultaAbasteCalcFields(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    colsel : String;
  public
    { Public declarations }
    DelAbastecimentos : TClasse_Abastecimentos;
    ConsultaAbastecimento: TClasse_Abastecimentos;
  end;

var
  FGerAbastecimento: TFGerAbastecimento;

implementation

{$R *.dfm}

uses Uprinc, UMntAbastecimentos, Umodulo;

procedure TFGerAbastecimento.cdsConsultaAbasteCalcFields(DataSet: TDataSet);
begin

  cdsConsultaAbastecalcNUM_BOMBA.AsString := ConsultaAbastecimento.fnc_BuscarNumerodaBomba(cdsConsultaAbasteID.AsInteger);
end;

procedure TFGerAbastecimento.dbAbastecimentosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if not Odd((dbAbastecimentos.DataSource.DataSet as TClientDataSet).RecNo) then
  begin
      if not (gdSelected in State) then
      begin
           dbAbastecimentos.Canvas.Brush.Color := $00CBEAFE;
           dbAbastecimentos.Canvas.FillRect(Rect);
           dbAbastecimentos.DefaultDrawDataCell(Rect,Column.Field,State);
      end;
  end;

  dbAbastecimentos.Canvas.Font.Color := clBlack;

  if gdSelected in State then
  begin
      dbAbastecimentos.Canvas.Brush.Color:= $00F3EBD1;
      dbAbastecimentos.Canvas.FillRect(rect);
  end;
  dbAbastecimentos.DefaultDrawDataCell(Rect,dbAbastecimentos.Columns[DataCol].Field, State);
end;

procedure TFGerAbastecimento.FFrame_Gerenciador1btAlterarClick(Sender: TObject);
begin
  if cdsConsultaAbaste.IsEmpty then EXIT;

  Application.CreateForm(TFMntAbastecimentos, FMntAbastecimentos);
  FMntAbastecimentos.var_incluse := False;
  FMntAbastecimentos.iId := cdsConsultaAbasteID.AsInteger;
  FMntAbastecimentos.ShowModal;
  FreeAndNil(FMntAbastecimentos);
  cdsConsultaAbaste.Refresh;
end;

procedure TFGerAbastecimento.FFrame_Gerenciador1btExcluirClick(Sender: TObject);
begin
  if cdsConsultaAbaste.IsEmpty then EXIT;

  if Application.MessageBox('Deseja realmente excluir registro selecionado ?',
    'Atenção', mb_YesNo + MB_ICONQUESTION ) = IdYes then
  begin
    DelAbastecimentos := TClasse_Abastecimentos.Create(Dm.conexao);

    Try
      DelAbastecimentos.prc_Deletar(cdsConsultaAbasteID.AsInteger);
      cdsConsultaAbaste.Refresh;
    Finally
      DelAbastecimentos.Destroy;
    End

  end;
end;

procedure TFGerAbastecimento.FFrame_Gerenciador1btIncluirClick(Sender: TObject);
begin
  Application.CreateForm(TFMntAbastecimentos, FMntAbastecimentos);
  FMntAbastecimentos.var_incluse := True;
  FMntAbastecimentos.ShowModal;
  FreeAndNil(FMntAbastecimentos);
  cdsConsultaAbaste.Refresh;
end;

procedure TFGerAbastecimento.FFrame_Gerenciador1btSairClick(Sender: TObject);
begin
  Fprinc.FechaForm(Self);
  Fprinc.FormAbaste := False;
  Fprinc.VerificasAbas;
  Close;
end;

procedure TFGerAbastecimento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ConsultaAbastecimento.Destroy;
end;

procedure TFGerAbastecimento.FormCreate(Sender: TObject);
begin
  ConsultaAbastecimento := TClasse_Abastecimentos.Create(Dm.conexao);
end;

procedure TFGerAbastecimento.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and not (ActiveControl is TMemo) then
   begin
     Perform(WM_NEXTDLGCTL,0,0);
   end;
end;

procedure TFGerAbastecimento.FormShow(Sender: TObject);
begin
  cdsConsultaAbaste.Open;
  cdsConsultaAbaste.IndexFieldNames := 'DATA_ABASTECIMENTO';

  FFrame_Gerenciador1.pnlNome.Caption := 'Abastecimentos';
end;

end.
