﻿using Microsoft.AspNetCore.Mvc;
using Dapper;
using System.Data;
using System.Data.SqlClient;
using API.Entities;
using System.Net.Mail;
using System.Text;
using System.Security.Cryptography;
using Microsoft.AspNetCore.Authorization;
using API.Models;

namespace API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LoginController : ControllerBase
    {
        private readonly IConfiguration _configuration;
        private readonly IUtilitarios _utilitarios;
        private string _connection;

        public LoginController(IConfiguration configuration, IUtilitarios utilitarios)
        {
            _configuration = configuration;
            _connection = _configuration.GetConnectionString("DefaultConnection");
            _utilitarios = utilitarios;
        }

        [HttpPost]
        [AllowAnonymous]
        [Route("IniciarSesion")]
        public IActionResult IniciarSesion(UsuarioEnt entidad)
        {
            try
            {
                using (var context = new SqlConnection(_connection))
                {
                    var datos = context.Query<UsuarioEnt>("IniciarSesion", 
                        new { entidad.usuario, entidad.contrasenna }, 
                        commandType: CommandType.StoredProcedure).FirstOrDefault();

                    if (datos != null)
                    {
                        datos.Token = _utilitarios.GenerarToken(datos.IdUsuario.ToString(), datos.ConRol.ToString());
                        return Ok(datos);
                    }
                    else
                    {
                        return BadRequest("No se logró validar su información");
                    }
                    
                }
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpPost]
        [AllowAnonymous]
        [Route("RegistrarCuenta")]
        public IActionResult RegistrarCuenta(UsuarioEnt entidad)
        {
            try
            {
                using (var context = new SqlConnection(_connection))
                {
                    var datos = context.Execute("RegistrarCuenta",
                        new { entidad.identificacion, entidad.nombre, entidad.usuario, entidad.correo, entidad.contrasenna },
                        commandType: CommandType.StoredProcedure);

                    return Ok(datos);
                }
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpPost]
        [AllowAnonymous]
        [Route("RecuperarCuenta")]
        public IActionResult RecuperarCuenta(UsuarioEnt entidad)
        {
            try
            {
                using (var context = new SqlConnection(_connection))
                {
                    var datos = context.Query<UsuarioEnt>("RecuperarCuenta",
                        new { entidad.usuario },
                        commandType: CommandType.StoredProcedure).FirstOrDefault();

                    if (datos != null)
                    {
                        string contrasennaTemporal = _utilitarios.GenerarCodigo();
                        string contenido = _utilitarios.ArmarHTML(datos, contrasennaTemporal);

                        context.Execute("ActualizarClaveTemporal",
                            new { datos.IdUsuario, contrasennaTemporal },
                            commandType: CommandType.StoredProcedure);

                        _utilitarios.EnviarCorreo(datos.correo, "Restaurar Contraseña", contenido);
                        return Ok(1);
                    }
                    else
                        return Ok(0);
                }
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpPut]
        [AllowAnonymous]
        [Route("CambiarClaveCuenta")]
        public IActionResult CambiarClaveCuenta(UsuarioEnt entidad)
        {
            try
            {
                using (var context = new SqlConnection(_connection))
                {
                    entidad.IdUsuario = long.Parse(_utilitarios.Decrypt(entidad.IdUsuarioSeguro));

                    var datos = context.Execute("CambiarClaveCuenta",
                        new { entidad.IdUsuario, entidad.contrasennaTemporal, entidad.contrasenna },
                        commandType: CommandType.StoredProcedure);

                    return Ok(1);
                }
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

    }
}
