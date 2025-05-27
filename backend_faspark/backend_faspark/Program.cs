using Microsoft.EntityFrameworkCore;
using backend_faspark.Database;

var builder = WebApplication.CreateBuilder(args);

// Force pakai URL tertentu
// Listen di semua IP, baik itu IP atau Lan
builder.WebHost.UseUrls("https://localhost:7211");

builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", policy =>
    {
        policy.AllowAnyOrigin()
              .AllowAnyHeader()
              .AllowAnyMethod();
    });
});

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseNpgsql(builder.Configuration.GetConnectionString("DefaultConnection")));

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseCors("AllowAll");

app.UseStaticFiles(); 

app.UseAuthorization();

app.MapControllers();

app.Run();
