/***Warby Parker SQL Project by Andreina Castejon***/

--1

SELECT *
FROM survey
LIMIT 10;


--2

SELECT question, 
COUNT(DISTINCT user_id) as 'responses per question'
FROM survey
GROUP BY question;


--3

SELECT COUNT(DISTINCT user_id)
FROM survey;


--4

SELECT *
FROM quiz
LIMIT 5;
SELECT *
FROM home_try_on
LIMIT 5;
SELECT *
FROM purchase
LIMIT 5;


--5

WITH funnel AS (SELECT DISTINCT quiz.user_id AS 'user_id',
                CASE WHEN home_try_on.user_id IS NOT NULL
                	THEN 'True' ELSE 'False' END AS 'is_home_try_on',
                CASE WHEN home_try_on.number_of_pairs IS NULL
                	THEN '0 pairs' ELSE home_try_on.number_of_pairs 
                END AS 'number_of_pairs',
                CASE WHEN purchase.user_id IS NOT NULL 
                	THEN 'True' ELSE 'False' END AS 'is_purchase'
     FROM quiz
     LEFT JOIN home_try_on
       ON home_try_on.user_id = quiz.user_id
     LEFT JOIN purchase
       ON purchase.user_id = home_try_on.user_id)
SELECT *
FROM funnel
GROUP BY user_id
LIMIT 10;


--6

WITH funnel AS (SELECT DISTINCT quiz.user_id AS 'user_id',
		CASE WHEN home_try_on.user_id IS NOT NULL
			THEN '1' ELSE '0' 
			END AS 'is_home_try_on',
		CASE WHEN home_try_on.number_of_pairs IS NULL
			THEN '0 pairs' ELSE home_try_on.number_of_pairs
			END AS 'number_of_pairs',
		CASE WHEN purchase.user_id IS NOT NULL
			THEN '1' ELSE '0' END AS 'is_purchase'
	FROM quiz
	LEFT JOIN home_try_on
	ON home_try_on.user_id = quiz.user_id
	LEFT JOIN purchase
	ON purchase.user_id = home_try_on.user_id)
SELECT DISTINCT number_of_pairs,
	COUNT(*) AS 'num_quiz',
	SUM(is_home_try_on) AS 'num_home_try_on',
	SUM(is_purchase) AS 'num_purchase',
	1.0 * SUM(is_home_try_on) / COUNT(user_id) AS 'quiz_to_home_try_on',
	1.0 * SUM(is_purchase) / SUM(is_home_try_on) AS 'home_try_on_to_purchase'
FROM funnel
GROUP BY 1
ORDER BY 1;


WITH funnel AS (SELECT DISTINCT quiz.user_id AS 'user_id',
		CASE WHEN home_try_on.user_id IS NOT NULL
			THEN '1' ELSE '0' 
			END AS 'is_home_try_on',
		CASE WHEN home_try_on.number_of_pairs IS NULL
			THEN '0 pairs' ELSE home_try_on.number_of_pairs
			END AS 'number_of_pairs',
		CASE WHEN purchase.user_id IS NOT NULL
			THEN '1' ELSE '0' END AS 'is_purchase'
	FROM quiz
	LEFT JOIN home_try_on
	ON home_try_on.user_id = quiz.user_id
	LEFT JOIN purchase
	ON purchase.user_id = home_try_on.user_id)
SELECT COUNT(*) AS 'num_quiz',
	SUM(is_home_try_on) AS 'num_home_try_on',
	SUM(is_purchase) AS 'num_purchase',
	1.0 * SUM (is_home_try_on) / COUNT (*) AS 'total_quiz_to_hto',
	1.0 * SUM (is_purchase) / SUM (is_home_try_on) AS 'total_hto_to_purchase',
	1.0 * SUM(is_purchase) / COUNT (*) AS 'overall_conversion'
FROM funnel;


SELECT DISTINCT model_name,
COUNT (*) AS 'frames_purchased'
FROM purchase
GROUP BY 1
ORDER BY 2 DESC;


SELECT fit, count (*) as ‘fit count'
FROM quiz
GROUP BY 1
ORDER BY 2 desc;


SELECT color, count (*) as 'color count'
FROM quiz
GROUP BY 1
ORDER BY 2 desc;
?
?
?