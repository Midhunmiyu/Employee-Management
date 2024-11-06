//---Employee---//
$(document).on("click", "#employee_search", function () {
    console.log("Employee");
    employee_view("None");
});

function employee_view(data) {
    console.log(data);
    var page = "1";
    if (data != "None") {
        var page = data;
    }
    console.log('page', page);
    var search = $("#search").val();
    var sts = $("#status").val();

    $.ajax({
        url: "/employees/",
        type: "GET",
        data: { search: search, page: page, sts: sts },
        success: function (data) {
            $("#employee-table").html(data.template);
        },
    });
}

function changeemployeestatus(id, sts) {
    var page = $("#page").val();
    var search = $("#search").val();
    var statusFilter = $("#status").val();
    console.log(id, sts);
    console.log('pg', page);
    $.ajax({
        url: "/employees/",
        type: "GET",
        data: {
            page: page,
            status: sts,
            item_id: id,
            search: search,
            sts: statusFilter,
        },
        success: function (data) {
            $("#employee-table").html(data.template);
            $("#message001").show().fadeOut(1000);
        },
    });
}

function show_modal(id) {
    $("#hid").val(id);
    $("#modaldemo5").modal("show");
}

function confirm_delete_employee() {
    var page = $("#page").val();
    id = $("#hid").val();
    console.log(id);
    $.ajax({
        url: "/employees/",
        type: "GET",
        data: { page: page, delete: "1", item_id: id },
        success: function (data) {
            $("#modaldemo5").modal("hide");
            $("#employee-table").html(data.template);
        },
    });
}

function showCustomFields(id) {
    console.log(id);
    $("#CustomFieldModel").modal("show");

    $.ajax({
        url: "/show-custom-fields/",
        type: "GET",
        data: { id: id },
        success: function (data) {
            $("#customFields").html(data.template);
        },
    });
}

function showCustomModal(id) {
    console.log(id);
    $('#modaldemo8').modal('show');
    $('#chid').val(id);
    $("#CustomFieldModel").modal("hide");
}

function confirm_delete_custom_field() {
    id = $('#chid').val();
    console.log(id);
    $.ajax({
        url: "/delete-custom-field/",
        type: "GET",
        data: { id: id},
        success: function (data) {
            $("#modaldemo8").modal("hide");
            $("#CustomFieldModel").modal("show");
            $("#customFields").html(data.template);
        },
    });
}


function deletefield(id) {
    console.log(id,'id');
    $.ajax({
        url: "/delete-field/",
        type: "GET",
        data: { id: id},
        success: function (data) {
            $('#custom_id_'+id).remove();
            $('#delete_btn_'+id).remove();

        },
    });
    
}