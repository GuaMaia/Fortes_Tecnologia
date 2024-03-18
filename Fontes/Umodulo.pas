unit Umodulo;

interface

uses
  System.SysUtils, System.Classes, Data.DB,forms, Data.SqlExpr,IniFiles,
  Data.FMTBcd, Data.DBXMySQL, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait, FireDAC.Comp.Client,
  Data.DbxSqlite, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TDm = class(TDataModule)
    conexao: TFDConnection;
    Q_Tanques: TFDQuery;
    Q_Bombas: TFDQuery;
    Q_Abastecimentos: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Dm: TDm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}


{ TDm }

end.
