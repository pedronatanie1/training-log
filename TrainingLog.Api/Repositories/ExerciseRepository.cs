using Microsoft.EntityFrameworkCore;
using TrainingLog.Api.Data;
using TrainingLog.Api.Entities;

namespace TrainingLog.Api.Repositories
{
    public class ExerciseRepository : IExerciseRepository
    {
        private readonly TrainingLogContext _context;

        public ExerciseRepository(TrainingLogContext context)
        {
            _context = context;
        }

        public async Task<List<Exercise>> GetAllAsync()
        {
            return await _context.Exercises
                .Include(e => e.MuscleGroup)
                .AsNoTracking()
                .OrderBy(e => e.Name)
                .ToListAsync();
        }

        public async Task<Exercise?> GetByIdAsync(int id)
        {
            return await _context.Exercises
                .Include(e => e.MuscleGroup)
                .AsNoTracking()
                .FirstOrDefaultAsync(e => e.Id == id);
        }

        public async Task<bool> NameExistsAsync(string name)
        {
            return await _context.Exercises.AnyAsync(e => e.Name == name);
        }

        public async Task<Exercise> AddAsync(Exercise exercise)
        {
            _context.Exercises.Add(exercise);
            await _context.SaveChangesAsync();
            return exercise;
        }
    }
}
