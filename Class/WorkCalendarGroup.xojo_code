#tag Class
Protected Class WorkCalendarGroup
	#tag Method, Flags = &h21
		Private Sub AddClosurePeriods(FirstDay as DateTime, LastDay as DateTime, cp() as ClosurePeriod, R as WorkCalendar)
		  For c As Integer = 0 To R.ClosurePeriods.LastIndex
		    If FirstDay <= R.ClosurePeriods(c).LastDay And LastDay >= R.ClosurePeriods(c).FirstDay Then cp.Add R.ClosurePeriods(c)
		  Next
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

	#tag Method, Flags = &h0
		Function BusinessDayOffsetEverywhere(startdate as datetime, number as integer = 1, limit as integer = 366) As DateTime
		  // if number is 1, this means the immediately following business day. 
		  // If the number is 2, it means the second following business day, and so on.
		  
		  If startdate  = Nil Then 
		    Raise New NilObjectException
		    Return Nil
		  End
		  
		  If number = 0 Then Return startdate // Trivial case
		  
		  if not OnCalendarEnabled then Return Nil
		  
		  // Duplicating the date and using a counter
		  Var dt As New DateTime(startdate), counter As Integer
		  Var dLimit As DateTime 
		  if number > 0 then
		    dLimit = dt.AddInterval(0,0,limit)
		  else
		    dLimit = dt.SubtractInterval(0,0,limit)
		  end
		  
		  Do 
		    
		    If number > 0 Then
		      dt = dt.AddInterval (0,0,1)
		    Else
		      dt = dt.SubtractInterval (0,0,1)
		    End
		    
		    If number > 0 And dt > dLimit Then Return Nil // Fail to find a day
		    If number < 0 And dt < dLimit Then Return Nil // Fail to find a day
		    
		    
		    for r as Integer = 0 to me.WorkCalendars.LastIndex
		      
		      if not me.WorkCalendars(r).Enabled then Continue for
		      
		      if not me.WorkCalendars(r).WorkingWeek.WorkingDay(dt.DayOfWeek) then Continue do
		      
		      if me.WorkCalendars(r).IsInClosurePeriod(dt) then Continue do
		      
		      If Me.WorkCalendars(r).IsAnnualEvent(dt, True) Then continue do
		      
		    Next r
		    
		    counter = counter + 1
		    
		  Loop Until counter = abs(number) 
		  
		  
		  Return dt
		  
		  
		  
		  
		  
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BusinessDayOffsetSomewhere(startdate as datetime, number as integer = 1, limit as integer = 366) As DateTime
		  // if number is 1, this means the immediately following business day. 
		  // If the number is 2, it means the second following business day, and so on.
		  
		  If startdate  = Nil Then 
		    Raise New NilObjectException
		    Return Nil
		  End
		  
		  If number = 0 Then Return startdate // Trivial case
		  
		  if not OnCalendarEnabled then Return Nil
		  
		  Var dt As New DateTime(startdate), counter As Integer
		  Var dLimit As DateTime 
		  If number > 0 Then
		    dLimit = dt.AddInterval(0,0,limit)
		  Else
		    dLimit = dt.SubtractInterval(0,0,limit)
		  End
		  
		  Do 
		    
		    
		    If number > 0 Then
		      dt = dt.AddInterval (0,0,1)
		    Else
		      dt = dt.SubtractInterval (0,0,1)
		    End
		    
		    If number > 0 And dt > dLimit Then Return Nil // Fail to find a day
		    If number < 0 And dt < dLimit Then Return Nil // Fail to find a day
		    
		    for r as Integer = 0 to me.WorkCalendars.LastIndex
		      
		      if not me.WorkCalendars(r).Enabled then Continue for 
		      
		      if not me.WorkCalendars(r).WorkingWeek.WorkingDay(dt.DayOfWeek) then Continue for // Not For this workcalendar, skip To the Next workcalendar
		      
		      if me.WorkCalendars(r).IsInClosurePeriod(dt) then Continue for // Not For this workcalendar, skip To the Next workcalendar
		      
		      If Me.WorkCalendars(r).IsAnnualEvent(dt, True) Then continue for // Not For this workcalendar, skip To the Next workcalendar
		      
		      counter = counter + 1
		      continue do // Skip the following calendars
		      
		    Next r
		    
		    
		    
		  Loop Until counter = abs(number) 
		  
		  
		  Return dt
		  
		  
		  
		  
		  
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BusinessDaysEverywhere(starting as DateTime, ending as DateTime) As DateTime()
		  If starting = Nil Then 
		    Raise New NilObjectException
		    Return Nil
		  End
		  
		  If ending = Nil Then 
		    Raise New NilObjectException
		    Return Nil
		  End
		  
		  Var list() As DateTime
		  if not me.OnCalendarEnabled then Return list // empty
		  
		  Var nStart As New DateTime(starting.Year, starting.Month, starting.day)
		  Var nEnd As New DateTime(ending.Year, ending.Month, ending.day)
		  
		  If nStart > nEnd Then Return list // empty
		  
		  Var d As DateTime = nStart.SubtractInterval(0,0,1)
		  
		  Do Until d = nEnd
		    
		    d = d.AddInterval(0,0,1)
		    
		    for i as Integer = 0 to me.WorkCalendars.LastIndex
		      
		      if not me.WorkCalendars(i).Enabled then Continue for // ignore
		      
		      If Not Me.WorkCalendars(i).WorkingWeek.WorkingDay(d.DayOfWeek) Then 
		        Continue Do
		      End If
		      
		      If Me.WorkCalendars(i).IsInClosurePeriod(d) Then 
		        Continue Do // It is enough that in just one region with a closure period...
		      end
		      
		      If Me.WorkCalendars(i).IsAnnualEvent(d, True) Then  // if is a holiday
		        Continue Do // It is enough that in just one region that day is not a working day...
		      end
		      
		    next 
		    
		    list.Add New DateTime(d) // Working day for all the WorkCalendars
		    
		  Loop
		  
		  Return list
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BusinessDaysEverywhere(year as Integer) As DateTime()
		  Var d As New DateTime(year, 1, 1, 0, 0, 0)
		  Var f As New DateTime(year, 12, 31, 0, 0, 0)
		  
		  Return BusinessDaysEverywhere(d,f)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BusinessDaysSomewhere(starting as DateTime, ending as DateTime) As DateTime()
		  If starting = Nil Then 
		    Raise New NilObjectException
		    Return Nil
		  End
		  
		  If ending = Nil Then 
		    Raise New NilObjectException
		    Return Nil
		  End
		  
		  Var list() As DateTime
		  if not me.OnCalendarEnabled then Return list // empty
		  
		  Var nStart As New DateTime(starting.Year, starting.Month, starting.day,0,0,0,0,starting.Timezone)
		  Var nEnd As New DateTime(ending.Year, ending.Month, ending.day,0,0,0,0, ending.Timezone)
		  
		  If nStart > nEnd Then Return list // empty
		  
		  
		  Var d As DateTime = nStart.SubtractInterval(0,0,1)
		  
		  Do Until d = nEnd
		    
		    d = d.AddInterval(0,0,1)
		    
		    for i as Integer = 0 to me.WorkCalendars.LastIndex
		      
		      if not me.WorkCalendars(i).Enabled then Continue for // ignore
		      
		      If Not Me.WorkCalendars(i).WorkingWeek.WorkingDay(d.DayOfWeek) Then 
		        Continue for // Not for this workcalendar, skip to the next workcalendar
		      End If
		      
		      If Me.WorkCalendars(i).IsInClosurePeriod(d) Then 
		        Continue for // Not for this workcalendar, skip to the next workcalendar
		      end
		      
		      If Me.WorkCalendars(i).IsAnnualEvent(d, True) Then  // if is a holiday
		        Continue for  // Not for this workcalendar, skip to the next workcalendar
		      end
		      
		      list.Add New DateTime(d) // Working day for all the WorkCalendars
		      Continue do // Skip the following calendars
		      
		    next 
		    
		    
		  Loop
		  
		  Return list
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BusinessDaysSomewhere(year as Integer) As DateTime()
		  Var d As New DateTime(year, 1, 1, 0, 0, 0)
		  Var f As New DateTime(year, 12, 31, 0, 0, 0)
		  
		  Return BusinessDaysSomewhere(d,f)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(copy as WorkCalendarGroup)
		  If copy.WorkCalendars.Count > 0 Then
		    
		    For r As Integer = 0 To copy.WorkCalendars.LastIndex
		      
		      me.WorkCalendars.Add new WorkCalendar(copy.WorkCalendars(r), copy.WorkCalendars(r).Identifier, copy.WorkCalendars(r).Caption)
		      // the enabled propertie is duplicate in the workcalendar.contructor method
		      
		    next
		    
		    
		  end
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CountBusinessDaysEverywhere(Date1 as datetime, Date2 as datetime) As Integer
		  // Trivial case
		  
		  If Date1 = Nil Then 
		    Raise New NilObjectException
		    Return -1
		  End
		  
		  If date2 = Nil Then 
		    Raise New NilObjectException
		    Return -1
		  End
		  
		  if not OnCalendarEnabled then Return -1
		  
		  Var dtCurrent As DateTime, dtMax As DateTime, counter As Integer
		  
		  If date1 > Date2 Then
		    dtMax = New DateTime(date1.Year, date1.Month, date1.Day, 0, 0, 0, 0, date1.Timezone)
		    dtCurrent = New DateTime(date2.Year, date2.Month, date2.Day, 0, 0, 0, 0, date2.Timezone)
		  else
		    dtMax = New DateTime(date2.Year, date2.Month, date2.Day, 0, 0, 0, 0, date2.Timezone)
		    dtCurrent = New DateTime(date1.Year, date1.Month, date1.Day, 0, 0, 0, 0, date1.Timezone)
		  End
		  
		  
		  dtCurrent = dtCurrent.SubtractInterval(0,0,1)
		  
		  Do 
		    
		    dtCurrent = dtCurrent.AddInterval (0,0,1)
		    
		    if IsWorkingDayEverywhere(dtCurrent) then counter = counter + 1
		    
		  loop until dtCurrent >= dtMax
		  
		  Return counter
		  
		  
		  
		  
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CountNonWorkingDaysEverywhere(Date1 as datetime, Date2 as datetime) As Integer
		  // Trivial cases
		  
		  If Date1 = Nil Then 
		    Raise New NilObjectException
		    Return -1
		  End
		  
		  If date2 = Nil Then 
		    Raise New NilObjectException
		    Return -1
		  End
		  
		  If Not OnCalendarEnabled Then Return -1
		  
		  
		  Var dtCurrent As DateTime, dtMax As DateTime, counter As Integer
		  
		  
		  If date1 > Date2 Then
		    dtMax = New DateTime(date1)
		    dtCurrent = New DateTime(Date2)
		  Else
		    dtMax = New DateTime(date2)
		    dtCurrent = New DateTime(Date1)
		  End
		  
		  dtCurrent = dtCurrent.SubtractInterval(0,0,1)
		  
		  Do 
		    
		    dtCurrent = dtCurrent.AddInterval (0,0,1)
		    
		    
		    
		    For i As Integer = 0 To Me.WorkCalendars.LastIndex
		      
		      If not Me.WorkCalendars(i).Enabled Then Continue for
		      
		      If Me.WorkCalendars(i).IsWorkingDay(dtCurrent) Then // It's working day in one calendar, is not non-working day everywhere
		        Continue do
		      end
		      
		    Next i
		    
		    Counter = Counter + 1
		    
		  Loop Until dtCurrent >= dtMax
		  
		  Return counter
		  
		  
		  
		  
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsAnnualEventEverywhere(d as DateTime, OnlyIfDayOff as Boolean = False) As Boolean
		  If d = Nil Then 
		    Raise New NilObjectException
		    Return False
		  end
		  
		  if not OnCalendarEnabled then Return False
		  
		  // The date must be a public holiday for ALL WorkCalendars.
		  
		  For i As Integer = 0 To Me.WorkCalendars.LastIndex
		    
		    if not me.WorkCalendars(i).Enabled then Continue
		    
		    // Therefore, it is enough for just one of them to not match.
		    if not me.WorkCalendars(i).IsAnnualEvent(d, OnlyIfDayOff) then Return false
		    
		  Next
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsAnnualEventSomewhere(d as DateTime, OnlyIfDayOff as Boolean = False) As Boolean
		  If d = Nil Then 
		    Raise New NilObjectException
		    Return False
		  end
		  
		  if not OnCalendarEnabled then Return False
		  
		  // The date must be a public holiday for one WorkCalendars.
		  
		  For i As Integer = 0 To Me.WorkCalendars.LastIndex
		    
		    if not me.WorkCalendars(i).Enabled then Continue
		    // Therefore, it is enough for just one of them to not match.
		    if me.WorkCalendars(i).IsAnnualEvent(d, OnlyIfDayOff) then Return true
		    
		  Next
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsInClosurePeriodEverywhere(d as DateTime) As Boolean
		  If d = Nil Then 
		    Raise New NilObjectException
		    Return False
		  End
		  
		  If Not OnCalendarEnabled Then Return False
		  
		  // The date must be a in a closing period for ALL WorkCalendars.
		  
		  For i As Integer = 0 To Me.WorkCalendars.LastIndex
		    
		    If Not Me.WorkCalendars(i).Enabled Then Continue
		    
		    // Therefore, it is enough for just one of them to not match.
		    If Not Me.WorkCalendars(i).IsInClosurePeriod(d) Then Return False
		    
		  Next
		  
		  Return True
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsInClosurePeriodSomewhere(d as DateTime) As Boolean
		  If d = Nil Then 
		    Raise New NilObjectException
		    Return False
		  End
		  
		  If Not OnCalendarEnabled Then Return False
		  
		  // The date must be a in a closing period for one WorkCalendar minmum.
		  
		  For i As Integer = 0 To Me.WorkCalendars.LastIndex
		    
		    If Not Me.WorkCalendars(i).Enabled Then Continue
		    
		    // Therefore, it is enough for just one of them to not match.
		    If  Me.WorkCalendars(i).IsInClosurePeriod(d) Then Return True
		    
		  Next
		  
		  Return False
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsWorkingDayEverywhere(d as DateTime) As Boolean
		  if d = Nil Then 
		    Raise New NilObjectException
		    Return False
		  End
		  
		  if Not OnCalendarEnabled Then Return False
		  
		  for r as Integer = 0 to me.WorkCalendars.LastIndex
		    
		    If Not Me.WorkCalendars(r).Enabled then Continue
		    
		    If Not me.WorkCalendars(r).WorkingWeek.WorkingDay(d.DayOfWeek) Then Return False // It's not a working week day somewhere
		    if me.WorkCalendars(r).IsInClosurePeriod(d) then Return false // it's as closure period somewhere
		    if me.WorkCalendars(r).IsAnnualEvent(d, true) then Return false // It's a holiday somewhere
		    
		  next r
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsWorkingDaySomewhere(d as DateTime) As Boolean
		  if d = Nil Then 
		    Raise New NilObjectException
		    Return False
		  End
		  
		  if Not OnCalendarEnabled Then Return False
		  
		  for r as Integer = 0 to me.WorkCalendars.LastIndex
		    
		    if not me.WorkCalendars(r).Enabled then Continue
		    
		    
		    If Not Me.WorkCalendars(r).WorkingWeek.WorkingDay(d.DayOfWeek) Then Continue // it's sunday for example
		    
		    if me.WorkCalendars(r).IsInClosurePeriod(d) then continue // it's as closure period
		    if me.WorkCalendars(r).IsAnnualEvent(d, true) then Continue // It's a holiday 
		    
		    Return true // Yes, is working day !
		    
		  next r
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsWorkingWeekDayEverywhere(DayOfWeek as integer) As Boolean
		  if not OnCalendarEnabled then Return False
		  
		  // The date must be a working week day for ALL WorkCalendars.
		  
		  For i As Integer = 0 To Me.WorkCalendars.LastIndex
		    
		    if not me.WorkCalendars(i).Enabled then Continue
		    
		    // Therefore, it is enough for just one of them to not match.
		    if not me.WorkCalendars(i).WorkingWeek.WorkingDay(DayOfWeek) then Return false
		    
		  Next
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsWorkingWeekDaySomewhere(DayOfWeek as integer) As Boolean
		  if not OnCalendarEnabled then Return False
		  
		  // The date must be a working week day for ALL WorkCalendars.
		  
		  For i As Integer = 0 To Me.WorkCalendars.LastIndex
		    
		    if not me.WorkCalendars(i).Enabled then Continue
		    
		    // Therefore, it is enough for just one of them to match.
		    if me.WorkCalendars(i).WorkingWeek.WorkingDay(DayOfWeek) then Return True
		    
		  Next
		  
		  Return false
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ListOfIdentifiers() As Variant()
		  Dim r() As Variant
		  
		  If Me.WorkCalendars.Count = 0 Then return r() // Retun empty array
		  
		  For i As Integer = 0 To Me.WorkCalendars.LastIndex
		    if Me.WorkCalendars(i).Enabled then r.Add me.WorkCalendars(i).Identifier
		  Next
		  
		  Return r
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub LoadAnnualEventsFromRowSet(WorkCalendars() as WorkCalendar, rs as RowSet, Encoding as TextEncoding = Nil, ValueColumn as string = "value", IdentifierColumn as string = "region", IdColumn as string = "id_event")
		  // if Encoding = nil, using UTF8
		  
		  if WorkCalendars.Count = 0 then exit Sub
		  
		  Var DefinitionsArray() as AnnualEvent
		  Var identifier As String
		  Var value as string
		  
		  If Encoding = Nil Then Encoding = Encodings.UTF8
		  
		  Var ae as AnnualEvent
		  
		  Var CurrentCalendar as WorkCalendar
		  If rs = Nil Then exit sub
		  
		  Do Until rs.AfterLastRow
		    
		    If Encoding <> Encodings.UTF8 Then // Converting all text data
		      identifier = rs.Column(IdentifierColumn).StringValue.DefineEncoding(Encoding).ConvertEncoding(Encodings.UTF8).DefineEncoding(Encodings.UTF8)
		      value = rs.Column(ValueColumn).StringValue.DefineEncoding(Encoding).ConvertEncoding(Encodings.UTF8).DefineEncoding(Encodings.UTF8)
		    else
		      identifier = rs.Column(IdentifierColumn).StringValue.DefineEncoding(Encodings.UTF8)
		      value = rs.Column(ValueColumn).StringValue.DefineEncoding(Encodings.UTF8)
		    end
		    
		    CurrentCalendar = nil
		    
		    for i as Integer = 0 to WorkCalendars.LastIndex
		      If WorkCalendars(i).Identifier.StringValue.Trim.Lowercase = identifier.Trim.Lowercase Then CurrentCalendar = WorkCalendars(i)
		    next
		    
		    If CurrentCalendar = Nil Then 
		      rs.MoveToNextRow
		      continue // No region to adding
		    end
		    
		    Try
		      ae = AnnualEventFixed.FromString(value)
		      If ae = Nil Then Break
		      ae.DbId = rs.Column(IdColumn).Int64Value
		    Catch e As InvalidArgumentException
		      Break
		      rs.MoveToNextRow
		      Continue
		    end
		    
		    CurrentCalendar.AnnualEvents.Add ae
		    
		    rs.MoveToNextRow
		  Loop
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function LoadCalendars(rs as RowSet, encoding as TextEncoding = Nil) As WorkCalendar()
		  // Load Calendars not load annualevents and closurperiods of each workcalendar
		  
		  Var w() as WorkCalendar
		  If rs = Nil Then Return w
		  Var identifier As String, caption as string
		  
		  Do Until rs.AfterLastRow
		    
		    If Encoding = Nil Or Encoding = Encodings.UTF8 Then
		      caption = rs.Column("name").StringValue.DefineEncoding(Encodings.UTF8).Trim
		      identifier = rs.Column("identifier").StringValue.DefineEncoding(Encodings.UTF8).Lowercase.Trim
		    Else
		      caption = rs.Column("name").StringValue.DefineEncoding(Encoding).ConvertEncoding(Encodings.UTF8).DefineEncoding(Encodings.UTF8).Trim
		      identifier = rs.Column("identifier").StringValue.DefineEncoding(Encoding).ConvertEncoding(Encodings.UTF8).DefineEncoding(Encodings.UTF8).Lowercase.Trim
		    End
		    
		    w.Add new WorkCalendar(identifier, caption)
		    w(w.LastIndex).WorkingWeek.ReadString rs.Column("workingWeek").StringValue
		    
		    rs.MoveToNextRow
		    
		  Loop
		  
		  Return w
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub LoadClosurePeriodsFromRowSet(WorkCalendars() as WorkCalendar, rs as RowSet, Encoding as TextEncoding = Nil, ValueColumn as string = "value", IdentifierColumn as string = "region", IdColumn as string = "id_period")
		  If rs = Nil Then Exit Sub
		  If WorkCalendars.Count = 0 Then Exit Sub
		  
		  Var r1 as string, value as string
		  
		  if Encoding = nil then Encoding = Encodings.UTF8
		  
		  do until rs.AfterLastRow
		    
		    If Encoding = Encodings.UTF8 Then
		      r1 = rs.Column(IdentifierColumn).StringValue.DefineEncoding(Encodings.UTF8).Lowercase.Trim
		      value = rs.Column(ValueColumn).StringValue.DefineEncoding(Encodings.UTF8)
		    else
		      r1 = rs.Column(IdentifierColumn).StringValue.DefineEncoding(Encoding).ConvertEncoding(Encodings.UTF8).DefineEncoding(Encodings.UTF8).Lowercase.Trim
		      value = rs.Column(ValueColumn).StringValue.DefineEncoding(Encoding).ConvertEncoding(Encodings.UTF8).DefineEncoding(Encodings.UTF8)
		    end
		    
		    for r as Integer = 0 to WorkCalendars.LastIndex
		      
		      If r1 <> WorkCalendars(r).Identifier.StringValue.Lowercase.Trim Then continue
		      WorkCalendars(r).ClosurePeriods.Add new ClosurePeriod(value)
		      WorkCalendars(r).ClosurePeriods(WorkCalendars(r).ClosurePeriods.LastIndex).DbId = rs.Column(IdColumn.DefineEncoding(Encoding)).Int64Value
		      
		    Next r
		    
		    rs.MoveToNextRow
		    
		  Loop
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NonWorkingDaysEverywhere(starting as DateTime, ending as DateTime) As DateTime()
		  If Starting = Nil Then 
		    Raise New NilObjectException
		    Return Nil
		  End
		  
		  If Ending = Nil Then 
		    Raise New NilObjectException
		    Return Nil
		  End
		  
		  Var list() As DateTime
		  if not OnCalendarEnabled then Return list
		  
		  Var nStart As New DateTime(starting.Year, starting.Month, starting.day)
		  Var nEnd As New DateTime(ending.Year, ending.Month, ending.day)
		  
		  If nStart > nEnd Then Return list
		  
		  
		  Var d As DateTime = nStart.SubtractInterval(0,0,1)
		  
		  
		  Do Until d = nEnd
		    
		    d = d.AddInterval(0,0,1)
		    
		    
		    For i As Integer = 0 To Me.WorkCalendars.LastIndex
		      
		      If Not Me.WorkCalendars(i).Enabled Then Continue For
		      
		      If Me.WorkCalendars(i).IsWorkingDay(d) Then // It's working day in one calendar, is not non-working day everywhere
		        Continue Do
		      End
		      
		    Next i
		    
		    list.Add New DateTime(d)
		    
		  Loop
		  
		  Return list
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NonWorkingDaysEverywhere(year as Integer) As DateTime()
		  Var d As New DateTime(year, 1, 1, 0, 0, 0)
		  Var f As New DateTime(year, 12, 31, 0, 0, 0)
		  
		  Return NonWorkingDaysEverywhere(d,f)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function OnCalendarEnabled() As Boolean
		  
		  if me.WorkCalendars.Count = 0 then Return False
		  
		  For i As Integer = 0 To Me.WorkCalendars.LastIndex
		    If Me.WorkCalendars(i).Enabled Then Return True
		  Next i
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function WhereIsAnnualEvent(d as DateTime, OnlyDayOff as Boolean = False) As WorkCalendar()
		  // Warning
		  // Return a array of pointers to the objects WorkCalendar, not a copy of the objects
		  
		  
		  Var wcs() As WorkCalendar
		  
		  If d = Nil Then 
		    Raise New NilObjectException
		    Return wcs
		  End
		  
		  
		  If Not OnCalendarEnabled Then Return wcs()
		  
		  
		  For i As Integer = 0 To Me.WorkCalendars.LastIndex
		    
		    If Not Me.WorkCalendars(i).Enabled Then Continue
		    // Therefore, it is enough for just one of them to not match.
		    If Me.WorkCalendars(i).IsAnnualEvent(d, OnlyDayOff) Then wcs.Add Me.WorkCalendars(i)
		    
		  Next
		  
		  Return wcs()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function WhereIsInClosurePeriod(d as DateTime) As WorkCalendar()
		  // Warning
		  // Return a array of pointers to the objects WorkCalendar, not a copy of the objects
		  
		  Var wcs() As WorkCalendar
		  
		  If d = Nil Then 
		    Raise New NilObjectException
		    Return wcs // empty Array
		  End
		  
		  
		  if me.WorkCalendars.Count = 0 then Return wcs // empty array
		  
		  
		  For i As Integer = 0 To Me.WorkCalendars.LastIndex
		    
		    If Not Me.WorkCalendars(i).Enabled Then Continue
		    
		    If Me.WorkCalendars(i).IsInClosurePeriod(d) Then wcs.add Me.WorkCalendars(i)
		    
		  Next
		  
		  Return wcs()
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function WhereIsNonWorkingDay(d as DateTime) As WorkCalendar()
		  // Warning
		  // Return a array of pointers to the objects WorkCalendar, not a copy of the objects
		  
		  Var wcs() As WorkCalendar
		  
		  If d = Nil Then 
		    Raise New NilObjectException
		    Return wcs // empty Array
		  End
		  
		  if Not OnCalendarEnabled Then Return wcs // empty
		  
		  for r as Integer = 0 to me.WorkCalendars.LastIndex
		    
		    if Not Me.WorkCalendars(r).Enabled then continue for
		    
		    If Not Me.WorkCalendars(r).WorkingWeek.WorkingDay(d.DayOfWeek) Then
		      wcs.add WorkCalendars(r)
		      Continue For
		    End
		    
		    If Me.WorkCalendars(r).IsInClosurePeriod(d) Then 
		      wcs.add WorkCalendars(r)
		      Continue For
		    end
		    
		    If Me.WorkCalendars(r).IsAnnualEvent(d, True) Then 
		      wcs.add WorkCalendars(r)
		      Continue For
		    End
		    
		  next r
		  
		  Return wcs
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function WhereIsWorkingDay(d as DateTime) As WorkCalendar()
		  // Warning
		  // Return a array of pointers to the objects WorkCalendar, not a copy of the objects
		  
		  Var wcs() As WorkCalendar
		  
		  If d = Nil Then 
		    Raise New NilObjectException
		    Return wcs // empty Array
		  End
		  
		  if Not OnCalendarEnabled Then Return wcs // empty
		  
		  Var flgWorkingDay as Boolean
		  
		  for r as Integer = 0 to me.WorkCalendars.LastIndex
		    
		    if Not Me.WorkCalendars(r).Enabled then continue for
		    
		    If Not me.WorkCalendars(r).WorkingWeek.WorkingDay(d.DayOfWeek) Then continue for // It's never a working day
		    
		    flgWorkingDay = True
		    For p As Integer = 0 To Me.WorkCalendars(r).ClosurePeriods.LastIndex
		      If d >=  Me.WorkCalendars(r).ClosurePeriods(p).FirstDay And d <=  Me.WorkCalendars(r).ClosurePeriods(p).LastDay Then  // It's as closed period
		        flgWorkingDay = False
		        exit for // Exit the p for...next
		      end
		    Next p
		    if not flgWorkingDay then continue for
		    
		    If Me.WorkCalendars(r).IsAnnualEvent(d, True) Then continue for // It's a holiday somewhere
		    
		    
		    wcs.add WorkCalendars(r)
		    
		  next r
		  
		  Return wcs
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Tag As Variant
	#tag EndProperty

	#tag Property, Flags = &h0
		WorkCalendars() As WorkCalendar
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
	#tag EndViewBehavior
End Class
#tag EndClass
