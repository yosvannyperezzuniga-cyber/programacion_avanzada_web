using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Model;

namespace Tarea1_GestionCondominal
{
    public partial class Login2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UsuariosSistema"] == null)
            {
                List<Usuario> listaUsuarios = new List<Usuario>
{
    new Usuario { TipoId = TipoIdentificacion.Fisica, Identificacion = "1-1111-1111", Nombre = "Juan", Apellidos = "Pérez Solano", FechaNacimiento = new DateTime(1985, 4, 12), NumeroFilial = 101, TieneConstruccion = true, Email = "juan@mail.com", Password = "123456789", AceptaTerminos = true, perfil = Acceso.Administrador },

    new Usuario { TipoId = TipoIdentificacion.DIMEX, Identificacion = "2-2222-2222", Nombre = "María", Apellidos = "Castro Mora", FechaNacimiento = new DateTime(1992, 8, 25), NumeroFilial = 102, TieneConstruccion = false, Email = "maria@mail.com", Password = "123456789", AceptaTerminos = true, perfil = Acceso.Condomino },

    new Usuario { TipoId = TipoIdentificacion.Pasaporte, Identificacion = "3-3333-3333", Nombre = "John", Apellidos = "Smith Doe", FechaNacimiento = new DateTime(1980, 1, 15), NumeroFilial = 103, TieneConstruccion = true, Email = "john@mail.com", Password = "hashed_password", AceptaTerminos = true, perfil = Acceso.Condomino },

    new Usuario { TipoId = TipoIdentificacion.Fisica, Identificacion = "4-4444-4444", Nombre = "Luis", Apellidos = "González Vega", FechaNacimiento = new DateTime(1975, 12, 5), NumeroFilial = 104, TieneConstruccion = true, Email = "luis@mail.com", Password = "hashed_password", AceptaTerminos = true, perfil = Acceso.Condomino },

    new Usuario { TipoId = TipoIdentificacion.Fisica, Identificacion = "5-5555-5555", Nombre = "Ana", Apellidos = "Rojas Chaves", FechaNacimiento = new DateTime(1995, 6, 30), NumeroFilial = 105, TieneConstruccion = false, Email = "ana@mail.com", Password = "hashed_password", AceptaTerminos = true, perfil = Acceso.Condomino },

    new Usuario { TipoId = TipoIdentificacion.DIMEX, Identificacion = "6-6666-6666", Nombre = "Carlos", Apellidos = "Soto Ruiz", FechaNacimiento = new DateTime(1988, 3, 20), NumeroFilial = 106, TieneConstruccion = true, Email = "carlos@mail.com", Password = "hashed_password", AceptaTerminos = true, perfil = Acceso.Condomino },

    new Usuario { TipoId = TipoIdentificacion.Pasaporte, Identificacion = "7-7777-7777", Nombre = "Elena", Apellidos = "Vargas Lizano", FechaNacimiento = new DateTime(1990, 11, 10), NumeroFilial = 107, TieneConstruccion = false, Email = "elena@mail.com", Password = "hashed_password", AceptaTerminos = true, perfil = Acceso.Condomino },

    new Usuario { TipoId = TipoIdentificacion.Fisica, Identificacion = "8-8888-8888", Nombre = "Pedro", Apellidos = "Méndez Alpízar", FechaNacimiento = new DateTime(1982, 7, 18), NumeroFilial = 108, TieneConstruccion = true, Email = "pedro@mail.com", Password = "hashed_password", AceptaTerminos = true, perfil = Acceso.Administrador },

    new Usuario { TipoId = TipoIdentificacion.Fisica, Identificacion = "9-9999-9999", Nombre = "Sofía", Apellidos = "Miranda Quesada", FechaNacimiento = new DateTime(1998, 9, 5), NumeroFilial = 109, TieneConstruccion = false, Email = "sofia@mail.com", Password = "hashed_password", AceptaTerminos = true, perfil = Acceso.Condomino },

    new Usuario { TipoId = TipoIdentificacion.DIMEX, Identificacion = "1-0101-0101", Nombre = "Jorge", Apellidos = "Salas Porras", FechaNacimiento = new DateTime(1970, 2, 28), NumeroFilial = 110, TieneConstruccion = true, Email = "jorge@mail.com", Password = "hashed_password", AceptaTerminos = true, perfil = Acceso.Condomino }
};

                Session["UsuariosSistema"] = listaUsuarios;
            }



        }

        protected void btn_login_Click(object sender, EventArgs e)
        {
            List<Usuario> lista = Session["UsuariosSistema"] as List<Usuario>;


            if (lista != null)
            {
                // 2. Buscar el primer usuario que coincida con correo Y contraseña
                // Usamos StringComparison para evitar problemas de mayúsculas/minúsculas en el email
                Usuario usuarioEncontrado = lista.FirstOrDefault(u =>
                    u.Email.Equals(email.Text, StringComparison.OrdinalIgnoreCase) &&
                    u.Password == password.Text);

                if (usuarioEncontrado.Email.Equals( email.Text, StringComparison.OrdinalIgnoreCase)) {
                    Session["Usuario"] = usuarioEncontrado;
                    Response.Redirect("Default.aspx");
                }
            }


        }

        protected void btn_register_Click(object sender, EventArgs e)
        {
            Response.Redirect("Registro.aspx");
        }
    }
}