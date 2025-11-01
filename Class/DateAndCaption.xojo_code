#tag Class
Protected Class DateAndCaption
	#tag Method, Flags = &h0
		Sub Constructor(SourceCopy as DateAndCaption)
		  Me.DateValue = SourceCopy.DateValue
		  Me.Caption = SourceCopy.Caption
		  me.RegionIdentifier = SourceCopy.RegionIdentifier
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(lDate as DateTime = Nil, lCaption as string = "", lRegionIdentifier as Variant = Nil)
		  Me.DateValue = lDate
		  Me.Caption = lCaption
		  me.RegionIdentifier = lRegionIdentifier
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Caption As String
	#tag EndProperty

	#tag Property, Flags = &h0
		DateValue As DateTime
	#tag EndProperty

	#tag Property, Flags = &h0
		RegionIdentifier As Variant = Nil
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
