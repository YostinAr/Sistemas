﻿using API.Entities;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Data.Common;
using System.Data.SqlClient;
using System.Data;
using System.IdentityModel.Tokens.Jwt;
using System.Net.Mail;
using System.Runtime.InteropServices;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;
using Dapper;

namespace API.Models
{
    public class Utilitarios : IUtilitarios
    {
        private readonly IConfiguration _configuration;
        private IHostEnvironment _hostingEnvironment;

        public Utilitarios(IConfiguration configuration, IHostEnvironment hostingEnvironment)
        {
            _configuration = configuration;
            _hostingEnvironment = hostingEnvironment;
        }

        public string ArmarHTML(UsuarioEnt datos, string claveTemporal)
        {
            string rutaArchivo = Path.Combine(_hostingEnvironment.ContentRootPath, "CorreosTemplate\\Contrasenna.html");
            string htmlArchivo = File.ReadAllText(rutaArchivo);
            htmlArchivo = htmlArchivo.Replace("@@Nombre", datos.nombre);
            htmlArchivo = htmlArchivo.Replace("@@ClaveTemporal", claveTemporal);
            htmlArchivo = htmlArchivo.Replace("@@Link", "https://localhost:7245/Login/CambiarClaveCuenta?q=" + Encrypt(datos.IdUsuario.ToString()));

            return htmlArchivo;
        }

        public string GenerarCodigo()
        {
            int length = 4;
            const string valid = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
            StringBuilder res = new StringBuilder();
            Random rnd = new Random();
            while (0 < length--)
            {
                res.Append(valid[rnd.Next(valid.Length)]);
            }
            return res.ToString();
        }

        public void EnviarCorreo(string Destinatario, string Asunto, string Mensaje)
        {
            string correoSMTP = _configuration.GetSection("Llaves:correoSMTP").Value;
            string claveSMTP = _configuration.GetSection("Llaves:claveSMTP").Value;

            MailMessage msg = new MailMessage();
            msg.To.Add(new MailAddress(Destinatario));
            msg.From = new MailAddress(correoSMTP);
            msg.Subject = Asunto;
            msg.Body = Mensaje;
            msg.IsBodyHtml = true;

            SmtpClient client = new SmtpClient();
            client.UseDefaultCredentials = false;
            client.Credentials = new System.Net.NetworkCredential(correoSMTP, claveSMTP);
            client.Port = 587;
            client.Host = "smtp.office365.com";
            client.DeliveryMethod = SmtpDeliveryMethod.Network;
            client.EnableSsl = true;
            client.Send(msg);
        }

        public string GenerarToken(string idUsuario, string conRol)
        {
            List<Claim> claims = new List<Claim>();
            claims.Add(new Claim("username", Encrypt(idUsuario)));
            claims.Add(new Claim("userrol", Encrypt(conRol)));

            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes("Ty1UELmVFKQmMD4af0a4jvfZS30cXu3U"));
            var cred = new SigningCredentials(key, SecurityAlgorithms.HmacSha512Signature);

            var token = new JwtSecurityToken(
                claims: claims,
                expires: DateTime.UtcNow.AddMinutes(10),
                signingCredentials: cred);

            return new JwtSecurityTokenHandler().WriteToken(token);
        }

        public long ObtenerUsuario(IEnumerable<Claim> valores)
        {
            var claims = valores.Select(Claim => new { Claim.Type, Claim.Value }).ToArray();
            return long.Parse(Decrypt(claims.Where(x => x.Type == "username").ToList().FirstOrDefault().Value));
        }

        public bool IsAdmin(IEnumerable<Claim> valores)
        {
            var claims = valores.Select(Claim => new { Claim.Type, Claim.Value }).ToArray();
            var userrol = Decrypt(claims.Where(x => x.Type == "userrol").ToList().FirstOrDefault().Value);

            if (userrol == "1")
                return true;

            return false;
        }

        public string Encrypt(string texto)
        {
            byte[] iv = new byte[16];
            byte[] array;

            using (Aes aes = Aes.Create())
            {
                aes.Key = Encoding.UTF8.GetBytes("EzfjS0IHnNSjv0jo");
                aes.IV = iv;

                ICryptoTransform encryptor = aes.CreateEncryptor(aes.Key, aes.IV);

                using (MemoryStream memoryStream = new MemoryStream())
                {
                    using (CryptoStream cryptoStream = new CryptoStream(memoryStream, encryptor, CryptoStreamMode.Write))
                    {
                        using (StreamWriter streamWriter = new StreamWriter(cryptoStream))
                        {
                            streamWriter.Write(texto);
                        }

                        array = memoryStream.ToArray();
                    }
                }
            }

            return Convert.ToBase64String(array);
        }

        public string Decrypt(string texto)
        {
            byte[] iv = new byte[16];
            byte[] buffer = Convert.FromBase64String(texto);

            using (Aes aes = Aes.Create())
            {
                aes.Key = Encoding.UTF8.GetBytes("EzfjS0IHnNSjv0jo");
                aes.IV = iv;
                ICryptoTransform decryptor = aes.CreateDecryptor(aes.Key, aes.IV);

                using (MemoryStream memoryStream = new MemoryStream(buffer))
                {
                    using (CryptoStream cryptoStream = new CryptoStream(memoryStream, decryptor, CryptoStreamMode.Read))
                    {
                        using (StreamReader streamReader = new StreamReader(cryptoStream))
                        {
                            return streamReader.ReadToEnd();
                        }
                    }
                }
            }
        }

    }
}
