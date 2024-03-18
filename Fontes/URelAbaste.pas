unit URelAbaste;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, RLReport;

type
  TFRelAbaste = class(TForm)
    RelAbastecimentos: TRLReport;
    RLBand2: TRLBand;
    RLLabel7: TRLLabel;
    RLSystemInfo4: TRLSystemInfo;
    RLSystemInfo5: TRLSystemInfo;
    RLSystemInfo6: TRLSystemInfo;
    RLBand5: TRLBand;
    RLLabel10: TRLLabel;
    RLLabel1: TRLLabel;
    RLLabel12: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLLabel4: TRLLabel;
    RLDBText1: TRLDBText;
    RLBand1: TRLBand;
    RLLabel5: TRLLabel;
    RLDBResult1: TRLDBResult;
    RLDBResult2: TRLDBResult;
    RLDBResult3: TRLDBResult;
    RelGpTipo: TRLReport;
    RLBand3: TRLBand;
    RLLabel6: TRLLabel;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
    RLSystemInfo3: TRLSystemInfo;
    RLLabel9: TRLLabel;
    RLLabel11: TRLLabel;
    RLLabel13: TRLLabel;
    RLLabel14: TRLLabel;
    RLLabel15: TRLLabel;
    RLBand6: TRLBand;
    RLLabel16: TRLLabel;
    RLDBResult4: TRLDBResult;
    RLDBResult5: TRLDBResult;
    RLDBResult6: TRLDBResult;
    RLGroup1: TRLGroup;
    RLBand7: TRLBand;
    RLLabel8: TRLLabel;
    RLDBText7: TRLDBText;
    RLBand4: TRLBand;
    RLDBText9: TRLDBText;
    RLDBText10: TRLDBText;
    RLDBText11: TRLDBText;
    RLDBText12: TRLDBText;
    RLDBText13: TRLDBText;
    RelGpData: TRLReport;
    RLBand8: TRLBand;
    RLLabel17: TRLLabel;
    RLSystemInfo7: TRLSystemInfo;
    RLSystemInfo8: TRLSystemInfo;
    RLSystemInfo9: TRLSystemInfo;
    RLLabel18: TRLLabel;
    RLLabel19: TRLLabel;
    RLLabel20: TRLLabel;
    RLLabel22: TRLLabel;
    RLBand9: TRLBand;
    RLLabel23: TRLLabel;
    RLDBResult7: TRLDBResult;
    RLDBResult8: TRLDBResult;
    RLDBResult9: TRLDBResult;
    RLGroup2: TRLGroup;
    RLBand10: TRLBand;
    RLLabel24: TRLLabel;
    RLDBText8: TRLDBText;
    RLBand11: TRLBand;
    RLDBText14: TRLDBText;
    RLDBText15: TRLDBText;
    RLDBText16: TRLDBText;
    RLDBText17: TRLDBText;
    RLLabel21: TRLLabel;
    RLDBText18: TRLDBText;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FRelAbaste: TFRelAbaste;

implementation

{$R *.dfm}

uses uRelAbastecimento;


end.
