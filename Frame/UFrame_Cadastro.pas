unit UFrame_Cadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Imaging.jpeg, Vcl.StdCtrls;

type
  TFFrame_Cadastro = class(TFrame)
    Panel1: TPanel;
    BtnSalvar: TSpeedButton;
    Panel2: TPanel;
    BtnSair: TSpeedButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
