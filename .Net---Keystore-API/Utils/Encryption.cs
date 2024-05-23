using System.Security.Cryptography;
using System.Text;

namespace KeystoreAPI.Utils
{
    public class Encryption
    { 
        public static string Encrypt(string plainText, byte[] key)
        {
            using Aes aesAlg = Aes.Create();
            aesAlg.KeySize = 256; // Establecer el tamaño de la clave en 256 bits 

            aesAlg.Key = key;


            aesAlg.Mode = CipherMode.CBC;
            aesAlg.GenerateIV();
            ICryptoTransform encryptor = aesAlg.CreateEncryptor(aesAlg.Key, aesAlg.IV);
            using MemoryStream msEncrypt = new();
            msEncrypt.Write(aesAlg.IV, 0, aesAlg.IV.Length);

            using (CryptoStream csEncrypt = new(msEncrypt, encryptor, CryptoStreamMode.Write))
            using (StreamWriter swEncrypt = new(csEncrypt))
            {
                swEncrypt.Write(plainText);
            }

            return Convert.ToBase64String(msEncrypt.ToArray());
        }

        public static string Decrypt(string cipherText, byte[] key)
        {
            byte[] cipherBytes = Convert.FromBase64String(cipherText);
            byte[] iv = new byte[16]; // IV debe tener la misma longitud que el bloque de cifrado (16 bytes para AES)
            Array.Copy(cipherBytes, iv, iv.Length);

            using Aes aesAlg = Aes.Create();
            aesAlg.KeySize = 256; // Establecer el tamaño de la clave en 256 bits

            aesAlg.Key = key; // Convertir la clave derivada en bytes

            aesAlg.Mode = CipherMode.CBC;
            aesAlg.IV = iv;

            ICryptoTransform decryptor = aesAlg.CreateDecryptor(aesAlg.Key, aesAlg.IV);

            using MemoryStream msDecrypt = new(cipherBytes, iv.Length, cipherBytes.Length - iv.Length);
            using CryptoStream csDecrypt = new(msDecrypt, decryptor, CryptoStreamMode.Read);
            using StreamReader srDecrypt = new(csDecrypt);
            return srDecrypt.ReadToEnd();
        }  

        public static byte[] EncryptKey(string pin)
        {
            byte[] salt = Encoding.UTF8.GetBytes("SaltingKey"); // Valor de sal fijo
            using Rfc2898DeriveBytes keyDerivation = new(pin, salt, 10000); // 10000 iteraciones para la derivación
            return keyDerivation.GetBytes(32); // Convertir la clave derivada en bytes
        }
    }
}
