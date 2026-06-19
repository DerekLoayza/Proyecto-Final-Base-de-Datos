const API = "http://127.0.0.1:5000";
const btnVenta = document.getElementById("btnVenta");
const btnReporte = document.getElementById("btnReporte");
const mensaje = document.getElementById("mensaje");
// Registrar venta
btnVenta.addEventListener("click", async () => {
    try {
        const respuesta = await fetch(`${API}/api/registrar_venta`, {
            method: "POST"
        });
        const datos = await respuesta.json();
        if (!respuesta.ok){
            throw new Error('Error de la API')
        }
        mensaje.innerHTML = `
            <div class="alert alert-success">
                ${datos.mensaje}
            </div>
        `;
    } catch (error) {
        mensaje.innerHTML = `
            <div class="alert alert-danger">
                Error al conectar con la API.
            </div>
        `;
    }
});

// Descargar reporte
btnReporte.addEventListener("click", () => {
    window.location.href = `${API}/api/exportar_reporte`;
});