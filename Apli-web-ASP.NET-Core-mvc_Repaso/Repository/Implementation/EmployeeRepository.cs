using Apli_web_ASP.NET_Core_mvc_Repaso.Models;
using Apli_web_ASP.NET_Core_mvc_Repaso.Repository.Contract;
using System.Data.SqlClient;
using System.Data;
using System.Reflection;

namespace Apli_web_ASP.NET_Core_mvc_Repaso.Repository.Implementation 
{
    public class EmployeeRepository : IGenericRepository<Employee>
    {

        private readonly string _SQLstring = ""; //Cadena de conexion

        public EmployeeRepository(IConfiguration configuration) //Contructor
        {
            _SQLstring = configuration.GetConnectionString("SQLstring");
        }

        public async Task<List<Employee>> List()
        {
            List<Employee> _list = new List<Employee>();

            using (var connection = new SqlConnection(_SQLstring))
            {
                connection.Open();
                SqlCommand cmd = new SqlCommand("sp_ListadoEmpleados", connection);
                cmd.CommandType = CommandType.StoredProcedure;

                using (var dr = await cmd.ExecuteReaderAsync())
                {
                    while (await dr.ReadAsync())
                    {
                        _list.Add(new Employee
                        {
                            idEmployee = Convert.ToInt32(dr["idEmpledo"]),
                            fullName = dr["nombreCompleto"].ToString(),
                            refDepartment = new Department()
                            {
                                iddepartment = Convert.ToInt32(dr["idDepartamento"]),
                                name = dr["nombre"].ToString()
                            },
                            salary = Convert.ToInt32(dr["sueldo"]),
                            contractDate = dr["fechaContrato"].ToString(),
                        });
                    }
                }

            }
            return _list;
        }

        public async Task<bool> Save(Employee model)
        {
            using (var connection = new SqlConnection(_SQLstring))
            {
                connection.Open();
                SqlCommand cmd = new SqlCommand("sp_GuardarEmpleado", connection);
                cmd.Parameters.AddWithValue("nombreCompleto", model.fullName);
                cmd.Parameters.AddWithValue("idDepartamento", model.refDepartment.iddepartment);
                cmd.Parameters.AddWithValue("sueldo", model.salary);
                cmd.Parameters.AddWithValue("fechaContrato", model.contractDate);
                cmd.CommandType = CommandType.StoredProcedure;

                int affected_rows = await cmd.ExecuteNonQueryAsync();

                if(affected_rows > 0)
                    return true;
                else
                    return false;
            }
        }

        public async Task<bool> Edit(Employee model)
        {
            using (var connection = new SqlConnection(_SQLstring))
            {
                connection.Open();
                SqlCommand cmd = new SqlCommand("sp_EditarEmpleado", connection);
                cmd.Parameters.AddWithValue("idEmpledo", model.idEmployee);
                cmd.Parameters.AddWithValue("nombreCompleto", model.fullName);
                cmd.Parameters.AddWithValue("idDepartamento", model.refDepartment.iddepartment);
                cmd.Parameters.AddWithValue("sueldo", model.salary);
                cmd.Parameters.AddWithValue("fechaContrato", model.contractDate);
                cmd.CommandType = CommandType.StoredProcedure;

                int affected_rows = await cmd.ExecuteNonQueryAsync();

                if (affected_rows > 0)
                    return true;
                else
                    return false;
            }
        }

        public async Task<bool> Delete(int id)
        {
            using (var connection = new SqlConnection(_SQLstring))
            {
                connection.Open();
                SqlCommand cmd = new SqlCommand("sp_EliminarEmpleado", connection);
                cmd.Parameters.AddWithValue("idEmpledo", id);
                cmd.CommandType = CommandType.StoredProcedure;

                int affected_rows = await cmd.ExecuteNonQueryAsync();

                if (affected_rows > 0)
                    return true;
                else
                    return false;
            }
        }
    }
}
