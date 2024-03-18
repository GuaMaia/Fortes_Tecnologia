object FCadBombas: TFCadBombas
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Cadastro de Bombas'
  ClientHeight = 442
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  TextHeight = 15
  inline FFrame_Gerenciador1: TFFrame_Gerenciador
    Left = 0
    Top = 0
    Width = 628
    Height = 50
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 624
    inherited Panel1: TPanel
      Width = 628
      ExplicitWidth = 624
      inherited Panel2: TPanel
        ExplicitHeight = 50
        inherited btExcluir: TSpeedButton
          Visible = False
        end
        inherited btAlterar: TSpeedButton
          Visible = False
        end
        inherited btIncluir: TSpeedButton
          OnClick = FFrame_Gerenciador1btIncluirClick
        end
      end
      inherited pnlNome: TPanel
        ExplicitHeight = 50
      end
      inherited Panel4: TPanel
        Left = 571
        ExplicitLeft = 567
        ExplicitHeight = 50
        inherited btSair: TSpeedButton
          OnClick = FFrame_Gerenciador1btSairClick
        end
      end
    end
  end
  object dbBombas: TDBGrid
    Left = 0
    Top = 50
    Width = 628
    Height = 392
    Align = alClient
    DataSource = dsConBombas
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnDrawColumnCell = dbBombasDrawColumnCell
    Columns = <
      item
        Expanded = False
        FieldName = 'ID'
        Title.Alignment = taRightJustify
        Title.Caption = 'Id'
        Width = 42
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NUM_BOMBA'
        Title.Alignment = taRightJustify
        Title.Caption = 'N'#176' Bomba'
        Width = 81
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CALC_BOMBA'
        Title.Caption = 'Tipo de Combust'#237'vel'
        Width = 170
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TANQUE_ID'
        Visible = False
      end>
  end
  object dsConBombas: TDataSource
    AutoEdit = False
    DataSet = cdsConBombas
    Left = 376
    Top = 8
  end
  object dspConBombas: TDataSetProvider
    DataSet = Dm.Q_Bombas
    Left = 312
    Top = 8
  end
  object cdsConBombas: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspConBombas'
    OnCalcFields = cdsConBombasCalcFields
    Left = 344
    Top = 8
    object cdsConBombasID: TIntegerField
      FieldName = 'ID'
    end
    object cdsConBombasTANQUE_ID: TIntegerField
      FieldName = 'TANQUE_ID'
    end
    object cdsConBombasNUM_BOMBA: TIntegerField
      FieldName = 'NUM_BOMBA'
    end
    object cdsConBombasCALC_BOMBA: TStringField
      FieldKind = fkCalculated
      FieldName = 'CALC_BOMBA'
      Size = 18
      Calculated = True
    end
  end
end
