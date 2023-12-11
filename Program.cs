var builder = WebApplication.CreateBuilder(args);

builder.WebHost.UseUrls("http://0.0.0.0:8080");

var app = builder.Build();

string defaultMessage = "Hello World!";

app.MapGet("/", () => defaultMessage);

app.MapPost("/message", async (HttpContext context) =>
{
    using (var reader = new StreamReader(context.Request.Body))
    {
        var requestBody = await reader.ReadToEndAsync();
        if (!string.IsNullOrEmpty(requestBody))
        {
            defaultMessage = requestBody;
            return Results.Ok($"Message set to: {defaultMessage}");
        }

        return Results.BadRequest("Message cannot be empty");
    }
});

app.Run();
