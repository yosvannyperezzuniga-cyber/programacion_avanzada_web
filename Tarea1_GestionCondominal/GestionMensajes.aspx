<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GestionMensajes.aspx.cs" Inherits="Tarea1_GestionCondominal.GestionMensajes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="header" style="display: flex; justify-content: space-between; align-items: center;">
        <h1>Gestión de Mensajes</h1>
        <button class="btn btn-primary" onclick="openModal()">+ Crear Nuevo Mensaje</button>
    </div>
    <div class="card">
        <h3>Mensajes Activos / Programados</h3>
        <table width="100%" cellpadding="10">
            <thead>
                <tr style="text-align: left; background: #f8fafc;">
                    <th>Título</th>
                    <th>Tipo</th>
                    <th>Publicación</th>
                    <th>Estado</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody id="lista-admin">
            </tbody>
        </table>
    </div>
    <asp:HiddenField ID="hfEditIndex" runat="server" Value="-1" />
    <div id="modalForm" class="modal">
        <div class="modal-content">
            <h2 id="modalTitle">Nuevo Mensaje</h2>
            <form id="mainForm">
                <div class="form-group">
                    <label>Título del Mensaje *</label>
                    <asp:TextBox ID="txtTitulo" runat="server" CssClass="form-control" required="required"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Tipo de Actividad *</label>
                    <asp:DropDownList ID="ddlTipoActividad" runat="server" onchange="toggleFields()" required="required">
                        <asp:ListItem Value="">Seleccione...</asp:ListItem>
                        <asp:ListItem Value="Reunion">Reunión</asp:ListItem>
                        <asp:ListItem Value="Actividad social">Actividad Social</asp:ListItem>
                        <asp:ListItem Value="Recordatorio">Recordatorio</asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div id="campos-reunion" class="hidden">
                    <div class="form-group">
                        <label>Fecha y Hora</label>
                        <asp:TextBox ID="txtReunionFecha" runat="server" TextMode="DateTimeLocal"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Duración Estimada</label>
                        <asp:TextBox ID="txtReunionDuracion" runat="server" placeholder="Ej: 2 horas"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Agenda</label>
                        <asp:TextBox ID="txtReunionAgenda" runat="server" TextMode="MultiLine"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Ubicación Presencial</label>
                        <asp:TextBox ID="txtReunionUbicacion" runat="server"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Enlace Virtual (URL)</label>
                        <asp:TextBox ID="txtReunionLink" runat="server" TextMode="Url"></asp:TextBox>
                    </div>
                </div>

                <div id="campos-social" class="hidden">
                    <div class="form-group">
                        <label>Fecha Inicio</label>
                        <asp:TextBox ID="txtSocialInicio" runat="server" TextMode="DateTimeLocal"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Fecha Fin</label>
                        <asp:TextBox ID="txtSocialFin" runat="server" TextMode="DateTimeLocal"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Ubicación</label>
                        <asp:TextBox ID="txtSocialUbicacion" runat="server"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Formato</label>
                        <asp:DropDownList ID="ddlSocialFormato" runat="server">
                            <asp:ListItem Value="Formal">Formal</asp:ListItem>
                            <asp:ListItem Value="Informal">Informal</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <label>Instrucciones</label>
                        <asp:TextBox ID="txtSocialInstrucciones" runat="server" TextMode="MultiLine"></asp:TextBox>
                    </div>
                </div>

                <div id="campos-recordatorio" class="hidden">
                    <div class="form-group">
                        <label>Descripción del Recordatorio</label>
                        <asp:TextBox ID="txtRecordatorioDesc" runat="server" TextMode="MultiLine"></asp:TextBox>
                    </div>
                </div>

                <hr>

                <div class="form-group">
                    <label>Destinatarios</label>
                    <asp:DropDownList ID="ddlDestinatarios" runat="server">
                        <asp:ListItem Value="todos">Todos los condóminos</asp:ListItem>
                        <asp:ListItem Value="especifico">Filiales específicas</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div id="div-filiales" style="display: none; margin-top: 10px;">
                    <label>Seleccione las Filiales:</label>
                    <asp:ListBox ID="lbFiliales" runat="server" SelectionMode="Multiple" CssClass="form-control">
                        <asp:ListItem Value="101">Filial 101</asp:ListItem>
                        <asp:ListItem Value="102">Filial 102</asp:ListItem>
                        <asp:ListItem Value="103">Filial 103</asp:ListItem>
                        <asp:ListItem Value="104">Filial 104</asp:ListItem>
                    </asp:ListBox>
                    <small class="text-muted">Mantenga presionado Ctrl (o Cmd en Mac) para seleccionar varias.</small>
                </div>

                <div class="form-group">
                    <label>Fecha de Cierre (Ocultar mensaje) *</label>
                    <asp:TextBox ID="txtFechaCierre" runat="server" TextMode="DateTimeLocal" required="required"></asp:TextBox>
                </div>


             <div class="modal-footer">
    <button type="button" class="btn-cancel" onclick="closeModal()">Cancelar</button>
    <asp:Button ID="btn_finalizar_registro" 
                CssClass="btn-primary" 
                runat="server" 
                Text="Guardar y Publicar" 
                UseSubmitBehavior="false" 
                OnClick="Save_Click" />
</div>
            </form>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="scripts" runat="server">

    <script>   

        // Ejecutar al cargar la página
        window.onload = function () {
            renderAdminTable();
            // Inicializar el evento onchange de destinatarios manualmente si es necesario
            document.getElementById('<%= ddlDestinatarios.ClientID %>').onchange = toggleFiliales;
        };

        function renderAdminTable() {
            // Obtenemos los datos desde el CodeBehind
            const dataFromServer = <%= ActividadesJson %>;
            const lista = document.getElementById('lista-admin');

            if (!dataFromServer || dataFromServer.length === 0) {
                lista.innerHTML = '<tr><td colspan="5" style="text-align:center;">No hay mensajes registrados</td></tr>';
                return;
            }

            lista.innerHTML = dataFromServer.map((a, index) => `
            <tr>
                <td>${a.Titulo}</td>
                <td>${getTipoTexto(a.Tipo)}</td>
                <td>${formatearFechaDotNet(a.FechaPublicacionInicio)}</td>
                <td><span class="badge">${a.Estado}</span></td>
                <td>
                    <button type="button" onclick="abrirEdicion(${index})">Editar</button>
                   <button type="button" class="btn-delete" onclick="confirmarEliminar(${index})">Eliminar</button>
                </td>
            </tr>
        `).join('');
        }


        function confirmarEliminar(index) {
            if (confirm("¿Está seguro de que desea eliminar esta actividad?")) {
                // Usamos __doPostBack para disparar un evento en C# pasando el índice
                __doPostBack('EliminarActividad', index);
                renderAdminTable()
            }
        }
        function getTipoTexto(tipoEnum) {
            // Ajustado según tu Enum: Reunion=0, ActividadSocial=1, Recordatorio=2
            switch (tipoEnum) {
                case 0: return 'Reunión';
                case 1: return 'Actividad Social';
                case 2: return 'Recordatorio';
                default: return 'Otro';
            }
        }

        function formatearFechaDotNet(fechaDotNet) {
            if (!fechaDotNet) return "-";
            // Maneja formatos ISO o el formato antiguo de JSON /Date(12345)/
            const ms = parseInt(fechaDotNet.replace(/\D/g, ""));
            return new Date(ms).toLocaleDateString("es-CR") + " " + new Date(ms).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
        }

        // Mostrar campos según tipo de actividad usando ClientID
        function toggleFields() {
            const ddl = document.getElementById('<%= ddlTipoActividad.ClientID %>');
            const tipo = ddl.value;

            // Ocultar todos primero
            document.getElementById('campos-reunion').classList.add('hidden');
            document.getElementById('campos-social').classList.add('hidden');
            document.getElementById('campos-recordatorio').classList.add('hidden');

            // Mostrar el seleccionado
            if (tipo === "Reunion") {
                document.getElementById('campos-reunion').classList.remove('hidden');
            } else if (tipo === "Actividad social") {
                document.getElementById('campos-social').classList.remove('hidden');
            } else if (tipo === "Recordatorio") {
                document.getElementById('campos-recordatorio').classList.remove('hidden');
            }
        }

        function toggleFiliales() {
            const ddl = document.getElementById('<%= ddlDestinatarios.ClientID %>');
            const div = document.getElementById('div-filiales');
            div.style.display = (ddl.value === "especifico") ? "block" : "none";
        }

        // Funciones del Modal
        function openModal() {
            document.getElementById('modalForm').style.display = 'block';
            // Resetear el formulario si es necesario
        }

        function closeModal() {
            document.getElementById('modalForm').style.display = 'none';
        }

        // Cerrar modal si se hace clic fuera de él
        window.onclick = function (event) {
            const modal = document.getElementById('modalForm');
            if (event.target == modal) {
                closeModal();
            }
        }

        function abrirEdicion(index) {
            const data = <%= ActividadesJson %>;
            const a = data[index];

            // Cambiar título del modal
            document.getElementById('modalTitle').innerText = "Editar Mensaje";

            // 1. Campos base (Usando ClientID)
            document.getElementById('<%= txtTitulo.ClientID %>').value = a.Titulo;
            document.getElementById('<%= txtFechaCierre.ClientID %>').value = formatearFechaParaInput(a.FechaPublicacionCierre);
            document.getElementById('<%= ddlDestinatarios.ClientID %>').value = a.EsParaTodosLosCondominos ? "todos" : "especifico";

            // 2. Tipo de Actividad
            const ddlTipo = document.getElementById('<%= ddlTipoActividad.ClientID %>');
            // Mapeo manual del Enum (0:Reunion, 1:Social, 2:Recordatorio)
            const tipos = ["Reunion", "Actividad social", "Recordatorio"];
            ddlTipo.value = tipos[a.Tipo];
            toggleFields(); // Mostrar los campos correctos
            toggleFiliales(); // Mostrar lista de filiales si aplica

            // 3. Campos específicos por tipo
            if (a.Tipo === 0) { // Reunion
                document.getElementById('<%= txtReunionFecha.ClientID %>').value = formatearFechaParaInput(a.FechaHoraReunion);
        document.getElementById('<%= txtReunionDuracion.ClientID %>').value = a.DuracionEstimada;
        document.getElementById('<%= txtReunionAgenda.ClientID %>').value = a.Agenda;
        document.getElementById('<%= txtReunionUbicacion.ClientID %>').value = a.UbicacionPresencial;
        document.getElementById('<%= txtReunionLink.ClientID %>').value = a.EnlaceVirtual;
    } else if (a.Tipo === 1) { // Actividad Social
        document.getElementById('<%= txtSocialInicio.ClientID %>').value = formatearFechaParaInput(a.FechaHoraInicio);
        document.getElementById('<%= txtSocialFin.ClientID %>').value = formatearFechaParaInput(a.FechaHoraFin);
        document.getElementById('<%= txtSocialUbicacion.ClientID %>').value = a.Ubicacion;
        document.getElementById('<%= ddlSocialFormato.ClientID %>').value = (a.Formato === 0 ? "Formal" : "Informal");
        document.getElementById('<%= txtSocialInstrucciones.ClientID %>').value = a.InstruccionesDetalladas;
    } else if (a.Tipo === 2) { // Recordatorio
                document.getElementById('<%= txtRecordatorioDesc.ClientID %>').value = a.Descripcion;
            }

            openModal();
        }

        // Función auxiliar para convertir fecha de .NET a formato compatible con <input type="datetime-local">
        function formatearFechaParaInput(fechaDotNet) {
            if (!fechaDotNet) return "";
            const ms = parseInt(fechaDotNet.replace(/\D/g, ""));
            const d = new Date(ms);
            // Formato requerido: yyyy-MM-ddThh:mm
            return d.getFullYear() + '-' +
                String(d.getMonth() + 1).padStart(2, '0') + '-' +
                String(d.getDate()).padStart(2, '0') + 'T' +
                String(d.getHours()).padStart(2, '0') + ':' +
                String(d.getMinutes()).padStart(2, '0');
        }

    </script>

</asp:Content>
