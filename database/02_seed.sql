USE TrainingLog;
GO

-- =====================================================
-- 02_seed.sql
-- Training Log Database: reference and sample data
-- =====================================================


-- =====================================================
-- 1. MUSCLE GROUPS
-- =====================================================

INSERT INTO dbo.muscle_groups (name)
VALUES
    ('Chest'),
    ('Back'),
    ('Legs'),
    ('Shoulders'),
    ('Arms'),
    ('Core'),
    ('Traps'),
    ('Forearms'),
    ('Calves');
GO

-- =====================================================
-- 2. EXERCISES
-- Each exercise is registered once.
-- =====================================================

INSERT INTO dbo.exercises (name, muscle_group_id)
VALUES
    ('Bench Press',
        (SELECT id FROM muscle_groups WHERE name = 'Chest')),

    ('Incline Dumbbell Press',
        (SELECT id FROM muscle_groups WHERE name = 'Chest')),

    ('Cable Single Arm Press',
        (SELECT id FROM muscle_groups WHERE name = 'Chest')),

    ('Weighted Dips',
        (SELECT id FROM muscle_groups WHERE name = 'Chest')),

    ('Weighted Pull-Ups',
        (SELECT id FROM muscle_groups WHERE name = 'Back')),

    ('Barbell Row',
        (SELECT id FROM muscle_groups WHERE name = 'Back')),

    ('One-Arm Dumbbell Row',
        (SELECT id FROM muscle_groups WHERE name = 'Back')),

    ('Chest-Supported Row',
        (SELECT id FROM muscle_groups WHERE name = 'Back')),

    ('Lat Pulldown',
        (SELECT id FROM muscle_groups WHERE name = 'Back')),

    ('Pull-Up',
        (SELECT id FROM muscle_groups WHERE name = 'Back')),

    ('Chin-Up',
        (SELECT id FROM muscle_groups WHERE name = 'Back')),

    ('Hack Squat',
        (SELECT id FROM muscle_groups WHERE name = 'Legs')),

    ('Front Squat',
        (SELECT id FROM muscle_groups WHERE name = 'Legs')),

    ('Bulgarian Split Squat',
        (SELECT id FROM muscle_groups WHERE name = 'Legs')),

    ('Romanian Deadlift',
        (SELECT id FROM muscle_groups WHERE name = 'Legs')),

    ('Single-Leg Romanian Deadlift',
        (SELECT id FROM muscle_groups WHERE name = 'Legs')),

    ('Leg Curl',
        (SELECT id FROM muscle_groups WHERE name = 'Legs')),

    ('Nordic Curl',
        (SELECT id FROM muscle_groups WHERE name = 'Legs')),

    ('Box Jump',
        (SELECT id FROM muscle_groups WHERE name = 'Legs')),

    ('Kettlebell Swing',
        (SELECT id FROM muscle_groups WHERE name = 'Legs')),

    ('Standing Calf Raise',
        (SELECT id FROM muscle_groups WHERE name = 'Calves')),

    ('Seated Calf Raise',
        (SELECT id FROM muscle_groups WHERE name = 'Calves')),

    ('Tibialis Raise',
        (SELECT id FROM muscle_groups WHERE name = 'Legs')),

    ('Overhead Press',
        (SELECT id FROM muscle_groups WHERE name = 'Shoulders')),

    ('Push Press',
        (SELECT id FROM muscle_groups WHERE name = 'Shoulders')),

    ('Landmine Press',
        (SELECT id FROM muscle_groups WHERE name = 'Shoulders')),

    ('Lateral Raise',
        (SELECT id FROM muscle_groups WHERE name = 'Shoulders')),

    ('Rear-Delt Fly',
        (SELECT id FROM muscle_groups WHERE name = 'Shoulders')),

    ('Face Pull',
        (SELECT id FROM muscle_groups WHERE name = 'Shoulders')),

    ('Cable Y-Raise',
        (SELECT id FROM muscle_groups WHERE name = 'Shoulders')),

    ('Biceps Curl',
        (SELECT id FROM muscle_groups WHERE name = 'Arms')),

    ('Incline Dumbbell Curl',
        (SELECT id FROM muscle_groups WHERE name = 'Arms')),

    ('Hammer Curl',
        (SELECT id FROM muscle_groups WHERE name = 'Arms')),

    ('Reverse Curl',
        (SELECT id FROM muscle_groups WHERE name = 'Forearms')),

    ('Wrist Curl',
        (SELECT id FROM muscle_groups WHERE name = 'Forearms')),

    ('Triceps Pushdown',
        (SELECT id FROM muscle_groups WHERE name = 'Arms')),

    ('Shrugs',
        (SELECT id FROM muscle_groups WHERE name = 'Traps')),

    ('Farmer Carry',
        (SELECT id FROM muscle_groups WHERE name = 'Forearms')),

    ('Plank',
        (SELECT id FROM muscle_groups WHERE name = 'Core')),

    ('Pallof Press',
        (SELECT id FROM muscle_groups WHERE name = 'Core')),

    ('Hanging Leg Raise',
        (SELECT id FROM muscle_groups WHERE name = 'Core')),

    ('Ab Wheel',
        (SELECT id FROM muscle_groups WHERE name = 'Core')),

    ('Cable Woodchopper',
        (SELECT id FROM muscle_groups WHERE name = 'Core')),

    ('Battle Ropes',
        (SELECT id FROM muscle_groups WHERE name = 'Shoulders'));
GO

-- =====================================================
-- 3. WORKOUT SESSIONS
-- Three weeks, five sessions per week.
-- These dates are fictional sample dates.
-- =====================================================

INSERT INTO dbo.workouts (workout_date, notes)
VALUES
    ('2026-09-21', 'Upper Power + Traps'),
    ('2026-09-22', 'Lower + Calves'),
    ('2026-09-23', 'Upper Hypertrophy'),
    ('2026-09-24', 'Athletic Legs + Calves'),
    ('2026-09-25', 'Fighter Physique + Forearms'),

    ('2026-09-28', 'Upper Power + Traps'),
    ('2026-09-29', 'Lower + Calves'),
    ('2026-09-30', 'Upper Hypertrophy'),
    ('2026-10-01', 'Athletic Legs + Calves'),
    ('2026-10-02', 'Fighter Physique + Forearms'),

    ('2026-10-05', 'Upper Power + Traps'),
    ('2026-10-06', 'Lower + Calves'),
    ('2026-10-07', 'Upper Hypertrophy'),
    ('2026-10-08', 'Athletic Legs + Calves'),
    ('2026-10-09', 'Fighter Physique + Forearms');
GO

-- =====================================================
-- 4. WORKOUT SETS
-- Each row represents one exercise set.
--
-- IMPORTANT:
-- This section is populated in the next step using
-- the actual IDs generated by SQL Server.
-- =====================================================


-- =====================================================
-- 5. BODY METRICS
-- Add sample values only if you want sample data.
-- Replace these fictional measurements with actual
-- historical measurements if you intend to track them.
-- =====================================================
