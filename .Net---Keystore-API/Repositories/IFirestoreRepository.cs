namespace KeystoreAPI.Repositories
{
    public interface IFirestoreRepository<T>
    {
        T Add(T model);
        T Get(T record);
    }
}
