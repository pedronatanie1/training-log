using Microsoft.EntityFrameworkCore;
using TrainingLog.Api.Data;
using TrainingLog.Api.Repositories;
using TrainingLog.Api.Services;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddControllers();

var connectionString = builder.Configuration.GetConnectionString("TrainingLog")
    ?? throw new InvalidOperationException("Connection string 'TrainingLog' is missing.");

builder.Services.AddDbContext<TrainingLogContext>(options =>
    options.UseSqlServer(connectionString));

builder.Services.AddScoped<IMuscleGroupRepository, MuscleGroupRepository>();

builder.Services.AddScoped<IExerciseRepository, ExerciseRepository>();

builder.Services.AddScoped<ExerciseService>();

builder.Services.AddOpenApi();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
