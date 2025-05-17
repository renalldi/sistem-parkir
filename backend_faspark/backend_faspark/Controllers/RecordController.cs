using Microsoft.AspNetCore.Mvc;
using backend_faspark.Models;
using backend_faspark.Database; // atau namespace DbContext kamu
using Microsoft.EntityFrameworkCore;

[Route("api/[controller]")]
[ApiController]
public class RecordController : ControllerBase
{
    private readonly AppDbContext _context;

    public RecordController(AppDbContext context)
    {
        _context = context;
    }

    // GET: api/Record/5
    [HttpGet("{id}")]
    public async Task<IActionResult> GetRecord(int id)
    {
        var record = await _context.Reports.FindAsync(id);

        if (record == null)
        {
            return NotFound(new { message = "Record not found" });
        }

        return Ok(record);
    }
}
