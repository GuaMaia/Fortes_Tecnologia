unit UCadTanques;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrame_Gerenciador, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,Datasnap.DBClient, Datasnap.Provider,UClasse_Tanques;

type
  TFCadTanques = class(TForm)
    FFrame_Gerenciador1: TFFrame_Gerenciador;
    dbTaques: TDBGrid;
    dspConTanque: TDataSetProvider;
    cdsConTanque: TClientDataSet;
    dsConTanque: TDataSource;
    cdsConTanqueID: TIntegerField;
    cdsConTanqueTIPO: TIntegerField;
    cdsConTanqueCalcTipo: TStringField;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure dbTaquesDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FFrame_Gerenciador1btSairClick(Sender: TObject);
    procedure FFrame_Gerenciador1btIncluirClick(Sender: TObject);
    procedure cdsConTanqueCalcFields(DataSet: TDataSet);
  private
    { Private declarations }

  public
    { Public declarations }
    DelTanques : TClasse_Tanques;
  end;

var
  FCadTanques: TFCadTanques;

implementation

{$R *.dfm}

uses Uprinc, UMntTanques, Umodulo;

procedure TFCadTanques.cdsConTanqueCalcFields(DataSet: TDataSet);
begin
  if cdsConTanqueTIPO.AsInteger = 1 then
    cdsConTanqueCalcTipo.AsString := 'GASOLINA'
  else cdsConTanqueCalcTipo.AsString := '�LEO DIESEL';
end;

procedure TFCadTanques.dbTaquesDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if not Odd((dbTaques.DataSource.DataSet as TClientDataSet).RecNo) then
  begin
      if not (gdSelected in State) then
      begin
           dbTaques.Canvas.Brush.Color := $00CBEAFE;
           dbTaques.Canvas.FillRect(Rect);
           dbTaques.DefaultDrawDataCell(Rect,Column.Field,State);
      end;
  end;

  dbTaques.Canvas.Font.Color := clBlack;

  if gdSelected in State then
  begin
      dbTaques.Canvas.Brush.Color:= $00F3EBD1;
      dbTaques.Canvas.FillRect(rect);
  end;
  dbTaques.DefaultDrawDataCell(Rect,dbTaques.Columns[DataCol].Field, State);
end;

procedure TFCadTanques.FFrame_Gerenciador1btIncluirClick(Sender: TObject);
begin
  if cdsConTanque.RecordCount = 2 then
  begin
    Application.MessageBox('� poss�vel cadastrar apenas 2 tipos de tanques !','Aten��o',MB_ICONEXCLAMATION);
    Abort;
  end;

  Application.CreateForm(TFMntTanques, FMntTanques);
  FMntTanques.ShowModal;
  FreeAndNil(FMntTanques);
  cdsConTanque.Refresh;
end;

procedure TFCadTanques.FFrame_Gerenciador1btSairClick(Sender: TObject);
begin
  Fprinc.FechaForm(Self);
  Fprinc.FormTanq := False;
  Fprinc.VerificasAbas;
  Close;
end;

procedure TFCadTanques.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and not (ActiveControl is TMemo) then
   begin
     Perform(WM_NEXTDLGCTL,0,0);
   end;
end;

procedure TFCadTanques.FormShow(Sender: TObject);
begin
  cdsConTanque.Open;

  FFrame_Gerenciador1.pnlNome.Caption := 'Cadastro de Tanques';
end;

end.
