using Microsoft.AspNetCore.Mvc;
using TrainingLog.Api.Dtos;
using TrainingLog.Api.Services;

namespace TrainingLog.Api.Controllers 
{
    [ApiController]
    [Route("api/exercises")]
    public class ExercisesController : ControllerBase
    {
        private readonly ExerciseService _service;

        public ExercisesController(ExerciseService service)
        {
            _service = service;
        }

        [HttpGet]
        public async Task<ActionResult<List<ExerciseDto>>> GetAll()
        {
            return Ok(await _service.GetAllAsync());
        }

        [HttpPost]
        public async Task<ActionResult<ExerciseDto>> Create(CreateExerciseRequest request)
        {
            var created = await _service.CreateAsync(request);
            return Created($"/api/exercises/{created.Id}", created);
        }
    }
}
