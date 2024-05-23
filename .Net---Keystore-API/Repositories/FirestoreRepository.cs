using Google.Cloud.Firestore;
using Google.Cloud.Firestore.V1;
using KeystoreAPI.Models;

namespace KeystoreAPI.Repositories
{
    public class FirestoreRepository
    {
        private readonly string _collection; 
        public FirestoreDb firestoreDb;

        public FirestoreRepository(string collection)
        {
            string filePath = "D:/Documentos/Desarrollo/Proyectos/.Net---Keystore-API/keystoredb-729ad-firebase-adminsdk-owrk2-a5a08a5dbb.json";
            Environment.SetEnvironmentVariable("GOOGLE_APPLICATION_CREDENTIALS", filePath);
            firestoreDb = FirestoreDb.Create("keystoredb-729ad");
            _collection = collection;
        }

        public T? Add<T>(T record) where T : FirebaseDocument
        {
            try
            {
                DocumentReference docRef = firestoreDb
                    .Collection(_collection)
                    .Document(record.ID); // Utiliza el ID proporcionado en el objeto record

                // Guarda el documento en Firestore con el ID especificado
                docRef.SetAsync(record).GetAwaiter().GetResult();

                return record;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error en Create: " + ex.Message);
                throw;
            }
        }

        public T? Get<T>(T record) where T : FirebaseDocument 
        {
            try 
            {
                DocumentReference docRef = firestoreDb.Collection(_collection).Document(record.ID);
                DocumentSnapshot docSnapshot = docRef.GetSnapshotAsync().GetAwaiter().GetResult();
                if (!docSnapshot.Exists) return null;
                T doc = docSnapshot.ConvertTo<T>();
                doc.ID = docSnapshot.Id;
                return doc;
            }
            catch (Exception ex) 
            {
                Console.WriteLine("Get Error: " + ex.Message);
                return null;
            } 
        }

        public List<T> GetAll<T>() where T : FirebaseDocument
        {
            try
            {
                CollectionReference collectionRef = firestoreDb.Collection(_collection);
                QuerySnapshot querySnapshot = collectionRef.GetSnapshotAsync().GetAwaiter().GetResult();
                List<T> documents = [];

                foreach (DocumentSnapshot documentSnapshot in querySnapshot.Documents)
                {
                    T document = documentSnapshot.ConvertTo<T>();
                    document.ID = documentSnapshot.Id;
                    documents.Add(document);
                }

                return documents;
            }
            catch (Exception ex)
            {
                Console.WriteLine("GetAll Error: " + ex.Message);
                return [];
            }
        }
    }
}
