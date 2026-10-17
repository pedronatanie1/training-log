-- A workout and its sets must be saved together: without a transaction,
-- a failure halfway would leave a workout with only some of its sets.
USE TrainingLog;
GO

SET XACT_ABORT ON;

DECLARE @workout_id INT;
DECLARE @bench INT = 
	(SELECT id FROM dbo.exercises WHERE name = 'Bench Press');

BEGIN TRY
	BEGIN TRANSACTION;

	INSERT INTO dbo.workouts (workout_date, notes)
	VALUES ('2026-10-12', 'Transaction test');

	SET @workout_id = SCOPE_IDENTITY();

	INSERT INTO dbo.workout_sets (workout_id, exercise_id, set_number, reps, weight_kg)
	VALUES 
		(@workout_id, @bench, 1, 8, 35.00),
		(@workout_id, @bench, 2, 8, 35.00),
		(@workout_id, @bench, 3, -5, 35.00);       -- deliberately invalid

	COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION;

	THROW;
END CATCH;
