<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Tarea1_GestionCondominal.Login2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Autenticacion de usuario</title>

    <link href="Content/login.css" rel="stylesheet" type="text/css" />

</head>
<body>
    <form id="form1" runat="server">
        <div class="login-card">
            <h2>Acceso al Sistema</h2>
            <form id="loginForm" novalidate>
                <div class="form-group">
                    <label for="email">Correo Electrónico (Usuario)</label>
                    <asp:TextBox ID="email" type="email" runat="server" placeholder="usuario@dominio.com" />
                    <div id="emailError" class="error-message">Formato de correo inválido.</div>
                </div>

                <div class="form-group">
                    <label for="password">Contraseña</label>
                    <asp:TextBox ID="password" type="password" runat="server" placeholder="••••••••" />
                    <div id="passError" class="error-message">La contraseña es obligatoria.</div>
                </div>
                <asp:Button ID="btn_login" class="btn-login" runat="server" Text="Iniciar Sesión" OnClick="btn_login_Click" />
                <div class="register-link">
                    <asp:Button ID="btn_register" class="btn-register" runat="server" Text="Registrarse" OnClick="btn_register_Click" UseSubmitBehavior="false" />
                </div>
            </form>
        </div>
    </form>

    <script src="Scripts/login.js" type="text/javascript"></script>
</body>
</html>
