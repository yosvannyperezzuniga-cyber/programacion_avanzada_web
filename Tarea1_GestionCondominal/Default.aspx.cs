using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Model;

namespace Tarea1_GestionCondominal
{
    public partial class _Default : Page
    {
        public String perfil;
        public String TotalActividades;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) {

                List<ActividadBase> lista;
                if (Session["Usuario"] == null)
                {
                    // Si la sesión es nula, redirigir al login
                    Response.Redirect("Login.aspx");
                }

                if (Session["actividades"] != null)
                {
                    lista = Session["actividades"] as List<ActividadBase>;
                    TotalActividades = lista.Count.ToString();
                }
                else {

                  
                    List<ActividadBase> listaActividades = new List<ActividadBase>();

 
                    listaActividades.Add(new Reunion
                    {
                        Titulo = "Asamblea General Ordinaria",
                        EsParaTodosLosCondominos = true,
                        FechaPublicacionInicio = DateTime.Now,
                        FechaPublicacionCierre = DateTime.Now.AddDays(7),
                        FechaHoraReunion = new DateTime(2024, 10, 20, 18, 0, 0),
                        DuracionEstimada = TimeSpan.FromHours(2),
                        Agenda = "1. Lectura de actas. 2. Presupuesto 2025.",
                        EnlaceVirtual = "https://zoom.us/j/123456789",
                        UbicacionPresencial = "N/A",
                        Estado = "Próxima"
                    });

     
                    listaActividades.Add(new ActividadSocial
                    {
                        Titulo = "Fiesta de Halloween",
                        EsParaTodosLosCondominos = true,
                        FechaPublicacionInicio = DateTime.Now,
                        FechaPublicacionCierre = new DateTime(2024, 10, 31),
                        FechaHoraInicio = new DateTime(2024, 10, 31, 19, 0, 0),
                        FechaHoraFin = new DateTime(2024, 10, 31, 23, 59, 0),
                        Ubicacion = "Casa Club",
                        Formato = FormatoActividad.Informal,
                        InstruccionesDetalladas = "Venir con disfraz. El condominio pone las bebidas.",
                        Estado = "Finalizada"

                    });

 
                    listaActividades.Add(new Recordatorio
                    {
                        Titulo = "Corte de Agua Programado",
                        EsParaTodosLosCondominos = true,
                        FechaPublicacionInicio = DateTime.Now,
                        FechaPublicacionCierre = DateTime.Now.AddDays(2),
                        Descripcion = "Se suspenderá el servicio el martes de 8am a 12md por mantenimiento de tuberías.",
                        Estado = "En curso"
                    });

         
                    listaActividades.Add(new Reunion
                    {
                        Titulo = "Reunión de Comité de Seguridad",
                        EsParaTodosLosCondominos = false,
                        FilialesSeleccionadas = new List<int> { 12, 45, 67 },
                        FechaPublicacionInicio = DateTime.Now,
                        FechaPublicacionCierre = DateTime.Now.AddDays(3),
                        FechaHoraReunion = new DateTime(2024, 10, 15, 17, 0, 0),
                        DuracionEstimada = TimeSpan.FromMinutes(45),
                        Agenda = "Revisión de cámaras y nuevas rondas de vigilancia.",
                        UbicacionPresencial = "Oficina de Administración",
                        Estado = "Próxima"
                    });

  
                    listaActividades.Add(new ActividadSocial
                    {
                        Titulo = "Cena de Gala de Fin de Año",
                        EsParaTodosLosCondominos = true,
                        FechaPublicacionInicio = new DateTime(2024, 11, 01),
                        FechaPublicacionCierre = new DateTime(2024, 12, 15),
                        FechaHoraInicio = new DateTime(2024, 12, 15, 20, 0, 0),
                        FechaHoraFin = new DateTime(2024, 12, 16, 02, 0, 0),
                        Ubicacion = "Salón Principal",
                        Formato = FormatoActividad.Formal,
                        InstruccionesDetalladas = "Código de vestimenta: Traje formal. Requiere confirmar asistencia.",
                        Estado = "Finalizada"
                    });


                    Session["actividades"] = listaActividades;
                    TotalActividades = listaActividades.Count.ToString();
                }
                    Usuario usuario = Session["Usuario"] as Usuario;
                perfil = usuario.perfil.ToString();
            }

        }
    }
}