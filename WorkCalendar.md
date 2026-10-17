# WorkCalendar

## Description

Manages the calendar of a school, a company or any organization: the days of the week that are worked, the closure periods and the annual events (public holidays, celebrations). The class tells whether a day is worked, counts the business days between two dates, finds the next business day, and lists the non-working days and the annual events.

The class also provides ready-made lists of public holidays for Belgium, France, Israel and the United States, and loads events and closure periods from a database.

## Notes

A `WorkCalendar` combines three sources of non-working days:

- the days of the week that are not worked, defined by [WorkingWeek](#workingweek) ([wcWorkingWeekDays](wcWorkingWeekDays.md));
- the closure periods, in [ClosurePeriods](#closureperiods) ([ClosurePeriod](ClosurePeriod.md));
- the annual events whose `DayOff` property is `True`, in [AnnualEvents](#annualevents) (classes that implement [AnnualEvent](AnnualEvent.md)).

A day is a business day (a working day) if none of these sources makes it a non-working day. The annual events are tested last, because they take the most time to calculate.

An annual event whose `DayOff` property is `False` (for example a celebration that is not a holiday) does not make a day non-working. You can still find it with the methods that list the annual events, if you do not ask for `OnlyDayOff` events.

[Identifier](#identifier) identifies the calendar, for example a country, a region or a school. It is the *RegionIdentifier* used when the events and the periods are saved in a database (see [DbRow](AnnualEvent.md#dbrow)), and it is used to read only the rows of this calendar from a database. It is also the `RegionIdentifier` of the `DateAndCaption` returned by [IsAnnualEventDateAndCaption](#isannualeventdateandcaption).

The methods work on days: pass dates at 00:00:00.

### Database tables

The events and the closure periods can be stored in two tables. The methods that read the database use the names `value`, `region` and `id_event` (`id_period` for the closure periods) for the columns by default. You can use other names with the parameters *ValueColumn*, *RegionColumn* and *IdColumn* of [AnnualEventsFromRowSet](#annualeventsfromrowset) and [ClosurePeriodsFromRowSet](#closureperiodsfromrowset), or rename a column in the `SELECT` (see the example below). Here is an example for SQLite (see the note on the size of the columns in [DbRow](AnnualEvent.md#dbrow) for the other databases):

```sql
CREATE TABLE tevents (
  id_event INTEGER PRIMARY KEY AUTOINCREMENT,
  region TEXT,
  value TEXT NOT NULL
);

CREATE TABLE tperiods (
  id_period INTEGER PRIMARY KEY AUTOINCREMENT,
  region TEXT,
  value TEXT NOT NULL
);
```

The `region` and `value` columns of the two tables are the columns of the `DatabaseRow` returned by [DbRow](AnnualEvent.md#dbrow) for an annual event and by [DbRow](ClosurePeriod.md#dbrow) for a closure period. The `value` column contains the text returned by `ToString`, which describes the whole event or period.

## Sample code

A company in France, closed during three weeks in August 2026:

```xojo
Var cal As New WorkCalendar("FR", "Company calendar")
cal.AddAnnualEvents(WorkCalendar.AnnualEventsFrance(WorkCalendar.France.General))
cal.ClosurePeriods.Add(New ClosurePeriod(New DateTime(2026, 8, 3), New DateTime(2026, 8, 21), "Summer closure"))
```

Test a day:

```xojo
Var d As New DateTime(2026, 5, 14)
If cal.IsWorkingDay(d) Then
  MessageBox("Open")
Else
  MessageBox(cal.NonWorkingDayReasonCaption(d)) // Ascension
End If

MessageBox(cal.NonWorkingDayReasonCaption(New DateTime(2026, 8, 10))) // Summer closure
```

Count the business days:

```xojo
Var n1 As Integer = cal.CountBusinessDays(New DateTime(2026, 5, 1), New DateTime(2026, 5, 31))
// 17: 21 weekdays minus May 1, May 8, Ascension (May 14) and Whit Monday (May 25)

Var n2 As Integer = cal.CountBusinessDays(New DateTime(2026, 8, 1), New DateTime(2026, 8, 31))
// 6: the three weeks of closure are not counted
```

Find the fifth business day after April 30, 2026:

```xojo
Var d As DateTime = cal.BusinessDayOffset(New DateTime(2026, 4, 30), 5)
MessageBox(d.SQLDate) // 2026-05-11 (May 1 and May 8 are holidays)
```

A school that is closed on Wednesday:

```xojo
Var school As New WorkCalendar("BE-WAL", "School")
school.WorkingWeek.WorkingWednesday = False
school.AddAnnualEvents(WorkCalendar.AnnualEventsBelgium(WorkCalendar.Belgium.Wallonie, False))
```

List the public holidays of a year, with their names:

```xojo
Var list() As DateAndCaption = cal.ListOfAnnualEvents(2026, True)
For Each item As DateAndCaption In list
  System.DebugLog(item.DateValue.SQLDate + " " + item.Caption)
Next
```

Load the events and the closure periods of a calendar from a database:

```xojo
Var school As New WorkCalendar("BE-WAL")

Var rs1 As RowSet = db.SelectSQL("SELECT id_event, region, value FROM tevents")
school.LoadAnnualEventsFromRowSet(rs1)

Var rs2 As RowSet = db.SelectSQL("SELECT id_period, region, value FROM tperiods")
school.LoadClosurePeriodsFromRowSet(rs2)
```

## Compatibility

Uses `DateTime`, `RowSet` and `Dictionary` (API 2).

## Properties

| Property | Type | Read | Write | Description |
| -------- | ---- | :--: | :---: | ----------- |
| [AnnualEvents](#annualevents) | AnnualEvent() | ✓ | ✓ | The annual events of the calendar. |
| [Caption](#caption) | String | ✓ | ✓ | The name of the calendar. |
| [ClosurePeriods](#closureperiods) | ClosurePeriod() | ✓ | ✓ | The closure periods of the calendar. |
| [DbId](#dbid) | Variant | ✓ | ✓ | The identifier of the calendar in a database. |
| [Enabled](#enabled) | Boolean | ✓ | ✓ | A flag for your own use. Default: `True`. |
| [Identifier](#identifier) | Variant | ✓ | ✓ | The identifier of the calendar (country, region, school, etc.). |
| [Tag](#tag) | Variant | ✓ | ✓ | A value reserved for your own use. |
| [WorkingWeek](#workingweek) | wcWorkingWeekDays | ✓ | ✓ | The days of the week that are worked. |

## Methods

| Method | Parameters | Returns |
| ------ | ---------- | ------- |
| [AddAnnualEvents](#addannualevents) | *d()* As AnnualEvent, *NoDuplicates* As Boolean = False | |
| [AddAnnualEvents](#addannualevents) | *NewEvent* As AnnualEvent, *NoDuplicates* As Boolean = False | |
| [BusinessDayOffset](#businessdayoffset) | *startdate* As DateTime, *number* As Integer = 1, *limit* As Integer = 366 | DateTime |
| [BusinessDays](#businessdays) | *starting* As DateTime, *ending* As DateTime | DateTime() |
| [BusinessDays](#businessdays) | *year* As Integer | DateTime() |
| [Constructor](#constructor) | | |
| [Constructor](#constructor) | *copy* As WorkCalendar, *NewIdentifier* As Variant = Nil, *NewCaption* As String = "" | |
| [Constructor](#constructor) | *lIdentifier* As Variant | |
| [Constructor](#constructor) | *lIdentifier* As Variant, *lCaption* As String | |
| [CountBusinessDays](#countbusinessdays) | *Date1* As DateTime, *Date2* As DateTime | Integer |
| [CountNonWorkingDays](#countnonworkingdays) | *Date1* As DateTime, *Date2* As DateTime | Integer |
| [DatesOfAnnualEvents](#datesofannualevents) | *Starting* As DateTime, *Ending* As DateTime, *OnlyDayOff* As Boolean = False, *IncludeSaturday* ... *IncludeFriday* As Boolean = True | DateTime() |
| [DatesOfAnnualEvents](#datesofannualevents) | *Year* As Integer, *OnlyDayOff* As Boolean = False, *IncludeSaturday* ... *IncludeFriday* As Boolean = True | DateTime() |
| [IsAnnualEvent](#isannualevent) | *d* As DateTime, *OnlyIfDayOff* As Boolean = False | Boolean |
| [IsAnnualEventCaption](#isannualeventcaption) | *d* As DateTime, *OnlyIfDayOff* As Boolean = False | String |
| [IsAnnualEventDateAndCaption](#isannualeventdateandcaption) | *d* As DateTime, *OnlyIfDayOff* As Boolean = False | [DateAndCaption](DateAndCaption.md) |
| [IsAnnualEventObject](#isannualeventobject) | *d* As DateTime, *OnlyIfDayOff* As Boolean = False | AnnualEvent |
| [IsAnnualEventRegion](#isannualeventregion) | *d* As DateTime, *OnlyIfDayOff* As Boolean = False | Variant |
| [IsInClosurePeriod](#isinclosureperiod) | *d* As DateTime | Boolean |
| [IsInClosurePeriodCaption](#isinclosureperiodcaption) | *d* As DateTime | String |
| [IsInClosurePeriodObject](#isinclosureperiodobject) | *d* As DateTime | [ClosurePeriod](ClosurePeriod.md) |
| [IsWorkingDay](#isworkingday) | *d* As DateTime | Boolean |
| [ListOfAnnualEvents](#listofannualevents) | *Starting* As DateTime, *Ending* As DateTime, *OnlyDayOff* As Boolean = False, *IncludeSaturday* ... *IncludeFriday* As Boolean = True | [DateAndCaption](DateAndCaption.md)() |
| [ListOfAnnualEvents](#listofannualevents) | *Year* As Integer, *OnlyDayOff* As Boolean = False, *IncludeSaturday* ... *IncludeFriday* As Boolean = True | [DateAndCaption](DateAndCaption.md)() |
| [LoadAnnualEventsFromRowSet](#loadannualeventsfromrowset) | *rs* As RowSet, *Encoding* As TextEncoding = Nil, *ValueColumn* As String = "value", *RegionColumn* As String = "region", *IdColumn* As String = "id_event" | |
| [LoadClosurePeriodsFromRowSet](#loadclosureperiodsfromrowset) | *rs* As RowSet, *Encoding* As TextEncoding = Nil | |
| [NonWorkingDayOffset](#nonworkingdayoffset) | *startdate* As DateTime, *number* As Integer = 1, *limit* As Integer = 366 | DateTime |
| [NonWorkingDayReasonCaption](#nonworkingdayreasoncaption) | *d* As DateTime | String |
| [NonWorkingDayReasonType](#nonworkingdayreasontype) | *d* As DateTime | Integer |
| [NonWorkingDays](#nonworkingdays) | *starting* As DateTime, *ending* As DateTime | DateTime() |
| [NonWorkingDays](#nonworkingdays) | *year* As Integer | DateTime() |
| [NonWorkingDaysDateAndCaption](#nonworkingdaysdateandcaption) | *starting* As DateTime, *ending* As DateTime | [DateAndCaption](DateAndCaption.md)() |
| [NonWorkingDaysDateAndCaption](#nonworkingdaysdateandcaption) | *year* As Integer | [DateAndCaption](DateAndCaption.md)() |

## Shared methods

| Method | Parameters | Returns |
| ------ | ---------- | ------- |
| [AnnualEventsBelgium](#annualeventsbelgium) | *Region* As Belgium = NationauxEnFrancais, *PublicService* As Boolean = True | AnnualEvent() |
| [AnnualEventsFrance](#annualeventsfrance) | *Region* As France = General | AnnualEvent() |
| [AnnualEventsFromRowSet](#annualeventsfromrowset) | *rs* As RowSet, *Identifier* As Variant = Nil, *Encoding* As TextEncoding = Nil, *ValueColumn* As String = "value", *RegionColumn* As String = "region", *IdColumn* As String = "id_event" | AnnualEvent() |
| [AnnualEventsIsrael](#annualeventsisrael) | | AnnualEvent() |
| [AnnualEventsUSA](#annualeventsusa) | *State* As USA = Federal | AnnualEvent() |
| [ClosurePeriodsFromRowSet](#closureperiodsfromrowset) | *rs* As RowSet, *Identifier* As Variant = Nil, *Encoding* As TextEncoding = Nil, *ValueColumn* As String = "value", *RegionColumn* As String = "region", *IdColumn* As String = "id_period" | ClosurePeriod() |

## Enumerations

### Belgium

The regions and languages for which [AnnualEventsBelgium](#annualeventsbelgium) returns the public holidays.

| Name | Value | Description |
| ---- | ----: | ----------- |
| NationauxEnFrancais | 0 | The national holidays, with the captions in French. |
| NationaleDagenInDeVlaamseTaal | 1 | The national holidays, with the captions in Dutch (Flemish), and the holiday of the Flemish Community. |
| NationalfeiertageAufDeutsch | 2 | The national holidays, with the captions in German. |
| Vlaanderen | 3 | The holidays of Flanders. |
| DeutschsprachigeGemeinschaft | 4 | The holidays of the German-speaking Community. |
| BruxellesCapitale | 5 | The holidays of the Brussels-Capital Region. |
| Wallonie | 6 | The holidays of Wallonia. |

### France

The regions for which [AnnualEventsFrance](#annualeventsfrance) returns the public holidays.

| Name | Value |
| ---- | ----: |
| General | 0 |
| AlsaceMoselle | 1 |
| Guyane | 2 |
| Guadeloupe | 3 |
| Martinique | 4 |
| Reunion | 5 |
| SaintBarthelemy | 6 |
| SaintMartin | 7 |
| Mayotte | 8 |

### USA

The federal government and the states for which [AnnualEventsUSA](#annualeventsusa) returns the public holidays.

| Name | Value |
| ---- | ----: |
| Federal | 0 |
| Alabama, Alaska, Arkansas, Arizona, California, Colorado, Connecticut, Delaware, DistrictOfColumbia, Florida, Georgia, Hawaii, Idaho, Illinois, Indiana, Iowa, Kansas, Kentucky, Louisiana, Maine, Maryland, Massachusetts, Michigan, Minnesota, Mississippi, Missouri, Montana, Nebraska, Nevada, NewHampshire, NewJersey, NewMexico, NewYork, NorthCarolina, NorthDakota, Ohio, Oklahoma, Oregon, Pennsylvania, RhodeIsland, SouthCarolina, SouthDakota, Tennessee, Texas, Utah, Vermont, Virginia, Washington, WestVirginia, Wisconsin, Wyoming | 1 to 51, in this order |

> [!NOTE]
> Not all the states have a list of holidays yet. See [AnnualEventsUSA](#annualeventsusa).

---

## Property descriptions

### AnnualEvents

The annual events of the calendar.

**Declaration**

```xojo
Property AnnualEvents() As AnnualEvent
```

**Notes**

An array of objects that implement [AnnualEvent](AnnualEvent.md): [AnnualEventFixed](AnnualEventFixed.md), [AnnualEventWeekDay](AnnualEventWeekDay.md), [AnnualEventEaster and AnnualEventOrthodoxEaster](EasterEvents.md), [AnnualEventHebraic](AnnualEventHebraic.md). You can add events with the array (`AnnualEvents.Add`), with [AddAnnualEvents](#addannualevents) (which can avoid duplicates), with the lists of the shared methods such as [AnnualEventsFrance](#annualeventsfrance), or from a database with [LoadAnnualEventsFromRowSet](#loadannualeventsfromrowset).

The methods search the events in the order of the array: when several events fall on the same day, the first one is used.

---

### Caption

The name of the calendar.

**Declaration**

```xojo
Property Caption As String
```

**Notes**

For example `"School calendar"`. It is not used by the class itself.

---

### ClosurePeriods

The closure periods of the calendar.

**Declaration**

```xojo
Property ClosurePeriods() As ClosurePeriod
```

**Notes**

An array of [ClosurePeriod](ClosurePeriod.md). Add the periods with `ClosurePeriods.Add`, or from a database with [LoadClosurePeriodsFromRowSet](#loadclosureperiodsfromrowset).

---

### DbId

The identifier of the calendar in a database.

**Declaration**

```xojo
Function DbId() As Variant
Sub DbId(Assigns value As Variant)
```

**Notes**

The type is `Variant` so that any kind of key can be used. It is not used by the class itself. It is used like a property: `cal.DbId = 12`.

---

### Enabled

A flag for your own use.

**Declaration**

```xojo
Property Enabled As Boolean
```

**Notes**

The default value is `True`. The class does not use it: use it to tell whether a calendar is active, for example in a list of calendars.

---

### Identifier

The identifier of the calendar.

**Declaration**

```xojo
Property Identifier As Variant
```

**Notes**

For example `"FR"`, `"BE-WAL"` or the name of a school. See the notes at the beginning of this page. The comparison with the `region` column of a database ignores case and spaces at the beginning and at the end.

---

### Tag

A value reserved for your own use.

**Declaration**

```xojo
Property Tag As Variant
```

**Notes**

The value is not used by the class itself.

---

### WorkingWeek

The days of the week that are worked.

**Declaration**

```xojo
Property WorkingWeek As wcWorkingWeekDays
```

**Notes**

See [wcWorkingWeekDays](wcWorkingWeekDays.md). The default week is Monday to Friday. The object is created by the constructors.

**Sample code**

```xojo
cal.WorkingWeek.WorkingSaturday = True
```

---

## Method descriptions

### AddAnnualEvents

Adds one or several annual events to the calendar.

**Declaration**

```xojo
Sub AddAnnualEvents(d() As AnnualEvent, NoDuplicates As Boolean = False)
Sub AddAnnualEvents(NewEvent As AnnualEvent, NoDuplicates As Boolean = False)
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| d | AnnualEvent() | The events to add. |
| NewEvent | AnnualEvent | The event to add. |
| NoDuplicates | Boolean | If `True`, an event is not added if the calendar already has an event with the same [FingerPrint](AnnualEvent.md#fingerprint). Default: `False`. |

**Notes**

With the array, when *NoDuplicates* is `True`, an event is also not added if the calendar already has an event with the same caption (case ignored). The events of the array are also compared with each other.

**Sample code**

```xojo
cal.AddAnnualEvents(WorkCalendar.AnnualEventsFrance(), True)
cal.AddAnnualEvents(New AnnualEventFixed("Company anniversary", 3, 15), True)
```

---

### BusinessDayOffset

Returns the business day that is a number of business days after, or before, a date.

**Declaration**

```xojo
Function BusinessDayOffset(startdate As DateTime, number As Integer = 1, limit As Integer = 366) As DateTime
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| startdate | DateTime | The starting date. It is not counted. |
| number | Integer | The number of business days. `1` is the next business day, `2` the second business day after, and so on. A negative number goes back in time. Default: `1`. |
| limit | Integer | The maximum number of days to go through from *startdate*. Default: `366`. |

**Returns**

A `DateTime` with the date of the business day. If *number* is `0`, the result is *startdate*. If the business day is not found after *limit* days, the result is `Nil`.

**Notes**

The method raises a `NilObjectException` if *startdate* is `Nil`. The result has the time of *startdate*.

The limit is absolute: it is the maximum number of days that the method examines, whatever the value of *number*, and the method stops as soon as it is reached. A closure period is skipped in a single step and counts for one day. The limit prevents the method from running forever when there is no business day, for example if no day of the week is worked. Increase *limit* if *number* is large: with the default value, about 260 business days is the most you can reach in a calendar that works five days a week.

**Sample code**

```xojo
Var d As DateTime = cal.BusinessDayOffset(New DateTime(2026, 4, 30), 5)
MessageBox(d.SQLDate) // 2026-05-11
```

Look for a business day far from the starting date, and test the result:

```xojo
Var d As DateTime = cal.BusinessDayOffset(DateTime.Now, 400, 800)
If d Is Nil Then
  MessageBox("No business day found in 800 days")
End If
```

---

### BusinessDays

Returns the business days between two dates, or in a year.

**Declaration**

```xojo
Function BusinessDays(starting As DateTime, ending As DateTime) As DateTime()
Function BusinessDays(year As Integer) As DateTime()
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| starting | DateTime | The first day. |
| ending | DateTime | The last day. |
| year | Integer | The year. |

**Returns**

An array of `DateTime` (time 00:00:00), in chronological order. Both *starting* and *ending* are included if they are business days. The array is empty if *starting* is after *ending*.

**Notes**

The method raises a `NilObjectException` if a date is `Nil`.

---

### Constructor

Creates a new calendar.

**Declaration**

```xojo
Sub Constructor()
Sub Constructor(copy As WorkCalendar, NewIdentifier As Variant = Nil, NewCaption As String = "")
Sub Constructor(lIdentifier As Variant)
Sub Constructor(lIdentifier As Variant, lCaption As String)
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| copy | WorkCalendar | The calendar to copy. |
| NewIdentifier | Variant | The identifier of the new calendar. Default: `Nil`. |
| NewCaption | String | The caption of the new calendar. Default: empty. |
| lIdentifier | Variant | The identifier of the calendar. |
| lCaption | String | The caption of the calendar. |

**Notes**

*Constructor 1:* creates an empty calendar, with the default working week (Monday to Friday).

*Constructor 2:* creates a copy of a calendar, with another identifier and another caption. The working week, the annual events and the closure periods are duplicated: the new calendar does not share any object with the original one.

*Constructors 3 and 4:* create an empty calendar with the specified identifier, and caption.

**Sample code**

```xojo
Var fr As New WorkCalendar("FR", "France")
fr.AddAnnualEvents(WorkCalendar.AnnualEventsFrance())

Var alsace As New WorkCalendar(fr, "FR-67", "Alsace")
alsace.AddAnnualEvents(New AnnualEventEaster("Good Friday", AnnualEventEaster.GoodFriday))
```

---

### CountBusinessDays

Counts the business days between two dates.

**Declaration**

```xojo
Function CountBusinessDays(Date1 As DateTime, Date2 As DateTime) As Integer
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| Date1 | DateTime | The first date. |
| Date2 | DateTime | The second date. |

**Returns**

The number of business days, *Date1* and *Date2* included. If the two dates are the same day, the result is `1` or `0`. The order of the dates does not matter.

**Notes**

The method raises a `NilObjectException` if a date is `Nil`.

---

### CountNonWorkingDays

Counts the non-working days between two dates.

**Declaration**

```xojo
Function CountNonWorkingDays(Date1 As DateTime, Date2 As DateTime) As Integer
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| Date1 | DateTime | The first date. |
| Date2 | DateTime | The second date. |

**Returns**

The number of non-working days, *Date1* and *Date2* included. The order of the dates does not matter.

**Notes**

The method raises a `NilObjectException` if a date is `Nil`. For a period, the result of `CountBusinessDays` and the result of this method add up to the number of days.

---

### DatesOfAnnualEvents

Returns the dates of the annual events between two dates, or in a year.

**Declaration**

```xojo
Function DatesOfAnnualEvents(Starting As DateTime, Ending As DateTime, OnlyDayOff As Boolean = False, IncludeSaturday As Boolean = True, IncludeSunday As Boolean = True, IncludeMonday As Boolean = True, IncludeTuesday As Boolean = True, IncludeWednesday As Boolean = True, IncludeThursday As Boolean = True, IncludeFriday As Boolean = True) As DateTime()
Function DatesOfAnnualEvents(Year As Integer, OnlyDayOff As Boolean = False, IncludeSaturday As Boolean = True, IncludeSunday As Boolean = True, IncludeMonday As Boolean = True, IncludeTuesday As Boolean = True, IncludeWednesday As Boolean = True, IncludeThursday As Boolean = True, IncludeFriday As Boolean = True) As DateTime()
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| Starting | DateTime | The first day. |
| Ending | DateTime | The last day. |
| Year | Integer | The year. |
| OnlyDayOff | Boolean | If `True`, only the events that make a day non-working (`DayOff` is `True`) are returned. Default: `False`. |
| IncludeSaturday, IncludeSunday, IncludeMonday, IncludeTuesday, IncludeWednesday, IncludeThursday, IncludeFriday | Boolean | If `False`, the events that fall on this day of the week are left out. Default: `True`. |

**Returns**

An array of `DateTime`, in chronological order. The array is empty if the calendar has no annual event, or if *Starting* is after *Ending*. If two events fall on the same day, the date appears twice.

**Notes**

The method raises a `NilObjectException` if *Starting* or *Ending* is `Nil`. To know the names of the events, use [ListOfAnnualEvents](#listofannualevents).

**Sample code**

```xojo
// The public holidays of 2026 that do not fall on a weekend
Var dates() As DateTime = cal.DatesOfAnnualEvents(2026, True, False, False)
```

---

### IsAnnualEvent

Indicates whether a date is the date of an annual event.

**Declaration**

```xojo
Function IsAnnualEvent(d As DateTime, OnlyIfDayOff As Boolean = False) As Boolean
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| d | DateTime | The date to test. |
| OnlyIfDayOff | Boolean | If `True`, only the events that make a day non-working (`DayOff` is `True`) are tested. Default: `False`. |

**Returns**

`True` if *d* is the date of an annual event that is valid at this date.

**Notes**

The method raises a `NilObjectException` if *d* is `Nil`. The following methods work in the same way and give more information about the event: [IsAnnualEventCaption](#isannualeventcaption), [IsAnnualEventDateAndCaption](#isannualeventdateandcaption), [IsAnnualEventObject](#isannualeventobject) and [IsAnnualEventRegion](#isannualeventregion).

---

### IsAnnualEventCaption

Returns the caption of the annual event that falls on a date.

**Declaration**

```xojo
Function IsAnnualEventCaption(d As DateTime, OnlyIfDayOff As Boolean = False) As String
```

**Parameters**

See [IsAnnualEvent](#isannualevent).

**Returns**

The caption of the first event that falls on *d*, or an empty string if there is none.

---

### IsAnnualEventDateAndCaption

Returns the date and the caption of the annual event that falls on a date.

**Declaration**

```xojo
Function IsAnnualEventDateAndCaption(d As DateTime, OnlyIfDayOff As Boolean = False) As DateAndCaption
```

**Parameters**

See [IsAnnualEvent](#isannualevent).

**Returns**

A [DateAndCaption](DateAndCaption.md) with *d*, the caption of the first event that falls on *d*, and the [Identifier](#identifier) of the calendar as `RegionIdentifier`. The result is `Nil` if there is no event.

---

### IsAnnualEventObject

Returns the annual event that falls on a date.

**Declaration**

```xojo
Function IsAnnualEventObject(d As DateTime, OnlyIfDayOff As Boolean = False) As AnnualEvent
```

**Parameters**

See [IsAnnualEvent](#isannualevent).

**Returns**

The first event that falls on *d*, or `Nil` if there is none.

> [!IMPORTANT]
> The result is the event of the calendar itself, not a copy. If you change it, you change the calendar.

---

### IsAnnualEventRegion

Returns the identifier of the calendar if an annual event falls on a date.

**Declaration**

```xojo
Function IsAnnualEventRegion(d As DateTime, OnlyIfDayOff As Boolean = False) As Variant
```

**Parameters**

See [IsAnnualEvent](#isannualevent).

**Returns**

The [Identifier](#identifier) of the calendar if an event falls on *d*, `Nil` otherwise.

---

### IsInClosurePeriod

Indicates whether a date is in a closure period.

**Declaration**

```xojo
Function IsInClosurePeriod(d As DateTime) As Boolean
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| d | DateTime | The date to test. |

**Returns**

`True` if *d* is in one of the [ClosurePeriods](#closureperiods).

**Notes**

The time of *d* is ignored. The following methods give more information: [IsInClosurePeriodCaption](#isinclosureperiodcaption) and [IsInClosurePeriodObject](#isinclosureperiodobject).

---

### IsInClosurePeriodCaption

Returns the caption of the closure period that contains a date.

**Declaration**

```xojo
Function IsInClosurePeriodCaption(d As DateTime) As String
```

**Returns**

The caption of the first period that contains *d*, or an empty string if there is none.

---

### IsInClosurePeriodObject

Returns the closure period that contains a date.

**Declaration**

```xojo
Function IsInClosurePeriodObject(d As DateTime) As ClosurePeriod
```

**Returns**

The first [ClosurePeriod](ClosurePeriod.md) that contains *d*, or `Nil` if there is none.

> [!IMPORTANT]
> The result is the period of the calendar itself, not a copy. If you change it, you change the calendar.

---

### IsWorkingDay

Indicates whether a date is a business day.

**Declaration**

```xojo
Function IsWorkingDay(d As DateTime) As Boolean
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| d | DateTime | The date to test. |

**Returns**

`True` if the day of the week is worked, if *d* is not in a closure period and if no annual event with `DayOff` set to `True` falls on this day. `False` otherwise.

**Sample code**

```xojo
If cal.IsWorkingDay(New DateTime(2026, 5, 14)) Then
  // Not executed: Ascension
End If
```

---

### ListOfAnnualEvents

Returns the annual events between two dates, or in a year, with their dates and captions.

**Declaration**

```xojo
Function ListOfAnnualEvents(Starting As DateTime, Ending As DateTime, OnlyDayOff As Boolean = False, IncludeSaturday As Boolean = True, IncludeSunday As Boolean = True, IncludeMonday As Boolean = True, IncludeTuesday As Boolean = True, IncludeWednesday As Boolean = True, IncludeThursday As Boolean = True, IncludeFriday As Boolean = True) As DateAndCaption()
Function ListOfAnnualEvents(Year As Integer, OnlyDayOff As Boolean = False, IncludeSaturday As Boolean = True, IncludeSunday As Boolean = True, IncludeMonday As Boolean = True, IncludeTuesday As Boolean = True, IncludeWednesday As Boolean = True, IncludeThursday As Boolean = True, IncludeFriday As Boolean = True) As DateAndCaption()
```

**Parameters**

The parameters are the same as those of [DatesOfAnnualEvents](#datesofannualevents).

**Returns**

An array of [DateAndCaption](DateAndCaption.md), in chronological order. The array is empty if the calendar has no annual event, or if *Starting* is after *Ending*.

**Notes**

The method raises a `NilObjectException` if *Starting* or *Ending* is `Nil`.

---

### LoadAnnualEventsFromRowSet

Adds the annual events of this calendar that are stored in a database.

**Declaration**

```xojo
Sub LoadAnnualEventsFromRowSet(rs As RowSet, Encoding As TextEncoding = Nil, ValueColumn As String = "value", RegionColumn As String = "region", IdColumn As String = "id_event")
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| rs | RowSet | The rows to read. |
| Encoding | TextEncoding | Optional. The encoding of the text of the database. If `Nil`, UTF-8 is used. |
| ValueColumn | String | The column that contains the text of the event ([ToString](AnnualEvent.md#tostring)). Default: `"value"`. |
| RegionColumn | String | The column that contains the region. Default: `"region"`. |
| IdColumn | String | The column that contains the identifier of the event. Default: `"id_event"`. |

**Notes**

Only the rows whose region is the [Identifier](#identifier) of the calendar are read. The events are added to [AnnualEvents](#annualevents) and their `DbId` is the value of *IdColumn*. The method reads the `RowSet` to the end. It does nothing if *rs* is `Nil` or has no row. See [AnnualEventsFromRowSet](#annualeventsfromrowset).

---

### LoadClosurePeriodsFromRowSet

Adds the closure periods of this calendar that are stored in a database.

**Declaration**

```xojo
Sub LoadClosurePeriodsFromRowSet(rs As RowSet, Encoding As TextEncoding = Nil)
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| rs | RowSet | The rows to read. |
| Encoding | TextEncoding | Optional. The encoding of the text of the database. If `Nil`, UTF-8 is used. |

**Notes**

Only the rows whose region is the [Identifier](#identifier) of the calendar are read. The periods are added to [ClosurePeriods](#closureperiods). The method uses the default names of the columns (`value`, `region` and `id_period`): rename the columns in the `SELECT` if your table uses other names, or use [ClosurePeriodsFromRowSet](#closureperiodsfromrowset), which has parameters for the names.

---

### NonWorkingDayOffset

Returns the non-working day that is a number of non-working days after, or before, a date.

**Declaration**

```xojo
Function NonWorkingDayOffset(startdate As DateTime, number As Integer = 1, limit As Integer = 366) As DateTime
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| startdate | DateTime | The starting date. It is not counted. |
| number | Integer | The number of non-working days. `1` is the next non-working day. A negative number goes back in time. Default: `1`. |
| limit | Integer | The maximum number of days to go through from *startdate*. Default: `366`. |

**Returns**

A `DateTime` with the date of the non-working day. If *number* is `0`, the result is *startdate*. If the non-working day is not found after *limit* days, the result is `Nil`.

**Notes**

The method raises a `NilObjectException` if *startdate* is `Nil`. The result has the time of *startdate*.

The limit is absolute: it is the maximum number of days that the method examines, whatever the value of *number*, and the method stops as soon as it is reached. It prevents the method from running forever when there is no non-working day, for example if all the days of the week are worked and the calendar has no event or closure period.

---

### NonWorkingDayReasonCaption

Returns the reason why a day is not worked.

**Declaration**

```xojo
Function NonWorkingDayReasonCaption(d As DateTime) As String
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| d | DateTime | The date. |

**Returns**

The name of the day of the week (for example `"Sunday"`, in the language of the user) if this day of the week is not worked; otherwise the caption of the closure period that contains *d*; otherwise the caption of the annual event with `DayOff` set to `True` that falls on this day. An empty string if the day is worked.

**Notes**

The method raises a `NilObjectException` if *d* is `Nil`. The reasons are tested in this order. Use [NonWorkingDayReasonType](#nonworkingdayreasontype) to know the type of the reason.

---

### NonWorkingDayReasonType

Returns the type of the reason why a day is not worked.

**Declaration**

```xojo
Function NonWorkingDayReasonType(d As DateTime) As Integer
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| d | DateTime | The date. |

**Returns**

| Value | Meaning |
| ----: | ------- |
| 0 | The day is worked. |
| 1 | The day of the week is not worked. |
| 2 | The day is in a closure period. |
| 3 | An annual event with `DayOff` set to `True` falls on this day. |

**Notes**

The method raises a `NilObjectException` if *d* is `Nil`. If there are several reasons, the first one in the order of the table is returned.

---

### NonWorkingDays

Returns the non-working days between two dates, or in a year.

**Declaration**

```xojo
Function NonWorkingDays(starting As DateTime, ending As DateTime) As DateTime()
Function NonWorkingDays(year As Integer) As DateTime()
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| starting | DateTime | The first day. |
| ending | DateTime | The last day. |
| year | Integer | The year. |

**Returns**

An array of `DateTime` (time 00:00:00), in chronological order. The array is empty if *starting* is after *ending*. Both days are included if they are not worked.

---

### NonWorkingDaysDateAndCaption

Returns the non-working days between two dates, or in a year, with the reason.

**Declaration**

```xojo
Function NonWorkingDaysDateAndCaption(starting As DateTime, ending As DateTime) As DateAndCaption()
Function NonWorkingDaysDateAndCaption(year As Integer) As DateAndCaption()
```

**Parameters**

The parameters are the same as those of [NonWorkingDays](#nonworkingdays).

**Returns**

An array of [DateAndCaption](DateAndCaption.md), in chronological order. The caption is the reason, as in [NonWorkingDayReasonCaption](#nonworkingdayreasoncaption): the name of the day of the week, the caption of the closure period or the caption of the annual event.

**Sample code**

```xojo
Var list() As DateAndCaption = cal.NonWorkingDaysDateAndCaption(2026)
For Each item As DateAndCaption In list
  System.DebugLog(item.DateValue.SQLDate + ": " + item.Caption)
Next
```

---

## Shared method descriptions

### AnnualEventsBelgium

Returns the public holidays of Belgium.

**Declaration**

```xojo
Shared Function AnnualEventsBelgium(Region As Belgium = Belgium.NationauxEnFrancais, PublicService As Boolean = True) As AnnualEvent()
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| Region | Belgium | The region or the language of the captions. Default: `NationauxEnFrancais`. |
| PublicService | Boolean | If `True`, the holidays of the public service are included (Brussels-Capital, Flanders and Wallonia). It has no effect on the other values. Default: `True`. |

**Returns**

An array of `AnnualEvent` ([AnnualEventFixed](AnnualEventFixed.md) and [AnnualEventEaster](EasterEvents.md)). The events have the default values of their class: `DayOff` is `True`, except where noted.

**Notes**

The ten national holidays are: January 1, May 1, July 21, August 15, November 1, November 11, December 25, Easter Monday, Ascension and Whit Monday. The captions are in the language of the region. The other holidays are:

| Region | Other holidays |
| ------ | -------------- |
| NationauxEnFrancais | None. |
| NationaleDagenInDeVlaamseTaal | July 11 (holiday of the Flemish Community). |
| NationalfeiertageAufDeutsch | None. |
| BruxellesCapitale | With *PublicService*: May 8 (Iris Day), September 27 (holiday of the Wallonia-Brussels Federation), November 2, November 15 (Dynasty Day), December 26. |
| Vlaanderen | July 11 (holiday of the Flemish Community). With *PublicService*: November 2, November 15, December 26. |
| Wallonie | With *PublicService*: September 27, November 2, November 15, December 26. In all cases: the Walloon Region Day, on the third Sunday of September, with `DayOff` set to `False`. |
| DeutschsprachigeGemeinschaft | November 15 (holiday of the German-speaking Community). |

**Sample code**

```xojo
Var cal As New WorkCalendar("BE-BRU", "Brussels")
cal.AddAnnualEvents(WorkCalendar.AnnualEventsBelgium(WorkCalendar.Belgium.BruxellesCapitale, True))
```

---

### AnnualEventsFrance

Returns the public holidays of France.

**Declaration**

```xojo
Shared Function AnnualEventsFrance(Region As France = France.General) As AnnualEvent()
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| Region | France | The region. Default: `General`. |

**Returns**

An array of `AnnualEvent` ([AnnualEventFixed](AnnualEventFixed.md) and [AnnualEventEaster](EasterEvents.md)), with the captions in French.

**Notes**

The eleven holidays of metropolitan France are returned for all the regions: January 1, May 1, May 8, July 14, August 15, November 1, November 11, December 25, Easter Monday, Ascension and Whit Monday. The other holidays are:

| Region | Other holidays |
| ------ | -------------- |
| General | None. |
| AlsaceMoselle | Good Friday and December 26. |
| Guadeloupe | Abolition of slavery, May 27. |
| SaintMartin | Abolition of slavery, May 27. |
| Martinique | Abolition of slavery, May 22. |
| Guyane | Abolition of slavery, June 10. |
| Reunion | Abolition of slavery, December 20. |
| Mayotte | Abolition of slavery, April 27. |
| SaintBarthelemy | Abolition of slavery, October 9. |

---

### AnnualEventsFromRowSet

Returns the annual events that are stored in a database.

**Declaration**

```xojo
Shared Function AnnualEventsFromRowSet(rs As RowSet, Identifier As Variant = Nil, Encoding As TextEncoding = Nil, ValueColumn As String = "value", RegionColumn As String = "region", IdColumn As String = "id_event") As AnnualEvent()
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| rs | RowSet | The rows to read. |
| Identifier | Variant | The identifier of the calendar. Only the rows whose region is equal to this value are read (case and spaces at the beginning and at the end are ignored). If it is `Nil`, the rows with an empty region are read. |
| Encoding | TextEncoding | Optional. The encoding of the text of the database. If `Nil`, UTF-8 is used. |
| ValueColumn | String | The column that contains the text of the event. Default: `"value"`. |
| RegionColumn | String | The column that contains the region. Default: `"region"`. |
| IdColumn | String | The column that contains the identifier of the event. Default: `"id_event"`. |

**Returns**

An array of `AnnualEvent`, rebuilt with `FromString` (the class of each event is found from the text). The `DbId` of each event is the value of *IdColumn*. The array is empty if *rs* is `Nil`.

**Notes**

The method reads the `RowSet` to the end. The `region` and `value` columns are the columns of the row returned by [DbRow](AnnualEvent.md#dbrow).

**Sample code**

```xojo
Var rs As RowSet = db.SelectSQL("SELECT id_event, region, value FROM tevents")
Var events() As AnnualEvent = WorkCalendar.AnnualEventsFromRowSet(rs, "FR")
```

---

### AnnualEventsIsrael

Returns the public holidays of Israel.

**Declaration**

```xojo
Shared Function AnnualEventsIsrael() As AnnualEvent()
```

**Returns**

An array of [AnnualEventHebraic](AnnualEventHebraic.md), with the captions in Modern Hebrew: the first day and the seventh day of Passover, Yom HaAtzmaut (with the postponement rule of Israel), Shavuot, Rosh Hashanah, Yom Kippur, the first day of Sukkot and Simchat Torah (variant for Israel).

---

### AnnualEventsUSA

Returns the public holidays of the federal government or of a state of the United States.

**Declaration**

```xojo
Shared Function AnnualEventsUSA(State As USA = USA.Federal) As AnnualEvent()
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| State | USA | The federal government or the state. Default: `Federal`. |

**Returns**

An array of `AnnualEvent` ([AnnualEventFixed](AnnualEventFixed.md), [AnnualEventWeekDay](AnnualEventWeekDay.md) and [AnnualEventEaster](EasterEvents.md)), with the captions in English.

**Notes**

The federal holidays are: New Year's Day, Martin Luther King Jr. Day (third Monday of January), Washington's Birthday (third Monday of February), Memorial Day (last Monday of May), Juneteenth (June 19), Independence Day (July 4), Labor Day (first Monday of September), Columbus Day (second Monday of October), Veterans Day (November 11), Thanksgiving (fourth Thursday of November) and Christmas Day. For the holidays on a fixed date, a holiday that falls on a Saturday is observed on the Friday, and a holiday that falls on a Sunday is observed on the Monday.

The lists are available for the federal government and for these states: Alabama, Alaska, Arkansas, Arizona, California, Colorado, Connecticut, Delaware, DistrictOfColumbia and Florida. They follow the official list of each state, with the rule for the weekends when the state defines it. For the other values of the enumeration, the array is empty.

**Sample code**

```xojo
Var cal As New WorkCalendar("US-CA", "California")
cal.AddAnnualEvents(WorkCalendar.AnnualEventsUSA(WorkCalendar.USA.California))
```

---

### ClosurePeriodsFromRowSet

Returns the closure periods that are stored in a database.

**Declaration**

```xojo
Shared Function ClosurePeriodsFromRowSet(rs As RowSet, Identifier As Variant = Nil, Encoding As TextEncoding = Nil, ValueColumn As String = "value", RegionColumn As String = "region", IdColumn As String = "id_period") As ClosurePeriod()
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| rs | RowSet | The rows to read. |
| Identifier | Variant | The identifier of the calendar. Only the rows whose region is equal to this value are read (case and spaces at the beginning and at the end are ignored). If it is `Nil`, the rows with an empty region are read. |
| Encoding | TextEncoding | Optional. The encoding of the text of the database. If `Nil`, UTF-8 is used. |
| ValueColumn | String | The column that contains the text of the period ([ToString](ClosurePeriod.md#tostring)). Default: `"value"`. |
| RegionColumn | String | The column that contains the region. Default: `"region"`. |
| IdColumn | String | The column that contains the identifier of the period. Default: `"id_period"`. |

**Returns**

An array of [ClosurePeriod](ClosurePeriod.md). The array is empty if *rs* is `Nil` or has no row.

**Notes**

The `value` column contains the text returned by [ToString](ClosurePeriod.md#tostring) (see [DbRow](ClosurePeriod.md#dbrow)). The `DbId` of each period is the value of *IdColumn*. If your table uses another name for the identifier, pass it in *IdColumn* or rename it in the `SELECT`. The method reads the `RowSet` to the end.

**Sample code**

```xojo
Var rs As RowSet = db.SelectSQL("SELECT id_period, region, value FROM tperiods")
Var periods() As ClosurePeriod = WorkCalendar.ClosurePeriodsFromRowSet(rs, "BE-WAL")
```

---

## See also

[wcWorkingWeekDays](wcWorkingWeekDays.md), [ClosurePeriod](ClosurePeriod.md), [DateAndCaption](DateAndCaption.md) and [WorkCalendarGroup](WorkCalendarGroup.md) (which manages several calendars) classes; [AnnualEvent](AnnualEvent.md) interface; [AnnualEventFixed](AnnualEventFixed.md), [AnnualEventWeekDay](AnnualEventWeekDay.md), [AnnualEventEaster and AnnualEventOrthodoxEaster](EasterEvents.md) and [AnnualEventHebraic](AnnualEventHebraic.md) classes.
