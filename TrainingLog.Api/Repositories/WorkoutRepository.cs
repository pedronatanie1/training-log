using Microsoft.EntityFrameworkCore;
using TrainingLog.Api.Data;
using TrainingLog.Api.Dtos;
using TrainingLog.Api.Entities;

namespace TrainingLog.Api.Repositories
{
    public class WorkoutRepository : IWorkoutRepository
    {
        private readonly TrainingLogContext _context;

        public WorkoutRepository(TrainingLogContext context)
        {
            _context = context;
        }

        public async Task<Workout> AddAsync(Workout workout)
        {
            _context.Workouts.Add(workout);
            await _context.SaveChangesAsync();
            return workout;
        }

        public async Task<Workout?> GetByIdAsync(int id)
        {
            return await _context.Workouts
                .Include(w => w.Sets)
                    .ThenInclude(s => s.Exercise)
                .AsNoTracking()
                .FirstOrDefaultAsync(w => w.Id == id);
        }

        public async Task<List<Workout>> GetRecentAsync(int count)
        {
            return await _context.Workouts
                .Include(w => w.Sets)
                    .ThenInclude(s => s.Exercise)
                .AsNoTracking()
                .OrderByDescending(w => w.Date)
                .ThenByDescending(w => w.Id)
                .Take(count)
                .ToListAsync();
        }

        public async Task<bool> DeleteAsync(int id)
        {
            var workout = await _context.Workouts.FindAsync(id);

            if (workout is null)
            {
                return false;
            }

            _context.Workouts.Remove(workout);
            await _context.SaveChangesAsync();
            return true;
        }

        public async Task<List<SetHistoryRow>> GetSetHistoryAsync()
        {
            return await (from s in _context.WorkoutSets
                          join w in _context.Workouts on s.WorkoutId equals w.Id
                          join e in _context.Exercises on s.ExerciseId equals e.Id
                          select new SetHistoryRow(e.Id, e.Name, e.MuscleGroup!.Name,
                                                   w.Date, s.Reps, s.WeightKg))
                .AsNoTracking()
                .ToListAsync();
        }
    }
}