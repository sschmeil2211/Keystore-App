using KeystoreAPI.Models;

namespace KeystoreAPI.Repositories
{
    public class UserRepository : IFirestoreRepository<User>
    {
        private readonly string _collection = "users";
        private readonly FirestoreRepository firestoreRepository;

        public UserRepository() => firestoreRepository = new(_collection);

        public User Add(User record)
        {
            User addedUser = firestoreRepository.Add(record) ?? throw new Exception("Error creating user");
            return addedUser;
        }

        public User Get(User record)
        {
            User user = firestoreRepository.Get(record)/* ?? throw new Exception("User not found")*/;
            return user;
        }

        public User GetById(string userID)
        {
            User user = firestoreRepository.GetAll<User>().FirstOrDefault(s => s.ID == userID);
            return user;
        }

        public User GetByEmail(string email)
        {
            User user = firestoreRepository.GetAll<User>().FirstOrDefault(s => s.Email == email);
            return user;
        }
    }
}
