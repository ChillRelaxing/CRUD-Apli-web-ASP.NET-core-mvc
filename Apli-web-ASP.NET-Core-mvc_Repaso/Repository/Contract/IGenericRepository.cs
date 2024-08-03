namespace Apli_web_ASP.NET_Core_mvc_Repaso.Repository.Contract
{
    //Programacion asincrona
    public interface IGenericRepository<T> where T: class
    {
        Task<List<T>> List();
        Task<bool> Save(T model);
        Task<bool> Edit(T model);
        Task<bool> Delete(int id);
    }
}
