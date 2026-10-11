# ClosurePeriod

## Description

Holds a period of holidays or closure, from a first day to a last day, with a caption. For example, the summer holidays of a school or the annual closure of a company.

## Notes

A `ClosurePeriod` is defined by its first day ([FirstDay](#firstday)), its last day ([LastDay](#lastday)) and a name ([Caption](#caption)). Both days are part of the period.

The time of the two dates is normalized: `FirstDay` is always at 00:00:00 and `LastDay` is always at 23:59:59. A period is therefore made of whole days, and any time on the first day, on the last day or between them is in the period.

The class provides the number of days of the period ([Duration](#duration)), tests whether a date is in the period ([IsIncluded](#isincluded)), and gives the moment when work stops ([LastDayOfWork](#lastdayofwork)) and when it resumes ([ReturnToWork](#returntowork)).

A period can be saved as text with [ToString](#tostring) and rebuilt with [FromString](#fromstring), or saved in a database with [DbRow](#dbrow). `Tag` and `DbId` are not part of this text.

The class works like an annual event for the database: [DbRow](#dbrow), [ToString](#tostring), [FromString](#fromstring), `DbId` and `Tag` have the same meaning as in the [AnnualEvent](AnnualEvent.md) interface. `ClosurePeriod` does not implement the interface, because a period has no date to calculate for a year.

A period must have a first day and a last day: assigning `Nil` to `FirstDay` or `LastDay`, or passing `Nil` to a constructor, raises an `InvalidArgumentException`. The order of the two dates is not checked: the last day must not be before the first day.

## Sample code

Create a period and get its duration:

```xojo
Var summer As New ClosurePeriod(New DateTime(2026, 7, 4), New DateTime(2026, 8, 31), "Summer holidays")

MessageBox(summer.Duration.ToString) // 59
```

Test whether a date is in the period:

```xojo
If summer.IsIncluded(New DateTime(2026, 8, 15)) Then
  MessageBox("Closed")
End If

If Not summer.IsIncluded(New DateTime(2026, 9, 1)) Then
  MessageBox("Open")
End If
```

Find when work stops and when it resumes:

```xojo
Var stopWork As DateTime = summer.LastDayOfWork // 2026-07-03 23:59:59
Var resume As DateTime = summer.ReturnToWork    // 2026-09-01 00:00:00
```

When a period starts on a Monday or ends on a Friday, use the *skipWeekends* parameter to get the last working day and the first working day. The autumn holidays below start on Monday, October 19, 2026 and end on Friday, October 30, 2026:

```xojo
Var autumn As New ClosurePeriod(New DateTime(2026, 10, 19), New DateTime(2026, 10, 30), "Autumn holidays")

autumn.LastDayOfWork        // 2026-10-18 23:59:59 (Sunday)
autumn.LastDayOfWork(True)  // 2026-10-16 23:59:59 (Friday)

autumn.ReturnToWork         // 2026-10-31 00:00:00 (Saturday)
autumn.ReturnToWork(True)   // 2026-11-02 00:00:00 (Monday)
```

Save a period and rebuild it:

```xojo
Var s As String = summer.ToString
Var restored As ClosurePeriod = ClosurePeriod.FromString(s)
```

Save a period in a database, for the region "FR" (see the example of the table in [WorkCalendar](WorkCalendar.md#database-tables)):

```xojo
db.AddRow("tperiods", summer.DbRow("FR"))
```

## Compatibility

Uses `DateTime` (API 2).

## Properties

| Property | Type | Read | Write | Description |
| -------- | ---- | :--: | :---: | ----------- |
| [Caption](#caption) | String | ✓ | ✓ | The name of the period. |
| [DbId](#dbid) | Variant | ✓ | ✓ | The identifier of the period in a database. |
| [FirstDay](#firstday) | DateTime | ✓ | ✓ | The first day of the period, at 00:00:00. |
| [LastDay](#lastday) | DateTime | ✓ | ✓ | The last day of the period, at 23:59:59. |
| [Tag](#tag) | Variant | ✓ | ✓ | A value reserved for your own use. |

## Methods

| Method | Parameters | Returns |
| ------ | ---------- | ------- |
| [Constructor](#constructor) | *lFirstDay* As DateTime, *lLastDay* As DateTime, *lCaption* As String = "" | |
| [Constructor](#constructor) | *copy* As ClosurePeriod | |
| [Constructor](#constructor) | *FromStringValue* As String | |
| [DbRow](#dbrow) | *RegionIdentifier* As Variant = Nil, *encoding* As TextEncoding = Nil | DatabaseRow |
| [Duration](#duration) | | Integer |
| [IsIncluded](#isincluded) | *lDate* As DateTime | Boolean |
| [LastDayOfWork](#lastdayofwork) | *skipWeekends* As Boolean = False | DateTime |
| [ReturnToWork](#returntowork) | *skipWeekends* As Boolean = False | DateTime |
| [ToString](#tostring) | | String |

## Shared methods

| Method | Parameters | Returns |
| ------ | ---------- | ------- |
| [FromString](#fromstring) | *value* As String | ClosurePeriod |

---

## Property descriptions

### Caption

The name of the period.

**Declaration**

```xojo
Property Caption As String
```

**Notes**

For example `"Summer holidays"`. When you save the period with [ToString](#tostring), the caption is encoded so that it can contain any character.

---

### DbId

The identifier of the period in a database.

**Declaration**

```xojo
Property DbId As Variant
```

**Notes**

The type is `Variant` so that any kind of key can be used. The value is not used by the class itself and is not part of [ToString](#tostring).

---

### FirstDay

The first day of the period.

**Declaration**

```xojo
Property FirstDay As DateTime
```

**Notes**

The time of the date you assign is set to 00:00:00, so the whole first day is in the period. The value you read is the normalized date. Assigning `Nil` raises an `InvalidArgumentException`.

---

### LastDay

The last day of the period.

**Declaration**

```xojo
Property LastDay As DateTime
```

**Notes**

The time of the date you assign is set to 23:59:59, so the whole last day is in the period. The value you read is the normalized date. Assigning `Nil` raises an `InvalidArgumentException`.

---

### Tag

A value reserved for your own use.

**Declaration**

```xojo
Property Tag As Variant
```

**Notes**

The value is not used by the class itself and is not part of [ToString](#tostring).

---

## Method descriptions

### Constructor

Creates a new period.

**Declaration**

```xojo
Sub Constructor(lFirstDay As DateTime, lLastDay As DateTime, lCaption As String = "")
Sub Constructor(copy As ClosurePeriod)
Sub Constructor(FromStringValue As String)
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| lFirstDay | DateTime | The first day. |
| lLastDay | DateTime | The last day. |
| lCaption | String | The name of the period. Default: empty. |
| copy | ClosurePeriod | A period to copy. |
| FromStringValue | String | A string produced by [ToString](#tostring). |

**Notes**

*Constructor 1:* creates a period with the specified days and caption. The time of the days is normalized (see [FirstDay](#firstday) and [LastDay](#lastday)). It raises an `InvalidArgumentException` if one of the dates is `Nil`.

*Constructor 2:* creates a copy of a period. All the properties are duplicated.

*Constructor 3:* creates a period from a string produced by [ToString](#tostring). It raises an `InvalidArgumentException` if the string is not valid. This is the same as [FromString](#fromstring).

**Sample code**

```xojo
Var a As New ClosurePeriod(New DateTime(2026, 12, 19), New DateTime(2027, 1, 3), "Christmas holidays")
Var b As New ClosurePeriod(a)
Var c As New ClosurePeriod(a.ToString)
```

---

### DbRow

Returns a `DatabaseRow` that contains the period, to make it easy to save the period in a database.

**Declaration**

```xojo
Function DbRow(RegionIdentifier As Variant = Nil, encoding As TextEncoding = Nil) As DatabaseRow
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| RegionIdentifier | Variant | Optional. Identifies the region (country, state, school, etc.) to which the period belongs. |
| encoding | TextEncoding | Optional. The encoding of the text values. If `Nil` or `Encodings.UTF8`, UTF-8 is used. |

**Returns**

A `DatabaseRow` that can be passed to `DatabaseConnection.AddRow`, with two columns:

| Column | Description |
| ------ | ----------- |
| region | The text of *RegionIdentifier*, or an empty string if it is `Nil`. |
| value | The result of [ToString](#tostring). |

**Notes**

It is the same as the [DbRow](AnnualEvent.md#dbrow) method of the annual events. The whole period is stored in the `value` column, so a table with these two columns is enough. To read the periods of a region back, see [ClosurePeriodsFromRowSet](WorkCalendar.md#closureperiodsfromrowset) and [LoadClosurePeriodsFromRowSet](WorkCalendar.md#loadclosureperiodsfromrowset) of the [WorkCalendar](WorkCalendar.md) class. The `DbId` is not stored in the row: it is set when you read the periods with `ClosurePeriodsFromRowSet`.

**Sample code**

```xojo
Var row As DatabaseRow = p.DbRow("BE-WAL")
db.AddRow("tperiods", row)
```

---

### Duration

Returns the number of days of the period.

**Declaration**

```xojo
Function Duration() As Integer
```

**Returns**

The number of days, the first day and the last day included. A period of a single day has a duration of `1`. The result does not depend on the changes between summer time and winter time.

**Sample code**

```xojo
Var p As New ClosurePeriod(New DateTime(2026, 4, 4), New DateTime(2026, 4, 19), "Spring holidays")
MessageBox(p.Duration.ToString) // 16
```

---

### IsIncluded

Indicates whether a date is in the period.

**Declaration**

```xojo
Function IsIncluded(lDate As DateTime) As Boolean
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| lDate | DateTime | The date to test. |

**Returns**

`True` if *lDate* is between the first day and the last day of the period, both included. `False` otherwise, or if *lDate* is `Nil`.

**Sample code**

```xojo
If p.IsIncluded(DateTime.Now) Then
  MessageBox(p.Caption)
End If
```

---

### LastDayOfWork

Returns the moment at which work stops before the period.

**Declaration**

```xojo
Function LastDayOfWork(skipWeekends As Boolean = False) As DateTime
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| skipWeekends | Boolean | Optional. If `True`, Saturdays and Sundays are skipped. Default: `False`. |

**Returns**

A `DateTime` with the day before the first day of the period, at 23:59:59. With *skipWeekends* set to `True`, if this day is a Saturday or a Sunday, the result is the Friday before.

**Notes**

Use *skipWeekends* when the period starts on a Monday: the last working day is then the Friday before. The method assumes that the weekend is Saturday and Sunday. It does not take public holidays into account.

**Sample code**

```xojo
Var d As DateTime = autumn.LastDayOfWork(True) // 2026-10-16 23:59:59 (Friday)
```

---

### ReturnToWork

Returns the moment at which work resumes after the period.

**Declaration**

```xojo
Function ReturnToWork(skipWeekends As Boolean = False) As DateTime
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| skipWeekends | Boolean | Optional. If `True`, Saturdays and Sundays are skipped. Default: `False`. |

**Returns**

A `DateTime` with the day after the last day of the period, at 00:00:00. With *skipWeekends* set to `True`, if this day is a Saturday or a Sunday, the result is the Monday after.

**Notes**

Use *skipWeekends* when the period ends on a Friday: work then resumes on the Monday after. The method assumes that the weekend is Saturday and Sunday. It does not take public holidays into account.

**Sample code**

```xojo
Var d As DateTime = autumn.ReturnToWork(True) // 2026-11-02 00:00:00 (Monday)
```

---

### ToString

Returns a text representation of the period.

**Declaration**

```xojo
Function ToString() As String
```

**Returns**

A `String` that contains the caption (encoded), the first day and the last day.

**Notes**

Use [FromString](#fromstring) to rebuild the period. `Tag` and `DbId` are not included. The format is internal and may change.

---

## Shared method descriptions

### FromString

Creates a period from a string produced by [ToString](#tostring).

**Declaration**

```xojo
Shared Function FromString(value As String) As ClosurePeriod
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| value | String | The string, as returned by `ToString`. |

**Returns**

A new `ClosurePeriod`.

**Notes**

The method raises an `InvalidArgumentException` if the string is not a valid description of a period.

**Sample code**

```xojo
Var s As String = p.ToString
Var restored As ClosurePeriod = ClosurePeriod.FromString(s)
```

---

## See also

[WorkCalendar](WorkCalendar.md) class, which uses the closure periods; `DateTime` class.
