<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Tarea1_GestionCondominal._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
<div class="cards-grid">
    <div id="card-actividades" class="card" onclick="redirect('Actividades.aspx')" style="display:none;">
        <h4>Actividades del condominio</h4>
        <div class="value"><%= TotalActividades %></div>
    </div>

    <div id="card-gestion" class="card" onclick="redirect('GestionMensajes.aspx')" style="display:none;">
        <h4>Gestión de mensajes</h4>
         <div class="value"><%= TotalActividades %></div>
    </div>
</div>

</asp:Content>
<asp:Content ID="scripts" ContentPlaceHolderID="scripts" runat="server">
 <script src="Scripts/redirect.js" type="text/javascript"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            // Obtenemos el perfil desde ASP.NET (puedes pasarlo vía una variable global o HiddenField)
            const perfilUsuario = "<%= perfil %>";

        const cardActividades = document.getElementById('card-actividades');
        const cardGestion = document.getElementById('card-gestion');
        if (perfilUsuario === "Administrador") {
            // El Admin ve la gestión de mensajes
            cardGestion.style.display = "block";
            cardActividades.style.display = "none";
        } else if (perfilUsuario === "Condomino") {
            // El Condómino solo ve las actividades
            cardActividades.style.display = "block";
            cardGestion.style.display = "none";
        }
    });

</script>
</asp:Content>
