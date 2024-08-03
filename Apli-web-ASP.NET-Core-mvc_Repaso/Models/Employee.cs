namespace Apli_web_ASP.NET_Core_mvc_Repaso.Models
{
    public class Employee
    {
        public int idEmployee { get; set; }
        public string fullName { get; set; }
        public Department refDepartment { get; set; }
        public int salary { get; set; }
        public string contractDate { get; set; }

    }
}
