object FMntTanques: TFMntTanques
  Left = 0
  Top = 0
  Cursor = crHandPoint
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'FMntTanques'
  ClientHeight = 208
  ClientWidth = 434
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 14
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 151
    Height = 16
    Caption = 'CADASTRO DE TANQUES'
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
    Width = 393
    Height = 2
    Pen.Color = 529079
    Pen.Style = psInsideFrame
  end
  object Label2: TLabel
    Left = 16
    Top = 49
    Width = 12
    Height = 14
    Cursor = crHandPoint
    Caption = 'ID'
  end
  object Label3: TLabel
    Left = 16
    Top = 95
    Width = 131
    Height = 14
    Cursor = crHandPoint
    Caption = 'TIPO DE COMBUSTIV'#201'L'
  end
  inline FFrame_Cadastro1: TFFrame_Cadastro
    Left = 0
    Top = 337
    Width = 434
    Height = 82
    TabOrder = 2
    ExplicitTop = 337
    ExplicitWidth = 434
    ExplicitHeight = 82
  end
  inline FFrame_Cadastro2: TFFrame_Cadastro
    Left = 0
    Top = 147
    Width = 434
    Height = 61
    Align = alBottom
    TabOrder = 3
    ExplicitTop = 147
    ExplicitWidth = 434
    inherited Panel1: TPanel
      inherited BtnSalvar: TSpeedButton
        OnClick = FFrame_Cadastro2BtnSalvarClick
      end
    end
    inherited Panel2: TPanel
      inherited BtnSair: TSpeedButton
        OnClick = FFrame_Cadastro2BtnSairClick
      end
    end
  end
  object Panel1: TPanel
    Left = 16
    Top = 63
    Width = 57
    Height = 24
    BevelOuter = bvNone
    Enabled = False
    TabOrder = 0
    object edId: TEdit
      Left = 0
      Top = 1
      Width = 57
      Height = 22
      Color = clGray
      TabOrder = 0
    end
  end
  object cbTipo: TComboBox
    Left = 16
    Top = 111
    Width = 145
    Height = 22
    Style = csOwnerDrawFixed
    TabOrder = 1
    Items.Strings = (
      'Gasolina'
      #211'leo Diesel')
  end
end
