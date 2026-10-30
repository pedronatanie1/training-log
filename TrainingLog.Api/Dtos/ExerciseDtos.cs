namespace TrainingLog.Api.Dtos;

public record MuscleGroupDto(int Id, string Name);
public record ExerciseDto(int Id, string Name, string MuscleGroup);
public record CreateExerciseRequest(string Name, int MuscleGroupId);

