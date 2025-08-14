<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<f:view>
	<html>
<head>
<title>Edit Prescription</title>@charset "UTF-8";
<style>
html, body {
	margin: 0;
	padding: 0;
	height: 100%;
	font-family: 'Segoe UI', sans-serif;
	background-color: #f4f8fb;
	overflow: auto;
}

.page-wrapper {
	display: flex;
	flex-direction: column;
	height: 100vh;
}

/* Smaller input field */
.input-small {
	width: 160px;
	margin: 0 auto;
	padding: 6px;
	font-size: 14px;
}

/* Smaller button */
.btn-small {
	width: auto;
	min-width: 100px;
	padding: 6px 12px;
	font-size: 14px;
	border: none;
	border-radius: 5px;
	color: white;
	cursor: pointer;
}

/* Authentication button styles */
.btn-authenticate {
	background-color: #4CAF50;
}

.btn-authenticate:hover {
	background-color: #388e3c;
}

/* Back button styles */
.btn-back {
	background-color: black;
}

.btn-back:hover {
	background-color: #333;
}

/* Button row for authentication */
.auth-button-row {
	display: flex;
	justify-content: center;
	gap: 10px;
	margin-top: 12px;
}

/* Optional: reduce max width of the whole group */
.compact-auth {
	max-width: 350px;
	margin: 0 auto;
	text-align: center;
	display: flex;
	flex-direction: column;
	align-items: center;
}

.main-content {
	flex-grow: 1;
	padding: 10px;
	overflow-y: auto;
	display: flex;
	justify-content: center;
	align-items: flex-start;
	margin-top: 90px;
}

.form-container {
	max-width: 600px;
	width: 100%;
	padding: 15px;
	background-color: #ffffff;
	border-radius: 10px;
	box-shadow: 0 0 10px #ccc;
}

.form-title {
	text-align: center;
	font-size: 22px;
	margin-bottom: 12px;
	color: #2a3f54;
}

.form-grid {
	display: grid;
	grid-template-columns: repeat(2, 1fr);
	gap: 8px;
}

.form-group {
	display: flex;
	flex-direction: column;
}

.form-group.full-width {
	grid-column: 1/-1;
}

label {
	font-weight: bold;
	margin-bottom: 4px;
	font-size: 15px;
	color: #2a3f54;
}

.form-control {
	width: 100%;
	padding: 6px;
	border-radius: 4px;
	border: 1px solid #ccc;
	box-sizing: border-box;
	font-size: 15px;
}

.error {
	display: block;
	color: #f44336 !important;
	font-size: 14px;
	font-weight: 600;
	margin-top: 3px;
}

.button-group {
	display: flex;
	justify-content: center;
	gap: 10px;
	margin-top: 15px;
}

.btn-add, .btn-reset {
	padding: 8px 14px;
	font-size: 14px;
	border: none;
	border-radius: 5px;
	color: white;
	cursor: pointer;
}

.btn-add {
	background-color: #28a745;
}

.btn-add:hover {
	background-color: #218838;
}

.btn-reset {
	background-color: #007bff;
}

.btn-reset:hover {
	background-color: #0056b3;
}
</style>
<!-- Disable caching -->
<meta http-equiv="Cache-Control"
	content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />

<script type="text/javascript">
        window.addEventListener('pageshow', function(event) {
            var navEntries = performance.getEntriesByType && performance.getEntriesByType("navigation");
            var navType    = navEntries && navEntries.length ? navEntries[0].type : "";
            if (event.persisted || navType === "back_forward") {
                document.querySelectorAll('.error').forEach(function(el) {
                    el.textContent = '';
                });
            }
        });
    </script>
</head>

<body>
	<div class="page-wrapper">
		<jsp:include page="/navbar/NavProvider.jsp" />

		<div class="main-content">
			<div class="form-container">
				<div class="form-title">Edit Prescription Details</div>

				<h:form prependId="false">
					<h:messages globalOnly="true" styleClass="error" />
					<h:panelGroup
						rendered="#{procedureController.procedure.type ne 'SINGLE_DAY' and not procedureController.validDoctor}">

						<div class="form-group center-group compact-auth">
							<h:outputLabel for="doctorId" value="Enter Doctor ID:" />

							<h:inputText id="doctorId"
								value="#{procedureController.authDoctorId}"
								styleClass="form-control input-small" />

							<h:message for="doctorId" styleClass="error" />

							<div class="auth-button-row">
								<h:commandButton value="Authenticate"
									action="#{procedureController.authenticatePrescriptionDoctor(procedureController.authDoctorId)}"
									styleClass="btn-small btn-authenticate" />

								<h:commandButton value="Back"
									action="ViewPrescriptions?faces-redirect=true"
									styleClass="btn-small btn-back" />
							</div>
						</div>
					</h:panelGroup>
					<h:panelGroup rendered="#{procedureController.validDoctor}">
						<!-- Top IDs grid -->
						<div class="form-grid">
							<div class="form-group">
								<label for="prescriptionId">Prescription ID</label>
								<h:inputText id="prescriptionId"
									value="#{procedureController.prescription.prescriptionId}"
									styleClass="form-control" readonly="true" />
							</div>

							<div class="form-group">
								<label for="procedureId">Procedure ID</label>
								<h:inputText id="procedureId"
									value="#{procedureController.procedure.procedureId}"
									styleClass="form-control" readonly="true" />
							</div>

							<div class="form-group">
								<label for="recipientId">Recipient ID</label>
								<h:inputText id="recipientId"
									value="#{procedureController.procedure.recipient.hId}"
									styleClass="form-control" readonly="true" />
							</div>

							<div class="form-group">
								<label for="providerId">Provider ID</label>
								<h:inputText id="providerId"
									value="#{procedureController.procedure.provider.providerId}"
									styleClass="form-control" readonly="true" />
							</div>

							<div class="form-group">
								<label for="doctorId">Doctor ID</label>
								<h:inputText
									value="#{procedureController.procedure.doctor.doctorId}"
									styleClass="form-control" readonly="true" />
							</div>
							<h:panelGroup
								rendered="#{procedureController.procedure.type ne 'SINGLE_DAY'}"
								styleClass="form-group full-width">
								<div class="form-group">
									<label for="prescribedBy"><span
									style="color: red">*</span>Prescribed BY</label>
									<h:inputText id="prescribedBy"
										value="#{procedureController.prescription.prescribedDoc.doctorId}"
										styleClass="form-control" readonly="true" />
									<h:message for="prescribedBy" styleClass="error" />
								</div>
							</h:panelGroup>
						</div>

						<!-- Date fields grid -->
						<div class="form-grid" style="margin-top: 12px;">
							<h:panelGroup
								rendered="#{procedureController.procedure.type ne 'SINGLE_DAY'}"
								styleClass="form-group full-width">
								<label for="writtenOn"><span
									style="color: red">*</span>Written On </label>
								<h:inputText id="writtenOn"
									value="#{procedureController.prescription.writtenOn}"
									styleClass="form-control" readonly="true">
									<f:convertDateTime pattern="yyyy-MM-dd" />
								</h:inputText>
								<h:message for="writtenOn" styleClass="error" />
								<script>
                                let w = document.querySelector('#writtenOn');
                                if (w) w.setAttribute('type', 'date');
                            </script>
							</h:panelGroup>

							<div class="form-group full-width">
								<label for="startDate"><span
									style="color: red">*</span>Start Date</label>
								<h:inputText id="startDate"
									value="#{procedureController.prescription.startDate}"
									styleClass="form-control">
									<f:convertDateTime pattern="yyyy-MM-dd" />
								</h:inputText>
								<h:message for="startDate" styleClass="error" />
								<script>
                                let s = document.querySelector('#startDate');
                                if (s) s.setAttribute('type', 'date');
                            </script>
							</div>

							<div class="form-group full-width">
								<label for="endDate"><span
									style="color: red">*</span>End Date</label>
								<h:inputText id="endDate"
									value="#{procedureController.prescription.endDate}"
									styleClass="form-control">
									<f:convertDateTime pattern="yyyy-MM-dd" />
								</h:inputText>
								<h:message for="endDate" styleClass="error" />
								<script>
                                let e = document.querySelector('#endDate');
                                if (e) e.setAttribute('type', 'date');
                            </script>
							</div>
							<div class="form-group full-width">
								<label for="notes">Notes</label>
								<h:inputTextarea id="notes"
									value="#{procedureController.prescription.notes}"
									styleClass="form-control" />
								<h:message for="notes" styleClass="error" />
							</div>
						</div>

						<!-- Action buttons -->
						<div class="button-group">
							<h:commandButton value="Save Prescription" styleClass="btn-add"
								action="#{procedureController.updatePrescription(procedureController.prescription)}" />

							<h:commandButton value="Reset Form" styleClass="btn-reset"
								immediate="true"
								action="#{procedureController.resetEditPrescription()}" />
							<h:commandButton value="back"
								action="#{procedureController.backFromEditPrescription()}"
							styleClass="shared-button" />
						</div>
					</h:panelGroup>
				</h:form>
			</div>
		</div>
	</div>
</body>
	</html>
</f:view>