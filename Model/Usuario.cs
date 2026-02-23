using System;

namespace Model
{

    [Serializable]
    public class Usuario
    {
        // 1. Tipo de identificación (Física, DIMEX o Pasaporte)
        public TipoIdentificacion TipoId { get; set; }

   
        public string Identificacion { get; set; }

  
        public string Nombre { get; set; }

    
        public string Apellidos { get; set; }

        // 5. Fecha de nacimiento
        public DateTime FechaNacimiento { get; set; }

        // 6. Número de filial
        public int NumeroFilial { get; set; }

        // 7. Tiene construcción o no
        public bool TieneConstruccion { get; set; }

    
        public string Email { get; set; }

      
        public string Password { get; set; }

        // 10. Aceptación de términos
        public bool AceptaTerminos { get; set; }

        public Acceso perfil { get; set; }
    }

    public enum TipoIdentificacion
    {
        Fisica,
        DIMEX,
        Pasaporte
    }

    public enum Acceso
    {
        Condomino,
        Administrador
    }
}
