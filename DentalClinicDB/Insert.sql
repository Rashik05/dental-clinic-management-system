USE DentalClinicDB;


-- Patient

INSERT INTO Patient (PatientID, Name, PhoneNumber, Email, DateOfBirth, Address) VALUES
(1,'Aarav Mehta','6043211234','aarav.mehta@gmail.com','1995-07-12','55 W 5th Ave, Vancouver, BC'),
(2,'Liam Chen','7788884567','liam.chen@yahoo.com','1988-11-02','321 Oak Avenue, Vancouver, BC'),
(3,'Sophia Patel','6045557812','sophia.patel@gmail.com','1992-04-18','100 Main St, Vancouver, BC'),
(4,'Noah Singh','6047778811','noah.singh@gmail.com','1990-09-05','210 Broadway, Vancouver, BC'),
(5,'Emma Wilson','7785552201','emma.wilson@gmail.com','1998-01-21','78 Kingsway, Burnaby, BC');


-- Insurance

INSERT INTO Insurance (InsuranceID, PolicyNumber, ProviderName, CoveragePercentage, MaxCoverage, CoverageType) VALUES
(1,'DNTL901','Pacific HealthCare',85.00,7000.00,'Dental'),
(2,'HLTH782','Global Wellness',90.00,12000.00,'Comprehensive'),
(3,'CARE554','SunCare Insurance',80.00,5000.00,'Dental'),
(4,'MED884','BlueShield Health',75.00,6500.00,'Dental'),
(5,'PLUS333','Canada Life',95.00,15000.00,'Premium');


-- Dentist

INSERT INTO Dentist (DentistID, Name, Email, Specialization, PhoneNumber) VALUES
(1,'Dr. Anita Kapoor','anita.kapoor@brightdent.com','Prosthodontics','6047774321'),
(2,'Dr. Miguel Torres','miguel.torres@brightdent.com','Periodontics','7786669876'),
(3,'Dr. Sarah Kim','sarah.kim@brightdent.com','Orthodontics','6045558877'),
(4,'Dr. James Brown','james.brown@brightdent.com','Endodontics','7785553344'),
(5,'Dr. Olivia Green','olivia.green@brightdent.com','General Dentistry','6049991122');


-- Dentist Schedule

INSERT INTO DentistSchedule (DentistID, ScheduleDay, StartTime, EndTime) VALUES
(1,'Monday','08:30:00','12:30:00'),
(2,'Tuesday','09:00:00','13:00:00'),
(3,'Wednesday','10:00:00','15:00:00'),
(4,'Thursday','08:00:00','12:00:00'),
(5,'Friday','09:30:00','16:30:00');


-- Patient Insurance Coverage

INSERT INTO PatientInsuranceCoverage (PatientID, InsuranceID) VALUES
(1,1),(2,2),(3,3),(4,4),(5,5);


-- Patient Referral

INSERT INTO PatientReferral (PatientID, ReferredPatientID, ReferralDate, Relationship) VALUES
(1,2,'2024-03-15','Colleague'),
(2,3,'2024-04-10','Friend'),
(3,4,'2024-05-05','Sibling'),
(4,5,'2024-06-12','Coworker'),
(5,1,'2024-07-08','Neighbor');


-- Appointment

INSERT INTO Appointment (AppointmentID, AppointmentDate, AppointmentTime, Status, DentistID, PatientID, Notes) VALUES
(1,'2024-04-01','09:00:00','Scheduled',1,1,'Whitening consultation'),
(2,'2024-04-05','11:30:00','Completed',2,2,'Root canal follow-up'),
(3,'2024-04-09','10:00:00','Scheduled',3,3,'Braces consultation'),
(4,'2024-04-12','13:30:00','Completed',4,4,'Tooth extraction'),
(5,'2024-04-15','15:00:00','Scheduled',5,5,'Routine cleaning');


-- Payment

INSERT INTO Payment (PaymentID, AppointmentID, PaymentDate, PaymentStatus, TotalAmount, PaymentMethod) VALUES
(1,1,'2024-04-01','Paid',180.00,'Debit Card'),
(2,2,'2024-04-05','Paid',550.00,'e-Transfer'),
(3,3,'2024-04-09','Pending',250.00,'Credit Card'),
(4,4,'2024-04-12','Paid',700.00,'Cash'),
(5,5,'2024-04-15','Pending',120.00,'Debit Card');


-- Installment

INSERT INTO Installment (PaymentID, InstallmentID, AmountPaid, DueDate, InstallmentStatus) VALUES
(1,1,180.00,'2024-04-01','Paid'),
(2,1,275.00,'2024-04-10','Paid'),
(2,2,275.00,'2024-04-17','Pending'),
(4,1,350.00,'2024-04-19','Paid'),
(5,1,120.00,'2024-04-22','Pending');
