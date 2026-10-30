using Microsoft.EntityFrameworkCore;
using TrainingLog.Api.Entities;

namespace TrainingLog.Api.Data
{
    public class TrainingLogContext : DbContext
    {
        public TrainingLogContext(DbContextOptions<TrainingLogContext> options) : base(options)
        {
        }

        public DbSet<MuscleGroup> MuscleGroups => Set<MuscleGroup>();
        public DbSet<Exercise> Exercises => Set<Exercise>();
        public DbSet<Workout> Workouts => Set<Workout>();
        public DbSet<WorkoutSet> WorkoutSets => Set<WorkoutSet>();
        public DbSet<BodyMetric> BodyMetrics => Set<BodyMetric>();

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<MuscleGroup>(m =>
            {
                m.ToTable("muscle_groups");
                m.Property(x => x.Id).HasColumnName("id");
                m.Property(x => x.Name).HasColumnName("name");
            });

            modelBuilder.Entity<Exercise>(e =>
            {
                e.ToTable("exercises");
                e.Property(x => x.Id).HasColumnName("id");
                e.Property(x => x.Name).HasColumnName("name");
                e.Property(x => x.MuscleGroupId).HasColumnName("muscle_group_id");
                e.HasOne(x => x.MuscleGroup)
                .WithMany(m => m.Exercises)
                .HasForeignKey(x => x.MuscleGroupId)
                .OnDelete(DeleteBehavior.Restrict);
            });

            modelBuilder.Entity<Workout>(w =>
            {
                w.ToTable("workouts");
                w.Property(x => x.Id).HasColumnName("id");
                w.Property(x => x.Date).HasColumnName("workout_date");
                w.Property(x => x.Notes).HasColumnName("notes");
                w.HasMany(x => x.Sets)
                .WithOne()
                .HasForeignKey(s => s.WorkoutId)
                .OnDelete(DeleteBehavior.Cascade);
            });

            modelBuilder.Entity<WorkoutSet>(s =>
            {
                s.ToTable("workout_sets");
                s.Property(x => x.Id).HasColumnName("id");
                s.Property(x => x.WorkoutId).HasColumnName("workout_id");
                s.Property(x => x.ExerciseId).HasColumnName("exercise_id");
                s.Property(x => x.SetNumber).HasColumnName("set_number");
                s.Property(x => x.Reps).HasColumnName("reps");
                s.Property(x => x.WeightKg).HasColumnName("weight_kg").HasPrecision(6, 2);
                s.Property(x => x.DurationSeconds).HasColumnName("duration_seconds");
                s.Property(x =>
                x.DistanceMetres).HasColumnName("distance_metres").HasPrecision(7, 2);
                s.HasOne(x => x.Exercise)
                .WithMany()
                .HasForeignKey(x => x.ExerciseId)
                .OnDelete(DeleteBehavior.Restrict);
            });

            modelBuilder.Entity<BodyMetric>(b =>
            {
                b.ToTable("body_metrics");
                b.Property(x => x.Id).HasColumnName("id");
                b.Property(x => x.Date).HasColumnName("metric_date");
                b.Property(x => x.WeightKg).HasColumnName("weight_kg").HasPrecision(5, 2);
            });
        }
    }
}
