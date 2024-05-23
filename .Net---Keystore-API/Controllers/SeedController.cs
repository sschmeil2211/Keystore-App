using KeystoreAPI.Models;
using KeystoreAPI.Repositories;
using KeystoreAPI.Utils;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using System.Security.Cryptography;
using System.Text;

namespace KeystoreAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SeedController(SeedRepository seedRepository, IConfiguration configuration, UserRepository userRepository) : ControllerBase
    {
        private readonly SeedRepository _seedRepository = seedRepository;
        private readonly IConfiguration _configuration = configuration;
        private readonly UserRepository _userRepository = userRepository;

        /*[HttpGet("{id}")]
        public IActionResult GetSeed(string id)
        {
            if (string.IsNullOrEmpty(id))
                return BadRequest("Invalid ID");

            Seed seed = _seedRepository.Get(new Seed() { ID = id});
            if (seed == null)
                return NotFound($"Seed not found for user {id}");

            // Decrypt the seed before returning it

            string tokenValue = _configuration.GetSection("AppSettings:Token").Value ?? throw new Exception("AppSettings:Token no está configurado correctamente.");
            seed.EncryptedSeed = Decrypt(seed.EncryptedSeed, tokenValue);
            return Ok(seed);
        }*/

        [HttpPost]
        public IActionResult CreateSeed(SeedDTO model)
        {
            if (model == null || model.Seed == null)
                return BadRequest("Seed must not be null or empty");

            string tokenValue = _configuration.GetSection("AppSettings:Key").Value ?? throw new Exception("AppSettings:Token no está configurado correctamente.");
            string encryptedSeed = Encryption.Encrypt(model.Seed, Encoding.UTF8.GetBytes(tokenValue));
            Seed seed = new()
            {
                ID = Guid.NewGuid().ToString(),
                UserID = model.UserID,
                EncryptedSeed = encryptedSeed
            };

            Seed addedSeed = _seedRepository.Add(seed);
            return Ok(addedSeed);
        } 

        [HttpPost("ValidateData")]
        public IActionResult ValidateData(string email, string dataToValidate)
        {
            if (string.IsNullOrEmpty(email) || dataToValidate == null)
                return BadRequest("Invalid request");

            User user = _userRepository.GetByEmail(email);
            if(user == null)
                return NotFound($"User not found for user {email}");

            Seed seed = _seedRepository.GetByUserID(user.ID);
            if (seed == null)
                return NotFound($"Seed not found for user {user.ID}");

            string tokenValue = _configuration.GetSection("AppSettings:Key").Value ?? throw new Exception("AppSettings:Token no está configurado correctamente.");
            string decryptedSeed = Encryption.Decrypt(seed.EncryptedSeed, Encoding.UTF8.GetBytes(tokenValue));
            if(decryptedSeed == dataToValidate)
                return Ok("Seed is correct");
            else
                return BadRequest("Seed is incorrect");
        } 

        /*private static string Encrypt(string plainText, string key)
        {
            byte[] encrypted;
            using (Aes aesAlg = Aes.Create())
            {
                aesAlg.Key = Encoding.UTF8.GetBytes(key);
                aesAlg.Mode = CipherMode.CBC;
                aesAlg.GenerateIV();

                ICryptoTransform encryptor = aesAlg.CreateEncryptor(aesAlg.Key, aesAlg.IV);

                using MemoryStream msEncrypt = new();
                msEncrypt.Write(aesAlg.IV, 0, aesAlg.IV.Length);
                using CryptoStream csEncrypt = new(msEncrypt, encryptor, CryptoStreamMode.Write);
                using (StreamWriter swEncrypt = new(csEncrypt))
                {
                    swEncrypt.Write(plainText);
                }
                encrypted = msEncrypt.ToArray();
            }
            return Convert.ToBase64String(encrypted);
        }

        private static string Decrypt(string cipherText, string key)
        {
            string plaintext;
            byte[] cipherBytes = Convert.FromBase64String(cipherText);
            using (Aes aesAlg = Aes.Create())
            {
                aesAlg.Key = Encoding.UTF8.GetBytes(key);
                aesAlg.Mode = CipherMode.CBC;

                byte[] iv = new byte[aesAlg.IV.Length];
                Array.Copy(cipherBytes, iv, iv.Length);
                aesAlg.IV = iv;

                ICryptoTransform decryptor = aesAlg.CreateDecryptor(aesAlg.Key, aesAlg.IV);

                using MemoryStream msDecrypt = new(new ReadOnlySpan<byte>(cipherBytes)[aesAlg.IV.Length..].ToArray());
                using CryptoStream csDecrypt = new(msDecrypt, decryptor, CryptoStreamMode.Read);
                using StreamReader srDecrypt = new(csDecrypt);
                plaintext = srDecrypt.ReadToEnd();
            }
            return plaintext;
        } */
    }
}
