object FMntAbastecimentos: TFMntAbastecimentos
  Left = 0
  Top = 0
  Cursor = crHandPoint
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'FMntAbastecimentos'
  ClientHeight = 260
  ClientWidth = 511
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  TextHeight = 15
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 113
    Height = 16
    Caption = 'ABASTECIMENTOS'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Shape1: TShape
    Left = 16
    Top = 31
    Width = 491
    Height = 2
    Pen.Color = 529079
    Pen.Style = psInsideFrame
  end
  object Label2: TLabel
    Left = 16
    Top = 49
    Width = 11
    Height = 15
    Cursor = crHandPoint
    Caption = 'ID'
  end
  object Label4: TLabel
    Left = 16
    Top = 98
    Width = 78
    Height = 15
    Cursor = crHandPoint
    Caption = 'N'#176' DA BOMBA'
  end
  object Label3: TLabel
    Left = 16
    Top = 143
    Width = 133
    Height = 15
    Cursor = crHandPoint
    Caption = 'QUANTIDADE DE  LITROS'
  end
  object Label5: TLabel
    Left = 90
    Top = 49
    Width = 123
    Height = 15
    Cursor = crHandPoint
    Caption = 'DATA ABASTECIMENTO'
  end
  object Label6: TLabel
    Left = 155
    Top = 143
    Width = 108
    Height = 15
    Cursor = crHandPoint
    Caption = 'VALOR ABASTECIDO'
  end
  object Label7: TLabel
    Left = 287
    Top = 143
    Width = 106
    Height = 15
    Cursor = crHandPoint
    Caption = 'VALOR DE IMPOSTO'
  end
  object Panel1: TPanel
    Left = 16
    Top = 63
    Width = 57
    Height = 25
    BevelOuter = bvNone
    Enabled = False
    TabOrder = 0
    object edId: TEdit
      Left = 0
      Top = 0
      Width = 57
      Height = 23
      Cursor = crHandPoint
      Color = clGray
      TabOrder = 0
    end
  end
  object cbNBomba: TDBLookupComboBox
    Left = 15
    Top = 114
    Width = 89
    Height = 23
    Cursor = crHandPoint
    KeyField = 'ID'
    ListField = 'NUM_BOMBA'
    ListSource = dsConsultaBomba
    TabOrder = 2
    OnClick = cbNBombaClick
  end
  object edData: TMaskEdit
    Left = 90
    Top = 65
    Width = 76
    Height = 23
    Cursor = crHandPoint
    EditMask = '99/99/9999;1;_'
    MaxLength = 10
    TabOrder = 1
    Text = '  /  /    '
  end
  inline FFrame_Cadastro1: TFFrame_Cadastro
    Left = 0
    Top = 199
    Width = 511
    Height = 61
    Align = alBottom
    TabOrder = 6
    ExplicitTop = 147
    ExplicitWidth = 511
    inherited Panel1: TPanel
      Left = 71
      ExplicitLeft = 71
      inherited BtnSalvar: TSpeedButton
        OnClick = FFrame_Cadastro1BtnSalvarClick
      end
    end
    inherited Panel2: TPanel
      Left = 258
      ExplicitLeft = 258
      inherited BtnSair: TSpeedButton
        OnClick = FFrame_Cadastro1BtnSairClick
      end
    end
  end
  object Panel2: TPanel
    Left = 287
    Top = 159
    Width = 105
    Height = 25
    BevelOuter = bvNone
    Enabled = False
    TabOrder = 5
    object edimposto: TEdit
      Left = 0
      Top = 2
      Width = 102
      Height = 23
      Cursor = crHandPoint
      Color = clGray
      TabOrder = 0
    end
  end
  object edQtd: TEdit
    Left = 16
    Top = 159
    Width = 121
    Height = 23
    TabOrder = 3
    OnExit = edQtdExit
    OnKeyPress = edQtdKeyPress
  end
  object edValor: TEdit
    Left = 155
    Top = 159
    Width = 121
    Height = 23
    TabOrder = 4
    OnExit = edValorExit
    OnKeyPress = edQtdKeyPress
  end
  object EdTexto: TEdit
    Left = 27
    Top = 114
    Width = 195
    Height = 23
    TabStop = False
    Color = clGray
    ImeName = 'Portuguese (Brazilian ABNT)'
    ReadOnly = True
    TabOrder = 7
    Text = 'EdTexto'
  end
  object Panel3: TPanel
    Left = 110
    Top = 113
    Width = 105
    Height = 25
    BevelOuter = bvNone
    Enabled = False
    TabOrder = 8
    object Ednome: TEdit
      Left = 0
      Top = 2
      Width = 102
      Height = 23
      Cursor = crHandPoint
      Color = clGray
      TabOrder = 0
    end
  end
  object dpConsultaBomba: TDataSetProvider
    DataSet = Dm.Q_Bombas
    Left = 216
  end
  object cdsConsultaBomba: TClientDataSet
    Aggregates = <>
    AutoCalcFields = False
    Params = <>
    ProviderName = 'dpConsultaBomba'
    Left = 256
    object cdsConsultaBombaID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object cdsConsultaBombaTANQUE_ID: TIntegerField
      FieldName = 'TANQUE_ID'
      Origin = 'TANQUE_ID'
    end
    object cdsConsultaBombaNUM_BOMBA: TIntegerField
      FieldName = 'NUM_BOMBA'
      Origin = 'NUM_BOMBA'
    end
  end
  object dsConsultaBomba: TDataSource
    DataSet = cdsConsultaBomba
    Left = 288
  end
end
