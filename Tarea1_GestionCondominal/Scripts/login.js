    const emailInput = document.getElementById('email');
    const emailError = document.getElementById('emailError');
    const password = document.getElementById('password')

    const emailRegex = /^[a-zA-Z0-9._+-]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,}$/;
    let isValid = true;

    emailInput.addEventListener("change", (e) => {
        if (!emailRegex.test(emailInput.value)) {
        emailError.style.display = 'block';
    emailInput.style.borderColor = 'var(--error)';
    isValid = false;
        } else {
        emailError.style.display = 'none';
    emailInput.style.borderColor = '#cbd5e1';
        }
    });

    password.addEventListener("change", (e) => {
        if (password.value == "") {
        console.log("entro 2")
            document.getElementById('passError').style.display = 'block';
    isValid = false;
        } else {
        console.log("entro 1")
            document.getElementById('passError').style.display = 'none';
        }
    });


