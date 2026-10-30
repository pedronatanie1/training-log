using TrainingLog.Api.Entities;

namespace TrainingLog.Api.Repositories
{
    public interface IExerciseRepository
    {
        Task<List<Exercise>> GetAllAsync();
        Task<Exercise?> GetByIdAsync(int id);
        Task<bool> NameExistsAsync(string name);
        Task<Exercise> AddAsync(Exercise exercise);
    }
}
