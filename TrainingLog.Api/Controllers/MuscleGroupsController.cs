using Microsoft.AspNetCore.Mvc;
using TrainingLog.Api.Dtos;
using TrainingLog.Api.Services;

namespace TrainingLog.Api.Controllers
{
    [ApiController]
    [Route("api/muscle-groups")]
    public class MuscleGroupsController : ControllerBase
    {
        private readonly ExerciseService _service;

        public MuscleGroupsController(ExerciseService service)
        {
            _service = service;
        }

        [HttpGet]
        public async Task<ActionResult<List<MuscleGroupDTO>>> GetAll()
        {
            return Ok(await _service.GetMuscleGroupsAsync());
        }
    }
}
