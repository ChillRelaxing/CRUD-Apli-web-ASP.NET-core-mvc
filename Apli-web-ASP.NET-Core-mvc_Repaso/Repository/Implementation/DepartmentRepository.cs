using Apli_web_ASP.NET_Core_mvc_Repaso.Models;
using Apli_web_ASP.NET_Core_mvc_Repaso.Repository.Contract;
using System.Data;
using System.Data.SqlClient;

namespace Apli_web_ASP.NET_Core_mvc_Repaso.Repository.Implementation
{
    public class DepartmentRepository : IGenericRepository<Department>
    {
        private readonly string _SQLstring = "";

        public DepartmentRepository(IConfiguration configuration) 
        {
            _SQLstring = configuration.GetConnectionString("SQLstring");
        }

        public async Task<List<Department>> List()
        {
            List<Department> _list = new List<Department>();

            using (var connection = new SqlConnection(_SQLstring))
            {
                connection.Open();
                SqlCommand cmd = new SqlCommand("sp_ListaDepartamentos", connection);
                cmd.CommandType = CommandType.StoredProcedure;

                using (var dr = await cmd.ExecuteReaderAsync())
                {
                    while (await dr.ReadAsync())
                    {
                        _list.Add(new Department
                        {
                            iddepartment = Convert.ToInt32(dr["idDepartamento"]),
                            name = dr["nombre"].ToString()
                        });
                    }
                }

            }
            return _list;
        }

        public Task<bool> Delete(int id)
        {
            throw new NotImplementedException();
        }

        public Task<bool> Edit(Department model)
        {
            throw new NotImplementedException();
        }
        public Task<bool> Save(Department model)
        {
            throw new NotImplementedException();
        }
    }
}
