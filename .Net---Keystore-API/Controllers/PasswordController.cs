using KeystoreAPI.Models;
using KeystoreAPI.Repositories;
using KeystoreAPI.Utils;
using Microsoft.AspNetCore.Mvc;

namespace KeystoreAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PasswordController(PasswordRepository passwordRepository, UserRepository userRepository) : ControllerBase
    {
        private readonly PasswordRepository _passwordRepository = passwordRepository;  
        private readonly UserRepository _userRepository = userRepository;  

        [HttpPost]
        public IActionResult CreatePassword(PasswordDTO model)
        {
            if (model == null || string.IsNullOrEmpty(model.UserID) || string.IsNullOrEmpty(model.Password) || string.IsNullOrEmpty(model.PlatformName))
                return BadRequest("Invalid request");

            User user = _userRepository.GetById(model.UserID);
            if(user == null)
                return NotFound("User not found");

            string encryptedPassword = Encryption.Encrypt(model.Password, user.EncryptedPin);

            Password password = new()
            {
                ID = Guid.NewGuid().ToString(),
                UserID = model.UserID,
                EncryptedPassword = encryptedPassword,
                PlatformName = model.PlatformName
            };

            Password addedPassword = _passwordRepository.Add(password);
            return Ok(addedPassword);
        }

        [HttpGet("{userID}")]
        public IActionResult GetPasswords(string userID)
        { 
            List<Password> userPasswords = _passwordRepository.GetAll(userID);
            if (userPasswords.Count == 0)
                return BadRequest("Password not found"); 
            return Ok(userPasswords);
        }

        [HttpGet("DecryptedPassword")]
        public IActionResult DecryptedPassword(string id)
        {
            if (string.IsNullOrEmpty(id))
                return BadRequest("Invalid input");

            Password password = _passwordRepository.GetByID(id);
            if (password == null)
                return NotFound("Password not found");
            User user = _userRepository.GetById(password.UserID);
            if (user == null)
                return NotFound("User not found");

            string decryptedPassword = Encryption.Decrypt(password.EncryptedPassword, user.EncryptedPin);

            return Ok(decryptedPassword);
        } 
    } 
} 
