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

    ('Dips',
        (SELECT id FROM muscle_groups WHERE name = 'Chest')),

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

    ('Pendulum Squat',
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
        (SELECT id FROM muscle_groups WHERE name = 'Calves')),

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

    ('Rocket Shrugs',
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
-- 4. WORKOUT SETS (sample values)
-- Each row represents one exercise set.
-- Weights go up each week so the progress report has something to show.
--
-- IMPORTANT:
-- This section is populated in the next step using
-- the actual IDs generated by SQL Server.
-- =====================================================

-- Assigning variables to each exercise ID for easier reference in the workout sets insertion.

DECLARE @bench INT =
    (SELECT id FROM dbo.exercises WHERE name = 'Bench Press');

DECLARE @weightedPullups INT =
    (SELECT id FROM dbo.exercises WHERE name = 'Pull-Up');

DECLARE @pushPress INT =
    (SELECT id FROM dbo.exercises WHERE name = 'Push Press');

DECLARE @cableSingleArmPress INT =
    (SELECT id FROM dbo.exercises WHERE name = 'Cable Single Arm Press');

DECLARE @oneArmDumbbellRow INT =
    (SELECT id FROM dbo.exercises WHERE name = 'One-Arm Dumbbell Row');

DECLARE @rocketShrugs INT =
    (SELECT id FROM dbo.exercises WHERE name = 'Rocket Shrugs');

DECLARE @lateralRaise INT =
    (SELECT id FROM dbo.exercises WHERE name = 'Lateral Raise');

DECLARE @reverseCurl INT =
    (SELECT id FROM dbo.exercises WHERE name = 'Reverse Curl');

DECLARE @farmerCarry INT =
    (SELECT id FROM dbo.exercises WHERE name = 'Farmer Carry');

DECLARE @pallofPress INT =
    (SELECT id FROM dbo.exercises WHERE name = 'Pallof Press');

DECLARE @boxJumps INT =
    (SELECT id FROM dbo.exercises WHERE name = 'Box Jump');

DECLARE @hackSquat INT =
    (SELECT id FROM dbo.exercises WHERE name = 'Hack Squat');

DECLARE @romanianDeadlift INT =
    (SELECT id FROM dbo.exercises WHERE name = 'Romanian Deadlift');

DECLARE @bulgarianSplitSquat INT =
    (SELECT id FROM dbo.exercises WHERE name = 'Bulgarian Split Squat');

DECLARE @legCurl INT =
    (SELECT id FROM dbo.exercises WHERE name = 'Leg Curl');

DECLARE @nordicCurl INT =
    (SELECT id FROM dbo.exercises WHERE name = 'Nordic Curl');

DECLARE @standingCalfRaise INT =
    (SELECT id FROM dbo.exercises WHERE name = 'Standing Calf Raise');

DECLARE @seatedCalfRaise INT =
    (SELECT id FROM dbo.exercises WHERE name = 'Seated Calf Raise');

DECLARE @tibialisRaise INT =
    (SELECT id FROM dbo.exercises WHERE name = 'Tibialis Raise');

DECLARE @hangingLegRaise INT =
    (SELECT id FROM dbo.exercises WHERE name = 'Hanging Leg Raise');

DECLARE @abWheel INT =
    (SELECT id FROM dbo.exercises WHERE name = 'Ab Wheel');

DECLARE @cableWoodchopper INT =
    (SELECT id FROM dbo.exercises WHERE name = 'Cable Woodchopper');

DECLARE @inclineDumbbellPress INT =
    (SELECT id FROM dbo.exercises WHERE name = 'Incline Dumbbell Press');

DECLARE @chestSupportedRow INT =
    (SELECT id FROM dbo.exercises WHERE name = 'Chest-Supported Row');

DECLARE @latPulldown INT =
    (SELECT id FROM dbo.exercises WHERE name = 'Lat Pulldown');

DECLARE @landminePress INT =
    (SELECT id FROM dbo.exercises WHERE name = 'Landmine Press');

DECLARE @rearDeltFly INT =
    (SELECT id FROM dbo.exercises WHERE name = 'Rear-Delt Fly');

DECLARE @inclineDumbbellCurl INT =
    (SELECT id FROM dbo.exercises WHERE name = 'Incline Dumbbell Curl');

DECLARE @hammerCurl INT =
    (SELECT id FROM dbo.exercises WHERE name = 'Hammer Curl'); 

DECLARE @tricepsPushdown INT =
    (SELECT id FROM dbo.exercises WHERE name = 'Triceps Pushdown');

DECLARE @cableYRaise INT =
    (SELECT id FROM dbo.exercises WHERE name = 'Cable Y-Raise');

DECLARE @pendulumSquat INT =
    (SELECT id FROM dbo.exercises WHERE name = 'Pendulum Squat');

DECLARE @singleLegRomanianDeadlift INT =
    (SELECT id FROM dbo.exercises WHERE name = 'Single-Leg Romanian Deadlift');

DECLARE @kettlebellSwing INT =
    (SELECT id FROM dbo.exercises WHERE name = 'Kettlebell Swing');

DECLARE @battleRopes INT =
    (SELECT id FROM dbo.exercises WHERE name = 'Battle Ropes');

DECLARE @plank INT =
    (SELECT id FROM dbo.exercises WHERE name = 'Plank');

DECLARE @weightedDips INT =
    (SELECT id FROM dbo.exercises WHERE name = 'Dips');

DECLARE @chinups INT =
    (SELECT id FROM dbo.exercises WHERE name = 'Chin-Up');

DECLARE @facePull INT =
    (SELECT id FROM dbo.exercises WHERE name = 'Face Pull');

DECLARE @wristCurl INT =
    (SELECT id FROM dbo.exercises WHERE name = 'Wrist Curl');


-- WORKOUTS

DECLARE @UpperPower INT = 
    (SELECT id FROM dbo.workouts WHERE workout_date = '2026-09-21');

DECLARE @LowerCalves INT = 
    (SELECT id FROM dbo.workouts WHERE workout_date = '2026-09-22');

DECLARE @UpperHypertrophy INT = 
    (SELECT id FROM dbo.workouts WHERE workout_date = '2026-09-23');

DECLARE @AthleticLegs INT = 
    (SELECT id FROM dbo.workouts WHERE workout_date = '2026-09-24');

DECLARE @FighterPhysique INT = 
    (SELECT id FROM dbo.workouts WHERE workout_date = '2026-09-25');

DECLARE @UpperPower2 INT = 
    (SELECT id FROM dbo.workouts WHERE workout_date = '2026-09-28');

DECLARE @LowerCalves2 INT =
    (SELECT id FROM dbo.workouts WHERE workout_date = '2026-09-29');

DECLARE @UpperHypertrophy2 INT =
    (SELECT id FROM dbo.workouts WHERE workout_date = '2026-09-30');

DECLARE @AthleticLegs2 INT =
    (SELECT id FROM dbo.workouts WHERE workout_date = '2026-10-01');

DECLARE @FighterPhysique2 INT =
    (SELECT id FROM dbo.workouts WHERE workout_date = '2026-10-02');

DECLARE @UpperPower3 INT = 
    (SELECT id FROM dbo.workouts WHERE workout_date = '2026-10-05');

DECLARE @LowerCalves3 INT =
    (SELECT id FROM dbo.workouts WHERE workout_date = '2026-10-06');

DECLARE @UpperHypertrophy3 INT =
    (SELECT id FROM dbo.workouts WHERE workout_date = '2026-10-07');

DECLARE @AthleticLegs3 INT =
    (SELECT id FROM dbo.workouts WHERE workout_date = '2026-10-08');

DECLARE @FighterPhysique3 INT =
    (SELECT id FROM dbo.workouts WHERE workout_date = '2026-10-09');


-- Insert workout sets for each workout session here, using the exercise IDs and workout IDs defined above.

-- ---------------- WEEK 1 ----------------

-- Upper Power + Traps (2026-09-21)
INSERT INTO dbo.workout_sets
    (workout_id, exercise_id, set_number, reps, weight_kg, duration_seconds, distance_metres)
VALUES
    (@UpperPower,         @bench,                   1, 5,    100.00, NULL, NULL),
    (@UpperPower,         @bench,                   2, 5,    105.00, NULL, NULL),
    (@UpperPower,         @bench,                   3, 5,    110.00, NULL, NULL),
    (@UpperPower,         @weightedPullups,         1, 6,    10.00,  NULL, NULL),
    (@UpperPower,         @weightedPullups,         2, 6,    10.00,  NULL, NULL),
    (@UpperPower,         @weightedPullups,         3, 6,    10.00,  NULL, NULL),
    (@UpperPower,         @weightedPullups,         4, 5,    10.00,  NULL, NULL),
    (@UpperPower,         @pushPress,               1, 5,    40.00,  NULL, NULL),
    (@UpperPower,         @pushPress,               2, 5,    40.00,  NULL, NULL),
    (@UpperPower,         @pushPress,               3, 5,    40.00,  NULL, NULL),
    (@UpperPower,         @pushPress,               4, 5,    40.00,  NULL, NULL),
    (@UpperPower,         @oneArmDumbbellRow,       1, 10,   24.00,  NULL, NULL),
    (@UpperPower,         @oneArmDumbbellRow,       2, 10,   24.00,  NULL, NULL),
    (@UpperPower,         @oneArmDumbbellRow,       3, 10,   24.00,  NULL, NULL),
    (@UpperPower,         @rocketShrugs,            1, 12,   10.00,  NULL, NULL),
    (@UpperPower,         @rocketShrugs,            2, 12,   10.00,  NULL, NULL),
    (@UpperPower,         @rocketShrugs,            3, 12,   10.00,  NULL, NULL),
    (@UpperPower,         @rocketShrugs,            4, 12,   10.00,  NULL, NULL),
    (@UpperPower,         @farmerCarry,             1, NULL, 16.00,  NULL, 45.00),
    (@UpperPower,         @farmerCarry,             2, NULL, 16.00,  NULL, 45.00),
    (@UpperPower,         @farmerCarry,             3, NULL, 16.00,  NULL, 40.00);

-- Lower + Calves (2026-09-22)
INSERT INTO dbo.workout_sets
    (workout_id, exercise_id, set_number, reps, weight_kg, duration_seconds, distance_metres)
VALUES
    (@LowerCalves,        @boxJumps,                1, 3,    0.00,   NULL, NULL),
    (@LowerCalves,        @boxJumps,                2, 3,    0.00,   NULL, NULL),
    (@LowerCalves,        @boxJumps,                3, 3,    0.00,   NULL, NULL),
    (@LowerCalves,        @boxJumps,                4, 3,    0.00,   NULL, NULL),
    (@LowerCalves,        @hackSquat,               1, 8,    30.00,  NULL, NULL),
    (@LowerCalves,        @hackSquat,               2, 8,    30.00,  NULL, NULL),
    (@LowerCalves,        @hackSquat,               3, 8,    30.00,  NULL, NULL),
    (@LowerCalves,        @hackSquat,               4, 7,    30.00,  NULL, NULL),
    (@LowerCalves,        @romanianDeadlift,        1, 8,    15.00,  NULL, NULL),
    (@LowerCalves,        @romanianDeadlift,        2, 8,    15.00,  NULL, NULL),
    (@LowerCalves,        @romanianDeadlift,        3, 8,    15.00,  NULL, NULL),
    (@LowerCalves,        @standingCalfRaise,       1, 12,   80.00,  NULL, NULL),
    (@LowerCalves,        @standingCalfRaise,       2, 12,   80.00,  NULL, NULL),
    (@LowerCalves,        @standingCalfRaise,       3, 10,   80.00,  NULL, NULL),
    (@LowerCalves,        @standingCalfRaise,       4, 10,   80.00,  NULL, NULL),
    (@LowerCalves,        @hangingLegRaise,         1, 12,   0.00,   NULL, NULL),
    (@LowerCalves,        @hangingLegRaise,         2, 12,   0.00,   NULL, NULL),
    (@LowerCalves,        @hangingLegRaise,         3, 10,   0.00,   NULL, NULL);

-- Upper Hypertrophy (2026-09-23)
INSERT INTO dbo.workout_sets
    (workout_id, exercise_id, set_number, reps, weight_kg, duration_seconds, distance_metres)
VALUES
    (@UpperHypertrophy,   @inclineDumbbellPress,    1, 10,   22.00,  NULL, NULL),
    (@UpperHypertrophy,   @inclineDumbbellPress,    2, 10,   22.00,  NULL, NULL),
    (@UpperHypertrophy,   @inclineDumbbellPress,    3, 9,    22.00,  NULL, NULL),
    (@UpperHypertrophy,   @inclineDumbbellPress,    4, 8,    22.00,  NULL, NULL),
    (@UpperHypertrophy,   @chestSupportedRow,       1, 10,   20.00,  NULL, NULL),
    (@UpperHypertrophy,   @chestSupportedRow,       2, 10,   20.00,  NULL, NULL),
    (@UpperHypertrophy,   @chestSupportedRow,       3, 10,   20.00,  NULL, NULL),
    (@UpperHypertrophy,   @chestSupportedRow,       4, 9,    20.00,  NULL, NULL),
    (@UpperHypertrophy,   @latPulldown,             1, 12,   50.00,  NULL, NULL),
    (@UpperHypertrophy,   @latPulldown,             2, 11,   50.00,  NULL, NULL),
    (@UpperHypertrophy,   @latPulldown,             3, 10,   50.00,  NULL, NULL),
    (@UpperHypertrophy,   @lateralRaise,            1, 15,   10.00,  NULL, NULL),
    (@UpperHypertrophy,   @lateralRaise,            2, 15,   10.00,  NULL, NULL),
    (@UpperHypertrophy,   @lateralRaise,            3, 14,   10.00,  NULL, NULL),
    (@UpperHypertrophy,   @lateralRaise,            4, 12,   10.00,  NULL, NULL),
    (@UpperHypertrophy,   @tricepsPushdown,         1, 12,   25.00,  NULL, NULL),
    (@UpperHypertrophy,   @tricepsPushdown,         2, 12,   25.00,  NULL, NULL),
    (@UpperHypertrophy,   @tricepsPushdown,         3, 10,   25.00,  NULL, NULL);

-- Athletic Legs + Calves (2026-09-24)
INSERT INTO dbo.workout_sets
    (workout_id, exercise_id, set_number, reps, weight_kg, duration_seconds, distance_metres)
VALUES
    (@AthleticLegs,       @pendulumSquat,              1, 6,    10.00,  NULL, NULL),
    (@AthleticLegs,       @pendulumSquat,              2, 6,    10.00,  NULL, NULL),
    (@AthleticLegs,       @pendulumSquat,              3, 6,    10.00,  NULL, NULL),
    (@AthleticLegs,       @pendulumSquat,              4, 6,    10.00,  NULL, NULL),
    (@AthleticLegs,       @bulgarianSplitSquat,     1, 10,   16.00,  NULL, NULL),
    (@AthleticLegs,       @bulgarianSplitSquat,     2, 10,   16.00,  NULL, NULL),
    (@AthleticLegs,       @legCurl,                 1, 10,   52.00,  NULL, NULL),
    (@AthleticLegs,       @legCurl,                 2, 10,   52.00,  NULL, NULL),
    (@AthleticLegs,       @legCurl,                 3, 10,   52.00,  NULL, NULL),
    (@AthleticLegs,       @kettlebellSwing,         1, 15,   16.00,  NULL, NULL),
    (@AthleticLegs,       @kettlebellSwing,         2, 15,   16.00,  NULL, NULL),
    (@AthleticLegs,       @kettlebellSwing,         3, 15,   16.00,  NULL, NULL),
    (@AthleticLegs,       @standingCalfRaise,       1, 15,   80.00,  NULL, NULL),
    (@AthleticLegs,       @standingCalfRaise,       2, 15,   80.00,  NULL, NULL),
    (@AthleticLegs,       @standingCalfRaise,       3, 15,   80.00,  NULL, NULL),
    (@AthleticLegs,       @standingCalfRaise,       4, 15,   80.00,  NULL, NULL),
    (@AthleticLegs,       @plank,                   1, NULL, 0.00,   45,   NULL),
    (@AthleticLegs,       @plank,                   2, NULL, 0.00,   45,   NULL),
    (@AthleticLegs,       @plank,                   3, NULL, 0.00,   40,   NULL);

-- Fighter Physique + Forearms (2026-09-25)
INSERT INTO dbo.workout_sets
    (workout_id, exercise_id, set_number, reps, weight_kg, duration_seconds, distance_metres)
VALUES
    (@FighterPhysique,    @weightedDips,            1, 10,   20.00,  NULL, NULL),
    (@FighterPhysique,    @weightedDips,            2, 10,   20.00,  NULL, NULL),
    (@FighterPhysique,    @weightedDips,            3, 9,    20.00,  NULL, NULL),
    (@FighterPhysique,    @weightedDips,            4, 8,    20.00,  NULL, NULL),
    (@FighterPhysique,    @chinups,                 1, 10,   0.00,   NULL, NULL),
    (@FighterPhysique,    @chinups,                 2, 9,    0.00,   NULL, NULL),
    (@FighterPhysique,    @chinups,                 3, 8,    0.00,   NULL, NULL),
    (@FighterPhysique,    @chinups,                 4, 8,    0.00,   NULL, NULL),
    (@FighterPhysique,    @oneArmDumbbellRow,       1, 12,   30.00,  NULL, NULL),
    (@FighterPhysique,    @oneArmDumbbellRow,       2, 12,   30.00,  NULL, NULL),
    (@FighterPhysique,    @oneArmDumbbellRow,       3, 12,   30.00,  NULL, NULL),
    (@FighterPhysique,    @facePull,                1, 15,   10.00,  NULL, NULL),
    (@FighterPhysique,    @facePull,                2, 15,   10.00,  NULL, NULL),
    (@FighterPhysique,    @facePull,                3, 15,   10.00,  NULL, NULL),
    (@FighterPhysique,    @farmerCarry,             1, NULL, 16.00,  NULL, 45.00),
    (@FighterPhysique,    @farmerCarry,             2, NULL, 16.00,  NULL, 45.00),
    (@FighterPhysique,    @farmerCarry,             3, NULL, 16.00,  NULL, 45.00),
    (@FighterPhysique,    @farmerCarry,             4, NULL, 16.00,  NULL, 40.00),
    (@FighterPhysique,    @battleRopes,             1, NULL, 0.00,   20,   NULL),
    (@FighterPhysique,    @battleRopes,             2, NULL, 0.00,   20,   NULL),
    (@FighterPhysique,    @battleRopes,             3, NULL, 0.00,   20,   NULL),
    (@FighterPhysique,    @battleRopes,             4, NULL, 0.00,   20,   NULL),
    (@FighterPhysique,    @battleRopes,             5, NULL, 0.00,   20,   NULL),
    (@FighterPhysique,    @battleRopes,             6, NULL, 0.00,   20,   NULL),
    (@FighterPhysique,    @battleRopes,             7, NULL, 0.00,   20,   NULL),
    (@FighterPhysique,    @battleRopes,             8, NULL, 0.00,   20,   NULL);

-- ---------------- WEEK 2 ----------------

-- Upper Power + Traps (2026-09-28)
INSERT INTO dbo.workout_sets
    (workout_id, exercise_id, set_number, reps, weight_kg, duration_seconds, distance_metres)
VALUES
    (@UpperPower2,        @bench,                   1, 5,    102.50, NULL, NULL),
    (@UpperPower2,        @bench,                   2, 5,    107.50, NULL, NULL),
    (@UpperPower2,        @bench,                   3, 5,    112.50, NULL, NULL),
    (@UpperPower2,        @weightedPullups,         1, 6,    12.50,  NULL, NULL),
    (@UpperPower2,        @weightedPullups,         2, 6,    12.50,  NULL, NULL),
    (@UpperPower2,        @weightedPullups,         3, 6,    12.50,  NULL, NULL),
    (@UpperPower2,        @weightedPullups,         4, 5,    12.50,  NULL, NULL),
    (@UpperPower2,        @pushPress,               1, 5,    42.50,  NULL, NULL),
    (@UpperPower2,        @pushPress,               2, 5,    42.50,  NULL, NULL),
    (@UpperPower2,        @pushPress,               3, 5,    42.50,  NULL, NULL),
    (@UpperPower2,        @pushPress,               4, 5,    42.50,  NULL, NULL),
    (@UpperPower2,        @oneArmDumbbellRow,       1, 10,   26.00,  NULL, NULL),
    (@UpperPower2,        @oneArmDumbbellRow,       2, 10,   26.00,  NULL, NULL),
    (@UpperPower2,        @oneArmDumbbellRow,       3, 10,   26.00,  NULL, NULL),
    (@UpperPower2,        @rocketShrugs,            1, 12,   10.00,  NULL, NULL),
    (@UpperPower2,        @rocketShrugs,            2, 12,   10.00,  NULL, NULL),
    (@UpperPower2,        @rocketShrugs,            3, 12,   10.00,  NULL, NULL),
    (@UpperPower2,        @rocketShrugs,            4, 12,   10.00,  NULL, NULL),
    (@UpperPower2,        @farmerCarry,             1, NULL, 18.00,  NULL, 45.00),
    (@UpperPower2,        @farmerCarry,             2, NULL, 18.00,  NULL, 45.00),
    (@UpperPower2,        @farmerCarry,             3, NULL, 18.00,  NULL, 40.00);

-- Lower + Calves (2026-09-29)
INSERT INTO dbo.workout_sets
    (workout_id, exercise_id, set_number, reps, weight_kg, duration_seconds, distance_metres)
VALUES
    (@LowerCalves2,       @boxJumps,                1, 3,    0.00,   NULL, NULL),
    (@LowerCalves2,       @boxJumps,                2, 3,    0.00,   NULL, NULL),
    (@LowerCalves2,       @boxJumps,                3, 3,    0.00,   NULL, NULL),
    (@LowerCalves2,       @boxJumps,                4, 3,    0.00,   NULL, NULL),
    (@LowerCalves2,       @hackSquat,               1, 8,    35.00,  NULL, NULL),
    (@LowerCalves2,       @hackSquat,               2, 8,    35.00,  NULL, NULL),
    (@LowerCalves2,       @hackSquat,               3, 8,    35.00,  NULL, NULL),
    (@LowerCalves2,       @hackSquat,               4, 7,    35.00,  NULL, NULL),
    (@LowerCalves2,       @romanianDeadlift,        1, 8,    17.50,  NULL, NULL),
    (@LowerCalves2,       @romanianDeadlift,        2, 8,    17.50,  NULL, NULL),
    (@LowerCalves2,       @romanianDeadlift,        3, 8,    17.50,  NULL, NULL),
    (@LowerCalves2,       @standingCalfRaise,       1, 12,   85.00,  NULL, NULL),
    (@LowerCalves2,       @standingCalfRaise,       2, 12,   85.00,  NULL, NULL),
    (@LowerCalves2,       @standingCalfRaise,       3, 10,   85.00,  NULL, NULL),
    (@LowerCalves2,       @standingCalfRaise,       4, 10,   85.00,  NULL, NULL),
    (@LowerCalves2,       @hangingLegRaise,         1, 12,   0.00,   NULL, NULL),
    (@LowerCalves2,       @hangingLegRaise,         2, 12,   0.00,   NULL, NULL),
    (@LowerCalves2,       @hangingLegRaise,         3, 10,   0.00,   NULL, NULL);

-- Upper Hypertrophy (2026-09-30)
INSERT INTO dbo.workout_sets
    (workout_id, exercise_id, set_number, reps, weight_kg, duration_seconds, distance_metres)
VALUES
    (@UpperHypertrophy2,  @inclineDumbbellPress,    1, 10,   24.00,  NULL, NULL),
    (@UpperHypertrophy2,  @inclineDumbbellPress,    2, 10,   24.00,  NULL, NULL),
    (@UpperHypertrophy2,  @inclineDumbbellPress,    3, 9,    24.00,  NULL, NULL),
    (@UpperHypertrophy2,  @inclineDumbbellPress,    4, 8,    24.00,  NULL, NULL),
    (@UpperHypertrophy2,  @chestSupportedRow,       1, 10,   22.00,  NULL, NULL),
    (@UpperHypertrophy2,  @chestSupportedRow,       2, 10,   22.00,  NULL, NULL),
    (@UpperHypertrophy2,  @chestSupportedRow,       3, 10,   22.00,  NULL, NULL),
    (@UpperHypertrophy2,  @chestSupportedRow,       4, 9,    22.00,  NULL, NULL),
    (@UpperHypertrophy2,  @latPulldown,             1, 12,   52.50,  NULL, NULL),
    (@UpperHypertrophy2,  @latPulldown,             2, 11,   52.50,  NULL, NULL),
    (@UpperHypertrophy2,  @latPulldown,             3, 10,   52.50,  NULL, NULL),
    (@UpperHypertrophy2,  @lateralRaise,            1, 15,   10.00,  NULL, NULL),
    (@UpperHypertrophy2,  @lateralRaise,            2, 15,   10.00,  NULL, NULL),
    (@UpperHypertrophy2,  @lateralRaise,            3, 14,   10.00,  NULL, NULL),
    (@UpperHypertrophy2,  @lateralRaise,            4, 12,   10.00,  NULL, NULL),
    (@UpperHypertrophy2,  @tricepsPushdown,         1, 12,   27.50,  NULL, NULL),
    (@UpperHypertrophy2,  @tricepsPushdown,         2, 12,   27.50,  NULL, NULL),
    (@UpperHypertrophy2,  @tricepsPushdown,         3, 10,   27.50,  NULL, NULL);

-- Athletic Legs + Calves (2026-10-01)
INSERT INTO dbo.workout_sets
    (workout_id, exercise_id, set_number, reps, weight_kg, duration_seconds, distance_metres)
VALUES
    (@AthleticLegs2,      @pendulumSquat,              1, 6,    12.50,  NULL, NULL),
    (@AthleticLegs2,      @pendulumSquat,              2, 6,    12.50,  NULL, NULL),
    (@AthleticLegs2,      @pendulumSquat,              3, 6,    12.50,  NULL, NULL),
    (@AthleticLegs2,      @pendulumSquat,              4, 6,    12.50,  NULL, NULL),
    (@AthleticLegs2,      @bulgarianSplitSquat,     1, 10,   18.00,  NULL, NULL),
    (@AthleticLegs2,      @bulgarianSplitSquat,     2, 10,   18.00,  NULL, NULL),
    (@AthleticLegs2,      @legCurl,                 1, 10,   54.50,  NULL, NULL),
    (@AthleticLegs2,      @legCurl,                 2, 10,   54.50,  NULL, NULL),
    (@AthleticLegs2,      @legCurl,                 3, 10,   54.50,  NULL, NULL),
    (@AthleticLegs2,      @kettlebellSwing,         1, 15,   16.00,  NULL, NULL),
    (@AthleticLegs2,      @kettlebellSwing,         2, 15,   16.00,  NULL, NULL),
    (@AthleticLegs2,      @kettlebellSwing,         3, 15,   16.00,  NULL, NULL),
    (@AthleticLegs2,      @standingCalfRaise,       1, 15,   85.00,  NULL, NULL),
    (@AthleticLegs2,      @standingCalfRaise,       2, 15,   85.00,  NULL, NULL),
    (@AthleticLegs2,      @standingCalfRaise,       3, 15,   85.00,  NULL, NULL),
    (@AthleticLegs2,      @standingCalfRaise,       4, 15,   85.00,  NULL, NULL),
    (@AthleticLegs2,      @plank,                   1, NULL, 0.00,   45,   NULL),
    (@AthleticLegs2,      @plank,                   2, NULL, 0.00,   45,   NULL),
    (@AthleticLegs2,      @plank,                   3, NULL, 0.00,   40,   NULL);

-- Fighter Physique + Forearms (2026-10-02)
INSERT INTO dbo.workout_sets
    (workout_id, exercise_id, set_number, reps, weight_kg, duration_seconds, distance_metres)
VALUES
    (@FighterPhysique2,   @weightedDips,            1, 10,   22.50,  NULL, NULL),
    (@FighterPhysique2,   @weightedDips,            2, 10,   22.50,  NULL, NULL),
    (@FighterPhysique2,   @weightedDips,            3, 9,    22.50,  NULL, NULL),
    (@FighterPhysique2,   @weightedDips,            4, 8,    22.50,  NULL, NULL),
    (@FighterPhysique2,   @chinups,                 1, 10,   0.00,   NULL, NULL),
    (@FighterPhysique2,   @chinups,                 2, 9,    0.00,   NULL, NULL),
    (@FighterPhysique2,   @chinups,                 3, 8,    0.00,   NULL, NULL),
    (@FighterPhysique2,   @chinups,                 4, 8,    0.00,   NULL, NULL),
    (@FighterPhysique2,   @oneArmDumbbellRow,       1, 12,   32.00,  NULL, NULL),
    (@FighterPhysique2,   @oneArmDumbbellRow,       2, 12,   32.00,  NULL, NULL),
    (@FighterPhysique2,   @oneArmDumbbellRow,       3, 12,   32.00,  NULL, NULL),
    (@FighterPhysique2,   @facePull,                1, 15,   10.00,  NULL, NULL),
    (@FighterPhysique2,   @facePull,                2, 15,   10.00,  NULL, NULL),
    (@FighterPhysique2,   @facePull,                3, 15,   10.00,  NULL, NULL),
    (@FighterPhysique2,   @farmerCarry,             1, NULL, 18.00,  NULL, 45.00),
    (@FighterPhysique2,   @farmerCarry,             2, NULL, 18.00,  NULL, 45.00),
    (@FighterPhysique2,   @farmerCarry,             3, NULL, 18.00,  NULL, 45.00),
    (@FighterPhysique2,   @farmerCarry,             4, NULL, 18.00,  NULL, 40.00),
    (@FighterPhysique2,   @battleRopes,             1, NULL, 0.00,   20,   NULL),
    (@FighterPhysique2,   @battleRopes,             2, NULL, 0.00,   20,   NULL),
    (@FighterPhysique2,   @battleRopes,             3, NULL, 0.00,   20,   NULL),
    (@FighterPhysique2,   @battleRopes,             4, NULL, 0.00,   20,   NULL),
    (@FighterPhysique2,   @battleRopes,             5, NULL, 0.00,   20,   NULL),
    (@FighterPhysique2,   @battleRopes,             6, NULL, 0.00,   20,   NULL),
    (@FighterPhysique2,   @battleRopes,             7, NULL, 0.00,   20,   NULL),
    (@FighterPhysique2,   @battleRopes,             8, NULL, 0.00,   20,   NULL);

-- ---------------- WEEK 3 ----------------

-- Upper Power + Traps (2026-10-05)
INSERT INTO dbo.workout_sets
    (workout_id, exercise_id, set_number, reps, weight_kg, duration_seconds, distance_metres)
VALUES
    (@UpperPower3,        @bench,                   1, 5,    105.00, NULL, NULL),
    (@UpperPower3,        @bench,                   2, 5,    110.00, NULL, NULL),
    (@UpperPower3,        @bench,                   3, 5,    115.00, NULL, NULL),
    (@UpperPower3,        @weightedPullups,         1, 6,    15.00,  NULL, NULL),
    (@UpperPower3,        @weightedPullups,         2, 6,    15.00,  NULL, NULL),
    (@UpperPower3,        @weightedPullups,         3, 6,    15.00,  NULL, NULL),
    (@UpperPower3,        @weightedPullups,         4, 5,    15.00,  NULL, NULL),
    (@UpperPower3,        @pushPress,               1, 5,    45.00,  NULL, NULL),
    (@UpperPower3,        @pushPress,               2, 5,    45.00,  NULL, NULL),
    (@UpperPower3,        @pushPress,               3, 5,    45.00,  NULL, NULL),
    (@UpperPower3,        @pushPress,               4, 5,    45.00,  NULL, NULL),
    (@UpperPower3,        @oneArmDumbbellRow,       1, 10,   28.00,  NULL, NULL),
    (@UpperPower3,        @oneArmDumbbellRow,       2, 10,   28.00,  NULL, NULL),
    (@UpperPower3,        @oneArmDumbbellRow,       3, 10,   28.00,  NULL, NULL),
    (@UpperPower3,        @rocketShrugs,            1, 12,   10.00,  NULL, NULL),
    (@UpperPower3,        @rocketShrugs,            2, 12,   10.00,  NULL, NULL),
    (@UpperPower3,        @rocketShrugs,            3, 12,   10.00,  NULL, NULL),
    (@UpperPower3,        @rocketShrugs,            4, 12,   10.00,  NULL, NULL),
    (@UpperPower3,        @farmerCarry,             1, NULL, 20.00,  NULL, 45.00),
    (@UpperPower3,        @farmerCarry,             2, NULL, 20.00,  NULL, 45.00),
    (@UpperPower3,        @farmerCarry,             3, NULL, 20.00,  NULL, 40.00);

-- Lower + Calves (2026-10-06)
INSERT INTO dbo.workout_sets
    (workout_id, exercise_id, set_number, reps, weight_kg, duration_seconds, distance_metres)
VALUES
    (@LowerCalves3,       @boxJumps,                1, 3,    0.00,   NULL, NULL),
    (@LowerCalves3,       @boxJumps,                2, 3,    0.00,   NULL, NULL),
    (@LowerCalves3,       @boxJumps,                3, 3,    0.00,   NULL, NULL),
    (@LowerCalves3,       @boxJumps,                4, 3,    0.00,   NULL, NULL),
    (@LowerCalves3,       @hackSquat,               1, 8,    40.00,  NULL, NULL),
    (@LowerCalves3,       @hackSquat,               2, 8,    40.00,  NULL, NULL),
    (@LowerCalves3,       @hackSquat,               3, 8,    40.00,  NULL, NULL),
    (@LowerCalves3,       @hackSquat,               4, 7,    40.00,  NULL, NULL),
    (@LowerCalves3,       @romanianDeadlift,        1, 8,    20.00,  NULL, NULL),
    (@LowerCalves3,       @romanianDeadlift,        2, 8,    20.00,  NULL, NULL),
    (@LowerCalves3,       @romanianDeadlift,        3, 8,    20.00,  NULL, NULL),
    (@LowerCalves3,       @standingCalfRaise,       1, 12,   90.00,  NULL, NULL),
    (@LowerCalves3,       @standingCalfRaise,       2, 12,   90.00,  NULL, NULL),
    (@LowerCalves3,       @standingCalfRaise,       3, 10,   90.00,  NULL, NULL),
    (@LowerCalves3,       @standingCalfRaise,       4, 10,   90.00,  NULL, NULL),
    (@LowerCalves3,       @hangingLegRaise,         1, 12,   0.00,   NULL, NULL),
    (@LowerCalves3,       @hangingLegRaise,         2, 12,   0.00,   NULL, NULL),
    (@LowerCalves3,       @hangingLegRaise,         3, 10,   0.00,   NULL, NULL);

-- Upper Hypertrophy (2026-10-07)
INSERT INTO dbo.workout_sets
    (workout_id, exercise_id, set_number, reps, weight_kg, duration_seconds, distance_metres)
VALUES
    (@UpperHypertrophy3,  @inclineDumbbellPress,    1, 10,   26.00,  NULL, NULL),
    (@UpperHypertrophy3,  @inclineDumbbellPress,    2, 10,   26.00,  NULL, NULL),
    (@UpperHypertrophy3,  @inclineDumbbellPress,    3, 9,    26.00,  NULL, NULL),
    (@UpperHypertrophy3,  @inclineDumbbellPress,    4, 8,    26.00,  NULL, NULL),
    (@UpperHypertrophy3,  @chestSupportedRow,       1, 10,   24.00,  NULL, NULL),
    (@UpperHypertrophy3,  @chestSupportedRow,       2, 10,   24.00,  NULL, NULL),
    (@UpperHypertrophy3,  @chestSupportedRow,       3, 10,   24.00,  NULL, NULL),
    (@UpperHypertrophy3,  @chestSupportedRow,       4, 9,    24.00,  NULL, NULL),
    (@UpperHypertrophy3,  @latPulldown,             1, 12,   55.00,  NULL, NULL),
    (@UpperHypertrophy3,  @latPulldown,             2, 11,   55.00,  NULL, NULL),
    (@UpperHypertrophy3,  @latPulldown,             3, 10,   55.00,  NULL, NULL),
    (@UpperHypertrophy3,  @lateralRaise,            1, 15,   10.00,  NULL, NULL),
    (@UpperHypertrophy3,  @lateralRaise,            2, 15,   10.00,  NULL, NULL),
    (@UpperHypertrophy3,  @lateralRaise,            3, 14,   10.00,  NULL, NULL),
    (@UpperHypertrophy3,  @lateralRaise,            4, 12,   10.00,  NULL, NULL),
    (@UpperHypertrophy3,  @tricepsPushdown,         1, 12,   30.00,  NULL, NULL),
    (@UpperHypertrophy3,  @tricepsPushdown,         2, 12,   30.00,  NULL, NULL),
    (@UpperHypertrophy3,  @tricepsPushdown,         3, 10,   30.00,  NULL, NULL);

-- Athletic Legs + Calves (2026-10-08)
INSERT INTO dbo.workout_sets
    (workout_id, exercise_id, set_number, reps, weight_kg, duration_seconds, distance_metres)
VALUES
    (@AthleticLegs3,      @pendulumSquat,              1, 6,    15.00,  NULL, NULL),
    (@AthleticLegs3,      @pendulumSquat,              2, 6,    15.00,  NULL, NULL),
    (@AthleticLegs3,      @pendulumSquat,              3, 6,    15.00,  NULL, NULL),
    (@AthleticLegs3,      @pendulumSquat,              4, 6,    15.00,  NULL, NULL),
    (@AthleticLegs3,      @bulgarianSplitSquat,     1, 10,   20.00,  NULL, NULL),
    (@AthleticLegs3,      @bulgarianSplitSquat,     2, 10,   20.00,  NULL, NULL),
    (@AthleticLegs3,      @legCurl,                 1, 10,   57.00,  NULL, NULL),
    (@AthleticLegs3,      @legCurl,                 2, 10,   57.00,  NULL, NULL),
    (@AthleticLegs3,      @legCurl,                 3, 10,   57.00,  NULL, NULL),
    (@AthleticLegs3,      @kettlebellSwing,         1, 15,   16.00,  NULL, NULL),
    (@AthleticLegs3,      @kettlebellSwing,         2, 15,   16.00,  NULL, NULL),
    (@AthleticLegs3,      @kettlebellSwing,         3, 15,   16.00,  NULL, NULL),
    (@AthleticLegs3,      @standingCalfRaise,       1, 15,   90.00,  NULL, NULL),
    (@AthleticLegs3,      @standingCalfRaise,       2, 15,   90.00,  NULL, NULL),
    (@AthleticLegs3,      @standingCalfRaise,       3, 15,   90.00,  NULL, NULL),
    (@AthleticLegs3,      @standingCalfRaise,       4, 15,   90.00,  NULL, NULL),
    (@AthleticLegs3,      @plank,                   1, NULL, 0.00,   45,   NULL),
    (@AthleticLegs3,      @plank,                   2, NULL, 0.00,   45,   NULL),
    (@AthleticLegs3,      @plank,                   3, NULL, 0.00,   40,   NULL);

-- Fighter Physique + Forearms (2026-10-09)
INSERT INTO dbo.workout_sets
    (workout_id, exercise_id, set_number, reps, weight_kg, duration_seconds, distance_metres)
VALUES
    (@FighterPhysique3,   @weightedDips,            1, 10,   25.00,  NULL, NULL),
    (@FighterPhysique3,   @weightedDips,            2, 10,   25.00,  NULL, NULL),
    (@FighterPhysique3,   @weightedDips,            3, 9,    25.00,  NULL, NULL),
    (@FighterPhysique3,   @weightedDips,            4, 8,    25.00,  NULL, NULL),
    (@FighterPhysique3,   @chinups,                 1, 10,   0.00,   NULL, NULL),
    (@FighterPhysique3,   @chinups,                 2, 9,    0.00,   NULL, NULL),
    (@FighterPhysique3,   @chinups,                 3, 8,    0.00,   NULL, NULL),
    (@FighterPhysique3,   @chinups,                 4, 8,    0.00,   NULL, NULL),
    (@FighterPhysique3,   @oneArmDumbbellRow,       1, 12,   34.00,  NULL, NULL),
    (@FighterPhysique3,   @oneArmDumbbellRow,       2, 12,   34.00,  NULL, NULL),
    (@FighterPhysique3,   @oneArmDumbbellRow,       3, 12,   34.00,  NULL, NULL),
    (@FighterPhysique3,   @facePull,                1, 15,   10.00,  NULL, NULL),
    (@FighterPhysique3,   @facePull,                2, 15,   10.00,  NULL, NULL),
    (@FighterPhysique3,   @facePull,                3, 15,   10.00,  NULL, NULL),
    (@FighterPhysique3,   @farmerCarry,             1, NULL, 20.00,  NULL, 45.00),
    (@FighterPhysique3,   @farmerCarry,             2, NULL, 20.00,  NULL, 45.00),
    (@FighterPhysique3,   @farmerCarry,             3, NULL, 20.00,  NULL, 45.00),
    (@FighterPhysique3,   @farmerCarry,             4, NULL, 20.00,  NULL, 40.00),
    (@FighterPhysique3,   @battleRopes,             1, NULL, 0.00,   20,   NULL),
    (@FighterPhysique3,   @battleRopes,             2, NULL, 0.00,   20,   NULL),
    (@FighterPhysique3,   @battleRopes,             3, NULL, 0.00,   20,   NULL),
    (@FighterPhysique3,   @battleRopes,             4, NULL, 0.00,   20,   NULL),
    (@FighterPhysique3,   @battleRopes,             5, NULL, 0.00,   20,   NULL),
    (@FighterPhysique3,   @battleRopes,             6, NULL, 0.00,   20,   NULL),
    (@FighterPhysique3,   @battleRopes,             7, NULL, 0.00,   20,   NULL),
    (@FighterPhysique3,   @battleRopes,             8, NULL, 0.00,   20,   NULL);


-- =====================================================
-- 5. BODY METRICS
-- =====================================================

INSERT INTO dbo.body_metrics (metric_date, weight_kg)
VALUES
    ('2026-09-21', 82.40),
    ('2026-09-28', 82.10),
    ('2026-10-05', 82.60);
GO
