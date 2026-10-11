# AnnualEventWeekDay

## Description

Calculates the date of an event that falls on a given occurrence of a weekday in a given month, such as the second Sunday of May or the last Monday of May. The date can then be moved by a number of days ([DayOffset](#dayoffset)).

## Notes

`AnnualEventWeekDay` implements the [AnnualEvent](AnnualEvent.md) interface. The properties and methods of the interface are described on the [AnnualEvent](AnnualEvent.md) page. This page describes what is specific to this class.

The date is defined by three properties:

- [Month](#month): the month of the year (1 to 12);
- [WeekDay](#weekday): the day of the week (1 to 7, where 1 is Sunday, as in `DateTime.DayOfWeek`);
- [Occurrence](#occurrence): which weekday of the month (1 to 5), or the last one (the [kLast](#constants) constant).

[DayOffset](#dayoffset) is then added to the date found. A negative offset gives an earlier date, a positive offset a later date. This lets you define events such as "the Tuesday after the first Monday of November" (first Monday plus one day).

The 5th occurrence of a weekday does not exist in every month. In that case, [DateValue](AnnualEvent.md#datevalue) returns `Nil` for that year. Use `kLast` to always get the last weekday of the month.

The constructors do not check the values. An event with an invalid `Month`, `WeekDay` or `Occurrence` is created, but [DateValue](AnnualEvent.md#datevalue) returns `Nil` for every year.

## Sample code

Thanksgiving (US): fourth Thursday of November.

```xojo
Var e As New AnnualEventWeekDay("Thanksgiving", 11, 5, 4) // Month 11, Thursday (5), 4th
Var d As DateTime = e.DateValue(2026)
MessageBox(d.SQLDate) // 2026-11-26
```

Black Friday and Cyber Monday: the day after and the Monday after Thanksgiving. Both are the fourth Thursday of November, plus an offset.

```xojo
Var blackFriday As New AnnualEventWeekDay("Black Friday", 11, 5, 4)
blackFriday.DayOffset = 1 // Friday, the day after Thanksgiving
blackFriday.DayOff = False

Var cyberMonday As New AnnualEventWeekDay("Cyber Monday", 11, 5, 4)
cyberMonday.DayOffset = 4 // Monday, four days after Thanksgiving
cyberMonday.DayOff = False

MessageBox(blackFriday.DateValue(2026).SQLDate) // 2026-11-27
MessageBox(cyberMonday.DateValue(2026).SQLDate) // 2026-11-30
```

Memorial Day (US): last Monday of May.

```xojo
Var e As New AnnualEventWeekDay("Memorial Day", 5, 2, AnnualEventWeekDay.kLast) // Month 5, Monday (2), last
MessageBox(e.DateValue(2026).SQLDate) // 2026-05-25
```

Election Day (US): Tuesday after the first Monday of November.

```xojo
Var e As New AnnualEventWeekDay("Election Day", 11, 2, 1) // first Monday of November
e.DayOffset = 1                                           // plus one day
MessageBox(e.DateValue(2026).SQLDate) // 2026-11-03
```

Presidential election (US): the same day, but only every four years. The cycle restricts the event to the years 1792, 1796, 1800, and so on.

```xojo
Var e As New AnnualEventWeekDay("Presidential Election", 11, 2, 1)
e.DayOffset = 1
e.CycleFirstYear = 1792
e.CycleYearDuration = 4

MessageBox(e.DateValue(2024).SQLDate) // 2024-11-05
MessageBox(e.DateValue(2028).SQLDate) // 2028-11-07

If e.DateValue(2026) = Nil Then
  MessageBox("No presidential election in 2026")
End If
```

To get the elections that take place two years after (the midterm elections), set `CycleFirstYear` to 1794.

Test a date:

```xojo
If e.IsEventDate(DateTime.Now) Then
  MessageBox("Today is " + e.Caption)
End If
```

Save an event and rebuild it:

```xojo
Var s As String = e.ToString
Var restored As AnnualEvent = AnnualEventWeekDay.FromString(s)
```

## Interfaces

[AnnualEvent](AnnualEvent.md)

## Compatibility

Uses `DateTime` and `DatabaseRow` (API 2).

## Properties

| Property | Type | Read | Write | Description |
| -------- | ---- | :--: | :---: | ----------- |
| [Caption](AnnualEvent.md#caption) | String | ✓ | ✓ | The name of the event. Default: empty. |
| [CycleFirstYear](AnnualEvent.md#cyclefirstyear) | Integer | ✓ | ✓ | The first year of the cycle. Default: `1900`. |
| [CycleYearDuration](AnnualEvent.md#cycleyearduration) | Integer | ✓ | ✓ | The length of the cycle, in years. Default: `1`. |
| [DayOff](AnnualEvent.md#dayoff) | Boolean | ✓ | ✓ | Whether the event is a non-working day. Default: `True`. |
| [DayOffset](#dayoffset) | Integer | ✓ | ✓ | The number of days added to the date of the weekday. Default: `0`. |
| [DbId](AnnualEvent.md#dbid) | Variant | ✓ | ✓ | The identifier of the event in a database. |
| [DefinitionObject](AnnualEvent.md#definitionobject) | Variant | ✓ | | The event itself. |
| [EndOfValidity](AnnualEvent.md#endofvalidity) | DateTime | ✓ | ✓ | The last date on which the event is valid. Default: December 31, year 3999. |
| [FingerPrint](AnnualEvent.md#fingerprint) | String | ✓ | | A string that identifies the definition of the event. |
| [Month](#month) | Integer | ✓ | ✓ | The month of the year (1 to 12). Default: `1`. |
| [Occurrence](#occurrence) | Integer | ✓ | ✓ | Which weekday of the month (1 to 5, or `kLast`). Default: `1`. |
| [StartOfValidity](AnnualEvent.md#startofvalidity) | DateTime | ✓ | ✓ | The first date on which the event is valid. Default: January 1, year 1. |
| [Tag](AnnualEvent.md#tag) | Variant | ✓ | ✓ | A value reserved for your own use. |
| [WeekDay](#weekday) | Integer | ✓ | ✓ | The day of the week (1 to 7, 1 = Sunday). Default: `1`. |

## Methods

| Method | Parameters | Returns |
| ------ | ---------- | ------- |
| [Calculate](AnnualEvent.md#calculate) | *Year* As Integer | [DateAndCaption](DateAndCaption.md) |
| [Constructor](#constructor) | *lCaption* As String = "", *lMonth* As Integer = 1, *lWeekDay* As Integer = 1, *lOccurrence* As Integer = 1 | |
| [Constructor](#constructor) | *copy* As AnnualEventWeekDay | |
| [Constructor](#constructor) | *d* As AnnualEvent | |
| [DateValue](AnnualEvent.md#datevalue) | *year* As Integer | DateTime |
| [DbRow](AnnualEvent.md#dbrow) | *RegionIdentifier* As Variant = Nil, *encoding* As TextEncoding = Nil | DatabaseRow |
| [IsEventDate](AnnualEvent.md#iseventdate) | *d* As DateTime | Boolean |
| [ToString](AnnualEvent.md#tostring) | | String |

## Shared methods

| Method | Parameters | Returns |
| ------ | ---------- | ------- |
| [FromString](#fromstring) | *value* As String | AnnualEvent |

## Constants

| Name | Type | Value | Description |
| ---- | ---- | ----: | ----------- |
| kLast | Number | 6 | Value of [Occurrence](#occurrence) that means the last weekday of the month. |

---

## Implementation of the AnnualEvent members

The members of the [AnnualEvent](AnnualEvent.md) interface behave as described on the interface page. This section lists what is specific to `AnnualEventWeekDay`.

### Default values

A new event created with the first constructor is valid from January 1, year 1 to December 31, year 3999, has no cycle (`CycleYearDuration = 1`, `CycleFirstYear = 1900`), `DayOff` is `True` and `DayOffset` is `0`. With no parameter, it is the first Sunday of January. The copy constructors duplicate all the properties of the source event.

### DateValue

[DateValue](AnnualEvent.md#datevalue) returns the date at 00:00:00, or `Nil` when:

- *year* is before the year of `StartOfValidity` or after the year of `EndOfValidity`;
- `Month` is not between 1 and 12, `WeekDay` is not between 1 and 7, or `Occurrence` is not between 1 and `kLast`;
- the cycle does not include the year (only checked when `CycleYearDuration` is greater than `1`);
- the occurrence does not exist in the month (for example a 5th Friday in a month that has only four). In a debug build, the method also stops at a `Break` in this case;
- the date found, after `DayOffset` is added, is before `StartOfValidity` or after `EndOfValidity`.

The cycle and the validity period apply to the year *year*, and the validity period also applies to the final date, offset included.

### IsEventDate

[IsEventDate](AnnualEvent.md#iseventdate) ignores the time of *d*. Because `DayOffset` can move the event into the previous or the next year (for example an event on the last Monday of December with an offset of 7 days), the method calculates the event for the years `d.Year - 1`, `d.Year` and `d.Year + 1` and returns `True` if one of them falls on *d*.

### DefinitionObject

Returns the event itself.

### FingerPrint

Identifies the definition of the event (see [FingerPrint](AnnualEvent.md#fingerprint)). `Caption`, `Tag` and `DbId` are not included.

### DbRow

The row has two columns, `region` and `value`, as described in [DbRow](AnnualEvent.md#dbrow). The `value` column contains the result of `ToString`, so it can be read back with [FromString](#fromstring).

### ToString

The text can be used with [FromString](#fromstring) to rebuild the event. Its format is internal and may change.

---

## Property descriptions

### DayOffset

The number of days added to the date of the weekday.

**Declaration**

```xojo
Property DayOffset As Integer
```

**Notes**

A negative value gives an earlier date and a positive value a later date. The default value is `0` (no offset).

**Sample code**

```xojo
// Black Friday: the day after the fourth Thursday of November
Var e As New AnnualEventWeekDay("Black Friday", 11, 5, 4)
e.DayOffset = 1
```

---

### Month

The month of the year in which the weekday is searched.

**Declaration**

```xojo
Property Month As Integer
```

**Notes**

A value from `1` (January) to `12` (December). With any other value, [DateValue](AnnualEvent.md#datevalue) returns `Nil`.

---

### Occurrence

Which weekday of the month is used.

**Declaration**

```xojo
Property Occurrence As Integer
```

**Notes**

A value from `1` (first) to `5` (fifth), or [kLast](#constants) for the last weekday of the month. The fifth weekday does not exist in every month: in that case, `DateValue` returns `Nil` for that year. With any other value, `DateValue` returns `Nil`.

---

### WeekDay

The day of the week.

**Declaration**

```xojo
Property WeekDay As Integer
```

**Notes**

A value from `1` to `7`, as in `DateTime.DayOfWeek`:

| Value | Day |
| ----: | --- |
| 1 | Sunday |
| 2 | Monday |
| 3 | Tuesday |
| 4 | Wednesday |
| 5 | Thursday |
| 6 | Friday |
| 7 | Saturday |

With any other value, [DateValue](AnnualEvent.md#datevalue) returns `Nil`.

---

## Method descriptions

### Constructor

Creates a new event.

**Declaration**

```xojo
Sub Constructor(lCaption As String = "", lMonth As Integer = 1, lWeekDay As Integer = 1, lOccurrence As Integer = 1)
Sub Constructor(copy As AnnualEventWeekDay)
Sub Constructor(d As AnnualEvent)
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| lCaption | String | The name of the event. Default: empty. |
| lMonth | Integer | The month (1 to 12). Default: `1`. |
| lWeekDay | Integer | The day of the week (1 to 7, 1 = Sunday). Default: `1`. |
| lOccurrence | Integer | Which weekday of the month (1 to 5, or `kLast`). Default: `1`. |
| copy | AnnualEventWeekDay | An event to copy. |
| d | AnnualEvent | An event to copy. It must be an `AnnualEventWeekDay`. |

**Notes**

*Constructor 1:* creates an event with the specified caption, month, weekday and occurrence. The values are not checked. With no parameter, it creates an event on the first Sunday of January with an empty caption.

*Constructor 2:* creates a copy of an `AnnualEventWeekDay`. All the properties are duplicated.

*Constructor 3:* creates a copy of another `AnnualEvent`. It raises a `NilObjectException` if *d* is `Nil` and an `InvalidArgumentException` if *d* is not an `AnnualEventWeekDay`. All the properties are duplicated.

**Sample code**

```xojo
Var a As New AnnualEventWeekDay("Mother's Day", 5, 1, 2) // second Sunday of May
Var b As New AnnualEventWeekDay(a)
```

---

## Shared method descriptions

### FromString

Creates an event from a string produced by [ToString](AnnualEvent.md#tostring).

**Declaration**

```xojo
Shared Function FromString(value As String) As AnnualEvent
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| value | String | The string, as returned by `ToString`. |

**Returns**

An object that implements `AnnualEvent`. The class of the object depends on the event described in the string.

**Notes**

The method works like [AnnualEventEaster.FromString](EasterEvents.md#fromstring): it can rebuild any of the classes that implement `AnnualEvent`. It raises an `InvalidArgumentException` if the string is not a valid description of an event.

**Sample code**

```xojo
Var s As String = e.ToString
Var restored As AnnualEvent = AnnualEventWeekDay.FromString(s)
```

---

## See also

[AnnualEvent](AnnualEvent.md) interface; [AnnualEventEaster and AnnualEventOrthodoxEaster](EasterEvents.md) classes; [DateAndCaption](DateAndCaption.md), `DateTime`, `DatabaseRow` classes.
