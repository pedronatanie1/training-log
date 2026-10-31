using TrainingLog.Api.Dtos;
using TrainingLog.Api.Entities;
using TrainingLog.Api.Exceptions;
using TrainingLog.Api.Repositories;

namespace TrainingLog.Api.Services
{
    public class WorkoutService
    {
        private readonly IWorkoutRepository _workouts;
        private readonly IExerciseRepository _exercises;
        private readonly ILogger<WorkoutService> _logger;

        public WorkoutService(
            IWorkoutRepository workouts,
            IExerciseRepository exercises,
            ILogger<WorkoutService> logger)
        {
            _workouts = workouts;
            _exercises = exercises;
            _logger = logger;
        }

        public async Task<WorkoutDto> LogAsync(CreateWorkoutRequest request)
        {
            if (request.Date == default)
            {
                throw new BadRequestException("Workout date is required.");
            }

            if (request.Date > DateOnly.FromDateTime(DateTime.Today))
            {
                throw new BadRequestException("Workout date cannot be in the future.");
            }

            if (request.Notes?.Length > 500)
            {
                throw new BadRequestException("Notes cannot be longer than 500 characters.");
            }
                
            if (request.Sets is null || request.Sets.Count == 0)
            {
                throw new BadRequestException("A workout needs at least one set.");
            }

            foreach (var set in request.Sets)
            {
                if (set.SetNumber <= 0)
                {
                    throw new BadRequestException("Set numbers must be greater than 0.");
                }
                    
                if (set.Reps is null && set.DurationSeconds is null && set.DistanceMetres is null)
                {
                    throw new BadRequestException("Each set needs reps, a duration or a distance.");
                }
                   
                if (set.Reps is <= 0)
                {
                    throw new BadRequestException("Reps must be greater than 0.");
                }
                   
                if (set.DurationSeconds is <= 0)
                {
                    throw new BadRequestException("Duration must be greater than 0.");
                }
                    
                if (set.DistanceMetres is <= 0m)
                {
                    throw new BadRequestException("Distance must be greater than 0.");
                }
                   
                if (set.WeightKg < 0)
                {
                    throw new BadRequestException("Weight cannot be negative.");
                }
                    
                if (set.WeightKg > 9999.99m)
                {
                    throw new BadRequestException("Weight cannot be more than 9999.99 kg.");
                }
                    
                if (set.DistanceMetres > 99999.99m)
                {
                    throw new BadRequestException("Distance cannot be more than 99999.99 m.");
                }
            }

            var hasDuplicate = request.Sets
                .GroupBy(s => (s.ExerciseId, s.SetNumber))
                .Any(g => g.Count() > 1);

            if (hasDuplicate)
            {
                throw new BadRequestException("Each exercise can use a set number only once per workout.");
            }

            foreach (var exerciseId in request.Sets.Select(s => s.ExerciseId).Distinct())
            {
                if (await _exercises.GetByIdAsync(exerciseId) is null)
                {
                    throw new BadRequestException($"Exercise {exerciseId} does not exist.");
                }
            }

            var workout = new Workout
            {
                Date = request.Date,
                Notes = request.Notes,
                Sets = request.Sets.Select(s => new WorkoutSet
                {
                    ExerciseId = s.ExerciseId,
                    SetNumber = s.SetNumber,
                    Reps = s.Reps,
                    WeightKg = s.WeightKg,
                    DurationSeconds = s.DurationSeconds,
                    DistanceMetres = s.DistanceMetres
                }).ToList()
            };

            await _workouts.AddAsync(workout);
            _logger.LogInformation("Workout {WorkoutId} logged with {SetCount} sets",
                workout.Id, workout.Sets.Count);

            var saved = await _workouts.GetByIdAsync(workout.Id);

            return ToDto(saved!);
        }

        public async Task<WorkoutDto> GetByIdAsync(int id)
        {
            var workout = await _workouts.GetByIdAsync(id)
                ?? throw new NotFoundException($"Workout {id} was not found.");

            return ToDto(workout);
        }

        public async Task<List<WorkoutDto>> GetRecentAsync(int count)
        {
            var workouts = await _workouts.GetRecentAsync(Math.Clamp(count, 1, 100));

            return workouts.Select(ToDto).ToList();
        }

        public async Task DeleteAsync(int id)
        {
            if (!await _workouts.DeleteAsync(id))
            {
                throw new NotFoundException($"Workout {id} was not found.");
            }

            _logger.LogInformation("Workout {WorkoutId} deleted", id);
        }

        private static WorkoutDto ToDto(Workout w) => new(
            w.Id, w.Date, w.Notes,
            w.Sets
                .OrderBy(s => s.ExerciseId)
                .ThenBy(s => s.SetNumber)
                .Select(s => new WorkoutSetDto(
                    s.Id, s.ExerciseId, s.Exercise?.Name ?? string.Empty, s.SetNumber,
                    s.Reps, s.WeightKg, s.DurationSeconds, s.DistanceMetres))
                .ToList());
    }
}