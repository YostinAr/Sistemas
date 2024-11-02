namespace SYSWEB.Entities
{
    public class ProductoEnt
    {
        public long IdProducto { get; set; }
        public string Nombre { get; set; } = string.Empty;
        public string Descripcion { get; set; } = string.Empty;
        public decimal Precio { get; set; }
        public int Cantidad { get; set; }
        public bool Estado { get; set; }
        public string Imagen { get; set; } = string.Empty;
    }
}
