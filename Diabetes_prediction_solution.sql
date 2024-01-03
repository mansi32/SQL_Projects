use diabetes_prediction_analysis;
select * from diabetes_prediction;

/*1. Retrieve the Patient_id and ages of all patients.*/
select patient_id, age from diabetes_prediction;

/*2. Select all female patients who are older than 40.*/
select * from diabetes_prediction where gender = "Female" and age > 40;

/*3. Calculate the average BMI of patients.*/
select avg(BMI) from Diabetes_Prediction;

/*4. List patients in descending order of blood glucose levels.*/
select * from diabetes_prediction order by blood_glucose_level desc;

/*5. Find patients who have hypertension and diabetes.*/
select * from diabetes_prediction where hypertension = True and diabetes = True;

/*6. Determine the number of patients with heart disease.*/
select count(*) from diabetes_prediction where heart_disease = True;

/*7. Group patients by smoking history and count how many smokers and non smokers there are.*/
select count(patient_id), smoking_history from diabetes_prediction where smoking_history = "never" or smoking_history = "current" group by smoking_history;

/*8. Retrieve the Patient_ids of patients who have a BMI greater than the average BMI.*/
select patient_id, BMI from diabetes_prediction where BMI > (select avg(BMI) from diabetes_prediction);

/*9. Find the patient with the highest HbA1c level and the patient with the lowest HbA1clevel.*/
select patient_id, Hba1c_level from diabetes_prediction where hba1c_level = (select max(Hba1c_level) from diabetes_prediction);
select patient_id, Hba1c_level from diabetes_prediction where hba1c_level = (select min(Hba1c_level) from diabetes_prediction);

/*10. Calculate the age of patients in years (assuming the current date as of now).*/
select age, subdate(current_date(), interval age year) as DOB from diabetes_prediction;

/*11. Rank patients by blood glucose level within each gender group.*/
select employeename, gender, blood_glucose_level, rank() over (partition by gender order by blood_glucose_level desc) as Patient_Rank from diabetes_prediction;

/*12. Update the smoking history of patients who are older than 50 to "Ex-smoker."*/
SET SQL_SAFE_UPDATES = 0;
update diabetes_prediction set smoking_history = "Ex-smoker" where age > 50;

/*13. Insert a new patient into the database with sample data.*/
insert into diabetes_prediction (EmployeeName, Patient_id, gender, age, hypertension, heart_disease, smoking_history, bmi, HbA1c_level, blood_glucose_level, diabetes)
value ("Lara Fernandez", "pt1000101", "Female", 40, 0, 1, "Ex-smoker", "25.19", "6.6", 140, 0);

/*14. Delete all patients with heart disease from the database.*/
delete from diabetes_prediction where heart_disease = True;

/*15. Find patients who have hypertension but not diabetes using the EXCEPT operator.*/
select * from diabetes_prediction where hypertension = True except select * from diabetes_prediction WHERE diabetes = True;

/*16. Define a unique constraint on the "patient_id" column to ensure its values are unique.*/
alter table diabetes_prediction modify patient_id varchar(100) unique;

/*17. Create a view that displays the Patient_ids, ages, and BMI of patients.*/
create view Patient_Details as select patient_id, age, bmi from diabetes_prediction;

/*18. Suggest improvements in the database schema to reduce data redundancy and improve data integrity.*/
/*Answer: As per my understanding to reduce data redundancy and improve data integrity we can follow ------- 
1. Normalization rule like 1N, 2N, 3N
2. Clean unnecessary data from the database 
3. Remove duplicate values
4. */

/*19. Explain how you can optimize the performance of SQL queries on this dataset.*/
/*Answer: We can optimize the performance of SQL queries on this dataset are as follows ------
1. Use valid functions and operator
2. Write queries carefully as SQL is not case sensitive
3. Limit the result when we are dealing with large dataset
4. Do changes carefully in the database as it will affect whole database
5. Avoid retrieval of unnecessary columns
6. Be carful while deleting anything (like table, columns) from the database as once deleted we will lost data*/
