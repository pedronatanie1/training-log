namespace TrainingLog.Api.Dtos
{
    internal class ExerciseDtos
    {
        public record MuscleGroupDTO(int Id, string Name);
        public record ExerciseDTO(int Id, string Name, string MuscleGroup);
        public record CreateExerciseRequest(string Name, int MuscleGroupId);
    }
}
