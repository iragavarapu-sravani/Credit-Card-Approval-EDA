SELECT * FROM credit_card.credit_card_approval;

#1.Group the customers based on their income type and find the average of their annual income.

select type_income,avg(annual_income) as average_income from credit_card.credit_card_approval group by type_income 

#2.Find the female owners of cars and property.

select ind_id,gender,car_owner,propert_owner from credit_card.credit_card_approval where gender="F" and car_owner="y" and propert_owner="y"

#3.Find the male customers who are staying with their families.

select ind_id,gender,family_members from credit_card.credit_card_approval where family_members>1 and gender="m"

#4.Please list the top five people having the highest income.

select ind_id,gender,annual_income from credit_card.credit_card_approval order by annual_income desc limit 5

#5.How many married people are having bad credit?

with mar as (select ind_id,gender,marital_status,annual_income from credit_card.credit_card_approval where marital_status in ("married","civil marriage") 
order by annual_income)
select count(ind_id) as total_bad_credit from mar where annual_income<=200000 

#6.What is the highest education level and what is the total count? 
with hedu as 
(select Education,count(*) as total from credit_card.credit_card_approval group by education order by total desc)
select * from hedu limit 1,1


#7.Between married males and females, who is having more bad credit? 

with bad as ((select ind_id,gender,marital_status,annual_income from credit_card.credit_card_approval where marital_status in 
("married","civil marriage") and gender="f" 
order by annual_income limit 1)
union
(select ind_id,gender,marital_status,annual_income from credit_card.credit_card_approval where marital_status in ("married","civil marriage") and gender="m"
order by annual_income limit 1))
select ind_id,gender,marital_status,annual_income from bad order by annual_income limit 1
