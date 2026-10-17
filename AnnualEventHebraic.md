# AnnualEventHebraic

## Description

Calculates the date of a Jewish holiday or of any event defined by a date of the Hebrew calendar. The class also converts dates between the Hebrew and the Gregorian calendars and calculates sunrise and sunset times.

## Notes

`AnnualEventHebraic` implements the [AnnualEvent](AnnualEvent.md) interface. The properties and methods of the interface are described on the [AnnualEvent](AnnualEvent.md) page. This page describes what is specific to this class.

An event is defined in one of two ways:

- with a predefined holiday ([HolidayType](#holidaytype)), such as `RoshHashanah` or `Purim`;
- with a custom Hebrew date, a month ([hMonth](#hmonth)) and a day ([hDay](#hday)), for example for a family anniversary.

The Hebrew calendar is a lunisolar calendar: a Hebrew year does not start on the same Gregorian date every year, and a Hebrew year overlaps two civil years. [DateValue](AnnualEvent.md#datevalue) calculates the Hebrew dates of the two Hebrew years that overlap the civil year, and returns the one that falls in this civil year. The months are numbered from Nisan, as follows:

| Number | Month | Number | Month |
| -----: | ----- | -----: | ----- |
| 1 | Nisan | 8 | Heshvan |
| 2 | Iyar | 9 | Kislev |
| 3 | Sivan | 10 | Tevet |
| 4 | Tammuz | 11 | Shevat |
| 5 | Av | 12 | Adar (Adar I in a leap year) |
| 6 | Elul | 13 | Adar II (leap years only) |
| 7 | Tishri | | |

In a leap year, Purim and the Fast of Esther are celebrated in Adar II (month 13). The class takes this into account.

A few holidays, such as Hanukkah, can fall twice in the same civil year, or not at all (very rarely). In the first case, `DateValue` returns the first date. In the second case, it returns `Nil`.

> [!NOTE]
> The date returned is the civil day on which the holiday is observed. Jewish holidays start at sunset on the evening before. You can calculate this time with [SunsetTime](#sunsettime).

### Postponement rules

Some holidays have two variants: the raw date of the Hebrew calendar, and a variant that applies the official or traditional postponement rules. The variants are `HolidayType` values whose name ends with `_ApplyCivilShift` or `_ApplyShabbatShift`:

| Holiday | Rule |
| ------- | ---- |
| YomHaatzmaut_ApplyCivilShift | 5 Iyar, moved to the previous Thursday if it falls on a Saturday or a Friday, and to the next Tuesday if it falls on a Monday (rule of the State of Israel). |
| YomHaZikaron_ApplyCivilShift | The day before Yom HaAtzmaut (with the rule above). |
| TzomGedaliah_ApplyShabbatShift | 3 Tishri, moved to Sunday if it falls on Shabbat. |
| AsaraBeTevet_ApplyShabbatShift | 10 Tevet, moved to Sunday if it falls on Shabbat. |
| ShivaAsarBeTammuz_ApplyShabbatShift | 17 Tammuz, moved to Sunday if it falls on Shabbat. |
| TaanitEsther_ApplyShabbatShift | 13 Adar (or Adar II), moved to the previous Thursday if it falls on Shabbat. |

The captions of the holidays are available in six languages (see [DisplayLanguage](#displaylanguage)).

## Sample code

Rosh Hashanah (the Jewish New Year) in 2026, with the caption in English:

```xojo
Var e As New AnnualEventHebraic(AnnualEventHebraic.HolidayType.RoshHashanah, AnnualEventHebraic.DisplayLanguage.English)
MessageBox(e.Caption)                   // Rosh Hashanah
MessageBox(e.DateValue(2026).SQLDate)   // 2026-09-12
```

A holiday with your own caption:

```xojo
Var e As New AnnualEventHebraic("Pessa'h", AnnualEventHebraic.HolidayType.PassoverFirstDay)
MessageBox(e.DateValue(2026).SQLDate) // 2026-04-02
```

Purim: in 2027, which is a leap year, it is celebrated in Adar II.

```xojo
Var e As New AnnualEventHebraic("Purim", AnnualEventHebraic.HolidayType.Purim)
MessageBox(e.DateValue(2026).SQLDate) // 2026-03-03
MessageBox(e.DateValue(2027).SQLDate) // 2027-03-23
```

The raw date and the postponed date of the Fast of Gedaliah. In 2024, 3 Tishri falls on a Saturday:

```xojo
Var raw As New AnnualEventHebraic("Fast of Gedaliah", AnnualEventHebraic.HolidayType.TzomGedaliah)
Var shifted As New AnnualEventHebraic("Fast of Gedaliah", AnnualEventHebraic.HolidayType.TzomGedaliah_ApplyShabbatShift)

MessageBox(raw.DateValue(2024).SQLDate)     // 2024-10-05 (Saturday)
MessageBox(shifted.DateValue(2024).SQLDate) // 2024-10-06 (Sunday)
```

Yom HaAtzmaut with the rule of the State of Israel. In 2024, 5 Iyar falls on a Monday:

```xojo
Var e As New AnnualEventHebraic("Yom HaAtzmaut", AnnualEventHebraic.HolidayType.YomHaatzmaut_ApplyCivilShift)
MessageBox(e.DateValue(2024).SQLDate) // 2024-05-14 (Tuesday)
```

An event on a custom Hebrew date: the 4th of Tevet (month 10).

```xojo
Var e As New AnnualEventHebraic("Family anniversary", 10, 4)
MessageBox(e.DateValue(2026).SQLDate) // 2026-12-14
```

All the holidays, with the Israeli postponement rules and the captions in French:

```xojo
Var holidays() As AnnualEventHebraic = _
AnnualEventHebraic.AllHolidays(True, AnnualEventHebraic.DisplayLanguage.French)

For Each h As AnnualEventHebraic In holidays
  Var r As DateAndCaption = h.Calculate(2026)
  If r <> Nil Then
    System.DebugLog(h.Caption + ": " + r.DateValue.SQLDate)
  End If
Next
```

Convert a date between the two calendars:

```xojo
Var hYear, hMonth, hDay As Integer
AnnualEventHebraic.GregorianToHebraic(New DateTime(2026, 9, 12), hYear, hMonth, hDay)
// hYear = 5787, hMonth = 7 (Tishri), hDay = 1

Var d As DateTime = AnnualEventHebraic.HebraicToGregorian(5787, 7, 1)
MessageBox(d.SQLDate) // 2026-09-12
```

Calculate the time at which Rosh Hashanah 2026 begins (sunset on the evening before), in Jerusalem (latitude 31.7683, longitude 35.2137, altitude about 750 m):

```xojo
Var tz As New TimeZone("Asia/Jerusalem")
Var d As New DateTime(2026, 9, 11, 0, 0, 0, tz)

Var sunset As DateTime = AnnualEventHebraic.SunsetTime(d, 31.7683, 35.2137, 750)
MessageBox(sunset.Hour.ToString + ":" + sunset.Minute.ToString) // about 18:57
```

Save an event and rebuild it:

```xojo
Var s As String = e.ToString
Var restored As AnnualEvent = AnnualEventHebraic.FromString(s)
```

## Interfaces

[AnnualEvent](AnnualEvent.md)

## Compatibility

Uses `DateTime`, `TimeZone` and `DatabaseRow` (API 2).

## Properties

| Property | Type | Read | Write | Description |
| -------- | ---- | :--: | :---: | ----------- |
| [Caption](AnnualEvent.md#caption) | String | ✓ | ✓ | The name of the event. |
| [CycleFirstYear](AnnualEvent.md#cyclefirstyear) | Integer | ✓ | ✓ | The first year of the cycle. Default: `1900`. |
| [CycleYearDuration](AnnualEvent.md#cycleyearduration) | Integer | ✓ | ✓ | The length of the cycle, in years. Default: `1`. |
| [DayOff](AnnualEvent.md#dayoff) | Boolean | ✓ | ✓ | Whether the event is a non-working day. Default: `True`. |
| [DbId](AnnualEvent.md#dbid) | Variant | ✓ | ✓ | The identifier of the event in a database. |
| [DefinitionObject](AnnualEvent.md#definitionobject) | Variant | ✓ | | The event itself. |
| [EndOfValidity](AnnualEvent.md#endofvalidity) | DateTime | ✓ | ✓ | The last date on which the event is valid. Default: December 31, year 3999. |
| [FingerPrint](AnnualEvent.md#fingerprint) | String | ✓ | | A string that identifies the definition of the event. |
| [hDay](#hday) | Integer | ✓ | ✓ | The day of the Hebrew month. |
| [hMonth](#hmonth) | Integer | ✓ | ✓ | The Hebrew month (1 to 13). |
| [Holiday](#holiday) | HolidayType | ✓ | ✓ | The holiday. |
| [StartOfValidity](AnnualEvent.md#startofvalidity) | DateTime | ✓ | ✓ | The first date on which the event is valid. Default: January 1, year 1. |
| [Tag](AnnualEvent.md#tag) | Variant | ✓ | ✓ | A value reserved for your own use. |

## Methods

| Method | Parameters | Returns |
| ------ | ---------- | ------- |
| [Calculate](AnnualEvent.md#calculate) | *year* As Integer | [DateAndCaption](DateAndCaption.md) |
| [Constructor](#constructor) | *lHoliday* As HolidayType, *language* As DisplayLanguage | |
| [Constructor](#constructor) | *lCaption* As String, *lHoliday* As HolidayType | |
| [Constructor](#constructor) | *lCaption* As String, *Month* As Integer, *Day* As Integer | |
| [Constructor](#constructor) | *lCaption* As String, *lCode* As String | |
| [Constructor](#constructor) | *copy* As AnnualEventHebraic | |
| [Constructor](#constructor) | *d* As AnnualEvent | |
| [DateValue](AnnualEvent.md#datevalue) | *year* As Integer | DateTime |
| [DbRow](AnnualEvent.md#dbrow) | *RegionIdentifier* As Variant = Nil, *encoding* As TextEncoding = Nil | DatabaseRow |
| [IsEventDate](AnnualEvent.md#iseventdate) | *d* As DateTime | Boolean |
| [ToString](AnnualEvent.md#tostring) | | String |

## Shared methods

| Method | Parameters | Returns |
| ------ | ---------- | ------- |
| [AllHolidays](#allholidays) | *useIsraeliPostponement* As Boolean = False, *language* As DisplayLanguage = English | AnnualEventHebraic() |
| [DutchName](#name-methods) | *holiday* As HolidayType | String |
| [EnglishName](#name-methods) | *holiday* As HolidayType | String |
| [FrenchName](#name-methods) | *holiday* As HolidayType | String |
| [FromString](#fromstring) | *value* As String | AnnualEvent |
| [GermanName](#name-methods) | *holiday* As HolidayType | String |
| [GregorianToHebraic](#gregoriantohebraic) | *dtGregorian* As DateTime, ByRef *hYear* As Integer, ByRef *hMonth* As Integer, ByRef *hDay* As Integer | |
| [HebraicToGregorian](#hebraictogregorian) | *hYear* As Integer, *hMonth* As Integer, *hDay* As Integer | DateTime |
| [HolidayCode](#holidaycode) | *holiday* As HolidayType | String |
| [HolidayFromCode](#holidayfromcode) | *code* As String | HolidayType |
| [ModernHebrewName](#name-methods) | *holiday* As HolidayType | String |
| [SpanishName](#name-methods) | *holiday* As HolidayType | String |
| [SunriseTime](#sunrisetime) | *dt* As DateTime, *latitude* As Double, *longitude* As Double, *altitude* As Double = 0 | DateTime |
| [SunsetTime](#sunsettime) | *dt* As DateTime, *latitude* As Double, *longitude* As Double, *altitude* As Double = 0 | DateTime |

## Enumerations

### DisplayLanguage

The languages in which the caption of a holiday is returned.

| Name | Value | Description |
| ---- | ----: | ----------- |
| English | 0 | English. |
| French | 1 | French. |
| ModernHebrew | 2 | Modern Hebrew. |
| Dutch | 3 | Dutch, as used in Belgium (Flemish). |
| German | 4 | German. |
| Spanish | 5 | Spanish. |

### HolidayType

The holidays that can be calculated. Each holiday has a short code, used by [HolidayCode](#holidaycode) and [HolidayFromCode](#holidayfromcode), and a Hebrew date.

| Name | Code | Hebrew date | Description |
| ---- | ---- | ----------- | ----------- |
| RoshHashanah | RH | 1 Tishri | Jewish New Year. |
| YomKippur | YK | 10 Tishri | Day of Atonement. |
| SukkotFirstDay | SUK | 15 Tishri | First day of Sukkot. |
| HoshanaRabbah | HR | 21 Tishri | Hoshana Rabbah. |
| SheminiAtzeret | SA | 22 Tishri | Shemini Atzeret. |
| SimchatTorah_Diaspora | STD | 23 Tishri | Simchat Torah, as celebrated outside Israel. |
| SimchatTorah_Israel | STI | 22 Tishri | Simchat Torah in Israel (same day as Shemini Atzeret). |
| HanukkahFirstDay | HAN | 25 Kislev | First day of Hanukkah. |
| TuBishvat | TB | 15 Shevat | Tu BiShvat. |
| Purim | PUR | 14 Adar (14 Adar II in a leap year) | Purim. |
| PassoverFirstDay | PE1 | 15 Nisan | First day of Passover. |
| PassoverSeventhDay | PE7 | 21 Nisan | Seventh day of Passover. |
| PassoverEighthDay_Diaspora | PE8 | 22 Nisan | Eighth day of Passover. It does not exist in Israel. |
| YomHaShoah | YHS | 27 Nisan | Holocaust Remembrance Day. |
| YomHaZikaron | YHZ | 4 Iyar | Remembrance Day (raw date). |
| YomHaZikaron_ApplyCivilShift | YHZC | 4 Iyar | Remembrance Day, with the postponement rule of Israel. |
| YomHaatzmaut | YHA | 5 Iyar | Independence Day (raw date). |
| YomHaatzmaut_ApplyCivilShift | YHAC | 5 Iyar | Independence Day, with the postponement rule of Israel. |
| LagBaOmer | LBO | 18 Iyar | Lag BaOmer. |
| Shavuot | SHV | 6 Sivan | Shavuot. |
| TzomGedaliah | TG | 3 Tishri | Fast of Gedaliah (raw date). |
| TzomGedaliah_ApplyShabbatShift | TGS | 3 Tishri | Fast of Gedaliah, postponed to Sunday if on Shabbat. |
| AsaraBeTevet | ABT | 10 Tevet | Tenth of Tevet (raw date). |
| AsaraBeTevet_ApplyShabbatShift | ABTS | 10 Tevet | Tenth of Tevet, postponed to Sunday if on Shabbat. |
| TaanitEsther | TE | 13 Adar (13 Adar II in a leap year) | Fast of Esther (raw date). |
| TaanitEsther_ApplyShabbatShift | TES | 13 Adar (13 Adar II in a leap year) | Fast of Esther, advanced to Thursday if on Shabbat. |
| ShivaAsarBeTammuz | SBT | 17 Tammuz | Seventeenth of Tammuz (raw date). |
| ShivaAsarBeTammuz_ApplyShabbatShift | SBTS | 17 Tammuz | Seventeenth of Tammuz, postponed to Sunday if on Shabbat. |
| Unknown | | | Returned by `HolidayFromCode` when the code is not recognized. |
| Custom | CUST | | An event defined by [hMonth](#hmonth) and [hDay](#hday). |

---

## Implementation of the AnnualEvent members

The members of the [AnnualEvent](AnnualEvent.md) interface behave as described on the interface page. This section lists what is specific to `AnnualEventHebraic`.

### Default values

A new event is valid from January 1, year 1 to December 31, year 3999, has no cycle (`CycleYearDuration = 1`, `CycleFirstYear = 1900`) and `DayOff` is `True`. The copy constructors duplicate all the properties of the source event.

### DateValue

[DateValue](AnnualEvent.md#datevalue) returns the date at 00:00:00, or `Nil` when:

- *year* is less than 1 (in a debug build, the method also stops at a `Break`);
- the cycle does not include the year (only checked when `CycleYearDuration` is greater than `1`);
- *year* is before the year of `StartOfValidity` or after the year of `EndOfValidity`;
- the holiday does not fall in this civil year (very rare, see the notes above);
- the holiday is `Unknown`;
- the date is before `StartOfValidity` or after `EndOfValidity`.

### IsEventDate

[IsEventDate](AnnualEvent.md#iseventdate) ignores the time of *d*. For the holidays with a postponement rule (`_ApplyCivilShift` and `_ApplyShabbatShift`), the date is compared with the result of `DateValue`. For the other events, the Hebrew date of *d* is compared with the Hebrew date of the event.

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

### hDay

The day of the Hebrew month.

**Declaration**

```xojo
Property hDay As Integer
```

**Notes**

A value from `1` to `30`. For a predefined holiday, the value is set from the holiday. For a custom event (`Holiday` is `Custom`), it is the value you pass to the constructor.

---

### hMonth

The Hebrew month.

**Declaration**

```xojo
Property hMonth As Integer
```

**Notes**

A value from `1` (Nisan) to `13` (Adar II), see the table of months in the notes above. Month `13` exists only in leap years. For a predefined holiday, the value is set from the holiday. For a custom event (`Holiday` is `Custom`), it is the value you pass to the constructor.

---

### Holiday

The holiday of the event.

**Declaration**

```xojo
Property Holiday As HolidayType
```

**Notes**

See [HolidayType](#holidaytype). The value is `Custom` for an event created with a Hebrew month and day.

---

## Method descriptions

### Constructor

Creates a new event.

**Declaration**

```xojo
Sub Constructor(lHoliday As HolidayType, language As DisplayLanguage)
Sub Constructor(lCaption As String, lHoliday As HolidayType)
Sub Constructor(lCaption As String, Month As Integer, Day As Integer)
Sub Constructor(lCaption As String, lCode As String)
Sub Constructor(copy As AnnualEventHebraic)
Sub Constructor(d As AnnualEvent)
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| lHoliday | HolidayType | The holiday. |
| language | DisplayLanguage | The language of the caption. |
| lCaption | String | The name of the event. |
| Month | Integer | The Hebrew month (1 to 13). |
| Day | Integer | The day of the Hebrew month. |
| lCode | String | The code of a holiday (see [HolidayType](#holidaytype)). Case is ignored. |
| copy | AnnualEventHebraic | An event to copy. |
| d | AnnualEvent | An event to copy. It must be an `AnnualEventHebraic`. |

**Notes**

*Constructor 1:* creates an event for a predefined holiday, with the caption in the specified language.

*Constructor 2:* creates an event for a predefined holiday, with your own caption.

*Constructor 3:* creates a custom event on a Hebrew date. `Holiday` is `Custom`. The values are not checked: use a valid month and day.

*Constructor 4:* creates an event for a predefined holiday from its code, with your own caption. If the code is not recognized, `Holiday` is `Unknown` and `DateValue` returns `Nil`.

*Constructor 5:* creates a copy of an `AnnualEventHebraic`. All the properties are duplicated.

*Constructor 6:* creates a copy of another `AnnualEvent`. It raises a `NilObjectException` if *d* is `Nil` and an `InvalidArgumentException` if *d* is not an `AnnualEventHebraic`. All the properties are duplicated.

**Sample code**

```xojo
Var a As New AnnualEventHebraic(AnnualEventHebraic.HolidayType.Shavuot, AnnualEventHebraic.DisplayLanguage.German)
Var b As New AnnualEventHebraic("Shavuot", "SHV")
Var c As New AnnualEventHebraic("Family anniversary", 10, 4)
Var d As New AnnualEventHebraic(a)
```

---

## Shared method descriptions

### AllHolidays

Returns one event for each holiday.

**Declaration**

```xojo
Shared Function AllHolidays(Optional useIsraeliPostponement As Boolean = False, Optional language As DisplayLanguage = DisplayLanguage.English) As AnnualEventHebraic()
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| useIsraeliPostponement | Boolean | Optional. If `True`, Yom HaZikaron, Yom HaAtzmaut and the four minor fasts use their postponement rules. Default: `False`. |
| language | DisplayLanguage | Optional. The language of the captions. Default: `English`. |

**Returns**

An array of `AnnualEventHebraic`.

**Notes**

The events are not tied to a year: call `DateValue` or `Calculate` on each of them to get the date in a given year.

The array contains: Rosh Hashanah, Yom Kippur, Sukkot (first day), Hoshana Rabbah, Shemini Atzeret, Simchat Torah, Hanukkah (first day), Tu BiShvat, Purim, Passover (first, seventh and eighth day), Yom HaShoah, Lag BaOmer, Shavuot, Yom HaZikaron, Yom HaAtzmaut, and the four minor fasts (Fast of Gedaliah, Tenth of Tevet, Fast of Esther and Seventeenth of Tammuz).

The variants for the Diaspora are used for Simchat Torah and for the eighth day of Passover. If you need the variants for Israel, create the events yourself with a constructor.

When *useIsraeliPostponement* is `True`, the six holidays with a postponement rule use their `_ApplyCivilShift` or `_ApplyShabbatShift` variant. It has no effect on the other holidays.

---

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
Var restored As AnnualEvent = AnnualEventHebraic.FromString(s)
```

---

### GregorianToHebraic

Converts a Gregorian date to a date of the Hebrew calendar.

**Declaration**

```xojo
Shared Sub GregorianToHebraic(dtGregorian As DateTime, ByRef hYear As Integer, ByRef hMonth As Integer, ByRef hDay As Integer)
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| dtGregorian | DateTime | The Gregorian date. Only the year, month and day are used. |
| hYear | Integer | Receives the Hebrew year. |
| hMonth | Integer | Receives the Hebrew month (1 to 13). |
| hDay | Integer | Receives the day of the Hebrew month. |

**Notes**

The Hebrew day is the civil day, from midnight to midnight. A Hebrew day actually starts at sunset on the evening before: see [SunsetTime](#sunsettime).

**Sample code**

```xojo
Var hYear, hMonth, hDay As Integer
AnnualEventHebraic.GregorianToHebraic(New DateTime(2026, 9, 12), hYear, hMonth, hDay)
// 5787, 7, 1
```

---

### HebraicToGregorian

Converts a date of the Hebrew calendar to a Gregorian date.

**Declaration**

```xojo
Shared Function HebraicToGregorian(hYear As Integer, hMonth As Integer, hDay As Integer) As DateTime
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| hYear | Integer | The Hebrew year. |
| hMonth | Integer | The Hebrew month (1 to 13). |
| hDay | Integer | The day of the Hebrew month. |

**Returns**

A `DateTime` with the Gregorian date (time 00:00:00).

**Notes**

This is the inverse of [GregorianToHebraic](#gregoriantohebraic). The values are not checked.

**Sample code**

```xojo
Var d As DateTime = AnnualEventHebraic.HebraicToGregorian(5787, 7, 1)
MessageBox(d.SQLDate) // 2026-09-12
```

---

### HolidayCode

Returns the short code of a holiday.

**Declaration**

```xojo
Shared Function HolidayCode(holiday As HolidayType) As String
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| holiday | HolidayType | The holiday. |

**Returns**

A code of two to four capital letters (see [HolidayType](#holidaytype)), or an empty string for `Unknown`.

**Sample code**

```xojo
MessageBox(AnnualEventHebraic.HolidayCode(AnnualEventHebraic.HolidayType.YomKippur)) // YK
```

---

### HolidayFromCode

Returns the holiday that matches a code.

**Declaration**

```xojo
Shared Function HolidayFromCode(code As String) As HolidayType
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| code | String | The code. Case is ignored. |

**Returns**

The `HolidayType`, or `Unknown` if the code is not recognized. This is the inverse of [HolidayCode](#holidaycode).

**Sample code**

```xojo
Var h As AnnualEventHebraic.HolidayType = AnnualEventHebraic.HolidayFromCode("yk")
// HolidayType.YomKippur
```

---

### Name methods

Return the name of a holiday in a language.

**Declaration**

```xojo
Shared Function DutchName(holiday As HolidayType) As String
Shared Function EnglishName(holiday As HolidayType) As String
Shared Function FrenchName(holiday As HolidayType) As String
Shared Function GermanName(holiday As HolidayType) As String
Shared Function ModernHebrewName(holiday As HolidayType) As String
Shared Function SpanishName(holiday As HolidayType) As String
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| holiday | HolidayType | The holiday. |

**Returns**

The name of the holiday, or an empty string if the holiday has no name (`Unknown` and `Custom`).

**Notes**

A holiday and its variants with a postponement rule have the same name. `DutchName` returns the Dutch used in Belgium. The first day of Passover and the seventh day have the same name in Modern Hebrew, and so do the two variants of Simchat Torah.

**Sample code**

```xojo
MessageBox(AnnualEventHebraic.FrenchName(AnnualEventHebraic.HolidayType.YomKippur)) // Yom Kippour
```

---

### SunriseTime

Returns the time of sunrise at a location, on a date.

**Declaration**

```xojo
Shared Function SunriseTime(dt As DateTime, latitude As Double, longitude As Double, Optional altitude As Double = 0) As DateTime
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| dt | DateTime | The date. Only the year, month and day are used. The result is returned in the time zone of this `DateTime`. |
| latitude | Double | The latitude in degrees, positive to the north. |
| longitude | Double | The longitude in degrees, positive to the east. |
| altitude | Double | Optional. The altitude of the observer in meters above sea level. Default: `0`. |

**Returns**

A `DateTime` with the time of sunrise, or `Nil` if the sun does not rise on this date at this latitude.

**Notes**

See [SunsetTime](#sunsettime).

---

### SunsetTime

Returns the time of sunset at a location, on a date.

**Declaration**

```xojo
Shared Function SunsetTime(dt As DateTime, latitude As Double, longitude As Double, Optional altitude As Double = 0) As DateTime
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| dt | DateTime | The date. Only the year, month and day are used. The result is returned in the time zone of this `DateTime`. |
| latitude | Double | The latitude in degrees, positive to the north. |
| longitude | Double | The longitude in degrees, positive to the east. |
| altitude | Double | Optional. The altitude of the observer in meters above sea level. Default: `0`. |

**Returns**

A `DateTime` with the time of sunset, or `Nil` if the sun does not set on this date at this latitude.

**Notes**

The time is the moment when the top of the sun touches the horizon, with the usual correction for the refraction of the atmosphere. The accuracy is about one minute.

The result is expressed in the time zone of *dt*: pass a `DateTime` that has the time zone of the location, for example `New DateTime(2026, 9, 11, 0, 0, 0, New TimeZone("Asia/Jerusalem"))`.

A higher observer sees a lower horizon, and so sees the sun set later (and rise earlier). Use *altitude* for locations that are high above sea level, such as Jerusalem (about 750 m).

The method returns `Nil` in the polar regions, when the sun does not rise or set (polar day or polar night).

**Sample code**

```xojo
Var tz As New TimeZone("Asia/Jerusalem")
Var d As New DateTime(2026, 9, 11, 0, 0, 0, tz)
Var sunset As DateTime = AnnualEventHebraic.SunsetTime(d, 31.7683, 35.2137, 750)
```

---

## See also

[AnnualEvent](AnnualEvent.md) interface; [AnnualEventFixed](AnnualEventFixed.md) and [AnnualEventWeekDay](AnnualEventWeekDay.md) classes; [AnnualEventEaster and AnnualEventOrthodoxEaster](EasterEvents.md) classes; [DateAndCaption](DateAndCaption.md), `DateTime`, `TimeZone`, `DatabaseRow` classes.
