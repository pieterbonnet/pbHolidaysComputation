# WorkCalendarGroup

## Description

Manages a group of [WorkCalendar](WorkCalendar.md) objects, for example one for each region, country, site or school of an organization, each with its own public holidays, closure periods and working week. The class answers questions about the whole group, such as "is this day open everywhere?", "is it open in at least one place?" or "in which regions is it closed?".

## Notes

A `WorkCalendarGroup` contains an array of calendars, [WorkCalendars](#workcalendars). Add the calendars with `WorkCalendars.Add`, or load them from a database with [LoadCalendars](#loadcalendars).

The methods have two forms, depending on the question:

- the methods whose name ends with `Everywhere` test whether the condition is true in **all** the calendars of the group. For example, [IsWorkingDayEverywhere](#isworkingdayeverywhere) is `True` only if the day is worked in every calendar;
- the methods whose name ends with `Somewhere` test whether the condition is true in **at least one** calendar. For example, [IsWorkingDaySomewhere](#isworkingdaysomewhere) is `True` if the day is worked in at least one calendar.

This also applies to the non-working days: [NonWorkingDaysEverywhere](#nonworkingdayseverywhere) returns the days that are not worked in any calendar (closed everywhere), which is the opposite of [BusinessDaysSomewhere](#businessdayssomewhere).

The methods whose name starts with `WhereIs` return the calendars for which the condition is true.

A calendar whose `Enabled` property is `False` is ignored by all the methods. If no calendar is enabled (or if the group is empty), the methods that return a `Boolean` return `False`, the methods that return an array return an empty array, the methods that return a number of days return `-1`, and the methods that return a date return `Nil`.

The calendars are identified by their [Identifier](WorkCalendar.md#identifier) (for example `"FR"` or `"BE-WAL"`), which is also the region used in the database tables. See [WorkCalendar](WorkCalendar.md) for the definition of a working day, a closure period and an annual event.

> **Warning:** the `WhereIs...` methods ([WhereIsAnnualEvent](#whereisannualevent), [WhereIsInClosurePeriod](#whereisinclosureperiod), [WhereIsNonWorkingDay](#whereisnonworkingday) and [WhereIsWorkingDay](#whereisworkingday)) return references to the `WorkCalendar` objects of the group, not copies. If you change a calendar of the result (its working week, its annual events, its closure periods, its `Enabled` property, etc.), you change the calendar of the group, and the answers of all the methods of the group change with it. Handle the result with care: read it, or work on a copy.
>
> The array that is returned is a new array: adding items to it or removing items from it does not change the group. To work on a copy of a calendar, use the copy constructor and pass the identifier and the caption, which are not copied: `Var copy As New WorkCalendar(c, c.Identifier, c.Caption)`.

The methods work on days: pass dates at 00:00:00.

### Database tables

The group can load its calendars, annual events and closure periods from three tables. The tables of the events and of the closure periods are described in [WorkCalendar](WorkCalendar.md#database-tables): the `region` column of a row contains the identifier of the calendar to which it belongs. The calendars are stored in a third table, here an example for SQLite:

```sql
CREATE TABLE tcalendars (
  id_calendar INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT,
  identifier TEXT NOT NULL,
  workingWeek TEXT NOT NULL
);
```

The `workingWeek` column contains the text returned by [ToString](wcWorkingWeekDays.md#tostring) of `wcWorkingWeekDays`, for example `0111110`.

## Sample code

A company with a site in France and a site in Wallonia:

```xojo
Var fr As New WorkCalendar("FR", "France")
fr.AddAnnualEvents(WorkCalendar.AnnualEventsFrance(WorkCalendar.France.General))

Var wal As New WorkCalendar("BE-WAL", "Wallonia")
wal.AddAnnualEvents(WorkCalendar.AnnualEventsBelgium(WorkCalendar.Belgium.Wallonie, False))

Var group As New WorkCalendarGroup
group.WorkCalendars.Add(fr)
group.WorkCalendars.Add(wal)
```

Test a day. May 8, 2026 is a holiday in France only. May 14, 2026 (Ascension) is a holiday in both countries:

```xojo
Var d1 As New DateTime(2026, 5, 8)
group.IsWorkingDayEverywhere(d1) // False: closed in France
group.IsWorkingDaySomewhere(d1)  // True: open in Wallonia

Var d2 As New DateTime(2026, 5, 14)
group.IsWorkingDaySomewhere(d2)  // False: closed everywhere
```

Find where a day is closed:

```xojo
Var closed() As WorkCalendar = group.WhereIsNonWorkingDay(d1)
For Each c As WorkCalendar In closed
  MessageBox(c.Caption) // France
Next
```

Count the days that are worked in all the calendars, and in at least one calendar, in May 2026:

```xojo
Var everywhere() As DateTime = group.BusinessDaysEverywhere(New DateTime(2026, 5, 1), New DateTime(2026, 5, 31))
Var somewhere() As DateTime = group.BusinessDaysSomewhere(New DateTime(2026, 5, 1), New DateTime(2026, 5, 31))

MessageBox(everywhere.Count.ToString) // 17
MessageBox(somewhere.Count.ToString)  // 18 (May 8 is open in Wallonia)
```

Count the days on which all the calendars are closed (weekends, and the holidays that are shared by the two countries):

```xojo
Var closed As Integer = group.CountNonWorkingDaysEverywhere(New DateTime(2026, 5, 1), New DateTime(2026, 5, 31))
MessageBox(closed.ToString) // 13: the 18 days open somewhere and the 13 days closed everywhere make the 31 days of May
```

Find the next day on which everybody works:

```xojo
Var d As DateTime = group.BusinessDayOffsetEverywhere(New DateTime(2026, 5, 7))
MessageBox(d.SQLDate) // 2026-05-11 (May 8 is a holiday in France)
```

Load the group from a database:

```xojo
Var calendars() As WorkCalendar = WorkCalendarGroup.LoadCalendars(db.SelectSQL("SELECT name, identifier, workingWeek FROM tcalendars"))

WorkCalendarGroup.LoadAnnualEventsFromRowSet(calendars, db.SelectSQL("SELECT id_event, region, value FROM tevents"))
WorkCalendarGroup.LoadClosurePeriodsFromRowSet(calendars, db.SelectSQL("SELECT region, value FROM tperiods"))

Var group As New WorkCalendarGroup
For Each c As WorkCalendar In calendars
  group.WorkCalendars.Add(c)
Next
```

## Compatibility

Uses `DateTime` and `RowSet` (API 2).

## Properties

| Property | Type | Read | Write | Description |
| -------- | ---- | :--: | :---: | ----------- |
| [Tag](#tag) | Variant | ✓ | ✓ | A value reserved for your own use. |
| [WorkCalendars](#workcalendars) | WorkCalendar() | ✓ | ✓ | The calendars of the group. |

## Methods

| Method | Parameters | Returns |
| ------ | ---------- | ------- |
| [BusinessDaysEverywhere](#businessdayseverywhere) | *starting* As DateTime, *ending* As DateTime | DateTime() |
| [BusinessDaysEverywhere](#businessdayseverywhere) | *year* As Integer | DateTime() |
| [BusinessDayOffsetEverywhere](#businessdayoffseteverywhere) | *startdate* As DateTime, *number* As Integer = 1, *limit* As Integer = 366 | DateTime |
| [BusinessDayOffsetSomewhere](#businessdayoffsetsomewhere) | *startdate* As DateTime, *number* As Integer = 1, *limit* As Integer = 366 | DateTime |
| [BusinessDaysSomewhere](#businessdayssomewhere) | *starting* As DateTime, *ending* As DateTime | DateTime() |
| [BusinessDaysSomewhere](#businessdayssomewhere) | *year* As Integer | DateTime() |
| [Constructor](#constructor) | | |
| [Constructor](#constructor) | *copy* As WorkCalendarGroup | |
| [CountBusinessDaysEverywhere](#countbusinessdayseverywhere) | *Date1* As DateTime, *Date2* As DateTime | Integer |
| [CountNonWorkingDaysEverywhere](#countnonworkingdayseverywhere) | *Date1* As DateTime, *Date2* As DateTime | Integer |
| [IsAnnualEventEverywhere](#isannualeventeverywhere) | *d* As DateTime, *OnlyIfDayOff* As Boolean = False | Boolean |
| [IsAnnualEventSomewhere](#isannualeventsomewhere) | *d* As DateTime, *OnlyIfDayOff* As Boolean = False | Boolean |
| [IsInClosurePeriodEverywhere](#isinclosureperiodeverywhere) | *d* As DateTime | Boolean |
| [IsInClosurePeriodSomewhere](#isinclosureperiodsomewhere) | *d* As DateTime | Boolean |
| [IsWorkingDayEverywhere](#isworkingdayeverywhere) | *d* As DateTime | Boolean |
| [IsWorkingDaySomewhere](#isworkingdaysomewhere) | *d* As DateTime | Boolean |
| [IsWorkingWeekDayEverywhere](#isworkingweekdayeverywhere) | *DayOfWeek* As Integer | Boolean |
| [IsWorkingWeekDaySomewhere](#isworkingweekdaysomewhere) | *DayOfWeek* As Integer | Boolean |
| [ListOfIdentifiers](#listofidentifiers) | | Variant() |
| [NonWorkingDaysEverywhere](#nonworkingdayseverywhere) | *starting* As DateTime, *ending* As DateTime | DateTime() |
| [NonWorkingDaysEverywhere](#nonworkingdayseverywhere) | *year* As Integer | DateTime() |
| [WhereIsAnnualEvent](#whereisannualevent) | *d* As DateTime, *OnlyDayOff* As Boolean = False | WorkCalendar() |
| [WhereIsInClosurePeriod](#whereisinclosureperiod) | *d* As DateTime | WorkCalendar() |
| [WhereIsNonWorkingDay](#whereisnonworkingday) | *d* As DateTime | WorkCalendar() |
| [WhereIsWorkingDay](#whereisworkingday) | *d* As DateTime | WorkCalendar() |

## Shared methods

| Method | Parameters | Returns |
| ------ | ---------- | ------- |
| [LoadAnnualEventsFromRowSet](#loadannualeventsfromrowset) | *WorkCalendars()* As WorkCalendar, *rs* As RowSet, *Encoding* As TextEncoding = Nil, *ValueColumn* As String = "value", *IdentifierColumn* As String = "region", *IdColumn* As String = "id_event" | |
| [LoadCalendars](#loadcalendars) | *rs* As RowSet, *encoding* As TextEncoding = Nil | WorkCalendar() |
| [LoadClosurePeriodsFromRowSet](#loadclosureperiodsfromrowset) | *WorkCalendars()* As WorkCalendar, *rs* As RowSet, *Encoding* As TextEncoding = Nil, *ValueColumn* As String = "value", *IdentifierColumn* As String = "region", *IdColumn* As String = "id_period" | |

---

## Property descriptions

### Tag

A value reserved for your own use.

**Declaration**

```xojo
Property Tag As Variant
```

**Notes**

The value is not used by the class itself.

---

### WorkCalendars

The calendars of the group.

**Declaration**

```xojo
Property WorkCalendars() As WorkCalendar
```

**Notes**

An array of [WorkCalendar](WorkCalendar.md). Add the calendars with `WorkCalendars.Add`. The group does not copy the calendars: the objects you add are the objects that the group uses. Use the `Enabled` property of a calendar to leave it out of the questions of the group.

---

## Method descriptions

### BusinessDaysEverywhere

Returns the days that are business days in all the calendars, between two dates or in a year.

**Declaration**

```xojo
Function BusinessDaysEverywhere(starting As DateTime, ending As DateTime) As DateTime()
Function BusinessDaysEverywhere(year As Integer) As DateTime()
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| starting | DateTime | The first day. |
| ending | DateTime | The last day. |
| year | Integer | The year. |

**Returns**

An array of `DateTime` (time 00:00:00), in chronological order. A day is returned if it is worked in every enabled calendar: its day of the week is worked, it is not in a closure period and no annual event with `DayOff` set to `True` falls on this day. The array is empty if *starting* is after *ending*, or if no calendar is enabled.

**Notes**

The method raises a `NilObjectException` if a date is `Nil`.

---

### BusinessDaysSomewhere

Returns the days that are business days in at least one calendar, between two dates or in a year.

**Declaration**

```xojo
Function BusinessDaysSomewhere(starting As DateTime, ending As DateTime) As DateTime()
Function BusinessDaysSomewhere(year As Integer) As DateTime()
```

**Parameters**

The parameters are the same as those of [BusinessDaysEverywhere](#businessdayseverywhere).

**Returns**

An array of `DateTime` (time 00:00:00), in chronological order. A day is returned once, if it is worked in at least one enabled calendar.

---

### BusinessDayOffsetEverywhere

Returns the business day (worked in all the calendars) that is a number of business days after, or before, a date.

**Declaration**

```xojo
Function BusinessDayOffsetEverywhere(startdate As DateTime, number As Integer = 1, limit As Integer = 366) As DateTime
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| startdate | DateTime | The starting date. It is not counted. |
| number | Integer | The number of business days. `1` is the next business day, `2` the second business day after, and so on. A negative number goes back in time. Default: `1`. |
| limit | Integer | The maximum number of days to go through from *startdate*. Default: `366`. |

**Returns**

A `DateTime` with the date of the business day. If *number* is `0`, the result is *startdate*. The result is `Nil` if the day is not found within *limit* days, or if no calendar is enabled.

**Notes**

The method raises a `NilObjectException` if *startdate* is `Nil`. This is the equivalent of [BusinessDayOffset](WorkCalendar.md#businessdayoffset) of `WorkCalendar` for the whole group. The result has the time of *startdate*.

---

### BusinessDayOffsetSomewhere

Returns the business day (worked in at least one calendar) that is a number of business days after, or before, a date.

**Declaration**

```xojo
Function BusinessDayOffsetSomewhere(startdate As DateTime, number As Integer = 1, limit As Integer = 366) As DateTime
```

**Parameters**

The parameters are the same as those of [BusinessDayOffsetEverywhere](#businessdayoffseteverywhere).

**Returns**

A `DateTime` with the date of the business day, or `Nil` under the same conditions.

---

### Constructor

Creates a new group.

**Declaration**

```xojo
Sub Constructor()
Sub Constructor(copy As WorkCalendarGroup)
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| copy | WorkCalendarGroup | The group to copy. |

**Notes**

*Constructor 1:* creates an empty group.

*Constructor 2:* creates a copy of a group. Each calendar is duplicated (see the copy constructor of [WorkCalendar](WorkCalendar.md#constructor)), with the same identifier and caption: the new group does not share any calendar with the original one.

---

### CountBusinessDaysEverywhere

Counts the days that are business days in all the calendars, between two dates.

**Declaration**

```xojo
Function CountBusinessDaysEverywhere(Date1 As DateTime, Date2 As DateTime) As Integer
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| Date1 | DateTime | The first date. |
| Date2 | DateTime | The second date. |

**Returns**

The number of days that are worked in every enabled calendar, *Date1* and *Date2* included. The order of the dates does not matter. If the two dates are the same day, the result is `1` if the day is worked everywhere, and `0` otherwise. The result is `-1` if no calendar is enabled.

**Notes**

The method raises a `NilObjectException` if a date is `Nil`.

---

### CountNonWorkingDaysEverywhere

Counts the days on which all the calendars are closed, between two dates.

**Declaration**

```xojo
Function CountNonWorkingDaysEverywhere(Date1 As DateTime, Date2 As DateTime) As Integer
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| Date1 | DateTime | The first date. |
| Date2 | DateTime | The second date. |

**Returns**

The number of days that are not worked in any enabled calendar (closed everywhere), *Date1* and *Date2* included. The order of the dates does not matter. If the two dates are the same day, the result is `1` if the day is closed everywhere, and `0` otherwise. The result is `-1` if no calendar is enabled.

**Notes**

The method raises a `NilObjectException` if a date is `Nil`. See also [NonWorkingDaysEverywhere](#nonworkingdayseverywhere).

---

### IsAnnualEventEverywhere

Indicates whether an annual event falls on a date in all the calendars.

**Declaration**

```xojo
Function IsAnnualEventEverywhere(d As DateTime, OnlyIfDayOff As Boolean = False) As Boolean
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| d | DateTime | The date to test. |
| OnlyIfDayOff | Boolean | If `True`, only the events that make a day non-working (`DayOff` is `True`) are tested. Default: `False`. |

**Returns**

`True` if an annual event falls on *d* in every enabled calendar, for example a holiday that is shared by all the regions.

**Notes**

The method raises a `NilObjectException` if *d* is `Nil`. See [IsAnnualEvent](WorkCalendar.md#isannualevent) of `WorkCalendar`.

---

### IsAnnualEventSomewhere

Indicates whether an annual event falls on a date in at least one calendar.

**Declaration**

```xojo
Function IsAnnualEventSomewhere(d As DateTime, OnlyIfDayOff As Boolean = False) As Boolean
```

**Parameters**

The parameters are the same as those of [IsAnnualEventEverywhere](#isannualeventeverywhere).

**Returns**

`True` if an annual event falls on *d* in at least one enabled calendar.

---

### IsInClosurePeriodEverywhere

Indicates whether a date is in a closure period in all the calendars.

**Declaration**

```xojo
Function IsInClosurePeriodEverywhere(d As DateTime) As Boolean
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| d | DateTime | The date to test. |

**Returns**

`True` if *d* is in a closure period in every enabled calendar.

**Notes**

The method raises a `NilObjectException` if *d* is `Nil`.

---

### IsInClosurePeriodSomewhere

Indicates whether a date is in a closure period in at least one calendar.

**Declaration**

```xojo
Function IsInClosurePeriodSomewhere(d As DateTime) As Boolean
```

**Parameters**

The parameter is the same as that of [IsInClosurePeriodEverywhere](#isinclosureperiodeverywhere).

**Returns**

`True` if *d* is in a closure period in at least one enabled calendar.

---

### IsWorkingDayEverywhere

Indicates whether a date is a business day in all the calendars.

**Declaration**

```xojo
Function IsWorkingDayEverywhere(d As DateTime) As Boolean
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| d | DateTime | The date to test. |

**Returns**

`True` if the day is worked in every enabled calendar: the day of the week is worked, the day is not in a closure period and no annual event with `DayOff` set to `True` falls on this day. `False` otherwise, or if no calendar is enabled.

**Notes**

The method raises a `NilObjectException` if *d* is `Nil`. It is the question "is it open everywhere?". See [IsWorkingDay](WorkCalendar.md#isworkingday) of `WorkCalendar`.

---

### IsWorkingDaySomewhere

Indicates whether a date is a business day in at least one calendar.

**Declaration**

```xojo
Function IsWorkingDaySomewhere(d As DateTime) As Boolean
```

**Parameters**

The parameter is the same as that of [IsWorkingDayEverywhere](#isworkingdayeverywhere).

**Returns**

`True` if the day is worked in at least one enabled calendar. `False` if it is closed in all of them, or if no calendar is enabled.

---

### IsWorkingWeekDayEverywhere

Indicates whether a day of the week is worked in all the calendars.

**Declaration**

```xojo
Function IsWorkingWeekDayEverywhere(DayOfWeek As Integer) As Boolean
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| DayOfWeek | Integer | The day of the week, from `1` (Sunday) to `7` (Saturday), as in `DateTime.DayOfWeek`. |

**Returns**

`True` if this day of the week is worked in the [working week](wcWorkingWeekDays.md) of every enabled calendar. Holidays and closure periods are not taken into account.

**Notes**

The method raises an `InvalidArgumentException` if *DayOfWeek* is not between 1 and 7.

---

### IsWorkingWeekDaySomewhere

Indicates whether a day of the week is worked in at least one calendar.

**Declaration**

```xojo
Function IsWorkingWeekDaySomewhere(DayOfWeek As Integer) As Boolean
```

**Parameters**

The parameter is the same as that of [IsWorkingWeekDayEverywhere](#isworkingweekdayeverywhere).

**Returns**

`True` if this day of the week is worked in the working week of at least one enabled calendar.

---

### ListOfIdentifiers

Returns the identifiers of the calendars.

**Declaration**

```xojo
Function ListOfIdentifiers() As Variant()
```

**Returns**

An array with the [Identifier](WorkCalendar.md#identifier) of each enabled calendar, in the order of the group. The array is empty if the group is empty.

---

### NonWorkingDaysEverywhere

Returns the days on which all the calendars are closed, between two dates or in a year.

**Declaration**

```xojo
Function NonWorkingDaysEverywhere(starting As DateTime, ending As DateTime) As DateTime()
Function NonWorkingDaysEverywhere(year As Integer) As DateTime()
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| starting | DateTime | The first day. |
| ending | DateTime | The last day. |
| year | Integer | The year. |

**Returns**

An array of `DateTime` (time 00:00:00), in chronological order. A day is returned if it is not worked in any enabled calendar (closed everywhere): this is the opposite of [BusinessDaysSomewhere](#businessdayssomewhere). The array is empty if *starting* is after *ending*, or if no calendar is enabled.

**Notes**

The method raises a `NilObjectException` if a date is `Nil`.

---

### WhereIsAnnualEvent

Returns the calendars in which an annual event falls on a date.

**Declaration**

```xojo
Function WhereIsAnnualEvent(d As DateTime, OnlyDayOff As Boolean = False) As WorkCalendar()
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| d | DateTime | The date to test. |
| OnlyDayOff | Boolean | If `True`, only the events that make a day non-working (`DayOff` is `True`) are tested. Default: `False`. |

**Returns**

An array of the enabled calendars in which an annual event falls on *d*. **These are the calendars of the group, not copies:** if you change them, you change the group (see the warning in the notes at the beginning of this page). The array is empty if there is none.

**Notes**

The method raises a `NilObjectException` if *d* is `Nil`.

---

### WhereIsInClosurePeriod

Returns the calendars in which a date is in a closure period.

**Declaration**

```xojo
Function WhereIsInClosurePeriod(d As DateTime) As WorkCalendar()
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| d | DateTime | The date to test. |

**Returns**

An array of the enabled calendars in which *d* is in a closure period. **These are the calendars of the group, not copies:** if you change them, you change the group (see the warning in the notes at the beginning of this page).

**Notes**

The method raises a `NilObjectException` if *d* is `Nil`.

---

### WhereIsNonWorkingDay

Returns the calendars in which a date is not a business day.

**Declaration**

```xojo
Function WhereIsNonWorkingDay(d As DateTime) As WorkCalendar()
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| d | DateTime | The date to test. |

**Returns**

An array of the enabled calendars in which *d* is not worked: its day of the week is not worked, it is in a closure period, or an annual event with `DayOff` set to `True` falls on this day. **These are the calendars of the group, not copies:** if you change them, you change the group (see the warning in the notes at the beginning of this page).

**Notes**

The method raises a `NilObjectException` if *d* is `Nil`. To know why a day is not worked in a calendar, use [NonWorkingDayReasonCaption](WorkCalendar.md#nonworkingdayreasoncaption) of this calendar.

**Sample code**

Read the result:

```xojo
For Each c As WorkCalendar In group.WhereIsNonWorkingDay(New DateTime(2026, 5, 8))
  MessageBox(c.Caption + ": " + c.NonWorkingDayReasonCaption(New DateTime(2026, 5, 8)))
  // France: Victoire 1945
Next
```

Be careful when you change the result. `c` is the calendar of the group:

```xojo
Var closed() As WorkCalendar = group.WhereIsNonWorkingDay(New DateTime(2026, 5, 8))

closed(0).Enabled = False // WARNING: the calendar is now disabled in the group too

Var copy As New WorkCalendar(closed(0), closed(0).Identifier, closed(0).Caption) // a copy, independent from the group
copy.WorkingWeek.WorkingSaturday = True // does not change the group
```

---

### WhereIsWorkingDay

Returns the calendars in which a date is a business day.

**Declaration**

```xojo
Function WhereIsWorkingDay(d As DateTime) As WorkCalendar()
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| d | DateTime | The date to test. |

**Returns**

An array of the enabled calendars in which *d* is worked. **These are the calendars of the group, not copies:** if you change them, you change the group (see the warning in the notes at the beginning of this page). The two arrays of `WhereIsWorkingDay` and [WhereIsNonWorkingDay](#whereisnonworkingday) together contain all the enabled calendars.

**Notes**

The method raises a `NilObjectException` if *d* is `Nil`.

---

## Shared method descriptions

### LoadAnnualEventsFromRowSet

Adds the annual events that are stored in a database to the calendars that they belong to.

**Declaration**

```xojo
Shared Sub LoadAnnualEventsFromRowSet(WorkCalendars() As WorkCalendar, rs As RowSet, Encoding As TextEncoding = Nil, ValueColumn As String = "value", IdentifierColumn As String = "region", IdColumn As String = "id_event")
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| WorkCalendars | WorkCalendar() | The calendars to which the events are added. |
| rs | RowSet | The rows to read. |
| Encoding | TextEncoding | Optional. The encoding of the text of the database. If `Nil`, UTF-8 is used. |
| ValueColumn | String | The column that contains the text of the event ([ToString](AnnualEvent.md#tostring)). Default: `"value"`. |
| IdentifierColumn | String | The column that contains the identifier of the calendar (the region). Default: `"region"`. |
| IdColumn | String | The column that contains the identifier of the event. Default: `"id_event"`. |

**Notes**

Each row is added to the calendar whose `Identifier` is equal to the value of *IdentifierColumn* (case and spaces at the beginning and at the end are ignored). The rows that do not match any calendar are ignored. If several calendars have the same identifier, the first one is used. The `DbId` of each event is the value of *IdColumn*. The method reads the `RowSet` to the end. It does nothing if *rs* is `Nil` or if the array is empty.

With a single calendar, use [LoadAnnualEventsFromRowSet](WorkCalendar.md#loadannualeventsfromrowset) of `WorkCalendar`.

---

### LoadCalendars

Creates the calendars that are stored in a database.

**Declaration**

```xojo
Shared Function LoadCalendars(rs As RowSet, encoding As TextEncoding = Nil) As WorkCalendar()
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| rs | RowSet | The rows to read. |
| encoding | TextEncoding | Optional. The encoding of the text of the database. If `Nil`, UTF-8 is used. |

**Returns**

An array of `WorkCalendar`, one for each row. The array is empty if *rs* is `Nil`.

**Notes**

The columns must be named `name` (the caption of the calendar), `identifier` and `workingWeek` (see the example of table above). The identifier is converted to lowercase and the spaces at its beginning and its end are removed. The working week is read with [ReadString](wcWorkingWeekDays.md#readstring).

The method creates the calendars only: their annual events and their closure periods are not loaded. Load them with [LoadAnnualEventsFromRowSet](#loadannualeventsfromrowset) and [LoadClosurePeriodsFromRowSet](#loadclosureperiodsfromrowset). The method reads the `RowSet` to the end.

**Sample code**

```xojo
Var rs As RowSet = db.SelectSQL("SELECT name, identifier, workingWeek FROM tcalendars")
Var calendars() As WorkCalendar = WorkCalendarGroup.LoadCalendars(rs)
```

---

### LoadClosurePeriodsFromRowSet

Adds the closure periods that are stored in a database to the calendars that they belong to.

**Declaration**

```xojo
Shared Sub LoadClosurePeriodsFromRowSet(WorkCalendars() As WorkCalendar, rs As RowSet, Encoding As TextEncoding = Nil, ValueColumn As String = "value", IdentifierColumn As String = "region", IdColumn As String = "id_period")
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| WorkCalendars | WorkCalendar() | The calendars to which the periods are added. |
| rs | RowSet | The rows to read. |
| Encoding | TextEncoding | Optional. The encoding of the text of the database. If `Nil`, UTF-8 is used. |
| ValueColumn | String | The column that contains the text of the period ([ToString](ClosurePeriod.md#tostring)). Default: `"value"`. |
| IdentifierColumn | String | The column that contains the identifier of the calendar (the region). Default: `"region"`. |
| IdColumn | String | The column that contains the identifier of the period. Default: `"id_period"`. |

**Notes**

The `value` column contains the text of the period (see [DbRow](ClosurePeriod.md#dbrow)). Each row is added to the calendar whose `Identifier` is equal to the value of *IdentifierColumn* (case and spaces at the beginning and at the end are ignored). The rows that do not match any calendar are ignored. The `DbId` of each period is the value of *IdColumn*. The method reads the `RowSet` to the end.

The default name of the identifier column is `id_period`, as in the example of the `tperiods` table and in [ClosurePeriodsFromRowSet](WorkCalendar.md#closureperiodsfromrowset) of `WorkCalendar`.

---

## See also

[WorkCalendar](WorkCalendar.md), [ClosurePeriod](ClosurePeriod.md) and [wcWorkingWeekDays](wcWorkingWeekDays.md) classes; [AnnualEvent](AnnualEvent.md) interface.
