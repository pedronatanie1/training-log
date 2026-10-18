USE TrainingLog;
GO

-- =====================================================
-- 1. Personal record per exercise
-- Heaviest set for each exercise (ties: more reps, then
-- earliest date). Only rep-based sets count.
-- =====================================================

WITH ranked AS (
    SELECT
        e.name AS exercise,
        w.workout_date,
        s.reps,
        s.weight_kg,
        ROW_NUMBER() OVER (
            PARTITION BY e.id
            ORDER BY
                s.weight_kg DESC,
                s.reps DESC,
                w.workout_date ASC
        ) AS rn
    FROM dbo.workout_sets AS s
    JOIN dbo.workouts AS w
        ON w.id = s.workout_id
    JOIN dbo.exercises AS e
        ON e.id = s.exercise_id
    WHERE s.reps IS NOT NULL
)
SELECT
    exercise,
    workout_date,
    reps,
    weight_kg
FROM ranked
WHERE rn = 1
ORDER BY exercise;
GO


-- ==========================================================
-- 2. Bench Press progress over time
-- Best weight per day and the change since the last session.
-- ==========================================================

WITH best_per_day AS (
    SELECT
        w.workout_date,
        MAX(s.weight_kg) AS best_weight
    FROM dbo.workout_sets AS s
    JOIN dbo.workouts AS w
        ON w.id = s.workout_id
    JOIN dbo.exercises AS e
        ON e.id = s.exercise_id
    WHERE e.name = 'Bench Press'
    GROUP BY w.workout_date
)
SELECT
    workout_date,
    best_weight,
    LAG(best_weight) OVER (
        ORDER BY workout_date
    ) AS previous_best,
    best_weight - LAG(best_weight) OVER (
        ORDER BY workout_date
    ) AS change_kg
FROM best_per_day
ORDER BY workout_date;
GO


-- ===========================================================
-- 3. Progress for any exercise
-- Change the name in @exercise to report on another exercise.
-- The DECLARE and the query must stay in the same batch.
-- ===========================================================

DECLARE @exercise NVARCHAR(100) = 'Pendulum Squat';

WITH best_per_day AS (
    SELECT
        w.workout_date,
        MAX(s.weight_kg) AS best_weight
    FROM dbo.workout_sets AS s
    JOIN dbo.workouts AS w
        ON w.id = s.workout_id
    JOIN dbo.exercises AS e
        ON e.id = s.exercise_id
    WHERE e.name = @exercise
    GROUP BY w.workout_date
)
SELECT
    @exercise AS exercise,
    workout_date,
    best_weight,
    LAG(best_weight) OVER (
        ORDER BY workout_date
    ) AS previous_best,
    best_weight - LAG(best_weight) OVER (
        ORDER BY workout_date
    ) AS change_kg
FROM best_per_day
ORDER BY workout_date;
GO


-- =============================================
-- 4. Total body weight change
-- Latest body_metrics entry minus the earliest.
-- =============================================

SELECT
    first_entry.metric_date                         AS first_date,
    first_entry.weight_kg                           AS first_weight_kg,
    last_entry.metric_date                          AS last_date,
    last_entry.weight_kg                            AS last_weight_kg,
    last_entry.weight_kg - first_entry.weight_kg    AS change_kg
FROM (
    SELECT TOP 1
        metric_date,
        weight_kg
    FROM dbo.body_metrics
    ORDER BY metric_date ASC
) AS first_entry
CROSS JOIN (
    SELECT TOP 1
        metric_date,
        weight_kg
    FROM dbo.body_metrics
    ORDER BY metric_date DESC
) AS last_entry;
GO


-- ==============================================================
-- 5. Sessions per week (optional)
-- Number of workouts with at least one logged set, per ISO week.
-- ==============================================================

SELECT
    DATEPART(YEAR, w.workout_date)      AS year_number,
    DATEPART(ISO_WEEK, w.workout_date)  AS week_number,
    COUNT(DISTINCT w.id)                AS sessions
FROM dbo.workouts AS w
JOIN dbo.workout_sets AS s
    ON s.workout_id = w.id
GROUP BY
    DATEPART(YEAR, w.workout_date),
    DATEPART(ISO_WEEK, w.workout_date)
ORDER BY
    year_number,
    week_number;
GO


-- ==========================================================
-- 6. Best timed and distance sets (optional)
-- Longest distance (Farmer Carry) or longest duration
-- (Plank, Battle Ropes) per exercise, using the new columns.
-- ==========================================================

WITH ranked_endurance AS (
    SELECT
        e.name AS exercise,
        w.workout_date,
        s.weight_kg,
        s.distance_metres,
        s.duration_seconds,
        ROW_NUMBER() OVER (
            PARTITION BY e.id
            ORDER BY
                s.distance_metres DESC,
                s.duration_seconds DESC,
                s.weight_kg DESC,
                w.workout_date ASC
        ) AS rn
    FROM dbo.workout_sets AS s
    JOIN dbo.workouts AS w
        ON w.id = s.workout_id
    JOIN dbo.exercises AS e
        ON e.id = s.exercise_id
    WHERE s.reps IS NULL
)
SELECT
    exercise,
    workout_date,
    weight_kg,
    distance_metres,
    duration_seconds
FROM ranked_endurance
WHERE rn = 1
ORDER BY exercise;
GO
