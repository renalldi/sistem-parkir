using backend_faspark.Models;
using Microsoft.EntityFrameworkCore;

namespace backend_faspark.Database
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
        {
        }

        public DbSet<User> Users { get; set; }
        public DbSet<Report> Reports { get; set; }

    }
}
