program Candidato_GustavoMaia;

uses
  Vcl.Forms,
  Uprinc in 'Uprinc.pas' {Fprinc},
  UFrame_Cadastro in '..\Frame\UFrame_Cadastro.pas' {FFrame_Cadastro: TFrame},
  UFrame_Gerenciador in '..\Frame\UFrame_Gerenciador.pas' {FFrame_Gerenciador: TFrame},
  Umodulo in 'Umodulo.pas' {Dm: TDataModule},
  UCadTanques in 'UCadTanques.pas' {FCadTanques},
  UCadBombas in 'UCadBombas.pas' {FCadBombas},
  UMntTanques in 'UMntTanques.pas' {FMntTanques},
  UClasse_Tanques in 'UClasse_Tanques.pas',
  UClasse_Bombas in 'UClasse_Bombas.pas',
  UMntBombas in 'UMntBombas.pas' {FMntBombas},
  UClasse_Abastecimentos in 'UClasse_Abastecimentos.pas',
  UGerAbastecimento in 'UGerAbastecimento.pas' {FGerAbastecimento},
  UMntAbastecimentos in 'UMntAbastecimentos.pas' {FMntAbastecimentos},
  uRelAbastecimento in 'uRelAbastecimento.pas' {FRelAbastecimento},
  UFrame_Relatorio in '..\Frame\UFrame_Relatorio.pas' {FFrame_Relatorio: TFrame},
  URelAbaste in 'URelAbaste.pas' {FRelAbaste};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDm, Dm);
  Application.CreateForm(TFprinc, Fprinc);
  Application.Run;
end.
