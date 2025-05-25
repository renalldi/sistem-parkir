using backend_faspark.Database;
using backend_faspark.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace backend_faspark.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UserController : ControllerBase
    {
        private readonly AppDbContext _context;

        public UserController(AppDbContext context)
        {
            _context = context;
        }

        // registrasi mahasiswa/dosen
        [HttpPost("register")]
        public async Task<IActionResult> Register([FromBody] User user)
        {
            // Validasi input
            if (string.IsNullOrWhiteSpace(user.Username) || string.IsNullOrWhiteSpace(user.Password))
            {
                return BadRequest(new { message = "Username & Password wajib diisi" });
            }

            // Cek username sudah terdaftar
            var existingUser = await _context.Users.FirstOrDefaultAsync(u => u.Username == user.Username);
            if (existingUser != null)
            {
                return Conflict(new { message = "Username sudah digunakan" });
            }

            // Simpan user baru
            _context.Users.Add(user);
            await _context.SaveChangesAsync();

            return Ok(new { message = "Registrasi berhasil", user });
        }

        // login mahasiswa/dosen
        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] User loginData)
        {
            // validasi input
            if (string.IsNullOrWhiteSpace(loginData.Username) || string.IsNullOrWhiteSpace(loginData.Password))
            {
                return BadRequest(new { message = "Username atau Password wajib diisi!" });
            }

            // cari user di database
            var user = await _context.Users
                .FirstOrDefaultAsync(u => u.Username == loginData.Username && u.Password == loginData.Password);

            if (user == null)
            {
                return Unauthorized(new { message = "Username atau Password Salah!" });
            }

            // sukses login
            return Ok(new
            {
                message = "Login Berhasil",
                user = new { user.Id, user.Username, user.Role }
            });
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetUser(int id)
        {
            var user = await _context.Users.FindAsync(id);
            if (user == null)
            {
                return NotFound(new { message = "User tidak ditemukan" });
            }

            return Ok(user);
        }

        [HttpPut("update-profile/{id}")]
        public async Task<IActionResult> UpdateProfile(int id, [FromBody] User updatedUser )
        {
            var user = await _context.Users.FindAsync(id);
            if (user == null)
            {
                return NotFound(new { message = "User tidak ditemukan." });
            }

            // update data
            user.Username = updatedUser.Username ?? user.Username;
            user.Password = updatedUser.Password ?? user.Password;
            user.Role = updatedUser.Role ?? user.Role;

            await _context.SaveChangesAsync();

            return Ok(new { message = "Profil Berhasil Diperbarui", user});
        }

        [HttpDelete("delete/{id}")]
        public async Task<IActionResult> DeleteProfile (int id)
        {
            var user = await _context.Users.FindAsync (id);
            if (user == null)
            {
                return NotFound(new { message = "User tidak ditemukan" });
            }
            _context.Users.Remove(user);
            await _context.SaveChangesAsync();

            return Ok(new { message = "User berhasil dihapus"});
        }
    }
}
