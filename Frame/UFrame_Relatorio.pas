unit UFrame_Relatorio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, Vcl.Imaging.pngimage;

type
  TFFrame_Relatorio = class(TFrame)
    Panel1: TPanel;
    Panel2: TPanel;
    btIncluir: TSpeedButton;
    Image1: TImage;
    pnlNome: TPanel;
    Panel4: TPanel;
    btSair: TSpeedButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
