const modal = document.getElementById('activityModal');
const form = document.getElementById('activityForm');

function openModal() {
    modal.style.display = 'flex';
}

function closeModal() {
    modal.style.display = 'none';
    form.reset();
}

form.addEventListener('submit', function (e) {
    e.preventDefault();

    const fInicio = new Date(document.getElementById('fechaInicio').value);
    const fFin = new Date(document.getElementById('fechaFin').value);
    const url = document.getElementById('enlace').value;

    if (fInicio >= fFin) {
        alert("Error: La fecha de fin debe ser posterior a la fecha de inicio.");
        return;
    }


    if (url !== "" && !isValidHttpUrl(url)) {
        alert("Error: Por favor ingrese una URL válida (debe incluir http:// o https://).");
        return;
    }


    alert("Actividad guardada correctamente.");
    closeModal();
});


function isValidHttpUrl(string) {
    let url;
    try {
        url = new URL(string);
    } catch (_) {
        return false;
    }
    return url.protocol === "http:" || url.protocol === "https:";
}