using Microsoft.AspNetCore.Mvc.Rendering;
using System.Collections.Generic;
using System.Net.Http.Headers;
using SYSWEB.Entities;

namespace SYSWEB.Models
{
    public class ProductoModel : IProductoModel
    {
        private readonly HttpClient _httpClient;
        private readonly IConfiguration _configuration;
        private readonly IHttpContextAccessor _HttpContextAccessor;
        private string _urlApi;

        public ProductoModel(HttpClient httpClient, IConfiguration configuration, IHttpContextAccessor httpContextAccessor)
        {
            _httpClient = httpClient;
            _configuration = configuration;
            _HttpContextAccessor = httpContextAccessor;
            _urlApi = _configuration.GetSection("Llaves:urlApi").Value;
        }

        public List<ProductoEnt>? ConsultarProductos()
        {
            string url = _urlApi + "api/Producto/ConsultarProductos";
            var resp = _httpClient.GetAsync(url).Result;

            if (resp.IsSuccessStatusCode)
                return resp.Content.ReadFromJsonAsync<List<ProductoEnt>>().Result;
            else
                return null;
        }

        public long RegistrarProducto(ProductoEnt entidad)
        {
            string url = _urlApi + "api/Producto/RegistrarProducto";
            string token = _HttpContextAccessor.HttpContext.Session.GetString("TokenUsuario");

            _httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);
            JsonContent obj = JsonContent.Create(entidad);
            var resp = _httpClient.PostAsync(url, obj).Result;

            if (resp.IsSuccessStatusCode)
                return resp.Content.ReadFromJsonAsync<long>().Result;
            else
                return 0;
        }

        public int ActualizarEstadoProducto(ProductoEnt entidad)
        {
            string url = _urlApi + "api/Producto/ActualizarEstadoProducto";
            string token = _HttpContextAccessor.HttpContext.Session.GetString("TokenUsuario");

            JsonContent obj = JsonContent.Create(entidad);
            _httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);
            var resp = _httpClient.PutAsync(url, obj).Result;

            if (resp.IsSuccessStatusCode)
                return resp.Content.ReadFromJsonAsync<int>().Result;
            else
                return 0;
        }

        public int ActualizarProducto(ProductoEnt entidad)
        {
            string url = _urlApi + "api/Producto/ActualizarProducto";
            string token = _HttpContextAccessor.HttpContext.Session.GetString("TokenUsuario");

            JsonContent obj = JsonContent.Create(entidad);
            _httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);
            var resp = _httpClient.PutAsync(url, obj).Result;

            if (resp.IsSuccessStatusCode)
                return resp.Content.ReadFromJsonAsync<int>().Result;
            else
                return 0;
        }

    }
}
