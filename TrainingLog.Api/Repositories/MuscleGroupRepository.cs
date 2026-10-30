using Microsoft.EntityFrameworkCore;
using TrainingLog.Api.Data;
using TrainingLog.Api.Entities;

namespace TrainingLog.Api.Repositories
{
    public class MuscleGroupRepository : IMuscleGroupRepository
    {
        private readonly TrainingLogContext _context;

        public MuscleGroupRepository(TrainingLogContext context)
        {
            _context = context;
        }

        public async Task<List<MuscleGroup>> GetAllAsync()
        {
            return await _context.MuscleGroups
                .AsNoTracking()
                .OrderBy(m => m.Name)
                .ToListAsync();
        }

        public async Task<bool> ExistsAsync(int id)
        {
            return await _context.MuscleGroups.AnyAsync(m => m.Id == id);
        }
    }
}
