#tag Class
Protected Class AnnualEventWeekDay
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
		Sub Caption(assigns s as string)
		  mCaption = s
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(d as AnnualEvent)
		  If d = Nil Then 
		    Raise New NilObjectException
		    Exit Sub
		  End
		  
		  If Not (d IsA AnnualEventWeekDay) Then
		    Raise New InvalidArgumentException
		    Exit Sub
		  End
		  
		  Var copy As AnnualEventWeekDay = d.DefinitionObject
		  
		  
		  Me.Month = copy.Month
		  Me.WeekDay = copy.WeekDay
		  Me.Occurrence = copy.Occurrence
		  Me.DayOffset = copy.DayOffset
		  
		  Me.mCaption = Copy.Caption
		  Me.DayOff = copy.DayOff
		  Me.CycleFirstYear = Copy.CycleFirstYear
		  Me.CycleYearDuration = Copy.CycleYearDuration
		  Me.Tag = copy.Tag
		  Me.DbId = copy.DbId
		  Me.StartOfValidity = copy.StartOfValidity
		  Me.EndOfValidity = copy.EndOfValidity
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(copy as AnnualEventWeekDay)
		  
		  Me.Month = copy.Month
		  Me.WeekDay = copy.WeekDay
		  Me.Occurrence = copy.Occurrence
		  me.DayOffset = copy.DayOffset
		  
		  Me.mCaption = Copy.Caption
		  Me.DayOff = copy.DayOff
		  Me.CycleFirstYear = Copy.CycleFirstYear
		  Me.CycleYearDuration = Copy.CycleYearDuration
		  Me.Tag = copy.Tag
		  Me.DbId = copy.DbId
		  Me.StartOfValidity = copy.StartOfValidity
		  Me.EndOfValidity = copy.EndOfValidity
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(lCaption as string = "", lMonth as Integer = 1, lWeekDay as Integer = 1, lOccurrence as Integer = 1)
		  Me.mCaption = lCaption
		  
		  Me.Month = lMonth
		  me.WeekDay = lWeekDay
		  me.Occurrence = lOccurrence
		  
		  
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
		  If year < Me.StartOfValidity.Year Or year > Me.EndOfValidity.Year Then Return Nil
		  
		  // Validate properties (Occurrence: 1 to 5 = nth, kLast = last)
		  If Month < 1 Or Month > 12 Then Return Nil
		  If Weekday < 1 Or Weekday > 7 Then Return Nil
		  If Occurrence < 1 Or Occurrence > kLast Then Return Nil
		  
		  If Me.CycleYearDuration > 1 Then
		    If Me.CycleFirstYear > year Then Return Nil
		    If (year - Me.CycleFirstYear) Mod Me.CycleYearDuration > 0 Then Return Nil
		  End
		  
		  // Returns the holiday date for the given year at 00:00,
		  // or Nil if the configuration is invalid or the date does not exist
		  // (e.g. a 5th Friday in a month that only has four).
		  
		  
		  Var firstOfMonth As New DateTime(year, Month, 1, 0, 0, 0)
		  Var lastOfMonth As DateTime = firstOfMonth.AddInterval(0, 1, -1)
		  Var dayNumber As Integer
		  
		  If Occurrence < kLast Then
		    // nth weekday of the month: distance from the 1st to the first matching
		    // weekday, then 7 days per additional week.
		    // The modulo is normalized so the result is always between 0 and 6.
		    Var shift As Integer = ((Weekday - firstOfMonth.DayOfWeek) Mod 7 + 7) Mod 7
		    dayNumber = 1 + shift + (Occurrence - 1) * 7
		  Else
		    // Occurrence = kLast: last weekday of the month.
		    // Start from the last day and walk backwards.
		    Var shift As Integer = ((lastOfMonth.DayOfWeek - Weekday) Mod 7 + 7) Mod 7
		    dayNumber = lastOfMonth.Day - shift
		  End If
		  
		  // Safety check: the day must exist in the month
		  If dayNumber < 1 Or dayNumber > lastOfMonth.Day Then 
		    Break
		    Return Nil
		  end
		  
		  Var result As New DateTime(year, Month, dayNumber, 0, 0, 0)
		  
		  // Apply the day offset (positive or negative)
		  If DayOffset <> 0 Then result = result.AddInterval(0, 0, DayOffset)
		  
		  if result < me.mStartOfValidity or result > me.mEndOfValidity then Return Nil
		  
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
		  Var row as new DatabaseRow
		  
		  
		  If Encoding = Nil Or Encoding = Encodings.UTF8 Then
		    
		    if RegionIdentifier <> nil then row.Column("region").StringValue = RegionIdentifier.StringValue.DefineEncoding(Encodings.UTF8) else row.Column("region").StringValue = ""
		    row.Column("value").StringValue = me.ToString.DefineEncoding(Encodings.UTF8)
		    
		  Else
		    
		    if RegionIdentifier <> nil then row.Column("region").StringValue = RegionIdentifier.StringValue.DefineEncoding(Encodings.UTF8).ConvertEncoding(Encoding).DefineEncoding(encoding) else row.Column("region").StringValue = ""
		    row.Column("value").StringValue = me.ToString.DefineEncoding(Encodings.UTF8).ConvertEncoding(Encoding).DefineEncoding(encoding)
		    
		    
		  End
		  
		  
		  Return row
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DefinitionObject() As Variant
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
		Function FingerPrint() As string
		  Var s As String
		  
		  s = "W|"
		  
		  s = s + Me.StartOfValidity.SQLDate + "|"
		  s = s + Me.EndOfValidity.SQLDate + "|"
		  s = s + Me.CycleFirstYear.ToString(Locale.Raw) + "|"
		  s = s + Me.CycleYearDuration.ToString(Locale.Raw) + "|"
		  If Me.DayOff Then s = s + "1|" Else s = s + "0|"
		  s = s + Me.Month.ToString(locale.Raw) + "|"
		  s = s + Me.WeekDay.ToString(locale.Raw) + "|"
		  s = s + Me.Occurrence.ToString(locale.Raw) + "|"
		  s = s + Me.DayOffset.ToString(Locale.Raw)
		  
		  
		  
		  Return s
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromString(value as String) As AnnualEvent
		  Return AnnualEventFixed.FromString(value)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsEventDate(d as DateTime) As Boolean
		  // Returns True if d falls on the configured holiday (time of day is ignored).
		  If d Is Nil Then Return False
		  
		  
		  If Me.CycleYearDuration > 1 Then
		    If Me.CycleFirstYear > d.year Then Return False
		    If (d.year - Me.CycleFirstYear) Mod Me.CycleYearDuration > 0 Then Return False
		  End
		  
		  
		  // With a DayOffset, the holiday can land in the previous or next year
		  // (e.g. an offset from late December into January),
		  // so we check d.Year - 1, d.Year and d.Year + 1.
		  
		  For y As Integer = d.Year - 1 To d.Year + 1
		    
		    Var holiday As DateTime = DateValue(y)
		    If holiday Is Nil Then Continue
		    
		    If holiday.Year = d.Year And holiday.Month = d.Month And holiday.Day = d.Day Then
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
		  
		  s = "W|"
		  s = s + EncodeBase64(Me.Caption,0) + "|"
		  s = s + Me.StartOfValidity.SQLDate + "|"
		  s = s + Me.EndOfValidity.SQLDate + "|"
		  s = s + Me.CycleFirstYear.ToString(Locale.Raw) + "|"
		  s = s + Me.CycleYearDuration.ToString(Locale.Raw) + "|"
		  If Me.DayOff Then s = s + "1|" Else s = s + "0|"
		  s = s + Me.Month.ToString(locale.Raw) + "|"
		  s = s + Me.WeekDay.ToString(locale.Raw) + "|"
		  s = s + Me.Occurrence.ToString(locale.Raw) + "|"
		  s = s + Me.DayOffset.ToString(Locale.Raw)
		  
		  
		  
		  Return s
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		DayOffset As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCaption As string
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
		Private mEndOfValidity As DateTime
	#tag EndProperty

	#tag Property, Flags = &h0
		Month As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStartOfValidity As DateTime
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTag As Variant
	#tag EndProperty

	#tag Property, Flags = &h0
		Occurrence As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		WeekDay As Integer = 0
	#tag EndProperty


	#tag Constant, Name = kLast, Type = Double, Dynamic = False, Default = \"6", Scope = Public
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"6"
	#tag EndConstant


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
			Name="Month"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="WeekDay"
			Visible=false
			Group="Behavior"
			InitialValue="=0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Occurrence"
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
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
