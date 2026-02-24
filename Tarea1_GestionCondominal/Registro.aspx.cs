using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Model;

namespace Tarea1_GestionCondominal
{
    public partial class Registro : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_finalizar_registro_Click(object sender, EventArgs e)
        {
            List<Usuario> lista = new List<Usuario>();
  TipoIdentificacion tipoSeleccionado;
            switch (tipoId.SelectedValue)
            {
                case "fisica": tipoSeleccionado = TipoIdentificacion.Fisica; break;
                case "dimex": tipoSeleccionado = TipoIdentificacion.DIMEX; break; // Ajustar según tu Enum
                case "pasaporte": tipoSeleccionado = TipoIdentificacion.Pasaporte; break;
                default: tipoSeleccionado = TipoIdentificacion.Fisica; break;
            }

            if (Session["UsuariosSistema"] != null)
            {
                // La sesión existe, ahora la recuperamos con un "cast"
                lista = (List<Usuario>)Session["UsuariosSistema"];

                if (lista.Count > 0)
                {
                  
                   


                    lista.Add(new Usuario
                    {
                        perfil = Acceso.Condomino,
                        TipoId = tipoSeleccionado,
                        Identificacion = identificacion.Text.Trim(),
                        Nombre = nombre.Text.Trim(),
                        Apellidos = apellidos.Text.Trim(),
                        FechaNacimiento = DateTime.Parse(fechaNacimiento.Text),
                        NumeroFilial = int.Parse(numFilial.Text),
                        TieneConstruccion = rbConstruccion.SelectedValue == "si",
                        Email = email.Text.Trim(),
                        Password = password.Text,
                        AceptaTerminos = terminos.Checked,
                    });

                    Session["UsuariosSistema"] = lista;
                    Response.Redirect("Login.aspx");
                }
            }
            else
            {
         


                lista.Add(new Usuario
                {
                    perfil = Acceso.Condomino,
                    TipoId = tipoSeleccionado,
                    Identificacion = identificacion.Text.Trim(),
                    Nombre = nombre.Text.Trim(),
                    Apellidos = apellidos.Text.Trim(),
                    FechaNacimiento = DateTime.Parse(fechaNacimiento.Text),
                    NumeroFilial = int.Parse(numFilial.Text),
                    TieneConstruccion = rbConstruccion.SelectedValue == "si",
                    Email = email.Text.Trim(),
                    Password = password.Text,
                    AceptaTerminos = terminos.Checked,
                });

          
            }

            Session["UsuariosSistema"] = lista;
            Response.Redirect("Login.aspx");
        }
    }
}