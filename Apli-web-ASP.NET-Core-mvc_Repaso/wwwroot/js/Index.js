const _modelEmployee = {
    idEmployee: 0,
    fullName: "",
    iddepartment: 0,
    salary: 0,
    contractDate: ""
}

function ShowEmployee() {
    fetch("/Home/listEmployee")
        .then(response => response.ok ? response.json() : Promise.reject(response))
        .then(responseJson => {
            if (responseJson.length > 0) {
                $("#TableEmployee tbody").html("");
                responseJson.forEach((employee) => {
                    $("#TableEmployee tbody").append(
                        $("<tr>").append(
                            $("<td>").text(employee.fullName),
                            $("<td>").text(employee.refDepartment.name),
                            $("<td>").text(employee.salary),
                            $("<td>").text(employee.contractDate),
                            $("<td>").append(
                                $("<button>").addClass("btn btn-primary btn-sm buton-edit-employee").text("Editar").data("dataEmployee", employee),
                                $("<button>").addClass("btn btn-danger btn-sm ms-2 buton-delete-employee").text("Eliminar").data("dataEmployee", employee),
                            )
                        )
                    )
                })
            }
        })
}

document.addEventListener("DOMContentLoaded", function () {
    ShowEmployee();
    fetch("/Home/listDepartment")
        .then(response => response.ok ? response.json() : Promise.reject(response))
        .then(responseJson => {
            if (responseJson.length > 0) {
                responseJson.forEach((item) => {
                    $("#cboDeparment").append(
                        $("<option>").val(item.iddepartment).text(item.name)
                    )
                })
            }
        })
    $("#txtcontractDate").datepicker({
        format: "dd/mm/yyyy",
        autoclose: true,
        todayHighlight: true
    })
}, false)

function ShowModal() {
    $("#txtFullName").val(_modelEmployee.fullName);
    $("#cboDeparment").val(_modelEmployee.iddepartment == 0 ? $("#cboDeparment option:first").val() : _modelEmployee.iddepartment);
    $("#txtsalary").val(_modelEmployee.salary);
    $("#txtcontractDate").val(_modelEmployee.contractDate);
    $("#ModalEmployee").modal("show");
}

$(document).on("click", ".buton-new-employee", function () {
    _modelEmployee.idEmployee = 0;
    _modelEmployee.fullName = "";
    _modelEmployee.iddepartment = 0;
    _modelEmployee.salary = 0;
    _modelEmployee.contractDate = "";
    ShowModal();
})

$(document).on("click", ".buton-edit-employee", function () {

    const _employee = $(this).data("dataEmployee");

    _modelEmployee.idEmployee = _employee.idEmployee
    _modelEmployee.fullName = _employee.fullName
    _modelEmployee.iddepartment = _employee.refDepartment.iddepartment
    _modelEmployee.salary = _employee.salary;
    _modelEmployee.contractDate = _employee.contractDate

    ShowModal();

})

$(document).on("click", ".buton-save-change-employee", function () {

    const model = {
        idEmployee : _modelEmployee.idEmployee,
        fullName: $("#txtFullName").val(),
        refDepartment: {
            iddepartment: $("#cboDeparment").val()
        },
        salary: $("#txtsalary").val(),
        contractDate: $("#txtcontractDate").val()
    }

    if (_modelEmployee.idEmployee == 0) {

        fetch("/Home/SaveEmployee", {
            method: "POST",
            headers: { "Content-Type": "application/json; charset=utf-8" },
            body: JSON.stringify(model)
        })
            .then(response => {
                return response.ok ? response.json() : Promise.reject(response)
            })
            .then(responseJson => {

                if (responseJson.valor) { 
                    $("#ModalEmployee").modal("hide");
                    Swal.fire("Listo!", "Empleado fue creado", "success");
                    ShowEmployee();
                }
                else
                    Swal.fire("Lo sentimos", "No se puedo crear", "error");
            })

    } else {

        fetch("/Home/EditEmployee", {
            method: "PUT",
            headers: { "Content-Type": "application/json; charset=utf-8" },
            body: JSON.stringify(model)
        })
            .then(response => {
                return response.ok ? response.json() : Promise.reject(response)
            })
            .then(responseJson => {

                if (responseJson.valor) {
                    $("#ModalEmployee").modal("hide");
                    Swal.fire("Listo!", "Empleado fue actualizado", "success");
                    ShowEmployee();
                }
                else
                    Swal.fire("Lo sentimos", "No se puedo actualizar", "error");
            })
    }

})

$(document).on("click", ".buton-delete-employee", function () {

    const _employee = $(this).data("dataEmployee");

    Swal.fire({
        title: "Esta seguro?",
        text: `Eliminar empleado "${_employee.fullName}"`,
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "Si, eliminar",
        cancelButtonText: "No, volver"
    }).then((result) => {

        if (result.isConfirmed) {

            fetch(`/Home/DeleteEmployee?idEmployee=${_employee.idEmployee}`, {
                method: "DELETE"
            })
                .then(response => {
                    return response.ok ? response.json() : Promise.reject(response)
                })
                .then(responseJson => {

                    if (responseJson.valor) {
                        Swal.fire("Listo!", "Empleado fue elminado", "success");
                        ShowEmployee();
                    }
                    else
                        Swal.fire("Lo sentimos", "No se puedo eliminar", "error");
                })
        }
    })

})





