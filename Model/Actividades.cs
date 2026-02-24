using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public enum TipoActividad { Reunion, ActividadSocial, Recordatorio }
    public enum FormatoActividad { Formal, Informal }

    [Serializable]
    public abstract class ActividadBase
    {
        public string Titulo { get; set; }
        public bool EsParaTodosLosCondominos { get; set; }
        // Lista de filiales si EsParaTodosLosCondominos es false
        public List<int> FilialesSeleccionadas { get; set; }
        public DateTime FechaPublicacionInicio { get; set; }
        public DateTime FechaPublicacionCierre { get; set; }
        public abstract TipoActividad Tipo { get; }
        public string Estado { get; set; }
    }

    [Serializable]
    public class Reunion : ActividadBase
    {
        public override TipoActividad Tipo => TipoActividad.Reunion;
        public DateTime FechaHoraReunion { get; set; }
        public TimeSpan DuracionEstimada { get; set; }
        public string Agenda { get; set; }
        public string UbicacionPresencial { get; set; }
        public string EnlaceVirtual { get; set; }
    }

    [Serializable]
    public class ActividadSocial : ActividadBase
    {
        public override TipoActividad Tipo => TipoActividad.ActividadSocial;
        public DateTime FechaHoraInicio { get; set; }
        public DateTime FechaHoraFin { get; set; }
        public string Ubicacion { get; set; }
        public FormatoActividad Formato { get; set; }
        public string InstruccionesDetalladas { get; set; }
    }

    [Serializable]
    public class Recordatorio : ActividadBase
    {
        public override TipoActividad Tipo => TipoActividad.Recordatorio;
        public string Descripcion { get; set; }
    }
}
