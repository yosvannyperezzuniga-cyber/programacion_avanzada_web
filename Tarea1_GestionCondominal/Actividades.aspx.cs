using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using Model;

namespace Tarea1_GestionCondominal
{
    public partial class Actividesdes : System.Web.UI.Page
    {
        public string ActividadesJson = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                List<ActividadBase> lista = Session["actividades"] as List<ActividadBase>;
                var serializer = new JavaScriptSerializer();
                ActividadesJson = serializer.Serialize(lista);
            }
        }
    }
}