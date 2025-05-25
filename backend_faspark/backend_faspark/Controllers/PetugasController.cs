using Microsoft.AspNetCore.Mvc;
using backend_faspark.Database;
using backend_faspark.Models;
using Microsoft.EntityFrameworkCore;

namespace backend_faspark.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PetugasController : ControllerBase
    {
        private readonly AppDbContext _context;

        public PetugasController(AppDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public IActionResult GetPetugas()
        {
            var users = _context.Petugas.ToList();
            return Ok(users);
        }
    }
}