<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registro.aspx.cs" Inherits="Tarea1_GestionCondominal.Registro" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Registro nuevo condomino</title>

    <link href="Content/registro.css" rel="stylesheet" type="text/css" />

</head>
<body>
    <form id="form1" runat="server">
        <div class="form-container">
            <h2>Registro de Nuevo Dueño</h2>

            <form id="registroDuenio">

                <div class="form-row">
                    <div class="form-group">
                        <label for="tipoId">Tipo de Identificación</label>
                        <asp:DropDownList ID="tipoId" runat="server" >
                            <asp:ListItem Value="" Text="Seleccione..." Selected="True" Disabled="True" />
                            <asp:ListItem Value="fisica" Text="Física" />
                            <asp:ListItem Value="dimex" Text="DIMEX" />
                            <asp:ListItem Value="pasaporte" Text="Pasaporte" />
                        </asp:DropDownList>
                    </div>

                    <div class="form-group">
                        <label for="identificacion">Identificación</label>
                        <asp:TextBox ID="identificacion" runat="server" placeholder="Número de ID"/>
                        <span class="error-text" id="error_identificacion"></span>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="nombre">Nombre</label>
                        <asp:TextBox ID="nombre" runat="server"  />
                         <span class="error-text" id="error_nombre"></span>
                    </div>

                    <div class="form-group">
                        <label for="apellidos">Apellidos</label>
                        <asp:TextBox ID="apellidos" runat="server"  />
                         <span class="error-text" id="error_apellidos"></span>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="fechaNacimiento">Fecha de Nacimiento</label>
                        <asp:TextBox ID="fechaNacimiento" runat="server" TextMode="Date"  />
                        <span class="error-text" id="error_fechaNacimiento"></span>
                    </div>

                    <div class="form-group">
                        <label for="numFilial">Número de Filial</label>
                        <asp:TextBox ID="numFilial" runat="server" TextMode="Number" min="1" placeholder="Ej: 102" />
                        <span class="error-text" id="error_numFilial"></span>
                    </div>
                </div>

                <div class="form-group">
                    <label>¿Tiene construcción dentro de la filial?</label>
                    <div class="radio-options">
                        <asp:RadioButtonList ID="rbConstruccion" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                            <asp:ListItem Value="si" Text="Sí" Selected="True" />
                            <asp:ListItem Value="no" Text="No" />
                        </asp:RadioButtonList>
                    </div>
                </div>

                <div class="form-group">
                    <label for="email">Correo electrónico (Usuario)</label>
                    <asp:TextBox ID="email" runat="server"  placeholder="correo@ejemplo.com"  />
                    <span class="error-text" id="error_email"></span>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="password">Contraseña</label>
                        <asp:TextBox ID="password" runat="server" TextMode="Password"  />
                        <span class="error-text" id="error_password"></span>
                    </div>

                    <div class="form-group">
                        <label for="confirmPassword">Confirmar Contraseña</label>
                        <asp:TextBox ID="confirmPassword" runat="server" TextMode="Password" />
                          <span class="error-text" id="error_confirmPassword"></span>
                    </div>
                </div>

                <div class="form-group checkbox-single">
                    <asp:CheckBox ID="terminos" runat="server" />
                    <label for="terminos" style="font-weight: normal;">Acepto los términos, condiciones y políticas de privacidad.</label>
                </div>
                <asp:Button ID="btn_finalizar_registro" class="submit-btn" runat="server" Text="Finalizar Registro" UseSubmitBehavior="false" OnClick="btn_finalizar_registro_Click"  />

            </form>
        </div>

    </form>

    <script src="Scripts/registro.js" type="text/javascript"></script>
</body>
</html>

