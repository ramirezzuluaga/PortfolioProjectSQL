Select *
From PortfolioProject..Reservation2017
Order by arrival_month

Select *
From PortfolioProject..Reservation2018
Order by arrival_month

--Select Data we are going to be using

Select lead_time, arrival_year, arrival_month, repeated_guest, no_of_previous_cancellations, no_of_previous_bookings_not_canceled, booking_status
From PortfolioProject..Reservation2017
UNION 
Select lead_time, arrival_year, arrival_month, repeated_guest, no_of_previous_cancellations, no_of_previous_bookings_not_canceled, booking_status
From PortfolioProject..Reservation2018
	
--Let's create now our new table 

Select *
From PortfolioProject..Reservations

--Counting in Booking Status Not Canceled Vs Canceled

Select COUNT(booking_status) AS BS,
       (Select COUNT(booking_status) From Reservations Where booking_status= 'Not_Canceled') AS TotalNotCanceled,
       (Select COUNT(booking_status) From Reservations Where booking_status= 'Canceled') AS TotalCanceled
From Reservations

--Looking at Repeated Guest Vs Booking Status

Select COUNT(repeated_guest) AS RG,
       (Select COUNT(repeated_guest) From Reservations Where repeated_guest= 0) AS NotRepeated,
       (Select COUNT(repeated_guest) From Reservations Where repeated_guest= 1) AS Repeated
From Reservations

Select booking_status, repeated_guest
From Reservations
Where booking_status= 'Not_Canceled' AND repeated_guest= 0

--Another way to get same result...

Select booking_status, repeated_guest
From Reservations
Where booking_status like 'Not%' AND repeated_guest= 0

Select booking_status, repeated_guest
From Reservations
Where booking_status= 'Not_Canceled' AND repeated_guest= 1

Select booking_status, repeated_guest
From Reservations
Where booking_status= 'Canceled' AND repeated_guest= 0

--Another way to get same result...

Select booking_status, repeated_guest
From Reservations
Where booking_status like'Can%' AND repeated_guest= 0

Select booking_status, repeated_guest
From Reservations
Where booking_status= 'Canceled' AND repeated_guest= 1

--Looking Lead time Vs Repeated and Not repeated Guest

Select repeated_guest, lead_time,
CASE 
	WHEN lead_time < 30 THEN 'Less than a month'
	WHEN lead_time BETWEEN 30 AND 60 THEN 'A month or two Month'
	ELSE 'More than two Month'
END AS [TimeDate Vs Arrival]
From Reservations;

--Let's see the trending about time booking and time arrival

Select [TimeDate Vs Arrival]
From LTRG
Where [TimeDate Vs Arrival]='Less than a month'

Select [TimeDate Vs Arrival]
From LTRG
Where [TimeDate Vs Arrival]='A month or two Month'

Select [TimeDate Vs Arrival]
From LTRG
Where [TimeDate Vs Arrival]='More than two Month'

--Arrival Month Vs count Not Canceled 2017 (New guest)

Select arrival_month, repeated_guest, COUNT(booking_status) AS TotalNotCanceled2017
From PortfolioProject..Reservation2017
Where booking_status='Not_canceled' AND repeated_guest= 0
Group by arrival_month, repeated_guest
Order by arrival_month

--Arrival Month Vs count Canceled 2017 (New guest)

Select arrival_month, repeated_guest, COUNT(booking_status) AS TotalCanceled2017
From PortfolioProject..Reservation2017
Where booking_status='Canceled' AND repeated_guest= 0
Group by arrival_month, repeated_guest
Order by arrival_month

--Arrival Month Vs count Not Canceled 2017 (Repetead guest)

Select arrival_month, repeated_guest, COUNT(booking_status) AS TotalNotCanceled2017
From PortfolioProject..Reservation2017
Where booking_status='Not_canceled' AND repeated_guest= 1
Group by arrival_month, repeated_guest
Order by arrival_month

--Arrival Month Vs count Canceled 2017 (Repeated guest)

Select arrival_month, repeated_guest, COUNT(booking_status) AS TotalCanceled2017
From PortfolioProject..Reservation2017
Where booking_status='Canceled' AND repeated_guest= 1
Group by arrival_month, repeated_guest
Order by arrival_month

--Nothing appears because in 2017 noboby canceled!

--Arrival Month Vs count Not Canceled 2018 (New guest)

Select arrival_month, repeated_guest, COUNT(booking_status) AS TotalNotCanceled2018
From PortfolioProject..Reservation2018
Where booking_status='Not_canceled' AND repeated_guest= 0 
Group by arrival_month, repeated_guest
Order by arrival_month

--Arrival Month Vs count Canceled 2018 (New Guest)

Select arrival_month, repeated_guest, COUNT(booking_status) AS TotalCanceled2018
From PortfolioProject..Reservation2018
Where booking_status='Canceled' AND repeated_guest= 0
Group by arrival_month, repeated_guest
Order by arrival_month

--Arrival Month Vs count Not Canceled 2018 (Repeated guest)

Select arrival_month, repeated_guest,COUNT(booking_status) AS TotalNotCanceled2018
From PortfolioProject..Reservation2018
Where booking_status='Not_canceled' AND repeated_guest= 1 
Group by arrival_month, repeated_guest
Order by arrival_month

--Arrival Month Vs count Canceled 2018 (Repeated Guest)

Select arrival_month, repeated_guest, COUNT(booking_status) AS TotalCanceled2018
From PortfolioProject..Reservation2018
Where booking_status='Canceled' AND repeated_guest= 1
Group by arrival_month, repeated_guest
Order by arrival_month

--My conclusions:
--Most of the visitors are New Guest (5041 Vs 696).
--People tend to use the reservations and not cancel (58.6% Vs 41.3%).
--People tend booking with more than two Months in advance.
--In 2017 there were more guests in October and December (Repetead Guest); September and October (New Guests).
--In 2018 there were more guests in January and March (Repetead Guest); June and October (New Guests).
--Therefore, we can conclude the most busy month is October so we must improve the the customer Service, the Website and create some perks/rewards to have more successful guest in more Months of the year.