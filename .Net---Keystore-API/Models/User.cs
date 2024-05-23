using Google.Cloud.Firestore; 

namespace KeystoreAPI.Models
{
    [FirestoreData]
    public class User : FirebaseDocument
    {
        [FirestoreProperty] 
        public string Email { get; set; } = string.Empty;

        [FirestoreProperty]
        public string Username { get; set; } = string.Empty;

        [FirestoreProperty]
        public byte[] EncryptedPin { get; set; } = new byte[32];
    }

    public class UserDTO
    {

        public required string ID { get; set; } 

        public required string Email { get; set; } 

        public required string Username { get; set; } 

        public required string Pin {  get; set; }
    }
}
