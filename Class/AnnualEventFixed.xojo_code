#tag Class
Protected Class AnnualEventFixed
Implements AnnualEvent
	#tag Method, Flags = &h0
		Function Calculate(Year as integer) As DateAndCaption
		  Var d As DateTime = Me.DateValue(Year)
		  
		  If d = Nil Then Return Nil
		  
		  Return new DateAndCaption(d, me.mCaption)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Caption() As string
		  Return mCaption
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Caption(Assigns s as string)
		  mCaption = s
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(a as AnnualEvent)
		  If a = Nil Then 
		    Raise new NilObjectException
		    Exit Sub
		  end
		  
		  If not (a IsA AnnualEventFixed) Then
		    Raise New InvalidArgumentException
		    Exit Sub
		  end
		  
		  Var copy As AnnualEventFixed = a.DefinitionObject
		  
		  Me.Day = copy.Day
		  Me.Month = copy.Month
		  
		  Me.mCaption = Copy.Caption
		  Me.DayOff = copy.DayOff
		  Me.CycleFirstYear = Copy.CycleFirstYear
		  Me.CycleYearDuration = Copy.CycleYearDuration
		  Me.Tag = copy.Tag
		  Me.DbId = copy.DbId
		  Me.StartOfValidity = copy.StartOfValidity
		  Me.EndOfValidity = copy.EndOfValidity
		  
		  Me.DayOffset = copy.DayOffset
		  Me.FridayIfSaturday = copy.FridayIfSaturday
		  Me.MondayIfSunday = copy.MondayIfSunday
		  Me.NotLeapYearOffset = copy.NotLeapYearOffset
		  
		  Me.AlwaysMoveDesiredWeekday= copy.AlwaysMoveDesiredWeekday
		  Me.DesiredWeekday = copy.DesiredWeekday
		  Me.DesiredWeekdayDirection = copy.DesiredWeekdayDirection
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(copy as AnnualEventFixed)
		  If copy = Nil Then 
		    Raise new NilObjectException
		    Exit Sub
		  end
		  
		  
		  Me.Day = copy.Day
		  Me.Month = copy.Month
		  
		  Me.mCaption = Copy.Caption
		  Me.DayOff = copy.DayOff
		  Me.CycleFirstYear = Copy.CycleFirstYear
		  Me.CycleYearDuration = Copy.CycleYearDuration
		  Me.Tag = copy.Tag
		  Me.DbId = copy.DbId
		  Me.StartOfValidity = copy.StartOfValidity
		  Me.EndOfValidity = copy.EndOfValidity
		  
		  
		  Me.DayOffset = copy.DayOffset
		  Me.FridayIfSaturday = copy.FridayIfSaturday
		  Me.MondayIfSunday = copy.MondayIfSunday
		  me.NotLeapYearOffset = copy.NotLeapYearOffset
		  
		  Me.AlwaysMoveDesiredWeekday= copy.AlwaysMoveDesiredWeekday
		  Me.DesiredWeekday = copy.DesiredWeekday
		  me.DesiredWeekdayDirection = copy.DesiredWeekdayDirection
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(lCaption as String = "", lMonth as Integer = 1, lDay as Integer = 1, lFridayIfSaturday as Boolean = False, lMondayIfSunday as Boolean = False)
		  Me.mCaption = lCaption
		  Me.Month = lMonth
		  Me.Day = lDay
		  
		  
		  Me.FridayIfSaturday = lFridayIfSaturday
		  me.MondayIfSunday = lMondayIfSunday
		  
		  Me.StartOfValidity = New DateTime(1,1,1,0,0,0)
		  Me.EndOfValidity = New DateTime(3999,12,31,23,59,59)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CycleFirstYear() As Integer
		  Return mCycleFirstYear
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CycleFirstYear(assigns value as Integer)
		  mCycleFirstYear = value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CycleYearDuration() As Integer
		  Return mCycleYearDuration
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CycleYearDuration(assigns value as Integer)
		  mCycleYearDuration = value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DateValue(year As Integer) As DateTime
		  Var d As Integer = Day
		  
		  If Me.CycleYearDuration > 1 Then
		    If Me.CycleFirstYear > year Then Return Nil
		    If (year - Me.CycleFirstYear) Mod Me.CycleYearDuration > 0 Then Return Nil
		  End
		  
		  if year < me.mStartOfValidity.Year or year > me.mEndOfValidity.Year then Return nil
		  
		  Var result as DateTime
		  
		  // February 29 does not exist in non-leap years: fall back to February 28
		  If Month = 2 And d = 29 And Not ((year Mod 4 = 0 And year Mod 100 <> 0) Or (year Mod 400 = 0)) then
		    
		    Select case me.mNotLeapYearOffset
		      
		    case 0
		      
		      Return Nil
		      
		    case is > 0
		      
		      result =  new DateTime(year, 3, 1, 0, 0, 0)
		      
		    case is < 0
		      
		      result =  new DateTime(year, 2, 28, 0, 0, 0)
		    end
		    
		  else
		    
		    result =  new DateTime(year, Month, d, 0, 0, 0)
		    
		  end
		  
		  // 1) Offset in days (positive or negative)
		  If DayOffset <> 0 Then result = result.AddInterval(0, 0, DayOffset)
		  
		  // 2) Move to a given weekday
		  // DayOfWeek: 1 = Sunday, 2 = Monday ... 7 = Saturday
		  If DesiredWeekday >= 1 And DesiredWeekday <= 7 Then
		    Var current As Integer = result.DayOfWeek
		    Var delta As Integer
		    
		    If DesiredWeekdayDirection = WeekdayDirectionType.After Then
		      delta = (DesiredWeekday - current + 7) Mod 7      // days to move forward
		    Else
		      delta = (current - DesiredWeekday + 7) Mod 7      // days to move backward
		    End If
		    
		    // Already on the target weekday: still move by one week if AlwaysMoveDesiredWeekday is set
		    If delta = 0 And AlwaysMoveDesiredWeekday Then delta = 7
		    
		    If DesiredWeekdayDirection = WeekdayDirectionType.After Then
		      result = result.AddInterval(0, 0, delta)
		    Else
		      result = result.AddInterval(0, 0, -delta)
		    End If
		    
		  End If
		  
		  // 3) Weekend adjustment
		  If DesiredWeekday = 0 Then
		    If MondayIfSunday And result.DayOfWeek = 1 Then
		      result = result.AddInterval(0, 0, 1)
		    ElseIf FridayIfSaturday And result.DayOfWeek = 7 Then
		      result = result.AddInterval(0, 0, -1)
		    End If
		  End If
		  
		  
		  
		  If result < Me.mStartOfValidity Or result > Me.mEndOfValidity Then Return Nil
		  
		  Return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DayOff() As Boolean
		  Return mDayOff
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DayOff(assigns value as Boolean)
		  mDayOff = value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DbId() As Variant
		  Return mDbId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DbId(assigns value as Variant)
		  mDbId = value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DbRow(RegionIdentifier as Variant = Nil, encoding as TextEncoding = nil) As DatabaseRow
		  // Part of the AnnualEvent interface.
		  
		  Var row As New DatabaseRow
		  
		  
		  If Encoding = Nil Or Encoding = Encodings.UTF8 Then
		    
		    If RegionIdentifier <> Nil Then row.Column("region").StringValue = RegionIdentifier.StringValue.DefineEncoding(Encodings.UTF8) Else row.Column("region").StringValue = ""
		    row.Column("value").StringValue = Me.ToString.DefineEncoding(Encodings.UTF8)
		    
		  Else
		    
		    If RegionIdentifier <> Nil Then row.Column("region").StringValue = RegionIdentifier.StringValue.DefineEncoding(Encodings.UTF8).ConvertEncoding(Encoding).DefineEncoding(Encoding) Else row.Column("region").StringValue = ""
		    row.Column("value").StringValue = Me.ToString.DefineEncoding(Encodings.UTF8).ConvertEncoding(Encoding).DefineEncoding(Encoding)
		    
		    
		  End
		  
		  
		  Return row
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DefinitionObject() As Variant
		  // Part of the AnnualEvent interface.
		  
		  Return me
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EndOfValidity() As DateTime
		  Return mEndOfValidity
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EndOfValidity(assigns d as DateTime)
		  Var d1 as new DateTime(d.Year, d.Month, d.day, 23, 59, 59)
		  mEndOfValidity = d1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FIngerPrint() As String
		  Var s as String
		  
		  s = "F|" // 0
		  's = s + EncodeBase64(Me.Caption,0) + "|" // 1
		  s = s + Me.StartOfValidity.SQLDate + "|" // 2
		  s = s + Me.EndOfValidity.SQLDate + "|" // 3
		  s = s + Me.CycleFirstYear.ToString(Locale.Raw) + "|" // 4
		  s = s + Me.CycleYearDuration.ToString(Locale.Raw) + "|" // 5
		  If me.DayOff Then s = s + "1|" Else s = s + "0|" // 6
		  s = s + Me.Month.ToString(Locale.Raw) + "|" // 7
		  s = s + Me.Day.ToString(Locale.Raw) + "|" // 8
		  s = s + me.DayOffset.ToString(Locale.Raw) + "|" // 9 
		  s = s + Me.DesiredWeekday.ToString(Locale.Raw) + "|" // 10
		  s = s + ctype(me.DesiredWeekdayDirection, integer).ToString(Locale.Raw) + "|" // 11
		  if me.AlwaysMoveDesiredWeekday then s = s + "1|" else s = s + "0|"
		  If Me.MondayIfSunday Then s = s + "1|" Else s = s + "0|" // 13 
		  If Me.FridayIfSaturday Then s = s + "1|" Else s = s + "0|" // 14
		  
		  If Not (Me.Month = 2 And Me.day = 29) Then
		    s = s + "B" // Before 
		  Else
		    
		    Select Case Me.mNotLeapYearOffset // 15
		      
		    Case Is < 0 
		      
		      s = s + "B" // Before 
		      
		    Case Is < 0 
		      
		      s = s + "A" // After
		      
		    Else
		      
		      s = s + "N" // Nil
		      
		    End
		    
		  End
		  
		  
		  Return s
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromString(value as String) As AnnualEvent
		  Var s() As String = value.Split("|")
		  
		  If s.LastIndex < 7 Then 
		    Raise New InvalidArgumentException
		    Return Nil
		  End
		  
		  Select Case s(0)
		    
		  Case "F"
		    
		    If s.LastIndex <> 15 Then
		      Raise New InvalidArgumentException
		      Return Nil
		    End
		    
		    Var adf As New AnnualEventFixed
		    If s(1).Trim <> "" Then adf.Caption = DecodeBase64(s(1)).DefineEncoding(Encodings.UTF8)
		    
		    adf.StartOfValidity = DateTime.FromString(s(2))
		    adf.EndOfValidity = DateTime.FromString(s(3))
		    adf.CycleFirstYear = s(4).ToInteger
		    adf.CycleYearDuration = s(5).ToInteger
		    adf.DayOff = (s(6)="1")
		    adf.Month = s(7).ToInteger
		    adf.day = s(8).ToInteger
		    adf.DayOffset  = s(9).ToInteger 
		    adf.DesiredWeekday = s(10).ToInteger
		    adf.DesiredWeekdayDirection = AnnualEventFixed.WeekdayDirectionType(s(11).ToInteger)
		    adf.AlwaysMoveDesiredWeekday = (s(12) = "1")
		    adf.MondayIfSunday = (s(13) = "1")
		    adf.FridayIfSaturday = (s(14) = "1")
		    
		    Select Case s(15)
		      
		    Case "B" // before
		      
		      adf.NotLeapYearOffset = -1
		      
		    case "A" // After
		      
		      adf.NotLeapYearOffset = 1
		      
		    case else // return nil
		      
		      adf.NotLeapYearOffset = 0
		      
		    end
		    
		    Return adf
		    
		  Case "E"
		    
		    Var ae As New AnnualEventEaster
		    
		    If s.LastIndex <> 7 Then
		      Raise New InvalidArgumentException
		      Return Nil
		    End
		    
		    If s(1).Trim <> "" Then ae.Caption = DecodeBase64(s(1)).DefineEncoding(Encodings.UTF8)
		    
		    ae.StartOfValidity = DateTime.FromString(s(2))
		    ae.EndOfValidity = DateTime.FromString(s(3))
		    ae.CycleFirstYear = s(4).ToInteger
		    ae.CycleYearDuration = s(5).ToInteger
		    ae.DayOff = (s(6)="1")
		    ae.DayOffset = s(7).ToInteger
		    
		    Return ae
		    
		  Case "O"
		    
		    Var ae As New AnnualEventOrthodoxEaster
		    
		    If s.LastIndex <> 7 Then
		      Raise New InvalidArgumentException
		      Return Nil
		    End
		    
		    If s(1).Trim <> "" Then ae.Caption = DecodeBase64(s(1)).DefineEncoding(Encodings.UTF8)
		    
		    ae.StartOfValidity = DateTime.FromString(s(2))
		    ae.EndOfValidity = DateTime.FromString(s(3))
		    ae.CycleFirstYear = s(4).ToInteger
		    ae.CycleYearDuration = s(5).ToInteger
		    ae.DayOff = (s(6)="1")
		    ae.DayOffset = s(7).ToInteger
		    
		    Return ae
		    
		  Case "W"
		    
		    If s.LastIndex <> 10 Then 
		      Raise New InvalidArgumentException
		      Return Nil
		    End
		    
		    Var aw As New AnnualEventWeekDay
		    
		    If s(1).Trim <> "" Then aw.Caption = DecodeBase64(s(1)).DefineEncoding(Encodings.UTF8)
		    
		    aw.StartOfValidity = DateTime.FromString(s(2))
		    aw.EndOfValidity = DateTime.FromString(s(3))
		    aw.CycleFirstYear = s(4).ToInteger
		    aw.CycleYearDuration = s(5).ToInteger
		    aw.DayOff = (s(6)="1")
		    
		    aw.Month = s(7).ToInteger
		    aw.WeekDay = s(8).ToInteger
		    aw.Occurrence = s(9).ToInteger
		    aw.DayOffset = s(10).ToInteger
		    
		    Return aw
		    
		  Case "H"
		    
		    Var h As AnnualEventHebraic.HolidayType = AnnualEventHebraic.HolidayFromCode(s(7))
		    
		    If h = AnnualEventHebraic.HolidayType.Unknown Then
		      Raise New InvalidArgumentException
		      Return Nil
		    End
		    
		    Var c As String
		    If s(1).Trim <> "" Then c = DecodeBase64(s(1)).DefineEncoding(Encodings.UTF8)
		    
		    Var ah As AnnualEventHebraic
		    
		    If h = AnnualEventHebraic.HolidayType.Custom Then
		      
		      Var month As Integer = s(8).ToInteger
		      Var day As Integer = s(9).ToInteger
		      
		      If month < 1 Or day < 1 Then
		        Raise New InvalidArgumentException
		        Return Nil
		      End
		      
		      ah = New AnnualEventHebraic(c, month, day)
		      
		    Else 
		      
		      ah = New AnnualEventHebraic(c, h)
		      
		    End
		    
		    ah.StartOfValidity = DateTime.FromString(s(2))
		    ah.EndOfValidity = DateTime.FromString(s(3))
		    ah.CycleFirstYear = s(4).ToInteger
		    ah.CycleYearDuration = s(5).ToInteger
		    ah.DayOff = (s(6)="1")
		    
		    Return ah
		    
		  Else
		    
		    Raise New InvalidArgumentException
		    Return Nil
		    
		  End
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsEventDate(d As DateTime) As Boolean
		  if d is nil then Return False
		  if d.Year < 1 then Return False
		  
		  For y As Integer = d.Year - 1 To d.Year + 1
		    
		    Var eventDate As DateTime = DateValue(y)
		    
		    If eventDate Is Nil Then Continue
		    
		    If eventDate.Year = d.Year And eventDate.Month = d.Month And eventDate.Day = d.Day Then
		      Return True
		    End If
		    
		  Next
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StartOfValidity() As DateTime
		  Return mStartOfValidity
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StartOfValidity(assigns d as DateTime)
		  Var d1 as new DateTime(d.Year, d.Month, d.day, 0, 0, 0)
		  mStartOfValidity = d1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Tag() As Variant
		  Return mTag
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Tag(assigns value as Variant)
		  me.mTag = value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As String
		  Var s as String
		  
		  s = "F|" // 0
		  s = s + EncodeBase64(Me.Caption,0) + "|" // 1
		  s = s + Me.StartOfValidity.SQLDate + "|" // 2
		  s = s + Me.EndOfValidity.SQLDate + "|" // 3
		  s = s + Me.CycleFirstYear.ToString(Locale.Raw) + "|" // 4
		  s = s + Me.CycleYearDuration.ToString(Locale.Raw) + "|" // 5
		  If me.DayOff Then s = s + "1|" Else s = s + "0|" // 6
		  
		  s = s + Me.Month.ToString(Locale.Raw) + "|" // 7
		  s = s + Me.Day.ToString(Locale.Raw) + "|" // 8
		  s = s + me.DayOffset.ToString(Locale.Raw) + "|" // 9 
		  s = s + Me.DesiredWeekday.ToString(Locale.Raw) + "|" // 10
		  s = s + ctype(me.DesiredWeekdayDirection, integer).ToString(Locale.Raw) + "|" // 11
		  if me.AlwaysMoveDesiredWeekday then s = s + "1|" else s = s + "0|" // 12
		  If Me.MondayIfSunday Then s = s + "1|" Else s = s + "0|" // 13 
		  if Me.FridayIfSaturday Then s = s + "1|" Else s = s + "0|" // 14
		  
		  If Not (Me.Month = 2 And Me.day = 29) Then
		    s = s + "B" // Before 
		  else
		    
		    Select Case Me.mNotLeapYearOffset // 15
		      
		    case is < 0 
		      
		      s = s + "B" // Before 
		      
		    Case Is < 0 
		      
		      s = s + "A" // After
		      
		    Else
		      
		      s = s + "N" // Nil
		      
		    end
		    
		  end 
		  
		  Return s
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		#tag Note
			// True: shift even if the date already falls on the target weekday (e.g. Victoria Day)
		#tag EndNote
		AlwaysMoveDesiredWeekday As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		Day As Integer = 1
	#tag EndProperty

	#tag Property, Flags = &h0
		DayOffset As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mDesiredWeekday
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  if value < 0 or value > 7 then value = 0
			  mDesiredWeekday = value
			End Set
		#tag EndSetter
		DesiredWeekday As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		#tag Note
			// Move to the previous (Before) or next (After) target weekday
		#tag EndNote
		DesiredWeekdayDirection As WeekdayDirectionType = WeekdayDirectionType.After
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			// If the date falls on a Saturday, move it to Friday
		#tag EndNote
		FridayIfSaturday As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCaption As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCycleFirstYear As Integer = 1900
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCycleYearDuration As Integer = 1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDayOff As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDbId As Variant
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDesiredWeekday As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEndOfValidity As DateTime
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNotLeapYearOffset As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			// If the date falls on a Sunday, move it to Monday
		#tag EndNote
		MondayIfSunday As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		Month As Integer = 1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStartOfValidity As DateTime
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTag As Variant
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mNotLeapYearOffset
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If value > 0 And value > 1 Then 
			    value  = 1
			  ElseIf value < 0 And value < -1 Then
			    value  = -1
			  End If
			  
			  mNotLeapYearOffset = value
			End Set
		#tag EndSetter
		NotLeapYearOffset As Integer
	#tag EndComputedProperty


	#tag Enum, Name = WeekdayDirectionType, Type = Integer, Flags = &h0
		Before
		After
	#tag EndEnum


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
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Day"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Month"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DayOffset"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AlwaysMoveDesiredWeekday"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MondayIfSunday"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FridayIfSaturday"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DesiredWeekdayDirection"
			Visible=false
			Group="Behavior"
			InitialValue="WeekdayDirectionType.After"
			Type="WeekdayDirectionType"
			EditorType="Enum"
			#tag EnumValues
				"0 - Before"
				"1 - After"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="DesiredWeekday"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
