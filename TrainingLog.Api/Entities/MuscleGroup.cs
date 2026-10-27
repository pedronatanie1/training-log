namespace TrainingLog.Api.Entities
{
    internal class MuscleGroup
    {
        public int Id { get; set; }
        public string Name { get; set; } = string.Empty;
        public List<Exercise> Exercises { get; set; } = new();
    }
}
