<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>

<f:view>
<html>
<head>
    <title>Add Prescribed Medicine</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/AddPrescribedMedicine.css" />
    <!-- Prevent HTML caching -->
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
    <meta http-equiv="Pragma" content="no-cache" />
    <meta http-equiv="Expires" content="0" />

    <script type="text/javascript">
        window.addEventListener('pageshow', function(event) {
            var navEntries = performance.getEntriesByType?.("navigation");
            var navType = navEntries?.length ? navEntries[0].type : "";
            if (event.persisted || navType === "back_forward") {
                document.querySelectorAll('.error').forEach(el => el.textContent = '');
            }
        });
    </script>

</head>
<body>
<div class="page-wrapper">
    <jsp:include page="/navbar/NavProvider.jsp" />

    <div class="main-content">
        <div class="form-container">
            <div class="form-title">Add Prescribed Medicine</div>

            <h:form prependId="false">
                <h:messages globalOnly="true" styleClass="error" />

                <div class="form-grid">
                    <div class="form-group">
                        <label for="prescribedId">Prescribed ID</label>
                        <h:inputText id="prescribedId" value="#{procedureController.prescribedMedicine.prescribedId}" readonly="true" styleClass="form-control" />
                        <h:message for="prescribedId" styleClass="error" />
                    </div>

                    <div class="form-group">
                        <label for="prescriptionId">Prescription ID</label>
                        <h:inputText id="prescriptionId" value="#{procedureController.prescription.prescriptionId}" readonly="true" styleClass="form-control" />
                        <h:message for="prescriptionId" styleClass="error" />
                    </div>

                    <div class="form-group">
                        <label for="medicineName"><span style="color:red">*</span>Medicine Name</label>
                        <h:inputText id="medicineName" value="#{procedureController.prescribedMedicine.medicineName}" styleClass="form-control" />
                        <h:message for="medicineName" styleClass="error" />
                    </div>

                    <div class="form-group">
                        <label for="type"><span style="color:red">*</span>Medicine Type</label>
                        <h:selectOneMenu id="type" value="#{procedureController.prescribedMedicine.type}" styleClass="form-control">
                            <f:selectItem itemLabel="-- Select Type --" itemValue="" />
                            <f:selectItem itemLabel="Tablet" itemValue="TABLET" />
                            <f:selectItem itemLabel="Syrup" itemValue="SYRUP" />
                            <f:selectItem itemLabel="Injection" itemValue="INJECTION" />
                            <f:selectItem itemLabel="Drop" itemValue="DROP" />
                        </h:selectOneMenu>
                        <h:message for="type" styleClass="error" />
                    </div>

                    <div class="form-group">
                        <label for="dosage"><span style="color:red">*</span>Dosage</label>
                        <h:inputText id="dosage" value="#{procedureController.prescribedMedicine.dosage}" styleClass="form-control" />
                        <h:message for="dosage" styleClass="error" />
                    </div>

                    <div class="form-group">
                        <label for="duration"><span style="color:red">*</span>Duration (days)</label>
                        <h:inputText id="duration" value="#{procedureController.prescribedMedicine.duration}" styleClass="form-control" />
                        <h:message for="duration" styleClass="error" />
                    </div>

                    <div class="form-group">
                        <label for="startDate"><span style="color:red">*</span>Start Date</label>
                        <h:inputText id="startDate" value="#{procedureController.prescribedMedicine.startDate}" styleClass="form-control">
                            <f:convertDateTime pattern="yyyy-MM-dd" />
                        </h:inputText>
                        <h:message for="startDate" styleClass="error" />
                        <script>
                            const calendarInput = document.querySelector("#startDate");
                            if (calendarInput) {
                                calendarInput.setAttribute("type", "date");
                            }
                        </script>
                    </div>

                    <div class="form-group full-width">
                        <label for="notes">Notes</label>
                        <h:inputTextarea id="notes" value="#{procedureController.prescribedMedicine.notes}" styleClass="form-control" />
                        <h:message for="notes" styleClass="error" />
                    </div>
                </div>

                <div class="button-group">
                    <h:commandButton value="Add Medicine" action="#{procedureController.addPresribedMedicinesController(procedureController.prescribedMedicine)}" styleClass="btn-add" />
                    <h:commandButton value="Reset Form" action="#{procedureController.createNewPrescribedMedicine()}" immediate="true" styleClass="btn-reset" />
                </div>

               <h:commandButton value="back"
							action="#{procedureController.backFromAddMedicine()}"
							styleClass="shared-button" />
         
        </h:form>
         </div>
    </div>
    </div>
</body>
</html>
</f:view>