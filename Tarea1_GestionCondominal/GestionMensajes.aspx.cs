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
    public partial class GestionMensajes : System.Web.UI.Page
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
            else
            {
                
                string eventTarget = Request.Form["__EVENTTARGET"];
                string eventArgument = Request.Form["__EVENTARGUMENT"];

                if (eventTarget == "EliminarActividad")
                {
                    int index = int.Parse(eventArgument);
                    EliminarActividadProceso(index);
                }
            }
        }

        private void EliminarActividadProceso(int index)
        {
            try
            {
                
                List<ActividadBase> lista = Session["actividades"] as List<ActividadBase>;

                if (lista != null && index < lista.Count)
                {

                    lista.RemoveAt(index);

    
                    Session["actividades"] = lista;

                    Response.Redirect(Request.RawUrl);

                }
            }
            catch (Exception ex)
            {
        
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Error al eliminar: {ex.Message}');", true);
            }
        }

        protected void Save_Click(object sender, EventArgs e)
        {
            int index = int.Parse(hfEditIndex.Value);
            List<ActividadBase> lista = Session["ListaActividades"] as List<ActividadBase> ?? new List<ActividadBase>();

            ActividadBase actividad;
                string tipoSeleccionado = ddlTipoActividad.SelectedValue;

  
                switch (tipoSeleccionado)
                {
                    case "Reunion":
                        actividad = new Reunion()
                        {
                            FechaHoraReunion = DateTime.Parse(txtReunionFecha.Text),
                            // Nota: Para DuracionEstimada (TimeSpan), podrías necesitar un formato específico 
                            // o un parsing manual si es un string libre. Aquí un ejemplo simple:
                            DuracionEstimada = TimeSpan.FromHours(2),
                            Agenda = txtReunionAgenda.Text,
                            UbicacionPresencial = txtReunionUbicacion.Text,
                            EnlaceVirtual = txtReunionLink.Text
                        };
                        break;

                    case "Actividad social":
                        actividad = new ActividadSocial()
                        {
                            FechaHoraInicio = DateTime.Parse(txtSocialInicio.Text),
                            FechaHoraFin = DateTime.Parse(txtSocialFin.Text),
                            Ubicacion = txtSocialUbicacion.Text,
                            Formato = (FormatoActividad)Enum.Parse(typeof(FormatoActividad), ddlSocialFormato.SelectedValue),
                            InstruccionesDetalladas = txtSocialInstrucciones.Text
                        };
                        break;

                    case "Recordatorio":
                        actividad = new Recordatorio()
                        {
                            Descripcion = txtRecordatorioDesc.Text
                        };
                        break;

                    default:
                          return;
                }

                actividad.Titulo = txtTitulo.Text;
                actividad.FechaPublicacionInicio = DateTime.Now; 
                actividad.FechaPublicacionCierre = DateTime.Parse(txtFechaCierre.Text);
                actividad.EsParaTodosLosCondominos = (ddlDestinatarios.SelectedValue == "todos");
                actividad.Estado = "Pendiente"; 

                if (!actividad.EsParaTodosLosCondominos)
                {
                    actividad.FilialesSeleccionadas = new List<int>();

                    
                    foreach (ListItem item in lbFiliales.Items)
                    {
                        if (item.Selected)
                        {
                            actividad.FilialesSeleccionadas.Add(int.Parse(item.Value));
                        }
                    }

     
                    if (actividad.FilialesSeleccionadas.Count == 0)
                    {

                        return;
                    }
                }

            if (index == -1)
            {
                
                lista.Add(actividad);
            }
            else
            {
           
                lista[index] = actividad;
                hfEditIndex.Value = "-1"; 
            }
            Session["ListaActividades"] = lista;
            Response.Redirect(Request.RawUrl);

        }
    }
}