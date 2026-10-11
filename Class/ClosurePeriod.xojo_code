#tag Class
Protected Class ClosurePeriod
	#tag Method, Flags = &h0
		Sub Constructor(copy as ClosurePeriod)
		  me.DbId = copy.DbId
		  Me.mFirstDay = copy.FirstDay
		  Me.mLastDay = copy.LastDay
		  Me.Caption = copy.Caption
		  me.Tag = copy.Tag
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(lFirstDay as DateTime, lLastDay as DateTime, lCaption as string = "")
		  Me.FirstDay = lFirstDay
		  Me.LastDay= lLastDay
		  me.Caption = lCaption
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(FromStringValue as string)
		  Var s() As String = FromStringValue.Split("|")
		  If s.LastIndex <> 2 Then 
		    Raise New InvalidArgumentException
		    Exit Sub
		  end
		  
		  If s(0).Trim <> "" Then Me.Caption = DecodeBase64(s(0)).DefineEncoding(Encodings.UTF8)
		  Me.FirstDay = DateTime.FromString(s(1))
		  Me.LastDay = DateTime.FromString(s(2))
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
		Function Duration() As Integer
		  if mLastDay = nil or mFirstDay = Nil then Return 0
		  
		  Var l as new DateTime(me.mLastDay.Year, me.mLastDay.Month, me.LastDay.day, 12, 0, 0, 0, me.mLastDay.Timezone)
		  Var f As New DateTime(Me.mFirstDay.Year, Me.mFirstDay.Month, Me.mFirstDay.day, 12, 0, 0, 0, Me.mFirstDay.Timezone)
		  
		  Return Round((l.SecondsFrom1970 - f.SecondsFrom1970) / 86400) + 1
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromString(value as String) As ClosurePeriod
		  Var s() As String = value.Split("|")
		  If s.LastIndex <> 2 Then 
		    Raise new InvalidArgumentException
		    Return Nil
		  end
		  
		  
		  
		  Var c as string = DecodeBase64(s(0)).DefineEncoding(Encodings.UTF8)
		  Var f as DateTime = DateTime.FromString(s(1))
		  var l as DateTime = DateTime.FromString(s(2))
		  
		  Var cp As New ClosurePeriod(f,l,c)
		  
		  Return cp
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsIncluded(lDate as DateTime) As Boolean
		  if lDate = Nil then Return False
		  
		  Return (lDate >= me.FirstDay and lDate <= me.LastDay)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastDayOfWork(skipWeekends As Boolean = False) As DateTime
		  Var d As New DateTime(FirstDay.Year, FirstDay.Month, FirstDay.Day, 23, 59, 59)
		  d = d.SubtractInterval(0, 0, 1)
		  
		  If skipWeekends Then
		    While d.DayOfWeek = 1 Or d.DayOfWeek = 7 // 1 = Sunday, 7 = Saturday
		      d = d.SubtractInterval(0, 0, 1)
		    Wend
		  End If
		  
		  Return d
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReturnToWork(skipWeekends As Boolean = False) As DateTime
		  Var d As New DateTime(LastDay.Year, LastDay.Month, LastDay.Day, 0, 0, 0)
		  d = d.AddInterval(0, 0, 1)
		  
		  If skipWeekends Then
		    While d.DayOfWeek = 1 Or d.DayOfWeek = 7
		      d = d.AddInterval(0, 0, 1)
		    Wend
		  End If
		  
		  Return d
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As String
		  Var s as string
		  
		  s = s + EncodeBase64(Me.Caption,0) + "|"
		  s = s + Me.FirstDay.SQLDate + "|"
		  s = s + Me.LastDay.SQLDate 
		  
		  Return s
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Caption As String
	#tag EndProperty

	#tag Property, Flags = &h0
		DbId As Variant
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mFirstDay
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If value = Nil Then
			    Raise new InvalidArgumentException
			    Exit Sub
			  end
			  
			  Var d1 as new DateTime(value.Year, value.Month,  value.day, 0, 0, 0)
			  mFirstDay = d1
			End Set
		#tag EndSetter
		FirstDay As DateTime
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mLastDay
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If value = Nil Then
			    Raise New InvalidArgumentException
			    Exit Sub
			  End
			  
			  var d1 as new DateTime(value.Year, value.Month,  value.day, 23, 59, 59)
			  mLastDay = d1
			End Set
		#tag EndSetter
		LastDay As DateTime
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mFirstDay As DateTime
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastDay As DateTime
	#tag EndProperty

	#tag Property, Flags = &h0
		Tag As Variant
	#tag EndProperty


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
			Name="Caption"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
