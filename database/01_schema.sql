CREATE DATABASE TrainingLog;
GO

USE TrainingLog;
GO

CREATE TABLE muscle_groups (
	id INT IDENTITY(1,1) PRIMARY KEY,
	name NVARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE exercises (
	id INT IDENTITY(1,1) PRIMARY KEY,
	name NVARCHAR(100) NOT NULL UNIQUE,
	muscle_group_id INT NOT NULL,
	CONSTRAINT fk_exercises_muscle_group
		FOREIGN KEY (muscle_group_id) 
			REFERENCES muscle_groups(id)
);

CREATE TABLE workouts (
	id INT IDENTITY(1,1) PRIMARY KEY,
	workout_date DATE NOT NULL,
	notes NVARCHAR(500)
);

CREATE TABLE workout_sets (
	id INT IDENTITY(1,1) PRIMARY KEY,
	workout_id INT NOT NULL,
	exercise_id INT NOT NULL,
	set_number INT NOT NULL,
	reps INT NOT NULL,
	weight_kg DECIMAL(6, 2) NOT NULL,
	CONSTRAINT fk_sets_workout
		FOREIGN KEY (workout_id) 
			REFERENCES workouts(id) ON DELETE CASCADE,
	CONSTRAINT fk_sets_exercise
		FOREIGN KEY (exercise_id) 
			REFERENCES exercises(id),
	CONSTRAINT uq_set 
		UNIQUE (workout_id, exercise_id, set_number), 
	CONSTRAINT ck_sets_number 
		CHECK (set_number > 0), 
	CONSTRAINT ck_sets_reps 
		CHECK (reps > 0), 
	CONSTRAINT ck_sets
		CHECK (weight_kg >= 0)
);

CREATE TABLE body_metrics (
	id INT IDENTITY(1,1) PRIMARY KEY,
	metric_date DATE NOT NULL,
	weight_kg DECIMAL(5, 2) NOT NULL,
	CONSTRAINT ck_body_weight
		CHECK (weight_kg BETWEEN 20 AND 400)
);
