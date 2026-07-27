<?php
$host="localhost"; $db="DentalClinicDB"; $user="root"; $pass="";
$conn=new mysqli($host,$user,$pass,$db);
if($conn->connect_error){die("Connection failed: ".$conn->connect_error);}
$action=$_POST['action']??'';

function runPrepared($conn,$sql,$types,$params,$success){
    $stmt=$conn->prepare($sql);
    $stmt->bind_param($types,...$params);
    if($stmt->execute()) echo $success;
    else echo "Error: ".$stmt->error;
    $stmt->close();
}

switch($action){

case "insert_patient":
runPrepared($conn,
"INSERT INTO Patient(PatientID,Name,PhoneNumber,Email,DateOfBirth,Address) VALUES(?,?,?,?,?,?)",
"isssss",
[$_POST['patient_id'],$_POST['name'],$_POST['phone'],$_POST['email'],$_POST['dob'],$_POST['address']],
"Patient inserted.");
break;

case "insert_dentist":
runPrepared($conn,
"INSERT INTO Dentist(DentistID,Name,Email,Specialization,PhoneNumber) VALUES(?,?,?,?,?)",
"issss",
[$_POST['dentist_id'],$_POST['dentist_name'],$_POST['dentist_email'],$_POST['specialization'],$_POST['dentist_phone']],
"Dentist inserted.");
break;

case "insert_insurance":
runPrepared($conn,
"INSERT INTO Insurance(InsuranceID,PolicyNumber,ProviderName,CoveragePercentage,MaxCoverage,CoverageType)
VALUES(?,?,?,?,?,?)",
"issdds",
[$_POST['insurance_id'],$_POST['policy_number'],$_POST['provider'],$_POST['coverage_percentage'],$_POST['max_coverage'],$_POST['coverage_type']],
"Insurance inserted.");
break;

case "insert_appointment":
runPrepared($conn,
"INSERT INTO Appointment(AppointmentID,AppointmentDate,AppointmentTime,Status,DentistID,PatientID,Notes)
VALUES(?,?,?,?,?,?,?)",
"isssiis",
[$_POST['appointment_id'],$_POST['appointment_date'],$_POST['appointment_time'],$_POST['status'],$_POST['dentist_id'],$_POST['patient_id'],$_POST['notes']],
"Appointment inserted.");
break;

case "insert_payment":
runPrepared($conn,
"INSERT INTO Payment(PaymentID,AppointmentID,PaymentDate,PaymentStatus,TotalAmount,PaymentMethod)
VALUES(?,?,?,?,?,?)",
"iissds",
[$_POST['payment_id'],$_POST['appointment_id'],$_POST['payment_date'],$_POST['payment_status'],$_POST['amount'],$_POST['payment_method']],
"Payment inserted.");
break;

case "insert_installment":
runPrepared($conn,
"INSERT INTO Installment(PaymentID,InstallmentID,AmountPaid,DueDate,InstallmentStatus)
VALUES(?,?,?,?,?)",
"iidss",
[$_POST['payment_id'],$_POST['installment_id'],$_POST['amount_paid'],$_POST['due_date'],$_POST['installment_status']],
"Installment inserted.");
break;

default:
echo "Unknown action.";
}
$conn->close();
?>