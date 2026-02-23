document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("form1");

    const emailInput = document.querySelector('[id$="email"]');
    const passInput = document.querySelector('[id$="password"]');
    const confirmPass = document.querySelector('[id$="confirmPassword"]');
    const txtId = document.querySelector('[id$="identificacion"]');
    const ddlTipo = document.querySelector('[id$="tipoId"]');

    const campos = ["nombre", "apellidos", "fechaNacimiento", "numFilial", "password"];

    // Función genérica para validar si está vacío
    const validarCampoVacio = (id) => {
        const input = document.querySelector(`[id$="${id}"]`)
         console.log(id)
        if (input.value.trim() === "") {
            showError(id, "Este campo es obligatorio.");
           
        }
  
    };

    // Asignar el evento blur a cada campo
    campos.forEach(id => {
        const el = document.querySelector(`[id$="${id}"]`);
        if (el) {
            el.addEventListener("blur", () => validarCampoVacio(id));
        }
    });

    // Función para mostrar error
    const showError = (inputID, message) => {
        const errorSpan = document.getElementById("error_" + inputID);
        if (errorSpan) {
            errorSpan.textContent = message;
            errorSpan.style.display = "block";
        }
    };

 
    emailInput.addEventListener("blur", function () {
        const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!regex.test(this.value)) {
            showError("email", "El formato del correo no es válido.");
        } else {
            document.getElementById("error_email").style.display = "none";
        }
    });

    confirmPass.addEventListener("keyup", function () {
        if (passInput.value !== confirmPass.value) {
            showError("confirmPassword", "Las contraseñas no coinciden.");
        } else {
            document.getElementById("error_confirmPassword").style.display = "none";
        }
    });




    const validarId = () => {
        const valor = txtId.value.trim();
        const tipo = ddlTipo.value;
        let mensaje = "";

        // 1. Validar si está vacío
        if (valor === "") {
            showError("identificacion", "La identificación es obligatoria.");
        }
        // 2. Lógica según el tipo
        else if (tipo === "fisica") {
            // Ejemplo: Cédula física (9 dígitos, sin guiones o con guiones)
            const regexFisica = /^[1-9]0?\d{3}0?\d{3}$/; // Formato simple 9 dígitos
            const limpio = valor.replace(/-/g, ""); // Quitar guiones para validar
            if (limpio.length !== 9 || isNaN(limpio)) {
                showError("identificacion", "La cédula física debe tener 9 dígitos exactos.");
            }
        }
        else if (tipo === "dimex") {
            // DIMEX suele tener 11 o 12 dígitos
            if (valor.length < 11 || valor.length > 12) {
                showError("identificacion", "El DIMEX debe tener entre 11 y 12 dígitos.");
            }
        }
        else if (tipo === "pasaporte") {
            // Pasaporte es más libre, pero usualmente alfanumérico largo
            if (valor.length < 6) {
                showError("identificacion", "Pasaporte inválido (muy corto).");
            }
        }

      
    };

    // Validar cuando el usuario termina de escribir
    txtId.addEventListener("blur", validarId);

    // Validar también si cambia el tipo de identificación
    ddlTipo.addEventListener("change", validarId);
});