using backend_faspark.Database;
using backend_faspark.Models;
using Microsoft.AspNetCore.Mvc;

namespace backend_faspark.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ReportController : ControllerBase
    {
        private readonly AppDbContext _context;

        public ReportController(AppDbContext context)
        {
            _context = context;
        }

        // Class pengganti ReportDto hanya untuk input
        public class ReportInputModel
        {
            public string PlatMotor { get; set; } = "";
            public string NamaMotor { get; set; } = "";
            public string Spot { get; set; } = "";
            public string Deskripsi { get; set; } = "";
            public IFormFile? Gambar { get; set; }
        }

        [HttpPost]
        [RequestSizeLimit(10_000_000)]
        public async Task<IActionResult> CreateReport([FromForm] ReportInputModel input)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            try
            {
                string? fileName = null;

                if (input.Gambar != null && input.Gambar.Length > 0)
                {
                    fileName = $"{Guid.NewGuid()}{Path.GetExtension(input.Gambar.FileName)}";
                    var filePath = Path.Combine("wwwroot/uploads", fileName);
                    Directory.CreateDirectory("wwwroot/uploads");

                    using (var stream = new FileStream(filePath, FileMode.Create))
                    {
                        await input.Gambar.CopyToAsync(stream);
                    }
                }

                var report = new Report
                {
                    PlatMotor = input.PlatMotor,
                    NamaMotor = input.NamaMotor,
                    Spot = input.Spot,
                    Deskripsi = input.Deskripsi,
                    GambarPath = fileName ?? ""
                };

                _context.Reports.Add(report);
                await _context.SaveChangesAsync();

                return Ok(new
                {
                    message = "Laporan berhasil dikirim.",
                    id = report.Id
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Terjadi kesalahan", error = ex.Message });
            }
        }

        [HttpGet]
        public IActionResult GetReports()
        {
            return Ok(_context.Reports.ToList());
        }
    }
}
