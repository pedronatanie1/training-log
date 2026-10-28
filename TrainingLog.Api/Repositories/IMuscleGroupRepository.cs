using TrainingLog.Api.Entities;

namespace TrainingLog.Api.Repositories
{
    internal interface IMuscleGroupRepository
    {
        Task<List<MuscleGroup>> GetAllAsync();
        Task<bool> ExistsAsync(int id);
    }
}
