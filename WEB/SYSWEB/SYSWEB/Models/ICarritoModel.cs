﻿using SYSWEB.Entities;

namespace SYSWEB.Models
{
    public interface ICarritoModel
    {
        public long RegistrarCarrito(CarritoEnt entidad);

        public List<CarritoEnt>? ConsultarCarrito();

        public string PagarCarrito();

        public int EliminarProductoCarrito(long q);

        public List<FacturasEnt>? ConsultarFacturas();

        public List<FacturasEnt>? ConsultarDetalleFactura(long q);
    }
}
