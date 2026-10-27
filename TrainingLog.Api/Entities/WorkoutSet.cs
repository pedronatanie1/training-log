namespace TrainingLog.Api.Entities
{
    internal class WorkoutSet
    {
        public int Id { get; set; }
        public int WorkoutId { get; set; }
        public int ExerciseId { get; set; }
        public Exercise? Exercise { get; set; }
        public int SetNumber { get; set; }
        public int? Reps { get; set; }
        public decimal WeightKg { get; set; }
        public int? DurationSeconds { get; set; }
        public decimal? DistanceMetres { get; set; }
    }
}
