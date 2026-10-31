namespace TrainingLog.Api.Dtos;

public record WorkoutSetRequest(
    int ExerciseId,
    int SetNumber,
    int? Reps,
    decimal WeightKg,
    int? DurationSeconds = null,
    decimal? DistanceMetres = null);

public record CreateWorkoutRequest(DateOnly Date, string? Notes, List<WorkoutSetRequest> Sets);

public record WorkoutSetDto(
    int Id,
    int ExerciseId,
    string ExerciseName,
    int SetNumber,
    int? Reps,
    decimal WeightKg,
    int? DurationSeconds,
    decimal? DistanceMetres);

public record WorkoutDto(int Id, DateOnly Date, string? Notes, List<WorkoutSetDto> Sets);

public record SetHistoryRow(
    int ExerciseId,
    string ExerciseName,
    string MuscleGroup,
    DateOnly Date,
    int? Reps,
    decimal WeightKg);
