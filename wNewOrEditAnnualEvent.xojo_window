#tag DesktopWindow
Begin DesktopWindow wNewOrEditAnnualEvent
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF
   Composite       =   False
   DefaultLocation =   2
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   True
   HasFullScreenButton=   False
   HasMaximizeButton=   False
   HasMinimizeButton=   False
   HasTitleBar     =   True
   Height          =   451
   ImplicitInstance=   False
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   ""
   MenuBarVisible  =   False
   MinimumHeight   =   64
   MinimumWidth    =   64
   Resizeable      =   False
   Title           =   "New annual event definition"
   Type            =   1
   Visible         =   True
   Width           =   658
   BeginDesktopSegmentedButton DesktopSegmentedButton SegmentedButton1
      Enabled         =   True
      Height          =   24
      Index           =   -2147483648
      Left            =   10
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   0
      Segments        =   "Fixed day\n\nTrue\rEaster\n\nFalse\rOrthodox Easter\n\nFalse\rWeekDay Occurence\n\nFalse\rHebraic calendar\n\nFalse"
      SelectionStyle  =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   False
      Tooltip         =   ""
      Top             =   10
      Transparent     =   False
      Visible         =   True
      Width           =   638
   End
   Begin DesktopLabel Label14
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   10
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "First year of the cycle"
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   331
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   113
   End
   Begin DesktopLabel Label15
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   225
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Cycle Duration (years)"
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   331
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   117
   End
   Begin DesktopTextField txtCycleDuration
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   22
      Hint            =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   345
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   0
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "1"
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   331
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   51
   End
   Begin DesktopTextField txtFirstYearOfTheCycle
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   22
      Hint            =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   127
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   0
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "1900"
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   331
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   51
   End
   Begin DesktopUpDownArrows UpDownArrows4
      Active          =   False
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowTabStop    =   True
      Enabled         =   True
      Height          =   23
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   398
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      PanelIndex      =   0
      Scope           =   0
      TabIndex        =   9
      TabPanelIndex   =   0
      Tooltip         =   ""
      Top             =   331
      Transparent     =   False
      Visible         =   True
      Width           =   14
      _mIndex         =   0
      _mInitialParent =   ""
      _mName          =   ""
      _mPanelIndex    =   0
   End
   Begin DesktopDateTimePicker dtStart
      Active          =   False
      AllowAutoDeactivate=   True
      AllowFocusRing  =   False
      AllowTabStop    =   True
      DisplayMode     =   1
      DisplaySeconds  =   False
      Enabled         =   True
      GraphicalDisplay=   True
      Height          =   22
      HourMode        =   0
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   10
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      PanelIndex      =   0
      Scope           =   0
      TabIndex        =   12
      TabPanelIndex   =   0
      TodayButtonCaption=   ""
      Tooltip         =   ""
      Top             =   385
      Transparent     =   False
      Visible         =   True
      Width           =   113
      _mIndex         =   0
      _mInitialParent =   ""
      _mName          =   ""
      _mPanelIndex    =   0
   End
   Begin DesktopLabel Label16
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   17
      Index           =   -2147483648
      Italic          =   False
      Left            =   10
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Start of validity"
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   363
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   113
   End
   Begin DesktopDateTimePicker dtEnd
      Active          =   False
      AllowAutoDeactivate=   True
      AllowFocusRing  =   False
      AllowTabStop    =   True
      DisplayMode     =   1
      DisplaySeconds  =   False
      Enabled         =   True
      GraphicalDisplay=   True
      Height          =   22
      HourMode        =   0
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   135
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      PanelIndex      =   0
      Scope           =   0
      TabIndex        =   13
      TabPanelIndex   =   0
      TodayButtonCaption=   ""
      Tooltip         =   ""
      Top             =   385
      Transparent     =   False
      Visible         =   True
      Width           =   113
      _mIndex         =   0
      _mInitialParent =   ""
      _mName          =   ""
      _mPanelIndex    =   0
   End
   Begin DesktopLabel Label17
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   17
      Index           =   -2147483648
      Italic          =   False
      Left            =   135
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "End of validity"
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   363
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   113
   End
   Begin DesktopCheckBox chkDayOff
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Day off"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   10
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   299
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      VisualState     =   1
      Width           =   100
   End
   Begin DesktopLabel Label5
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   17
      Index           =   -2147483648
      Italic          =   False
      Left            =   10
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Caption"
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   46
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   43
   End
   Begin DesktopTextField txtCaption
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   22
      Hint            =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   10
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "New day"
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   66
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   638
   End
   Begin DesktopPagePanel PagePanel1
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   186
      Index           =   -2147483648
      Left            =   10
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   5
      Panels          =   ""
      Scope           =   0
      SelectedPanelIndex=   0
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   False
      Tooltip         =   ""
      Top             =   100
      Transparent     =   False
      Value           =   4
      Visible         =   True
      Width           =   638
      Begin DesktopLabel Label1
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   10
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Month"
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   100
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   43
         Begin DesktopLabel Label9
            AllowAutoDeactivate=   True
            Bold            =   False
            Enabled         =   True
            FontName        =   "System"
            FontSize        =   0.0
            FontUnit        =   0
            Height          =   20
            Index           =   -2147483648
            InitialParent   =   "Label1"
            Italic          =   False
            Left            =   10
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Multiline       =   False
            Scope           =   0
            Selectable      =   False
            TabIndex        =   0
            TabPanelIndex   =   4
            TabStop         =   True
            Text            =   "Month"
            TextAlignment   =   0
            TextColor       =   &c000000
            Tooltip         =   ""
            Top             =   100
            Transparent     =   False
            Underline       =   False
            Visible         =   True
            Width           =   43
         End
      End
      Begin DesktopPopupMenu popFDMonth
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         InitialValue    =   ""
         Italic          =   False
         Left            =   10
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         SelectedRowIndex=   -1
         TabIndex        =   2
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   121
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   165
      End
      Begin DesktopPopupMenu popFDDay
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         InitialValue    =   ""
         Italic          =   False
         Left            =   190
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         SelectedRowIndex=   -1
         TabIndex        =   3
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   121
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   165
      End
      Begin DesktopLabel Label3
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   10
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   7
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Shift to the                            day of the week"
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   215
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   61
      End
      Begin DesktopPopupMenu popFDWeekDay
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         InitialValue    =   ""
         Italic          =   False
         Left            =   154
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         SelectedRowIndex=   -1
         TabIndex        =   9
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   214
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   165
      End
      Begin DesktopLabel Label4
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   329
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   10
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "or adding days"
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   214
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   85
      End
      Begin DesktopTextField txtFDAdding
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   413
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   0
         TabIndex        =   11
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "0"
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   214
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   51
      End
      Begin DesktopUpDownArrows UpDownArrows1
         Active          =   False
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowTabStop    =   True
         Enabled         =   True
         Height          =   23
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Left            =   469
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         PanelIndex      =   0
         Scope           =   0
         TabIndex        =   12
         TabPanelIndex   =   1
         Tooltip         =   ""
         Top             =   214
         Transparent     =   False
         Visible         =   True
         Width           =   14
         _mIndex         =   0
         _mInitialParent =   ""
         _mName          =   ""
         _mPanelIndex    =   0
      End
      Begin DesktopLabel Label6
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   12
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Difference in days with Easter"
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   100
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   158
      End
      Begin DesktopTextField txtEDDiff
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   174
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   0
         TabIndex        =   1
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "0"
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   100
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   51
      End
      Begin DesktopButton ButtonEaster
         AllowAutoDeactivate=   True
         Bold            =   True
         Cancel          =   False
         Caption         =   "Easter"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   147
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   18
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   261
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   125
      End
      Begin DesktopButton ButtonEaster1
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Good Friday"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   147
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   12
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   197
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   125
      End
      Begin DesktopButton ButtonEaster2
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Whit Monday"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   284
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   13
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   197
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   125
      End
      Begin DesktopButton ButtonEaster3
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Ascension Thursday"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   284
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   16
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   229
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   125
      End
      Begin DesktopButton ButtonEaster4
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Corpus Christi"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   421
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   6
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   132
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   125
      End
      Begin DesktopButton ButtonEaster5
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Sunday after Corpus Christi"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   10.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   421
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   10
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   165
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   125
      End
      Begin DesktopButton ButtonEaster6
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Trinity Sunday"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   284
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   19
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   261
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   125
      End
      Begin DesktopButton ButtonEaster7
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Mardi gras"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   10
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   7
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   132
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   125
      End
      Begin DesktopButton ButtonEaster8
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Palm Sunday"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   10
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   4
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   261
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   125
      End
      Begin DesktopButton ButtonEaster9
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Ash Wednesday"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   12
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   11
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   166
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   125
      End
      Begin DesktopButton ButtonEaster16
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Mothering Sunday"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   12
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   14
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   197
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   125
      End
      Begin DesktopButton ButtonEaster18
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Maundy Thursday"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   147
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   8
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   165
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   125
      End
      Begin DesktopButton ButtonEaster19
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Holy Saturday"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   147
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   15
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   229
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   125
      End
      Begin DesktopButton ButtonEaster20
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Second Sunday of Easter"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   10.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   284
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   5
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   132
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   125
      End
      Begin DesktopButton ButtonEaster21
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Pentecost"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   284
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   9
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   165
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   125
      End
      Begin DesktopButton ButtonEaster17
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Passion Sunday"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   10
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   17
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   231
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   125
      End
      Begin DesktopLabel Label10
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   187
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   4
         TabStop         =   True
         Text            =   "Day of week"
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   100
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   73
      End
      Begin DesktopPopupMenu popWDWeekDay
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         InitialValue    =   ""
         Italic          =   False
         Left            =   187
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         SelectedRowIndex=   -1
         TabIndex        =   3
         TabPanelIndex   =   4
         TabStop         =   True
         Tooltip         =   ""
         Top             =   121
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   165
      End
      Begin DesktopPopupMenu popWDRank
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         InitialValue    =   ""
         Italic          =   False
         Left            =   364
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         SelectedRowIndex=   -1
         TabIndex        =   4
         TabPanelIndex   =   4
         TabStop         =   True
         Tooltip         =   ""
         Top             =   120
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   165
      End
      Begin DesktopLabel Label12
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   10
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   5
         TabPanelIndex   =   4
         TabStop         =   True
         Text            =   "Day offset"
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   169
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   58
      End
      Begin DesktopTextField txtWDAdding
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   70
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   0
         TabIndex        =   9
         TabPanelIndex   =   4
         TabStop         =   True
         Text            =   "0"
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   169
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   51
      End
      Begin DesktopUpDownArrows UpDownArrows3
         Active          =   False
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowTabStop    =   True
         Enabled         =   True
         Height          =   23
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Left            =   123
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         PanelIndex      =   0
         Scope           =   0
         TabIndex        =   10
         TabPanelIndex   =   4
         Tooltip         =   ""
         Top             =   168
         Transparent     =   False
         Visible         =   True
         Width           =   14
         _mIndex         =   0
         _mInitialParent =   ""
         _mName          =   ""
         _mPanelIndex    =   0
      End
      Begin DesktopPopupMenu popFDShiftMode
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         InitialValue    =   ""
         Italic          =   False
         Left            =   75
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         SelectedRowIndex=   -1
         TabIndex        =   8
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   214
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   74
      End
      Begin DesktopLabel Label11
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   364
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   1
         TabPanelIndex   =   4
         TabStop         =   True
         Text            =   "Occurence"
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   100
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   67
      End
      Begin DesktopLabel Label2
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   190
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Day"
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   100
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   43
      End
      Begin DesktopCheckBox cbFDFridayIfSaturday
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Previous friday if saturday"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   167
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         TabIndex        =   5
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   166
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         VisualState     =   0
         Width           =   158
      End
      Begin DesktopCheckBox cbFDMondayIfSunday
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Next monday if sunday"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   10
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         TabIndex        =   4
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   166
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         VisualState     =   0
         Width           =   142
      End
      Begin DesktopLabel Label7
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   12
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   "Difference in days with Easter"
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   100
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   158
      End
      Begin DesktopTextField txtEDDiff1
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   174
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   0
         TabIndex        =   1
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   "0"
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   100
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   51
      End
      Begin DesktopPopupMenu popWDMonth
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         InitialValue    =   ""
         Italic          =   False
         Left            =   10
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         SelectedRowIndex=   -1
         TabIndex        =   2
         TabPanelIndex   =   4
         TabStop         =   True
         Tooltip         =   ""
         Top             =   120
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   165
      End
      Begin DesktopUpDownArrows UpDownArrows2
         Active          =   False
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowTabStop    =   True
         Enabled         =   True
         Height          =   23
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Left            =   230
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         PanelIndex      =   0
         Scope           =   0
         TabIndex        =   20
         TabPanelIndex   =   2
         Tooltip         =   ""
         Top             =   100
         Transparent     =   False
         Visible         =   True
         Width           =   14
         _mIndex         =   0
         _mInitialParent =   ""
         _mName          =   ""
         _mPanelIndex    =   0
      End
      Begin DesktopUpDownArrows UpDownArrows5
         Active          =   False
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowTabStop    =   True
         Enabled         =   True
         Height          =   23
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Left            =   230
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         PanelIndex      =   0
         Scope           =   0
         TabIndex        =   2
         TabPanelIndex   =   3
         Tooltip         =   ""
         Top             =   100
         Transparent     =   False
         Visible         =   True
         Width           =   14
         _mIndex         =   0
         _mInitialParent =   ""
         _mName          =   ""
         _mPanelIndex    =   0
      End
      Begin DesktopCheckBox chkDFAlways
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Always"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   154
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         TabIndex        =   13
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   247
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         VisualState     =   0
         Width           =   329
      End
      Begin DesktopButton ButtonEaster23
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Great and Holy Friday"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   212
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   3
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   198
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   157
      End
      Begin DesktopButton ButtonEaster24
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Holy and Great Saturday"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   212
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   4
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   230
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   157
      End
      Begin DesktopButton ButtonEaster22
         AllowAutoDeactivate=   True
         Bold            =   True
         Cancel          =   False
         Caption         =   "Easter"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   212
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   5
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   262
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   157
      End
      Begin DesktopButton ButtonEaster25
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "All Saints Sunday"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   381
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   6
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   262
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   157
      End
      Begin DesktopButton ButtonEaster26
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Radonitsa (Monday)"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   381
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   7
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   132
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   157
      End
      Begin DesktopButton ButtonEaster27
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Radonitsa (Tuesday)"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   381
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   8
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   164
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   157
      End
      Begin DesktopButton ButtonEaster28
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Lazarus Saturday"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   43
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   9
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   262
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   157
      End
      Begin DesktopButton ButtonEaster29
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Saturday of Souls"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   43
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   10
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   198
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   157
      End
      Begin DesktopButton ButtonEaster30
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Triumph of Orthodoxy"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   43
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   11
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   230
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   157
      End
      Begin DesktopButton ButtonEaster31
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Triodon"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   43
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   12
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   164
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   157
      End
      Begin DesktopButton ButtonEaster32
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Pentecost"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   381
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   13
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   230
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   157
      End
      Begin DesktopButton ButtonEaster33
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Ascension of the Lord"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   381
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   14
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   198
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   157
      End
      Begin DesktopButton ButtonEaster34
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Palm Sunday"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   212
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   15
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   164
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   157
      End
      Begin DesktopLabel Label18
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   10
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   5
         TabStop         =   True
         Text            =   "Holiday"
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   100
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   47
      End
      Begin DesktopPopupMenu popHebraicHolidayType
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         InitialValue    =   ""
         Italic          =   False
         Left            =   10
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         SelectedRowIndex=   -1
         TabIndex        =   1
         TabPanelIndex   =   5
         TabStop         =   True
         Tooltip         =   ""
         Top             =   120
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   258
      End
      Begin DesktopLabel Label19
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   10
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   2
         TabPanelIndex   =   5
         TabStop         =   True
         Text            =   "Month"
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   154
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   43
      End
      Begin DesktopLabel Label20
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   10
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   3
         TabPanelIndex   =   5
         TabStop         =   True
         Text            =   "Month"
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   154
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   43
      End
      Begin DesktopPopupMenu popHMonth
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         InitialValue    =   ""
         Italic          =   False
         Left            =   10
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         SelectedRowIndex=   -1
         TabIndex        =   4
         TabPanelIndex   =   5
         TabStop         =   True
         Tooltip         =   ""
         Top             =   175
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   165
      End
      Begin DesktopLabel Label21
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   190
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   5
         TabPanelIndex   =   5
         TabStop         =   True
         Text            =   "Day"
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   154
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   43
      End
      Begin DesktopPopupMenu popHDay
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         InitialValue    =   ""
         Italic          =   False
         Left            =   190
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         SelectedRowIndex=   -1
         TabIndex        =   6
         TabPanelIndex   =   5
         TabStop         =   True
         Tooltip         =   ""
         Top             =   175
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   165
      End
      Begin DesktopLabel Label22
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   280
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   7
         TabPanelIndex   =   5
         TabStop         =   True
         Text            =   "Set caption to"
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   100
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   75
      End
      Begin DesktopButton btnHEnglish
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "English"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   280
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   8
         TabPanelIndex   =   5
         TabStop         =   True
         Tooltip         =   ""
         Top             =   121
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   60
      End
      Begin DesktopButton btnHEnglish1
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Spanish"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   342
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   9
         TabPanelIndex   =   5
         TabStop         =   True
         Tooltip         =   ""
         Top             =   121
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   60
      End
      Begin DesktopButton btnHEnglish2
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "French"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   404
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   10
         TabPanelIndex   =   5
         TabStop         =   True
         Tooltip         =   ""
         Top             =   121
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   60
      End
      Begin DesktopButton btnHEnglish3
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Dutch"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   466
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   11
         TabPanelIndex   =   5
         TabStop         =   True
         Tooltip         =   ""
         Top             =   121
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   60
      End
      Begin DesktopButton btnHEnglish4
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "German"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   527
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   12
         TabPanelIndex   =   5
         TabStop         =   True
         Tooltip         =   ""
         Top             =   121
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   60
      End
      Begin DesktopButton btnHEnglish5
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Hebrew"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   588
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   13
         TabPanelIndex   =   5
         TabStop         =   True
         Tooltip         =   ""
         Top             =   121
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   60
      End
   End
   Begin DesktopButton btnOK
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "&Add"
      Default         =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      Italic          =   False
      Left            =   476
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   0
      TabIndex        =   15
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   419
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin DesktopButton btnCancel
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   True
      Caption         =   "&Cancel"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      Italic          =   False
      Left            =   568
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   0
      TabIndex        =   16
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   419
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin DesktopButton btnCopy
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "&Copy code"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      Italic          =   False
      Left            =   10
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   0
      TabIndex        =   14
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   419
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   113
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Method, Flags = &h0
		Function Charge(d as AnnualEvent = Nil, ShowCopyCodeButton as Boolean = True) As AnnualEvent
		  If d <> Nil Then
		    Me.Title = "Edit annual event definition"
		    btnOK.Caption = "&OK"
		    LoadEvent(d)
		  end
		  
		  btnCopy.Visible = ShowCopyCodeButton
		  
		  dtStart.SelectedDate = New DateTime(1,1,1) 
		  dtEnd.SelectedDate = new DateTime(3999,12,31)
		  
		  Me.ShowModal
		  
		  Return AnnualEventReturned
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HebraicEnum(index as Integer) As String
		  Var s() as String
		  
		  s.add "RoshHashanah"
		  s.add "YomKippur"
		  s.add "SukkotFirstDay"
		  s.add "HoshanaRabbah"
		  s.add "SheminiAtzeret"
		  s.add "SimchatTorah_Diaspora"
		  s.add "SimchatTorah_Israel"
		  s.add "HanukkahFirstDay"
		  s.add "TuBishvat"
		  s.add "Purim"
		  s.add "PassoverFirstDay"
		  s.add "PassoverSeventhDay"
		  s.add "PassoverEighthDay_Diaspora"
		  s.add "YomHaShoah"
		  s.add "YomHaZikaron"
		  s.add "YomHaZikaron_ApplyCivilShift"
		  s.add "YomHaatzmaut"
		  s.add "YomHaatzmaut_ApplyCivilShift"
		  s.add "LagBaOmer"
		  s.add "Shavuot"
		  s.add "TzomGedaliah"
		  s.add "TzomGedaliah_ApplyShabbatShift"
		  s.add "AsaraBeTevet"
		  s.add "AsaraBeTevet_ApplyShabbatShift"
		  s.add "TaanitEsther"
		  s.add "TaanitEsther_ApplyShabbatShift"
		  s.add "ShivaAsarBeTammuz"
		  s.add "ShivaAsarBeTammuz_ApplyShabbatShift"
		  s.add "Unknown"
		  s.add "Custom"
		  
		  Return s(index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LoadEvent(d as AnnualEvent)
		  txtCaption.Text= d.Caption
		  chkDayOff.Value = d.DayOff
		  dtStart.SelectedDate = d.StartOfValidity
		  dtEnd.SelectedDate = d.EndOfValidity
		  txtFirstYearOfTheCycle.Text = d.CycleFirstYear.ToString
		  txtCycleDuration.Text = d.CycleYearDuration.ToString
		  
		  Select Case d
		    
		  Case IsA AnnualEventFixed 
		    
		    Var df As AnnualEventFixed = d.DefinitionObject
		    
		    popFDMonth.SelectedRowIndex = df.Month - 1
		    popFDDay.SelectedRowIndex = df.day - 1
		    cbFDMondayIfSunday.Value = df.MondayIfSunday
		    cbFDFridayIfSaturday.Value = df.FridayIfSaturday
		    
		    popFDWeekDay.SelectedRowIndex = df.DesiredWeekday
		    
		    if df.DesiredWeekday <> 0 then
		      If df.DesiredWeekdayDirection = AnnualEventFixed.WeekdayDirectionType.Before Then
		        popFDShiftMode.SelectedRowIndex = 0
		      ElseIf df.DesiredWeekdayDirection = AnnualEventFixed.WeekdayDirectionType.After then
		        popFDShiftMode.SelectedRowIndex = 1
		      end
		    end
		    
		    
		    chkDFAlways.Value = df.AlwaysMoveDesiredWeekday
		    txtFDAdding.Text = df.DayOffset.ToString(locale.raw)
		    
		  Case IsA AnnualEventEaster
		    
		    Var de As AnnualEventEaster = d.DefinitionObject
		    txtEDDiff.Text = de.DayOffset.ToString
		    
		    SegmentedButton1.SelectedSegmentIndex = 1
		    PagePanel1.SelectedPanelIndex = 1
		    
		  Case IsA AnnualEventOrthodoxEaster
		    
		    Var doe As AnnualEventOrthodoxEaster = d.DefinitionObject
		    txtEDDiff1.Text = doe.DayOffset.ToString
		    
		    SegmentedButton1.SelectedSegmentIndex = 2
		    PagePanel1.SelectedPanelIndex = 2
		    
		  Case IsA AnnualEventWeekDay
		    
		    Var wd As AnnualEventWeekDay = d.DefinitionObject
		    
		    popWDMonth.SelectedRowIndex =  wd.Month - 1
		    popWDWeekDay.SelectedRowIndex = wd.WeekDay - 1
		    popWDRank.SelectedRowIndex = wd.Occurrence - 1
		    
		    If wd.DayOffset <> 0 Then
		      txtWDAdding.Text = wd.DayOffset.ToString
		    End If
		    
		    SegmentedButton1.SelectedSegmentIndex = 3
		    PagePanel1.SelectedPanelIndex = 3
		    
		  end
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private AnnualEventReturned As AnnualEvent
	#tag EndProperty


#tag EndWindowCode

#tag Events SegmentedButton1
	#tag Event
		Sub Pressed(segmentIndex As Integer)
		  PagePanel1.SelectedPanelIndex = segmentIndex
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events txtCycleDuration
	#tag Event
		Function KeyDown(key As String) As Boolean
		  if key.Asc < 32 then Return false// Specials char 
		  if key.asc = 127 then Return false // backspace
		  
		  If key = "-" Then
		    If Me.Text.IndexOf("-") > 0 Then Return True
		    If Me.SelectionStart > 0 Then Return True
		    Return False
		  end
		  
		  If Not (key>="0" And key<="9") Then Return True
		  
		  // ok
		  Return False
		End Function
	#tag EndEvent
	#tag Event
		Sub FocusLost()
		  
		  #Pragma BreakOnExceptions False
		  Try
		    Me.Text = Me.Text.ToInteger.ToString
		  Catch
		    me.Text = "0"
		  End
		  #Pragma BreakOnExceptions True
		  
		  Select Case SegmentedButton1.SelectedSegmentIndex
		    
		  Case 0
		    
		    
		    
		  Case 1
		    
		    
		    
		  Case 2
		    
		    
		    
		  end
		End Sub
	#tag EndEvent
	#tag Event
		Sub TextChanged()
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events txtFirstYearOfTheCycle
	#tag Event
		Function KeyDown(key As String) As Boolean
		  if key.Asc < 32 then Return false// Specials char 
		  if key.asc = 127 then Return false // backspace
		  
		  If key = "-" Then
		    If Me.Text.IndexOf("-") > 0 Then Return True
		    If Me.SelectionStart > 0 Then Return True
		    Return False
		  end
		  
		  If Not (key>="0" And key<="9") Then Return True
		  
		  // ok
		  Return False
		End Function
	#tag EndEvent
	#tag Event
		Sub FocusLost()
		  
		  #Pragma BreakOnExceptions False
		  Try
		    Me.Text = Me.Text.ToInteger.ToString
		  Catch
		    me.Text = "0"
		  End
		  #Pragma BreakOnExceptions True
		  
		  if me.Text.ToInteger < 1 then me.text = "1"
		  
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events UpDownArrows4
	#tag Event
		Sub DownPressed()
		  Var v As Integer
		  
		  
		  #Pragma BreakOnExceptions False
		  Try
		    v= txtCycleDuration.Text.ToInteger
		  Catch
		    v = 0
		  End
		  #Pragma BreakOnExceptions True
		  
		  v = v - 1
		  
		  if txtCycleDuration.Text.ToInteger < 0 then txtCycleDuration.Text = "0"
		  
		  txtCycleDuration.Text = v.ToString
		  
		  
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub UpPressed()
		  Var v As Integer
		  
		  
		  #Pragma BreakOnExceptions False
		  Try
		    v= txtCycleDuration.Text.ToInteger
		  Catch
		    v = 0
		  End
		  #Pragma BreakOnExceptions True
		  
		  v = v + 1
		  
		  txtCycleDuration.Text = v.ToString
		  
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events dtStart
	#tag Event
		Sub Opening()
		  me.SelectedDate = new DateTime(1,1,1)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events dtEnd
	#tag Event
		Sub Opening()
		  me.SelectedDate = new DateTime(3999,12,31)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events popFDMonth
	#tag Event
		Sub Opening()
		  Var d As DateTime
		  For i As Integer = 1 To 12
		    d = New DateTime(2025, i, 1)
		    Me.AddRow d.ToString("MMMM", Locale.Current)
		  Next 
		  
		  me.SelectedRowIndex = 0
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events popFDDay
	#tag Event
		Sub Opening()
		  For i As Integer = 1 To 31
		    me.AddRow i.ToString
		  Next 
		  
		  me.SelectedRowIndex = 0
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events popFDWeekDay
	#tag Event
		Sub Opening()
		  Me.AddRow "0 - <Disabled>"
		  
		  Var d As New DateTime(2025, 8, 30)
		  For i As Integer = 1 To 7
		    d = d.AddInterval(0,0,1)
		    Me.AddRow d.DayOfWeek.ToString + " - " + d.ToString("EEEE", Locale.Current)
		  Next 
		  
		  
		  
		  me.SelectedRowIndex = 0
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events txtFDAdding
	#tag Event
		Function KeyDown(key As String) As Boolean
		  if key.Asc < 32 then Return false// Specials char 
		  if key.asc = 127 then Return false // backspace
		  
		  If key = "-" Then
		    If Me.Text.IndexOf("-") > 0 Then Return True
		    If Me.SelectionStart > 0 Then Return True
		    Return False
		  end
		  
		  If Not (key>="0" And key<="9") Then Return True
		  
		  // ok
		  Return False
		End Function
	#tag EndEvent
	#tag Event
		Sub FocusLost()
		  
		  #Pragma BreakOnExceptions False
		  Try
		    Me.Text = Me.Text.ToInteger.ToString
		  Catch
		    me.Text = "0"
		  End
		  #Pragma BreakOnExceptions True
		  
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events UpDownArrows1
	#tag Event
		Sub DownPressed()
		  Var v As Integer
		  
		  
		  #Pragma BreakOnExceptions False
		  Try
		    v= txtFDAdding.Text.ToInteger
		  Catch
		    v = 0
		  End
		  #Pragma BreakOnExceptions True
		  
		  v = v - 1
		  
		  txtFDAdding.Text = v.ToString
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub UpPressed()
		  Var v As Integer
		  
		  
		  #Pragma BreakOnExceptions False
		  Try
		    v= txtFDAdding.Text.ToInteger
		  Catch
		    v = 0
		  End
		  #Pragma BreakOnExceptions True
		  
		  v = v + 1
		  
		  txtFDAdding.Text = v.ToString
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events txtEDDiff
	#tag Event
		Function KeyDown(key As String) As Boolean
		  if key.Asc < 32 then Return false// Specials char 
		  if key.asc = 127 then Return false // backspace
		  
		  If key = "-" Then
		    If Me.Text.IndexOf("-") > 0 Then Return True
		    If Me.SelectionStart > 0 Then Return True
		    Return False
		  end
		  
		  If Not (key>="0" And key<="9") Then Return True
		  
		  // ok
		  Return False
		End Function
	#tag EndEvent
	#tag Event
		Sub FocusLost()
		  
		  #Pragma BreakOnExceptions False
		  Try
		    Me.Text = Me.Text.ToInteger.ToString
		  Catch
		    me.Text = "0"
		  End
		  #Pragma BreakOnExceptions True
		  
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonEaster
	#tag Event
		Sub Pressed()
		  txtCaption.Text = me.Caption
		  txtEDDiff.Text = "0"
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonEaster1
	#tag Event
		Sub Pressed()
		  txtCaption.Text = me.Caption
		  txtEDDiff.Text = "-2"
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonEaster2
	#tag Event
		Sub Pressed()
		  txtCaption.Text = me.Caption
		  txtEDDiff.Text = "50"
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonEaster3
	#tag Event
		Sub Pressed()
		  txtCaption.Text = me.Caption
		  txtEDDiff.Text = "40"
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonEaster4
	#tag Event
		Sub Pressed()
		  txtCaption.Text = Me.Caption
		  txtEDDiff.Text = "60"
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonEaster5
	#tag Event
		Sub Pressed()
		  txtCaption.Text = me.Caption
		  txtEDDiff.Text = "63"
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonEaster6
	#tag Event
		Sub Pressed()
		  txtCaption.Text = me.Caption
		  txtEDDiff.Text = "56"
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonEaster7
	#tag Event
		Sub Pressed()
		  txtCaption.Text = me.Caption
		  txtEDDiff.Text = AnnualEventEaster.MardiGras.ToString // or txtEDDiff.Text = "-47"
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonEaster8
	#tag Event
		Sub Pressed()
		  txtCaption.Text = me.Caption
		  txtEDDiff.Text = "-7"
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonEaster9
	#tag Event
		Sub Pressed()
		  txtCaption.Text = me.Caption
		  txtEDDiff.Text = AnnualEventEaster.AshWednesday.ToString // // or txtEDDiff.Text = "-46"
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonEaster16
	#tag Event
		Sub Pressed()
		  txtCaption.Text = me.Caption
		  txtEDDiff.Text = "-21" // Or txtEDDiff.Text = AnnualEventEaster.MotheringSunday.ToString
		  
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonEaster18
	#tag Event
		Sub Pressed()
		  txtCaption.Text = me.Caption
		  txtEDDiff.Text = "-3"
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonEaster19
	#tag Event
		Sub Pressed()
		  txtCaption.Text = me.Caption
		  txtEDDiff.Text = "-1"
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonEaster20
	#tag Event
		Sub Pressed()
		  txtCaption.Text = me.Caption
		  txtEDDiff.Text = "7"
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonEaster21
	#tag Event
		Sub Pressed()
		  txtCaption.Text = me.Caption
		  txtEDDiff.Text = "49"
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonEaster17
	#tag Event
		Sub Pressed()
		  txtCaption.Text = me.Caption
		  txtEDDiff.Text = "-14"
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events popWDWeekDay
	#tag Event
		Sub Opening()
		  Var d As New DateTime(2025, 8, 30)
		  For i As Integer = 1 To 7
		    d = d.AddInterval(0,0,1)
		    Me.AddRow d.DayOfWeek.ToString + " - " + d.ToString("EEEE", Locale.Current)
		  Next 
		  
		  
		  
		  me.SelectedRowIndex = 0
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events popWDRank
	#tag Event
		Sub Opening()
		  Me.AddRow "1st"
		  Me.AddRow "2nd"
		  Me.AddRow "3rd"
		  Me.AddRow "4th"
		  Me.AddRow "5th"
		  me.AddRow "Last"
		  
		  me.SelectedRowIndex = 0
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events txtWDAdding
	#tag Event
		Function KeyDown(key As String) As Boolean
		  if key.Asc < 32 then Return false// Specials char 
		  if key.asc = 127 then Return false // backspace
		  
		  If key = "-" Then
		    If Me.Text.IndexOf("-") > 0 Then Return True
		    If Me.SelectionStart > 0 Then Return True
		    Return False
		  end
		  
		  If Not (key>="0" And key<="9") Then Return True
		  
		  // ok
		  Return False
		End Function
	#tag EndEvent
	#tag Event
		Sub FocusLost()
		  
		  #Pragma BreakOnExceptions False
		  Try
		    Me.Text = Me.Text.ToInteger.ToString
		  Catch
		    me.Text = "0"
		  End
		  #Pragma BreakOnExceptions True
		  
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events UpDownArrows3
	#tag Event
		Sub DownPressed()
		  Var v As Integer
		  
		  
		  #Pragma BreakOnExceptions False
		  Try
		    v= txtWDAdding.Text.ToInteger
		  Catch
		    v = 0
		  End
		  #Pragma BreakOnExceptions True
		  
		  v = v - 1
		  
		  txtWDAdding.Text = v.ToString
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub UpPressed()
		  Var v As Integer
		  
		  
		  #Pragma BreakOnExceptions False
		  Try
		    v= txtWDAdding.Text.ToInteger
		  Catch
		    v = 0
		  End
		  #Pragma BreakOnExceptions True
		  
		  v = v + 1
		  
		  txtWDAdding.Text = v.ToString
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events popFDShiftMode
	#tag Event
		Sub Opening()
		  Me.AddRow "previous"
		  Me.AddRow "next"
		  me.SelectedRowIndex = 0
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events txtEDDiff1
	#tag Event
		Function KeyDown(key As String) As Boolean
		  if key.Asc < 32 then Return false// Specials char 
		  if key.asc = 127 then Return false // backspace
		  
		  If key = "-" Then
		    If Me.Text.IndexOf("-") > 0 Then Return True
		    If Me.SelectionStart > 0 Then Return True
		    Return False
		  end
		  
		  If Not (key>="0" And key<="9") Then Return True
		  
		  // ok
		  Return False
		End Function
	#tag EndEvent
	#tag Event
		Sub FocusLost()
		  
		  #Pragma BreakOnExceptions False
		  Try
		    Me.Text = Me.Text.ToInteger.ToString
		  Catch
		    me.Text = "0"
		  End
		  #Pragma BreakOnExceptions True
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub TextChanged()
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events popWDMonth
	#tag Event
		Sub Opening()
		  Var d As DateTime
		  For i As Integer = 1 To 12
		    d = New DateTime(2025, i, 1)
		    Me.AddRow d.ToString("MMMM", Locale.Current)
		  Next 
		  
		  me.SelectedRowIndex = 0
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events UpDownArrows2
	#tag Event
		Sub DownPressed()
		  Var v As Integer
		  
		  
		  #Pragma BreakOnExceptions False
		  Try
		    v= txtEDDiff.Text.ToInteger
		  Catch
		    v = 0
		  End
		  #Pragma BreakOnExceptions True
		  
		  v = v - 1
		  
		  txtEDDiff.Text = v.ToString
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub UpPressed()
		  Var v As Integer
		  
		  
		  #Pragma BreakOnExceptions False
		  Try
		    v= txtEDDiff.Text.ToInteger
		  Catch
		    v = 0
		  End
		  #Pragma BreakOnExceptions True
		  
		  v = v + 1
		  
		  txtEDDiff.Text = v.ToString
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events UpDownArrows5
	#tag Event
		Sub DownPressed()
		  Var v As Integer
		  
		  
		  #Pragma BreakOnExceptions False
		  Try
		    v= txtEDDiff1.Text.ToInteger
		  Catch
		    v = 0
		  End
		  #Pragma BreakOnExceptions True
		  
		  v = v - 1
		  
		  txtEDDiff1.Text = v.ToString
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub UpPressed()
		  Var v As Integer
		  
		  
		  #Pragma BreakOnExceptions False
		  Try
		    v= txtEDDiff1.Text.ToInteger
		  Catch
		    v = 0
		  End
		  #Pragma BreakOnExceptions True
		  
		  v = v + 1
		  
		  txtEDDiff1.Text = v.ToString
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonEaster23
	#tag Event
		Sub Pressed()
		  txtCaption.Text = me.Caption
		  txtEDDiff1.Text = "-2"
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonEaster24
	#tag Event
		Sub Pressed()
		  txtCaption.Text = me.Caption
		  txtEDDiff1.Text = "-1"
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonEaster22
	#tag Event
		Sub Pressed()
		  txtCaption.Text = me.Caption
		  txtEDDiff1.Text = "0"
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonEaster25
	#tag Event
		Sub Pressed()
		  txtCaption.Text = me.Caption
		  txtEDDiff1.Text = "56"
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonEaster26
	#tag Event
		Sub Pressed()
		  txtCaption.Text = me.Caption
		  txtEDDiff1.Text = "8"
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonEaster27
	#tag Event
		Sub Pressed()
		  txtCaption.Text = me.Caption
		  txtEDDiff1.Text = "9"
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonEaster28
	#tag Event
		Sub Pressed()
		  txtCaption.Text = me.Caption
		  txtEDDiff1.Text = "-8"
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonEaster29
	#tag Event
		Sub Pressed()
		  txtCaption.Text = me.Caption
		  txtEDDiff1.Text = "-57"
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonEaster30
	#tag Event
		Sub Pressed()
		  txtCaption.Text = me.Caption
		  txtEDDiff1.Text = "-42"
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonEaster31
	#tag Event
		Sub Pressed()
		  txtCaption.Text = me.Caption
		  txtEDDiff1.Text = "-70"
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonEaster32
	#tag Event
		Sub Pressed()
		  txtCaption.Text = me.Caption
		  txtEDDiff1.Text = "49"
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonEaster33
	#tag Event
		Sub Pressed()
		  txtCaption.Text = me.Caption
		  txtEDDiff1.Text = "40"
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonEaster34
	#tag Event
		Sub Pressed()
		  txtCaption.Text = me.Caption
		  txtEDDiff1.Text = "-7"
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events popHebraicHolidayType
	#tag Event
		Sub Opening()
		  
		  Me.Addrow "Rosh Hashanah"
		  Me.Addrow "Yom Kippur"
		  Me.Addrow "Sukkot (1st day)"
		  Me.Addrow "Hoshana Rabbah"
		  Me.Addrow "Shemini Atzeret"
		  Me.Addrow "Simchat Torah (Diaspora)"
		  Me.Addrow "Simchat Torah (Israel)"
		  Me.Addrow "Hanukkah (1st day)"
		  Me.Addrow "Tu BiShvat"
		  Me.Addrow "Purim"
		  Me.Addrow "Passover (1st day)"
		  Me.Addrow "Passover (7th day)"
		  Me.Addrow "Passover (8th day - Diaspora)"
		  Me.Addrow "Yom HaShoah"
		  Me.Addrow "Yom HaZikaron"
		  Me.Addrow "Yom HaZikaron (Civil shift)"
		  Me.Addrow "Yom Ha'atzmaut"
		  Me.Addrow "Yom Ha'atzmaut (Civil shift)"
		  Me.Addrow "Lag BaOmer"
		  Me.Addrow "Shavuot"
		  Me.Addrow "Fast of Gedaliah"
		  Me.Addrow "Fast of Gedaliah (Shabbat shift)"
		  Me.Addrow "Tenth of Tevet"
		  Me.Addrow "Tenth of Tevet (Shabbat shift)"
		  Me.Addrow "Fast of Esther"
		  Me.Addrow "Fast of Esther (Shabbat shift)"
		  Me.Addrow "Seventeenth of Tammuz"
		  Me.Addrow "Seventeenth of Tammuz (Shabbat shift)"
		  me.AddRow "-"
		  Me.Addrow "Custom"
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged(item As DesktopMenuItem)
		  #Pragma Unused item
		  
		  If Me.SelectedRowIndex = Me.LastRowIndex - 1 Then
		    Me.SelectedRowIndex = Me.SelectedRowIndex - 2
		  end
		  
		  If Me.SelectedRowIndex = Me.LastRowIndex And Not Label20.Enabled Then
		    popHDay.SelectedRowIndex = 0
		    popHMonth.SelectedRowIndex = 0
		  end
		  
		  Label20.Enabled = Me.SelectedRowIndex <> Me.LastRowIndex
		  Label21.Enabled = Me.SelectedRowIndex <> Me.LastRowIndex
		  popHDay.Enabled = Me.SelectedRowIndex <> Me.LastRowIndex
		  popHMonth.Enabled = Me.SelectedRowIndex <> Me.LastRowIndex
		  btnHEnglish.Enabled  = Me.SelectedRowIndex <> Me.LastRowIndex
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events popHMonth
	#tag Event
		Sub Opening()
		  Me.AddRow "1 - Nisan"
		  Me.AddRow "2 - Iyar"
		  Me.AddRow "3 - Sivan"
		  Me.AddRow "3 - Tammuz"
		  Me.AddRow "5 - Av"
		  Me.AddRow "6 - Elul"
		  Me.AddRow "7 - Tishri"
		  Me.AddRow "8 - Heshvan"
		  Me.AddRow "9 - Kislev"
		  Me.AddRow "10 - Tevet"
		  Me.AddRow "11 - Shevat"
		  Me.AddRow "12 - Adar (Adar I In a leap year)"
		  Me.AddRow "13 - Adar II (leap years only)"
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events popHDay
	#tag Event
		Sub Opening()
		  For i As Integer = 1 To 30
		    me.AddRow i.ToString
		  Next 
		  
		  me.SelectedRowIndex = 0
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnHEnglish
	#tag Event
		Sub Pressed()
		  txtCaption.Text = AnnualEventHebraic.EnglishName(CType(popHebraicHolidayType.SelectedRowIndex + 1, AnnualEventHebraic.HolidayType))
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnHEnglish1
	#tag Event
		Sub Pressed()
		  txtCaption.Text = AnnualEventHebraic.SpanishName(CType(popHebraicHolidayType.SelectedRowIndex + 1, AnnualEventHebraic.HolidayType))
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnHEnglish2
	#tag Event
		Sub Pressed()
		  txtCaption.Text = AnnualEventHebraic.FrenchName(CType(popHebraicHolidayType.SelectedRowIndex + 1, AnnualEventHebraic.HolidayType))
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnHEnglish3
	#tag Event
		Sub Pressed()
		  txtCaption.Text = AnnualEventHebraic.DutchName(CType(popHebraicHolidayType.SelectedRowIndex + 1, AnnualEventHebraic.HolidayType))
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnHEnglish4
	#tag Event
		Sub Pressed()
		  txtCaption.Text = AnnualEventHebraic.GermanName(CType(popHebraicHolidayType.SelectedRowIndex + 1, AnnualEventHebraic.HolidayType))
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnHEnglish5
	#tag Event
		Sub Pressed()
		  txtCaption.Text = AnnualEventHebraic.ModernHebrewName(CType(popHebraicHolidayType.SelectedRowIndex + 1, AnnualEventHebraic.HolidayType))
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnOK
	#tag Event
		Sub Pressed()
		  If txtCaption.Text.Trim = "" Then
		    MessageBox "Enter a caption"
		    Exit Sub
		  end
		  
		  If txtCaption.Text.Trim.Lowercase = "new day" Then
		    
		    Var m as new MessageDialog
		    m.Title = self.Title
		    m.Message = "Do you want to keep ""New day"" as the caption?"
		    m.IconType = MessageDialog.IconTypes.Question
		    m.ActionButton.Caption = "Keep"
		    m.CancelButton.Caption = "Cancel"
		    m.CancelButton.Visible = True
		    m.CancelButton.Default = True
		    m.CancelButton.Cancel = True
		    Var b As MessageDialogButton  = m.ShowModal
		    if b = m.CancelButton then exit sub
		    
		  end
		  
		  Select Case PagePanel1.SelectedPanelIndex
		    
		  Case 0 // Fixed day
		    
		    Var month as Integer = popFDMonth.SelectedRowIndex + 1
		    Var day As Integer = popFDDay.SelectedRowIndex + 1
		    
		    If (month = 4 Or month = 6 Or month = 9 Or month = 11) and day = 31 Then
		      MessageBox "The day was set to 30"
		      day = 30
		    elseif month = 2 and day > 29 then
		      MessageBox "The day was set to 29"
		      day = 29
		    end
		    
		    Var fd As New AnnualEventFixed(txtCaption.Text.trim, month, day )
		    
		    If cbFDFridayIfSaturday.Value Then fd.FridayIfSaturday = True
		    if cbFDMondayIfSunday.Value then fd.MondayIfSunday = True
		    
		    
		    If popFDWeekDay.SelectedRowIndex > 0 Then
		      If popFDShiftMode.SelectedRowIndex = 0 Then
		        
		        fd.DesiredWeekday = popFDWeekDay.SelectedRowIndex
		        fd.AlwaysMoveDesiredWeekday = chkDFAlways.value 
		        fd.DesiredWeekdayDirection = AnnualEventFixed.WeekdayDirectionType.Before
		        
		      Else
		        fd.DesiredWeekday = popFDWeekDay.SelectedRowIndex
		        fd.AlwaysMoveDesiredWeekday = chkDFAlways.value 
		        fd.DesiredWeekdayDirection = AnnualEventFixed.WeekdayDirectionType.After
		      End
		      
		    ElseIf txtFDAdding.Text.ToInteger <> 0 Then
		      fd.DayOffset =  txtFDAdding.Text.ToInteger
		    End
		    
		    
		    fd.DayOff = chkDayOff.Value
		    fd.CycleFirstYear =  txtFirstYearOfTheCycle.Text.ToInteger
		    fd.CycleYearDuration = txtCycleDuration.Text.ToInteger
		    fd.StartOfValidity = dtStart.SelectedDate
		    fd.EndOfValidity = dtEnd.SelectedDate
		    
		    self.AnnualEventReturned = fd
		    
		  case 1 // Easter
		    
		    Var delta as integer = txtEDDiff.Text.ToInteger
		    Var ed as new AnnualEventEaster(txtCaption.Text, delta)
		    
		    ed.DayOff = chkDayOff.Value
		    ed.CycleFirstYear =  txtFirstYearOfTheCycle.Text.ToInteger
		    ed.CycleYearDuration = txtCycleDuration.Text.ToInteger
		    ed.StartOfValidity = dtStart.SelectedDate
		    ed.EndOfValidity = dtEnd.SelectedDate
		    
		    self.AnnualEventReturned = ed
		    
		  Case 2 // Orthodox aster
		    
		    Var delta As Integer = txtEDDiff1.Text.ToInteger
		    Var oed As New AnnualEventOrthodoxEaster(txtCaption.Text, delta)
		    
		    oed.DayOff = chkDayOff.Value
		    oed.CycleFirstYear =  txtFirstYearOfTheCycle.Text.ToInteger
		    oed.CycleYearDuration = txtCycleDuration.Text.ToInteger
		    oed.StartOfValidity = dtStart.SelectedDate
		    oed.EndOfValidity = dtEnd.SelectedDate
		    
		    self.AnnualEventReturned = oed
		    
		  Case 3
		    
		    Var month As Integer = popWDMonth.SelectedRowIndex + 1
		    Var weekday As Integer = popWDWeekDay.SelectedRowIndex + 1
		    var occurence as Integer = popWDRank.SelectedRowIndex + 1
		    
		    Var wdd as new AnnualEventWeekDay(txtCaption.Text, month, weekday, occurence)
		    
		    
		    If txtWDAdding.Text.ToInteger <> 0 Then
		      wdd.DayOffset =  txtWDAdding.Text.ToInteger
		    End
		    
		    wdd.DayOff = chkDayOff.Value
		    wdd.CycleFirstYear =  txtFirstYearOfTheCycle.Text.ToInteger
		    wdd.CycleYearDuration = txtCycleDuration.Text.ToInteger
		    wdd.StartOfValidity = new DateTime(dtStart.SelectedDate.Year, dtStart.SelectedDate.Month, dtStart.SelectedDate.Day)
		    wdd.EndOfValidity = new DateTime(dtEnd.SelectedDate.Year, dtEnd.SelectedDate.Month, dtEnd.SelectedDate.Day, 23, 59, 59)
		    
		    self.AnnualEventReturned = wdd
		    
		  End Select
		  
		  self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnCancel
	#tag Event
		Sub Pressed()
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnCopy
	#tag Event
		Sub Pressed()
		  If txtCaption.Text.Trim = "" Then
		    MessageBox "Enter a caption"
		    Exit Sub
		  end
		  
		  Var strCode as string
		  
		  Select Case PagePanel1.SelectedPanelIndex
		    
		  Case 0 // Fixed day
		    
		    Var month as Integer = popFDMonth.SelectedRowIndex + 1
		    Var day As Integer = popFDDay.SelectedRowIndex + 1
		    
		    If (month = 4 Or month = 6 Or month = 9 Or month = 11) and day = 31 Then
		      day = 30
		    elseif month = 2 and day > 29 then
		      day = 29
		    end
		    
		    strCode = "Var NewEvent As New AnnualEventFixed(""" + txtCaption.Text.ReplaceAll("""","""""") + """," + month.ToString + "," + day.ToString + ")"
		    
		    
		    If txtFDAdding.Text.ToInteger <> 0 Then
		      strCode = strCode + EndOfLine
		      strCode = strCode + "NewEvent.DayOffset = " +  txtFDAdding.Text
		    End
		    
		    
		    if popFDWeekDay.SelectedRowIndex > 0 then
		      
		      If popFDShiftMode.SelectedRowIndex = 0 Then
		        
		        strCode = strCode + EndOfLine
		        strCode = strCode + "NewEvent.DesiredWeekday  = " + popFDWeekDay.SelectedRowIndex.ToString + EndOfLine
		        if chkDFAlways.value then strCode = strCode + "NewEvent.AlwaysMoveDesiredWeekday = True" + EndOfLine
		        strCode = strCode + "NewEvent.DesiredWeekdayDirection = AnnualEventFixed.WeekdayDirectionType.Before"
		        
		      Else
		        strCode = strCode + EndOfLine
		        strCode = strCode + "NewEvent.DesiredWeekday  = " + popFDWeekDay.SelectedRowIndex.ToString + EndOfLine
		        If chkDFAlways.value Then strCode = strCode + "NewEvent.AlwaysMoveDesiredWeekday = True" + EndOfLine
		        strCode = strCode + "NewEvent.DesiredWeekdayDirection = AnnualEventFixed.WeekdayDirectionType.After"
		      End
		      
		    else
		      
		      If cbFDFridayIfSaturday.Value Then 
		        strCode = strCode + EndOfLine
		        strCode = strCode + "NewEvent.FridayIfSaturday = True"
		      End
		      
		      If cbFDMondayIfSunday.Value Then 
		        strCode = strCode + EndOfLine
		        strCode = strCode + "NewEvent.MondayIfSunday = True"
		      End If
		      
		    end
		    
		  case 1 // Easter
		    
		    Var delta as integer = txtEDDiff.Text.ToInteger
		    strCode = strCode + "Var NewEvent as new AnnualEventEaster(""" + txtCaption.Text.ReplaceAll("""","""""") + """," + delta.ToString + ")"
		    
		    
		  Case 2 // Orthodox aster
		    
		    Var delta As Integer = txtEDDiff1.Text.ToInteger
		    strCode = strCode + "Var NewEvent as new AnnualEventOrthodoxEaster(""" + txtCaption.Text.ReplaceAll("""","""""") + """," + delta.ToString + ")"
		    
		  Case 3 // Occurence
		    
		    Var month As Integer = popWDMonth.SelectedRowIndex + 1
		    Var weekday As Integer = popWDWeekDay.SelectedRowIndex + 1
		    var occurence as Integer = popWDRank.SelectedRowIndex + 1
		    
		    strCode = strCode + "Var NewEvent as new AnnualEventWeekDay(""" + txtCaption.Text.ReplaceAll("""","""""") + """, " + month.ToString + ", " + weekday.ToString + ", "  + occurence.ToString + ")"
		    
		    
		    If txtWDAdding.Text.ToInteger <> 0 Then
		      
		      strCode = strCode + EndOfLine
		      strCode = strCode + "NewEvent.DayOffset = " +  txtWDAdding.Text
		      
		    End
		    
		  case 4 // hebraic
		    
		    If popHebraicHolidayType.SelectedRowIndex <> popHebraicHolidayType.LastRowIndex Then
		      
		      Var currentEnum As AnnualEventHebraic.HolidayType = CType(popHebraicHolidayType.SelectedRowIndex + 1, AnnualEventHebraic.HolidayType)
		      strCode = strCode + "Var NewEvent as new AnnualEventHebraic(""" + txtCaption.Text.ReplaceAll("""","""""") + _
		       """, AnnualEventHebraic.HolidayType." + HebraicEnum(popHebraicHolidayType.SelectedRowIndex) + ")"
		      
		    else
		      
		      strCode = strCode + "Var NewEvent as new AnnualEventHebraic(" + _ 
		      """" + txtCaption.Text.ReplaceAll("""","""""") + """, " + _
		      popHMonth.RowTextAt(popHMonth.SelectedRowIndex) + ", " + _
		      popHDay.RowTextAt(popHDay.SelectedRowIndex) + ")"
		      
		    end
		    
		  End Select
		  
		  
		  If Not chkDayOff.Value Then
		    strCode = strCode + EndOfLine
		    strCode = strCode + "NewEvent.DayOff = False"
		  End
		  
		  If txtCycleDuration.Text.ToInteger > 1 Then
		    strCode = strCode + EndOfLine
		    strCode = strCode + "NewEvent.CycleFirstYear = " + txtFirstYearOfTheCycle.Text + EndOfLine
		    strCode = strCode + "NewEvent.CycleYearDuration = " +txtCycleDuration.Text + EndOfLine
		  End
		  
		  Var dCompare As new DateTime(1,1,1)
		  
		  
		  If Not (dtStart.SelectedDate.day = dCompare.day _
		    And dtStart.SelectedDate.Month = dCompare.Month _
		    And dtStart.SelectedDate.Year = dCompare.Year) Then
		    
		    strCode = strCode + EndOfLine
		    strCode = strCode + "NewEvent.StartOfValidity = New DateTime(" _ 
		    + dtStart.SelectedDate.Year.ToString _
		    + "," + dtStart.SelectedDate.Month.ToString _
		    + "," + dtStart.SelectedDate.day.ToString + ", 0, 0, 0, 0, TimeZone.Current)"
		    
		  End
		  
		  dCompare = new DateTime(3999,12,31)
		  
		  if Not (dtEnd.SelectedDate.day = dCompare.day _
		    And dtEnd.SelectedDate.Month = dCompare.Month _
		    And dtEnd.SelectedDate.Year = dCompare.Year) Then
		    
		    strCode = strCode + EndOfLine
		    strCode = strCode + "NewEvent.EndValidity = New DateTime(" _ 
		    + dtEnd.SelectedDate.Year.ToString _
		    + ", " + dtEnd.SelectedDate.Month.ToString _
		    + ", " + dtEnd.SelectedDate.day.ToString + ", 23, 59, 59, 0, TimeZone.Current)"
		    
		  end
		  
		  Var cb As New Clipboard
		  cb.Text = strCode
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Interfaces"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Type"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Types"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasCloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasFullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasTitleBar"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DefaultLocation"
		Visible=true
		Group="Behavior"
		InitialValue="2"
		Type="Locations"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Window Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&cFFFFFF"
		Type="ColorGroup"
		EditorType="ColorGroup"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Menus"
		InitialValue=""
		Type="DesktopMenuBar"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
