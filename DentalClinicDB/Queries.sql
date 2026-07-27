USE DentalClinicDB;

-- Query 1: Retrieve All Patients
-- Purpose: Display every patient registered in the clinic.

SELECT *
FROM Patient;

-- Query 2: Retrieve All Dentists
-- Purpose: Display all dentists and their specializations.

SELECT *
FROM Dentist;

-- Query 3: View All Appointments
-- Purpose: Display appointments ordered by date and time.

SELECT *
FROM Appointment
ORDER BY AppointmentDate, AppointmentTime;

-- Query 4: Display Patients with Their Assigned Dentists
-- Purpose: Join patients, dentists, and appointments to
-- show who is treating each patient.

SELECT
    p.Name AS Patient,
    d.Name AS Dentist,
    a.AppointmentDate,
    a.AppointmentTime,
    a.Status
FROM Appointment a
INNER JOIN Patient p
    ON a.PatientID = p.PatientID
INNER JOIN Dentist d
    ON a.DentistID = d.DentistID;
    
-- Query 5: Display Patients with Insurance Information
-- Purpose: Show each patient's insurance provider and
-- coverage details.

SELECT
    p.Name,
    i.ProviderName,
    i.CoverageType,
    i.CoveragePercentage
FROM Patient p
INNER JOIN PatientInsuranceCoverage pic
    ON p.PatientID = pic.PatientID
INNER JOIN Insurance i
    ON pic.InsuranceID = i.InsuranceID;
    
-- Query 6: View Dentist Weekly Schedule
-- Purpose: Display each dentist's working schedule.

SELECT
    d.Name,
    ds.ScheduleDay,
    ds.StartTime,
    ds.EndTime
FROM Dentist d
INNER JOIN DentistSchedule ds
    ON d.DentistID = ds.DentistID
ORDER BY d.Name;

-- Query 7: Appointment Payment Details
-- Purpose: Combine patient, appointment, and payment
-- information for billing purposes.

SELECT
    p.Name AS Patient,
    a.AppointmentDate,
    pay.TotalAmount,
    pay.PaymentMethod,
    pay.PaymentStatus
FROM Payment pay
INNER JOIN Appointment a
    ON pay.AppointmentID = a.AppointmentID
INNER JOIN Patient p
    ON a.PatientID = p.PatientID;
    
-- Query 8: Count Appointments per Dentist
-- Purpose: Determine the workload of each dentist.

SELECT
    d.Name,
    COUNT(a.AppointmentID) AS TotalAppointments
FROM Dentist d
LEFT JOIN Appointment a
    ON d.DentistID = a.DentistID
GROUP BY d.Name
ORDER BY TotalAppointments DESC;

-- Query 9: Calculate Average Payment
-- Purpose: Determine the average payment collected per
-- appointment.

SELECT
    AVG(TotalAmount) AS AveragePayment
FROM Payment;

-- Query 10: Calculate Total Revenue
-- Purpose: Calculate total revenue from all completed
-- payments.

SELECT
    SUM(TotalAmount) AS TotalRevenue
FROM Payment
WHERE PaymentStatus = 'Paid';

-- Query 11: Dentists with More Than One Appointment
-- Purpose: Identify dentists who have handled multiple
-- appointments using GROUP BY and HAVING.

SELECT
    d.Name,
    COUNT(a.AppointmentID) AS TotalAppointments
FROM Dentist d
INNER JOIN Appointment a
    ON d.DentistID = a.DentistID
GROUP BY d.DentistID, d.Name
HAVING COUNT(a.AppointmentID) > 1;

-- Query 12: Patients Without Any Appointments
-- Purpose: Find patients who have not yet booked an
-- appointment using a LEFT JOIN.

SELECT
    p.PatientID,
    p.Name
FROM Patient p
LEFT JOIN Appointment a
    ON p.PatientID = a.PatientID
WHERE a.AppointmentID IS NULL;

 -- Query 13: Highest Payment Made
-- Purpose: Display the payment record with the highest
-- transaction amount using a subquery.

SELECT *
FROM Payment
WHERE TotalAmount = (
    SELECT MAX(TotalAmount)
    FROM Payment
);

-- Query 14: Classify Payments Using CASE
-- Purpose: Categorize payments into High, Medium, and
-- Low value transactions.

SELECT
    PaymentID,
    TotalAmount,
    CASE
        WHEN TotalAmount >= 500 THEN 'High'
        WHEN TotalAmount >= 200 THEN 'Medium'
        ELSE 'Low'
    END AS PaymentCategory
FROM Payment;

-- Query 15: Patients with Existing Insurance
-- Purpose: Display patients who have insurance records
-- using EXISTS.

SELECT
    p.PatientID,
    p.Name
FROM Patient p
WHERE EXISTS (
    SELECT 1
    FROM PatientInsuranceCoverage pic
    WHERE pic.PatientID = p.PatientID
);

-- Query 16: Total Revenue by Payment Method
-- Purpose: Calculate revenue collected through each
-- payment method.

SELECT
    PaymentMethod,
    SUM(TotalAmount) AS TotalRevenue
FROM Payment
GROUP BY PaymentMethod
ORDER BY TotalRevenue DESC;

-- Query 17: Update Appointment Status
-- Purpose: Mark Appointment ID 1 as completed.

UPDATE Appointment
SET Status = 'Completed'
WHERE AppointmentID = 1;

-- Query 18: Update Patient Phone Number
-- Purpose: Update the phone number for Patient ID 3.

UPDATE Patient
SET PhoneNumber = '6045559000'
WHERE PatientID = 3;

-- Query 19: Delete a Patient Referral
-- Purpose: Remove an existing referral record.

DELETE FROM PatientReferral
WHERE PatientID = 5
  AND ReferredPatientID = 1;

-- Query 20: Delete an Installment Record
-- Purpose: Remove a completed installment payment.

DELETE FROM Installment
WHERE PaymentID = 1
  AND InstallmentID = 1;

