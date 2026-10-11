#tag Class
Protected Class WorkCalendar
	#tag Method, Flags = &h0
		Sub AddAnnualEvents(d() as AnnualEvent, NoDuplicates as Boolean = False)
		  If d.Count = 0 Then Exit Sub
		  
		  // Create a dictionnary to speed up duplicate searches
		  
		  Var dic As New Dictionary, dicCaption as new Dictionary
		  
		  If NoDuplicates Then 
		    
		    // Filling the dictionary with existing values
		    
		    If Me.AnnualEvents.Count > 0 Then
		      
		      For i As Integer = 0 To Me.AnnualEvents.LastIndex
		        dic.value(me.AnnualEvents(i).FingerPrint) = i
		        dicCaption.Value(me.AnnualEvents(i).Caption.Lowercase) = i
		      Next
		      
		    End If
		    
		  end
		  
		  For i As Integer = 0 To d.LastIndex
		    
		    if NoDuplicates then
		      If Not dic.Lookup(d(i).FingerPrint, "clear") = "clear" Then Continue // Already exist ! Skip this definition
		      If Not dicCaption.Lookup(d(i).Caption.Lowercase, "clear") = "clear" Then Continue // Already exist ! Skip this definition
		    end
		    
		    me.AnnualEvents.Add d(i)
		    
		    // Adding the new value in the dictionary
		    If NoDuplicates Then 
		      dic.value(Me.AnnualEvents(Me.AnnualEvents.LastIndex).FingerPrint) = Me.AnnualEvents.LastIndex
		      dicCaption.value(Me.AnnualEvents(Me.AnnualEvents.LastIndex).Caption.Lowercase) = Me.AnnualEvents.LastIndex
		    end
		  next
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddAnnualEvents(NewEvent as AnnualEvent, NoDuplicates as Boolean = False)
		  // Create a dictionnary to speed up duplicate searches
		  
		  if me.AnnualEvents.Count > 0 and NoDuplicates then
		    
		    Var dic As New Dictionary
		    
		    // Filling the dictionary with existing values
		    
		    If Me.AnnualEvents.Count > 0 Then
		      
		      For i As Integer = 0 To Me.AnnualEvents.LastIndex
		        dic.value(me.AnnualEvents(i).FingerPrint) = i
		      Next
		      
		    End If
		    
		    If Not dic.Lookup(NewEvent.FingerPrint, "clear") = "clear" Then exit sub // Already exist ! Skip this definition
		  end
		  
		  me.AnnualEvents.Add NewEvent
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub AddInArray(d() as DateAndCaption, valeur as DateAndCaption)
		  If d.LastIndex = -1 Then
		    d.Add valeur
		    Exit Sub
		  End
		  
		  If valeur.DateValue >= d(d.LastIndex).DateValue Then
		    d.Add valeur
		    Exit Sub
		  End
		  
		  For i As Integer = 0 To d.LastIndex
		    
		    If valeur.DateValue <= d(i).DateValue Then
		      d.AddAt(i, valeur)
		      Exit Sub
		    End
		    
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub AddInArray(d() as DateTime, valeur as DateTime)
		  If d.LastIndex = -1 Then
		    d.Add valeur
		    Exit Sub
		  End
		  
		  If valeur >= d(d.LastIndex) Then
		    d.Add valeur
		    Exit Sub
		  End
		  
		  For i As Integer = 0 To d.LastIndex
		    
		    If valeur <= d(i) Then
		      d.AddAt(i, valeur)
		      Exit Sub
		    End
		    
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function AffectedClosurePeriods(FirstDay as DateTime, LastDay as DateTime) As ClosurePeriod()
		  Var cp() As ClosurePeriod // Copy the relevant items ClosurePeriod
		  
		  Var fd As DateTime
		  var ld as DateTime
		  
		  If FirstDay <= LastDay Then
		    fd = New DateTime(FirstDay)
		    ld = New DateTime(LastDay)
		  else
		    ld = New DateTime(FirstDay)
		    fd = New DateTime(LastDay)
		  end
		  
		  If Me.ClosurePeriods.Count > 0 Then
		    
		    For c As Integer = 0 To Me.ClosurePeriods.LastIndex
		      
		      If fd <= ClosurePeriods(c).LastDay And ld >= ClosurePeriods(c).FirstDay Then cp.Add ClosurePeriods(c)
		      
		    Next
		    
		  End
		  
		  Return cp
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function AnnualEventsBelgium(Region as Belgium = Belgium.NationauxEnFrancais, PublicService as Boolean = True) As AnnualEvent()
		  Var df() As AnnualEvent
		  
		  // I use Belgium so as not to offend any Belgian language community.
		  
		  Select Case Region
		    
		  Case Belgium.NationauxEnFrancais
		    
		    df.Add New AnnualEventFixed("Premier janvier", 1, 1)
		    df.Add New AnnualEventFixed("Fête du travail", 5, 1)
		    df.Add New AnnualEventFixed("Fête Nationale", 7, 21)
		    df.Add New AnnualEventFixed("Assomption", 8, 15)
		    
		    df.Add New AnnualEventFixed("Toussaint", 11, 1)
		    df.Add New AnnualEventFixed("Armistice 1918", 11, 11)
		    
		    df.Add New AnnualEventFixed("Noël", 12, 25)
		    df.Add New AnnualEventEaster("Lundi de Pâques", 1)
		    df.Add New AnnualEventEaster("Ascension", 39)
		    df.Add New AnnualEventEaster("Lundi de Pentecôte", 50)
		    
		  case Belgium.NationaleDagenInDeVlaamseTaal
		    
		    df.Add New AnnualEventFixed("Nieuwjaarsdag", 1, 1) 
		    df.Add New AnnualEventFixed("Feest van de Arbeid", 5, 1)
		    df.Add New AnnualEventFixed("Feest van de Vlaamse Gemeenschap", 7, 11)
		    df.Add New AnnualEventFixed("Nationale Feestdag", 7, 21)
		    df.Add New AnnualEventFixed("Onze-Lieve-Vrouw Hemelvaart", 8, 15)
		    
		    df.Add New AnnualEventFixed("Allerheiligen", 11, 1)
		    df.Add New AnnualEventFixed("Wapenstilstand", 11, 11)
		    
		    df.Add New AnnualEventFixed("Kerstmis", 12, 25)
		    
		    df.Add New AnnualEventEaster("Paasmaandag", 1)
		    df.Add New AnnualEventEaster("Onze-Lieve-Heer Hemelvaart", 39)
		    df.Add New AnnualEventEaster("Pinkstermaandag", 50)
		    
		  case Belgium.NationalfeiertageAufDeutsch
		    
		    df.Add New AnnualEventFixed("Neujahr", 1, 1)
		    df.Add New AnnualEventFixed("Tag der Arbeit", 5, 1)
		    df.Add New AnnualEventFixed("Nationalfeiertag", 7, 21)
		    df.Add New AnnualEventFixed("Mariä Himmelfahrt", 8, 15)
		    
		    df.Add New AnnualEventFixed("Allerheiligen", 11, 1)
		    df.Add New AnnualEventFixed("Waffenstillstand", 11, 11)
		    
		    df.Add New AnnualEventFixed("Weihnachten", 12, 25)
		    df.Add New AnnualEventEaster("Ostermontag", 1)
		    df.Add New AnnualEventEaster("Christi Himmelfahrt", 39)
		    df.Add New AnnualEventEaster("Pfingstmontag", 50)
		    
		  Case Belgium.BruxellesCapitale
		    
		    // https://www.talent.brussels/fr/fonctionnaires/jours-feries-la-region-bruxelloise
		    
		    df.Add New AnnualEventFixed("Premier janvier", 1, 1)
		    df.Add New AnnualEventFixed("Fête du travail", 5, 1)
		    df.Add New AnnualEventFixed("Fête Nationale", 7, 21)
		    df.Add New AnnualEventFixed("Assomption", 8, 15)
		    
		    df.Add New AnnualEventFixed("Toussaint", 11, 1)
		    df.Add New AnnualEventFixed("Armistice 1918", 11, 11)
		    df.Add New AnnualEventFixed("Noël", 12, 25)
		    
		    df.Add New AnnualEventEaster("Lundi de Pâques", 1)
		    df.Add New AnnualEventEaster("Ascension", 39)
		    df.Add New AnnualEventEaster("Lundi de Pentecôte", 50)
		    
		    
		    if PublicService then
		      df.Add New AnnualEventFixed("Fête de l'Iris", 5, 8)
		      df.Add New AnnualEventFixed("Fête de la Fédération Wallonie-Bruxelles", 9,27)
		      df.Add New AnnualEventFixed("Fête des morts", 11, 2)
		      df.Add New AnnualEventFixed("Jour de la Dynastie", 11, 15)
		      df.Add New AnnualEventFixed("Deuxième jour de Noël", 12, 26)
		    end
		    
		  Case Belgium.vlaanderen
		    
		    // https://www.vlaanderen.be/intern/personeel/verloven-en-afwezigheden/feestdagen
		    
		    df.Add New AnnualEventFixed("Nieuwjaarsdag", 1, 1) 
		    df.Add New AnnualEventFixed("Feest van de Arbeid", 5, 1)
		    df.Add New AnnualEventFixed("Feest van de Vlaamse Gemeenschap", 7, 11)
		    df.Add New AnnualEventFixed("Nationale Feestdag", 7, 21)
		    df.Add New AnnualEventFixed("Onze-Lieve-Vrouw Hemelvaart", 8, 15)
		    
		    df.Add New AnnualEventFixed("Allerheiligen", 11, 1)
		    df.Add New AnnualEventFixed("Wapenstilstand", 11, 11)
		    
		    df.Add New AnnualEventFixed("Kerstmis", 12, 25)
		    
		    df.Add New AnnualEventEaster("Paasmaandag", 1)
		    df.Add New AnnualEventEaster("Onze-Lieve-Heer Hemelvaart", 39)
		    df.Add New AnnualEventEaster("Pinkstermaandag", 50)
		    
		    If PublicService Then
		      df.Add New AnnualEventFixed("Allerzielen", 11, 2)
		      df.Add New AnnualEventFixed("Koningsdag", 11, 15)
		      df.Add New AnnualEventFixed("Tweede kerstdag", 12, 26)
		    End
		    
		    
		  Case Belgium.Wallonie
		    
		    df.Add New AnnualEventFixed("Premier janvier", 1, 1)
		    df.Add New AnnualEventFixed("Fête du travail", 5, 1)
		    df.Add New AnnualEventFixed("Fête Nationale", 7, 21)
		    df.Add New AnnualEventFixed("Assomption", 8, 15)
		    
		    df.Add New AnnualEventFixed("Toussaint", 11, 1)
		    df.Add New AnnualEventFixed("Armistice 1918", 11, 11)
		    df.Add New AnnualEventFixed("Noël", 12, 25)
		    
		    df.Add New AnnualEventEaster("Lundi de Pâques", 1)
		    df.Add New AnnualEventEaster("Ascension", 39)
		    df.Add New AnnualEventEaster("Lundi de Pentecôte", 50)
		    
		    
		    If PublicService Then
		      df.Add New AnnualEventFixed("Fête de la Fédération Wallonie-Bruxelles", 9,27)
		      
		      df.Add New AnnualEventFixed("Fête des morts", 11, 2)
		      df.Add New AnnualEventFixed("Jour de la Dynastie", 11, 15)
		      df.Add New AnnualEventFixed("Deuxième jour de Noël", 12, 26)
		    end
		    
		    
		    df.Add new AnnualEventWeekDay("Fête de la Région wallonne", 9, 1, 3) // 3ème dimanche de septembre
		    df(df.LastIndex).DayOff = False
		    
		  case Belgium.DeutschsprachigeGemeinschaft
		    
		    // https://de.wikipedia.org/wiki/Deutschsprachige_Gemeinschaft
		    
		    df.Add New AnnualEventFixed("Neujahr", 1, 1)
		    df.Add New AnnualEventFixed("Tag der Arbeit", 5, 1)
		    df.Add New AnnualEventFixed("Nationalfeiertag", 7, 21)
		    df.Add New AnnualEventFixed("Mariä Himmelfahrt", 8, 15)
		    
		    df.Add New AnnualEventFixed("Allerheiligen", 11, 1)
		    df.Add New AnnualEventFixed("Waffenstillstand", 11, 11)
		    
		    df.Add New AnnualEventFixed("Weihnachten", 12, 25)
		    df.Add New AnnualEventEaster("Ostermontag", 1)
		    df.Add New AnnualEventEaster("Christi Himmelfahrt", 39)
		    df.Add New AnnualEventEaster("Pfingstmontag", 50)
		    
		    df.Add New AnnualEventFixed("Tag der Deutschsprachigen Gemeinschaft", 11, 15)
		    
		  End
		  
		  Return df
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function AnnualEventsFrance(Region as France = France.General) As AnnualEvent()
		  Var df() As AnnualEvent
		  
		  
		  Select Case region
		    
		  Case France.General
		    
		    df.Add New AnnualEventFixed("Jour de l'an", 1, 1)
		    df.Add New AnnualEventFixed("Fête du travail", 5, 1)
		    df.Add New AnnualEventFixed("Victoire 1945", 5, 8)
		    df.Add New AnnualEventFixed("Fête Nationale", 7, 14)
		    df.Add New AnnualEventFixed("Assomption", 8, 15)
		    df.Add New AnnualEventFixed("Toussaint", 11, 1)
		    df.Add New AnnualEventFixed("Armistice 1918", 11, 11)
		    df.Add New AnnualEventFixed("Noël", 12, 25)
		    
		    df.Add New AnnualEventEaster("Lundi de Pâques", 1)
		    df.Add New AnnualEventEaster("Ascension", 39)
		    df.Add New AnnualEventEaster("Lundi de Pentecôte", 50)
		    
		  Case France.Guadeloupe
		    
		    df.Add New AnnualEventFixed("Jour de l'an", 1, 1)
		    df.Add New AnnualEventFixed("Fête du travail", 5, 1)
		    df.Add New AnnualEventFixed("Victoire 1945", 5, 8)
		    df.Add New AnnualEventFixed("Fête Nationale", 7, 14)
		    df.Add New AnnualEventFixed("Assomption", 8, 15)
		    df.Add New AnnualEventFixed("Toussaint", 11, 1)
		    df.Add New AnnualEventFixed("Armistice 1918", 11, 11)
		    df.Add New AnnualEventFixed("Noël", 12, 25)
		    
		    df.Add New AnnualEventEaster("Lundi de Pâques", 1)
		    df.Add New AnnualEventEaster("Ascension", 39)
		    df.Add New AnnualEventEaster("Lundi de Pentecôte", 50)
		    
		    df.Add New AnnualEventFixed("Abolition de l'esclavage", 05, 27)
		    
		  case France.SaintMartin
		    
		    df.Add New AnnualEventFixed("Jour de l'an", 1, 1)
		    df.Add New AnnualEventFixed("Fête du travail", 5, 1)
		    df.Add New AnnualEventFixed("Victoire 1945", 5, 8)
		    df.Add New AnnualEventFixed("Fête Nationale", 7, 14)
		    df.Add New AnnualEventFixed("Assomption", 8, 15)
		    df.Add New AnnualEventFixed("Toussaint", 11, 1)
		    df.Add New AnnualEventFixed("Armistice 1918", 11, 11)
		    df.Add New AnnualEventFixed("Noël", 12, 25)
		    
		    df.Add New AnnualEventEaster("Lundi de Pâques", 1)
		    df.Add New AnnualEventEaster("Ascension", 39)
		    df.Add New AnnualEventEaster("Lundi de Pentecôte", 50)
		    
		    df.Add New AnnualEventFixed("Abolition de l'esclavage", 05, 27)
		    
		  Case France.AlsaceMoselle
		    
		    df.Add New AnnualEventFixed("Jour de l'an", 1, 1)
		    df.Add New AnnualEventFixed("Fête du travail", 5, 1)
		    df.Add New AnnualEventFixed("Victoire 1945", 5, 8)
		    df.Add New AnnualEventFixed("Fête Nationale", 7, 14)
		    df.Add New AnnualEventFixed("Assomption", 8, 15)
		    df.Add New AnnualEventFixed("Toussaint", 11, 1)
		    df.Add New AnnualEventFixed("Armistice 1918", 11, 11)
		    df.Add New AnnualEventFixed("Noël", 12, 25)
		    
		    df.Add New AnnualEventEaster("Lundi de Pâques", 1)
		    df.Add New AnnualEventEaster("Ascension", 39)
		    df.Add New AnnualEventEaster("Lundi de Pentecôte", 50)
		    
		    
		    df.Add New AnnualEventEaster("Vendredi Saint", -2)
		    df.Add New AnnualEventFixed("Lendemain Noël - St Étienne", 12, 26)
		    
		  Case France.Martinique
		    
		    df.Add New AnnualEventFixed("Jour de l'an", 1, 1)
		    df.Add New AnnualEventFixed("Fête du travail", 5, 1)
		    df.Add New AnnualEventFixed("Victoire 1945", 5, 8)
		    df.Add New AnnualEventFixed("Fête Nationale", 7, 14)
		    df.Add New AnnualEventFixed("Assomption", 8, 15)
		    df.Add New AnnualEventFixed("Toussaint", 11, 1)
		    df.Add New AnnualEventFixed("Armistice 1918", 11, 11)
		    df.Add New AnnualEventFixed("Noël", 12, 25)
		    
		    df.Add New AnnualEventEaster("Lundi de Pâques", 1)
		    df.Add New AnnualEventEaster("Ascension", 39)
		    df.Add New AnnualEventEaster("Lundi de Pentecôte", 50)
		    
		    df.Add New AnnualEventFixed("Abolition de l'esclavage", 05, 22)
		    
		  Case France.Guyane
		    
		    df.Add New AnnualEventFixed("Jour de l'an", 1, 1)
		    df.Add New AnnualEventFixed("Fête du travail", 5, 1)
		    df.Add New AnnualEventFixed("Victoire 1945", 5, 8)
		    df.Add New AnnualEventFixed("Fête Nationale", 7, 14)
		    df.Add New AnnualEventFixed("Assomption", 8, 15)
		    df.Add New AnnualEventFixed("Toussaint", 11, 1)
		    df.Add New AnnualEventFixed("Armistice 1918", 11, 11)
		    df.Add New AnnualEventFixed("Noël", 12, 25)
		    
		    df.Add New AnnualEventEaster("Lundi de Pâques", 1)
		    df.Add New AnnualEventEaster("Ascension", 39)
		    df.Add New AnnualEventEaster("Lundi de Pentecôte", 50)
		    
		    df.Add New AnnualEventFixed("Abolition de l'esclavage", 06, 10)
		    
		  Case France.Reunion
		    
		    df.Add New AnnualEventFixed("Jour de l'an", 1, 1)
		    df.Add New AnnualEventFixed("Fête du travail", 5, 1)
		    df.Add New AnnualEventFixed("Victoire 1945", 5, 8)
		    df.Add New AnnualEventFixed("Fête Nationale", 7, 14)
		    df.Add New AnnualEventFixed("Assomption", 8, 15)
		    df.Add New AnnualEventFixed("Toussaint", 11, 1)
		    df.Add New AnnualEventFixed("Armistice 1918", 11, 11)
		    df.Add New AnnualEventFixed("Noël", 12, 25)
		    
		    df.Add New AnnualEventEaster("Lundi de Pâques", 1)
		    df.Add New AnnualEventEaster("Ascension", 39)
		    df.Add New AnnualEventEaster("Lundi de Pentecôte", 50)
		    
		    df.Add New AnnualEventFixed("Abolition de l'esclavage", 12, 20)
		    
		  Case France.Mayotte
		    
		    df.Add New AnnualEventFixed("Jour de l'an", 1, 1)
		    df.Add New AnnualEventFixed("Fête du travail", 5, 1)
		    df.Add New AnnualEventFixed("Victoire 1945", 5, 8)
		    df.Add New AnnualEventFixed("Fête Nationale", 7, 14)
		    df.Add New AnnualEventFixed("Assomption", 8, 15)
		    df.Add New AnnualEventFixed("Toussaint", 11, 1)
		    df.Add New AnnualEventFixed("Armistice 1918", 11, 11)
		    df.Add New AnnualEventFixed("Noël", 12, 25)
		    
		    df.Add New AnnualEventEaster("Lundi de Pâques", 1)
		    df.Add New AnnualEventEaster("Ascension", 39)
		    df.Add New AnnualEventEaster("Lundi de Pentecôte", 50)
		    
		    
		    df.Add New AnnualEventFixed("Abolition de l'esclavage", 04, 27)
		    
		  Case France.SaintBarthelemy
		    
		    df.Add New AnnualEventFixed("Jour de l'an", 1, 1)
		    df.Add New AnnualEventFixed("Fête du travail", 5, 1)
		    df.Add New AnnualEventFixed("Victoire 1945", 5, 8)
		    df.Add New AnnualEventFixed("Fête Nationale", 7, 14)
		    df.Add New AnnualEventFixed("Assomption", 8, 15)
		    df.Add New AnnualEventFixed("Toussaint", 11, 1)
		    df.Add New AnnualEventFixed("Armistice 1918", 11, 11)
		    df.Add New AnnualEventFixed("Noël", 12, 25)
		    
		    df.Add New AnnualEventEaster("Lundi de Pâques", 1)
		    df.Add New AnnualEventEaster("Ascension", 39)
		    df.Add New AnnualEventEaster("Lundi de Pentecôte", 50)
		    
		    df.Add New AnnualEventFixed("Abolition de l'esclavage", 10, 9)
		    
		  End
		  
		  Return df
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function AnnualEventsFromRowSet(rs as RowSet, Identifier as Variant = Nil, Encoding as TextEncoding = Nil, ValueColumn as string = "value", RegionColumn as string = "region", IdColumn as string = "id_event") As AnnualEvent()
		  // if Encoding = nil, using UTF8
		  
		  Var EventsArray() as AnnualEvent
		  Var region as String
		  
		  Var id As String
		  if Identifier = nil Then id = "" else id = Identifier.StringValue.Lowercase.Trim
		  
		  If rs = Nil Then Return EventsArray
		  
		  if Encoding = Nil then Encoding = Encodings.UTF8
		  
		  Do Until rs.AfterLastRow
		    
		    
		    If  Encoding = Encodings.UTF8 Then 
		      
		      region = rs.Column(RegionColumn).StringValue.DefineEncoding(Encodings.UTF8)
		      
		    else // No action UTF8
		      
		      region = rs.Column(RegionColumn).StringValue.DefineEncoding(Encoding).ConvertEncoding(Encodings.UTF8).DefineEncoding(Encodings.UTF8)
		      
		    end
		    
		    If region.trim.Lowercase <> id Then 
		      rs.MoveToNextRow
		      Continue Do
		    End
		    
		    If Encoding = Encodings.UTF8 Then
		      
		      EventsArray.Add AnnualEventFixed.FromString(rs.Column(ValueColumn).StringValue.DefineEncoding(Encodings.UTF8))
		      EventsArray(EventsArray.LastIndex).DbId = rs.Column(IdColumn).Int64Value
		      
		    Else // No action
		      
		      EventsArray.Add AnnualEventFixed.FromString(rs.Column(ValueColumn.DefineEncoding(Encoding)).StringValue.DefineEncoding(Encoding).ConvertEncoding(Encodings.UTF8).DefineEncoding(Encodings.UTF8))
		      EventsArray(EventsArray.LastIndex).DbId = rs.Column(IdColumn.DefineEncoding(Encoding)).Int64Value
		      
		    end
		    
		    rs.MoveToNextRow
		    
		  Loop
		  
		  Return EventsArray
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function AnnualEventsIsrael() As AnnualEvent()
		  Var df() As AnnualEvent
		  
		  df.add New AnnualEventHebraic(AnnualEventHebraic.HolidayType.PassoverFirstDay, AnnualEventHebraic.DisplayLanguage.ModernHebrew)
		  df.add New AnnualEventHebraic(AnnualEventHebraic.HolidayType.PassoverSeventhDay, AnnualEventHebraic.DisplayLanguage.ModernHebrew)
		  df.add New AnnualEventHebraic(AnnualEventHebraic.HolidayType.YomHaatzmaut_ApplyCivilShift, AnnualEventHebraic.DisplayLanguage.ModernHebrew)
		  df.add New AnnualEventHebraic(AnnualEventHebraic.HolidayType.Shavuot, AnnualEventHebraic.DisplayLanguage.ModernHebrew)
		  df.add New AnnualEventHebraic(AnnualEventHebraic.HolidayType.RoshHashanah, AnnualEventHebraic.DisplayLanguage.ModernHebrew)
		  df.add New AnnualEventHebraic(AnnualEventHebraic.HolidayType.YomKippur, AnnualEventHebraic.DisplayLanguage.ModernHebrew)
		  df.add New AnnualEventHebraic(AnnualEventHebraic.HolidayType.SukkotFirstDay, AnnualEventHebraic.DisplayLanguage.ModernHebrew)
		  df.add New AnnualEventHebraic(AnnualEventHebraic.HolidayType.SimchatTorah_Israel, AnnualEventHebraic.DisplayLanguage.ModernHebrew)
		  
		  Return df
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function AnnualEventsUSA(State as USA = USA.Federal) As AnnualEvent()
		  Var List() As AnnualEvent
		  
		  Select Case state
		    
		  Case usa.Federal
		    
		    // https://www.opm.gov/policy-data-oversight/pay-leave/federal-holidays/#url=Overview
		    
		    // The change from Sunday to Monday, or from Saturday to Friday, 
		    // was announced on the official website.
		    
		    List.Add New AnnualEventFixed("New Year's Day", 1, 1,  True, True) // January, 1st
		    List.Add New AnnualEventFixed("Juneteenth National Independence Day", 6,19,  True, True) // June, 19
		    List.Add New AnnualEventFixed("Independence Day", 7,4,  True, True) // July, 4
		    List.Add New AnnualEventFixed("Christmas",12,25,  True, True) // December, 25
		    List.Add New AnnualEventFixed("Veterans Day", 11,11,  True, True) // November, 11
		    
		    
		    list.Add New AnnualEventWeekDay("Birthday of Martin Luther King, Jr.", 1,2,3) // January, Monday, The Third
		    list.Add New AnnualEventWeekDay("Washington's Birthday", 2,2,3) // Frebruary, Monday, The Third
		    List.Add New AnnualEventWeekDay("Memorial Day", 5, 2, 6) // May, the last monday
		    List.Add New AnnualEventWeekDay("Labor Day",9, 2, 1) // September, the first monday
		    List.Add New AnnualEventWeekDay("Columbus Day",10, 2, 2) // October, the second monday
		    List.Add New AnnualEventWeekDay("Thanksgiving",11, 5, 4) // November, the 4th thursday
		    
		  Case usa.Alabama // Alabama
		    
		    // https://personnel.alabama.gov/Downloads/StateHolidays.pdf
		    // https://admincode.legislature.state.al.us/administrative-code/670-X-12-.01
		    // No mention of a schedule change from Sunday to Monday, or from Saturday to Friday, 
		    // was found on this website (or I couldn't find it). 
		    
		    List.Add New AnnualEventFixed("New Year's Day", 1, 1) // January, 1st
		    List.Add New AnnualEventWeekDay("Martin Luther King Day & Robert E. Lee’s Birthday",1,2,3)' Januray, third monday
		    List.Add new AnnualEventEaster("Mardi gras", -47)
		    List.Add New AnnualEventWeekDay("George Washington & Thomas Jefferson’s Birthday", 2, 2, 3) // February, the third monday
		    List.Add New AnnualEventWeekDay("Confederate Memorial Day",4,2,4) // April, the fourth monday
		    List.Add New AnnualEventWeekDay("National Memorial Day",5,2,6) // May, the last monday
		    List.Add New AnnualEventWeekDay("Jefferson Davis birthday",6,2,1) // June, the first monday
		    List.Add New AnnualEventFixed("Independence Day", 7,4) // July, 4
		    List.Add New AnnualEventWeekDay("Labor Day",9, 2, 1) // September, the first monday
		    list.Add New AnnualEventWeekDay("Columbus Day & Fraternal Day & American Indian Heritage Day",10,2,2) // October, the second monday
		    List.Add New AnnualEventFixed("Veterans Day", 11,11,  True, True) // November, 11
		    List.Add New AnnualEventWeekDay("Thanksgiving",11, 5, 4) // November, the 4th thursday
		    List.Add New AnnualEventFixed("Christmas",12,25) // December, 25
		    
		  Case USA.Alaska // Alaska
		    
		    // https://library.alaska.gov/akholidays.html
		    // No mention of a schedule change from Sunday to Monday, or from Saturday to Friday, 
		    // was found on this website (or I couldn't find it). 
		    
		    list.Add New AnnualEventWeekDay("President's day", 2,2,3) // Frebruary, Monday, The Third
		    list.Add New AnnualEventWeekDay("Seward Day",3,2,6) // March, the last monday
		    List.Add New AnnualEventWeekDay("Memorial Day", 5, 2, 6) // May, the last monday
		    List.Add New AnnualEventWeekDay("Labor Day",9, 2, 1) // September, the first monday
		    List.Add New AnnualEventWeekDay("Thanksgiving",11, 5, 4) // November, the 4th thursday
		    
		    List.Add New AnnualEventFixed("New Year's Day", 1, 1) // January, 1st
		    List.Add New AnnualEventFixed("Independence Day", 7,4) // July, 4
		    List.Add New AnnualEventFixed("Alaska day",10,18) // October, 18
		    List.Add New AnnualEventFixed("Veterans Day", 11,11) // November, 
		    List.Add New AnnualEventFixed("Christmas",12,25) // December, 25
		    
		  Case usa.Arkansas // Arkansas
		    
		    // https://law.justia.com/codes/arkansas/title-1/chapter-5/section-1-5-101/
		    // https://arkleg.state.ar.us/Home/FTPDocument?path=%2FACTS%2F2001%2FPublic%2FACT304.pdf
		    // https://arkleg.state.ar.us/Home/FTPDocument?path=%2FACTS%2F2017R%2FPublic%2FACT561.pdf
		    
		    // The change from Sunday to Monday, or from Saturday to Friday, 
		    // was announced in the law.
		    
		    list.Add New AnnualEventWeekDay("Dr. Martin Luther King Jr.'s Birthday", 1,2,3) // January, Monday, The Third
		    list.Add New AnnualEventWeekDay("Washington's Birthday and Daisy Gatson Bates Day", 2,2,3) // Frebruary, Monday, The Third
		    List.Add New AnnualEventWeekDay("Memorial Day", 5, 2, 6) // May, the last monday
		    List.Add New AnnualEventWeekDay("Labor Day",9, 2, 1) // September, the first monday
		    List.Add New AnnualEventWeekDay("Thanksgiving",11, 5, 4) // November, the 4th thursday
		    
		    
		    List.Add New AnnualEventFixed("New Year's Day", 1, 1, True, True) // January, 1st
		    List.Add New AnnualEventFixed("Independence Day", 7,4, True, True) // July, 4
		    List.Add New AnnualEventFixed("Veterans Day", 11,11, True, True) // November, 11
		    
		    List.Add New AnnualEventFixed("Christmas Eve",12,24, True, True) // December, 24
		    List.Add New AnnualEventFixed("Christmas",12,25, True, True) // December, 25
		    
		    
		  Case USA.Arizona // Arizona
		    // https://hr.az.gov/2024-holiday-calendar
		    // The change from Sunday to Monday, or from Saturday to Friday, 
		    // was announced on the this website.
		    
		    
		    List.Add New AnnualEventFixed("New Year's Day", 1, 1, True, True) // January, 1st
		    List.Add New AnnualEventFixed("Independence Day", 7,4, True, True) // July, 4
		    List.Add New AnnualEventFixed("Veterans Day", 11,11, True, True) // November, 11
		    List.Add New AnnualEventFixed("Christmas",12,25, True, True) // December, 25
		    
		    
		    
		    list.Add New AnnualEventWeekDay("Martin Luther King, Jr. / Civil Rights", 1,2,3) // January, Monday, The Third
		    list.Add New AnnualEventWeekDay("President's day", 2,2,3) // Frebruary, Monday, The Third
		    List.Add New AnnualEventWeekDay("Memorial Day", 5, 2, 6) // May, the last monday
		    List.Add New AnnualEventWeekDay("Labor Day",9, 2, 1) // September, the first monday
		    List.add New AnnualEventWeekDay("Columbus Day",10, 2, 2) // October, the second monday
		    List.Add New AnnualEventWeekDay("Thanksgiving",11, 5, 4) // November, the 4th thursday
		    
		    
		    
		  Case USA.California // California
		    
		    // https://www.sos.ca.gov/state-holidays
		    // No mention of a schedule change from Sunday to Monday, or from Saturday to Friday, 
		    // was found on this website (or I couldn't find it). 
		    
		    List.Add New AnnualEventFixed("New Year's Day", 1, 1, True, True) // January, 1st
		    List.Add New AnnualEventFixed("Independence Day", 7,4, True, True) // July, 4
		    List.Add New AnnualEventFixed("Veterans Day", 11,11, True, True) // November, 11
		    List.Add New AnnualEventFixed("Christmas",12,25, True, True) // December, 25
		    List.Add New AnnualEventFixed("Cesar Chavez Day",03,31) // October, 18
		    
		    
		    list.Add New AnnualEventWeekDay("Martin Luther King Jr. Day", 1,2,3) // January, Monday, The Third
		    list.Add New AnnualEventWeekDay("President's day", 2,2,3) // Frebruary, Monday, The Third
		    List.Add New AnnualEventWeekDay("Memorial Day", 5, 2, 6) // May, the last monday
		    List.Add New AnnualEventWeekDay("Labor Day",9, 2, 1)     // September, the first monday
		    List.Add New AnnualEventWeekDay("Thanksgiving",11, 5, 4) // November, the 4th thursday
		    
		    var dw as New AnnualEventWeekDay("Day after thanksgiving",11,5,4) // // November, the 4th thursday
		    dw.DayOffset = 1 // The day after... BlackFriday
		    List.Add dw
		    
		  Case USA.Colorado // Colorado
		    
		    // Colorado C.R.S. 24-11-101
		    // https://tax.colorado.gov/holidays
		    
		    List.Add New AnnualEventFixed("New Year's Day", 1, 1, False, True) // January, 1st
		    List.Add New AnnualEventFixed("Juneteenth National Independence Day", 6,19, False, True)
		    List.Add New AnnualEventFixed("Independence Day", 7,4, False, True) // July, 4
		    List.Add New AnnualEventFixed("Veterans Day", 11,11, False, True) // November, 11
		    List.Add New AnnualEventFixed("Christmas",12,25, False, True) // December, 25
		    
		    list.Add New AnnualEventWeekDay("Martin Luther King Jr. Day", 1,2,3) // January, Monday, The Third
		    list.Add New AnnualEventWeekDay("Washington-Lincoln day", 2,2,3) // Frebruary, Monday, The Third
		    List.Add New AnnualEventWeekDay("Memorial Day", 5, 2, 6) // May, the last monday
		    List.Add New AnnualEventWeekDay("Labor Day",9, 2, 1) // September, the first monday
		    list.Add New AnnualEventWeekDay("Frances Xavier Cabrini day", 10,2,1) // October, the first monday
		    List.Add New AnnualEventWeekDay("Thanksgiving",11, 5, 4) // November, the 4th thursday
		    
		  case usa.Connecticut // Connecticut
		    
		    // https://portal.ct.gov/about/legal-state-holidays
		    
		    List.Add New AnnualEventFixed("New Year's Day", 1, 1, True, True) // January, 1st
		    
		    Var df as New AnnualEventFixed("Martin Luther King Jr. Day", 1,15) // The first monday after the 15
		    df.DesiredWeekday = 2
		    df.DesiredWeekdayDirection =  AnnualEventFixed.WeekdayDirectionType.After
		    List.Add df
		    
		    List.Add New AnnualEventFixed("Lincoln's Birthday", 2, 12, True, True) // January, 1st
		    List.Add New AnnualEventFixed("Juneteenth", 6, 19, true, true)
		    List.Add New AnnualEventFixed("Independence Day", 7,4, True, True) // July, 4
		    List.Add New AnnualEventFixed("Veterans Day", 11,11, True, True) // November, 11
		    List.Add New AnnualEventFixed("Christmas",12,25, True, True) // December, 25
		    
		    list.Add New AnnualEventWeekDay("Washington's Birthday", 2,2,3) // Frebruary, Monday, The Third
		    List.Add New AnnualEventWeekDay("Memorial Day", 5, 2, 6) // May, the last monday
		    List.Add New AnnualEventWeekDay("Labor Day",9, 2, 1) // September, the first monday
		    List.Add New AnnualEventWeekDay("Columbus Day",10, 2, 2) // October, the second monday
		    List.Add New AnnualEventWeekDay("Thanksgiving",11, 5, 4) // November, the 4th thursday
		    
		  Case USA.Delaware // Delaware
		    
		    // https://delcode.delaware.gov/title1/c005/index.html
		    
		    List.Add New AnnualEventFixed("New Year's Day", 1, 1, True, True) // January, 1st
		    List.Add New AnnualEventFixed("Juneteenth", 6, 19, true, true)
		    List.Add New AnnualEventFixed("Independence Day", 7,4, True, True) // July, 4
		    List.Add New AnnualEventFixed("Veterans Day", 11,11, True, True) // November, 11
		    List.Add New AnnualEventFixed("Christmas",12,25, True, True) // December, 25
		    
		    list.Add new AnnualEventEaster("Good friday", AnnualEventEaster.GoodFriday)
		    
		    list.Add New AnnualEventWeekDay("Martin Luther King, Jr.", 1,2,3) // January, Monday, The Third
		    List.Add(New AnnualEventWeekDay("Memorial Day", 5, 2, AnnualEventWeekDay.kLast))
		    list.Add New AnnualEventWeekDay("Labor Day",9, 2, 1) // September, the first monday
		    List.Add New AnnualEventWeekDay("Thanksgiving",11, 5, 4) // November, the 4th thursday
		    Var dw As New AnnualEventWeekDay("Day after thanksgiving",11,5,4) // // November, the 4th thursday
		    dw.DayOffset = 1 // The day after...
		    List.Add dw
		    
		    // The general election takes place every two years, on the Tuesday after the first Monday of November
		    Var election As New AnnualEventWeekDay("General Election Day", 11, 2, 1)
		    election.DayOffset = 1
		    election.CycleFirstYear = 2000
		    election.CycleYearDuration = 2
		    list.Add(election) 
		    
		  case usa.DistrictOfColumbia
		    
		    // https://edpm.dc.gov/chapter/12/#section-1220
		    
		    Var df as New AnnualEventFixed("Inauguration Day", 1, 20, False, True)
		    df.CycleFirstYear = 1849
		    df.CycleYearDuration = 4
		    
		    List.add df
		    
		    List.Add New AnnualEventFixed("New Year's Day", 1, 1,  True, True) // January, 1st
		    List.Add New AnnualEventFixed("Independence Day", 7,4,  True, True) // July, 4
		    List.Add New AnnualEventFixed("Veterans Day", 11,11,  True, True) // November, 11
		    List.Add New AnnualEventFixed("Christmas",12,25,  True, True) // December, 25
		    
		    list.Add New AnnualEventWeekDay("Birthday of Martin Luther King, Jr.", 1,2,3) // January, Monday, The Third
		    list.Add New AnnualEventWeekDay("Washington's Birthday", 2,2,3) // Frebruary, Monday, The Third
		    List.Add New AnnualEventWeekDay("Memorial Day", 5, 2, 6) // May, the last monday
		    List.Add New AnnualEventWeekDay("Labor Day",9, 2, 1) // September, the first monday
		    List.Add New AnnualEventWeekDay("Columbus Day",10, 2, 2) // October, the second monday
		    List.Add New AnnualEventWeekDay("Thanksgiving",11, 5, 4) // November, the 4th thursday
		    
		  case usa.Florida 
		    
		    // https://www.leg.state.fl.us/statutes/index.cfm?App_mode=Display_Statute&URL=0600-0699/0683/Sections/0683.01.html
		    
		    List.Add New AnnualEventFixed("New Year's Day", 1, 1,  False, True) // January, 1st
		    List.Add New AnnualEventFixed("Birthday of Martin Luther King, Jr.", 1, 15,  False, True) // January, 15
		    List.Add New AnnualEventFixed("Birthday of Robert E. Lee", 1, 19,  False, True) // January, 19
		    List.Add New AnnualEventFixed("Lincoln's Birthday", 2, 12,  False, True) // February, 12
		    List.Add New AnnualEventFixed("Susan B. Anthony’s Birthday", 2, 15,  False, True) // February, 15
		    
		    list.Add New AnnualEventWeekDay("Washington's Birthday", 2,2,3) // Frebruary, Monday, The Third
		    list.Add New AnnualEventWeekDay("Tuskegee Airmen Commemoration Day", 3, 5, 4) // March, Thursday , The Fourth
		    
		    list.add new AnnualEventEaster("Good Friday", AnnualEventEaster.GoodFriday) // Good Friday
		    
		    List.Add New AnnualEventFixed("Pascua Florida Day", 4, 2,  False, True) // April, 2nd
		    List.Add New AnnualEventFixed("Confederate Memorial Day", 4, 26,  False, True) // April, 26
		    
		    list.Add New AnnualEventWeekDay("Memorial day", 5, 2, AnnualEventWeekDay.kLast) // May, Monday , The last
		    
		    List.Add New AnnualEventFixed("Birthday of Jefferson Davis", 6, 3,  False, True) // June, 3rd
		    List.Add New AnnualEventFixed("Flag Day", 6, 14,  False, True) // June, 14
		    
		    List.Add New AnnualEventFixed("Independence Day", 7,4,  True, True) // July, 4
		    
		    List.Add New AnnualEventWeekDay("Labor Day",9, 2, 1) // September, the first monday
		    List.Add New AnnualEventWeekDay("Columbus Day and Farmer's day",10, 2, 2) // October, the second monday
		    List.Add New AnnualEventFixed("Veterans' Day", 11,11,  True, True) // November, 11
		    List.Add New AnnualEventWeekDay("Thanksgiving",11, 5, 4) // November, the 4th thursday
		    
		    List.Add New AnnualEventFixed("Christmas",12,25,  True, True) // December, 25
		    
		    // Shrove Tuesday, sometimes also known as "Mardi Gras,"
		    // in counties where carnival associations are organized for the purpose of celebrating the same.
		    
		    'Case USA.Georgia 
		    
		    // In accordance With state law, Each year Georgia's governor announces which holidays will be observed by the state government
		    // Only federal holidays are predictable, and they are sometimes shifted.
		    
		    ''Case USA.Hawai
		    
		    //https://law.justia.com/codes/hawaii/title-1/chapter-8/section-8-1/
		    
		    'case usa.Idaho
		    
		    
		    
		  end Select
		  
		  
		  
		  Return List
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BusinessDayOffset(startdate as datetime, number as integer = 1, limit as integer = 366) As DateTime
		  // if number is 1, this means the immediately following business day. 
		  // If the number is 2, it means the second following business day, and so on.
		  // If you need to add 6 business days, then number = 6
		  
		  If startdate = Nil Then 
		    Raise New NilObjectException
		    Return Nil
		  End
		  
		  If number = 0 Then Return startdate // Trivial case
		  
		  // Duplicating the date and using a counter
		  Var dt As New DateTime(startdate.Year, startdate.Month, startdate.day, 0, 0, 0, 0, startdate.Timezone)
		  Var counter As Integer
		  Var dLimit As DateTime 
		  
		  If number > 0 Then
		    dLimit = dt.AddInterval(0,0,limit)
		  Else
		    dLimit = dt.SubtractInterval(0,0,limit)
		  End
		  
		  Do 
		    
		    If number > 0 And dt > dLimit Then Return Nil // Fail to find a day
		    If number < 0 And dt < dLimit Then Return Nil // Fail to find a day
		    
		    If number > 0 Then
		      dt = dt.AddInterval (0,0,1)
		    Else
		      dt = dt.SubtractInterval (0,0,1)
		    End
		    
		    //  Is this never a workday ?
		    if not me.WorkingWeek.WorkingDay(dt.DayOfWeek) then Continue do// Skip
		    
		    // Is this a Closure period ?
		    For i As Integer = 0 To Me.ClosurePeriods.LastIndex
		      If dt >= Me.ClosurePeriods(i).FirstDay And dt <= Me.ClosurePeriods(i).LastDay Then 
		        if number > 0 then
		          dt = New DateTime(Me.ClosurePeriods(i).LastDay.Year, Me.ClosurePeriods(i).LastDay.Month,  me.ClosurePeriods(i).LastDay.day, 0, 0, 0, 0, dt.Timezone) // Skip to the last day of the closure period
		        else
		          dt = New DateTime(Me.ClosurePeriods(i).FirstDay.Year, Me.ClosurePeriods(i).FirstDay.Month,  me.ClosurePeriods(i).FirstDay.day, 0, 0, 0, 0, dt.Timezone) // Skip to the last day of the closure period // Skip to the first day of the closure period
		        end
		        continue do // skip
		      end
		    Next
		    
		    // Is this a non-worked event ?
		    // This is the most time-consuming part to calculate, so it is calculated last only if necessary.
		    If Me.IsAnnualEvent(dt, True) Then Continue do // Skip
		    
		    counter = counter + 1
		    
		  Loop Until counter = abs(number)
		  
		  if counter < abs(number) then Return Nil
		  
		  Return dt
		  
		  
		  
		  
		  
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BusinessDays(starting as DateTime, ending as DateTime) As DateTime()
		  If starting = Nil Then 
		    Raise New NilObjectException
		    Return Nil
		  End
		  
		  If ending = Nil Then 
		    Raise New NilObjectException
		    Return Nil
		  End
		  
		  
		  Var list() As DateTime
		  Var nStart As New DateTime(starting.Year, starting.Month, starting.day,0,0,0,0, starting.Timezone)
		  Var nEnd As New DateTime(ending.Year, ending.Month, ending.day,0,0,0,0, ending.Timezone)
		  If nStart > nEnd Then Return list
		  
		  Var cp() as ClosurePeriod = me.AffectedClosurePeriods(nStart, nEnd) // Copy the relevant items ClosurePeriod
		  
		  
		  Var d As DateTime = nStart.SubtractInterval(0,0,1)
		  
		  Do Until d = nEnd
		    
		    d = d.AddInterval(0,0,1)
		    
		    //  Is this never a workday ?
		    if not me.WorkingWeek.WorkingDay(d.DayOfWeek) then Continue Do // Sufficient condition, no need to check anything else
		    
		    // Is this a Closure period ?
		    For i As Integer = 0 To cp.LastIndex
		      If d >= cp(i).FirstDay And d <= cp(i).LastDay Then Continue Do // Sufficient condition, no need to check anything else
		    Next
		    
		    // Is this a non-worked event ?
		    // This is the most time-consuming part to calculate, so it is calculated last only if necessary.
		    If IsAnnualEvent(d, true) Then Continue  Do
		    
		    list.Add New DateTime(d) // okay, we work
		    
		  Loop
		  
		  Return list
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BusinessDays(year as Integer) As DateTime()
		  Var d As New DateTime(year, 1, 1, 0, 0, 0)
		  Var f As New DateTime(year, 12, 31, 0, 0, 0)
		  
		  Return BusinessDays(d,f)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ClosurePeriodsFromRowSet(rs as RowSet, Identifier as variant = nil, Encoding as TextEncoding = Nil, ValueColumn as string = "value", RegionColumn as string = "region", IdColumn as string = "id_period") As ClosurePeriod()
		  Var cp() As ClosurePeriod
		  If rs = Nil Then Return cp // Empty array
		  If rs.AfterLastRow Then Return cp // Empty array
		  
		  Var id As String
		  if Identifier = nil Then id = "" else id = Identifier.StringValue.Lowercase.Trim
		  
		  Var region As String, value as string
		  
		  if Encoding = nil then Encoding = Encodings.UTF8
		  
		  Do Until rs.AfterLastRow
		    
		    If Encoding = Encodings.UTF8 Then
		      region = rs.Column(RegionColumn).StringValue.DefineEncoding(Encodings.UTF8).Lowercase.Trim
		      value = rs.Column(ValueColumn).StringValue.DefineEncoding(Encodings.UTF8)
		    Else
		      region = rs.Column(RegionColumn).StringValue.DefineEncoding(Encoding).ConvertEncoding(Encodings.UTF8).DefineEncoding(Encodings.UTF8).Lowercase.Trim
		      value = rs.Column(ValueColumn).StringValue.DefineEncoding(Encoding).ConvertEncoding(Encodings.UTF8).DefineEncoding(Encodings.UTF8)
		    End
		    
		    If region.Trim.Lowercase <> id Then 
		      rs.MoveToNextRow
		      Continue do
		    End
		    
		    cp.Add New ClosurePeriod(value)
		    cp(cp.LastIndex).DbId = rs.Column(IdColumn.DefineEncoding(Encoding)).Int64Value
		    
		    rs.MoveToNextRow
		  Loop
		  
		  Return cp
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  me.WorkingWeek = new wcWorkingWeekDays
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(lIdentifier as Variant)
		  Me.WorkingWeek = New wcWorkingWeekDays
		  me.Identifier  = lIdentifier
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(lIdentifier as Variant, lCaption as string)
		  Me.WorkingWeek = New wcWorkingWeekDays
		  me.Caption = lCaption
		  me.Identifier  = lIdentifier
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(copy as WorkCalendar, NewIdentifier as Variant = Nil, NewCaption as string = "")
		  Me.WorkingWeek = New wcWorkingWeekDays
		  
		  me.Identifier = NewIdentifier
		  Me.Caption = NewCaption
		  me.Enabled = copy.Enabled
		  
		  For i As Integer = 1 To 7
		    Me.WorkingWeek.WorkingDay(i) = copy.WorkingWeek.WorkingDay(i)
		  Next
		  
		  Var df As AnnualEventFixed
		  Var de As AnnualEventEaster
		  Var doe As AnnualEventOrthodoxEaster
		  Var dwd As AnnualEventWeekDay
		  Var dh as AnnualEventHebraic
		  
		  If copy.AnnualEvents.Count > 0 Then
		    
		    
		    For i As Integer = 0 To copy.AnnualEvents.LastIndex
		      
		      select case copy.AnnualEvents(i) 
		        
		      Case IsA AnnualEventFixed
		        
		        df = copy.AnnualEvents(i).DefinitionObject
		        me.AnnualEvents.Add new AnnualEventFixed(df)
		        
		      Case IsA AnnualEventEaster
		        
		        de =  copy.AnnualEvents(i).DefinitionObject
		        me.AnnualEvents.Add new AnnualEventEaster(de)
		        
		      Case IsA AnnualEventOrthodoxEaster
		        
		        doe =  copy.AnnualEvents(i).DefinitionObject
		        Me.AnnualEvents.Add New AnnualEventOrthodoxEaster(doe)
		        
		      Case IsA AnnualEventWeekDay
		        
		        dwd =  copy.AnnualEvents(i).DefinitionObject
		        Me.AnnualEvents.Add New AnnualEventWeekDay(dwd)
		        
		      case IsA AnnualEventHebraic
		        
		        dh = copy.AnnualEvents(i).DefinitionObject
		        Me.AnnualEvents.Add New AnnualEventHebraic(dwd)
		        
		      end
		      
		    Next i
		    
		  End If
		  
		  If copy.ClosurePeriods.Count > 0 Then
		    
		    For p As Integer = 0 To copy.ClosurePeriods.LastIndex
		      me.ClosurePeriods.Add new ClosurePeriod(copy.ClosurePeriods(p))
		    Next p
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CountBusinessDays(Date1 as datetime, Date2 as datetime) As Integer
		  // cas triviaux
		  
		  If Date1 = Nil Then 
		    Raise New NilObjectException
		    Return 0
		  End
		  
		  If date2 = Nil Then 
		    Raise New NilObjectException
		    Return 0
		  End
		  
		  If date1.day= date2.day _
		    And date1.Month = date2.Month _
		    And date1.Year = date2.Year Then 
		    
		    If IsWorkingDay(date1)  Then Return 1 Else Return 0
		    
		  End
		  
		  Var dtCurrent As DateTime, dtMax As DateTime, counter As Integer
		  
		  If date1 < Date2 Then
		    dtCurrent = New DateTime(Date1.Year, Date1.Month, date1.Day, 0, 0, 0, 0, Date1.Timezone)
		    dtMax = New DateTime(Date2.Year, Date2.Month, Date2.Day, 0, 0, 0, 0, Date2.Timezone)
		  else
		    dtCurrent =  New DateTime(Date2.Year, Date2.Month, Date2.Day, 0, 0, 0, 0, Date1.Timezone)
		    dtMax = New DateTime(Date1.Year, Date1.Month, Date1.Day, 0, 0, 0, 0, Date1.Timezone)
		  End
		  
		  Var cp() As ClosurePeriod  = AffectedClosurePeriods(dtCurrent, dtMax) // Copy the relevant items ClosurePeriod
		  
		  dtCurrent = dtCurrent.SubtractInterval(0,0,1)
		  
		  Do 
		    
		    dtCurrent = dtCurrent.AddInterval (0,0,1)
		    
		    //  Is this never a workday ?
		    If not me.WorkingWeek.WorkingDay(dtCurrent.DayOfWeek ) then Continue do
		    
		    // Is this a Closure period ?
		    For i As Integer = 0 To cp.LastIndex
		      If dtCurrent >= cp(i).FirstDay And dtCurrent <= cp(i).LastDay Then 
		        dtCurrent = new DateTime(cp(i).LastDay) // Skip to the last day of the closure period
		        Continue Do
		      end
		    Next
		    
		    // Is this a non-worked event ?
		    // This is the most time-consuming part to calculate, so it's calculated last, only if necessary.
		    If Me.IsAnnualEvent(dtCurrent, True) Then Continue
		    
		    counter = counter + 1
		    
		  loop until dtCurrent >= dtMax
		  
		  Return counter
		  
		  
		  
		  
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CountNonWorkingDays(Date1 as datetime, Date2 as datetime) As Integer
		  // cas triviaux
		  
		  If Date1 = Nil Then 
		    Raise New NilObjectException
		    Return -1
		  End
		  
		  If date2 = Nil Then 
		    Raise New NilObjectException
		    Return -1
		  End
		  
		  If date1.day= date2.day _
		    And date1.Month = date2.Month _
		    And date1.Year = date2.Year Then 
		    
		    if IsWorkingDay(date1) then Return 0 else return 1
		    
		  end
		  
		  Var dtCurrent As DateTime, dtMax As DateTime, counter As Integer
		  
		  If date1 < Date2 Then
		    dtCurrent = New DateTime(Date1.Year, Date1.Month, date1.Day, 0, 0, 0, 0, Date1.Timezone)
		    dtMax = New DateTime(Date2.Year, Date2.Month, Date2.Day, 0, 0, 0, 0, Date2.Timezone)
		  Else
		    dtCurrent =  New DateTime(Date2.Year, Date2.Month, Date2.Day, 0, 0, 0, 0, Date1.Timezone)
		    dtMax = New DateTime(Date1.Year, Date1.Month, Date1.Day, 0, 0, 0, 0, Date1.Timezone)
		  End
		  
		  Var cp() As ClosurePeriod  = AffectedClosurePeriods(dtCurrent, dtMax) // Copy the relevant items ClosurePeriod
		  
		  dtCurrent = dtCurrent.SubtractInterval(0,0,1)
		  
		  Do 
		    
		    dtCurrent = dtCurrent.AddInterval (0,0,1)
		    
		    //  Is this never a workday ?
		    If Not Me.WorkingWeek.WorkingDay(dtCurrent.DayOfWeek) Then
		      counter = counter + 1
		      Continue
		    end
		    
		    // Is this a Closure period ?
		    For i As Integer = 0 To cp.LastIndex
		      If dtCurrent >= cp(i).FirstDay And dtCurrent <= cp(i).LastDay Then 
		        counter = counter + 1
		        Continue do
		      end
		    Next
		    
		    // Is this a non-worked event ?
		    // This is the most time-consuming part to calculate, so it is calculated last only if necessary.
		    If IsAnnualEvent(dtCurrent, true) Then 
		      counter = counter + 1
		      Continue
		    End
		    
		  loop until dtCurrent >= dtMax
		  
		  Return counter
		  
		  
		  
		  
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DatesOfAnnualEvents(Starting as DateTime, Ending as DateTime, OnlyDayOff as boolean = False, IncludeSaturday as Boolean = True, IncludeSunday as Boolean = True, IncludeMonday as Boolean = True, IncludeTuesday as Boolean = True, IncludeWednesday as Boolean = True, IncludeThursday as Boolean = True, IncludeFriday as Boolean = True) As DateTime()
		  If Starting = Nil Then 
		    Raise New NilObjectException
		    Return Nil
		  End
		  
		  If Ending = Nil Then 
		    Raise New NilObjectException
		    Return Nil
		  End
		  
		  
		  Var list() As DateTime
		  If Me.AnnualEvents.LastIndex = -1 Then Return list // Empty
		  
		  Var nStart As New DateTime(starting.Year, starting.Month, starting.Day, 0, 0, 0, 0, Starting.Timezone)
		  Var nEnd As New DateTime(ending.Year, ending.Month, ending.Day, 0, 0, 0, 0, Ending.Timezone)
		  
		  If nStart > nEnd Then Return list // Empty
		  If nStart = nEnd Then
		    Var temp As DateAndCaption = Me.IsAnnualEventDateAndCaption(nStart, OnlyDayOff)
		    If temp <> Nil Then list.Add temp.DateValue
		    Return list
		  End
		  
		  Var Valeur As DateAndCaption
		  
		  
		  For year As Integer = nStart.Year To nEnd.Year
		    
		    For i As Integer = 0 To Me.AnnualEvents.LastIndex
		      
		      if OnlyDayOff and not me.AnnualEvents(i).DayOff then Continue
		      
		      Valeur = Me.AnnualEvents(i).Calculate(year)
		      
		      If valeur = Nil Then Continue
		      If valeur.DateValue < nStart Or valeur.DateValue > nEnd Then Continue
		      
		      
		      If valeur.DateValue.DayOfWeek = 7 And Not IncludeSaturday Then Continue
		      If valeur.DateValue.DayOfWeek = 1 And Not IncludeSunday Then Continue
		      If valeur.DateValue.DayOfWeek = 2 And Not IncludeMonday Then Continue
		      If valeur.DateValue.DayOfWeek = 3 And Not IncludeTuesday Then Continue
		      If valeur.DateValue.DayOfWeek = 4 And Not IncludeWednesday Then Continue
		      If valeur.DateValue.DayOfWeek = 5 And Not IncludeThursday Then Continue
		      If valeur.DateValue.DayOfWeek = 6 And Not IncludeFriday Then Continue
		      
		      AddInArray list, valeur.DateValue
		      
		    Next
		    
		  Next
		  
		  Return list
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DatesOfAnnualEvents(Year as integer, OnlyDayOff as boolean = False, IncludeSaturday as Boolean = True, IncludeSunday as Boolean = True, IncludeMonday as Boolean = True, IncludeTuesday as Boolean = True, IncludeWednesday as Boolean = True, IncludeThursday as Boolean = True, IncludeFriday as Boolean = True) As DateTime()
		  Var list() As DateTime
		  If Me.AnnualEvents.LastIndex = -1 Then Return list
		  
		  Var Valeur As DateAndCaption
		  Var nStart As New DateTime(Year,1,1,0,0,0,0, TimeZone.Current)
		  Var nEnd as new DateTime(Year,12,31,23,59,59,0, TimeZone.Current)
		  
		  For i As Integer = 0 To Me.AnnualEvents.LastIndex
		    
		    if OnlyDayOff and not me.AnnualEvents(i).DayOff then Continue
		    
		    Valeur = Me.AnnualEvents(i).Calculate(year)
		    
		    If valeur = Nil Then Continue
		    If valeur.DateValue < nStart Or valeur.DateValue > nEnd Then Continue
		    
		    If valeur.DateValue.DayOfWeek = 7 And Not IncludeSaturday Then Continue
		    If valeur.DateValue.DayOfWeek = 1 And Not IncludeSunday Then Continue
		    If valeur.DateValue.DayOfWeek = 2 And Not IncludeMonday Then Continue
		    If valeur.DateValue.DayOfWeek = 3 And Not IncludeTuesday Then Continue
		    If valeur.DateValue.DayOfWeek = 4 And Not IncludeWednesday Then Continue
		    If valeur.DateValue.DayOfWeek = 5 And Not IncludeThursday Then Continue
		    If valeur.DateValue.DayOfWeek = 6 And Not IncludeFriday Then Continue
		    
		    
		    AddInArray list, valeur.DateValue
		    
		  Next
		  
		  Return list
		  
		End Function
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
		Function IsAnnualEvent(d as DateTime, OnlyIfDayOff as Boolean = False) As Boolean
		  If d = Nil Then 
		    Raise New NilObjectException
		    Return False
		  End
		  
		  
		  Var r As DateAndCaption
		  r = IsAnnualEventDateAndCaption(d, OnlyIfDayOff)
		  Return r <> Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsAnnualEventCaption(d as DateTime, OnlyIfDayOff as Boolean = False) As String
		  If d = Nil Then 
		    Raise New NilObjectException
		    Return ""
		  End
		  
		  Var r As DateAndCaption
		  r = IsAnnualEventDateAndCaption(d, OnlyIfDayOff)
		  if r = Nil then Return "" else return r.Caption
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsAnnualEventDateAndCaption(d as DateTime, OnlyIfDayOff as Boolean = False) As DateAndCaption
		  If d = Nil Then 
		    Raise New NilObjectException
		    Return Nil
		  End
		  
		  If Me.AnnualEvents.LastIndex = -1 Then Return nil
		  
		  For i As Integer = 0 To Me.AnnualEvents.LastIndex
		    
		    if OnlyIfDayOff and not me.AnnualEvents(i).DayOff then Continue
		    If d < Me.AnnualEvents(i).StartOfValidity Or d > Me.AnnualEvents(i).EndOfValidity Then Continue
		    If Me.AnnualEvents(i).IsEventDate(d) Then Return new DateAndCaption(d, me.AnnualEvents(i).Caption, me.Identifier)
		    
		  Next i
		  
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsAnnualEventObject(d as DateTime, OnlyIfDayOff as Boolean = False) As AnnualEvent
		  If d = Nil Then 
		    Raise New NilObjectException
		    Return Nil
		  End
		  
		  If Me.AnnualEvents.LastIndex = -1 Then Return Nil
		  
		  For i As Integer = 0 To Me.AnnualEvents.LastIndex
		    
		    If OnlyIfDayOff And Not Me.AnnualEvents(i).DayOff Then Continue
		    If d < Me.AnnualEvents(i).StartOfValidity Or d > Me.AnnualEvents(i).EndOfValidity Then Continue
		    If Me.AnnualEvents(i).IsEventDate(d) Then return Me.AnnualEvents(i)
		    
		  Next i
		  
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsAnnualEventRegion(d as DateTime, OnlyIfDayOff as Boolean = False) As Variant
		  If d = Nil Then 
		    Raise New NilObjectException
		    Return Nil
		  End
		  
		  Var r As DateAndCaption
		  r = IsAnnualEventDateAndCaption(d, OnlyIfDayOff)
		  if r = Nil then Return Nil else return r.RegionIdentifier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsInClosurePeriod(d as DateTime) As Boolean
		  Var d1 As New DateTime(d.Year, d.Month, d.day,0,0,0) // 00:00
		  
		  For p As Integer = 0 To Me.ClosurePeriods.LastIndex
		    
		    if me.ClosurePeriods(p).FirstDay <= d1 and me.ClosurePeriods(p).LastDay >= d1 then Return true
		    
		  Next
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsInClosurePeriodCaption(d as DateTime) As string
		  Var d1 As New DateTime(d.Year, d.Month, d.day,0,0,0) // 00:00
		  
		  For p As Integer = 0 To Me.ClosurePeriods.LastIndex
		    
		    if me.ClosurePeriods(p).FirstDay <= d1 and me.ClosurePeriods(p).LastDay >= d1 then Return me.ClosurePeriods(p).Caption
		    
		  Next
		  
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsInClosurePeriodObject(d as DateTime) As ClosurePeriod
		  Var d1 As New DateTime(d.Year, d.Month, d.day,0,0,0) // 00:00
		  
		  For p As Integer = 0 To Me.ClosurePeriods.LastIndex
		    
		    if me.ClosurePeriods(p).FirstDay <= d1 and me.ClosurePeriods(p).LastDay >= d1 then Return me.ClosurePeriods(p)
		    
		  Next
		  
		  Return nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsWorkingDay(d as DateTime) As Boolean
		  If Not Me.WorkingWeek.WorkingDay(d.DayOfWeek) Then Return False
		  
		  For p As Integer = 0 To Me.ClosurePeriods.LastIndex
		    If Me.ClosurePeriods(p).IsIncluded(d) Then Return False
		  Next p
		  
		  For i As Integer = 0 To Me.AnnualEvents.LastIndex
		    
		    if not (d >= me.AnnualEvents(i).StartOfValidity and d <= me.AnnualEvents(i).EndOfValidity) then Continue 
		    if not me.AnnualEvents(i).DayOff then Continue // No need to test, it's not a holiday
		    
		    // Is this a non-worked event ?
		    // This is the most time-consuming part to calculate, so it is calculated last only if necessary.
		    if me.AnnualEvents(i).IsEventDate(d) then Return False
		    
		  Next i
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ListOfAnnualEvents(Starting as DateTime, Ending as DateTime, OnlyDayOff as boolean = False, IncludeSaturday as Boolean = True, IncludeSunday as Boolean = True, IncludeMonday as Boolean = True, IncludeTuesday as Boolean = True, IncludeWednesday as Boolean = True, IncludeThursday as Boolean = True, IncludeFriday as Boolean = True) As DateAndCaption()
		  Var list() As DateAndCaption
		  If Me.AnnualEvents.LastIndex = -1 Then Return list
		  
		  If Starting = Nil Then 
		    Raise New NilObjectException
		    Return Nil
		  End
		  
		  If Ending = Nil Then 
		    Raise New NilObjectException
		    Return Nil
		  End
		  
		  
		  Var nStart As New DateTime(starting.Year, starting.Month, starting.Day, 0, 0, 0, 0, Starting.Timezone)
		  Var nEnd As New DateTime(ending.Year, ending.Month, ending.Day, 0, 0, 0, 0, Ending.Timezone)
		  
		  If nStart > nEnd Then Return list // Empty
		  If nStart = nEnd Then
		    Var temp As DateAndCaption = Me.IsAnnualEventDateAndCaption(nStart)
		    If temp <> Nil Then list.Add temp
		    Return list
		  End
		  
		  Var Valeur As DateAndCaption
		  
		  
		  For year As Integer = nStart.Year To nEnd.Year
		    
		    For i As Integer = 0 To Me.AnnualEvents.LastIndex
		      
		      if OnlyDayOff and not me.AnnualEvents(i).DayOff then Continue
		      
		      Valeur = Me.AnnualEvents(i).Calculate(year)
		      
		      If valeur = Nil Then Continue
		      If valeur.DateValue < nStart Or valeur.DateValue > nEnd Then Continue
		      
		      
		      If valeur.DateValue.DayOfWeek = 7 And Not IncludeSaturday Then Continue
		      If valeur.DateValue.DayOfWeek = 1 And Not IncludeSunday Then Continue
		      If valeur.DateValue.DayOfWeek = 2 And Not IncludeMonday Then Continue
		      If valeur.DateValue.DayOfWeek = 3 And Not IncludeTuesday Then Continue
		      If valeur.DateValue.DayOfWeek = 4 And Not IncludeWednesday Then Continue
		      If valeur.DateValue.DayOfWeek = 5 And Not IncludeThursday Then Continue
		      If valeur.DateValue.DayOfWeek = 6 And Not IncludeFriday Then Continue
		      
		      AddInArray(list, New DateAndCaption(valeur))
		      
		    Next
		    
		  Next
		  
		  Return list
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ListOfAnnualEvents(Year as integer, OnlyDayOff as boolean = False, IncludeSaturday as Boolean = True, IncludeSunday as Boolean = True, IncludeMonday as Boolean = True, IncludeTuesday as Boolean = True, IncludeWednesday as Boolean = True, IncludeThursday as Boolean = True, IncludeFriday as Boolean = True) As DateAndCaption()
		  Var list() As DateAndCaption
		  If Me.AnnualEvents.LastIndex = -1 Then Return list
		  
		  Var Valeur As DateAndCaption
		  Var nStart As New DateTime(Year,1,1,0,0,0)
		  Var nEnd as new DateTime(Year,12,31,23,59,59)
		  
		  
		  For i As Integer = 0 To Me.AnnualEvents.LastIndex
		    
		    if OnlyDayOff and not me.AnnualEvents(i).DayOff then Continue
		    
		    Valeur = Me.AnnualEvents(i).Calculate(year)
		    
		    If valeur = Nil Then Continue
		    If valeur.DateValue < nStart Or valeur.DateValue > nEnd Then Continue
		    
		    If valeur.DateValue.DayOfWeek = 7 And Not IncludeSaturday Then Continue
		    If valeur.DateValue.DayOfWeek = 1 And Not IncludeSunday Then Continue
		    If valeur.DateValue.DayOfWeek = 2 And Not IncludeMonday Then Continue
		    If valeur.DateValue.DayOfWeek = 3 And Not IncludeTuesday Then Continue
		    If valeur.DateValue.DayOfWeek = 4 And Not IncludeWednesday Then Continue
		    If valeur.DateValue.DayOfWeek = 5 And Not IncludeThursday Then Continue
		    If valeur.DateValue.DayOfWeek = 6 And Not IncludeFriday Then Continue
		    
		    AddInArray(list, New DateAndCaption(valeur))
		    
		  Next
		  
		  Return list
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LoadAnnualEventsFromRowSet(rs as RowSet, Encoding as TextEncoding = Nil, ValueColumn as string = "value", RegionColumn as string = "region", IdColumn as string = "id_event")
		  If rs = Nil Then 
		    exit sub
		  end
		  
		  If rs.AfterLastRow Then 
		    exit sub
		  end
		  
		  Var ae() As AnnualEvent = WorkCalendar.AnnualEventsFromRowSet( _
		  rs, _
		  Me.Identifier, _
		  Encoding, _
		  ValueColumn, _
		  RegionColumn, _
		  IdColumn _
		  )
		  
		  For i As Integer = 0 To ae.LastIndex
		    me.AnnualEvents.Add ae(i)
		  next 
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LoadClosurePeriodsFromRowSet(rs as RowSet, Encoding as TextEncoding = Nil)
		  If rs = Nil Then Exit Sub
		  if rs.AfterLastRow then exit sub
		  
		  Var cp() As ClosurePeriod = WorkCalendar.ClosurePeriodsFromRowSet(rs, Me.Identifier, Encoding)
		  
		  For p As Integer = 0 To cp.LastIndex
		    Me.ClosurePeriods.add cp(p)
		  next p
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NonWorkingDayOffset(startdate as datetime, number as integer = 1, limit as integer = 366) As DateTime
		  // if number is 1, this means the immediately following non working day. 
		  // If the number is 2, it means the second following non working day, and so on.
		  // If you need to add 6 non working days, then number = 6
		  
		  If startdate = Nil Then 
		    Raise New NilObjectException
		    Return Nil
		  End
		  
		  If number = 0 Then Return startdate // Trivial case
		  
		  // Duplicating the date and using a counter
		  Var dt As New DateTime(startdate.Year, startdate.Month, startdate.day, 0, 0, 0, 0, startdate.Timezone)
		  Var counter As Integer
		  
		  
		  Var dLimit As DateTime 
		  If number > 0 Then
		    dLimit = dt.AddInterval(0,0,limit)
		  Else
		    dLimit = dt.SubtractInterval(0,0,limit)
		  End
		  
		  Do 
		    
		    If number > 0 And dt > dLimit Then Return Nil // Fail to find a day
		    If number < 0 And dt < dLimit Then Return Nil // Fail to find a day
		    
		    If number > 0 Then
		      dt = dt.AddInterval (0,0,1)
		    Else
		      dt = dt.SubtractInterval (0,0,1)
		    End
		    
		    //  Is this never a workday ?
		    If Not Me.WorkingWeek.WorkingDay(dt.DayOfWeek) Then 
		      counter = counter + 1
		      Continue do // Skip
		    end
		    
		    // Is this a Closure period ?
		    For i As Integer = 0 To Me.ClosurePeriods.LastIndex
		      If dt >= Me.ClosurePeriods(i).FirstDay  And dt <= Me.ClosurePeriods(i).LastDay Then 
		        counter = counter + 1
		        continue do // skip
		      end
		    Next
		    
		    // Is this a non-worked event ?
		    // This is the most time-consuming part to calculate, so it is calculated last only if necessary.
		    If Me.IsAnnualEvent(dt, True) Then counter = counter + 1
		    
		  Loop Until counter = Abs(number)
		  
		  If counter < abs(number) Then Return Nil
		  
		  Return dt
		  
		  
		  
		  
		  
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NonWorkingDayReasonCaption(d as DateTime) As String
		  If d = Nil Then 
		    Raise New NilObjectException
		    Return ""
		  End
		  
		  if not me.WorkingWeek.WorkingDay(d.DayOfWeek) then Return d.ToString("EEEE")
		  
		  For i As Integer = 0 To Me.ClosurePeriods.LastIndex
		    If Me.ClosurePeriods(i).IsIncluded(d) Then Return Me.ClosurePeriods(i).Caption
		  next
		  
		  
		  
		  For i As Integer = 0 To Me.AnnualEvents.LastIndex
		    
		    If Not Me.AnnualEvents(i).DayOff Then Continue
		    If d < Me.AnnualEvents(i).StartOfValidity Or d > Me.AnnualEvents(i).EndOfValidity Then Continue
		    If Me.AnnualEvents(i).IsEventDate(d) Then Return me.AnnualEvents(i).Caption
		    
		  Next i
		  
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NonWorkingDayReasonType(d as DateTime) As Integer
		  If d = Nil Then 
		    Raise New NilObjectException
		    Return 0
		  End
		  
		  if not me.WorkingWeek.WorkingDay(d.DayOfWeek) then Return 1
		  
		  For i As Integer = 0 To Me.ClosurePeriods.LastIndex
		    If Me.ClosurePeriods(i).IsIncluded(d) Then Return 2
		  next
		  
		  For i As Integer = 0 To Me.AnnualEvents.LastIndex
		    
		    If Not Me.AnnualEvents(i).DayOff Then Continue
		    If d < Me.AnnualEvents(i).StartOfValidity Or d > Me.AnnualEvents(i).EndOfValidity Then Continue
		    If Me.AnnualEvents(i).IsEventDate(d) Then Return 3
		    
		  Next i
		  
		  Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NonWorkingDays(starting as DateTime, ending as DateTime) As DateTime()
		  Var list() As DateTime
		  Var nStart As New DateTime(starting.Year, starting.Month, starting.day, 0, 0, 0, 0, starting.Timezone)
		  Var nEnd As New DateTime(ending.Year, ending.Month, ending.day, 0, 0, 0, 0, ending.Timezone)
		  
		  If nStart > nEnd Then Return list
		  
		  
		  Var cp() As ClosurePeriod  = AffectedClosurePeriods(starting, ending) // Copy the relevant items ClosurePeriod
		  
		  Var d As DateTime =  nStart.SubtractInterval(0,0,1)
		  
		  Do Until d >= nEnd
		    
		    d = d.AddInterval(0,0,1)
		    
		    //  Is this never a workday ?
		    If Not Me.WorkingWeek.WorkingDay(d.DayOfWeek) Then  
		      list.Add new DateTime(d)
		      continue // Sufficient condition, no need to check anything else
		    end
		    
		    // Is this a Closure period ?
		    For i As Integer = 0 To cp.LastIndex
		      If d >= cp(i).FirstDay And d <= cp(i).LastDay Then 
		        list.Add New DateTime(d)
		        Continue Do // Sufficient condition, no need to check anything else
		      end
		    Next
		    
		    // Is this a non-worked event ?
		    // This is the most time-consuming part to calculate, so it is calculated last only if necessary.
		    
		    If IsAnnualEvent(d, True) Then 
		      list.Add New DateTime(d)
		    end
		    
		  Loop
		  
		  Return list
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NonWorkingDays(year as Integer) As DateTime()
		  Var d As New DateTime(year, 1, 1, 0, 0, 0)
		  Var f As New DateTime(year, 12, 31, 0, 0, 0)
		  
		  Return NonWorkingDays(d,f)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NonWorkingDaysDateAndCaption(starting as DateTime, ending as DateTime) As DateAndCaption()
		  Var list() As DateAndCaption
		  Var nStart As New DateTime(starting.Year, starting.Month, starting.day,0,0,0,0, starting.Timezone)
		  Var nEnd As New DateTime(ending.Year, ending.Month, ending.day,0,0,0,0, ending.Timezone)
		  
		  If nStart > nEnd Then Return list
		  
		  
		  Var cp() As ClosurePeriod  = AffectedClosurePeriods(starting, ending) // Copy the relevant items ClosurePeriod
		  
		  Var d As DateTime =  nStart.SubtractInterval(0,0,1)
		  Var s as string
		  
		  Do Until d >= nEnd
		    
		    d = d.AddInterval(0,0,1)
		    
		    //  Is this never a workday ?
		    If Not Me.WorkingWeek.WorkingDay(d.DayOfWeek) Then  
		      list.Add new DateAndCaption(DateTime(d), d.ToString("EEEE"))
		      continue // Sufficient condition, no need to check anything else
		    end
		    
		    // Is this a Closure period ?
		    For i As Integer = 0 To cp.LastIndex
		      If d >= cp(i).FirstDay And d <= cp(i).LastDay Then 
		        list.Add new DateAndCaption(DateTime(d), cp(i).Caption)
		        Continue Do // Sufficient condition, no need to check anything else
		      end
		    Next
		    
		    // Is this a non-worked event ?
		    // This is the most time-consuming part to calculate, so it is calculated last only if necessary.
		    
		    s = IsAnnualEventCaption(d, True)
		    if s <> "" then list.Add new DateAndCaption(New DateTime(d), s)
		    
		    
		  Loop
		  
		  Return list
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NonWorkingDaysDateAndCaption(year as Integer) As DateAndCaption()
		  Var d As New DateTime(year, 1, 1, 0, 0, 0)
		  Var f As New DateTime(year, 12, 31, 0, 0, 0)
		  
		  Return NonWorkingDaysDateAndCaption(d,f)
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		AnnualEvents() As AnnualEvent
	#tag EndProperty

	#tag Property, Flags = &h0
		Caption As string
	#tag EndProperty

	#tag Property, Flags = &h0
		ClosurePeriods() As ClosurePeriod
	#tag EndProperty

	#tag Property, Flags = &h0
		Enabled As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0
		Identifier As Variant
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDbId As Variant
	#tag EndProperty

	#tag Property, Flags = &h0
		Tag As Variant
	#tag EndProperty

	#tag Property, Flags = &h0
		WorkingWeek As wcWorkingWeekDays
	#tag EndProperty


	#tag Enum, Name = Belgium, Type = Integer, Flags = &h0
		NationauxEnFrancais
		  NationaleDagenInDeVlaamseTaal
		  NationalfeiertageAufDeutsch
		  Vlaanderen
		  DeutschsprachigeGemeinschaft
		  BruxellesCapitale
		Wallonie
	#tag EndEnum

	#tag Enum, Name = France, Flags = &h0
		General
		  AlsaceMoselle
		  Guyane
		  Guadeloupe
		  Martinique
		  Reunion
		  SaintBarthelemy
		  SaintMartin
		Mayotte
	#tag EndEnum

	#tag Enum, Name = USA, Type = Integer, Flags = &h0
		Federal
		  Alabama
		  Alaska
		  Arkansas
		  Arizona
		  California
		  Colorado
		  Connecticut
		  Delaware
		  DistrictOfColumbia
		  Florida
		  Georgia
		  Hawaii
		  Idaho
		  Illinois
		  Indiana
		  Iowa
		  Kansas
		  Kentucky
		  Louisiana
		  Maine
		  Maryland
		  Massachusetts
		  Michigan
		  Minnesota
		  Mississippi
		  Missouri
		  Montana
		  Nebraska
		  Nevada
		  NewHampshire
		  NewJersey
		  NewMexico
		  NewYork
		  NorthCarolina
		  NorthDakota
		  Ohio
		  Oklahoma
		  Oregon
		  Pennsylvania
		  RhodeIsland
		  SouthCarolina
		  SouthDakota
		  Tennessee
		  Texas
		  Utah
		  Vermont
		  Virginia
		  Washington
		  WestVirginia
		  Wisconsin
		Wyoming
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
			Name="Enabled"
			Visible=false
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Caption"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
