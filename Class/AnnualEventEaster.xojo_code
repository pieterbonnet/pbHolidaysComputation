#tag Class
Protected Class AnnualEventEaster
Implements AnnualEvent
	#tag Method, Flags = &h0
		Shared Function AllFeasts(cult As Denomination, lang As FeastLanguage) As AnnualEventEaster()
		  // Renvoie les fêtes mobiles célébrées par le culte donné,
		  // avec leur nom (Caption) dans la langue choisie
		  Var result() As AnnualEventEaster
		  
		  Select Case cult
		  Case Denomination.Catholic
		    
		    result.Add(NewFeast(FeastId.MardiGras, lang))
		    result.Add(NewFeast(FeastId.AshWednesday, lang))
		    result.Add(NewFeast(FeastId.LaetareSunday, lang))
		    result.Add(NewFeast(FeastId.PalmSunday, lang))
		    result.Add(NewFeast(FeastId.MaundyThursday, lang))
		    result.Add(NewFeast(FeastId.GoodFriday, lang))
		    result.Add(NewFeast(FeastId.HolySaturday, lang))
		    result.Add(NewFeast(FeastId.EasterSunday, lang))
		    result.Add(NewFeast(FeastId.EasterMonday, lang))
		    result.Add(NewFeast(FeastId.DivineMercySunday, lang))
		    result.Add(NewFeast(FeastId.Ascension, lang))
		    result.Add(NewFeast(FeastId.Pentecost, lang))
		    result.Add(NewFeast(FeastId.WhitMonday, lang))
		    result.Add(NewFeast(FeastId.TrinitySunday, lang))
		    result.Add(NewFeast(FeastId.CorpusChristi, lang))
		    result.Add(NewFeast(FeastId.SacredHeart, lang))
		    result.Add(NewFeast(FeastId.ImmaculateHeart, lang))
		    
		  Case Denomination.Anglican
		    
		    result.Add(NewFeast(FeastId.ShroveTuesday, lang))
		    result.Add(NewFeast(FeastId.AshWednesday, lang))
		    result.Add(NewFeast(FeastId.MotheringSunday, lang))
		    result.Add(NewFeast(FeastId.PassionSunday, lang))
		    result.Add(NewFeast(FeastId.PalmSunday, lang))
		    result.Add(NewFeast(FeastId.MaundyThursday, lang))
		    result.Add(NewFeast(FeastId.GoodFriday, lang))
		    result.Add(NewFeast(FeastId.HolySaturday, lang))
		    result.Add(NewFeast(FeastId.EasterSunday, lang))
		    result.Add(NewFeast(FeastId.EasterMonday, lang))
		    result.Add(NewFeast(FeastId.Ascension, lang))
		    result.Add(NewFeast(FeastId.Pentecost, lang))
		    result.Add(NewFeast(FeastId.WhitMonday, lang))
		    result.Add(NewFeast(FeastId.TrinitySunday, lang))
		    
		  Case Denomination.Lutheran
		    
		    result.Add(NewFeast(FeastId.AshWednesday, lang))
		    result.Add(NewFeast(FeastId.PalmSunday, lang))
		    result.Add(NewFeast(FeastId.MaundyThursday, lang))
		    result.Add(NewFeast(FeastId.GoodFriday, lang))
		    result.Add(NewFeast(FeastId.EasterSunday, lang))
		    result.Add(NewFeast(FeastId.EasterMonday, lang))
		    result.Add(NewFeast(FeastId.Ascension, lang))
		    result.Add(NewFeast(FeastId.Pentecost, lang))
		    result.Add(NewFeast(FeastId.WhitMonday, lang))
		    result.Add(NewFeast(FeastId.TrinitySunday, lang))
		    
		  Case Denomination.Calvinist
		    
		    result.Add(NewFeast(FeastId.PalmSunday, lang))
		    result.Add(NewFeast(FeastId.GoodFriday, lang))
		    result.Add(NewFeast(FeastId.EasterSunday, lang))
		    result.Add(NewFeast(FeastId.EasterMonday, lang))
		    result.Add(NewFeast(FeastId.Ascension, lang))
		    result.Add(NewFeast(FeastId.Pentecost, lang))
		    result.Add(NewFeast(FeastId.WhitMonday, lang))
		    
		  End Select
		  
		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Calculate(year as Integer) As DateAndCaption
		  Var d As DateTime = DateValue(year)
		  if d = nil then Return Nil
		  
		  Return New DateAndCaption(d, Me.mCaption)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Caption() As String
		  Return mCaption
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Caption(assigns s as string)
		  // Part of the AnnualEvent interface.
		  
		  mCaption = S
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(d as AnnualEvent)
		  If d = Nil Then 
		    Raise New NilObjectException
		    Exit Sub
		  End
		  
		  If Not (d IsA AnnualEventEaster) Then
		    Raise New InvalidArgumentException
		    Exit Sub
		  End
		  
		  
		  Var copy As AnnualEventEaster = d.DefinitionObject
		  
		  
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
		Sub Constructor(copy as AnnualEventEaster)
		  me.DayOffset = copy.DayOffset
		  
		  Me.mCaption = Copy.Caption
		  Me.DayOff = copy.DayOff
		  Me.CycleFirstYear = Copy.CycleFirstYear
		  me.CycleYearDuration = Copy.CycleYearDuration
		  me.Tag = copy.Tag
		  me.DbId = copy.DbId
		  Me.StartOfValidity = copy.StartOfValidity
		  Me.EndOfValidity = copy.EndOfValidity
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(lDayOffset As Integer, language As FeastLanguage)
		  Me.DayOffset = lDayOffset
		  
		  Me.StartOfValidity = New DateTime(1,1,1,0,0,0)
		  Me.EndOfValidity = New DateTime(3999,12,31,23,59,59)
		  
		  Var id As FeastId
		  
		  If FeastIdFromShift(lDayOffset, id) Then
		    mCaption = NewFeast(id, language).Caption
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(lCaption As String = "", lDayOffset As Integer = 0)
		  mCaption = lCaption
		  Self.DayOffset = lDayOffset
		  
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
		  If year < 1 Then 
		    Break
		    Return Nil
		  End
		  
		  If Me.CycleYearDuration > 1 Then
		    If Me.CycleFirstYear > year Then Return Nil
		    If (year - Me.CycleFirstYear) Mod Me.CycleYearDuration > 0 Then Return Nil
		  End
		  
		  
		  If year < Me.StartOfValidity.Year Or year > Me.EndOfValidity.Year Then Return Nil
		  
		  Var value As DateTime = EasterDate(year)
		  
		  value = value.AddInterval(0, 0, me.DayOffset)
		  
		  If value < Me.StartOfValidity Or value > Me.EndOfValidity Then Return Nil
		  
		  Return value
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
		Shared Function EasterDate(year As Integer) As DateTime
		  // Calcul de la date de Pâques (calendrier grégorien, catholique)
		  // Algorithme de Meeus/Jones/Butcher
		  Var a As Integer = year Mod 19
		  Var b As Integer = year \ 100
		  Var c As Integer = year Mod 100
		  Var d As Integer = b \ 4
		  Var e As Integer = b Mod 4
		  Var f As Integer = (b + 8) \ 25
		  Var g As Integer = (b - f + 1) \ 3
		  Var h As Integer = (19 * a + b - d - g + 15) Mod 30
		  Var i As Integer = c \ 4
		  Var k As Integer = c Mod 4
		  Var l As Integer = (32 + 2 * e + 2 * i - h - k) Mod 7
		  Var m As Integer = (a + 11 * h + 22 * l) \ 451
		  Var n As Integer = h + l - 7 * m + 114
		  
		  Var theMonth As Integer = n \ 31
		  Var theDay As Integer = (n Mod 31) + 1
		  
		  Return New DateTime(year, theMonth, theDay, 0, 0, 0)
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

	#tag Method, Flags = &h21
		Private Shared Function FeastIdFromShift(shift As Integer, ByRef id As FeastId) As Boolean
		  // Retrouve la fête correspondant à un décalage. Renvoie False si aucune ne correspond.
		  // Quand plusieurs fêtes ont le même décalage, on retient le nom principal :
		  // ShroveTuesday (-47), LaetareSunday (-21) et DivineMercySunday (+7).
		  Select Case shift
		  Case ShroveTuesday
		    id = FeastId.ShroveTuesday
		  Case AshWednesday
		    id = FeastId.AshWednesday
		  Case LaetareSunday
		    id = FeastId.LaetareSunday
		  Case PassionSunday
		    id = FeastId.PassionSunday
		  Case PalmSunday
		    id = FeastId.PalmSunday
		  Case MaundyThursday
		    id = FeastId.MaundyThursday
		  Case GoodFriday
		    id = FeastId.GoodFriday
		  Case HolySaturday
		    id = FeastId.HolySaturday
		  Case EasterSunday
		    id = FeastId.EasterSunday
		  Case EasterMonday
		    id = FeastId.EasterMonday
		  Case DivineMercySunday
		    id = FeastId.DivineMercySunday
		  Case Ascension
		    id = FeastId.Ascension
		  Case Pentecost
		    id = FeastId.Pentecost
		  Case WhitMonday
		    id = FeastId.WhitMonday
		  Case TrinitySunday
		    id = FeastId.TrinitySunday
		  Case CorpusChristi, CorpusChristiSunday
		    id = FeastId.CorpusChristi
		  Case SacredHeart
		    id = FeastId.SacredHeart
		  Case ImmaculateHeart
		    id = FeastId.ImmaculateHeart
		  Case Else
		    Return False
		  End Select
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FingerPrint() As string
		  Var s As String
		  
		  s = "E|"
		  
		  s = s + Me.StartOfValidity.SQLDate + "|"
		  s = s + Me.EndOfValidity.SQLDate + "|"
		  s = s + Me.CycleFirstYear.ToString(Locale.Raw) + "|"
		  s = s + Me.CycleYearDuration.ToString(Locale.Raw) + "|"
		  If Me.DayOff Then s = s + "1|" Else s = s + "0|"
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
		Function IsEventDate(d As DateTime) As Boolean
		  // True si d tombe le jour de Pâques (+/- Shift jours) de son année
		  If d Is Nil Then Return False
		  
		  Var target As DateTime = DateValue(d.Year)
		  if target = nil then Return False
		  
		  Return (d.Year = target.Year) And (d.Month = target.Month) And (d.Day = target.Day)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function NewFeast(id As FeastId, lang As FeastLanguage) As AnnualEventEaster
		  // Crée la fête : décalage + nom dans la langue demandée
		  // Ordre des noms : Anglais-Américain, Français, Allemand, Flamand belge, Espagnol
		  Var shiftValue As Integer
		  Var names() As String
		  
		  Select Case id
		  Case FeastId.ShroveTuesday
		    shiftValue = ShroveTuesday
		    names = Array("Shrove Tuesday", "Mardi gras", "Faschingsdienstag", "Vastenavond", "Martes de Carnaval")
		  Case FeastId.MardiGras
		    shiftValue = MardiGras
		    names = Array("Mardi Gras", "Mardi gras", "Faschingsdienstag", "Vastenavond", "Martes de Carnaval")
		  Case FeastId.AshWednesday
		    shiftValue = AshWednesday
		    names = Array("Ash Wednesday", "Mercredi des Cendres", "Aschermittwoch", "Aswoensdag", "Miércoles de Ceniza")
		  Case FeastId.LaetareSunday
		    shiftValue = LaetareSunday
		    names = Array("Laetare Sunday", "Dimanche de Laetare", "Laetare-Sonntag", "Laetare-zondag", "Domingo de Laetare")
		  Case FeastId.MotheringSunday
		    shiftValue = MotheringSunday
		    names = Array("Mothering Sunday", "Mothering Sunday", "Mothering Sunday", "Mothering Sunday", "Mothering Sunday")
		  Case FeastId.PassionSunday
		    shiftValue = PassionSunday
		    names = Array("Passion Sunday", "Dimanche de la Passion", "Passionssonntag", "Passiezondag", "Domingo de Pasión")
		  Case FeastId.PalmSunday
		    shiftValue = PalmSunday
		    names = Array("Palm Sunday", "Dimanche des Rameaux", "Palmsonntag", "Palmzondag", "Domingo de Ramos")
		  Case FeastId.MaundyThursday
		    shiftValue = MaundyThursday
		    names = Array("Maundy Thursday", "Jeudi saint", "Gründonnerstag", "Witte Donderdag", "Jueves Santo")
		  Case FeastId.GoodFriday
		    shiftValue = GoodFriday
		    names = Array("Good Friday", "Vendredi saint", "Karfreitag", "Goede Vrijdag", "Viernes Santo")
		  Case FeastId.HolySaturday
		    shiftValue = HolySaturday
		    names = Array("Holy Saturday", "Samedi saint", "Karsamstag", "Stille Zaterdag", "Sábado Santo")
		  Case FeastId.EasterSunday
		    shiftValue = EasterSunday
		    names = Array("Easter Sunday", "Dimanche de Pâques", "Ostersonntag", "Paaszondag", "Domingo de Pascua")
		  Case FeastId.EasterMonday
		    shiftValue = EasterMonday
		    names = Array("Easter Monday", "Lundi de Pâques", "Ostermontag", "Paasmaandag", "Lunes de Pascua")
		  Case FeastId.DivineMercySunday
		    shiftValue = DivineMercySunday
		    names = Array("Divine Mercy Sunday", "Dimanche de la Divine Miséricorde", "Barmherzigkeitssonntag", "Zondag van de Goddelijke Barmhartigheid", "Domingo de la Divina Misericordia")
		  Case FeastId.Ascension
		    shiftValue = Ascension
		    names = Array("Ascension Day", "Ascension", "Christi Himmelfahrt", "Onze-Lieve-Heer-Hemelvaart", "Ascensión del Señor")
		  Case FeastId.Pentecost
		    shiftValue = Pentecost
		    names = Array("Pentecost", "Pentecôte", "Pfingstsonntag", "Pinksteren", "Pentecostés")
		  Case FeastId.WhitMonday
		    shiftValue = WhitMonday
		    names = Array("Whit Monday", "Lundi de Pentecôte", "Pfingstmontag", "Pinkstermaandag", "Lunes de Pentecostés")
		  Case FeastId.TrinitySunday
		    shiftValue = TrinitySunday
		    names = Array("Trinity Sunday", "Fête de la Sainte Trinité", "Dreifaltigkeitssonntag", "Heilige Drievuldigheid", "Domingo de la Santísima Trinidad")
		  Case FeastId.CorpusChristi
		    shiftValue = CorpusChristi
		    names = Array("Corpus Christi", "Fête-Dieu", "Fronleichnam", "Sacramentsdag", "Corpus Christi")
		  Case FeastId.SacredHeart
		    shiftValue = SacredHeart
		    names = Array("Sacred Heart", "Sacré-Cœur", "Herz-Jesu-Fest", "Heilig Hart", "Sagrado Corazón de Jesús")
		  Case FeastId.ImmaculateHeart
		    shiftValue = ImmaculateHeart
		    names = Array("Immaculate Heart of Mary", "Cœur immaculé de Marie", "Unbeflecktes Herz Mariä", "Onbevlekt Hart van Maria", "Inmaculado Corazón de María")
		  End Select
		  
		  Return New AnnualEventEaster(names(CType(lang, Integer)), shiftValue)
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
		  Var s As String
		  
		  s = "E|"
		  s = s + EncodeBase64(Me.Caption,0) + "|"
		  s = s + Me.StartOfValidity.SQLDate + "|"
		  s = s + Me.EndOfValidity.SQLDate + "|"
		  s = s + Me.CycleFirstYear.ToString(Locale.Raw) + "|"
		  s = s + Me.CycleYearDuration.ToString(Locale.Raw) + "|"
		  If Me.DayOff Then s = s + "1|" Else s = s + "0|"
		  s = s + Me.DayOffset.ToString(Locale.Raw) 
		  
		  Return s
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		DayOffset As Integer
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
		Private mEndOfValidity As DateTime
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStartOfValidity As DateTime
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTag As Variant
	#tag EndProperty


	#tag Constant, Name = Ascension, Type = Integer, Dynamic = False, Default = \"39", Scope = Public
	#tag EndConstant

	#tag Constant, Name = AshWednesday, Type = Integer, Dynamic = False, Default = \"-46", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CorpusChristi, Type = Integer, Dynamic = False, Default = \"60", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CorpusChristiSunday, Type = Integer, Dynamic = False, Default = \"63", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DivineMercySunday, Type = Integer, Dynamic = False, Default = \"7", Scope = Public
	#tag EndConstant

	#tag Constant, Name = EasterMonday, Type = Integer, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = EasterSunday, Type = Integer, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = GoodFriday, Type = Integer, Dynamic = False, Default = \"-2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = HolySaturday, Type = Integer, Dynamic = False, Default = \"-1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ImmaculateHeart, Type = Integer, Dynamic = False, Default = \"69", Scope = Public
	#tag EndConstant

	#tag Constant, Name = LaetareSunday, Type = Integer, Dynamic = False, Default = \"-21", Scope = Public
	#tag EndConstant

	#tag Constant, Name = MardiGras, Type = Integer, Dynamic = False, Default = \"-47", Scope = Public
	#tag EndConstant

	#tag Constant, Name = MaundyThursday, Type = Integer, Dynamic = False, Default = \"-3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = MotheringSunday, Type = Integer, Dynamic = False, Default = \"-21", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PalmSunday, Type = Integer, Dynamic = False, Default = \"-7", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PassionSunday, Type = Integer, Dynamic = False, Default = \"-14", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Pentecost, Type = Integer, Dynamic = False, Default = \"49", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Quasimodo, Type = Integer, Dynamic = False, Default = \"7", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ResurrectionSunday, Type = Double, Dynamic = False, Default = \"0", Scope = Public
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"0"
	#tag EndConstant

	#tag Constant, Name = SacredHeart, Type = Integer, Dynamic = False, Default = \"68", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ShroveMonday, Type = Double, Dynamic = False, Default = \"-48", Scope = Public
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"-48"
	#tag EndConstant

	#tag Constant, Name = ShroveTuesday, Type = Integer, Dynamic = False, Default = \"-47", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TrinitySunday, Type = Integer, Dynamic = False, Default = \"56", Scope = Public
	#tag EndConstant

	#tag Constant, Name = WhitMonday, Type = Integer, Dynamic = False, Default = \"50", Scope = Public
	#tag EndConstant


	#tag Enum, Name = Denomination, Type = Integer, Flags = &h0
		Catholic
		  Anglican
		  Lutheran
		Calvinist
	#tag EndEnum

	#tag Enum, Name = FeastId, Type = Integer, Flags = &h21
		ShroveTuesday
		  MardiGras
		  AshWednesday
		  LaetareSunday
		  MotheringSunday
		  PassionSunday
		  PalmSunday
		  MaundyThursday
		  GoodFriday
		  HolySaturday
		  EasterSunday
		  EasterMonday
		  DivineMercySunday
		  Ascension
		  Pentecost
		  WhitMonday
		  TrinitySunday
		  CorpusChristi
		  SacredHeart
		ImmaculateHeart
	#tag EndEnum

	#tag Enum, Name = FeastLanguage, Type = Integer, Flags = &h0
		AmericanEnglish
		  French
		  German
		  BelgianFlemish
		Spanish
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
			Name="DayOffset"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
