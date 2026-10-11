# DateAndCaption

## Description

Holds a date and the caption of the event that falls on this date. It is the result of the [Calculate](AnnualEvent.md#calculate) method of the [AnnualEvent](AnnualEvent.md) interface.

## Notes

The class has three properties: the date ([DateValue](#datevalue)), the name of the event ([Caption](#caption)) and, optionally, the region to which the event belongs ([RegionIdentifier](#regionidentifier)).

The `Calculate` method of the classes that implement `AnnualEvent` sets the date and the caption. `RegionIdentifier` is not set by `Calculate`, so it is `Nil`. It is set by [IsAnnualEventDateAndCaption](WorkCalendar.md#isannualeventdateandcaption) of the [WorkCalendar](WorkCalendar.md) class, with the identifier of the calendar. You can also set it yourself, for example when you collect the events of several regions in the same list.

You can also create a `DateAndCaption` yourself, with any date and caption, or make a copy of an existing one.

## Sample code

Use the result of `Calculate`:

```xojo
Var e As New AnnualEventEaster("Easter Monday", AnnualEventEaster.EasterMonday)

Var r As DateAndCaption = e.Calculate(2026)
If r <> Nil Then
  MessageBox(r.Caption + ": " + r.DateValue.SQLDate) // Easter Monday: 2026-04-06
End If
```

Create a `DateAndCaption` and a copy:

```xojo
Var a As New DateAndCaption(DateTime.Now, "Today", "FR")
Var b As New DateAndCaption(a)
```

## Compatibility

Uses `DateTime` (API 2).

## Properties

| Property | Type | Read | Write | Description |
| -------- | ---- | :--: | :---: | ----------- |
| [Caption](#caption) | String | ✓ | ✓ | The name of the event. |
| [DateValue](#datevalue) | DateTime | ✓ | ✓ | The date of the event. |
| [RegionIdentifier](#regionidentifier) | Variant | ✓ | ✓ | The region to which the event belongs. Default: `Nil`. |

## Methods

| Method | Parameters | Returns |
| ------ | ---------- | ------- |
| [Constructor](#constructor) | *lDate* As DateTime = Nil, *lCaption* As String = "", *lRegionIdentifier* As Variant = Nil | |
| [Constructor](#constructor) | *SourceCopy* As DateAndCaption | |

---

## Property descriptions

### Caption

The name of the event.

**Declaration**

```xojo
Property Caption As String
```

**Notes**

For the result of `Calculate`, it is the [Caption](AnnualEvent.md#caption) of the event.

---

### DateValue

The date of the event.

**Declaration**

```xojo
Property DateValue As DateTime
```

**Notes**

For the result of `Calculate`, it is the date of the event for the year you asked for, with the time 00:00:00.

---

### RegionIdentifier

The region (country, state, etc.) to which the event belongs.

**Declaration**

```xojo
Property RegionIdentifier As Variant
```

**Notes**

The default value is `Nil`. The type is `Variant` so that you can use any kind of identifier. It has the same meaning as the *RegionIdentifier* parameter of [DbRow](AnnualEvent.md#dbrow).

---

## Method descriptions

### Constructor

Creates a new `DateAndCaption`.

**Declaration**

```xojo
Sub Constructor(lDate As DateTime = Nil, lCaption As String = "", lRegionIdentifier As Variant = Nil)
Sub Constructor(SourceCopy As DateAndCaption)
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| lDate | DateTime | The date of the event. Default: `Nil`. |
| lCaption | String | The name of the event. Default: empty. |
| lRegionIdentifier | Variant | The region to which the event belongs. Default: `Nil`. |
| SourceCopy | DateAndCaption | The object to copy. |

**Notes**

*Constructor 1:* creates an object with the specified values. With no parameter, the date is `Nil`, the caption is empty and the region is `Nil`.

*Constructor 2:* creates a copy of another `DateAndCaption`. All the properties are duplicated. If *SourceCopy* is `Nil`, a `NilObjectException` is raised.

**Sample code**

```xojo
Var a As New DateAndCaption(New DateTime(2026, 12, 25), "Christmas Day")
Var b As New DateAndCaption(a)
```

---

## See also

[AnnualEvent](AnnualEvent.md) interface; `DateTime` class.
