# AnnualEventEaster and AnnualEventOrthodoxEaster

## Description

Two classes calculate the date of an event that depends on the date of Easter:

- `AnnualEventEaster` uses the date of Western (Gregorian) Easter;
- `AnnualEventOrthodoxEaster` uses the date of Orthodox Easter (Pascha), expressed in the Gregorian calendar.

In both cases, the date of the event is the date of Easter plus or minus a number of days ([DayOffset](#dayoffset)).

## Notes

Both classes implement the [AnnualEvent](AnnualEvent.md) interface. The properties and methods of the interface are described on the [AnnualEvent](AnnualEvent.md) page. They work in the same way in the two classes, which is why they are described together on this page. What is specific to one class is described in the sections [AnnualEventEaster](#annualeventeaster-constants-and-enumerations) and [AnnualEventOrthodoxEaster](#annualeventorthodoxeaster-constants-and-enumerations).

The classes cover all the movable feasts that are defined relative to Easter: Ash Wednesday, Good Friday, Easter Monday, Ascension, Pentecost, and so on. The date of Easter is calculated for the year, then [DayOffset](#dayoffset) days are added. A negative offset gives a date before Easter, a positive offset a date after it.

Each class provides constants for the usual offsets (for example `GoodFriday`, `Ascension` or `Pentecost`), so you do not have to remember the number of days.

Each class also provides the names of the feasts in several languages. You do not have to translate the captions yourself: the name of a feast is set automatically when you create it with a language, or when you get a set of feasts with [AllFeasts](#allfeasts).

You can create a single event with a [constructor](#constructor), or get a complete set of feasts for a given denomination and language.

The differences between the two classes are:

| | AnnualEventEaster | AnnualEventOrthodoxEaster |
| - | ----------------- | ------------------------- |
| Date of Easter | Western Easter | Orthodox Easter |
| Constants | Feasts of the Western churches | Feasts of the Orthodox churches |
| Denomination | Catholic, Anglican, Lutheran, Calvinist | EasternOrthodox, SlavicOrthodox |
| FeastLanguage | American English, French, German, Belgian Flemish, Spanish | The same languages, plus Russian and Greek |

## Sample code

Calculate the date of Easter Monday for 2026:

```xojo
Var e As New AnnualEventEaster("Easter Monday", AnnualEventEaster.EasterMonday)

Var d As DateTime = e.DateValue(2026)
MessageBox(d.SQLDate) // 2026-04-06
```

Calculate the date of Orthodox Easter and of Clean Monday for 2026:

```xojo
Var pascha As New AnnualEventOrthodoxEaster("Orthodox Easter", AnnualEventOrthodoxEaster.Pascha)
MessageBox(pascha.DateValue(2026).SQLDate) // 2026-04-12

Var clean As New AnnualEventOrthodoxEaster("Clean Monday", AnnualEventOrthodoxEaster.CleanMonday)
MessageBox(clean.DateValue(2026).SQLDate) // 2026-02-23
```

A Western feast and an Orthodox feast can fall on the same day. In 2026, Western Easter is on April 5 and Orthodox Easter on April 12, so Orthodox Easter is the same day as the Western Divine Mercy Sunday (Easter plus 7 days):

```xojo
Var western As New AnnualEventEaster("Divine Mercy Sunday", AnnualEventEaster.DivineMercySunday)
Var orthodox As New AnnualEventOrthodoxEaster("Orthodox Easter", AnnualEventOrthodoxEaster.Pascha)

Var d As DateTime = western.DateValue(2026)
If orthodox.IsEventDate(d) Then
  MessageBox(western.Caption + " and " + orthodox.Caption + ": " + d.SQLDate) // 2026-04-12
End If
```

Find all the years between 2020 and 2040 in which they fall on the same day (2020, 2022, 2023, 2026, 2029, 2030, 2033, 2036 and 2039):

```xojo
For y As Integer = 2020 To 2040
  If orthodox.IsEventDate(western.DateValue(y)) Then
    System.DebugLog(y.ToString)
  End If
Next
```

Create an event with a predefined caption in a specific language:

```xojo
Var e As New AnnualEventEaster(AnnualEventEaster.Ascension, AnnualEventEaster.FeastLanguage.French)
MessageBox(e.Caption) // Ascension

Var o As New AnnualEventOrthodoxEaster(AnnualEventOrthodoxEaster.Pascha, AnnualEventOrthodoxEaster.FeastLanguage.Russian)
MessageBox(o.Caption) // Пасха
```

List the feasts of a denomination and calculate their dates:

```xojo
Var feasts() As AnnualEventEaster = _
AnnualEventEaster.AllFeasts(AnnualEventEaster.Denomination.Catholic, AnnualEventEaster.FeastLanguage.French)

For Each f As AnnualEventEaster In feasts
  Var r As DateAndCaption = f.Calculate(2026)
  If r <> Nil Then
    System.DebugLog(f.Caption)
  End If
Next
```

Save an event and rebuild it:

```xojo
Var s As String = e.ToString
Var restored As AnnualEvent = AnnualEventEaster.FromString(s)
```

## Interfaces

[AnnualEvent](AnnualEvent.md)

## Compatibility

Uses `DateTime` and `DatabaseRow` (API 2).

## Properties

The properties are the same in both classes.

| Property | Type | Read | Write | Description |
| -------- | ---- | :--: | :---: | ----------- |
| [Caption](AnnualEvent.md#caption) | String | ✓ | ✓ | The name of the event. Default: empty. |
| [CycleFirstYear](AnnualEvent.md#cyclefirstyear) | Integer | ✓ | ✓ | The first year of the cycle. Default: `1900`. |
| [CycleYearDuration](AnnualEvent.md#cycleyearduration) | Integer | ✓ | ✓ | The length of the cycle, in years. Default: `1`. |
| [DayOff](AnnualEvent.md#dayoff) | Boolean | ✓ | ✓ | Whether the event is a non-working day. Default: `True`. |
| [DayOffset](#dayoffset) | Integer | ✓ | ✓ | The number of days between Easter Sunday and the event. Default: `0`. |
| [DbId](AnnualEvent.md#dbid) | Variant | ✓ | ✓ | The identifier of the event in a database. |
| [DefinitionObject](AnnualEvent.md#definitionobject) | Variant | ✓ | | The event itself. |
| [EndOfValidity](AnnualEvent.md#endofvalidity) | DateTime | ✓ | ✓ | The last date on which the event is valid. Default: December 31, year 3999. |
| [FingerPrint](AnnualEvent.md#fingerprint) | String | ✓ | | A string that identifies the definition of the event. |
| [StartOfValidity](AnnualEvent.md#startofvalidity) | DateTime | ✓ | ✓ | The first date on which the event is valid. Default: January 1, year 1. |
| [Tag](AnnualEvent.md#tag) | Variant | ✓ | ✓ | A value reserved for your own use. |

## Methods

The methods are the same in both classes.

| Method | Parameters | Returns |
| ------ | ---------- | ------- |
| [Calculate](AnnualEvent.md#calculate) | *year* As Integer | [DateAndCaption](DateAndCaption.md) |
| [Constructor](#constructor) | *lCaption* As String = "", *lDayOffset* As Integer = 0 | |
| [Constructor](#constructor) | *lDayOffset* As Integer, *language* As FeastLanguage | |
| [Constructor](#constructor) | *d* As AnnualEvent | |
| [Constructor](#constructor) | *copy* As AnnualEventEaster or AnnualEventOrthodoxEaster | |
| [DateValue](AnnualEvent.md#datevalue) | *year* As Integer | DateTime |
| [DbRow](AnnualEvent.md#dbrow) | *RegionIdentifier* As Variant = Nil, *encoding* As TextEncoding = Nil | DatabaseRow |
| [IsEventDate](AnnualEvent.md#iseventdate) | *d* As DateTime | Boolean |
| [ToString](AnnualEvent.md#tostring) | | String |

## Shared methods

| Method | Class | Parameters | Returns |
| ------ | ----- | ---------- | ------- |
| [AllFeasts](#allfeasts) | Both | *cult* As Denomination, *lang* As FeastLanguage | AnnualEventEaster() or AnnualEventOrthodoxEaster() |
| [EasterDate](#easterdate) | Both | *year* As Integer | DateTime |
| [FromString](#fromstring) | Both | *value* As String | AnnualEvent |

---

## Implementation of the AnnualEvent members

The members of the [AnnualEvent](AnnualEvent.md) interface behave as described on the interface page. This section lists what is specific to the Easter classes. It applies to both classes.

### Default values

A new event (constructors 1 and 2) has an empty caption, `DayOffset` of `0`, no cycle (`CycleYearDuration = 1`, `CycleFirstYear = 1900`), `DayOff` set to `True`, and is valid from January 1, year 1 to December 31, year 3999. The copy constructors duplicate all the properties of the source event.

### DateValue

[DateValue](AnnualEvent.md#datevalue) returns the date at 00:00:00, or `Nil` when:

- *year* is less than 1 (in a debug build, the method also stops at a `Break`);
- the cycle does not include the year (only checked when `CycleYearDuration` is greater than `1`);
- *year* is before the year of `StartOfValidity` or after the year of `EndOfValidity`;
- the calculated date (Easter plus `DayOffset`) is before `StartOfValidity` or after `EndOfValidity`.

### DefinitionObject

Returns the event itself.

### FingerPrint

Identifies the definition of the event (see [FingerPrint](AnnualEvent.md#fingerprint)). `Caption` and `Tag` are ignored: two events that differ only by their caption or their tag have the same fingerprint. The other properties that define the event are taken into account.

### DbRow

The row has two columns, `region` and `value`, as described in [DbRow](AnnualEvent.md#dbrow). The `value` column contains the result of `ToString`, so it can be read back with [FromString](#fromstring).

### ToString

The text can be used with [FromString](#fromstring) to rebuild the event. Its format is internal and may change.

---

## Property descriptions

### DayOffset

The number of days between Easter Sunday and the event.

**Declaration**

```xojo
Property DayOffset As Integer
```

**Notes**

A negative value gives a date before Easter Sunday and a positive value a date after it. The default value is `0` (Easter Sunday). Use the constants of the class, such as `GoodFriday` or `Pentecost`, for the usual feasts.

The date of Easter depends on the class: Western Easter for `AnnualEventEaster`, Orthodox Easter for `AnnualEventOrthodoxEaster`.

**Sample code**

```xojo
Var e As New AnnualEventEaster
e.Caption = "Good Friday"
e.DayOffset = AnnualEventEaster.GoodFriday // -2
```

---

## Method descriptions

### Constructor

Creates a new event.

**Declaration**

```xojo
// AnnualEventEaster
Sub Constructor(lCaption As String = "", lDayOffset As Integer = 0)
Sub Constructor(lDayOffset As Integer, language As FeastLanguage)
Sub Constructor(d As AnnualEvent)
Sub Constructor(copy As AnnualEventEaster)

// AnnualEventOrthodoxEaster
Sub Constructor(lCaption As String = "", lDayOffset As Integer = 0)
Sub Constructor(lDayOffset As Integer, language As FeastLanguage)
Sub Constructor(d As AnnualEvent)
Sub Constructor(copy As AnnualEventOrthodoxEaster)
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| lCaption | String | The name of the event. Default: empty. |
| lDayOffset | Integer | The number of days after (or before, if negative) Easter Sunday. Default: `0`. |
| language | FeastLanguage | The language of the caption of a predefined feast. |
| d | AnnualEvent | An event to copy. It must be an event of the same class. |
| copy | AnnualEventEaster or AnnualEventOrthodoxEaster | An event to copy. |

**Notes**

*Constructor 1:* creates an event with the specified caption and offset. With no parameter, it creates an event on Easter Sunday with an empty caption.

*Constructor 2:* creates an event with the specified offset and sets the caption to the name of the matching feast in the specified language. If the offset does not match any feast, the caption is empty.

For `AnnualEventEaster`, when several feasts have the same offset, the main name is used: Shrove Tuesday (-47), Laetare Sunday (-21) and Divine Mercy Sunday (7). The offset 63 (`CorpusChristiSunday`) uses the caption of Corpus Christi.

*Constructor 3:* creates a copy of another `AnnualEvent`. It raises a `NilObjectException` if *d* is `Nil` and an `InvalidArgumentException` if *d* is not an event of the same class. All the properties are duplicated.

*Constructor 4:* creates a copy of an event of the same class. All the properties are duplicated.

**Sample code**

```xojo
Var a As New AnnualEventEaster("Pentecost", AnnualEventEaster.Pentecost)
Var b As New AnnualEventEaster(AnnualEventEaster.Pentecost, AnnualEventEaster.FeastLanguage.German)
Var c As New AnnualEventEaster(a)

Var o As New AnnualEventOrthodoxEaster(AnnualEventOrthodoxEaster.Pentecost, AnnualEventOrthodoxEaster.FeastLanguage.Greek)
```

---

## Shared method descriptions

### AllFeasts

Returns the movable feasts celebrated by a denomination, with their captions in the specified language.

**Declaration**

```xojo
Shared Function AllFeasts(cult As Denomination, lang As FeastLanguage) As AnnualEventEaster() // AnnualEventEaster
Shared Function AllFeasts(cult As Denomination, lang As FeastLanguage) As AnnualEventOrthodoxEaster() // AnnualEventOrthodoxEaster
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| cult | Denomination | The denomination (the `Denomination` enumeration of the class). |
| lang | FeastLanguage | The language of the captions (the `FeastLanguage` enumeration of the class). |

**Returns**

An array of events of the class, in the order of the calendar.

**Notes**

The events returned have the default values of the class: `DayOff` is `True`, there is no cycle and the validity period is January 1, year 1 to December 31, year 3999. You can change `DayOff` and the other properties on the returned events if needed.

The feasts returned by `AnnualEventEaster` for each denomination are:

| Denomination | Feasts |
| ------------ | ------ |
| Catholic | Mardi Gras, Ash Wednesday, Laetare Sunday, Palm Sunday, Maundy Thursday, Good Friday, Holy Saturday, Easter Sunday, Easter Monday, Divine Mercy Sunday, Ascension, Pentecost, Whit Monday, Trinity Sunday, Corpus Christi, Sacred Heart, Immaculate Heart of Mary |
| Anglican | Shrove Tuesday, Ash Wednesday, Mothering Sunday, Passion Sunday, Palm Sunday, Maundy Thursday, Good Friday, Holy Saturday, Easter Sunday, Easter Monday, Ascension, Pentecost, Whit Monday, Trinity Sunday |
| Lutheran | Ash Wednesday, Palm Sunday, Maundy Thursday, Good Friday, Easter Sunday, Easter Monday, Ascension, Pentecost, Whit Monday, Trinity Sunday |
| Calvinist | Palm Sunday, Good Friday, Easter Sunday, Easter Monday, Ascension, Pentecost, Whit Monday |

The caption of Mothering Sunday is the English name in all languages.

The feasts returned by `AnnualEventOrthodoxEaster` are:

| Denomination | Feasts |
| ------------ | ------ |
| EasternOrthodox | Sunday of the Publican and the Pharisee, Sunday of the Prodigal Son, Meatfare Sunday, Cheesefare Sunday, Clean Monday, Sunday of Orthodoxy, Sunday of the Cross, Lazarus Saturday, Palm Sunday, Holy Monday, Holy Tuesday, Holy Wednesday, Holy Thursday, Good Friday, Holy Saturday, Pascha, Bright Monday, Thomas Sunday, Sunday of the Myrrh-Bearers, Mid-Pentecost, Ascension, Pentecost, Holy Spirit Monday, All Saints Sunday |
| SlavicOrthodox | The same feasts as `EasternOrthodox`, plus Radonitsa (after Thomas Sunday). |

**Sample code**

```xojo
Var feasts() As AnnualEventEaster = _
AnnualEventEaster.AllFeasts(AnnualEventEaster.Denomination.Calvinist, AnnualEventEaster.FeastLanguage.AmericanEnglish)

For Each f As AnnualEventEaster In feasts
  f.DayOff = (f.DayOffset = AnnualEventEaster.GoodFriday Or f.DayOffset >= AnnualEventEaster.EasterMonday)
Next

Var orthodoxFeasts() As AnnualEventOrthodoxEaster = _
AnnualEventOrthodoxEaster.AllFeasts(AnnualEventOrthodoxEaster.Denomination.SlavicOrthodox, AnnualEventOrthodoxEaster.FeastLanguage.Russian)
```

---

### EasterDate

Returns the date of Easter Sunday for the specified year.

**Declaration**

```xojo
Shared Function EasterDate(year As Integer) As DateTime // AnnualEventEaster
Shared Function EasterDate(year As Integer) As DateTime // AnnualEventOrthodoxEaster
```

**Parameters**

| Name | Type | Description |
| ---- | ---- | ----------- |
| year | Integer | The year. |

**Returns**

A `DateTime` with the date of Easter Sunday in the Gregorian calendar (time 00:00:00).

**Notes**

The method does not check the value of *year*.

`AnnualEventEaster.EasterDate` returns the date of Western Easter, calculated with the Meeus/Jones/Butcher algorithm. For years before the adoption of the Gregorian calendar, the result is the date in the proleptic Gregorian calendar.

`AnnualEventOrthodoxEaster.EasterDate` returns the date of Orthodox Easter. The date is calculated in the Julian calendar with the Meeus algorithm, then converted to the Gregorian calendar by adding the difference between the two calendars: 13 days from 1900 to 2099, 14 days from 2100 to 2199, and so on.

**Sample code**

```xojo
Var western As DateTime = AnnualEventEaster.EasterDate(2026)
MessageBox(western.SQLDate) // 2026-04-05

Var orthodox As DateTime = AnnualEventOrthodoxEaster.EasterDate(2026)
MessageBox(orthodox.SQLDate) // 2026-04-12
```

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

The method can rebuild any of the classes that implement `AnnualEvent`, whichever class you call it on. It raises an `InvalidArgumentException` if the string is not a valid description of an event.

Because of this, you can use it to rebuild a list of events of different types.

**Sample code**

```xojo
Var s As String = e.ToString
Var restored As AnnualEvent = AnnualEventEaster.FromString(s)
```

---

## AnnualEventEaster: constants and enumerations

### Constants of AnnualEventEaster

The value of each constant is the number of days between Western Easter Sunday and the feast. Use them as the `DayOffset` of an event.

Several feasts are known under different names, depending on the tradition or the country. These names are provided as separate constants with the same value, so you can use the one you know (for example `MardiGras` and `ShroveTuesday`, or `DivineMercySunday` and `Quasimodo`).

| Name | Type | Value | Description |
| ---- | ---- | ----: | ----------- |
| MardiGras | Integer | -47 | Tuesday before Ash Wednesday. |
| ShroveTuesday | Integer | -47 | Same as `MardiGras`. |
| ShroveMonday | Number | -48 | Monday before Ash Wednesday. |
| AshWednesday | Integer | -46 | First day of Lent. |
| MotheringSunday | Integer | -21 | Fourth Sunday of Lent. Same as `LaetareSunday`. |
| LaetareSunday | Integer | -21 | Fourth Sunday of Lent. |
| PassionSunday | Integer | -14 | Fifth Sunday of Lent. |
| PalmSunday | Integer | -7 | Sunday before Easter. |
| MaundyThursday | Integer | -3 | Thursday before Easter. |
| GoodFriday | Integer | -2 | Friday before Easter. |
| HolySaturday | Integer | -1 | Saturday before Easter. |
| EasterSunday | Integer | 0 | Easter Sunday. |
| ResurrectionSunday | Number | 0 | Same as `EasterSunday`. |
| EasterMonday | Integer | 1 | Monday after Easter. |
| DivineMercySunday | Integer | 7 | Sunday after Easter. |
| Quasimodo | Integer | 7 | Same as `DivineMercySunday`. |
| Ascension | Integer | 39 | Thursday, 40 days after Easter (Easter counted as day 1). |
| Pentecost | Integer | 49 | Seventh Sunday after Easter. |
| WhitMonday | Integer | 50 | Monday after Pentecost. |
| TrinitySunday | Integer | 56 | Sunday after Pentecost. |
| CorpusChristi | Integer | 60 | Thursday after Trinity Sunday. |
| CorpusChristiSunday | Integer | 63 | Sunday after Trinity Sunday (date used where Corpus Christi is moved to Sunday). |
| SacredHeart | Integer | 68 | Friday after the second Sunday after Pentecost. |
| ImmaculateHeart | Integer | 69 | Saturday after the Sacred Heart. |

### Denomination of AnnualEventEaster

The Christian denominations for which [AllFeasts](#allfeasts) can return a list of feasts.

| Name | Value |
| ---- | ----: |
| Catholic | 0 |
| Anglican | 1 |
| Lutheran | 2 |
| Calvinist | 3 |

### FeastLanguage of AnnualEventEaster

The languages in which the caption of a predefined feast is returned.

| Name | Value |
| ---- | ----: |
| AmericanEnglish | 0 |
| French | 1 |
| German | 2 |
| BelgianFlemish | 3 |
| Spanish | 4 |

> [!IMPORTANT]
> The values of this enumeration are used as an index to find the caption in each language. Do not change their order.

---

## AnnualEventOrthodoxEaster: constants and enumerations

### Constants of AnnualEventOrthodoxEaster

The value of each constant is the number of days between Orthodox Easter and the feast. Use them as the `DayOffset` of an event.

| Name | Type | Value | Description |
| ---- | ---- | ----: | ----------- |
| PublicanAndPhariseeSunday | Integer | -70 | Sunday of the Publican and the Pharisee. |
| ProdigalSonSunday | Integer | -63 | Sunday of the Prodigal Son. |
| MeatfareSunday | Integer | -56 | Meatfare Sunday (Sunday of the Last Judgment). |
| CheesefareSunday | Integer | -49 | Cheesefare Sunday (Sunday of Forgiveness). |
| CleanMonday | Integer | -48 | First day of Great Lent. |
| SundayOfOrthodoxy | Integer | -42 | First Sunday of Great Lent. |
| SundayOfTheCross | Integer | -28 | Third Sunday of Great Lent (Veneration of the Cross). |
| LazarusSaturday | Integer | -8 | Saturday before Palm Sunday. |
| PalmSunday | Integer | -7 | Sunday before Pascha. |
| HolyMonday | Integer | -6 | Monday of Holy Week. |
| HolyTuesday | Integer | -5 | Tuesday of Holy Week. |
| HolyWednesday | Integer | -4 | Wednesday of Holy Week. |
| HolyThursday | Integer | -3 | Thursday of Holy Week. |
| GoodFriday | Integer | -2 | Friday before Pascha. |
| HolySaturday | Integer | -1 | Saturday before Pascha. |
| Pascha | Integer | 0 | Orthodox Easter Sunday. |
| BrightMonday | Integer | 1 | Monday after Pascha. |
| ThomasSunday | Integer | 7 | Sunday after Pascha. |
| Radonitsa | Integer | 9 | Tuesday of the second week after Pascha. |
| MyrrhBearersSunday | Integer | 14 | Sunday of the Myrrh-Bearers. |
| MidPentecost | Integer | 24 | Mid-Pentecost. |
| Ascension | Integer | 39 | Thursday, 40 days after Pascha (Pascha counted as day 1). |
| Pentecost | Integer | 49 | Seventh Sunday after Pascha. |
| HolySpiritMonday | Integer | 50 | Monday after Pentecost (Day of the Holy Spirit). |
| AllSaintsSunday | Integer | 56 | Sunday after Pentecost. |

### Denomination of AnnualEventOrthodoxEaster

The Orthodox traditions for which [AllFeasts](#allfeasts) can return a list of feasts.

| Name | Value |
| ---- | ----: |
| EasternOrthodox | 0 |
| SlavicOrthodox | 1 |

### FeastLanguage of AnnualEventOrthodoxEaster

The languages in which the caption of a predefined feast is returned.

| Name | Value |
| ---- | ----: |
| AmericanEnglish | 0 |
| French | 1 |
| German | 2 |
| BelgianFlemish | 3 |
| Spanish | 4 |
| Russian | 5 |
| Greek | 6 |

> [!IMPORTANT]
> The values of this enumeration are used as an index to find the caption in each language. Do not change their order.

---

## See also

[AnnualEvent](AnnualEvent.md) interface; [DateAndCaption](DateAndCaption.md), `DateTime`, `DatabaseRow` classes.
