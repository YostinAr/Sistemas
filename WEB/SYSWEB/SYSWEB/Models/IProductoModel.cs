using SYSWEB.Entities;

namespace SYSWEB.Models
{
    public interface IProductoModel
    {
        public List<ProductoEnt>? ConsultarProductos();

        public long RegistrarProducto(ProductoEnt entidad);

        public int ActualizarEstadoProducto(ProductoEnt entidad);

        public int ActualizarProducto(ProductoEnt entidad);

    }
}
