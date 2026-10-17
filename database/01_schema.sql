-- Optional reset: allows re-running every script on a clean database.
USE master;
GO

IF DB_ID('TrainingLog') IS NOT NULL
BEGIN
ALTER DATABASE TrainingLog SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE TrainingLog;
END;
GO

CREATE DATABASE TrainingLog;
GO

USE TrainingLog;
GO

-- =====================================================
-- 1. Muscle Groups
-- Stores the muscle groups targeted by exercises.
-- =====================================================

CREATE TABLE dbo.muscle_groups 
(
    id      INT IDENTITY(1,1)   PRIMARY KEY,
    name    NVARCHAR(50)        NOT NULL UNIQUE
);
GO


-- =====================================================
-- 2. Exercises
-- Each exercise belongs to one muscle group.
-- =====================================================

CREATE TABLE dbo.exercises
(
    id                  INT IDENTITY(1,1)   PRIMARY KEY,
    name                NVARCHAR(100)       NOT NULL UNIQUE,
    muscle_group_id     INT                 NOT NULL,

    CONSTRAINT fk_exercises_muscle_group
        FOREIGN KEY (muscle_group_id) REFERENCES dbo.muscle_groups(id)
);
GO


-- =====================================================
-- 3. Workouts
-- Stores the date and notes for each workout session.
-- =====================================================

CREATE TABLE dbo.workouts
(
    id              INT IDENTITY(1,1)   PRIMARY KEY,
    workout_date    DATE                NOT NULL,
    notes           NVARCHAR(500)       NULL
);
GO


-- =====================================================
-- 4. Workout Sets
-- Stores individual sets performed during workouts.
-- Duration and distance support timed and distance-based
-- exercises in addition to conventional weight training.
-- =====================================================

CREATE TABLE dbo.workout_sets
(
    id                  INT IDENTITY(1,1)   PRIMARY KEY,
    workout_id          INT                 NOT NULL,
    exercise_id         INT                 NOT NULL,
    set_number          INT                 NOT NULL,
    reps                INT                 NULL,
    weight_kg           DECIMAL(6,2)        NOT NULL,
    duration_seconds    INT                 NULL,
    distance_metres     DECIMAL(7,2)        NULL,

    CONSTRAINT fk_sets_workout
        FOREIGN KEY (workout_id)  REFERENCES dbo.workouts(id) ON DELETE CASCADE,
    CONSTRAINT fk_sets_exercise
        FOREIGN KEY (exercise_id) REFERENCES dbo.exercises(id),

    CONSTRAINT uq_set               UNIQUE (workout_id, exercise_id, set_number),

    CONSTRAINT ck_sets_number       CHECK (set_number > 0),
    CONSTRAINT ck_sets_reps         CHECK (reps IS NULL OR reps > 0),
    CONSTRAINT ck_sets_weight       CHECK (weight_kg >= 0),
    CONSTRAINT ck_sets_duration     CHECK (duration_seconds IS NULL OR duration_seconds > 0),
    CONSTRAINT ck_sets_distance     CHECK (distance_metres IS NULL OR distance_metres > 0),
    CONSTRAINT ck_sets_has_measure  CHECK (reps IS NOT NULL
                                           OR duration_seconds IS NOT NULL
                                           OR distance_metres IS NOT NULL)
);
GO


-- =====================================================
-- 5. Body Metrics
-- Stores body-weight measurements over time.
-- =====================================================

CREATE TABLE dbo.body_metrics
(
    id              INT IDENTITY(1,1)   PRIMARY KEY,
    metric_date     DATE                NOT NULL UNIQUE,
    weight_kg       DECIMAL(5,2)        NOT NULL,

    CONSTRAINT ck_body_weight       CHECK (weight_kg BETWEEN 20 AND 400)
);
GO
