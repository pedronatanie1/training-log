using TrainingLog.Api.Entities;

namespace TrainingLog.Api.Repositories
{
    public interface IMuscleGroupRepository
    {
        Task<List<MuscleGroup>> GetAllAsync();
        Task<bool> ExistsAsync(int id);
    }
}
