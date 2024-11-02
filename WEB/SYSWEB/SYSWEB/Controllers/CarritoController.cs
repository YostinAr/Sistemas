using Microsoft.AspNetCore.Mvc;
using SYSWEB.Entities;
using SYSWEB.Models;

namespace WEBJN.Controllers
{
    [ResponseCache(NoStore = true, Duration = 0)]
    public class CarritoController : Controller
    {
        private readonly ICarritoModel _carritoModel;
        private readonly IBitacoraModel _bitacoraModel;

        public CarritoController(ICarritoModel carritoModel, IBitacoraModel bitacoraModel)
        {
            _carritoModel = carritoModel;
            _bitacoraModel = bitacoraModel; 
        }

        [HttpPost]
        [FiltroSeguridad]
        public IActionResult RegistrarCarrito(long IdProducto, int cantidadComprar)
        {
            var entidad = new CarritoEnt();
            entidad.Cantidad = cantidadComprar;
            entidad.IdProducto = IdProducto;

            _carritoModel.RegistrarCarrito(entidad);

            var datos = _carritoModel.ConsultarCarrito();
            HttpContext.Session.SetString("Total", datos.Sum(x => x.Total).ToString());
            HttpContext.Session.SetString("Cantidad", datos.Sum(x => x.Cantidad).ToString());

            return Json("OK");
        }

        [HttpGet]
        [FiltroSeguridad]
        public IActionResult ConsultarCarrito()
        {
            var datos = _carritoModel.ConsultarCarrito();
            return View(datos);
        }

        [HttpPost]
        [FiltroSeguridad]
        public IActionResult PagarCarrito()
        {
            try
            {
                var respuesta = _carritoModel.PagarCarrito();
                var datos = _carritoModel.ConsultarCarrito();
                HttpContext.Session.SetString("Total", datos.Sum(x => x.Total).ToString());
                HttpContext.Session.SetString("Cantidad", datos.Sum(x => x.Cantidad).ToString());

                if (respuesta.Contains("verifique"))
                {
                    ViewBag.MensajePantalla = respuesta;
                    return View("ConsultarCarrito", datos);
                }
              
                 return RedirectToAction("Index", "Login");
            }
            catch (Exception ex)
            {
                var entidad = new BitacoraEnt();
                entidad.Accion = "PagarCarrito";
                entidad.Error = ex.Message;

                _bitacoraModel.RegistrarErrorBitacora(entidad);
                return View("~/Views/Shared/Error.cshtml");
            }
        }

        [HttpGet]
        [FiltroSeguridad]
        public IActionResult EliminarProductoCarrito(long q)
        {
            _carritoModel.EliminarProductoCarrito(q);

            var datos = _carritoModel.ConsultarCarrito();
            HttpContext.Session.SetString("Total", datos.Sum(x => x.Total).ToString());
            HttpContext.Session.SetString("Cantidad", datos.Sum(x => x.Cantidad).ToString());

            return RedirectToAction("ConsultarCarrito", "Carrito");
        }

        [HttpGet]
        [FiltroSeguridad]
        public IActionResult ConsultarFacturas()
        {
            var datos = _carritoModel.ConsultarFacturas();
            return View(datos);
        }

        [HttpGet]
        [FiltroSeguridad]
        public IActionResult ConsultarDetalleFactura(long q)
        {
            var datos = _carritoModel.ConsultarDetalleFactura(q);
            return View(datos);
        }

        [HttpGet]
        [FiltroSeguridad]
        public IActionResult GetChartData()
        {
            var chartData = new
            {
                labels = new[] { "Enero", "Febrero", "Marzo", "Abril", "Mayo" },
                datasets = new[]
                {
            new
            {
                label = "Ventas 2023",
                backgroundColor = "rgba(54, 162, 235, 0.2)", // Color de fondo
                borderColor = "rgba(54, 162, 235, 1)", // Color del borde
                borderWidth = 2,
                hoverBackgroundColor = "rgba(54, 162, 235, 0.7)", // Color de fondo al pasar el mouse
                hoverBorderColor = "rgba(54, 162, 235, 1)", // Color del borde al pasar el mouse
                data = new[] { 65, 59, 80, 81, 56 }
            }
        }
            };

            return Json(chartData);
        }


    }
}
