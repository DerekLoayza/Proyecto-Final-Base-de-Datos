const API = "http://127.0.0.1:5000";
// const btnVenta = document.getElementById("btnVenta");
const btnReporte = document.getElementById("btnReporte");
const mensaje = document.getElementById("mensaje");
// Elementos nuevos
const tabla = document.querySelector("#tablaSmartphones tbody");
const clienteSelect = document.getElementById("cliente");
const empleadoSelect = document.getElementById("empleado");
const sucursalSelect = document.getElementById("sucursal");
const smartphoneSelect = document.getElementById("smartphone");
const formVenta = document.getElementById("formVenta");

// Cargar datos al iniciar
document.addEventListener("DOMContentLoaded", () => {
    cargarSmartphones();
    cargarClientes();
    cargarEmpleados();
    cargarSucursales();
});
// Smartphones
async function cargarSmartphones() {
    const res = await fetch(`${API}/api/smartphones`);
    const data = await res.json();
    tabla.innerHTML = "";
    smartphoneSelect.innerHTML = "";
    data.forEach(s => {
        // tabla
        tabla.innerHTML += `
            <tr>
                <td>${s.id_smart}</td>
                <td>${s.modelo}</td>
                <td>${s.marca}</td>
                <td>${s.stock}</td>
                <td>${s.precio}</td>
            </tr>
        `;
        // select
        smartphoneSelect.innerHTML += `
            <option value="${s.id_smart}">
                ${s.marca} ${s.modelo} (Stock: ${s.stock})
            </option>
        `;
    });
}
// CLientes
async function cargarClientes() {
    const res = await fetch(`${API}/api/clientes`);
    const data = await res.json();
    clienteSelect.innerHTML = "";
    data.forEach(c => {
        clienteSelect.innerHTML += `
            <option value="${c.id_cli}">
                ${c.nombre} ${c.apellido}
            </option>
        `;
    });
}
// Empleados
async function cargarEmpleados() {
    const res = await fetch(`${API}/api/empleados`);
    const data = await res.json();
    empleadoSelect.innerHTML = "";
    data.forEach(e => {
        empleadoSelect.innerHTML += `
            <option value="${e.id_emp}">
                ${e.nombre} ${e.apellido} - ${e.cargo}
            </option>
        `;
    });
}
// Sucursales 
async function cargarSucursales() {
    const res = await fetch(`${API}/api/sucursales`);
    const data = await res.json();
    sucursalSelect.innerHTML = "";
    data.forEach(s => {
        sucursalSelect.innerHTML += `
            <option value="${s.id_suc}">
                ${s.nombre}
            </option>
        `;
    });
}
// Registrar venta
/*
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
*/
formVenta.addEventListener("submit", async (e) => {
    e.preventDefault();
    const venta = {
        id_cliente: clienteSelect.value,
        id_empleado: empleadoSelect.value,
        id_sucursal: sucursalSelect.value,
        id_smartphone: smartphoneSelect.value,
        cantidad: document.getElementById("cantidad").value
    };
    try {
        const res = await fetch(`${API}/api/registrar_venta`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(venta)
        });
        const data = await res.json();
        mensaje.innerHTML = `
            <p style="color: green;">
                ${data.mensaje || "Venta registrada"}
            </p>
        `;
        // refrescar inventario
        cargarSmartphones();
        formVenta.reset();
    } catch (err) {
        mensaje.innerHTML = `
            <p style="color: red;">
                Error al registrar venta
            </p>
        `;
    }
});
// Descargar reporte
btnReporte.addEventListener("click", () => {
    window.location.href = `${API}/api/exportar_reporte`;
});