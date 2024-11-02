using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.SignalR.Protocol;
using SYSWEB.Entities;
using SYSWEB.Models;

namespace WEBJN.Controllers
{
    [ResponseCache(NoStore = true, Duration = 0)]
    public class ProductoController : Controller
    {
        private readonly IProductoModel _productoModel;
        private readonly ICarritoModel _carritoModel;
        private IHostEnvironment _hostingEnvironment;

        public ProductoController(IProductoModel productoModel, ICarritoModel carritoModel, IHostEnvironment hostingEnvironment)
        {
            _productoModel = productoModel;
            _carritoModel = carritoModel;
            _hostingEnvironment = hostingEnvironment;
        }

        [HttpGet]
        [FiltroSeguridad]
        public IActionResult ConsultarProductos()
        {
            var datos = _productoModel.ConsultarProductos();
            return View(datos);
        }

        [HttpGet]
        [FiltroSeguridad]
        public IActionResult RegistrarProducto()
        {
            return View();
        }

        [HttpPost]
        [FiltroSeguridad]
        public IActionResult RegistrarProducto(IFormFile ImgProducto, ProductoEnt entidad)
        {
            string ext = Path.GetExtension(Path.GetFileName(ImgProducto.FileName));
            string folder = Path.Combine(_hostingEnvironment.ContentRootPath, "wwwroot\\images");

            if (ext.ToLower() != ".png")
            {
                ViewBag.MensajePantalla = "La imagen debe ser .png";
                return View();
            }

            var IdProducto = _productoModel.RegistrarProducto(entidad);

            if (IdProducto > 0)
            {
                string archivo = Path.Combine(folder, IdProducto + ext);
                using (Stream fileStream = new FileStream(archivo, FileMode.Create))
                {
                    ImgProducto.CopyTo(fileStream);
                }

                return RedirectToAction("ConsultarProductos", "Producto");
            }

            ViewBag.MensajePantalla = "No se pudo registrar su producto";
            return View();

        }


        [HttpGet]
        [FiltroSeguridad]
        public IActionResult ActualizarEstadoProducto(long q)
        {
            var entidad = new ProductoEnt();
            entidad.IdProducto = q;

            _productoModel.ActualizarEstadoProducto(entidad);
            return RedirectToAction("ConsultarProductos", "Producto");
        }

        [HttpGet]
        [FiltroSeguridad]
        public IActionResult ActualizarProducto(long q)
        {
            var datos = _productoModel.ConsultarProductos().Where(x => x.IdProducto == q).FirstOrDefault();
            return View(datos);
        }

        [HttpPost]
        [FiltroSeguridad]
        public IActionResult ActualizarProducto(IFormFile ImgProducto, ProductoEnt entidad)
        {
            string ext = string.Empty;
            string folder = string.Empty;
            string archivo = string.Empty;

            if (ImgProducto != null)
            { 
                ext = Path.GetExtension(Path.GetFileName(ImgProducto.FileName));
                folder = Path.Combine(_hostingEnvironment.ContentRootPath, "wwwroot\\images");
                archivo = Path.Combine(folder, entidad.IdProducto + ext);

                if (ext.ToLower() != ".png")
                {
                    ViewBag.MensajePantalla = "La imagen debe ser .png";
                    return View();
                }
            }

            var resp = _productoModel.ActualizarProducto(entidad);

            var datos = _carritoModel.ConsultarCarrito();
            HttpContext.Session.SetString("Total", datos.Sum(x => x.Total).ToString());
            HttpContext.Session.SetString("Cantidad", datos.Sum(x => x.Cantidad).ToString());

            if (resp == 1)
            {
                if (ImgProducto != null)
                {                    
                    using (Stream fileStream = new FileStream(archivo, FileMode.Create))
                    {
                        ImgProducto.CopyTo(fileStream);
                    }
                }

                return RedirectToAction("ConsultarProductos", "Producto");
            }
            else
            {
                ViewBag.MensajePantalla = "No se pudo actualizar el producto";
                return View();
            }
        }

    }
}
