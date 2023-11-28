SELECT Rentals.Reservation_Number, Rentals.Amount, Rentals.Pick_up_date, 
Rentals.Return_date,
Customers.First_Name + ' '+ Customers.Last_Name CustomerFullname,
pk.Country PickupCountry,
rt.Country ReturnCountry
FROM     Customers INNER JOIN
                  Rentals ON Customers.ID = Rentals.Customer_ID INNER JOIN
                  Location pk ON Rentals.Pick_up_location = pk.ID INNER JOIN
                  Location rt ON Rentals.Return_location = rt.ID
where pk.Country <> rt.Country
order by Amount desc