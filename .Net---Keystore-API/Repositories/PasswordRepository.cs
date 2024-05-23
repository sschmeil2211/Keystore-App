using KeystoreAPI.Models;

namespace KeystoreAPI.Repositories
{
    public class PasswordRepository : IFirestoreRepository<Password>
    {
        private readonly string _collection = "passwords";
        private readonly FirestoreRepository firestoreRepository;

        public PasswordRepository() => firestoreRepository = new(_collection);

        public Password Add(Password record)
        {
            Password addedPassword = firestoreRepository.Add(record) ?? throw new Exception("Error creating seed");
            return addedPassword;
        }

        public List<Password> GetAll(string userID)
        {
            return firestoreRepository.GetAll<Password>().Where(x => x.UserID == userID).ToList(); 
        }

        public Password Get(Password record)
        {
            Password password = firestoreRepository.Get(record) ?? throw new Exception("Seed not found");
            return password;
        }

        public Password GetByID(string passwordID)
        {
            Password password = firestoreRepository.GetAll<Password>().FirstOrDefault(p => p.ID == passwordID);
            return password;
        }
    }
}
