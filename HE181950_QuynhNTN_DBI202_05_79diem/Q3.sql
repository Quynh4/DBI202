SELECT Cars.ID CarID, Cars.Description CarDescription, 
Cars.Model, Cars.Brand, Cars.Category_ID, Category.Label CategoryLabel
FROM     Cars INNER JOIN
                  Category ON Cars.Category_ID = Category.ID
where Category.Label = 'luxury' or Category.Label = 'convertible'