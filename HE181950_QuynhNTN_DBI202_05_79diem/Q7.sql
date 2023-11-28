SELECT Category.ID, Category.Label, 
year(Rentals.Pick_up_date) Year, 
sum(Rentals.Amount) as TotalAmount ,
count(Rentals.Reservation_Number) as NumberOfRentals,
count(distinct Rentals.Customer_ID) as NumberOfCustmers,
sum(datediff(day, Rentals.Pick_up_date, Rentals.Return_date)) as TotalRentedDays
FROM     Cars INNER JOIN
                  Category ON Cars.Category_ID = Category.ID INNER JOIN
                  Rentals ON Cars.ID = Rentals.CarID
group by Category.ID, Category.Label, 
year(Rentals.Pick_up_date)
order by ID