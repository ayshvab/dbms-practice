-- Упр. 4.22
-- Для составления рейтинга аэропортов учитывается суточная пропускная способность, т.е. среднее
-- количество вылетевших из него и прилитевших в него за сутки пассажиров. Выведите 10 аэропортов
-- с наибольшей суточной пропускной способностью, упорядоченных по убыванию данной величины.

select aircraft_code, avg(count) as average from
(select 
    aircraft_code,
    count(*) as count
    from flights
    group by aircraft_code, date_trunc('day', scheduled_departure)
    order by aircraft_code) as _
group by aircraft_code
order by average DESC
limit 10;

-- Упр. 4.23
-- С целью оценки интенсивности работы обслуживающего персонала аэропорта Шереметьево (SVO) вычислите,
-- сколько раз вылеты следовали друг за другом с перерывом менее пяти минут.
SELECT count(*) as SVO_consecutive_within_five_minutes FROM (
    SELECT 
        departure_airport,
        scheduled_departure,
        scheduled_departure - LAG (scheduled_departure, 1) OVER (
        ORDER BY scheduled_departure ASC
        ) AS delta_time 
    FROM
    flights
    WHERE flights.departure_airport = 'SVO'
) as SVO_departures
WHERE delta_time < interval '5 minute';

-- Упр. 4.24
-- Кол-во рейсов, принятых конкретным аэропортом за каждый день.
-- Напишите представление данного запроса для аэропорта города Барнаул (BAX).
DROP VIEW IF EXISTS arrived_per_day;
CREATE VIEW arrived_per_day AS
SELECT flights.arrival_airport, date_trunc('day', actual_arrival) as day, count(*) AS arrived_count
FROM flights
WHERE flights.actual_arrival IS NOT NULL
GROUP BY flights.arrival_airport, day;

SELECT * FROM arrived_per_day
WHERE arrived_per_day.arrival_airport = 'BAX';
