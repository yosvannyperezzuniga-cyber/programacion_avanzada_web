<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Actividades.aspx.cs" Inherits="Tarea1_GestionCondominal.Actividesdes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div id="view-condomino">
            <div class="form-group" style="max-width: 300px; margin-bottom: 20px;">
                <label>Filtrar por tipo:</label>
                <select id="filtroTipo" class="form-control" onchange="renderTablero()">
                    <option value="todos">Todos</option>
                    <option value="0">Reuniones</option>
                    <option value="1">Actividades Sociales</option>
                    <option value="2">Recordatorios</option>
                </select>
            </div>

            <div id="tablero" class="grid-tablero">
            </div>
        </div>
    </div>
    <div id="modalDetalle" class="modal">
        <div class="modal-content detalle-modal">
            <span class="close-button" onclick="document.getElementById('modalDetalle').style.display='none'">&times;</span>
            <div id="detalle-contenido">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn-cancel" onclick="document.getElementById('modalDetalle').style.display='none'">Cerrar</button>
            </div>
        </div>
    </div>

</asp:Content>

<asp:Content ID="ContentScripts" ContentPlaceHolderID="scripts" runat="server">
    <script>
        // Inicialización
        window.onload = function () {
            renderTablero();
        };

        function renderTablero() {
            const dataFromServer = <%= ActividadesJson %>;
            const tablero = document.getElementById('tablero');
            const filtro = document.getElementById('filtroTipo').value;
            tablero.innerHTML = '';

            dataFromServer
                .filter(a => filtro === 'todos' || a.Tipo == filtro)
                .forEach(a => {
                    const card = document.createElement('div');
                    card.className = 'card actividad-card';

                    card.onclick = () => abrirDetalleActividad(a);
                    let contenidoEspecial = "";
                    let badgeClass = "";
                    let tipoTexto = "";

                    // Configuración por tipo
                    if (a.Tipo == 0) {
                        badgeClass = "reunion"; tipoTexto = "Reunión";
                        const fecha = a.FechaHoraReunion ? new Date(parseInt(a.FechaHoraReunion.replace(/\D/g, ""))).toLocaleDateString("es-CR") : "N/A";
                        contenidoEspecial = `<p><i class="fa-solid fa-calendar-plus"></i> <strong>Fecha:</strong> ${fecha}</p>`;
                    }
                    else if (a.Tipo == 1) {
                        badgeClass = "social"; tipoTexto = "Actividad Social";
                        const inicio = a.FechaHoraInicio ? new Date(parseInt(a.FechaHoraInicio.replace(/\D/g, ""))).toLocaleDateString("es-CR") : "N/A";
                        contenidoEspecial = `<p><i class="fa-solid fa-calendar-plus"></i> <strong>Inicio:</strong> ${inicio}</p>`;
                    }
                    else {
                        badgeClass = "recordatorio"; tipoTexto = "Recordatorio";
                        contenidoEspecial = `<p>${a.Descripcion || ''}</p>`;
                    }

                    const fin = a.FechaPublicacionCierre ? new Date(parseInt(a.FechaPublicacionCierre.replace(/\D/g, ""))).toLocaleDateString("es-CR") : "N/A";

                    card.innerHTML = `
                        <span class="badge ${badgeClass}">${tipoTexto}</span>
                        <h3">${a.Titulo}</h3>
                        ${contenidoEspecial}
                        <p><i class="fa-solid fa-calendar-minus"></i> <strong>Cierre:</strong> ${fin}</p>
                        <p><i class="fa-regular fa-circle"></i> <strong>Estado:</strong> ${a.Estado}</p>
                    `;
                    tablero.appendChild(card);
                });
        }


        // Nueva función para mostrar el detalle
        function abrirDetalleActividad(actividad) {

            console.log(actividad);
            const modal = document.getElementById('modalDetalle');
            const contenido = document.getElementById('detalle-contenido');

            // Función auxiliar para fechas
            const fmt = (d) => d ? new Date(parseInt(d.replace(/\D/g, ""))).toLocaleString("es-CR") : 'N/A';

            let htmlDetalle = `
        <div class="detalle-header">
            <h2>${actividad.Titulo}</h2>
            <span class="badge">${actividad.Estado}</span>
        </div>
        <hr>
        <p><strong>Tipo:</strong> ${actividad.Tipo === 0 ? 'Reunión' : actividad.Tipo === 1 ? 'Social' : 'Recordatorio'}</p>`;

            // Campos específicos según el tipo
            if (actividad.Tipo === 0) {
                htmlDetalle += `
            <p><strong>Fecha y Hora:</strong> ${fmt(actividad.FechaHoraReunion)}</p>
            <p><strong>Ubicación:</strong> ${actividad.UbicacionPresencial || 'Virtual'}</p>
            <p><strong>Agenda:</strong> ${actividad.Agenda || 'No especificada'}</p>
            ${actividad.EnlaceVirtual ? `<a href="${actividad.EnlaceVirtual}" target="_blank" class="btn-link">Unirse a la reunión</a>` : ''}
        `;
            } else if (actividad.Tipo === 1) {
                htmlDetalle += `
            <p><strong>Inicio:</strong> ${fmt(actividad.FechaHoraInicio)}</p>
            <p><strong>Fin:</strong> ${fmt(actividad.FechaHoraFin)}</p>
            <p><strong>Formato:</strong> ${actividad.Formato === 0 ? 'Formal' : 'Informal'}</p>
            <p><strong>Instrucciones:</strong> ${actividad.InstruccionesDetalladas || 'Ninguna'}</p>
        `;
            } else {
                htmlDetalle += `<p><strong>Descripción:</strong> ${actividad.Descripcion}</p>`;
            }

            contenido.innerHTML = htmlDetalle;
            modal.style.display = 'block';
        }

    </script>
</asp:Content>
