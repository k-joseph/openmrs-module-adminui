<h2 ng-hide="patientIdentifierType.uuid">${ui.message('adminui.addNewPatientIdentifierType.title')}</h2>
<h2 ng-show="patientIdentifierType.uuid">${ui.message('adminui.editPatientIdentifierType.title')}</h2>

<fieldset class="right" ng-show="patientIdentifierType.uuid">
    <legend>${ui.message('general.auditInfo')}</legend>
    <p>
        ${ui.message('general.uuid')}: {{ patientIdentifierType.uuid }}
    </p>
    <p>
        ${ui.message('general.createdBy')}:
        {{ patientIdentifierType.auditInfo.creator | omrs.display }}
        ${ui.message('general.onDate')}
        {{ patientIdentifierType.auditInfo.dateCreated | serverDate }}
    </p>
    <p ng-show="patientIdentifierType.changedBy">
        ${ui.message('general.changedBy')}:
        {{ patientIdentifierType.auditInfo.changedBy | omrs.display }}
        ${ui.message('general.onDate')}
        {{ patientIdentifierType.auditInfo.dateChanged | serverDate }}
    </p>
</fieldset>


<form class="simple-form-ui" name="patientIdentifierTypeForm" novalidate ng-submit="save()">
    <p>
        <label>${ui.message('general.name')}</label>
        <input ng-model="patientIdentifierType.name" required/>
    </p>
    <p>
        <label>${ui.message('general.description')}</label>
        <textarea ng-model="patientIdentifierType.description" cols="54" required></textarea>
    </p>
    
    <p>
        <label>${ui.message('PatientIdentifierType.format')}</label>
        <input ng-model="patientIdentifierType.format"/>
    </p>
    <p>
        <label>${ui.message('PatientIdentifierType.formatDescription')}</label>
        <input ng-model="patientIdentifierType.formatDescription"/>
    </p>
    <p>
        <label>${ui.message('PatientIdentifierType.required')}</label>
        <input type="checkbox" ng-model="patientIdentifierType.required"/>
    </p>
    <p>
        <label>${ui.message('PatientIdentifierType.locationBehavior')}</label>
        <input ng-model="patientIdentifierType.locationBehavior"/>
    </p>
    <p>
        <label>${ui.message('PatientIdentifierType.uniquenessBehavior')}</label>
        <input ng-model="patientIdentifierType.uniquenessBehavior"/>
    </p>
    <p>
        <label>${ui.message('PatientIdentifierType.validator')}</label>
        <input ng-model="patientIdentifierType.validator"/>
    </p>

    <p>
        <button ng-disabled="patientIdentifierTypeForm.\$invalid" type="submit" class="confirm right">${ui.message('general.save')}</button>
        <button type="button" class="cancel" ui-sref="list">${ui.message('general.cancel')}</button>
    </p>
</form>

