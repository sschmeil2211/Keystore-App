using Google.Cloud.Firestore;

namespace KeystoreAPI.Models
{
    [FirestoreData]
    public class Seed : FirebaseDocument
    {
        [FirestoreProperty]
        public string UserID { get; set; } = string.Empty;

        [FirestoreProperty]
        public string EncryptedSeed { get; set; } = string.Empty;
    }

    public class SeedDTO
    { 

        public required string UserID { get; set; }

        public required string Seed { get; set; } 
    }
} 