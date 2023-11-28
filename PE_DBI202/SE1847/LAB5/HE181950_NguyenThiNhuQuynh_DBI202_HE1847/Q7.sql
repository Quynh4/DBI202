SELECT Student.*, Class.className
FROM     Student INNER JOIN
                  Student_Class ON Student.studentID = Student_Class.studentID INNER JOIN
                  Class ON Student_Class.classCode = Class.classCode