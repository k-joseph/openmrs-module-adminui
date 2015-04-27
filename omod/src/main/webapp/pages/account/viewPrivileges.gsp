<%
    ui.decorateWith("appui", "standardEmrPage")
%>

<script type="text/javascript">
    var breadcrumbs = [
        { icon: "icon-home", link: '/' + OPENMRS_CONTEXT_PATH + '/index.htm' },
        { label: "${ ui.message("adminui.app.administrationTools.label")}" , link: '${ui.pageLink("adminui", "adminUiHome")}'},
        { label: "${ ui.message("adminui.app.accountManager.label")}", link: '${ui.pageLink("adminui", "account/manageAccounts")}' },
        { label: "${ ui.message("adminui.viewPrivileges.accountManagement.label")}" }
    ];
</script>

<% i=0 %>

 <input type="submit" class="button" value="${ui.message("adminui.addNewPrivilege")}" onclick="javascript:window.location='/${ contextPath }/adminui/account/privilege.page'"/>

<hr>
<table id="adminui-privileges" cellspacing="0" cellpadding="2">
	<thead>
		<tr>
			<th>${ ui.message("general.name") }</th>
			<th>${ ui.message("general.description") }</th>
            <th></th>
		</tr>
	</thead>
	<tbody>
		<% privileges.each{  %>
	 	<tr>
	 		<td>
				 ${ ui.format(it.name) }
			</td>
			<td>
				${ ui.format(it.description) }
            </td>
			<td>
	            <a href="/${ contextPath }/adminui/account/privilege.page?privilegeName=${ it.name }">
	                <button>${ ui.message("adminui.edit") }</button>
	            </a>
        	</td>
		</tr>
		<% } %>
	</tbody>
</table>


<% if ( (privileges != null) && (privileges.size() > 0) ) { %>
${ ui.includeFragment("uicommons", "widget/dataTable", [ object: "#adminui-privileges",
        options: [
                bFilter: true,
                bJQueryUI: true,
                bLengthChange: false,
                iDisplayLength: 10,
                sPaginationType: '\"full_numbers\"',
                bSort: false,
                sDom: '\'ft<\"fg-toolbar ui-toolbar ui-corner-bl ui-corner-br ui-helper-clearfix datatables-info-and-pg \"ip>\''
        ]
]) }
<% } %>
