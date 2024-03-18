object Dm: TDm
  Height = 240
  Width = 302
  object conexao: TFDConnection
    Params.Strings = (
      'Database=C:\Estudos Delphi\Fortes Tecnologia\Banco\PostoAbc.db'
      'LockingMode=Normal'
      'User_Name=sa'
      'DriverID=SQLite')
    Connected = True
    Left = 24
    Top = 8
  end
  object Q_Tanques: TFDQuery
    AutoCalcFields = False
    Connection = conexao
    SQL.Strings = (
      'SELECT ID,TIPO'
      'FROM TBTANQUE')
    Left = 72
    Top = 8
  end
  object Q_Bombas: TFDQuery
    AutoCalcFields = False
    Connection = conexao
    SQL.Strings = (
      'SELECT *'
      'FROM TBBOMBAS ')
    Left = 104
    Top = 8
  end
  object Q_Abastecimentos: TFDQuery
    Connection = conexao
    SQL.Strings = (
      'select id,bomba_id,'
      '    data_abastecimento ,qtd,'
      '    valor,valor_imposto'
      'FROM TBABASTECIMENTOS')
    Left = 152
    Top = 8
  end
end
