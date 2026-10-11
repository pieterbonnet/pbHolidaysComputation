# wcWorkingWeekDays

## Description

Defines which days of the week are worked. For example, Monday to Friday for a company, or Monday, Tuesday, Thursday and Friday for a school that is closed on Wednesday.

## Notes

`wcWorkingWeekDays` is used by the [WorkCalendar](WorkCalendar.md) class, through its [WorkingWeek](WorkCalendar.md#workingweek) property. You can also use it alone.

A new object has the usual working week: Monday to Friday are worked, Saturday and Sunday are not.

The days are numbered like `DateTime.DayOfWeek`: 1 is Sunday, 2 is Monday, ..., 7 is Saturday.

The working week can be saved as a text of seven characters with [ToString](#tostring) and read back with [ReadString](#readstring).

## Sample code

A school that is closed on Wednesday:

```xojo
Var w As New wcWorkingWeekDays
w.WorkingWednesday = False

MessageBox(w.ToString) // 0110110
```

Work on Saturday as well, using the number of the day:

```xojo
w.WorkingDay(7) = True // 7 = Saturday
MessageBox(w.ToString) // 0110111
```

Read a working week from a text, here Monday to Friday:

```xojo
Var w As New wcWorkingWeekDays
w.ReadString("0111110")
```

Test a date:

```xojo
Var d As New DateTime(2026, 10, 7) // a Wednesday
If Not w.WorkingDay(d.DayOfWeek) Then
  MessageBox("Closed")
End If
```

## Properties

| Property | Type | Read | Write | Description |
| -------- | ---- | :--: | :---: | ----------- |
| [WorkingFriday](#working-days-properties) | Boolean | ✓ | ✓ | Whether Friday is worked. Default: `True`. |
| [WorkingMonday](#working-days-properties) | Boolean | ✓ | ✓ | Whether Monday is worked. Default: `True`. |
| [WorkingSaturday](#working-days-properties) | Boolean | ✓ | ✓ | Whether Saturday is worked. Default: `False`. |
| [WorkingSunday](#working-days-properties) | Boolean | ✓ | ✓ | Whether Sunday is worked. Default: `False`. |
| [WorkingThursday](#working-days-properties) | Boolean | ✓ | ✓ | Whether Thursday is worked. Default: `True`. |
| [WorkingTuesday](#working-days-properties) | Boolean | ✓ | ✓ | Whether Tuesday is worked. Default: `True`. |
| [WorkingWednesday](#working-days-properties) | Boolean | ✓ | ✓ | Whether Wednesday is worked. Default: `True`. |

## Methods

| Method | Parameters | Returns |
| ------ | ---------- | ------- |
| [ReadString](#readstring) | *value* As String | |
| [ToString](#tostring) | | String |
| [WorkingDay](#workingday) | *DayOfWeek* As Integer | Boolean |
| [WorkingDay](#workingday) | *DayOfWeek* As Integer, Assigns *value* As Boolean | |

---

## Property descriptions

### Working days properties

`WorkingMonday`, `WorkingTuesday`, `WorkingWednesday`, `WorkingThursday`, `WorkingFriday`, `WorkingSaturday` and `WorkingSunday` indicate whether each day of the week is worked.

**Declaration**

```xojo
Property WorkingMonday As Boolean
Property WorkingTuesday As Boolean
Property WorkingWednesday As Boolean
Property WorkingThursday As Boolean
Property WorkingFriday As Boolean
Property WorkingSaturday As Boolean
Property WorkingSunday As Boolean
```

**Notes**

The default value is `True` from Monday to Friday and `False` for Saturday and Sunday. The properties are the same as the [WorkingDay](#workingday) method, which uses the number of the day.

---

## Method descriptions

### ReadString

Sets the working week from a text produced by [ToString](#tostring).

**Declaration**

```xojo
Sub ReadString(value As String)
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| value | String | A text of seven characters, one for each day from Sunday to Saturday: `1` for a worked day and any other character for a day that is not worked. |

**Notes**

The method raises an `InvalidArgumentException` if the text does not have seven characters.

**Sample code**

```xojo
Var w As New wcWorkingWeekDays
w.ReadString("0111110") // Monday to Friday
```

---

### ToString

Returns the working week as a text.

**Declaration**

```xojo
Function ToString() As String
```

**Returns**

A `String` of seven characters, one for each day from Sunday to Saturday: `1` for a worked day and `0` for a day that is not worked. The default week is `"0111110"`.

---

### WorkingDay

Indicates whether a day of the week is worked, or sets it.

**Declaration**

```xojo
Function WorkingDay(DayOfWeek As Integer) As Boolean
Sub WorkingDay(DayOfWeek As Integer, Assigns value As Boolean)
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| DayOfWeek | Integer | The day of the week, from `1` (Sunday) to `7` (Saturday), as in `DateTime.DayOfWeek`. |
| value | Boolean | `True` if the day is worked. |

**Notes**

Both methods raise an `InvalidArgumentException` if *DayOfWeek* is not between 1 and 7. You can use `DateTime.DayOfWeek` directly.

**Sample code**

```xojo
Var w As New wcWorkingWeekDays
w.WorkingDay(4) = False // Wednesday is not worked

If w.WorkingDay(DateTime.Now.DayOfWeek) Then
  MessageBox("Work today")
End If
```

---

## See also

[WorkCalendar](WorkCalendar.md) class; `DateTime` class.
