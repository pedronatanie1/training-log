namespace TrainingLog.Api.Entities
{
    internal class Exercise
    {
        public int Id { get; set; }
        public string Name { get; set; } = string.Empty;
        public int MuscleGroupId { get; set; }
        public MuscleGroup? MuscleGroup { get; set; }
    }
}
