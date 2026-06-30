-- 1. WHERE: deliveries where the batter scored a boundary (4 or 6 runs)
SELECT batter, batting_team, runs_scored FROM ipl WHERE is_boundary = 1;

-- 2. GROUP BY: total runs scored per team
SELECT batting_team, SUM(runs_scored) AS total_runs FROM ipl GROUP BY batting_team ORDER BY total_runs DESC;

-- 3. ORDER BY DESC: top 10 batters by total runs scored
SELECT batter, SUM(runs_scored) AS total_runs FROM ipl GROUP BY batter ORDER BY total_runs DESC LIMIT 10;

-- 4. HAVING: teams averaging over 1.5 runs per delivery
SELECT batting_team, AVG(runs_scored) AS avg_runs FROM ipl GROUP BY batting_team HAVING AVG(runs_scored) > 1.5;

-- 5. LIKE/BETWEEN: deliveries from seasons 2015-2020 by batters with names starting with 'S'
SELECT batter, season, runs_scored FROM ipl WHERE season BETWEEN 2015 AND 2020 AND batter LIKE 'S%';

-- 6. Advanced: bowler with the most wickets taken per team, using subquery
SELECT bowling_team, bowler, COUNT(*) AS wickets
FROM ipl t1
WHERE wicket_taken = 1
GROUP BY bowling_team, bowler
HAVING COUNT(*) = (
    SELECT MAX(wicket_count) FROM (
        SELECT bowler, COUNT(*) AS wicket_count
        FROM ipl t2
        WHERE wicket_taken = 1 AND t2.bowling_team = t1.bowling_team
        GROUP BY bowler
    )
);