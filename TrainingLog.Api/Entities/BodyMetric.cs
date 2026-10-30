namespace TrainingLog.Api.Entities
{
    public class BodyMetric
    {
        public int Id { get; set; }
        public DateOnly Date { get; set; }
        public decimal WeightKg { get; set; }
    }
}
