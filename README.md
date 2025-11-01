# pbDateComputaion
Calculate holidays, closures, and working days with Xojo.

The repository is provided with an example project, allowing you to show how to calculate event dates and how to calculate working days, the next working day after a date, etc.
# Features
The features consist of 8 classes.
## 4 classes for calculating annual events, such as holidays and commemorations:
- AnnualEventFix, for events whose date is calculated using a fixed month and day (Independence Day, Christmas, etc.) 
- AnnualEventEaster and AnnualEventOrthodoxEaster, for events whose date is calculated based on Easter (Mardi Gras, Ash Wednesday, etc.) 
- AnnualEventWeekDay, for events whose date is calculated based on a fixed month and the week number of a weekday (Labor Day, Thanksgiving, etc.) 

These 4 classes implement the **AnnualEvent** interface, allowing them to be used in the same array, for example.

### A class to indicate periods of closure or holidays, for the class DaysProcessingRegion

- ClosingPeriod

### A class to calculate, for the same region, the working days, closed days, etc. according to holidays, closure periods and working days of the week.

- DaysProcessingRegion

### A class to work with multiple regions, which do not have the same public holidays or vacation periods, for example.

- DaysProcessingMultiRegion

### A class that is used to return the result of certain methods

- DateAndCaption

For example, you can request a list of all public holidays for a given year. An array of this type will be returned, specifying the date and name of the event for each row.

*A final class (dprWorkingWeekDays), which is only there to be a property of the DaysProcessingRegion class, is also provided, but is not designed to be used on its own.*

# The 4 classes that implement the AnnualEvent interface
 ## Common methods and properties (implemented by the interface)
Note: An interface defines only methods and not properties. "Properties" are a pair of overloaded methods that simulate real properties.

    Public Sub Caption(assigns s as string) 
    Public Function Caption() As string

### Common properties
#### Caption
Type : String
The name of the event, for example Christmas, Easter, presidential election, etc.
#### DayOff 
Type : Boolean
Determines whether it is a non-working day or not (for non-working day the value is true)
#### StartOfValidity, EndOfValidity
Type : DateTime
Defines the dates on which the event occurs. For example, we can imagine a new public holiday being created starting next year (or an existing public holiday being discontinued).

The default dates are from January 1st of year 1 to December 31st of year 3999.
#### CycleFirstYear, CycleYearDuration
Type : Integer
An event may not occur every year. For example, an election.

If this is the case, you must define the first year and the cycle duration.

**Note :** that if the CycleYearDuration property is less than 2, these parameters are ignored.

The default values ​​are 1900 for CycleFirstYear and 1 for CycleYearDuration.

For example, the cycle for the US presidential election can be defined as follows: 

    Var PresidentialElection As New AnnualEventWeekDay("U.S. Presidential Election",11,2,1) // The first monday of november
    PresidentialElection .NextWeekDay = 3 // Shift to the next tuesday (so the next tuesday after the first monday)
    PresidentialElection .CycleFirstYear = 1792  // The event is not every year
    PresidentialElection .CycleYearDuration = 4

### Common methods

#### DateValue(Year as integer) as DateTime
Returns the date of the event for the specified year.

If the event did not occur that year, Nil is returned.
The reasons for a Nil value could be that the year falls outside the event's validity period or that the year does not correspond to the cycle.
Hours, minutes, and seconds are all set to 0.

    Var GoodFriday As New AnnualEventEaster("Good Friday",-2)
     // Determine the date for the year 2025
    Var Value2025 as Datetime = GoodFriday.DateValue(2025)


#### Calculate(Year as integer) as DateAndCaption
Returns a DateAndCaption object for the event for the specified year.
The object's date property contains the event date, and the Caption property replicates the event's Caption property.

If the event did not occur that year, Nil is returned.
The reasons for a Nil value could be that the year falls outside the event's validity period or that the year does not correspond to the cycle.
Hours, minutes, and seconds of the propertie Date are all set to 0.

#### TestDate(d as DateTime) as Boolean
Determines if the event occurs on the tested date.
Hours, minutes, and seconds are ignored.

     Var GoodFriday As New AnnualEventEaster("Good Friday",-2)
     Var t as new DateTime(2025,4,18)
     if GoodFriday.TestDate(t) then 
        MessageBox "It's the date of the Good Friday !"
     else
       MessageBox "It's NOT the date of the Good Friday !"
     end
#### DbRow(RegionIdentifier as Variant = Nil, encoding as TextEncoding = nil) as DatabaseRow
Returns a DatabaseRow object.
This allows you to quickly save an event definition to a database.
Example :


    Var LaborDayEvent as New AnnualEventWeekDay("Labor Day",9, 2, 1) // September, the first monday
    Call MyDatabase.AddRow "tdays", LaborDayEvent.dbrow

You can specify the RegionIdentifer for the event if you are working with multiple regions. For example, the date of the commemoration of the abolition of slavery is not the same in the different French regions concerned. This allows you to filter them in the database.

You can also specify a specific encoding, particularly for databases that do not support UTF-8. By default, it is UTF-8.

Below is the SQL (SQLite) code to create a table to store event definitions.
The DaysProcessingRegion class provides a method to load events from a RowSet.

    CREATE TABLE "tdays" (
    	"id_date"	INTEGER NOT NULL,
    	"start"	DATE NOT NULL DEFAULT '1-1-1',
    	"end"	DATE NOT NULL DEFAULT '3999-12-31',
    	"caption"	TEXT,
    	"region"	TEXT,
    	"definitiontype"	TEXT NOT NULL,
    	"dayoff"	BOOLEAN NOT NULL DEFAULT 1,
    	"cyclefirstyear"	INTEGER NOT NULL DEFAULT 1,
    	"cycleyearduration"	INTEGER NOT NULL DEFAULT 1,
    	"month"	INTEGER NOT NULL DEFAULT 0,
    	"day"	INTEGER NOT NULL DEFAULT 0,
    	"weekday"	INTEGER NOT NULL DEFAULT 0,
    	"rank"	INTEGER NOT NULL DEFAULT 0,
    	"adddays"	INTEGER NOT NULL DEFAULT 0,
    	"nextweekday"	INTEGER NOT NULL DEFAULT 0,
    	"previousweekday"	INTEGER NOT NULL DEFAULT 0,
    	"saturdaytofriday"	BOOLEAN NOT NULL DEFAULT 0,
    	"sundaytomonday"	BOOLEAN NOT NULL DEFAULT 0,
    	"saturdaytomonday"	BOOLEAN NOT NULL DEFAULT 0,
    	"fingerprint"	TEXT NOT NULL,
    	PRIMARY KEY("id_date" AUTOINCREMENT)
    )
### FingerPrint() as string
Returns a value calculated based on the nature of the event, its parameters, and its validity dates. 
The caption and the shift parameters properties is not part of the fingerprint.

    Var VictoriaDay As New AnnualEventFix("Victoria Day ou Fête des patriotes",5,25) // May, 25th
    VictoriaDay.PreviousWeekDay = 2 // Previous Monday, if this not a monday
    MessageBox dFixedDay.FingerPrint

This code return "F05;25;0|0001-01-01|3999-12-31"
