object FrmPrincipal: TFrmPrincipal
  Left = 0
  Top = 0
  ActiveControl = btnDownload
  Caption = 'Delphi Downloader'
  ClientHeight = 171
  ClientWidth = 631
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 173
    Height = 16
    Caption = 'Informe o link para download:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object btnDownload: TButton
    Left = 480
    Top = 8
    Width = 150
    Height = 36
    Caption = 'Baixar'
    TabOrder = 0
    OnClick = btnDownloadClick
  end
  object btnExibirMensagem: TButton
    Left = 480
    Top = 88
    Width = 150
    Height = 36
    Caption = 'ExibirMensagem'
    TabOrder = 1
    OnClick = btnExibirMensagemClick
  end
  object btnPararDownload: TButton
    Left = 480
    Top = 48
    Width = 150
    Height = 36
    Caption = 'Parar dowload'
    TabOrder = 2
    OnClick = btnPararDownloadClick
  end
  object btnHistorico: TButton
    Left = 480
    Top = 128
    Width = 150
    Height = 36
    Caption = 'Exibir historico'
    TabOrder = 3
    OnClick = btnHistoricoClick
  end
  object ProgressBar1: TProgressBar
    Left = 8
    Top = 130
    Width = 462
    Height = 33
    TabOrder = 4
  end
  object memoURL: TMemo
    Left = 8
    Top = 8
    Width = 462
    Height = 97
    HelpType = htKeyword
    MaxLength = 600
    ScrollBars = ssVertical
    TabOrder = 5
  end
end
