using KeystoreAPI.Models;

namespace KeystoreAPI.Repositories
{
    public class SeedRepository : IFirestoreRepository<Seed>
    {
        private readonly string _collection = "seeds";
        private readonly FirestoreRepository firestoreRepository;

        public SeedRepository() => firestoreRepository = new(_collection);

        public Seed Add(Seed record)
        {
            Seed addedUser = firestoreRepository.Add(record) ?? throw new Exception("Error creating seed");
            return addedUser;
        }

        public Seed Get(Seed record)
        {
            Seed user = firestoreRepository.Get(record) ?? throw new Exception("Seed not found");
            return user;
        }

        public Seed GetByUserID(string userID)
        { 
            Seed seed = firestoreRepository.GetAll<Seed>().FirstOrDefault(s => s.UserID == userID);
            return seed;
        }
    }
}
