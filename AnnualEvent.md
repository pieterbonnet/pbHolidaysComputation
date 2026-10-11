# AnnualEvent

## Description

Interface implemented by classes that calculate the date of an event that occurs every year, such as a public holiday, a religious celebration or a commemoration.

## Notes

`AnnualEvent` defines a common contract for several calculation modes. Each implementing class provides its own way of finding the date of the event for a given year (for example, a fixed date, a date based on Easter, or the *n*th weekday of a month). Code that uses the interface does not need to know which calculation mode is used.

Because Xojo interfaces cannot declare properties, the properties of `AnnualEvent` are declared as a pair of members with the same name: a function that gets the value and a method with an `Assigns` parameter that sets it. They are used like regular properties:

```xojo
Var e As AnnualEvent = New AnnualEventEaster("Easter Monday", AnnualEventEaster.EasterMonday)
e.Caption = "Lundi de Pâques"   // calls Caption(Assigns s As String)
Var c As String = e.Caption     // calls Caption() As String
```

An event can be limited in time with [StartOfValidity](#startofvalidity) and [EndOfValidity](#endofvalidity), and can be restricted to a repeating cycle of years with [CycleFirstYear](#cyclefirstyear) and [CycleYearDuration](#cycleyearduration).

An event can be saved as text with [ToString](#tostring) or as a database row with [DbRow](#dbrow). Each implementing class provides a shared `FromString` method to rebuild an event from this text.

Details that depend on the calculation mode (default values, content of `FingerPrint`, text format) are described on the page of each class.

## Sample code

Calculate the dates of a list of events, whatever their type:

```xojo
Var events() As AnnualEvent
events.Add(New AnnualEventEaster("Easter Monday", AnnualEventEaster.EasterMonday))
events.Add(New AnnualEventEaster("Pentecost", AnnualEventEaster.Pentecost))

For Each e As AnnualEvent In events
  Var r As DateAndCaption = e.Calculate(2026)
  If r <> Nil Then
    // The event occurs in 2026
  End If
Next
```

## Classes that implement AnnualEvent

| Class | Calculation mode |
| ----- | ---------------- |
| [AnnualEventEaster](EasterEvents.md) | Western (Gregorian) Easter, plus or minus a number of days. |
| [AnnualEventOrthodoxEaster](EasterEvents.md) | Orthodox Easter, plus or minus a number of days. |
| [AnnualEventFixed](AnnualEventFixed.md) | Fixed date (month and day), with an optional offset, move to a weekday, or weekend adjustment. |
| [AnnualEventWeekDay](AnnualEventWeekDay.md) | A given occurrence (first, second, ..., last) of a weekday in a month, plus or minus a number of days. |
| [AnnualEventHebraic](AnnualEventHebraic.md) | Jewish holidays and dates of the Hebrew calendar. |

## Compatibility

Uses `DateTime` and `DatabaseRow` (API 2).

## Properties

| Property | Type | Read | Write | Description |
| -------- | ---- | :--: | :---: | ----------- |
| [Caption](#caption) | String | ✓ | ✓ | The name of the event. |
| [CycleFirstYear](#cyclefirstyear) | Integer | ✓ | ✓ | The first year of the cycle. |
| [CycleYearDuration](#cycleyearduration) | Integer | ✓ | ✓ | The length of the cycle, in years. |
| [DayOff](#dayoff) | Boolean | ✓ | ✓ | Whether the event is a non-working day. |
| [DbId](#dbid) | Variant | ✓ | ✓ | The identifier of the event in a database. |
| [DefinitionObject](#definitionobject) | Variant | ✓ | | The object holding the definition of the event. |
| [EndOfValidity](#endofvalidity) | DateTime | ✓ | ✓ | The last date on which the event is valid. |
| [FingerPrint](#fingerprint) | String | ✓ | | A string that identifies the definition of the event. |
| [StartOfValidity](#startofvalidity) | DateTime | ✓ | ✓ | The first date on which the event is valid. |
| [Tag](#tag) | Variant | ✓ | ✓ | A value reserved for your own use. |

## Methods

| Method | Parameters | Returns |
| ------ | ---------- | ------- |
| [Calculate](#calculate) | *Year* As Integer | [DateAndCaption](DateAndCaption.md) |
| [DateValue](#datevalue) | *Year* As Integer | DateTime |
| [DbRow](#dbrow) | *RegionIdentifier* As Variant = Nil, *encoding* As TextEncoding = Nil | DatabaseRow |
| [IsEventDate](#iseventdate) | *d* As DateTime | Boolean |
| [ToString](#tostring) | | String |

---

## Property descriptions

### Caption

The name of the event.

**Declaration**

```xojo
Function Caption() As String
Sub Caption(Assigns s As String)
```

**Notes**

The caption is the text displayed for the event, for example `"Christmas Day"` or `"Easter Monday"`. It is also returned in the result of [Calculate](#calculate).

The caption is not part of the definition of the event: two events with a different caption can have the same [FingerPrint](#fingerprint).

If you save events in a database with [DbRow](#dbrow), the length of the caption determines most of the size of the stored text. Keep captions short if your database enforces the size of columns (see the note on column size in [DbRow](#dbrow)).

**Sample code**

```xojo
e.Caption = "Easter Monday"
MessageBox(e.Caption)
```

---

### CycleFirstYear

The first year of the cycle in which the event occurs.

**Declaration**

```xojo
Function CycleFirstYear() As Integer
Sub CycleFirstYear(Assigns value As Integer)
```

**Notes**

Used together with [CycleYearDuration](#cycleyearduration) for events that do not occur every year but repeat over a cycle of several years. The event does not occur before this year.

For example, with `CycleFirstYear = 2024` and `CycleYearDuration = 4`, the event occurs in 2024, 2028, 2032, and so on.

---

### CycleYearDuration

The length, in years, of the cycle in which the event occurs.

**Declaration**

```xojo
Function CycleYearDuration() As Integer
Sub CycleYearDuration(Assigns value As Integer)
```

**Notes**

A value of `1` means that the event occurs every year (no cycle). In that case, [CycleFirstYear](#cyclefirstyear) is ignored.

---

### DayOff

Indicates whether the event is a non-working day.

**Declaration**

```xojo
Function DayOff() As Boolean
Sub DayOff(Assigns value As Boolean)
```

**Notes**

Set to `True` for public holidays and other days on which work is normally not performed. Set to `False` for events that are only observed or celebrated, such as Valentine's Day.

**Sample code**

```xojo
e.Caption = "Labour Day"
e.DayOff = True
```

---

### DbId

The identifier of the event in a database.

**Declaration**

```xojo
Function DbId() As Variant
Sub DbId(Assigns value As Variant)
```

**Notes**

The type is `Variant` so that any kind of key (integer, string, UUID) can be used. The value is not used by the class itself and is not part of [ToString](#tostring) or [DbRow](#dbrow).

---

### DefinitionObject

The object that holds the definition of the event.

**Declaration**

```xojo
Function DefinitionObject() As Variant
```

**Notes**

*Read-only.*

In the existing classes, the definition object is the event itself. This lets you copy an event of the same class from any `AnnualEvent` reference.

---

### EndOfValidity

The last date on which the event is valid.

**Declaration**

```xojo
Function EndOfValidity() As DateTime
Sub EndOfValidity(Assigns d As DateTime)
```

**Notes**

The event does not occur after this date. The time of the date you assign is set to 23:59:59, so the whole last day is included. Passing `Nil` raises a `NilObjectException`.

Use together with [StartOfValidity](#startofvalidity) when an event was created, changed or abolished at a given date, for example a public holiday that exists only until a certain year.

---

### FingerPrint

A string that identifies the definition of the event.

**Declaration**

```xojo
Function FingerPrint() As String
```

**Notes**

*Read-only.*

The [Caption](#caption) and the [Tag](#tag) are ignored. Two events that are the same feast but have a different caption or tag have the same `FingerPrint`. You can compare fingerprints to avoid creating the same event twice under different names.

The content of the string depends on the class (see the page of each class).

**Sample code**

```xojo
For Each existing As AnnualEvent In events
  If existing.FingerPrint = newEvent.FingerPrint Then
    // This event already exists, with the caption existing.Caption
    Return
  End If
Next

events.Add(newEvent)
```

---

### StartOfValidity

The first date on which the event is valid.

**Declaration**

```xojo
Function StartOfValidity() As DateTime
Sub StartOfValidity(Assigns d As DateTime)
```

**Notes**

The event does not occur before this date. The time of the date you assign is set to 00:00:00. Passing `Nil` raises a `NilObjectException`.

See also [EndOfValidity](#endofvalidity).

---

### Tag

A value reserved for your own use.

**Declaration**

```xojo
Function Tag() As Variant
Sub Tag(Assigns value As Variant)
```

**Notes**

The value is not used by the class itself and is not part of [ToString](#tostring) or [DbRow](#dbrow).

---

## Method descriptions

### Calculate

Calculates the date of the event for the specified year and returns it with the caption of the event.

**Declaration**

```xojo
Function Calculate(Year As Integer) As DateAndCaption
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| Year | Integer | The year for which to calculate the date. |

**Returns**

A [DateAndCaption](DateAndCaption.md) object containing the date of the event and its caption, or `Nil` if the event does not occur that year (see [DateValue](#datevalue)).

**Sample code**

```xojo
Var result As DateAndCaption = e.Calculate(2026)
If result <> Nil Then
  // The event occurs in 2026
End If
```

---

### DateValue

Returns the date of the event for the specified year.

**Declaration**

```xojo
Function DateValue(Year As Integer) As DateTime
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| Year | Integer | The year for which to calculate the date. |

**Returns**

A `DateTime` with the date of the event, or `Nil` if the event does not occur that year.

**Notes**

The method returns `Nil` when the year is not valid, when the cycle does not include it, or when the date is outside the validity period (see [CycleFirstYear](#cyclefirstyear), [StartOfValidity](#startofvalidity) and [EndOfValidity](#endofvalidity)).

Use `DateValue` when you only need the date. Use [Calculate](#calculate) when you also need the caption.

**Sample code**

```xojo
Var d As DateTime = e.DateValue(2026)
If d <> Nil Then
  MessageBox(d.SQLDate)
End If
```

---

### DbRow

Returns a `DatabaseRow` that contains the event, to make it easy to save the event in a database.

**Declaration**

```xojo
Function DbRow(RegionIdentifier As Variant = Nil, encoding As TextEncoding = Nil) As DatabaseRow
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| RegionIdentifier | Variant | Optional. Identifies the region (country, state, etc.) to which the event belongs. |
| encoding | TextEncoding | Optional. The encoding of the text values. If `Nil` or `Encodings.UTF8`, UTF-8 is used. |

**Returns**

A `DatabaseRow` that can be passed to `DatabaseConnection.AddRow`, with two columns:

| Column | Description |
| ------ | ----------- |
| region | The text of *RegionIdentifier*, or an empty string if it is `Nil`. |
| value | The result of [ToString](#tostring). |

**Notes**

The whole definition of the event is stored in a single text value, thanks to [ToString](#tostring). A table with these two columns is therefore enough to store events of any class. To read an event back, pass the `value` column to the shared `FromString` method of a class.

Use *RegionIdentifier* to manage different lists of events for different regions. For example, you can save the public holidays of each country or state in the same table and then read only the rows of the region you need.

**Column size:** SQLite does not enforce the declared size of a text column, but most other database engines do. If you use another database, make sure that the `region` column is long enough for your region identifiers and that the `value` column is long enough for the longest `ToString` result. The other fields of the text have a short, predictable length, so the size of `value` mostly depends on the [Caption](#caption): the caption is stored in Base64, which takes about one third more space than the original text. To stay within the size of the column, limit the length of the captions. A value that is too long can be rejected or truncated, which would make the event impossible to rebuild.

**Sample code**

```xojo
// Save an event for the region "FR"
Var row As DatabaseRow = e.DbRow("FR")
db.AddRow("tevents", row)

// Rebuild the events of the region "FR"
Var rs As RowSet = db.SelectSQL("SELECT value FROM tevents WHERE region = ?", "FR")
Var events() As AnnualEvent
While Not rs.AfterLastRow
  events.Add(AnnualEventEaster.FromString(rs.Column("value").StringValue))
  rs.MoveToNextRow
Wend
```

---

### IsEventDate

Indicates whether the specified date is a date of the event.

**Declaration**

```xojo
Function IsEventDate(d As DateTime) As Boolean
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| d | DateTime | The date to test. |

**Returns**

`True` if *d* is the date of the event in its year. `False` if it is not, if the event does not occur that year, or if *d* is `Nil`.

**Sample code**

```xojo
If e.IsEventDate(DateTime.Now) Then
  MessageBox("Today is " + e.Caption)
End If
```

---

### ToString

Returns a text representation of the event.

**Declaration**

```xojo
Function ToString() As String
```

**Returns**

A `String` that describes the event. The text contains everything needed to rebuild the event, and its format is internal. The caption is encoded so that it can contain any character.

**Notes**

Use the shared `FromString` method of a class to rebuild the event. `Tag` and `DbId` are not included.

---

## See also

[AnnualEventEaster and AnnualEventOrthodoxEaster](EasterEvents.md) classes; [DateAndCaption](DateAndCaption.md), [WorkCalendar](WorkCalendar.md) (which groups annual events, closure periods and working days), `DateTime`, `DatabaseRow` classes.
