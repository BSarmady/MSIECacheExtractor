object frmMain: TfrmMain
  Left = 192
  Top = 114
  ActiveControl = BOpen
  Caption = 'MSIE4.0 Cach Explorer'
  ClientHeight = 173
  ClientWidth = 379
  Color = clBtnFace
  Constraints.MinHeight = 194
  Constraints.MinWidth = 361
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = Menu
  Visible = True
  OnCreate = FormCreate
  DesignSize = (
    379
    173)
  TextHeight = 15
  object Bevel1: TBevel
    Left = 0
    Top = 0
    Width = 137
    Height = 153
    Align = alLeft
    Shape = bsFrame
    Style = bsRaised
    ExplicitHeight = 129
  end
  object Bevel2: TBevel
    Left = 137
    Top = 0
    Width = 242
    Height = 153
    Align = alClient
    Shape = bsFrame
    Style = bsRaised
    ExplicitLeft = 136
    ExplicitWidth = 217
    ExplicitHeight = 129
  end
  object L3: TLabel
    Left = 144
    Top = 32
    Width = 49
    Height = 17
    AutoSize = False
    Caption = 'Hash:'
    Layout = tlCenter
  end
  object L5: TLabel
    Left = 144
    Top = 80
    Width = 49
    Height = 17
    AutoSize = False
    Caption = 'Redirect:'
    Layout = tlCenter
  end
  object L4: TLabel
    Left = 144
    Top = 56
    Width = 49
    Height = 17
    AutoSize = False
    Caption = 'Url:'
    Layout = tlCenter
  end
  object L2: TLabel
    Left = 144
    Top = 8
    Width = 81
    Height = 17
    AutoSize = False
    Caption = 'Process Status:'
    Layout = tlCenter
  end
  object L1: TLabel
    Left = 8
    Top = 8
    Width = 81
    Height = 17
    AutoSize = False
    Caption = 'Commands:'
    Layout = tlCenter
  end
  object BStart: TBitBtn
    Left = 8
    Top = 96
    Width = 113
    Height = 25
    Action = AcStart
    Caption = 'S&tart'
    ImageIndex = 2
    Glyph.Data = {
      42020000424D4202000000000000420000002800000010000000100000000100
      1000030000000002000000000000000000000000000000000000007C0000E003
      00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C0000000000001F7C1F7C1F7C1F7C1F7C1F7C1F7C00001F7C
      1F7C1F7C1F7C1F7C003C007C007C003C1F7C1F7C1F7C1F7C1F7C003C007C0000
      1F7C1F7C1F7C1F7C003C003C007C007C000000001F7C1F7C0000007C007C0000
      1F7C1F7C1F7C1F7C00000000003C007C003C003C00000000003C007C003C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C00000000007C007C007C007C007C00001F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C003C007C007C007C003C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C003C007C003C000000001F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C003CFF7F003C007C007C007C007C003C
      00001F7C1F7C1F7C1F7C1F7C1F7C1F7C0000007C007C007C003C003C007C003C
      00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000007C000000000000003C0000
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000003C00000000FF7F00001F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C003C007C007C00001F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000007C007CFF7F00001F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000007C007C007C00001F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000000000001F7C1F7C1F7C
      1F7C1F7C1F7C}
    Margin = 4
    TabOrder = 2
  end
  object BOpen: TBitBtn
    Left = 8
    Top = 32
    Width = 113
    Height = 25
    Action = AcOpen
    Caption = '&Open Cach'
    ImageIndex = 0
    Glyph.Data = {
      42020000424D4202000000000000420000002800000010000000100000000100
      1000030000000002000000000000000000000000000000000000007C0000E003
      00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C000000000000000000000000000000000000000000000000
      000000001F7CEF3DE03DE03DE03DE03DE03DE03DE03DE03DE03DE03DE03DE03D
      E03D00001F7CEF3DFF7FE07F00000000000000000000000000000000F75EE07F
      E03D00001F7CEF3DFF7FF75EEF3DFF7FE07FFF7FFF7FE07FFF7F0000E07FF75E
      E03D00001F7CEF3DFF7FE07FEF3DFF7FF75E0F000F00F75EFF7F0000F75EE07F
      E03D00001F7CEF3DFF7FF75EEF3DFF7FEF011F001F000F00FF7F0000E07FF75E
      E03D00001F7CEF3DFF7FE07FEF3DE07FEF01F75EE0010F00E07F0000F75EE07F
      E03D00001F7CEF3DFF7FF75EEF3DFF7FF75EEF01EF01F75EFF7F0000E07FF75E
      E03D00001F7CEF3DFF7FE07FEF3DFF7FE07FFF7FFF7FE07FFF7F0000F75EE07F
      E03D00001F7CEF3DFF7FFF7FEF3DEF3DEF3DEF3DEF3DEF3DEF3D0000FF7FFF7F
      E03D00001F7CEF3DF75EE07FF75EE07FF75EE07FF75EEF3DEF3DEF3DEF3DEF3D
      EF3D1F7C1F7C1F7CEF3DF75EE07FF75EE07FF75EEF3D1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7CEF3DEF3DEF3DEF3DEF3D1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C}
    Margin = 4
    TabOrder = 0
  end
  object Animate: TAnimate
    Left = 9
    Top = 98
    Width = 23
    Height = 21
    AutoSize = False
    StopFrame = 14
    Visible = False
  end
  object ProgressBar: TProgressBar
    Left = 144
    Top = 104
    Width = 217
    Height = 17
    Hint = 'Progress Status'
    Anchors = [akLeft, akTop, akRight]
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    ExplicitWidth = 213
  end
  object LUrl: TStaticText
    Left = 200
    Top = 56
    Width = 161
    Height = 17
    Hint = 'URL Count'
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    BorderStyle = sbsSunken
    Caption = '0'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    ExplicitWidth = 157
  end
  object LRedr: TStaticText
    Left = 200
    Top = 80
    Width = 161
    Height = 17
    Hint = 'REDR Count'
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    BorderStyle = sbsSunken
    Caption = '0'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    ExplicitWidth = 157
  end
  object LHash: TStaticText
    Left = 200
    Top = 32
    Width = 161
    Height = 17
    Hint = 'HASH Tables Count'
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    BorderStyle = sbsSunken
    Caption = '0'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    ExplicitWidth = 157
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 153
    Width = 379
    Height = 20
    AutoHint = True
    Panels = <
      item
        Text = 'First show the path to MSIE4 cash'
        Width = 303
      end
      item
        Alignment = taRightJustify
        Text = '0000000'
        Width = 50
      end>
    SizeGrip = False
    ExplicitTop = 152
    ExplicitWidth = 375
  end
  object BSave: TBitBtn
    Left = 8
    Top = 64
    Width = 113
    Height = 25
    Action = AcSave
    Caption = 'HTTP &Save Root'
    ImageIndex = 1
    Glyph.Data = {
      42020000424D4202000000000000420000002800000010000000100000000100
      1000030000000002000000000000000000000000000000000000007C0000E003
      00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7CF75E00000000000000000000000000000000000000000000
      000000001F7C1F7C00001F001F00000000000000000000000000F75EF75E0000
      1F0000001F7C1F7C00001F001F00000000000000000000000000F75EF75E0000
      1F0000001F7C1F7C00001F001F00000000000000000000000000F75EF75E0000
      1F0000001F7C1F7C00001F001F00000000000000000000000000000000000000
      1F0000001F7C1F7C00001F001F001F001F001F001F001F001F001F001F001F00
      1F0000001F7C1F7C00001F001F00000000000000000000000000000000001F00
      1F0000001F7C1F7C00001F000000F75EF75EF75EF75EF75EF75EF75EF75E0000
      1F0000001F7C1F7C00001F000000F75EF75EF75EF75EF75EF75EF75EF75E0000
      1F0000001F7C1F7C00001F000000F75EF75EF75EF75EF75EF75EF75EF75E0000
      1F0000001F7C1F7C00001F000000F75EF75EF75EF75EF75EF75EF75EF75E0000
      1F0000001F7C1F7C00001F000000F75EF75EF75EF75EF75EF75EF75EF75E0000
      000000001F7C1F7C00001F000000F75EF75EF75EF75EF75EF75EF75EF75E0000
      F75E00001F7C1F7C000000000000000000000000000000000000000000000000
      000000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C}
    Margin = 4
    TabOrder = 1
  end
  object Menu: TMainMenu
    Images = ImgList
    Left = 336
    Top = 16
    object MFile: TMenuItem
      Caption = '&File'
      object MOpen: TMenuItem
        Action = AcOpen
      end
      object MSave: TMenuItem
        Action = AcSave
      end
      object MStart: TMenuItem
        Action = AcStart
      end
      object ML1: TMenuItem
        Caption = '-'
      end
      object MExit: TMenuItem
        Action = AcExit
      end
    end
    object MHelp: TMenuItem
      Caption = '&Help'
      object MIndex: TMenuItem
        Caption = 'I&ndex'
        Enabled = False
        ImageIndex = 4
      end
      object ML2: TMenuItem
        Caption = '-'
      end
      object MAbout: TMenuItem
        Caption = '&About'
        ImageIndex = 5
        OnClick = MAboutClick
      end
    end
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'dat'
    FileName = 'index.dat'
    Filter = 'Internet Explorer 4 index file(*.dat)|*.dat'
    Options = [ofReadOnly, ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 304
    Top = 16
  end
  object ActionList: TActionList
    Images = ImgList
    Left = 272
    Top = 16
    object AcOpen: TAction
      Caption = '&Open Cach'
      Hint = 'Show me where can I find MSIE4 cach'
      ImageIndex = 0
      OnExecute = AcOpenExecute
    end
    object AcSave: TAction
      Caption = 'HTTP &Save Root'
      Enabled = False
      Hint = 'Show me where can I use as HTTP root'
      ImageIndex = 1
      OnExecute = AcSaveExecute
    end
    object AcStart: TAction
      Caption = 'S&tart'
      Enabled = False
      Hint = 'Now I'#39'm Ready to go, Press to start!'
      ImageIndex = 2
      OnExecute = AcStartExecute
    end
    object AcExit: TAction
      Caption = 'E&xit'
      Hint = 'Now I'#39'm Killing myself'
      ImageIndex = 3
      OnExecute = AcExitExecute
    end
    object AcStop: TAction
      Caption = 'S&top'
      Hint = 'Halt!... Stop Going!'
      ImageIndex = 2
      OnExecute = AcStopExecute
    end
  end
  object ImgList: TImageList
    Left = 240
    Top = 16
    Bitmap = {
      494C010106000A00040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007F7F00007F7F00007F7F000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007F007F007F007F007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007F7F00007F7F00007F7F000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007F007F007F007F00FFFFFF00FFFFFF00BFBFBF007F7F7F000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007F7F00007F7F00007F7F000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007F00
      7F007F007F00FFFFFF00FFFFFF000000000000000000BFBFBF00BFBFBF007F7F
      7F00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007F007F007F007F007F007F00FFFF
      FF00FFFFFF0000000000000000007F007F007F007F0000000000BFBFBF00BFBF
      BF007F7F7F000000000000000000000000000000000000000000000000000000
      000000000000000000007F7F00007F7F00007F7F000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007F007F007F007F00FFFFFF000000
      0000000000007F007F007F007F007F007F007F007F007F007F0000000000BFBF
      BF00BFBFBF007F7F7F0000000000000000000000000000000000000000000000
      000000000000000000007F7F00007F7F00007F7F000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007F007F0000000000000000007F00
      7F007F007F007F007F00007F7F0000FFFF007F007F007F007F007F007F000000
      0000BFBFBF00BFBFBF007F7F7F00000000000000000000000000000000000000
      000000000000000000007F7F00007F7F00007F7F00007F7F0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007F007F007F007F007F007F007F00
      7F007F007F007F007F007F007F00007F7F007F007F007F007F007F007F007F00
      7F0000000000BFBFBF0000000000000000000000000000000000000000000000
      00000000000000000000000000007F7F00007F7F00007F7F00007F7F00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007F007F00FFFFFF007F00
      7F007F007F007F007F007F007F007F007F0000FFFF0000FFFF007F007F007F00
      7F007F007F000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007F7F00007F7F00007F7F00007F7F
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007F007F00FFFF
      FF007F007F007F007F007F007F007F007F007F007F00007F7F0000FFFF0000FF
      FF007F007F007F007F0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007F7F00007F7F00007F7F
      00007F7F00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007F00
      7F00FFFFFF007F007F007F007F007F007F00007F7F007F007F0000FFFF0000FF
      FF007F007F007F007F007F007F00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007F7F00007F7F
      00007F7F00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007F007F00FFFFFF007F007F007F007F0000FFFF0000FFFF0000FFFF007F00
      7F007F007F007F007F00000000000000000000000000000000007F7F00007F7F
      00007F7F000000000000000000000000000000000000000000007F7F00007F7F
      00007F7F00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007F007F00FFFFFF007F007F007F007F007F007F007F007F007F00
      7F000000000000000000000000000000000000000000000000007F7F00007F7F
      00007F7F00007F7F00000000000000000000000000007F7F00007F7F00007F7F
      00007F7F00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007F007F00FFFFFF007F007F007F007F00000000000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      00007F7F00007F7F00007F7F00007F7F00007F7F00007F7F00007F7F00007F7F
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007F007F007F007F0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007F7F00007F7F00007F7F00007F7F00007F7F0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BFBFBF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      7F0000007F0000007F0000007F0000007F0000007F0000007F0000007F000000
      7F0000007F000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000000000000000000000000000000000000000000000000000BFBFBF00BFBF
      BF0000000000FF00000000000000000000000000000000007F000000FF000000
      FF0000007F00000000000000000000000000000000000000000000007F000000
      FF00000000000000000000000000000000000000000000000000000000000000
      7F0000007F0000007F0000007F0000007F0000007F0000007F0000007F000000
      7F0000007F000000000000000000000000007F7F7F00007F7F00007F7F00007F
      7F00007F7F00007F7F00007F7F00007F7F00007F7F00007F7F00007F7F00007F
      7F00007F7F00007F7F0000000000000000000000000000000000FF000000FF00
      0000000000000000000000000000000000000000000000000000BFBFBF00BFBF
      BF0000000000FF00000000000000000000000000000000007F0000007F000000
      FF000000FF0000000000000000000000000000000000000000000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      7F0000007F0000007F0000007F0000007F0000007F0000007F0000007F000000
      7F0000007F000000000000000000000000007F7F7F00FFFFFF0000FFFF000000
      000000000000000000000000000000000000000000000000000000000000BFBF
      BF0000FFFF00007F7F0000000000000000000000000000000000FF000000FF00
      0000000000000000000000000000000000000000000000000000BFBFBF00BFBF
      BF0000000000FF00000000000000000000000000000000000000000000000000
      7F000000FF0000007F0000007F00000000000000000000007F000000FF000000
      7F00000000000000000000000000000000000000000000000000000000000000
      7F0000007F0000007F0000007F0000007F0000007F0000007F0000007F000000
      7F0000007F000000000000000000000000007F7F7F00FFFFFF00BFBFBF007F7F
      7F00FFFFFF0000FFFF00FFFFFF00FFFFFF0000FFFF00FFFFFF000000000000FF
      FF00BFBFBF00007F7F0000000000000000000000000000000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF00000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      7F000000000000007F0000007F0000007F0000007F0000007F0000007F000000
      7F0000007F000000000000000000000000007F7F7F00FFFFFF0000FFFF007F7F
      7F00FFFFFF00BFBFBF007F0000007F000000BFBFBF00FFFFFF0000000000BFBF
      BF0000FFFF00007F7F0000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF00000000000000000000000000000000000000000000000000
      00000000000000007F000000FF000000FF000000FF0000007F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      7F00000000000000000000007F0000007F0000007F0000007F0000007F000000
      7F0000007F000000000000000000000000007F7F7F00FFFFFF00BFBFBF007F7F
      7F00FFFFFF007F7F0000FF000000FF0000007F000000FFFFFF000000000000FF
      FF00BFBFBF00007F7F0000000000000000000000000000000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000000FF00000000000000000000000000000000000000000000000000
      00000000000000007F000000FF0000007F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      7F0000007F0000007F0000007F0000007F0000007F0000007F0000007F000000
      7F0000007F000000000000000000000000007F7F7F00FFFFFF0000FFFF007F7F
      7F0000FFFF007F7F0000BFBFBF00007F00007F00000000FFFF0000000000BFBF
      BF0000FFFF00007F7F0000000000000000000000000000000000FF0000000000
      0000BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
      BF0000000000FF00000000000000000000000000000000000000000000000000
      00000000000000007F00FFFFFF0000007F000000FF000000FF000000FF000000
      FF0000007F000000000000000000000000000000000000000000000000000000
      7F0000007F0000007F0000007F0000007F0000007F0000007F0000007F000000
      7F0000007F000000000000000000000000007F7F7F00FFFFFF00BFBFBF007F7F
      7F00FFFFFF00BFBFBF007F7F00007F7F0000BFBFBF00FFFFFF000000000000FF
      FF00BFBFBF00007F7F0000000000000000000000000000000000FF0000000000
      0000BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
      BF0000000000FF00000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF0000007F0000007F000000
      FF0000007F000000000000000000000000000000000000000000000000000000
      7F00000000000000000000000000000000000000000000000000000000000000
      000000007F000000000000000000000000007F7F7F00FFFFFF0000FFFF007F7F
      7F00FFFFFF0000FFFF00FFFFFF00FFFFFF0000FFFF00FFFFFF0000000000BFBF
      BF0000FFFF00007F7F0000000000000000000000000000000000FF0000000000
      0000BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
      BF0000000000FF00000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      7F00000000000000000000000000000000000000000000000000000000000000
      7F0000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      000000007F000000000000000000000000007F7F7F00FFFFFF00FFFFFF007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F0000000000FFFF
      FF00FFFFFF00007F7F0000000000000000000000000000000000FF0000000000
      0000BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
      BF0000000000FF00000000000000000000000000000000000000000000000000
      000000000000000000000000000000007F000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      7F0000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      000000007F000000000000000000000000007F7F7F00BFBFBF0000FFFF00BFBF
      BF0000FFFF00BFBFBF0000FFFF00BFBFBF007F7F7F007F7F7F007F7F7F007F7F
      7F007F7F7F007F7F7F0000000000000000000000000000000000FF0000000000
      0000BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
      BF00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000007F000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      7F0000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      000000007F00000000000000000000000000000000007F7F7F00BFBFBF0000FF
      FF00BFBFBF0000FFFF00BFBFBF007F7F7F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF0000000000
      0000BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
      BF0000000000BFBFBF0000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      7F00000000000000000000000000000000000000000000000000000000000000
      000000007F0000000000000000000000000000000000000000007F7F7F007F7F
      7F007F7F7F007F7F7F007F7F7F00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      7F0000007F0000007F0000007F0000007F0000007F0000007F0000007F000000
      7F0000007F000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF00FFFFFE3F00000000FE3FFC3F00000000
      F81FFC3F00000000E00FFC7F000000008007FE3F000000000003FC3F00000000
      0001FC1F000000000000FC0F000000000001FE07000000008001FF0300000000
      C001FF8300000000E000E3C300000000F000C1C300000000F803C00700000000
      FC0FE00F00000000FE3FF83F00000000FFFFFFFFFFFFC003FFFF80018FEFC003
      8001800187C7C003000180018187C00300018001800FC00300018001E01FC003
      00018001F83FC00300018001F83FC00300018001F803C00300018001F803C003
      00018001FC07C00300018001FC0FC00300038001FE1FC00380FF8001FC1FC003
      C1FF8001FC1F8001FFFFFFFFFE3F800100000000000000000000000000000000
      000000000000}
  end
end
