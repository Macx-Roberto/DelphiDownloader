object FrmLog: TFrmLog
  Left = 0
  Top = 0
  Caption = 'Log de dowloads'
  ClientHeight = 409
  ClientWidth = 822
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GridLog: TDBGrid
    Left = 0
    Top = 0
    Width = 822
    Height = 409
    Align = alClient
    DataSource = dsLog
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'CODIGO'
        Title.Caption = 'Id'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'url'
        Title.Caption = 'URL'
        Width = 600
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATAINICIO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATAFIM'
        Visible = True
      end>
  end
  object dsLog: TDataSource
    Left = 408
    Top = 80
  end
end
