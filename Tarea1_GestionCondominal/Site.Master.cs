using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Model;

namespace Tarea1_GestionCondominal
{
    public partial class SiteMaster : MasterPage
    {
        public Usuario user { get; set; }
        public string menu1 { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Usuario"] == null)
            {
    
                Response.Redirect("Login.aspx");
            }

            user = Session["Usuario"] as Usuario;

            switch (user.perfil)
            {
                case Acceso.Administrador:
                    menu1 = "Gestión de mensajes";
                    break;

                case Acceso.Condomino: // Suponiendo que tienes este valor en tu clase Acceso
                    menu1 = "Actividades del condominio";
                    break;

                default:
                    menu1 = "Actividades del condominio";
                    break;
            }

        }
    }
}