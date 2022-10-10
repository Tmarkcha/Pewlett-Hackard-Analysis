# Pewlett-Hackard-Analysis
## Overview
The purpose of this analysis is to aid Pewlett Hackard, a large company that employs several thousand employees, with identifying which of its employees are eligible to be part of a mentorship program, should they meet the required criteria, and to identify which, and how many, positions will need filling in the near future.

The analysis will be conducted by first creating a map, or a quick database diagram, to visualize the relationships between the provided datasets. Using the provided datasets, and the shared columns they have, different datasets can be combined to provide outputs that could help answer either one of the two initial objectives.

To start solving the first objective, who is eligible for the mentorship program, one can select certain columns in one of the datasets called ‘employees’ where the employee number, first name, last name, and birth date columns are then filtered where the birth date of an employee lies in 1965, and that their hiring date fell between 1985-01-01 and 1988-12-31. A new dataset, ‘mentorship_eligibility’, is created from this and can be utilized with other datasets to get closer to the final answer. ‘Mentorship_eligibility’ is then combined with the ‘dept_emp’ and ‘titles’ dataset, where using the shared column of ‘emp_no’ (employee number) one can figure out whether an employee is still currently employed at Pewlett Hackard. This is done by filtering the employee list by checking if their “to_date” is equal to “9999-01-01”. If so, then the employees that match this criteria still work at the company. This allows us to further narrow down which employees still work for Pewlett Hackard. This dataset answers which current employees meet the criteria to be eligible for the retirement package. This final dataset contains: Employee number, first name, last name, birth date, from date (hiring date) to date (employment termination date), and job title.

The second half of this analysis is to figure out which positions need filling after a generation of employees begin to retire. This is another multi-step process that involves multiple queries to achieve the end result. Firstly, several columns from the ‘employees’ and ‘titles’ dataset are selected and joined by utilizing their shared column (employee number). The data is then filtered by dates for the date of birth (between 1952-01-01 and 1955-12-31). Secondly, the issue that presents itself in this newly formed dataset is that there are duplicates employees, due to promotions. This is solved by filtering out to the same “to_date” from before, as previous roles would have a different “to_date” than their current role. Finally, a new dataset is formed with the last filter, and with that the number of times each job title is counted and compiled into a final dataset that displays the total number of retirees by job title.

## Results

- The number of retiring employees, by title, are as follows:
  - 25,916 Senior Engineers
  - 24,926 Senior Staff
  - 9,285 Engineers
  - 7,636 Staff
  - 3,603 Technique Leaders
  - 1,090 Assistant Engineers
  - 2 Managers
-	Total of 72,458 jobs consist of current employees who will soon be retiring.
-	Total of 1,549 current employees are eligible for the mentorship program.
-	0.02% of potential retirees are eligible for the mentorship program

## Summary

1.	How many roles will need to be filled as the “silver tsunami” begins to make an impact?

With the criteria of employees being born in 1956, the query proves that 72,458 current employees are capable of retiring. Most of these roles are at the senior level, understandably, and are the prime title for current employees to fill in for. By running the following query:

![future_employees](https://user-images.githubusercontent.com/111096246/194955542-28bab367-d259-4086-84f5-643326f41c56.PNG)

We get a total result of 240,124 entries. This means that there are currently 240,124 employees at all levels of hierarchy and in different stages in life. By removing the ‘- -’ at the second last line of the query we get 167,666 entries. This means that there are 167,666 employees who are not quite ready to retire and will be called upon to fill in the void. The difference between the two values is the same as the number of employees capable of retiring.  

2.	Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?

With the total number of potential retirees being 72,458 and the number of those qualified for the mentorship program being 1,549, that puts the ratio of mentors to jobs that need filling at 1:47. Having an approximated 47 students per mentor is a rather large number of students, so the proposed method of teaching would be a seminar. However, as these mentors would reduce their work capacity to a part-time status, that would leave them more time to interact more closely with everyone looking to improve and thrive at Pewlett Hackard.

The following query allows us to get the count, per title, of the next generation of employees and available mentors:

![employee_mentor_counts_byTitle](https://user-images.githubusercontent.com/111096246/194955926-cee36a75-7bdd-4963-a109-1e65ed3dcde8.PNG)

If one compares the number of mentors, by title, to the number of current employees, by title as well, one can conclude the following:

![mentor_employee_counts_byTitle](https://user-images.githubusercontent.com/111096246/194954894-be3c5c88-e950-43e8-865b-2f6dce96f722.PNG)

We can also figure out what the ratio is of available mentors to the current workforce to pass on advice and wisdom to better fulfill their titles and prepare them to take on the next step in their careers. The ratios are as follows:

![mentor_employee_ratios_byTitle](https://user-images.githubusercontent.com/111096246/194954937-12e1b084-084e-4f82-8f97-1c255e5ffe50.PNG)

If the mentors were to teach their own to help them succeed even further, the senior engineers would have the most trouble, as there are too many future senior engineers for the mentors to teach. It would be advised that this potential opportunity be brought to the senior engineers with least experience, as there would be senior engineers who have done their tasks and duties for a longer period and do not believe they need much mentoring at that stage of their careers.
The positions of Senior Staff, Staff, and Technique Leaders have similar ratios, and are more feasible to conduct. Where, for example, one mentor can have approximately 20 different students each day. In an average five-day work week, a single mentor could cover all their potential students.
Moreover, the positions of Engineer and Assistant Engineers have more reasonable numbers to conduct this sort of operation where one mentor could have less than a dozen students per day in an average five-day work week.
Unfortunately, the next generation of managers are out of luck, as there are no mentorship eligible managers to aid them.
