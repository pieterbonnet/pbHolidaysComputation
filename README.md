# Annual events and work calendars for Xojo

A set of Xojo classes to calculate the dates of annual events (public holidays, religious celebrations, commemorations), to manage closure periods, and to answer questions such as "is this day a business day?", "how many business days are there between two dates?" or "is this day open in all our regions?" for a school or a company.

The classes use the Xojo API 2 (`DateTime`, `DatabaseRow`, `RowSet`).

## Contents

- [Summary](#summary)
- [Documentation](#documentation)
  - [Annual events](#annual-events)
  - [Calendars](#calendars)
- [Which class should I use?](#which-class-should-i-use)
- [Quick start](#quick-start)
- [Example: the holidays of Delaware](#example-the-holidays-of-delaware)
- [Conventions](#conventions)
- [About this code and this documentation](#about-this-code-and-this-documentation)

## Summary

- **Annual events.** Five classes calculate the date of an event for a given year, each with its own method: a fixed date, a weekday of a month, a day that depends on Easter (Western or Orthodox), or a date of the Hebrew calendar. They share the same interface, [AnnualEvent](AnnualEvent.md), so you can mix them in one list. Events can be limited in time, restricted to a cycle of years, and saved as text or as a database row.
- **Calendars.** A [work calendar](WorkCalendar.md) combines the days of the week that are worked ([wcWorkingWeekDays](wcWorkingWeekDays.md)), closure periods ([ClosurePeriod](ClosurePeriod.md)) and annual events. It tells whether a day is worked, counts and lists business days, finds the next business day, and loads its data from a database. Ready-made lists of public holidays are provided for Belgium, France, Israel and the United States.
- **Groups of calendars.** A [group](WorkCalendarGroup.md) manages several calendars, for example one for each region, and tells whether a day is open everywhere, open somewhere, or closed, and where.
- **Results.** The methods that return a date with the name of the event use [DateAndCaption](DateAndCaption.md).

## Documentation

Each page describes a class with its properties and methods, and has code samples. Start with the [AnnualEvent](AnnualEvent.md) page: it describes what all the annual events have in common.

### Annual events

| Page | Description |
| ---- | ----------- |
| [AnnualEvent](AnnualEvent.md) | The interface implemented by all the annual events. |
| [AnnualEventFixed](AnnualEventFixed.md) | A fixed date (month and day), with an optional offset, move to a weekday, or weekend adjustment. |
| [AnnualEventWeekDay](AnnualEventWeekDay.md) | A given occurrence of a weekday in a month, such as the second Sunday of May or the last Monday of May. |
| [EasterEvents](EasterEvents.md) | `AnnualEventEaster` and `AnnualEventOrthodoxEaster`: events that depend on Western or Orthodox Easter (Ash Wednesday, Good Friday, Easter Monday, Ascension, Pentecost, etc.). |
| [AnnualEventHebraic](AnnualEventHebraic.md) | Jewish holidays and dates of the Hebrew calendar. Also converts dates and calculates sunrise and sunset. |
| [DateAndCaption](DateAndCaption.md) | A date with a caption: the result of the methods that return a date and the name of the event. |

### Calendars

| Page | Description |
| ---- | ----------- |
| [ClosurePeriod](ClosurePeriod.md) | A period of holidays or closure. |
| [wcWorkingWeekDays](wcWorkingWeekDays.md) | The days of the week that are worked. |
| [WorkCalendar](WorkCalendar.md) | A calendar: working week, closure periods and annual events. Provides the lists of public holidays. |
| [WorkCalendarGroup](WorkCalendarGroup.md) | A group of calendars (regions, sites, schools): is a day open everywhere, or somewhere? |

## Which class should I use?

| I want to... | Use |
| ------------ | --- |
| Calculate a holiday on a fixed date, such as December 25 | [AnnualEventFixed](AnnualEventFixed.md) |
| Move a holiday that falls on a weekend (Saturday to Friday, Sunday to Monday) | [AnnualEventFixed](AnnualEventFixed.md) |
| Calculate "the second Sunday of May" or "the last Monday of May" | [AnnualEventWeekDay](AnnualEventWeekDay.md) |
| Calculate a day that depends on Easter, such as Ash Wednesday or Pentecost | [EasterEvents](EasterEvents.md) |
| Calculate Jewish holidays, or convert a date to the Hebrew calendar | [AnnualEventHebraic](AnnualEventHebraic.md) |
| Define school holidays or the annual closure of a company | [ClosurePeriod](ClosurePeriod.md) |
| Know whether a day is worked, or count business days | [WorkCalendar](WorkCalendar.md) |
| Get the public holidays of Belgium, France, Israel or a US state | [WorkCalendar](WorkCalendar.md) |
| Handle several regions, sites or schools at the same time | [WorkCalendarGroup](WorkCalendarGroup.md) |
| Save events or periods in a database | [AnnualEvent](AnnualEvent.md#dbrow), [ClosurePeriod](ClosurePeriod.md#dbrow) and [WorkCalendar](WorkCalendar.md#database-tables) |

## Quick start

Calculate the date of an event:

```xojo
Var e As New AnnualEventEaster("Easter Monday", AnnualEventEaster.EasterMonday)
MessageBox(e.DateValue(2026).SQLDate) // 2026-04-06
```

Create a calendar for a company in France, closed during three weeks in August 2026, and count the business days:

```xojo
Var cal As New WorkCalendar("FR", "Company calendar")
cal.AddAnnualEvents(WorkCalendar.AnnualEventsFrance(WorkCalendar.France.General))
cal.ClosurePeriods.Add(New ClosurePeriod(New DateTime(2026, 8, 3), New DateTime(2026, 8, 21), "Summer closure"))

Var may As Integer = cal.CountBusinessDays(New DateTime(2026, 5, 1), New DateTime(2026, 5, 31))
MessageBox(may.ToString) // 17

Var august As Integer = cal.CountBusinessDays(New DateTime(2026, 8, 1), New DateTime(2026, 8, 31))
MessageBox(august.ToString) // 6: the three weeks of closure are not counted

MessageBox(cal.NonWorkingDayReasonCaption(New DateTime(2026, 5, 14))) // Ascension
```


## Example: the holidays of Delaware

The legal holidays of Delaware ([Delaware Code, Title 1, Chapter 5](https://delcode.delaware.gov/title1/c005/index.html)) use all the kinds of events: fixed dates, weekdays of a month, days that depend on Easter, and an event that happens only every two years.

```xojo
// A holiday on a Saturday is observed on the Friday before,
// and a holiday on a Sunday is observed on the Monday after.
Var list() As AnnualEvent
list.Add(New AnnualEventFixed("New Year's Day", 1, 1, True, True))   // FridayIfSaturday, MondayIfSunday
list.Add(New AnnualEventFixed("Juneteenth", 6, 19, True, True))
list.Add(New AnnualEventFixed("Independence Day", 7, 4, True, True))
list.Add(New AnnualEventFixed("Veterans Day", 11, 11, True, True))
list.Add(New AnnualEventFixed("Christmas", 12, 25, True, True))

list.Add(New AnnualEventEaster("Good Friday", AnnualEventEaster.GoodFriday))

list.Add(New AnnualEventWeekDay("Martin Luther King, Jr.", 1, 2, 3))                // January, Monday, the third
list.Add(New AnnualEventWeekDay("Memorial Day", 5, 2, AnnualEventWeekDay.kLast))    // May, Monday, the last
list.Add(New AnnualEventWeekDay("Labor Day", 9, 2, 1))                              // September, Monday, the first
list.Add(New AnnualEventWeekDay("Thanksgiving", 11, 5, 4))                          // November, Thursday, the fourth

Var dw As New AnnualEventWeekDay("Day after Thanksgiving", 11, 5, 4)
dw.DayOffset = 1 // the day after...
list.Add(dw)

// The general election takes place every two years, on the Tuesday after the first Monday of November
Var election As New AnnualEventWeekDay("General Election Day", 11, 2, 1)
election.DayOffset = 1
election.CycleFirstYear = 2000
election.CycleYearDuration = 2
list.Add(election)
```

Test a date:

```xojo
Var d As New DateTime(2025, 11, 27)
For i As Integer = 0 To list.LastIndex
  If list(i).IsEventDate(d) Then
    MessageBox(list(i).Caption) // Thanksgiving
    Exit For
  End If
Next
```

Get the holidays of 2026:

```xojo
Var holidays() As DateTime
For i As Integer = 0 To list.LastIndex
  Var temp As DateTime = list(i).DateValue(2026)
  If temp <> Nil Then holidays.Add(temp) // Nil if the event does not occur that year
Next
```

The result is: January 1, January 19 (Martin Luther King, Jr.), April 3 (Good Friday), May 25 (Memorial Day), June 19 (Juneteenth), July 3 (Independence Day, observed on the Friday because July 4 is a Saturday), September 7 (Labor Day), November 3 (General Election Day), November 11 (Veterans Day), November 26 (Thanksgiving), November 27 (day after Thanksgiving) and December 25. In 2025, which is not an election year, `General Election Day` returns `Nil`.

To use these holidays in a calendar, add them with [AddAnnualEvents](WorkCalendar.md#addannualevents). The same list is available with `WorkCalendar.AnnualEventsUSA(WorkCalendar.USA.Delaware)`.


## Conventions

- The days of the week are numbered like `DateTime.DayOfWeek`: 1 is Sunday, 2 is Monday, ..., 7 is Saturday.
- The methods that work on days expect dates at 00:00:00.
- An event can be limited in time (`StartOfValidity`, `EndOfValidity`) and restricted to a cycle of years (`CycleFirstYear`, `CycleYearDuration`). See [AnnualEvent](AnnualEvent.md).
- Events and closure periods can be saved as text or as database rows, and loaded again. See [DbRow](AnnualEvent.md#dbrow) and [WorkCalendar](WorkCalendar.md).

## About this code and this documentation

> [!NOTE]
> - The code is old code written with RealStudio (the former name of Xojo). It was updated last year, and reviewed and corrected this year with the help of Claude, an AI assistant made by Anthropic.
> - The author is not a native English speaker. This documentation was written in English with the help of Claude. If you find a mistake or an unclear sentence, please report it.
