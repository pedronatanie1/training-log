using Microsoft.AspNetCore.Mvc;
using TrainingLog.Api.Dtos;
using TrainingLog.Api.Services;

namespace TrainingLog.Api.Controllers
{
    [ApiController]
    [Route("api/workouts")]
    public class WorkoutsController : ControllerBase
    {
        private readonly WorkoutService _service;

        public WorkoutsController(WorkoutService service)
        {
            _service = service;
        }

        [HttpGet]
        public async Task<ActionResult<List<WorkoutDto>>> GetRecent([FromQuery] int count = 10)
        {
            return Ok(await _service.GetRecentAsync(count));
        }

        [HttpGet("{id:int}")]
        public async Task<ActionResult<WorkoutDto>> GetById(int id)
        {
            return Ok(await _service.GetByIdAsync(id));
        }

        [HttpPost]
        public async Task<ActionResult<WorkoutDto>> Create(CreateWorkoutRequest request)
        {
            var created = await _service.LogAsync(request);
            return CreatedAtAction(nameof(GetById), new { id = created.Id }, created);
        }

        [HttpDelete("{id:int}")]
        public async Task<IActionResult> Delete(int id)
        {
            await _service.DeleteAsync(id);
            return NoContent();
        }
    }
}
