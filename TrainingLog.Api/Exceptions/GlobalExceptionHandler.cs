using Microsoft.AspNetCore.Diagnostics;
using Microsoft.AspNetCore.Mvc;

namespace TrainingLog.Api.Exceptions
{
    public class GlobalExceptionHandler : IExceptionHandler
    {
        private readonly ILogger<GlobalExceptionHandler> _logger;

        public GlobalExceptionHandler(ILogger<GlobalExceptionHandler> logger)
        {
            _logger = logger;
        }

        public async ValueTask<bool> TryHandleAsync(
            HttpContext httpContext, Exception exception, CancellationToken cancellationToken)
        {
            var (status, title) = exception switch
            {
                BadRequestException => (StatusCodes.Status400BadRequest, "Invalid request"),
                NotFoundException => (StatusCodes.Status404NotFound, "Not found"),
                _ => (StatusCodes.Status500InternalServerError, "Server error")
            };

            if (status == StatusCodes.Status500InternalServerError)
            {
                _logger.LogError(exception, "Unhandled exception");
            }

            httpContext.Response.StatusCode = status;

            await httpContext.Response.WriteAsJsonAsync(new ProblemDetails
            {
                Status = status,
                Title = title,
                Detail = status == StatusCodes.Status500InternalServerError ? null : exception.Message
            }, cancellationToken);

            return true;
        }
    }
}
