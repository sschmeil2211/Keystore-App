using Microsoft.AspNetCore.Mvc; 
using KeystoreAPI.Repositories;
using KeystoreAPI.Models; 
using KeystoreAPI.Utils;

namespace KeystoreAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController(UserRepository userRepository) : ControllerBase
    {
         private readonly UserRepository _userRepository = userRepository;

        [HttpGet("{id}")]
        public IActionResult GetUserById(string id) 
        {
            if (string.IsNullOrEmpty(id))
                return BadRequest("Invalid ID");
            User existingUser = _userRepository.Get(new User() { ID = id });
            if(existingUser == null)
                return NotFound($"User {id} not found");
            return Ok(_userRepository.Get(new User(){ID = id}));
        }

        [HttpPost]
        public IActionResult CreateUser(UserDTO model)
        {
            if (model == null || string.IsNullOrEmpty(model.Username) || string.IsNullOrEmpty(model.Pin))
                return BadRequest("Invalid request");
            try
            {
                User user = new()
                {
                    ID = model.ID,
                    Username = model.Username,
                    EncryptedPin = Encryption.EncryptKey(model.Pin),
                };

                User addedUser = _userRepository.Add(user);
                return Ok(addedUser);
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error al crear UserBank: " + ex.Message);
                return StatusCode(500, "Error interno del servidor");
            } 
        }

        [HttpPost("ValidateData")]
        public IActionResult ValidateData(string id, string dataToValidate)
        {
            if (string.IsNullOrEmpty(id) || string.IsNullOrEmpty(dataToValidate))
                return BadRequest("Invalid input");

            User user = _userRepository.Get(new User { ID = id });
            if (user == null)
                return NotFound($"User {id} not found");

            byte[] encryptedPin = Encryption.EncryptKey(dataToValidate);
            if (user.EncryptedPin.SequenceEqual(encryptedPin))
                return Ok("PIN is correct");
            else
                return BadRequest("PIN is incorrect");
        }
    }
} 