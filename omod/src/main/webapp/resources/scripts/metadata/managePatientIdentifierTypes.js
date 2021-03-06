angular.module("managePatientIdentifierTypes", [ "patientIdentifierTypeService", "ngDialog", "ui.router", "uicommons.filters" ])

    .config([ "$stateProvider", "$urlRouterProvider", function($stateProvider, $urlRouterProvider) {
        $urlRouterProvider.otherwise("/list");

        $stateProvider
            .state('list', {
                url: "/list",
                templateUrl: "templates/list.page",
                controller: "ManagePatientIdentifierTypesController"
            })
            .state("edit", {
                url: "/edit/:patientIdentifierTypeUuid",
                templateUrl: "templates/edit.page",
                params: {
                	patientIdentifierTypeUuid: null,
                },
                resolve: {
                	patientIdentifierType: function($stateParams, PatientIdentifierType) {
                        if ($stateParams.patientIdentifierTypeUuid) {
                            return PatientIdentifierType.get({ uuid: $stateParams.patientIdentifierTypeUuid, v: "full" });
                        }
                        return {};
                    }
                },
                controller: "EditPatientIdentifierTypeController"
            });
    }])

    .controller("ManagePatientIdentifierTypesController", [ "$scope", "$state", "PatientIdentifierType", "ngDialog",
        function($scope, $state, PatientIdentifierType, ngDialog) {
            function sortWithRetiredLast(list) {
                return _.sortBy(list, "retired");
            }

            function loadPatientIdentifierTypes() {
                // TODO standard function for failure of REST call
            	PatientIdentifierType.query({ v: "default", includeAll: true }).$promise.then(function(response) {
                    // TODO handle multiple pages of results in a standard way
                    $scope.patientIdentifierTypes = sortWithRetiredLast(response.results);
                });
            }

            $scope.retire = function(patientIdentifierType) {
                ngDialog.openConfirm({
                    showClose: false,
                    closeByEscape: true,
                    closeByDocument: true,
                    template: "templates/retirePatientIdentifierTypeDialog.page",
                    controller: function($scope) {
                        $scope.patientIdentifierType = patientIdentifierType;
                    }
                }).then(function(reason) {
                	PatientIdentifierType.delete({
                        uuid: patientIdentifierType.uuid,
                        reason: reason
                    }).$promise.then(function() {
                        loadPatientIdentifierTypes();
                            emr.successMessage(emr.message("adminui.retired"));
                    });
                });
            }

            $scope.unretire = function(patientIdentifierType) {
            	PatientIdentifierType.save({
                    uuid: patientIdentifierType.uuid,
                    retired: false
                }).$promise.then(function() {
                    loadPatientIdentifierTypes();
                        emr.successMessage(emr.message("adminui.restored"));
                })
            }

            $scope.edit = function(patientIdentifierType) {
                $state.go("edit", { patientIdentifierTypeUuid: patientIdentifierType.uuid });
            },

            $scope.purge = function(patientIdentifierType) {
                ngDialog.openConfirm({
                    showClose: false,
                    closeByEscape: true,
                    closeByDocument: true,
                    template: "templates/purgePatientIdentifierTypeDialog.page",
                    controller: function($scope) {
                        $scope.patientIdentifierType = patientIdentifierType;
                    }
                }).then(function() {
                	PatientIdentifierType.delete({
                        uuid: patientIdentifierType.uuid,
                        purge: ""
                    }).$promise.then(function() {
                        loadPatientIdentifierTypes();
                        emr.successMessage(emr.message("adminui.purged"));
                    })
                });
            }

            loadPatientIdentifierTypes();
        }])

    .controller("EditPatientIdentifierTypeController", [ "$scope", "$state", "PatientIdentifierType", "patientIdentifierType",
        function($scope, $state, PatientIdentifierType, patientIdentifierType) {
            $scope.patientIdentifierType = patientIdentifierType;

            $scope.save = function() {
                // TODO: utility function for doing this, until RESTWS-460 is fixed
                var toSave = {
                    uuid: $scope.patientIdentifierType.uuid,
                    name: $scope.patientIdentifierType.name,
                    description: $scope.patientIdentifierType.description
                }

                var successMessageCode = ($scope.patientIdentifierType.uuid) ? "adminui.savedChanges" : "adminui.saved";
                PatientIdentifierType.save(toSave).$promise.then(function() {
                    $state.go("list");
                    emr.successMessage(emr.message(successMessageCode));
                })
            }
        }]);