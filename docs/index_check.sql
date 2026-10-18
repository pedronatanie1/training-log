-- =====================================================
-- Index check: compare reads and plans before and after
-- creating the indexes in 06_indexes.sql.
-- Turn on "Include Actual Execution Plan" (Ctrl+M) first.
-- =====================================================

USE TrainingLog;
GO

-- -----------------------------------------------------
-- Step 1: remove the indexes to measure "before"
-- (IF EXISTS makes this safe if they don't exist yet)
-- -----------------------------------------------------
DROP INDEX IF EXISTS ix_sets_exercise ON dbo.workout_sets;
DROP INDEX IF EXISTS ix_workouts_date ON dbo.workouts;
GO

SET STATISTICS IO ON;
GO

-- -----------------------------------------------------
-- Step 2: run both queries and note the results
-- Messages tab: "logical reads" per table
-- Execution plan tab: Clustered Index Scan or Index Seek
-- -----------------------------------------------------
DECLARE @bench INT = 
	(SELECT id FROM dbo.exercises WHERE name = 'Bench Press');

-- Query A: all sets of one exercise
SELECT 
	s.id, 
	s.exercise_id
FROM dbo.workout_sets AS s
WHERE s.exercise_id = @bench;

-- Query B: workouts in a date range
SELECT 
	w.id, w.workout_date
FROM dbo.workouts AS w
WHERE w.workout_date BETWEEN '2026-09-28' AND '2026-10-04';
GO

-- -----------------------------------------------------
-- Step 3: recreate the indexes
-- -----------------------------------------------------
CREATE INDEX ix_sets_exercise ON dbo.workout_sets (exercise_id);
CREATE INDEX ix_workouts_date ON dbo.workouts (workout_date);
GO

-- -----------------------------------------------------
-- Step 4: run the same queries again and compare
-- -----------------------------------------------------
DECLARE @bench INT = 
	(SELECT id FROM dbo.exercises WHERE name = 'Bench Press');

SELECT 
	s.id,
	s.exercise_id
FROM dbo.workout_sets AS s
WHERE s.exercise_id = @bench;

SELECT 
	w.id, 
	w.workout_date
FROM dbo.workouts AS w
WHERE w.workout_date BETWEEN '2026-09-28' AND '2026-10-04';
GO

SET STATISTICS IO OFF;
GO
