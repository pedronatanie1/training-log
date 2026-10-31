using TrainingLog.Api.Dtos;
using TrainingLog.Api.Entities;

namespace TrainingLog.Api.Repositories
{
    public interface IWorkoutRepository
    {
        Task<Workout> AddAsync(Workout workout);
        Task<Workout?> GetByIdAsync(int id);
        Task<List<Workout>> GetRecentAsync(int count);
        Task<bool> DeleteAsync(int id);
        Task<List<SetHistoryRow>> GetSetHistoryAsync();
    }
}
