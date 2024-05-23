using Google.Cloud.Firestore;

namespace KeystoreAPI.Models
{
    [FirestoreData] 
    public class Password : FirebaseDocument
    {
        [FirestoreProperty]
        public string UserID { get; set; } = string.Empty;

        [FirestoreProperty]
        public string PlatformName { get; set; } = string.Empty;

        [FirestoreProperty]
        public string EncryptedPassword { get; set; } = string.Empty;
    }

    public class PasswordDTO
    {
        public required string UserID { get; set; }

        public required string PlatformName { get; set; }

        public required string Password { get; set; }
    }
}
