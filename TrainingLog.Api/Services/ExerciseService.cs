using TrainingLog.Api.Dtos;
using TrainingLog.Api.Entities;
using TrainingLog.Api.Exceptions;
using TrainingLog.Api.Repositories;

namespace TrainingLog.Api.Services
{
    public class ExerciseService
    {
        private readonly IExerciseRepository _exercises;
        private readonly IMuscleGroupRepository _muscleGroups;

        public ExerciseService(
            IExerciseRepository exercises,
            IMuscleGroupRepository muscleGroups)
        {
            _exercises = exercises;
            _muscleGroups = muscleGroups;
        }

        public async Task<List<MuscleGroupDto>> GetMuscleGroupsAsync()
        {
            var groups = await _muscleGroups.GetAllAsync();

            return groups.Select(g => new MuscleGroupDto(g.Id, g.Name)).ToList();
        }

        public async Task<List<ExerciseDto>> GetAllAsync()
        {
            var exercises = await _exercises.GetAllAsync();

            return exercises.Select(ToDto).ToList();
        }

        public async Task<ExerciseDto> CreateAsync(CreateExerciseRequest request)
        {
            var name = request.Name?.Trim();

            if (string.IsNullOrEmpty(name))
            {
                throw new BadRequestException("Exercise name is required.");
            }

            if (name.Length > 100)
            {
                throw new BadRequestException("Exercise name cannot be longer than 100 characters.");
            }

            if (!await _muscleGroups.ExistsAsync(request.MuscleGroupId))
            {
                throw new BadRequestException($"Muscle group {request.MuscleGroupId} does not exist.");
            }

            if (await _exercises.NameExistsAsync(name))
            {
                throw new BadRequestException($"An exercise named {name} already exists.");
            }

            var saved = await _exercises.AddAsync(new Exercise
            {
                Name = name,
                MuscleGroupId = request.MuscleGroupId
            });

            var loaded = await _exercises.GetByIdAsync(saved.Id);

            return ToDto(loaded!);
        }

        private static ExerciseDto ToDto(Exercise e) =>
            new(e.Id, e.Name, e.MuscleGroup?.Name ?? string.Empty);

    }
}
