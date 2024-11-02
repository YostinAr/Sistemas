using static System.Net.Mime.MediaTypeNames;

namespace API.Entities
{
    public class DepartmentEnt
    {
        public int DepartmentId { get; set; } 
        public string DepartmentName { get; set; } = string.Empty;
    }
}

