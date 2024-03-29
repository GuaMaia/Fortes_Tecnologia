object FRelAbastecimento: TFRelAbastecimento
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'Relat'#243'rio de Abastecimentos'
  ClientHeight = 157
  ClientWidth = 738
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poDesktopCenter
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  TextHeight = 15
  object Label5: TLabel
    Left = 14
    Top = 57
    Width = 123
    Height = 15
    Cursor = crHandPoint
    Caption = 'DATA ABASTECIMENTO'
  end
  object Label3: TLabel
    Left = 15
    Top = 107
    Width = 122
    Height = 15
    Cursor = crHandPoint
    Caption = 'TIPO DE COMBUSTIV'#201'L'
  end
  object Label1: TLabel
    Left = 96
    Top = 79
    Width = 19
    Height = 15
    Cursor = crHandPoint
    Caption = 'AT'#201
  end
  inline FFrame_Relatorio1: TFFrame_Relatorio
    Left = 0
    Top = 0
    Width = 738
    Height = 50
    Align = alTop
    TabOrder = 4
    ExplicitWidth = 596
    inherited Panel1: TPanel
      Width = 738
      ExplicitWidth = 596
      inherited Panel2: TPanel
        inherited btIncluir: TSpeedButton
          OnClick = FFrame_Relatorio1btIncluirClick
        end
      end
      inherited Panel4: TPanel
        Left = 681
        ExplicitLeft = 539
        inherited btSair: TSpeedButton
          OnClick = FFrame_Relatorio1btSairClick
        end
      end
    end
  end
  object edDataIni: TMaskEdit
    Left = 14
    Top = 74
    Width = 76
    Height = 23
    Cursor = crHandPoint
    EditMask = '99/99/9999;1;_'
    MaxLength = 10
    TabOrder = 0
    Text = '  /  /    '
  end
  object edDataFim: TMaskEdit
    Left = 123
    Top = 74
    Width = 76
    Height = 23
    Cursor = crHandPoint
    EditMask = '99/99/9999;1;_'
    MaxLength = 10
    TabOrder = 1
    Text = '  /  /    '
  end
  object cbTipo: TComboBox
    Left = 15
    Top = 123
    Width = 145
    Height = 22
    Style = csOwnerDrawFixed
    CharCase = ecUpperCase
    TabOrder = 2
    Items.Strings = (
      'GASOLINA'
      #211'LEO DIESEL'
      'TODOS')
  end
  object RgRel: TRadioGroup
    Left = 176
    Top = 103
    Width = 489
    Height = 46
    Caption = 'Agrupor por: '
    Columns = 3
    Items.Strings = (
      'Data de Abastecimentos'
      'Tipo de Combust'#237'vel'
      'Nenhum')
    TabOrder = 3
  end
  object QRelatorio: TFDQuery
    Connection = Dm.conexao
    SQL.Strings = (
      'select abe.data_abastecimento ,abe.qtd,'
      
        '    abe.valor,abe.valor_imposto,bomb.NUM_BOMBA,TBTANQUE.TIPO,TBT' +
        'ANQUE.ID'
      'FROM TBABASTECIMENTOS as abe'
      'inner join TBBOMBAS as bomb on  bomb.id = abe.bomba_id'
      'inner join TBTANQUE on  TBTANQUE.ID =  bomb.TANQUE_ID')
    Left = 184
    Top = 16
  end
  object cdsRelAbaste: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'DATA_ABASTECIMENTO'
        Attributes = [faRequired]
        DataType = ftDate
      end
      item
        Name = 'QTD'
        Attributes = [faRequired]
        DataType = ftBCD
        Precision = 12
        Size = 3
      end
      item
        Name = 'VALOR'
        Attributes = [faRequired]
        DataType = ftBCD
        Precision = 12
        Size = 3
      end
      item
        Name = 'VALOR_iMPOSTO'
        Attributes = [faRequired]
        DataType = ftBCD
        Precision = 12
        Size = 3
      end
      item
        Name = 'NUM_BOMBA'
        Attributes = [faReadonly]
        DataType = ftInteger
      end
      item
        Name = 'TIPO'
        Attributes = [faReadonly]
        DataType = ftInteger
      end
      item
        Name = 'ID'
        Attributes = [faReadonly]
        DataType = ftInteger
      end>
    IndexDefs = <>
    FetchOnDemand = False
    Params = <>
    ProviderName = 'dspRelAbaste'
    StoreDefs = True
    OnCalcFields = cdsRelAbasteCalcFields
    Left = 248
    Top = 16
    object cdsRelAbasteDATA_ABASTECIMENTO: TDateField
      FieldName = 'DATA_ABASTECIMENTO'
      Required = True
    end
    object cdsRelAbasteQTD: TBCDField
      FieldName = 'QTD'
      Required = True
      DisplayFormat = '###,##0.000'
      EditFormat = '###,##0.000'
      Precision = 12
      Size = 3
    end
    object cdsRelAbasteVALOR: TBCDField
      FieldName = 'VALOR'
      Required = True
      DisplayFormat = '###,##0.000'
      EditFormat = '###,##0.000'
      Precision = 12
      Size = 3
    end
    object cdsRelAbasteVALOR_iMPOSTO: TBCDField
      FieldName = 'VALOR_iMPOSTO'
      Required = True
      DisplayFormat = '###,##0.000'
      EditFormat = '###,##0.000'
      Precision = 12
      Size = 3
    end
    object cdsRelAbasteNUM_BOMBA: TIntegerField
      FieldName = 'NUM_BOMBA'
      ReadOnly = True
    end
    object cdsRelAbasteTIPO: TIntegerField
      FieldName = 'TIPO'
      ReadOnly = True
    end
    object cdsRelAbasteCalTanques: TStringField
      FieldKind = fkCalculated
      FieldName = 'CalTanques'
      Size = 18
      Calculated = True
    end
    object cdsRelAbasteID: TIntegerField
      FieldName = 'ID'
      ReadOnly = True
    end
  end
  object dspRelAbaste: TDataSetProvider
    DataSet = QRelatorio
    Left = 216
    Top = 16
  end
  object dsRelAbaste: TDataSource
    DataSet = cdsRelAbaste
    Left = 280
    Top = 16
  end
end
