using Microsoft.EntityFrameworkCore;
using TrainingLog.Api.Data;
using TrainingLog.Api.Exceptions;
using TrainingLog.Api.Repositories;
using TrainingLog.Api.Services;

var builder = WebApplication.CreateBuilder(args);

// Framework
builder.Services.AddControllers();
builder.Services.AddOpenApi();
builder.Services.AddExceptionHandler<GlobalExceptionHandler>();
builder.Services.AddProblemDetails();

// Database
var connectionString = builder.Configuration.GetConnectionString("TrainingLog")
    ?? throw new InvalidOperationException("Connection string 'TrainingLog' is missing.");

builder.Services.AddDbContext<TrainingLogContext>(options =>
    options.UseSqlServer(connectionString));

// Repositories
builder.Services.AddScoped<IMuscleGroupRepository, MuscleGroupRepository>();
builder.Services.AddScoped<IExerciseRepository, ExerciseRepository>();
builder.Services.AddScoped<IWorkoutRepository, WorkoutRepository>();

// Services
builder.Services.AddScoped<ExerciseService>();
builder.Services.AddScoped<WorkoutService>();

var app = builder.Build();

// Request pipeline (order matters)
app.UseExceptionHandler();

if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
}

app.UseHttpsRedirection();
app.UseAuthorization();
app.MapControllers();

app.Run();