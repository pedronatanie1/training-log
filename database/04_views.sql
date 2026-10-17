USE TrainingLog;
GO

CREATE OR ALTER VIEW dbo.vw_workout_history AS 
SELECT 
	w.id                                    AS workout_id,
	w.workout_date,
	w.notes,
	COUNT(s.id)                             AS total_sets,
	COUNT(DISTINCT s.exercise_id)           AS exercises_done,
	ISNULL(SUM(s.reps * s.weight_kg), 0)    AS total_volume_kg,
	SUM(s.duration_seconds)                 AS total_duration_seconds,
	SUM(s.distance_metres)                  AS total_distance_metres
FROM dbo.workouts w
JOIN dbo.workout_sets s ON s.workout_id = w.id
GROUP BY 
	w.id, 
	w.workout_date, 
	w.notes;
GO

CREATE OR ALTER VIEW dbo.vw_weekly_volume AS
SELECT
	DATEPART(YEAR, w.workout_date)          AS year_number,
	DATEPART(ISO_WEEK, w.workout_date)      AS week_number,
	mg.name                                 AS muscle_group,
	ISNULL(SUM(s.reps * s.weight_kg), 0)    AS volume_kg
FROM dbo.workout_sets s
JOIN dbo.workouts w       ON w.id = s.workout_id
JOIN dbo.exercises e      ON e.id = s.exercise_id
JOIN dbo.muscle_groups mg ON mg.id = e.muscle_group_id
GROUP BY 
	DATEPART(YEAR, w.workout_date), 
	DATEPART(ISO_WEEK, w.workout_date), 
	mg.name;
GO
