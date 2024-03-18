object FCadTanques: TFCadTanques
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Cadastro de Tanques'
  ClientHeight = 442
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
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
      Align = alClient
      ExplicitWidth = 624
      inherited Panel2: TPanel
        ExplicitHeight = 50
        inherited btExcluir: TSpeedButton
          Visible = False
          ExplicitHeight = 50
        end
        inherited btAlterar: TSpeedButton
          Visible = False
        end
        inherited btIncluir: TSpeedButton
          OnClick = FFrame_Gerenciador1btIncluirClick
          ExplicitHeight = 50
        end
        inherited Image1: TImage
          ExplicitHeight = 50
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
          ExplicitHeight = 50
        end
      end
    end
  end
  object dbTaques: TDBGrid
    Left = 0
    Top = 50
    Width = 628
    Height = 392
    Cursor = crHandPoint
    Align = alClient
    DataSource = dsConTanque
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
    OnDrawColumnCell = dbTaquesDrawColumnCell
    Columns = <
      item
        Expanded = False
        FieldName = 'ID'
        Title.Alignment = taRightJustify
        Title.Caption = 'Id'
        Width = 38
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CalcTipo'
        Title.Caption = 'Tipo'
        Width = 157
        Visible = True
      end>
  end
  object dspConTanque: TDataSetProvider
    DataSet = Dm.Q_Tanques
    Left = 312
    Top = 8
  end
  object cdsConTanque: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspConTanque'
    OnCalcFields = cdsConTanqueCalcFields
    Left = 344
    Top = 8
    object cdsConTanqueID: TIntegerField
      FieldName = 'ID'
    end
    object cdsConTanqueTIPO: TIntegerField
      FieldName = 'TIPO'
      Required = True
    end
    object cdsConTanqueCalcTipo: TStringField
      FieldKind = fkCalculated
      FieldName = 'CalcTipo'
      Size = 18
      Calculated = True
    end
  end
  object dsConTanque: TDataSource
    AutoEdit = False
    DataSet = cdsConTanque
    Left = 376
    Top = 8
  end
end
