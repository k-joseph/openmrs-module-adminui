<%
    ui.decorateWith("appui", "standardEmrPage")

    ui.includeJavascript("adminui", "jquery.validate.js")

    ui.includeCss("adminui", "adminui.css")

    def createPrivilege = ("add" == param.action[0]);
%>

<script type="text/javascript">
    var breadcrumbs = [
        { icon: "icon-home", link: '/' + OPENMRS_CONTEXT_PATH + '/index.htm' },
        { label: "${ ui.message("adminui.app.administrationTools.label")}" , link: '${ui.pageLink("adminui", "adminUiHome")}'},
        { label: "${ ui.message("adminui.app.accountManager.label")}" , link: '${ui.pageLink("adminui", "account/manageAccounts")}'},
        { label: "${ ui.message("adminui.viewPrivileges.accountManagement.label")}" , link: '${ui.pageLink("adminui", "account/viewPrivileges")}'},
        { label: "${ ui.message((createPrivilege) ? "adminui.addNewPrivilege" : "adminui.editPrivilege")}" }

    ];
</script>

<script type="text/javascript">

    jq().ready(function () {

        jq("#privilegeForm").validate({
            rules: {
                "name": {
                    required: true,
                    minlength: 3,
                    maxlength: 255
                },
                "description": {
                    required: false,
                    maxlength: 1024
                }
            },
            errorClass: "error",
            validClass: "",
            onfocusout: function (element) {
                jq(element).valid();
            },
            errorPlacement: function (error, element) {
                element.next().text(error.text());
            },
            highlight: function (element, errorClass, validClass) {
                jq(element).addClass(errorClass);
                jq(element).next().addClass(errorClass);
                jq(element).next().show();
            },
            unhighlight: function (element, errorClass, validClass) {
                jq(element).removeClass(errorClass);
                jq(element).next().removeClass(errorClass);
                jq(element).next().hide();
            }
        });
    });
</script>

<h1>
    <h3>${ ui.message((createPrivilege) ? "adminui.addNewPrivilege" : "adminui.editPrivilege")}</h3>
</h1>
${param.action[0]}
<form class="simple-form-ui" method="post" id="privilegeForm" autocomplete="off">

<fieldset>
    <% if(createPrivilege){ %>
        ${ui.includeFragment("uicommons", "field/text", [
            label        : ui.message("general.name")+"*",
            formFieldName: "privilege",
            id           : "privilege",
            maxLength    : 101,
            initialValue : privilege.privilege
        ])}
    <% } else{ %>
        <b>${ui.message("general.name")}:</b> ${privilege.privilege}
        <input type="hidden" name="privilegeName" value="${privilege.privilege}" />
    <% } %>
    ${ui.includeFragment("uicommons", "field/textarea", [
            label        : ui.message("general.description"),
            formFieldName: "description",
            id           : "description",
            initialValue : (privilege.description) ? privilege.description.trim() : ""
    ])}

    <div>
        <input type="button" class="cancel" value="${ui.message("adminui.cancel")}" onclick="javascript:window.location='/${ contextPath }/adminui/account/viewPrivileges.page'"/>
        <input type="submit" class="confirm" id="save-button" value="${ui.message("adminui.save")}"/>
    </div>
    </fieldset>
</form>