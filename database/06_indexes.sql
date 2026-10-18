USE TrainingLog;
GO

-- Foreign keys aren't indexed automatically in SQL Server.
-- These three columns are used often in joins and filters.

-- "All sets of Bench Press": personal records and progress reports
CREATE INDEX ix_sets_exercise
    ON dbo.workout_sets (exercise_id);

-- Date filters and ordering: history, weekly volume, recent workouts
CREATE INDEX ix_workouts_date
    ON dbo.workouts (workout_date);

-- Joining exercises to muscle groups: weekly volume per muscle group
CREATE INDEX ix_exercises_muscle_group
    ON dbo.exercises (muscle_group_id);
GO

-- No index on workout_sets.workout_id: the uq_set unique constraint
-- (workout_id, exercise_id, set_number) already created one that starts with it.
-- body_metrics.metric_date is already indexed by its UNIQUE constraint.
