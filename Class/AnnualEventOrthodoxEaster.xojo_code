#tag Class
Protected Class AnnualEventOrthodoxEaster
Implements AnnualEvent
	#tag Method, Flags = &h0
		Shared Function AllFeasts(cult As Denomination, lang As FeastLanguage) As AnnualEventOrthodoxEaster()
		  // Renvoie les fêtes mobiles célébrées par le culte donné,
		  // avec leur nom (Caption) dans la langue choisie
		  Var result() As AnnualEventOrthodoxEaster
		  
		  Select Case cult
		  Case Denomination.EasternOrthodox
		    
		    result.Add(NewFeast(FeastId.PublicanAndPhariseeSunday, lang))
		    result.Add(NewFeast(FeastId.ProdigalSonSunday, lang))
		    result.Add(NewFeast(FeastId.MeatfareSunday, lang))
		    result.Add(NewFeast(FeastId.CheesefareSunday, lang))
		    result.Add(NewFeast(FeastId.CleanMonday, lang))
		    result.Add(NewFeast(FeastId.SundayOfOrthodoxy, lang))
		    result.Add(NewFeast(FeastId.SundayOfTheCross, lang))
		    result.Add(NewFeast(FeastId.LazarusSaturday, lang))
		    result.Add(NewFeast(FeastId.PalmSunday, lang))
		    result.Add(NewFeast(FeastId.HolyMonday, lang))
		    result.Add(NewFeast(FeastId.HolyTuesday, lang))
		    result.Add(NewFeast(FeastId.HolyWednesday, lang))
		    result.Add(NewFeast(FeastId.HolyThursday, lang))
		    result.Add(NewFeast(FeastId.GoodFriday, lang))
		    result.Add(NewFeast(FeastId.HolySaturday, lang))
		    result.Add(NewFeast(FeastId.Pascha, lang))
		    result.Add(NewFeast(FeastId.BrightMonday, lang))
		    result.Add(NewFeast(FeastId.ThomasSunday, lang))
		    result.Add(NewFeast(FeastId.MyrrhBearersSunday, lang))
		    result.Add(NewFeast(FeastId.MidPentecost, lang))
		    result.Add(NewFeast(FeastId.Ascension, lang))
		    result.Add(NewFeast(FeastId.Pentecost, lang))
		    result.Add(NewFeast(FeastId.HolySpiritMonday, lang))
		    result.Add(NewFeast(FeastId.AllSaintsSunday, lang))
		    
		  Case Denomination.SlavicOrthodox
		    
		    result.Add(NewFeast(FeastId.PublicanAndPhariseeSunday, lang))
		    result.Add(NewFeast(FeastId.ProdigalSonSunday, lang))
		    result.Add(NewFeast(FeastId.MeatfareSunday, lang))
		    result.Add(NewFeast(FeastId.CheesefareSunday, lang))
		    result.Add(NewFeast(FeastId.CleanMonday, lang))
		    result.Add(NewFeast(FeastId.SundayOfOrthodoxy, lang))
		    result.Add(NewFeast(FeastId.SundayOfTheCross, lang))
		    result.Add(NewFeast(FeastId.LazarusSaturday, lang))
		    result.Add(NewFeast(FeastId.PalmSunday, lang))
		    result.Add(NewFeast(FeastId.HolyMonday, lang))
		    result.Add(NewFeast(FeastId.HolyTuesday, lang))
		    result.Add(NewFeast(FeastId.HolyWednesday, lang))
		    result.Add(NewFeast(FeastId.HolyThursday, lang))
		    result.Add(NewFeast(FeastId.GoodFriday, lang))
		    result.Add(NewFeast(FeastId.HolySaturday, lang))
		    result.Add(NewFeast(FeastId.Pascha, lang))
		    result.Add(NewFeast(FeastId.BrightMonday, lang))
		    result.Add(NewFeast(FeastId.ThomasSunday, lang))
		    result.Add(NewFeast(FeastId.Radonitsa, lang))
		    result.Add(NewFeast(FeastId.MyrrhBearersSunday, lang))
		    result.Add(NewFeast(FeastId.MidPentecost, lang))
		    result.Add(NewFeast(FeastId.Ascension, lang))
		    result.Add(NewFeast(FeastId.Pentecost, lang))
		    result.Add(NewFeast(FeastId.HolySpiritMonday, lang))
		    result.Add(NewFeast(FeastId.AllSaintsSunday, lang))
		  End Select
		  
		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Calculate(Year as integer) As DateAndCaption
		  // Part of the AnnualEvent interface.
		  Var d As DateTime = DateValue(year)
		  
		  If d = Nil Then Return Nil
		  
		  Return new DateAndCaption(d, me.mCaption)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Caption() As String
		  Return mCaption
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Caption(Assigns s As String)
		  mCaption = s
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(d as AnnualEvent)
		  If d = Nil Then 
		    Raise New NilObjectException
		    Exit Sub
		  End
		  
		  If Not (d IsA AnnualEventOrthodoxEaster) Then
		    Raise New InvalidArgumentException
		    Exit Sub
		  End
		  
		  
		  Var vo As AnnualEventOrthodoxEaster = d.DefinitionObject
		  
		  Me.mCaption = vo.Caption
		  Me.DayOff = vo.DayOff
		  Me.CycleFirstYear = vo.CycleFirstYear
		  Me.CycleYearDuration = vo.CycleYearDuration
		  Me.Tag = vo.Tag
		  Me.DbId = vo.DbId
		  Me.StartOfValidity = vo.StartOfValidity
		  Me.EndOfValidity = vo.EndOfValidity
		  
		  
		  
		  Me.DayOffset = vo.DayOffset
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(copy as AnnualEventOrthodoxEaster)
		  Me.mCaption = Copy.Caption
		  Me.DayOff = copy.DayOff
		  Me.CycleFirstYear = Copy.CycleFirstYear
		  Me.CycleYearDuration = Copy.CycleYearDuration
		  Me.Tag = copy.Tag
		  Me.DbId = copy.DbId
		  Me.StartOfValidity = copy.StartOfValidity
		  Me.EndOfValidity = copy.EndOfValidity
		  
		  
		  Me.DayOffset = copy.DayOffset
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(lDayOffset As Integer, language As FeastLanguage)
		  // Le Caption est déduit du décalage et de la langue
		  // Si aucune fête connue ne correspond au décalage, le Caption reste vide
		  Self.DayOffset = lDayOffset
		  
		  Var id As FeastId
		  If FeastIdFromShift(lDayOffset, id) Then
		    mCaption = NewFeast(id, language).Caption
		  End If
		  
		  Me.StartOfValidity = New DateTime(1,1,1,0,0,0)
		  Me.EndOfValidity = New DateTime(3999,12,31,23,59,59)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(lCaption As String = "", lDayOffset As Integer = 0)
		  // Les paramètres ont le même nom que les propriétés : on utilise Self pour Shift
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
		  // Date de Pâques orthodoxe (calendrier grégorien) de l'année donnée,
		  // décalée de Shift jours, à 00h00
		  
		  
		  If year < 1 Then 
		    Break
		    Return Nil
		  End
		  
		  If Me.CycleYearDuration > 1 Then
		    If Me.CycleFirstYear > year Then Return Nil
		    If (year - Me.CycleFirstYear) Mod Me.CycleYearDuration > 0 Then Return Nil
		  End
		  
		  
		  If year < Me.StartOfValidity.Year Or year > Me.EndOfValidity.Year Then Return Nil
		  
		  Var d As DateTime = AnnualEventOrthodoxEaster.EasterDate(year)
		  
		  d =  d.AddInterval(0, 0, Me.DayOffset)
		  
		  If d < Me.StartOfValidity Or d > Me.EndOfValidity Then Return Nil
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
		  // Pâques orthodoxe exprimée dans le calendrier grégorien.
		  // 1) Calcul de la date julienne (algorithme de Meeus)
		  Var a As Integer = year Mod 4
		  Var b As Integer = year Mod 7
		  Var c As Integer = year Mod 19
		  Var d As Integer = (19 * c + 15) Mod 30
		  Var e As Integer = (2 * a + 4 * b - d + 34) Mod 7
		  Var n As Integer = d + e + 114
		  
		  Var julianMonth As Integer = n \ 31
		  Var julianDay As Integer = (n Mod 31) + 1
		  
		  // 2) Conversion julien -> grégorien : écart de 13 jours de 1900 à 2099 (14 en 2100...)
		  Var gap As Integer = (year \ 100) - (year \ 400) - 2
		  
		  Var dt As DateTime = New DateTime(year, julianMonth, julianDay, 0, 0, 0)
		  Return dt.AddInterval(0, 0, gap)
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
		  Select Case shift
		  Case PublicanAndPhariseeSunday
		    id = FeastId.PublicanAndPhariseeSunday
		  Case ProdigalSonSunday
		    id = FeastId.ProdigalSonSunday
		  Case MeatfareSunday
		    id = FeastId.MeatfareSunday
		  Case CheesefareSunday
		    id = FeastId.CheesefareSunday
		  Case CleanMonday
		    id = FeastId.CleanMonday
		  Case SundayOfOrthodoxy
		    id = FeastId.SundayOfOrthodoxy
		  Case SundayOfTheCross
		    id = FeastId.SundayOfTheCross
		  Case LazarusSaturday
		    id = FeastId.LazarusSaturday
		  Case PalmSunday
		    id = FeastId.PalmSunday
		  Case HolyMonday
		    id = FeastId.HolyMonday
		  Case HolyTuesday
		    id = FeastId.HolyTuesday
		  Case HolyWednesday
		    id = FeastId.HolyWednesday
		  Case HolyThursday
		    id = FeastId.HolyThursday
		  Case GoodFriday
		    id = FeastId.GoodFriday
		  Case HolySaturday
		    id = FeastId.HolySaturday
		  Case Pascha
		    id = FeastId.Pascha
		  Case BrightMonday
		    id = FeastId.BrightMonday
		  Case ThomasSunday
		    id = FeastId.ThomasSunday
		  Case Radonitsa
		    id = FeastId.Radonitsa
		  Case MyrrhBearersSunday
		    id = FeastId.MyrrhBearersSunday
		  Case MidPentecost
		    id = FeastId.MidPentecost
		  Case Ascension
		    id = FeastId.Ascension
		  Case Pentecost
		    id = FeastId.Pentecost
		  Case HolySpiritMonday
		    id = FeastId.HolySpiritMonday
		  Case AllSaintsSunday
		    id = FeastId.AllSaintsSunday
		  Case Else
		    Return False
		  End Select
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FingerPrint() As String
		  Var s as String
		  
		  s = "O|"
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
		  // True si d tombe le jour de Pâques orthodoxe (+/- Shift jours) de son année
		  If d Is Nil Then Return False
		  
		  If d.year < 1 Then 
		    Break
		    Return False
		  End
		  
		  If d < Me.StartOfValidity Or d > Me.EndOfValidity Then Return False
		  
		  If Me.CycleYearDuration > 1 Then
		    If Me.CycleFirstYear > d. year Then Return false
		    If (d.year - Me.CycleFirstYear) Mod Me.CycleYearDuration > 0 Then Return False
		  End
		  
		  Var dt As DateTime = DateValue(d.Year)
		  
		  Return (dt.Year = d.Year) And (d.Month = dt.Month) And (d.Day = dt.Day)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function NewFeast(id As FeastId, lang As FeastLanguage) As AnnualEventOrthodoxEaster
		  // Crée la fête : décalage + nom dans la langue demandée
		  // Ordre des noms : Anglais-Américain, Français, Allemand, Flamand belge, Espagnol, Russe, Grec
		  Var shiftValue As Integer
		  Var names() As String
		  
		  Select Case id
		  Case FeastId.PublicanAndPhariseeSunday
		    shiftValue = PublicanAndPhariseeSunday
		    names = Array("Sunday of the Publican and the Pharisee", "Dimanche du Publicain et du Pharisien", "Sonntag des Zöllners und des Pharisäers", "Zondag van de tollenaar en de farizeeër", "Domingo del Publicano y el Fariseo", "Неделя о мытаре и фарисее", "Κυριακή του Τελώνου και του Φαρισαίου")
		  Case FeastId.ProdigalSonSunday
		    shiftValue = ProdigalSonSunday
		    names = Array("Sunday of the Prodigal Son", "Dimanche du Fils prodigue", "Sonntag des verlorenen Sohnes", "Zondag van de verloren zoon", "Domingo del Hijo Pródigo", "Неделя о блудном сыне", "Κυριακή του Ασώτου")
		  Case FeastId.MeatfareSunday
		    shiftValue = MeatfareSunday
		    names = Array("Meatfare Sunday", "Dimanche de la Viande", "Sonntag vom Jüngsten Gericht", "Zondag van het Laatste Oordeel", "Domingo del Juicio Final", "Неделя о Страшном суде", "Κυριακή της Απόκρεω")
		  Case FeastId.CheesefareSunday
		    shiftValue = CheesefareSunday
		    names = Array("Cheesefare Sunday", "Dimanche du Pardon", "Sonntag der Vergebung", "Vergevingszondag", "Domingo del Perdón", "Прощёное воскресенье", "Κυριακή της Τυροφάγου")
		  Case FeastId.CleanMonday
		    shiftValue = CleanMonday
		    names = Array("Clean Monday", "Lundi pur", "Reiner Montag", "Reine Maandag", "Lunes Limpio", "Чистый понедельник", "Καθαρά Δευτέρα")
		  Case FeastId.SundayOfOrthodoxy
		    shiftValue = SundayOfOrthodoxy
		    names = Array("Sunday of Orthodoxy", "Dimanche de l'Orthodoxie", "Sonntag der Orthodoxie", "Zondag van de Orthodoxie", "Domingo de la Ortodoxia", "Неделя Торжества Православия", "Κυριακή της Ορθοδοξίας")
		  Case FeastId.SundayOfTheCross
		    shiftValue = SundayOfTheCross
		    names = Array("Sunday of the Veneration of the Cross", "Dimanche de la Vénération de la Croix", "Sonntag der Kreuzverehrung", "Zondag van de Kruisverering", "Domingo de la Veneración de la Cruz", "Крестопоклонная неделя", "Κυριακή της Σταυροπροσκυνήσεως")
		  Case FeastId.LazarusSaturday
		    shiftValue = LazarusSaturday
		    names = Array("Lazarus Saturday", "Samedi de Lazare", "Lazarus-Samstag", "Lazaruszaterdag", "Sábado de Lázaro", "Лазарева суббота", "Σάββατο του Λαζάρου")
		  Case FeastId.PalmSunday
		    shiftValue = PalmSunday
		    names = Array("Palm Sunday", "Dimanche des Rameaux", "Palmsonntag", "Palmzondag", "Domingo de Ramos", "Вербное воскресенье", "Κυριακή των Βαΐων")
		  Case FeastId.HolyMonday
		    shiftValue = HolyMonday
		    names = Array("Holy Monday", "Lundi saint", "Karmontag", "Heilige Maandag", "Lunes Santo", "Великий понедельник", "Μεγάλη Δευτέρα")
		  Case FeastId.HolyTuesday
		    shiftValue = HolyTuesday
		    names = Array("Holy Tuesday", "Mardi saint", "Kardienstag", "Heilige Dinsdag", "Martes Santo", "Великий вторник", "Μεγάλη Τρίτη")
		  Case FeastId.HolyWednesday
		    shiftValue = HolyWednesday
		    names = Array("Holy Wednesday", "Mercredi saint", "Karmittwoch", "Heilige Woensdag", "Miércoles Santo", "Великая среда", "Μεγάλη Τετάρτη")
		  Case FeastId.HolyThursday
		    shiftValue = HolyThursday
		    names = Array("Holy Thursday", "Jeudi saint", "Gründonnerstag", "Witte Donderdag", "Jueves Santo", "Великий четверг", "Μεγάλη Πέμπτη")
		  Case FeastId.GoodFriday
		    shiftValue = GoodFriday
		    names = Array("Good Friday", "Vendredi saint", "Karfreitag", "Goede Vrijdag", "Viernes Santo", "Великая пятница", "Μεγάλη Παρασκευή")
		  Case FeastId.HolySaturday
		    shiftValue = HolySaturday
		    names = Array("Holy Saturday", "Samedi saint", "Karsamstag", "Paaszaterdag", "Sábado Santo", "Великая суббота", "Μεγάλο Σάββατο")
		  Case FeastId.Pascha
		    shiftValue = Pascha
		    names = Array("Orthodox Easter", "Pâques orthodoxe", "Orthodoxes Osterfest", "Orthodox Pasen", "Pascua ortodoxa", "Пасха", "Πάσχα")
		  Case FeastId.BrightMonday
		    shiftValue = BrightMonday
		    names = Array("Bright Monday", "Lundi de Pâques", "Ostermontag", "Paasmaandag", "Lunes de Pascua", "Светлый понедельник", "Δευτέρα του Πάσχα")
		  Case FeastId.ThomasSunday
		    shiftValue = ThomasSunday
		    names = Array("Thomas Sunday", "Dimanche de Thomas", "Thomassonntag", "Thomaszondag", "Domingo de Tomás", "Антипасха (Неделя апостола Фомы)", "Κυριακή του Θωμά")
		  Case FeastId.Radonitsa
		    shiftValue = Radonitsa
		    names = Array("Radonitsa", "Radonitsa", "Radonitsa", "Radonitsa", "Radonitsa", "Радоница", "Ραδονίτσα")
		  Case FeastId.MyrrhBearersSunday
		    shiftValue = MyrrhBearersSunday
		    names = Array("Sunday of the Myrrh-Bearers", "Dimanche des Myrophores", "Sonntag der Myronträgerinnen", "Zondag van de Myrondraagsters", "Domingo de las Mujeres Miróforas", "Неделя святых жён-мироносиц", "Κυριακή των Μυροφόρων")
		  Case FeastId.MidPentecost
		    shiftValue = MidPentecost
		    names = Array("Mid-Pentecost", "Mi-Pentecôte", "Mittpfingsten", "Middenpinksteren", "Mediapentecostés", "Преполовение Пятидесятницы", "Μεσοπεντηκοστή")
		  Case FeastId.Ascension
		    shiftValue = Ascension
		    names = Array("Ascension Day", "Ascension", "Christi Himmelfahrt", "Onze-Lieve-Heer-Hemelvaart", "Ascensión del Señor", "Вознесение Господне", "Ανάληψη του Χριστού")
		  Case FeastId.Pentecost
		    shiftValue = Pentecost
		    names = Array("Pentecost", "Pentecôte", "Pfingstsonntag", "Pinksteren", "Pentecostés", "День Святой Троицы", "Πεντηκοστή")
		  Case FeastId.HolySpiritMonday
		    shiftValue = HolySpiritMonday
		    names = Array("Day of the Holy Spirit", "Lundi du Saint-Esprit", "Pfingstmontag", "Pinkstermaandag", "Lunes del Espíritu Santo", "День Святого Духа", "Δευτέρα του Αγίου Πνεύματος")
		  Case FeastId.AllSaintsSunday
		    shiftValue = AllSaintsSunday
		    names = Array("Sunday of All Saints", "Dimanche de tous les saints", "Sonntag aller Heiligen", "Zondag van Allerheiligen", "Domingo de Todos los Santos", "Неделя всех святых", "Κυριακή των Αγίων Πάντων")
		  End Select
		  
		  Return New AnnualEventOrthodoxEaster(names(CType(lang, Integer)), shiftValue)
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
		  
		  s = "O|"
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
		Private mDayOff As Boolean
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


	#tag Constant, Name = AllSaintsSunday, Type = Integer, Dynamic = False, Default = \"56", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Ascension, Type = Integer, Dynamic = False, Default = \"39", Scope = Public
	#tag EndConstant

	#tag Constant, Name = BrightMonday, Type = Integer, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CheesefareSunday, Type = Integer, Dynamic = False, Default = \"-49", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CleanMonday, Type = Integer, Dynamic = False, Default = \"-48", Scope = Public
	#tag EndConstant

	#tag Constant, Name = GoodFriday, Type = Integer, Dynamic = False, Default = \"-2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = HolyMonday, Type = Integer, Dynamic = False, Default = \"-6", Scope = Public
	#tag EndConstant

	#tag Constant, Name = HolySaturday, Type = Integer, Dynamic = False, Default = \"-1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = HolySpiritMonday, Type = Integer, Dynamic = False, Default = \"50", Scope = Public
	#tag EndConstant

	#tag Constant, Name = HolyThursday, Type = Integer, Dynamic = False, Default = \"-3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = HolyTuesday, Type = Integer, Dynamic = False, Default = \"-5", Scope = Public
	#tag EndConstant

	#tag Constant, Name = HolyWednesday, Type = Integer, Dynamic = False, Default = \"-4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = LazarusSaturday, Type = Integer, Dynamic = False, Default = \"-8", Scope = Public
	#tag EndConstant

	#tag Constant, Name = MeatfareSunday, Type = Integer, Dynamic = False, Default = \"-56", Scope = Public
	#tag EndConstant

	#tag Constant, Name = MidPentecost, Type = Integer, Dynamic = False, Default = \"24", Scope = Public
	#tag EndConstant

	#tag Constant, Name = MyrrhBearersSunday, Type = Integer, Dynamic = False, Default = \"14", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PalmSunday, Type = Integer, Dynamic = False, Default = \"-7", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Pascha, Type = Integer, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Pentecost, Type = Integer, Dynamic = False, Default = \"49", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ProdigalSonSunday, Type = Integer, Dynamic = False, Default = \"-63", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PublicanAndPhariseeSunday, Type = Integer, Dynamic = False, Default = \"-70", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Radonitsa, Type = Integer, Dynamic = False, Default = \"9", Scope = Public
	#tag EndConstant

	#tag Constant, Name = SundayOfOrthodoxy, Type = Integer, Dynamic = False, Default = \"-42", Scope = Public
	#tag EndConstant

	#tag Constant, Name = SundayOfTheCross, Type = Integer, Dynamic = False, Default = \"-28", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ThomasSunday, Type = Integer, Dynamic = False, Default = \"7", Scope = Public
	#tag EndConstant


	#tag Enum, Name = Denomination, Type = Integer, Flags = &h0
		EasternOrthodox
		SlavicOrthodox
	#tag EndEnum

	#tag Enum, Name = FeastId, Type = Integer, Flags = &h21
		PublicanAndPhariseeSunday
		  ProdigalSonSunday
		  MeatfareSunday
		  CheesefareSunday
		  CleanMonday
		  SundayOfOrthodoxy
		  SundayOfTheCross
		  LazarusSaturday
		  PalmSunday
		  HolyMonday
		  HolyTuesday
		  HolyWednesday
		  HolyThursday
		  GoodFriday
		  HolySaturday
		  Pascha
		  BrightMonday
		  ThomasSunday
		  Radonitsa
		  MyrrhBearersSunday
		  MidPentecost
		  Ascension
		  Pentecost
		  HolySpiritMonday
		AllSaintsSunday
	#tag EndEnum

	#tag Enum, Name = FeastLanguage, Type = Integer, Flags = &h0
		AmericanEnglish
		  French
		  German
		  BelgianFlemish
		  Spanish
		  Russian
		Greek
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
