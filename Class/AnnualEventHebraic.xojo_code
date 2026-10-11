#tag Class
Protected Class AnnualEventHebraic
Implements AnnualEvent
	#tag Method, Flags = &h0
		Shared Function AllHolidays(Optional useIsraeliPostponement As Boolean = False, Optional language As DisplayLanguage = DisplayLanguage.English) As AnnualEventHebraic()
		  ' Returns one AnnualEventHebraic instance per Jewish holiday (not
		  ' tied to any particular year - call .DateValue(year) on each to
		  ' get its date in a given civil year). Shared: call it as
		  ' AnnualEventHebraic.AllHolidays(...), no instance needed.
		  '
		  ' language (default English): Caption on every returned instance is
		  ' filled in with the holiday's name in this language (one of the
		  ' languages covered by the Shared *Name functions).
		  '
		  ' useIsraeliPostponement (default False):
		  '   - False: the instances for YomHaatzmaut, YomHaZikaron and the
		  '     four minor fasts use their raw Hebrew-calendar HolidayType.
		  '   - True: those same holidays use their "_ApplyCivilShift"
		  '     variant instead (Israel's official weekday-postponement
		  '     rules - see ShiftedYomHaatzmaut, ShiftedMinorFast,
		  '     ShiftedTaanitEsther). Has no effect on any other holiday.
		  '
		  ' Diaspora usage is assumed for Simchat Torah and the 8th day of
		  ' Pesach (SimchatTorah_Diaspora / PassoverEighthDay_Diaspora); build
		  ' your own instances with New AnnualEventHebraic(...) if you need
		  ' the Israel variants instead.
		  
		  Var result() As AnnualEventHebraic
		  
		  result.Add(New AnnualEventHebraic(HolidayType.RoshHashanah, language))
		  result.Add(New AnnualEventHebraic(HolidayType.YomKippur, language))
		  result.Add(New AnnualEventHebraic(HolidayType.SukkotFirstDay, language))
		  result.Add(New AnnualEventHebraic(HolidayType.HoshanaRabbah, language))
		  result.Add(New AnnualEventHebraic(HolidayType.SheminiAtzeret, language))
		  result.Add(New AnnualEventHebraic(HolidayType.SimchatTorah_Diaspora, language))
		  result.Add(New AnnualEventHebraic(HolidayType.HanukkahFirstDay, language))
		  result.Add(New AnnualEventHebraic(HolidayType.TuBishvat, language))
		  result.Add(New AnnualEventHebraic(HolidayType.Purim, language))
		  result.Add(New AnnualEventHebraic(HolidayType.PassoverFirstDay, language))
		  result.Add(New AnnualEventHebraic(HolidayType.PassoverSeventhDay, language))
		  result.Add(New AnnualEventHebraic(HolidayType.PassoverEighthDay_Diaspora, language))
		  result.Add(New AnnualEventHebraic(HolidayType.YomHaShoah, language))
		  result.Add(New AnnualEventHebraic(HolidayType.LagBaOmer, language))
		  result.Add(New AnnualEventHebraic(HolidayType.Shavuot, language))
		  
		  If useIsraeliPostponement Then
		    result.Add(New AnnualEventHebraic(HolidayType.YomHaZikaron_ApplyCivilShift, language))
		    result.Add(New AnnualEventHebraic(HolidayType.YomHaatzmaut_ApplyCivilShift, language))
		    result.Add(New AnnualEventHebraic(HolidayType.TzomGedaliah_ApplyShabbatShift, language))
		    result.Add(New AnnualEventHebraic(HolidayType.AsaraBeTevet_ApplyShabbatShift, language))
		    result.Add(New AnnualEventHebraic(HolidayType.TaanitEsther_ApplyShabbatShift, language))
		    result.Add(New AnnualEventHebraic(HolidayType.ShivaAsarBeTammuz_ApplyShabbatShift, language))
		  Else
		    result.Add(New AnnualEventHebraic(HolidayType.YomHaZikaron, language))
		    result.Add(New AnnualEventHebraic(HolidayType.YomHaatzmaut, language))
		    result.Add(New AnnualEventHebraic(HolidayType.TzomGedaliah, language))
		    result.Add(New AnnualEventHebraic(HolidayType.AsaraBeTevet, language))
		    result.Add(New AnnualEventHebraic(HolidayType.TaanitEsther, language))
		    result.Add(New AnnualEventHebraic(HolidayType.ShivaAsarBeTammuz, language))
		  End If
		  
		  
		  
		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Calculate(year as Integer) As DateAndCaption
		  Var dt As DateTime = DateValue(year)
		  If dt = Nil Then Return Nil
		  Return new DateAndCaption(dt, me.mCaption)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Caption() As String
		  Return mCaption
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Caption(assigns s as string)
		  me.mCaption = s
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function CaptionFor(holiday As HolidayType, language As DisplayLanguage) As String
		  ' Shared helper behind the "holiday + language -> display name"
		  ' logic, used both by AllHolidays and by the
		  ' Constructor(holiday, language) overload, so the mapping only
		  ' lives in one place.
		  Select Case language
		  Case DisplayLanguage.French
		    Return FrenchName(holiday)
		  Case DisplayLanguage.ModernHebrew
		    Return ModernHebrewName(holiday)
		  Case DisplayLanguage.Dutch
		    Return DutchName(holiday)
		  Case DisplayLanguage.German
		    Return GermanName(holiday)
		  Case DisplayLanguage.Spanish
		    Return SpanishName(holiday)
		  Else
		    Return EnglishName(holiday)
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(d as AnnualEvent)
		  If d = Nil Then 
		    Raise New NilObjectException
		    Exit Sub
		  End
		  
		  If Not (d IsA AnnualEventHebraic) Then
		    Raise New InvalidArgumentException
		    Exit Sub
		  End
		  
		  
		  Var copy As AnnualEventHebraic = d.DefinitionObject
		  
		  Me.mCaption = Copy.Caption
		  Me.DayOff = Copy.DayOff
		  Me.DbId = copy.DbId
		  Me.Tag = copy.Tag
		  Me.CycleFirstYear = Copy.CycleFirstYear
		  Me.CycleYearDuration = Copy.CycleYearDuration
		  Me.StartOfValidity = copy.StartOfValidity
		  Me.EndOfValidity = copy.EndOfValidity
		  
		  Me.Holiday = copy.Holiday
		  Me.hDay = copy.hDay
		  Me.hMonth = copy.hMonth
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(copy as AnnualEventHebraic)
		  Me.mCaption = Copy.Caption
		  Me.DayOff = Copy.DayOff
		  me.DbId = copy.DbId
		  me.Tag = copy.Tag
		  Me.CycleFirstYear = Copy.CycleFirstYear
		  Me.CycleYearDuration = Copy.CycleYearDuration
		  
		  Me.StartOfValidity = copy.StartOfValidity
		  Me.EndOfValidity = copy.EndOfValidity
		  
		  Me.Holiday = copy.Holiday
		  Me.hDay = copy.hDay
		  me.hMonth = copy.hMonth
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(lHoliday As HolidayType, language As DisplayLanguage)
		  me.Holiday = lHoliday
		  me.mCaption = CaptionFor(lHoliday, language)
		  HolidayMonthDay(Me.Holiday, hMonth, hDay, 0)
		  
		  Me.StartOfValidity = New DateTime(1,1,1,0,0,0)
		  Me.EndOfValidity = New DateTime(3999,12,31,23,59,59)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(lCaption As string, lHoliday As HolidayType)
		  me.mCaption = lCaption
		  Holiday = lHoliday
		  HolidayMonthDay(Me.holiday, hMonth, hDay, 0)
		  
		  Me.StartOfValidity = New DateTime(1,1,1,0,0,0)
		  Me.EndOfValidity = New DateTime(3999,12,31,23,59,59)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(lCaption As string, Month As Integer, Day As Integer)
		  me.mCaption = lCaption
		  Me.Holiday = HolidayType.Custom
		  Me.hMonth = Month
		  Me.hDay = Day
		  
		  Me.StartOfValidity = New DateTime(1,1,1,0,0,0)
		  Me.EndOfValidity = New DateTime(3999,12,31,23,59,59)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(lCaption As string, lCode As String)
		  Me.Holiday = HolidayFromCode(lcode)
		  me.mCaption = lcaption
		  HolidayMonthDay(Holiday, hMonth, hDay, 0)
		  
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

	#tag Method, Flags = &h21
		Private Function DateInHebrewYear(hy As Integer) As DateTime
		  ' Computes this instance's holiday date within one specific Hebrew
		  ' year "hy" (called twice by DateValue, once per Hebrew year that
		  ' overlaps a given civil year). Reuses the Shared HebraicToGregorian.
		  '
		  ' YomHaatzmaut_ApplyCivilShift and YomHaZikaron_ApplyCivilShift use
		  ' Israel's official weekday-postponement rule instead of the raw
		  ' 5/4 Iyar date - see ShiftedYomHaatzmaut. Yom HaZikaron is always
		  ' exactly one day before the (possibly shifted) Yom Ha'atzmaut date,
		  ' by law.
		  '
		  ' The four minor-fast "_ApplyCivilShift" variants apply the
		  ' Shabbat-postponement rule for public fasts instead of the raw date
		  ' - see ShiftedMinorFast and ShiftedTaanitEsther.
		  
		  Var m2 As Integer = Me.hMonth
		  Var d2 As Integer = Me.hDay
		  
		  If Holiday = HolidayType.YomHaatzmaut_ApplyCivilShift Then
		    Return ShiftedYomHaatzmaut(hy)
		  ElseIf Holiday = HolidayType.YomHaZikaron_ApplyCivilShift Then
		    Return ShiftDays(ShiftedYomHaatzmaut(hy), -1)
		  ElseIf Holiday = HolidayType.TzomGedaliah_ApplyShabbatShift Then
		    Return ShiftedMinorFast(HebraicToGregorian(hy, 7, 3))
		  ElseIf Holiday = HolidayType.AsaraBeTevet_ApplyShabbatShift Then
		    Return ShiftedMinorFast(HebraicToGregorian(hy, 10, 10))
		  ElseIf Holiday = HolidayType.ShivaAsarBeTammuz_ApplyShabbatShift Then
		    Return ShiftedMinorFast(HebraicToGregorian(hy, 4, 17))
		  ElseIf Holiday = HolidayType.TaanitEsther_ApplyShabbatShift Then
		    HolidayMonthDay(HolidayType.TaanitEsther, m2, d2, hy)
		    Return ShiftedTaanitEsther(HebraicToGregorian(hy, m2, d2))
		  End If
		  
		  ' Custom events keep the hMonth/hDay set once by their Constructor.
		  ' Every built-in holiday re-resolves them against "hy" - a no-op
		  ' for most (always the same month/day), but genuinely necessary for
		  ' Purim/TaanitEsther, whose month depends on whether "hy" is a leap
		  ' year.
		  
		  
		  
		  If Holiday <> HolidayType.Custom Then
		    HolidayMonthDay(Holiday, m2, d2, hy)
		  End If
		  
		  Return HebraicToGregorian(hy, m2, d2)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function DateTimeFromJulianDay(jd As Double, tz As TimeZone) As DateTime
		  ' Converts a (fractional) Julian Date, UT, into a DateTime shown in
		  ' the given TimeZone - this is where the GMT offset carried by a
		  ' Xojo DateTime/TimeZone gets applied to our UT computation.
		  Dim secondsFrom1970 As Double = (jd - 2440587.5) * 86400.0
		  Return New DateTime(secondsFrom1970, tz)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DateValue(year As Integer) As DateTime
		  ' Computes the Gregorian date, in the given civil year, of this
		  ' instance's holiday. Returns Nil in the very rare case (Hanukkah
		  ' only, starting from year 2727) where it does not fall on any day
		  ' of that civil year; returns the chronologically first occurrence
		  ' if it falls twice in the same civil year.
		  
		  if me.Holiday = HolidayType.Unknown then Return Nil
		  
		  If year < 1 Then 
		    Break
		    Return Nil
		  End
		  
		  If Me.CycleYearDuration > 1 Then
		    If Me.CycleFirstYear > year Then Return Nil
		    If (year - Me.CycleFirstYear) Mod Me.CycleYearDuration > 0 Then Return Nil
		  End
		  
		  If year < Me.StartOfValidity.Year Or year > Me.EndOfValidity.Year Then Return Nil
		  
		  
		  Dim hy1 As Integer = year + 3760
		  Dim hy2 As Integer = hy1 + 1
		  
		  Dim c1 As DateTime = DateInHebrewYear(hy1)
		  Dim c2 As DateTime = DateInHebrewYear(hy2)
		  
		  Dim match1 As Boolean = (c1 <> Nil) And (c1.Year = year)
		  Dim match2 As Boolean = (c2 <> Nil) And (c2.Year = year)
		  
		  Dim dt as DateTime
		  
		  If match1 And match2 Then
		    If c1 < c2 Then
		      dt = c1
		    Else
		      dt =  c2
		    End If
		  ElseIf match1 Then
		    dt =  c1
		  ElseIf match2 Then
		    dt =  c2
		  Else
		    Return Nil
		  End If
		  
		  dt = new DateTime(dt.Year, dt.Month, dt.Day, 0, 0, 0, 0, dt.Timezone)
		  
		  If dt < Me.mStartOfValidity Or dt > Me.mEndOfValidity Then Return Nil
		  
		  Return dt
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

	#tag Method, Flags = &h21
		Private Shared Function DaysInHebrewYear(year As Integer) As Integer
		  Return HebrewNewYear(year + 1) - HebrewNewYear(year)
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
		Shared Function DutchName(holiday As HolidayType) As String
		  ' Returns the Belgian Dutch (Flemish) name of a holiday.
		  Select Case holiday
		  Case HolidayType.RoshHashanah
		    Return "Rosj Hasjana"
		  Case HolidayType.YomKippur
		    Return "Jom Kipoer"
		  Case HolidayType.SukkotFirstDay
		    Return "Soekot (1e dag)"
		  Case HolidayType.HoshanaRabbah
		    Return "Hosjana Rabba"
		  Case HolidayType.SheminiAtzeret
		    Return "Sjmini Atseret"
		  Case HolidayType.SimchatTorah_Diaspora
		    Return "Simchat Tora (diaspora)"
		  Case HolidayType.SimchatTorah_Israel
		    Return "Simchat Tora (Israël)"
		  Case HolidayType.HanukkahFirstDay
		    Return "Chanoeka (1e dag)"
		  Case HolidayType.TuBishvat
		    Return "Toe Bisjwat"
		  Case HolidayType.Purim
		    Return "Poerim"
		  Case HolidayType.PassoverFirstDay
		    Return "Pesach (1e dag)"
		  Case HolidayType.PassoverSeventhDay
		    Return "Pesach (7e dag)"
		  Case HolidayType.PassoverEighthDay_Diaspora
		    Return "Pesach (8e dag - diaspora)"
		  Case HolidayType.YomHaShoah
		    Return "Jom Hasjoa"
		  Case HolidayType.YomHaZikaron, HolidayType.YomHaZikaron_ApplyCivilShift
		    Return "Jom Hazikaron"
		  Case HolidayType.YomHaatzmaut, HolidayType.YomHaatzmaut_ApplyCivilShift
		    Return "Jom Ha'atzma'oet"
		  Case HolidayType.LagBaOmer
		    Return "Lag Ba'omer"
		  Case HolidayType.Shavuot
		    Return "Sjavoeot"
		  Case HolidayType.TzomGedaliah, HolidayType.TzomGedaliah_ApplyShabbatShift
		    Return "Vasten van Gedalja"
		  Case HolidayType.AsaraBeTevet, HolidayType.AsaraBeTevet_ApplyShabbatShift
		    Return "Tiende van Tevet"
		  Case HolidayType.TaanitEsther, HolidayType.TaanitEsther_ApplyShabbatShift
		    Return "Vasten van Esther"
		  Case HolidayType.ShivaAsarBeTammuz, HolidayType.ShivaAsarBeTammuz_ApplyShabbatShift
		    Return "Zeventiende van Tammoez"
		  End Select
		  Return ""
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
		Shared Function EnglishName(holiday As HolidayType) As String
		  ' Returns the English name of a holiday.
		  Select Case holiday
		  Case HolidayType.RoshHashanah
		    Return "Rosh Hashanah"
		  Case HolidayType.YomKippur
		    Return "Yom Kippur"
		  Case HolidayType.SukkotFirstDay
		    Return "Sukkot (1st day)"
		  Case HolidayType.HoshanaRabbah
		    Return "Hoshana Rabbah"
		  Case HolidayType.SheminiAtzeret
		    Return "Shemini Atzeret"
		  Case HolidayType.SimchatTorah_Diaspora
		    Return "Simchat Torah (Diaspora)"
		  Case HolidayType.SimchatTorah_Israel
		    Return "Simchat Torah (Israel)"
		  Case HolidayType.HanukkahFirstDay
		    Return "Hanukkah (1st day)"
		  Case HolidayType.TuBishvat
		    Return "Tu BiShvat"
		  Case HolidayType.Purim
		    Return "Purim"
		  Case HolidayType.PassoverFirstDay
		    Return "Passover (1st day)"
		  Case HolidayType.PassoverSeventhDay
		    Return "Passover (7th day)"
		  Case HolidayType.PassoverEighthDay_Diaspora
		    Return "Passover (8th day - Diaspora)"
		  Case HolidayType.YomHaShoah
		    Return "Yom HaShoah"
		  Case HolidayType.YomHaZikaron, HolidayType.YomHaZikaron_ApplyCivilShift
		    Return "Yom HaZikaron"
		  Case HolidayType.YomHaatzmaut, HolidayType.YomHaatzmaut_ApplyCivilShift
		    Return "Yom Ha'atzmaut"
		  Case HolidayType.LagBaOmer
		    Return "Lag BaOmer"
		  Case HolidayType.Shavuot
		    Return "Shavuot"
		  Case HolidayType.TzomGedaliah, HolidayType.TzomGedaliah_ApplyShabbatShift
		    Return "Fast of Gedaliah"
		  Case HolidayType.AsaraBeTevet, HolidayType.AsaraBeTevet_ApplyShabbatShift
		    Return "Tenth of Tevet"
		  Case HolidayType.TaanitEsther, HolidayType.TaanitEsther_ApplyShabbatShift
		    Return "Fast of Esther"
		  Case HolidayType.ShivaAsarBeTammuz, HolidayType.ShivaAsarBeTammuz_ApplyShabbatShift
		    Return "Seventeenth of Tammuz"
		  End Select
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EveDateValue(year as Integer, latitude as double, longitude as double, optional altitude as double = 0) As DateTime
		  ' Computes the Gregorian date, in the given civil year, of this
		  ' instance's holiday. Returns Nil in the very rare case (Hanukkah
		  ' only, starting from year 2727) where it does not fall on any day
		  ' of that civil year; returns the chronologically first occurrence
		  ' if it falls twice in the same civil year.
		  ' Shit to eve sunset
		  if me.Holiday = HolidayType.Unknown then Return Nil
		  
		  If year < 1 Then 
		    Break
		    Return Nil
		  End
		  
		  If Me.CycleYearDuration > 1 Then
		    If Me.CycleFirstYear > year Then Return Nil
		    If (year - Me.CycleFirstYear) Mod Me.CycleYearDuration > 0 Then Return Nil
		  End
		  
		  If year < Me.StartOfValidity.Year Or year > Me.EndOfValidity.Year Then Return Nil
		  
		  
		  Dim hy1 As Integer = year + 3760
		  Dim hy2 As Integer = hy1 + 1
		  
		  Dim c1 As DateTime = DateInHebrewYear(hy1)
		  Dim c2 As DateTime = DateInHebrewYear(hy2)
		  
		  Dim match1 As Boolean = (c1 <> Nil) And (c1.Year = year)
		  Dim match2 As Boolean = (c2 <> Nil) And (c2.Year = year)
		  
		  Dim dt as DateTime
		  
		  If match1 And match2 Then
		    If c1 < c2 Then
		      dt = c1
		    Else
		      dt =  c2
		    End If
		  ElseIf match1 Then
		    dt =  c1
		  ElseIf match2 Then
		    dt =  c2
		  Else
		    Return Nil
		  End If
		  
		  
		  If dt < Me.mStartOfValidity Or dt > Me.mEndOfValidity Then Return Nil
		  
		  dt = dt.SubtractInterval(0,0,1)
		  
		  Var dtSunset as DateTime = SunsetTime(dt, latitude, longitude, altitude)
		  
		  Return dtSunset
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FingerPrint() As string
		  Var s As String
		  
		  s = "H|" // 0
		  
		  s = s + Me.StartOfValidity.SQLDate + "|" // 2
		  s = s + Me.EndOfValidity.SQLDate + "|" // 3
		  s = s + Me.CycleFirstYear.ToString(Locale.Raw) + "|" // 4
		  s = s + Me.CycleYearDuration.ToString(Locale.Raw) + "|" // 5
		  If Me.DayOff Then s = s + "1|" Else s = s + "0|" // 6
		  s = s + HolidayCode(Me.Holiday) + "|" // 7
		  s = s + Me.hMonth.ToString(Locale.Raw) + "|" // 8
		  s = s + Me.hDay.ToString(Locale.Raw) + "|" // 9
		  
		  Return s
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function FixedFromGregorian(y As Integer, m As Integer, d As Integer) As Int64
		  ' Conversion Gregorian date -> RD (inverse of GregorianFromFixed,
		  ' days_from_civil algorithm, H. Hinnant)
		  Dim yy As Int64 = y
		  If m <= 2 Then yy = yy - 1
		  Dim era As Int64
		  If yy >= 0 Then
		    era = yy \ 400
		  Else
		    era = (yy - 399) \ 400
		  End If
		  Dim yoe As Int64 = yy - era * 400
		  Dim mp As Integer
		  If m > 2 Then
		    mp = m - 3
		  Else
		    mp = m + 9
		  End If
		  Dim doy As Int64 = (153 * mp + 2) \ 5 + d - 1
		  Dim doe As Int64 = yoe * 365 + yoe \ 4 - yoe \ 100 + doy
		  Dim zz As Int64 = era * 146097 + doe
		  Return zz - 305   ' inverse of the "+305" offset used in GregorianFromFixed
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function FixedFromHebrew(year As Integer, month As Integer, day As Integer) As Int64
		  Dim total As Int64 = 0
		  Dim m As Integer
		  If month < 7 Then
		    For m = 7 To LastMonthOfHebrewYear(year)
		      total = total + HebrewMonthDays(year, m)
		    Next
		    For m = 1 To month - 1
		      total = total + HebrewMonthDays(year, m)
		    Next
		  Else
		    For m = 7 To month - 1
		      total = total + HebrewMonthDays(year, m)
		    Next
		  End If
		  Return HebrewNewYear(year) + total + (day - 1)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FrenchName(holiday As HolidayType) As String
		  ' Returns the French name of a holiday.
		  Select Case holiday
		  Case HolidayType.RoshHashanah
		    Return "Rosh Hashana"
		  Case HolidayType.YomKippur
		    Return "Yom Kippour"
		  Case HolidayType.SukkotFirstDay
		    Return "Souccot (1er jour)"
		  Case HolidayType.HoshanaRabbah
		    Return "Hoshana Rabba"
		  Case HolidayType.SheminiAtzeret
		    Return "Chemini Atseret"
		  Case HolidayType.SimchatTorah_Diaspora
		    Return "Simhat Torah (diaspora)"
		  Case HolidayType.SimchatTorah_Israel
		    Return "Simhat Torah (Israël)"
		  Case HolidayType.HanukkahFirstDay
		    Return "Hanoucca (1er jour)"
		  Case HolidayType.TuBishvat
		    Return "Tou Bichvat"
		  Case HolidayType.Purim
		    Return "Pourim"
		  Case HolidayType.PassoverFirstDay
		    Return "Pessa'h (1er jour)"
		  Case HolidayType.PassoverSeventhDay
		    Return "Pessa'h (7e jour)"
		  Case HolidayType.PassoverEighthDay_Diaspora
		    Return "Pessa'h (8e jour - diaspora)"
		  Case HolidayType.YomHaShoah
		    Return "Yom HaShoah"
		  Case HolidayType.YomHaZikaron, HolidayType.YomHaZikaron_ApplyCivilShift
		    Return "Yom Hazikaron"
		  Case HolidayType.YomHaatzmaut, HolidayType.YomHaatzmaut_ApplyCivilShift
		    Return "Yom Haatsmaout"
		  Case HolidayType.LagBaOmer
		    Return "Lag Baomer"
		  Case HolidayType.Shavuot
		    Return "Chavouot"
		  Case HolidayType.TzomGedaliah, HolidayType.TzomGedaliah_ApplyShabbatShift
		    Return "Jeûne de Guedalia"
		  Case HolidayType.AsaraBeTevet, HolidayType.AsaraBeTevet_ApplyShabbatShift
		    Return "Jeûne du 10 Tevet"
		  Case HolidayType.TaanitEsther, HolidayType.TaanitEsther_ApplyShabbatShift
		    Return "Jeûne d'Esther"
		  Case HolidayType.ShivaAsarBeTammuz,  HolidayType.ShivaAsarBeTammuz_ApplyShabbatShift
		    Return "Jeûne du 17 Tamouz"
		  End Select
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromString(value as String) As AnnualEvent
		  Return AnnualEventFixed.FromString(value)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GermanName(holiday As HolidayType) As String
		  ' Returns the German name of a holiday.
		  Select Case holiday
		  Case HolidayType.RoshHashanah
		    Return "Rosch Haschana"
		  Case HolidayType.YomKippur
		    Return "Jom Kippur"
		  Case HolidayType.SukkotFirstDay
		    Return "Sukkot (1. Tag)"
		  Case HolidayType.HoshanaRabbah
		    Return "Hoschana Rabba"
		  Case HolidayType.SheminiAtzeret
		    Return "Schmini Azeret"
		  Case HolidayType.SimchatTorah_Diaspora
		    Return "Simchat Tora (Diaspora)"
		  Case HolidayType.SimchatTorah_Israel
		    Return "Simchat Tora (Israel)"
		  Case HolidayType.HanukkahFirstDay
		    Return "Chanukka (1. Tag)"
		  Case HolidayType.TuBishvat
		    Return "Tu BiSchwat"
		  Case HolidayType.Purim
		    Return "Purim"
		  Case HolidayType.PassoverFirstDay
		    Return "Pessach (1. Tag)"
		  Case HolidayType.PassoverSeventhDay
		    Return "Pessach (7. Tag)"
		  Case HolidayType.PassoverEighthDay_Diaspora
		    Return "Pessach (8. Tag - Diaspora)"
		  Case HolidayType.YomHaShoah
		    Return "Jom haScho'a"
		  Case HolidayType.YomHaZikaron, HolidayType.YomHaZikaron_ApplyCivilShift
		    Return "Jom HaSikaron"
		  Case HolidayType.YomHaatzmaut, HolidayType.YomHaatzmaut_ApplyCivilShift
		    Return "Jom Haatzma'ut"
		  Case HolidayType.LagBaOmer
		    Return "Lag baOmer"
		  Case HolidayType.Shavuot
		    Return "Schawuot"
		  Case HolidayType.TzomGedaliah, HolidayType.TzomGedaliah_ApplyShabbatShift
		    Return "Fasten Gedaljas"
		  Case HolidayType.AsaraBeTevet, HolidayType.AsaraBeTevet_ApplyShabbatShift
		    Return "Zehnter Tevet"
		  Case HolidayType.TaanitEsther, HolidayType.TaanitEsther_ApplyShabbatShift
		    Return "Ester-Fasten"
		  Case HolidayType.ShivaAsarBeTammuz, HolidayType.ShivaAsarBeTammuz_ApplyShabbatShift
		    Return "Siebzehnter Tammus"
		  End Select
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub GregorianFromFixed(rd As Int64, ByRef y As Integer, ByRef m As Integer, ByRef d As Integer)
		  ' Conversion RD -> Gregorian date (civil_from_days algorithm, H. Hinnant)
		  Dim zz As Int64 = rd + 305   ' 305 = -719163 (RD of 1970-01-01) + 719468 (internal offset)
		  Dim era As Int64
		  If zz >= 0 Then
		    era = zz \ 146097
		  Else
		    era = (zz - 146096) \ 146097
		  End If
		  Dim doe As Int64 = zz - era * 146097
		  Dim yoe As Int64 = (doe - doe \ 1460 + doe \ 36524 - doe \ 146096) \ 365
		  Dim yy As Int64 = yoe + era * 400
		  Dim doy As Int64 = doe - (365 * yoe + yoe \ 4 - yoe \ 100)
		  Dim mp As Int64 = (5 * doy + 2) \ 153
		  Dim dd As Int64 = doy - (153 * mp + 2) \ 5 + 1
		  Dim mm As Int64
		  If mp < 10 Then
		    mm = mp + 3
		  Else
		    mm = mp - 9
		  End If
		  If mm <= 2 Then yy = yy + 1
		  
		  y = yy
		  m = mm
		  d = dd
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub GregorianToHebraic(dtGregorian As DateTime, ByRef hYear As Integer, ByRef hMonth As Integer, ByRef hDay As Integer)
		  ' Converts a Gregorian DateTime into its Hebrew calendar equivalent
		  ' (year, month, day). Shared: call it as
		  ' AnnualEventHebraic.GregorianToHebraic(...), no instance needed.
		  Dim rd As Int64 = FixedFromGregorian(dtGregorian.Year, dtGregorian.Month, dtGregorian.Day)
		  
		  ' Estimate the Hebrew year, then adjust to the exact one that
		  ' contains this fixed day (the estimate is always off by at most 1).
		  Dim hy As Integer = dtGregorian.Year + 3760
		  While HebrewNewYear(hy + 1) <= rd
		    hy = hy + 1
		  Wend
		  While HebrewNewYear(hy) > rd
		    hy = hy - 1
		  Wend
		  
		  ' Walk through the months of that Hebrew year (Tishri..Adar/AdarII,
		  ' then Nisan..Elul) until we find the one containing this day.
		  Dim monthOrder() As Integer
		  Dim mm As Integer
		  For mm = 7 To LastMonthOfHebrewYear(hy)
		    monthOrder.Append(mm)
		  Next
		  For mm = 1 To 6
		    monthOrder.Append(mm)
		  Next
		  
		  Dim remaining As Int64 = rd - HebrewNewYear(hy)
		  Dim idx As Integer
		  For idx = 0 To UBound(monthOrder)
		    Dim mDays As Integer = HebrewMonthDays(hy, monthOrder(idx))
		    If remaining < mDays Then
		      hYear = hy
		      hMonth = monthOrder(idx)
		      hDay = remaining + 1
		      Return
		    End If
		    remaining = remaining - mDays
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function HebraicToGregorian(hYear As Integer, hMonth As Integer, hDay As Integer) As DateTime
		  ' Converts a Hebrew calendar date (year, month, day) into the
		  ' matching Gregorian DateTime (time = 00:00:00). Inverse of
		  ' GregorianToHebraic. Shared: call it as
		  ' AnnualEventHebraic.HebraicToGregorian(...), no instance needed.
		  Dim rd As Int64 = FixedFromHebrew(hYear, hMonth, hDay)
		  Dim y, m, d As Integer
		  GregorianFromFixed(rd, y, m, d)
		  Return New DateTime(y, m, d, 0, 0, 0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function HebrewCalendarElapsedDays(year As Integer) As Int64
		  Dim y As Int64 = year - 1
		  Dim monthsElapsed As Int64
		  monthsElapsed = 235 * (y \ 19) + 12 * (y Mod 19) + ((7 * (y Mod 19) + 1) \ 19)
		  
		  Dim partsElapsed As Int64 = 204 + 793 * (monthsElapsed Mod 1080)
		  Dim hoursElapsed As Int64 = 5 + 12 * monthsElapsed + 793 * (monthsElapsed \ 1080) + (partsElapsed \ 1080)
		  Dim conjunctionDay As Int64 = 1 + 29 * monthsElapsed + (hoursElapsed \ 24)
		  Dim conjunctionParts As Int64 = 1080 * (hoursElapsed Mod 24) + (partsElapsed Mod 1080)
		  
		  Dim altDay As Int64
		  If (conjunctionParts >= 19440) _
		    Or (((conjunctionDay Mod 7) = 2) And (conjunctionParts >= 9924) And (Not IsHebrewLeapYear(year))) _
		    Or (((conjunctionDay Mod 7) = 1) And (conjunctionParts >= 16789) And (IsHebrewLeapYear(year - 1))) Then
		    altDay = conjunctionDay + 1
		  Else
		    altDay = conjunctionDay
		  End If
		  
		  If (altDay Mod 7 = 0) Or (altDay Mod 7 = 3) Or (altDay Mod 7 = 5) Then
		    altDay = altDay + 1
		  End If
		  
		  Return altDay
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function HebrewMonthDays(year As Integer, month As Integer) As Integer
		  Select Case month
		  Case 7   ' Tishri
		    Return 30
		  Case 8   ' Heshvan (variable)
		    If IsLongHesvan(year) Then Return 30 Else Return 29
		  Case 9   ' Kislev (variable)
		    If IsShortKislev(year) Then Return 29 Else Return 30
		  Case 10  ' Tevet
		    Return 29
		  Case 11  ' Shevat
		    Return 30
		  Case 12  ' Adar / Adar I
		    If IsHebrewLeapYear(year) Then Return 30 Else Return 29
		  Case 13  ' Adar II (leap year only)
		    Return 29
		  Case 1   ' Nisan
		    Return 30
		  Case 2   ' Iyar
		    Return 29
		  Case 3   ' Sivan
		    Return 30
		  Case 4   ' Tamuz
		    Return 29
		  Case 5   ' Av
		    Return 30
		  Case 6   ' Elul
		    Return 29
		  End Select
		  Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function HebrewNewYear(year As Integer) As Int64
		  ' Fixed day (RD) of the 1st of Tishri of Hebrew year "year"
		  Return HEBREW_EPOCH + HebrewCalendarElapsedDays(year)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function HolidayCode(holiday As HolidayType) As String
		  ' Returns a short (2 to 4 character) code identifying the holiday,
		  ' loosely based on its initials. Always returned in uppercase;
		  ' HolidayFromCode is case-insensitive, so either case works as
		  ' input. Shared: call it as AnnualEventHebraic.HolidayCode(...).
		  Select Case holiday
		  Case HolidayType.RoshHashanah
		    Return "RH"
		  Case HolidayType.YomKippur
		    Return "YK"
		  Case HolidayType.SukkotFirstDay
		    Return "SUK"
		  Case HolidayType.HoshanaRabbah
		    Return "HR"
		  Case HolidayType.SheminiAtzeret
		    Return "SA"
		  Case HolidayType.SimchatTorah_Diaspora
		    Return "STD"
		  Case HolidayType.SimchatTorah_Israel
		    Return "STI"
		  Case HolidayType.HanukkahFirstDay
		    Return "HAN"
		  Case HolidayType.TuBishvat
		    Return "TB"
		  Case HolidayType.Purim
		    Return "PUR"
		  Case HolidayType.PassoverFirstDay
		    Return "PE1"
		  Case HolidayType.PassoverSeventhDay
		    Return "PE7"
		  Case HolidayType.PassoverEighthDay_Diaspora
		    Return "PE8"
		  Case HolidayType.YomHaShoah
		    Return "YHS"
		  Case HolidayType.YomHaZikaron
		    Return "YHZ"
		  Case HolidayType.YomHaZikaron_ApplyCivilShift
		    Return "YHZC"
		  Case HolidayType.YomHaatzmaut
		    Return "YHA"
		  Case HolidayType.YomHaatzmaut_ApplyCivilShift
		    Return "YHAC"
		  Case HolidayType.LagBaOmer
		    Return "LBO"
		  Case HolidayType.Shavuot
		    Return "SHV"
		  Case HolidayType.TzomGedaliah
		    Return "TG"
		  Case HolidayType.TzomGedaliah_ApplyShabbatShift
		    Return "TGS"
		  Case HolidayType.AsaraBeTevet
		    Return "ABT"
		  Case HolidayType.AsaraBeTevet_ApplyShabbatShift
		    Return "ABTS"
		  Case HolidayType.TaanitEsther
		    Return "TE"
		  Case HolidayType.TaanitEsther_ApplyShabbatShift
		    Return "TES"
		  Case HolidayType.ShivaAsarBeTammuz
		    Return "SBT"
		  Case HolidayType.ShivaAsarBeTammuz_ApplyShabbatShift
		    Return "SBTS"
		  Case HolidayType.Custom
		    Return "CUST"
		  End Select
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function HolidayFromCode(code As String) As HolidayType
		  ' Inverse of HolidayCode: resolves a 2-4 character code (case
		  ' insensitive) back to a HolidayType. Returns HolidayType.Unknown
		  ' if the code is not recognized. Shared: call it as
		  ' AnnualEventHebraic.HolidayFromCode(...).
		  Select Case code.Uppercase
		  Case "RH"
		    Return HolidayType.RoshHashanah
		  Case "YK"
		    Return HolidayType.YomKippur
		  Case "SUK"
		    Return HolidayType.SukkotFirstDay
		  Case "HR"
		    Return HolidayType.HoshanaRabbah
		  Case "SA"
		    Return HolidayType.SheminiAtzeret
		  Case "STD"
		    Return HolidayType.SimchatTorah_Diaspora
		  Case "STI"
		    Return HolidayType.SimchatTorah_Israel
		  Case "HAN"
		    Return HolidayType.HanukkahFirstDay
		  Case "TB"
		    Return HolidayType.TuBishvat
		  Case "PUR"
		    Return HolidayType.Purim
		  Case "PE1"
		    Return HolidayType.PassoverFirstDay
		  Case "PE7"
		    Return HolidayType.PassoverSeventhDay
		  Case "PE8"
		    Return HolidayType.PassoverEighthDay_Diaspora
		  Case "YHS"
		    Return HolidayType.YomHaShoah
		  Case "YHZ"
		    Return HolidayType.YomHaZikaron
		  Case "YHZC"
		    Return HolidayType.YomHaZikaron_ApplyCivilShift
		  Case "YHA"
		    Return HolidayType.YomHaatzmaut
		  Case "YHAC"
		    Return HolidayType.YomHaatzmaut_ApplyCivilShift
		  Case "LBO"
		    Return HolidayType.LagBaOmer
		  Case "SHV"
		    Return HolidayType.Shavuot
		  Case "TG"
		    Return HolidayType.TzomGedaliah
		  Case "TGS"
		    Return HolidayType.TzomGedaliah_ApplyShabbatShift
		  Case "ABT"
		    Return HolidayType.AsaraBeTevet
		  Case "ABTS"
		    Return HolidayType.AsaraBeTevet_ApplyShabbatShift
		  Case "TE"
		    Return HolidayType.TaanitEsther
		  Case "TES"
		    Return HolidayType.TaanitEsther_ApplyShabbatShift
		  Case "SBT"
		    Return HolidayType.ShivaAsarBeTammuz
		  Case "SBTS"
		    Return HolidayType.ShivaAsarBeTammuz_ApplyShabbatShift
		  case "CUST"
		    Return HolidayType.Custom
		  End Select
		  Return HolidayType.Unknown
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub HolidayMonthDay(holiday As HolidayType, ByRef hMonth As Integer, ByRef hDay As Integer, forYear As Integer)
		  ' Returns the Hebrew month/day for a given holiday. "forYear" is
		  ' only needed to resolve Purim's Adar/Adar II depending on whether
		  ' that Hebrew year is a leap year.
		  Select Case holiday
		  Case HolidayType.RoshHashanah
		    hMonth = 7
		    hDay = 1
		  Case HolidayType.YomKippur
		    hMonth = 7
		    hDay = 10
		  Case HolidayType.SukkotFirstDay
		    hMonth = 7
		    hDay = 15
		  Case HolidayType.HoshanaRabbah
		    hMonth = 7
		    hDay = 21
		  Case HolidayType.SheminiAtzeret
		    hMonth = 7
		    hDay = 22
		  Case HolidayType.SimchatTorah_Diaspora
		    hMonth = 7
		    hDay = 23
		  Case HolidayType.SimchatTorah_Israel
		    hMonth = 7
		    hDay = 22
		  Case HolidayType.HanukkahFirstDay
		    hMonth = 9
		    hDay = 25
		  Case HolidayType.TuBishvat
		    hMonth = 11
		    hDay = 15
		  Case HolidayType.Purim
		    If (forYear <> 0) And IsHebrewLeapYear(forYear) Then
		      hMonth = 13
		    Else
		      hMonth = 12
		    End If
		    hDay = 14
		  Case HolidayType.PassoverFirstDay
		    hMonth = 1
		    hDay = 15
		  Case HolidayType.PassoverSeventhDay
		    hMonth = 1
		    hDay = 21
		  Case HolidayType.PassoverEighthDay_Diaspora
		    hMonth = 1
		    hDay = 22
		  Case HolidayType.YomHaShoah
		    hMonth = 1
		    hDay = 27
		  Case HolidayType.YomHaZikaron, HolidayType.YomHaZikaron_ApplyCivilShift
		    hMonth = 2
		    hDay = 4
		  Case HolidayType.YomHaatzmaut, HolidayType.YomHaatzmaut_ApplyCivilShift
		    hMonth = 2
		    hDay = 5
		  Case HolidayType.LagBaOmer
		    hMonth = 2
		    hDay = 18
		  Case HolidayType.Shavuot
		    hMonth = 3
		    hDay = 6
		  Case HolidayType.TzomGedaliah, HolidayType.TzomGedaliah_ApplyShabbatShift
		    hMonth = 7
		    hDay = 3
		  Case HolidayType.AsaraBeTevet, HolidayType.AsaraBeTevet_ApplyShabbatShift
		    hMonth = 10
		    hDay = 10
		  Case HolidayType.TaanitEsther, HolidayType.TaanitEsther_ApplyShabbatShift
		    If (forYear <> 0) And IsHebrewLeapYear(forYear) Then
		      hMonth = 13
		    Else
		      hMonth = 12
		    End If
		    hDay = 13
		  Case HolidayType.ShivaAsarBeTammuz, HolidayType.ShivaAsarBeTammuz_ApplyShabbatShift
		    hMonth = 4
		    hDay = 17
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsEventDate(d as DateTime) As Boolean
		  ' Tests whether a Gregorian date falls on this instance's holiday.
		  ' For the six "_ApplyCivilShift"/"_ApplyShabbatShift" variants, this
		  ' compares against the officially/halachically postponed date (see
		  ' DateValue) rather than the raw Hebrew month/day, since the
		  ' postponement can shift the Hebrew day itself.
		  
		  if d = nil then Return False
		  
		  If Me.Holiday = HolidayType.Unknown Then Return False
		  
		  Var dt As New DateTime(d.Year, d.Month, d.Day, 0,0,0,0, d.Timezone)
		  
		  If dt < Me.StartOfValidity Or dt > Me.EndOfValidity Then Return False
		  
		  If Me.CycleYearDuration > 1 Then
		    If Me.CycleFirstYear > dt.year Then Return False
		    If (dt.year - Me.CycleFirstYear) Mod Me.CycleYearDuration > 0 Then Return False
		  End
		  
		  
		  If (Holiday = HolidayType.YomHaatzmaut_ApplyCivilShift) _
		    Or (Holiday = HolidayType.YomHaZikaron_ApplyCivilShift) _
		    Or (Holiday = HolidayType.TzomGedaliah_ApplyShabbatShift) _
		    Or (Holiday = HolidayType.AsaraBeTevet_ApplyShabbatShift) _
		    Or (Holiday = HolidayType.TaanitEsther_ApplyShabbatShift) _
		    Or (Holiday = HolidayType.ShivaAsarBeTammuz_ApplyShabbatShift) Then
		    Dim shifted As DateTime = DateValue(d.Year)
		    If shifted = Nil Then Return False
		    Return (shifted.Year = dt.Year) And (shifted.Month = dt.Month) And (shifted.Day = dt.Day)
		  End If
		  
		  Dim hy, hm, hd As Integer
		  GregorianToHebraic(dt, hy, hm, hd)
		  
		  If Holiday <> HolidayType.Custom Then
		    HolidayMonthDay(Holiday, hMonth, hDay, hy)
		  End If
		  
		  Return (hm = hMonth) And (hd = hDay)
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function IsHebrewLeapYear(year As Integer) As Boolean
		  Return ((7 * year + 1) Mod 19) < 7
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function IsLongHesvan(year As Integer) As Boolean
		  Dim d As Integer = DaysInHebrewYear(year)
		  Return (d = 355) Or (d = 385)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function IsShortKislev(year As Integer) As Boolean
		  Dim d As Integer = DaysInHebrewYear(year)
		  Return (d = 353) Or (d = 383)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function JulianDayFromGregorian(y As Integer, m As Integer, d As Integer) As Double
		  ' Julian Date (fractional day count, UT) at 00:00 of the given
		  ' Gregorian calendar date. Standard Meeus algorithm. This is a
		  ' different day-numbering system from RD (used elsewhere in this
		  ' class); it exists solely for the sun-position formulas below,
		  ' which are conventionally expressed in Julian Date.
		  Dim yy As Integer = y
		  Dim mm As Integer = m
		  If mm <= 2 Then
		    yy = yy - 1
		    mm = mm + 12
		  End If
		  Dim a As Integer = yy \ 100
		  Dim b As Integer = 2 - a + (a \ 4)
		  Return Floor(365.25 * (yy + 4716)) + Floor(30.6001 * (mm + 1)) + d + b - 1524.5
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function LastMonthOfHebrewYear(year As Integer) As Integer
		  If IsHebrewLeapYear(year) Then
		    Return 13
		  Else
		    Return 12
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ModernHebrewName(holiday As HolidayType) As String
		  ' Returns the modern Hebrew name of a holiday. Shared: call it as
		  ' AnnualEventHebraic.ModernHebrewName(...), no instance needed.
		  Select Case holiday
		  Case HolidayType.RoshHashanah
		    Return "ראש השנה"
		  Case HolidayType.YomKippur
		    Return "יום כיפור"
		  Case HolidayType.SukkotFirstDay
		    Return "סוכות"
		  Case HolidayType.HoshanaRabbah
		    Return "הושענא רבה"
		  Case HolidayType.SheminiAtzeret
		    Return "שמיני עצרת"
		  Case HolidayType.SimchatTorah_Diaspora, HolidayType.SimchatTorah_Israel
		    Return "שמחת תורה"
		  Case HolidayType.HanukkahFirstDay
		    Return "חנוכה"
		  Case HolidayType.TuBishvat
		    Return "ט""ו בשבט"
		  Case HolidayType.Purim
		    Return "פורים"
		  Case HolidayType.PassoverFirstDay, HolidayType.PassoverSeventhDay
		    Return "פסח"
		  Case HolidayType.PassoverEighthDay_Diaspora
		    Return "שמיני של פסח"
		  Case HolidayType.YomHaShoah
		    Return "יום השואה"
		  Case HolidayType.YomHaZikaron, HolidayType.YomHaZikaron_ApplyCivilShift
		    Return "יום הזיכרון"
		  Case HolidayType.YomHaatzmaut, HolidayType.YomHaatzmaut_ApplyCivilShift
		    Return "יום העצמאות"
		  Case HolidayType.LagBaOmer
		    Return "ל""ג בעומר"
		  Case HolidayType.Shavuot
		    Return "שבועות"
		  Case HolidayType.TzomGedaliah, HolidayType.TzomGedaliah_ApplyShabbatShift
		    Return "צום גדליה"
		  Case HolidayType.AsaraBeTevet, HolidayType.AsaraBeTevet_ApplyShabbatShift
		    Return "עשרה בטבת"
		  Case HolidayType.TaanitEsther, HolidayType.TaanitEsther_ApplyShabbatShift
		    Return "תענית אסתר"
		  Case HolidayType.ShivaAsarBeTammuz, HolidayType.ShivaAsarBeTammuz_ApplyShabbatShift
		    Return "שבעה עשר בתמוז"
		  End Select
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ShiftDays(dt As DateTime, days As Integer) As DateTime
		  ' Returns a new DateTime shifted by the given number of days
		  ' (positive = later, negative = earlier). Uses Xojo's built-in
		  ' DateTime.AddInterval, which handles month/year boundaries itself -
		  ' no need to go through our own RD arithmetic for a simple day shift.
		  Return dt.AddInterval(0, 0, days)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ShiftedMinorFast(rawDate As DateTime) As DateTime
		  ' The three "tragedy" minor fasts (Tzom Gedaliah, Asara BeTevet,
		  ' Shiva Asar BeTammuz) are postponed to Sunday if they fall on
		  ' Shabbat (fasting is not permitted on Shabbat, except Yom Kippur).
		  If rawDate.DayOfWeek = 7 Then   ' Saturday
		    Return ShiftDays(rawDate, 1)
		  Else
		    Return rawDate
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ShiftedTaanitEsther(rawDate As DateTime) As DateTime
		  ' Ta'anit Esther cannot be postponed to Sunday like the other minor
		  ' fasts (Sunday would be Purim itself), so when 13 Adar/Adar II
		  ' falls on Shabbat it is instead advanced to the preceding Thursday
		  ' (11 Adar/Adar II).
		  If rawDate.DayOfWeek = 7 Then   ' Saturday
		    Return ShiftDays(rawDate, -2)
		  Else
		    Return rawDate
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ShiftedYomHaatzmaut(hy As Integer) As DateTime
		  ' Applies Israel's official weekday-postponement rule (Independence
		  ' Day Law, 1949, amended 2004) to the raw 5 Iyar date:
		  '   - Saturday -> moved back to Thursday (3 Iyar)
		  '   - Friday   -> moved back to Thursday (4 Iyar)
		  '   - Monday   -> moved forward to Tuesday (6 Iyar)
		  '   - any other weekday -> unchanged (5 Iyar can never fall on a
		  '     Sunday, by construction of the Hebrew calendar)
		  Dim raw As DateTime = HebraicToGregorian(hy, 2, 5)
		  Select Case raw.DayOfWeek   ' Xojo: 1=Sunday ... 7=Saturday
		  Case 7
		    Return ShiftDays(raw, -2)
		  Case 6
		    Return ShiftDays(raw, -1)
		  Case 2
		    Return ShiftDays(raw, 1)
		  Else
		    Return raw
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function SpanishName(holiday As HolidayType) As String
		  ' Returns the Spanish name of a holiday.
		  Select Case holiday
		  Case HolidayType.RoshHashanah
		    Return "Rosh Hashaná"
		  Case HolidayType.YomKippur
		    Return "Iom Kipur"
		  Case HolidayType.SukkotFirstDay
		    Return "Sucot (1er día)"
		  Case HolidayType.HoshanaRabbah
		    Return "Hoshaná Rabá"
		  Case HolidayType.SheminiAtzeret
		    Return "Sheminí Atséret"
		  Case HolidayType.SimchatTorah_Diaspora
		    Return "Simjat Torá (diáspora)"
		  Case HolidayType.SimchatTorah_Israel
		    Return "Simjat Torá (Israel)"
		  Case HolidayType.HanukkahFirstDay
		    Return "Janucá (1er día)"
		  Case HolidayType.TuBishvat
		    Return "Tu BiShvat"
		  Case HolidayType.Purim
		    Return "Purim"
		  Case HolidayType.PassoverFirstDay
		    Return "Pésaj (1er día)"
		  Case HolidayType.PassoverSeventhDay
		    Return "Pésaj (7º día)"
		  Case HolidayType.PassoverEighthDay_Diaspora
		    Return "Pésaj (8º día - diáspora)"
		  Case HolidayType.YomHaShoah
		    Return "Iom HaShoá"
		  Case HolidayType.YomHaZikaron, HolidayType.YomHaZikaron_ApplyCivilShift
		    Return "Iom HaZikaron"
		  Case HolidayType.YomHaatzmaut, HolidayType.YomHaatzmaut_ApplyCivilShift
		    Return "Iom Ha'atzmaut"
		  Case HolidayType.LagBaOmer
		    Return "Lag BaÓmer"
		  Case HolidayType.Shavuot
		    Return "Shavuot"
		  Case HolidayType.TzomGedaliah, HolidayType.TzomGedaliah_ApplyShabbatShift
		    Return "Ayuno de Guedalías"
		  Case HolidayType.AsaraBeTevet, HolidayType.AsaraBeTevet_ApplyShabbatShift
		    Return "Ayuno del 10 de Tevet"
		  Case HolidayType.TaanitEsther, HolidayType.TaanitEsther_ApplyShabbatShift
		    Return "Ayuno de Ester"
		  Case HolidayType.ShivaAsarBeTammuz, HolidayType.ShivaAsarBeTammuz_ApplyShabbatShift
		    Return "17 de Tamuz"
		  End Select
		  Return ""
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

	#tag Method, Flags = &h21
		Private Shared Function SunEventTime(dt As DateTime, latitude As Double, longitude As Double, altitude As Double, isSunset As Boolean) As DateTime
		  ' Shared implementation for SunriseTime/SunsetTime, based on the
		  ' NOAA/Astronomical Almanac "sunrise equation" (accurate to about a
		  ' minute). latitude/longitude in decimal degrees, positive North
		  ' and East. Only the calendar date of "dt" is used for the
		  ' computation; the result is expressed in dt's own TimeZone, so
		  ' pass a DateTime already carrying the correct GMT offset for the
		  ' location (e.g. New DateTime(y, m, d, 0, 0, 0, New TimeZone("Asia/Jerusalem"))).
		  ' Returns Nil for polar day/night, where the sun does not rise or
		  ' set at all on that date at that latitude.
		  Const degToRad As Double = 0.017453292519943295   ' Pi / 180
		  
		  Dim jd As Double = JulianDayFromGregorian(dt.Year, dt.Month, dt.Day)
		  
		  ' The formula's "lw" is longitude west of Greenwich (positive west,
		  ' negative east); our input follows the usual convention (positive
		  ' east), hence the sign flip.
		  Dim lw As Double = -longitude
		  
		  Dim nStar As Double = jd - 2451545.0009 - lw / 360.0
		  Dim n As Double = Round(nStar)
		  
		  Dim jApprox As Double = 2451545.0009 + lw / 360.0 + n
		  
		  Dim m As Double = 357.5291 + 0.98560028 * (jApprox - 2451545.0)
		  m = m - Floor(m / 360.0) * 360.0   ' normalize to [0, 360)
		  Dim mRad As Double = m * degToRad
		  
		  Dim c As Double = 1.9148 * Sin(mRad) + 0.0200 * Sin(2 * mRad) + 0.0003 * Sin(3 * mRad)
		  
		  Dim lambda As Double = m + 102.9372 + c + 180.0
		  lambda = lambda - Floor(lambda / 360.0) * 360.0
		  Dim lambdaRad As Double = lambda * degToRad
		  
		  Dim jTransit As Double = jApprox + 0.0053 * Sin(mRad) - 0.0069 * Sin(2 * lambdaRad)
		  
		  Dim obliquityRad As Double = 23.44 * degToRad
		  Dim declRad As Double = Asin(Sin(lambdaRad) * Sin(obliquityRad))
		  
		  Dim latRad As Double = latitude * degToRad
		  
		  ' Horizon dip caused by observer altitude: the higher up, the
		  ' farther away the visible horizon is, so the sun is still visible
		  ' below the "sea level" horizon angle. Standard approximation.
		  Dim horizonAngle As Double = -0.833
		  If altitude > 0 Then
		    horizonAngle = horizonAngle - 0.0347 * Sqrt(altitude)
		  End If
		  
		  Dim cosOmega As Double = (Sin(horizonAngle * degToRad) - Sin(latRad) * Sin(declRad)) _
		  / (Cos(latRad) * Cos(declRad))
		  
		  If (cosOmega > 1.0) Or (cosOmega < -1.0) Then
		    Return Nil
		  End If
		  
		  Dim omegaDeg As Double = Acos(cosOmega) / degToRad
		  
		  Dim jEvent As Double
		  If isSunset Then
		    jEvent = jTransit + omegaDeg / 360.0
		  Else
		    jEvent = jTransit - omegaDeg / 360.0
		  End If
		  
		  Return DateTimeFromJulianDay(jEvent, dt.TimeZone)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function SunriseTime(dt As DateTime, latitude As Double, longitude As Double, Optional altitude As Double = 0) As DateTime
		  ' Time of sunrise, symmetric to SunsetTime. Returns Nil during
		  ' polar winter (sun never rises that day at that latitude).
		  ' altitude: see SunsetTime.
		  Return SunEventTime(dt, latitude, longitude, altitude, False)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function SunsetTime(dt As DateTime, latitude As Double, longitude As Double, Optional altitude As Double = 0) As DateTime
		  ' Time of sunset (top of the solar disk crossing the horizon, with
		  ' standard atmospheric refraction) on the calendar date of "dt", at
		  ' the given latitude/longitude (decimal degrees, positive North and
		  ' East). The result is a DateTime in dt's own TimeZone. Returns Nil
		  ' during polar summer (sun never sets that day at that latitude).
		  '
		  ' altitude (optional, meters above sea level, default 0): corrects
		  ' for the fact that a higher observer sees a farther, lower
		  ' horizon, so the sun appears to set later (and rise earlier) than
		  ' at sea level. Only worth setting for meaningfully elevated
		  ' locations (e.g. Jerusalem, ~750 m).
		  Return SunEventTime(dt, latitude, longitude, altitude, True)
		End Function
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
		  
		  s = "H|" // 0
		  s = s + EncodeBase64(Me.mCaption,0) + "|" // 1
		  s = s + Me.StartOfValidity.SQLDate + "|" // 2
		  s = s + Me.EndOfValidity.SQLDate + "|" // 3
		  s = s + Me.CycleFirstYear.ToString(Locale.Raw) + "|" // 4
		  s = s + Me.CycleYearDuration.ToString(Locale.Raw) + "|" // 5
		  If me.DayOff Then s = s + "1|" Else s = s + "0|" // 6
		  s = s + HolidayCode(Me.Holiday) + "|" // 7
		  s = s + Me.hMonth.ToString(Locale.Raw) + "|" // 8
		  s = s + Me.hDay.ToString(Locale.Raw) + "|" // 9
		  
		  Return s
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		#tag Note
			' The Hebrew month/day for this instance, resolved once by the
			' Constructor instead of being recomputed into fresh local
			' variables on every call. Same month numbering as the rest of
			' this class (7=Tishri...6=Elul).
			
			' The Hebrew month/day for this instance, resolved once by the
			' Constructor instead of being recomputed into fresh local
			' variables on every call. Same month numbering as the rest of
			' this class (7=Tishri...6=Elul).
			'
			' Exception: for Purim and TaanitEsther (and their
			' "_ApplyShabbatShift" variants), hMonth genuinely depends on
			' whether the *specific* Hebrew year being queried is a leap year
			' (12 = Adar, 13 = Adar II), so it cannot be fixed once and for
			' all at construction time - DateValue/IsEventDate still re-resolve
			' and overwrite hMonth for those, each time, against the Hebrew
			' year in question. For every other holiday, including Custom,
			' hMonth/hDay are set once by the Constructor and never change.
		#tag EndNote
		hDay As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		hMonth As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			' the holiday this instance represents
		#tag EndNote
		Holiday As HolidayType
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


	#tag Constant, Name = HEBREW_EPOCH, Type = , Dynamic = False, Default = \"-1373428", Scope = Private
	#tag EndConstant


	#tag Enum, Name = DisplayLanguage, Flags = &h0
		English
		  French
		  ModernHebrew
		  Dutch
		  German
		Spanish
	#tag EndEnum

	#tag Enum, Name = HolidayType, Flags = &h0
		RoshHashanah
		  YomKippur
		  SukkotFirstDay
		  HoshanaRabbah
		  SheminiAtzeret
		  SimchatTorah_Diaspora
		  SimchatTorah_Israel      ' same day as Shemini Atzeret (22 Tishri)
		  HanukkahFirstDay
		  TuBishvat
		  Purim
		  PassoverFirstDay
		  PassoverSeventhDay
		  PassoverEighthDay_Diaspora   ' does not exist in Israel (only 7 days)
		  YomHaShoah
		  YomHaZikaron
		  YomHaZikaron_ApplyCivilShift    ' YomHaZikaron with Israel's official weekday postponement rule
		  YomHaatzmaut
		  YomHaatzmaut_ApplyCivilShift    ' YomHaatzmaut with Israel's official weekday postponement rule
		  LagBaOmer
		  Shavuot
		  TzomGedaliah          ' minor fast, 3 Tishri (raw date)
		  TzomGedaliah_ApplyShabbatShift        ' postponed to Sunday if 3 Tishri falls on Shabbat
		  AsaraBeTevet          ' minor fast, 10 Tevet
		  AsaraBeTevet_ApplyShabbatShift        ' postponed to Sunday if 10 Tevet falls on Shabbat
		  TaanitEsther          ' minor fast, 13 Adar / Adar II
		  TaanitEsther_ApplyShabbatShift        ' advanced to the preceding Thursday if 13 Adar/Adar II falls on Shabbat
		  ShivaAsarBeTammuz     ' minor fast, 17 Tammuz
		  ShivaAsarBeTammuz_ApplyShabbatShift   ' postponed to Sunday if 17 Tammuz falls on Shabbat
		  Unknown               ' returned by HolidayFromCode when the code is not recognized
		Custom                ' user-defined event - see Constructor(month, day)
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
			Name="Holiday"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="HolidayType"
			EditorType="Enum"
			#tag EnumValues
				"0 - RoshHashanah"
				"1 - YomKippur"
				"2 - SukkotFirstDay"
				"3 - HoshanaRabbah"
				"4 - SheminiAtzeret"
				"5 - SimchatTorah_Diaspora"
				"6 - SimchatTorah_Israel"
				"7 - HanukkahFirstDay"
				"8 - TuBishvat"
				"9 - Purim"
				"10 - PassoverFirstDay"
				"11 - PassoverSeventhDay"
				"12 - PassoverEighthDay_Diaspora"
				"13 - YomHaShoah"
				"14 - YomHaZikaron"
				"15 - YomHaZikaron_ApplyCivilShift"
				"16 - YomHaatzmaut"
				"17 - YomHaatzmaut_ApplyCivilShift"
				"18 - LagBaOmer"
				"19 - Shavuot"
				"20 - TzomGedaliah"
				"21 - TzomGedaliah_ApplyShabbatShift"
				"22 - AsaraBeTevet"
				"23 - AsaraBeTevet_ApplyShabbatShift"
				"24 - TaanitEsther"
				"25 - TaanitEsther_ApplyShabbatShift"
				"26 - ShivaAsarBeTammuz"
				"27 - ShivaAsarBeTammuz_ApplyShabbatShift"
				"28 - Unknown"
				"29 - Custom"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="hMonth"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="hDay"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
