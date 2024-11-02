using Microsoft.AspNetCore.Mvc;
using SYSWEB.Entities;
using SYSWEB.Models;

namespace WEBJN.Controllers
{
    [ResponseCache(NoStore = true, Duration = 0)]
    public class VentaController : Controller
    {
        private readonly IVentaModel _ventaModel;
        private readonly IBitacoraModel _bitacoraModel;

        public VentaController(IVentaModel ventaModel, IBitacoraModel bitacoraModel)
        {
            _ventaModel = ventaModel;
            _bitacoraModel = bitacoraModel; 
        }

       


    }
}
