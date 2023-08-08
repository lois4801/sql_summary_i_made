

/* creating a column containing row numbers ordered by ascending name */
 /* select a.*, row_number () over (order by a.firstname) as rnum  from childstat a */

/*creating a column containing row numbers within the gender */
/* select a.*,row_number () over (partition by a.gender order by a.firstname) as rnum from childstat a
order by a.gender, a.firstname; */

/* create a string of first names by gender ordered by descending weight */
/* select *from childstat order by weight; */


/*
SELECT A.FIRSTNAME,A.WEIGHT, 
LEAD(A.WEIGHT,1,-1) OVER (ORDER BY A.WEIGHT) AS LEAD_1_WT,
LAG(A.WEIGHT,2,-1)  OVER (ORDER BY A.WEIGHT) AS LAG_2_WT
 FROM CHILDSTAT A ORDER BY A.WEIGHT
 */
 
 /* creating two columns using the weight within genders
  -the next heaviest weight
  - the previous lightest weight 
  
  select a.firstname, a.gender, a.weight,
  lead (a.weight, 1, -1) over (partition by a.gender order by a.weight) as lead_1_wt,
  lag(a.weight, 2,-1) over (partition by a.gender order by a.weight) as lag_2_wt
  from childstat a
  order by a.gender, a.weight */
  
/* create ranks using ascending height and gender 
select a.firstname, a.gender, a.height,
rank()       over (partition by a.gender order by a.height) as ht_rank,
dense_rank() over (partition by a.gender order by a.height) as ht_denserank
from childstat a
order by a.gender, a.height 
*/

/* retrieve names of the lightest male or female child and  Heaviest male or female 
with default window clause -- this made a wrong answer in the hv_child- using window syntax will provide right answer

use childinfo;
select a.firstname, a.gender, a.weight,
first_value (a.firstname) over (partition by a.gender order by a.weight
								rows between unbounded preceding and current row) as lt_child,
last_value(a.firstname)   over (partition by a.gender order by a.weight
                                rows between unbounded preceding and current row) as hv_child
from childstat a
order by a.gender, a.weight   */


/* retrieve names of the lightest male or female child and  Heaviest male or female 
with default window syntax. this will provide a correct answer in the hv_child */
/*
use childinfo;
select a.firstname, a.gender, a.weight,
first_value (a.firstname) over (partition by a.gender order by a.weight
								rows between unbounded preceding and unbounded following) as lt_child,
last_value(a.firstname)   over (partition by a.gender order by a.weight
                                rows between unbounded preceding and unbounded following) as hv_child
from childstat a
order by a.gender, a.weight  */



/* retrieve names of the heaviest weight  
with default window syntax. this will provide a correct answer in the wt_run2 or the heaviest_weight */

/*
use childinfo;
select a.firstname, a.gender, a.weight,
sum(a.weight)  over(partition by a.gender order by a.weight
								rows between unbounded preceding and current row) as wt_run,
sum(a.weight) over(partition by a.gender order by a.weight
                                rows between unbounded preceding and unbounded following) as heaviest_weight
from childstat a
order by a.gender, a.weight  */


/* compute the average weight using current, previous and next rows */
/*
Select a.firstname, gender, a.weight, 
avg(a.weight) over (partition by a.gender order by a.weight 
					rows between 1 preceding and 1 following) as average_3
from childstat a
order by a.gender, a.weight */

/*compute the sum of weight based on a range of height between 10 less than the current row's value to 5
more than the current row's value--- use the range window clause*/
/*
select a.firstname, a.gender, a.weight,
sum(a.weight) over(order by a.height 
					range between 10 preceding and 5 following) as sum_10_5
from childstat a
order by a.height
*/
             
                    










													

 

