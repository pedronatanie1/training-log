namespace TrainingLog.Api.Entities
{
    public class Workout
    {
        public int Id { get; set; }
        public DateOnly Date { get; set; }
        public string? Notes { get; set; }
        public List<WorkoutSet> Sets { get; set; } = new();
    }
}
