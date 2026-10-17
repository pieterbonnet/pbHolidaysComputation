# AnnualEventFixed

## Description

Calculates the date of an event that falls on a fixed date every year, such as December 25 or July 4. The date can then be moved by a number of days, moved to a given weekday, or adjusted when it falls on a weekend.

## Notes

`AnnualEventFixed` implements the [AnnualEvent](AnnualEvent.md) interface. The properties and methods of the interface are described on the [AnnualEvent](AnnualEvent.md) page. This page describes what is specific to this class.

The date is defined by [Month](#month) and [Day](#day). [DateValue](AnnualEvent.md#datevalue) then applies the following steps, in this order:

1. [DayOffset](#dayoffset) days are added to the date (a negative value gives an earlier date).
2. If [DesiredWeekday](#desiredweekday) is set, the date is moved to this weekday, after or before the date, depending on [DesiredWeekdayDirection](#desiredweekdaydirection).
3. If `DesiredWeekday` is not set, the weekend adjustment is applied: [MondayIfSunday](#mondayifsunday) moves a Sunday to the next day, and [FridayIfSaturday](#fridayifsaturday) moves a Saturday to the previous day.

The weekend adjustment is therefore ignored when `DesiredWeekday` is set.

February 29 does not exist in every year. When you choose `Month = 2` and `Day = 29`, the property [NotLeapYearOffset](#notleapyearoffset) defines what happens in the years that are not leap years: the event is moved to February 28 (`-1`), to March 1 (`1`), or it does not occur (`0`). This is done first: the steps above are then applied to the date that is found.

The constructors do not check the values. Use a valid combination of month and day.

## Sample code

Christmas Day: December 25.

```xojo
Var e As New AnnualEventFixed("Christmas Day", 12, 25)
MessageBox(e.DateValue(2026).SQLDate) // 2026-12-25
```

Independence Day (US): July 4, observed on the Friday before when it falls on a Saturday, and on the Monday after when it falls on a Sunday.

```xojo
Var e As New AnnualEventFixed("Independence Day", 7, 4, True, True) // FridayIfSaturday, MondayIfSunday

MessageBox(e.DateValue(2026).SQLDate) // 2026-07-03 (July 4 is a Saturday)
MessageBox(e.DateValue(2027).SQLDate) // 2027-07-05 (July 4 is a Sunday)
```

Boxing Day: the day after Christmas Day.

```xojo
Var e As New AnnualEventFixed("Boxing Day", 12, 25)
e.DayOffset = 1
MessageBox(e.DateValue(2026).SQLDate) // 2026-12-26
```

Victoria Day (Canada): the Monday before May 25. When May 25 is itself a Monday, the event is moved to the previous Monday.

```xojo
Var e As New AnnualEventFixed("Victoria Day", 5, 25)
e.DesiredWeekday = 2                                                    // Monday
e.DesiredWeekdayDirection = AnnualEventFixed.WeekdayDirectionType.Before
e.AlwaysMoveDesiredWeekday = True

MessageBox(e.DateValue(2025).SQLDate) // 2025-05-19 (May 25 is a Sunday)
MessageBox(e.DateValue(2026).SQLDate) // 2026-05-18 (May 25 is a Monday)
```

February 29. In the years that are not leap years, the event is moved to February 28 by default. Use `NotLeapYearOffset` to choose March 1, or to have no event:

```xojo
Var e As New AnnualEventFixed("Leap Day", 2, 29)
MessageBox(e.DateValue(2028).SQLDate) // 2028-02-29
MessageBox(e.DateValue(2027).SQLDate) // 2027-02-28

e.NotLeapYearOffset = 1
MessageBox(e.DateValue(2027).SQLDate) // 2027-03-01

e.NotLeapYearOffset = 0
If e.DateValue(2027) Is Nil Then
  MessageBox("No Leap Day in 2027")
End If
```

Save an event and rebuild it:

```xojo
Var s As String = e.ToString
Var restored As AnnualEvent = AnnualEventFixed.FromString(s)
```

## Interfaces

[AnnualEvent](AnnualEvent.md)

## Compatibility

Uses `DateTime` and `DatabaseRow` (API 2).

## Properties

| Property | Type | Read | Write | Description |
| -------- | ---- | :--: | :---: | ----------- |
| [AlwaysMoveDesiredWeekday](#alwaysmovedesiredweekday) | Boolean | ✓ | ✓ | Moves the event by a full week if it is already on the desired weekday. Default: `False`. |
| [Caption](AnnualEvent.md#caption) | String | ✓ | ✓ | The name of the event. Default: empty. |
| [CycleFirstYear](AnnualEvent.md#cyclefirstyear) | Integer | ✓ | ✓ | The first year of the cycle. Default: `1900`. |
| [CycleYearDuration](AnnualEvent.md#cycleyearduration) | Integer | ✓ | ✓ | The length of the cycle, in years. Default: `1`. |
| [Day](#day) | Integer | ✓ | ✓ | The day of the month. Default: `1`. |
| [DayOff](AnnualEvent.md#dayoff) | Boolean | ✓ | ✓ | Whether the event is a non-working day. Default: `True`. |
| [DayOffset](#dayoffset) | Integer | ✓ | ✓ | The number of days added to the date. Default: `0`. |
| [DbId](AnnualEvent.md#dbid) | Variant | ✓ | ✓ | The identifier of the event in a database. |
| [DefinitionObject](AnnualEvent.md#definitionobject) | Variant | ✓ | | The event itself. |
| [DesiredWeekday](#desiredweekday) | Integer | ✓ | ✓ | The weekday to which the event is moved (1 to 7), or `0` for none. Default: `0`. |
| [DesiredWeekdayDirection](#desiredweekdaydirection) | WeekdayDirectionType | ✓ | ✓ | The direction in which the event is moved to the desired weekday. Default: `After`. |
| [EndOfValidity](AnnualEvent.md#endofvalidity) | DateTime | ✓ | ✓ | The last date on which the event is valid. Default: December 31, year 3999. |
| [FingerPrint](AnnualEvent.md#fingerprint) | String | ✓ | | A string that identifies the definition of the event. |
| [FridayIfSaturday](#fridayifsaturday) | Boolean | ✓ | ✓ | Moves the event to the Friday before when it falls on a Saturday. Default: `False`. |
| [MondayIfSunday](#mondayifsunday) | Boolean | ✓ | ✓ | Moves the event to the Monday after when it falls on a Sunday. Default: `False`. |
| [Month](#month) | Integer | ✓ | ✓ | The month of the year (1 to 12). Default: `1`. |
| [NotLeapYearOffset](#notleapyearoffset) | Integer | ✓ | ✓ | What happens to an event on February 29 in the years that are not leap years: `-1`, `0` or `1`. Only used when `Month` is `2` and `Day` is `29`. Default: `-1`. |
| [StartOfValidity](AnnualEvent.md#startofvalidity) | DateTime | ✓ | ✓ | The first date on which the event is valid. Default: January 1, year 1. |
| [Tag](AnnualEvent.md#tag) | Variant | ✓ | ✓ | A value reserved for your own use. |

## Methods

| Method | Parameters | Returns |
| ------ | ---------- | ------- |
| [Calculate](AnnualEvent.md#calculate) | *Year* As Integer | [DateAndCaption](DateAndCaption.md) |
| [Constructor](#constructor) | *lCaption* As String = "", *lMonth* As Integer = 1, *lDay* As Integer = 1, *lFridayIfSaturday* As Boolean = False, *lMondayIfSunday* As Boolean = False | |
| [Constructor](#constructor) | *a* As AnnualEvent | |
| [Constructor](#constructor) | *copy* As AnnualEventFixed | |
| [DateValue](AnnualEvent.md#datevalue) | *year* As Integer | DateTime |
| [DbRow](AnnualEvent.md#dbrow) | *RegionIdentifier* As Variant = Nil, *encoding* As TextEncoding = Nil | DatabaseRow |
| [IsEventDate](AnnualEvent.md#iseventdate) | *d* As DateTime | Boolean |
| [ToString](AnnualEvent.md#tostring) | | String |

## Shared methods

| Method | Parameters | Returns |
| ------ | ---------- | ------- |
| [FromString](#fromstring) | *value* As String | AnnualEvent |

## Enumerations

### WeekdayDirectionType

The direction in which an event is moved to the desired weekday (see [DesiredWeekdayDirection](#desiredweekdaydirection)).

| Name | Value | Description |
| ---- | ----: | ----------- |
| Before | 0 | Moves the event backward, to the closest desired weekday before the date. |
| After | 1 | Moves the event forward, to the closest desired weekday after the date. |

---

## Implementation of the AnnualEvent members

The members of the [AnnualEvent](AnnualEvent.md) interface behave as described on the interface page. This section lists what is specific to `AnnualEventFixed`.

### Default values

A new event created with the first constructor has the date January 1, no offset, no desired weekday, no weekend adjustment, no cycle (`CycleYearDuration = 1`, `CycleFirstYear = 1900`), `NotLeapYearOffset` is `-1` (an event on February 29 is moved to February 28 in the years that are not leap years), and `DayOff` is `True`. It is valid from January 1, year 1 to December 31, year 3999. The copy constructors duplicate all the properties of the source event.

### DateValue

[DateValue](AnnualEvent.md#datevalue) returns the date at 00:00:00, or `Nil` when:

- the cycle does not include the year (only checked when `CycleYearDuration` is greater than `1`);
- *year* is before the year of `StartOfValidity` or after the year of `EndOfValidity`;
- the event is on February 29, the year is not a leap year and `NotLeapYearOffset` is `0`;
- the final date, after the offset, the weekday and the weekend adjustment, is before `StartOfValidity` or after `EndOfValidity`.

### IsEventDate

[IsEventDate](AnnualEvent.md#iseventdate) ignores the time of *d*. Because the offset, the desired weekday and the weekend adjustment can move the event into the previous or the next year (for example, a January 1 moved to the Friday before), the method calculates the event for the years `d.Year - 1`, `d.Year` and `d.Year + 1` and returns `True` if one of them falls on *d*.

### DefinitionObject

Returns the event itself.

### FingerPrint

Identifies the definition of the event (see [FingerPrint](AnnualEvent.md#fingerprint)). `Caption`, `Tag` and `DbId` are not included. `NotLeapYearOffset` is included, but only for an event on February 29: for any other date, the fingerprint uses the value `-1`. Two events on another date that differ only by this property therefore have the same fingerprint.

### DbRow

The row has two columns, `region` and `value`, as described in [DbRow](AnnualEvent.md#dbrow). The `value` column contains the result of `ToString`, so it can be read back with [FromString](#fromstring).

### ToString

The text can be used with [FromString](#fromstring) to rebuild the event. It includes `NotLeapYearOffset`, which [FromString](#fromstring) reads: for any date other than February 29, the text contains the value `-1`. Its format is internal and may change.

---

## Property descriptions

### AlwaysMoveDesiredWeekday

Indicates whether the event is moved by a full week when the date is already on the desired weekday.

**Declaration**

```xojo
Property AlwaysMoveDesiredWeekday As Boolean
```

**Notes**

The default value is `False`: when the date is already on [DesiredWeekday](#desiredweekday), it is kept. When the value is `True`, the event is moved to the next (or previous, depending on [DesiredWeekdayDirection](#desiredweekdaydirection)) occurrence of this weekday, one week later (or earlier). The property has no effect if `DesiredWeekday` is `0`.

---

### Day

The day of the month.

**Declaration**

```xojo
Property Day As Integer
```

**Notes**

The default value is `1` when the event is created with the default constructor. The value must be valid for the month. For February 29, see [NotLeapYearOffset](#notleapyearoffset).

---

### DayOffset

The number of days added to the date defined by `Month` and `Day`.

**Declaration**

```xojo
Property DayOffset As Integer
```

**Notes**

A negative value gives an earlier date and a positive value a later date. The default value is `0` (no offset). The offset is applied first, before the desired weekday and the weekend adjustment.

---

### DesiredWeekday

The weekday to which the event is moved.

**Declaration**

```xojo
Property DesiredWeekday As Integer
```

**Notes**

A value from `1` to `7`, as in `DateTime.DayOfWeek` (1 = Sunday, 2 = Monday, ..., 7 = Saturday), or `0` if the event is not moved to a weekday. A value that is less than `0` or greater than `7` is replaced by `0`.

The event is moved to the first day with this weekday after the date, or before the date, depending on [DesiredWeekdayDirection](#desiredweekdaydirection). If the date is already on this weekday, it is kept, unless [AlwaysMoveDesiredWeekday](#alwaysmovedesiredweekday) is `True`.

When `DesiredWeekday` is set, the weekend adjustment ([MondayIfSunday](#mondayifsunday) and [FridayIfSaturday](#fridayifsaturday)) is ignored.

---

### DesiredWeekdayDirection

The direction in which the event is moved to the desired weekday.

**Declaration**

```xojo
Property DesiredWeekdayDirection As WeekdayDirectionType
```

**Notes**

The default value is `WeekdayDirectionType.After`. See [WeekdayDirectionType](#weekdaydirectiontype). The property has no effect if [DesiredWeekday](#desiredweekday) is `0`.

---

### FridayIfSaturday

Indicates whether an event that falls on a Saturday is moved to the Friday before.

**Declaration**

```xojo
Property FridayIfSaturday As Boolean
```

**Notes**

The default value is `False`. The adjustment is applied only when [DesiredWeekday](#desiredweekday) is `0`. It is used for holidays that are observed on the Friday when they fall on a Saturday.

---

### Month

The month of the year.

**Declaration**

```xojo
Property Month As Integer
```

**Notes**

A value from `1` (January) to `12` (December). The default value is `1` when the event is created with the default constructor.

---

### MondayIfSunday

Indicates whether an event that falls on a Sunday is moved to the Monday after.

**Declaration**

```xojo
Property MondayIfSunday As Boolean
```

**Notes**

The default value is `False`. The adjustment is applied only when [DesiredWeekday](#desiredweekday) is `0`. It is used for holidays that are observed on the Monday when they fall on a Sunday.

---

### NotLeapYearOffset

Defines what happens to an event on February 29 in the years that are not leap years.

**Declaration**

```xojo
Property NotLeapYearOffset As Integer
```

**Notes**

> [!NOTE]
> This property concerns only an event on February 29, that is, when `Month` is `2` and `Day` is `29`. For any other date it has no effect, whatever its value.

The accepted values are:

| Value | Result in a year that is not a leap year |
| ----: | ---------------------------------------- |
| -1 | The event is on February 28. This is the default value. |
| 0 | The event does not occur: [DateValue](AnnualEvent.md#datevalue) returns `Nil` for these years. |
| 1 | The event is on March 1. |

A value that is not `-1`, `0` or `1` is corrected automatically to the nearest of these values.

The date is found first: [DayOffset](#dayoffset), [DesiredWeekday](#desiredweekday) and the weekend adjustment are applied to February 28 or March 1.

**Sample code**

```xojo
Var e As New AnnualEventFixed("Leap Day", 2, 29)
e.NotLeapYearOffset = 1 // March 1 in the years that are not leap years
```

---

## Method descriptions

### Constructor

Creates a new event.

**Declaration**

```xojo
Sub Constructor(lCaption As String = "", lMonth As Integer = 1, lDay As Integer = 1, lFridayIfSaturday As Boolean = False, lMondayIfSunday As Boolean = False)
Sub Constructor(a As AnnualEvent)
Sub Constructor(copy As AnnualEventFixed)
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| lCaption | String | The name of the event. Default: empty. |
| lMonth | Integer | The month (1 to 12). Default: `1`. |
| lDay | Integer | The day of the month. Default: `1`. |
| lFridayIfSaturday | Boolean | Moves the event to the Friday before when it falls on a Saturday. Default: `False`. |
| lMondayIfSunday | Boolean | Moves the event to the Monday after when it falls on a Sunday. Default: `False`. |
| a | AnnualEvent | An event to copy. It must be an `AnnualEventFixed`. |
| copy | AnnualEventFixed | An event to copy. |

**Notes**

*Constructor 1:* creates an event with the specified caption, month, day and weekend adjustments. The month comes before the day in the parameters. The values are not checked. With no parameter, it creates an event on January 1 with an empty caption. The offset and the desired weekday are not set by the constructor: set them with the properties.

*Constructor 2:* creates a copy of another `AnnualEvent`. It raises a `NilObjectException` if *a* is `Nil` and an `InvalidArgumentException` if *a* is not an `AnnualEventFixed`. All the properties are duplicated.

*Constructor 3:* creates a copy of an `AnnualEventFixed`. It raises a `NilObjectException` if *copy* is `Nil`. All the properties are duplicated.

**Sample code**

```xojo
Var a As New AnnualEventFixed("Labour Day", 5, 1)
Var b As New AnnualEventFixed(a)
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
Var restored As AnnualEvent = AnnualEventFixed.FromString(s)
```

---

## See also

[AnnualEvent](AnnualEvent.md) interface; [AnnualEventWeekDay](AnnualEventWeekDay.md) class; [AnnualEventEaster and AnnualEventOrthodoxEaster](EasterEvents.md) classes; [DateAndCaption](DateAndCaption.md), `DateTime`, `DatabaseRow` classes.
