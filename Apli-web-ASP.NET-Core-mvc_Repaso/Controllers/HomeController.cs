using Apli_web_ASP.NET_Core_mvc_Repaso.Models;
using Apli_web_ASP.NET_Core_mvc_Repaso.Repository.Contract;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;

namespace Apli_web_ASP.NET_Core_mvc_Repaso.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly IGenericRepository<Department> _departmentRepository;
        private readonly IGenericRepository<Employee> _employeeRepository;


        public HomeController(ILogger<HomeController> logger,
            IGenericRepository<Department> departmentRepository, 
            IGenericRepository<Employee> employeeRepository)
        {
            _logger = logger;
            _departmentRepository = departmentRepository;
            _employeeRepository = employeeRepository;
        }

        public IActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public async Task<IActionResult> listDepartment()
        {
            List<Department> _list = await _departmentRepository.List();

            return StatusCode(StatusCodes.Status200OK, _list);

            return View();
        }

        [HttpGet]
        public async Task<IActionResult> listEmployee()
        {
            List<Employee> _list = await _employeeRepository.List();

            return StatusCode(StatusCodes.Status200OK, _list);

            return View();
        }

        [HttpPost]
        public async Task<IActionResult> SaveEmployee([FromBody] Employee modelEmployee)
        {
            bool _result = await _employeeRepository.Save(modelEmployee);

            if (_result)
                return StatusCode(StatusCodes.Status200OK, new { valor = _result, msg = "ok" });
            else
                return StatusCode(StatusCodes.Status500InternalServerError, new { valor = _result, msg = "error" });
        }

        [HttpPut]
        public async Task<IActionResult> EditEmployee([FromBody] Employee modelEmployee)
        {
            bool _result = await _employeeRepository.Edit(modelEmployee);

            if (_result)
                return StatusCode(StatusCodes.Status200OK, new { valor = _result, msg = "ok" });
            else
                return StatusCode(StatusCodes.Status500InternalServerError, new { valor = _result, msg = "error" });
        }

        [HttpDelete]
        public async Task<IActionResult> DeleteEmployee(int idEmployee)
        {
            bool _result = await _employeeRepository.Delete(idEmployee);

            if (_result)
                return StatusCode(StatusCodes.Status200OK, new { valor = _result, msg = "ok" });
            else
                return StatusCode(StatusCodes.Status500InternalServerError, new { valor = _result, msg = "error" });
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
