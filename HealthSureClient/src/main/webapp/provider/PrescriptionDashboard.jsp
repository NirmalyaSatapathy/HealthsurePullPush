<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<f:view>
	<html>
<head>
<meta charset="UTF-8">
<title>Prescribed Medicines Dashboard</title>
<link rel="stylesheet" href="css/healthsure-style.css" />
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #eef5f9;
	margin: 0;
	padding: 0;
}

.dashboard-container {
	max-width: 700px;
	margin: 80px auto;
	padding: 30px;
	background-color: #fff;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	text-align: center;
	margin-top: 130px;
}

.dashboard-title {
	font-size: 26px;
	font-weight: bold;
	color: #2a3f54;
	margin-bottom: 30px;
}

.button-row {
	display: grid;
	grid-template-columns: repeat(3, minmax(140px, 1fr));
	gap: 20px 30px;
	justify-items: center;
	margin-bottom: 20px;
}

.button-group {
	width: 100%;
	max-width: 200px;
}

.action-button {
	width: 100%;
	padding: 12px 0; /* increased vertical padding */
	font-size: 16px;
	border: none;
	border-radius: 6px; /* matching roundness */
	color: #fff;
	cursor: pointer;
	transition: background-color 0.2s, transform 0.1s;
	text-decoration: none;
}

.action-button:hover {
	transform: translateY(-1px);
}

.action-button:focus {
	outline: 3px solid currentColor;
}

/* Add Buttons */
.add-button {
	background-color: #28a745;
}

.add-button:hover {
	background-color: #218838;
}

/* Edit Buttons */
.edit-button {
	background-color: #ffc107;
	color: #212529;
}

.edit-button:hover {
	background-color: #e0a800;
}

/* Submit & Back Buttons */
.submit-button {
	background-color: #17a2b8;
}

.submit-button:hover {
	background-color: #117a8b;
}

.error-message {
	margin-top: 5px;
	color: red;
	font-size: 12px;
}

@media ( max-width : 600px) {
	.button-row {
		grid-template-columns: repeat(2, 1fr);
	}
}

@media ( max-width : 400px) {
	.button-row {
		grid-template-columns: 1fr;
	}
}
</style>
</head>
<body>
	<jsp:include page="/navbar/NavProvider.jsp" />
	<div class="dashboard-container">
		<div class="dashboard-title">Prescription Dashboard</div>

		<h:form prependId="false">
			<div class="button-row">

				<div class="button-group">
					<h:commandButton id="addMed" value="Add Medicine"
						action="#{procedureController.createNewPrescribedMedicine()}"
						styleClass="action-button add-button" />
					<h:message for="addMed" styleClass="error-message" />
				</div>

				<div class="button-group">
					<h:commandButton id="addTest" value="Add Test"
						action="#{procedureController.createNewProcedureTest()}"
						styleClass="action-button add-button" />
					<h:message for="addTest" styleClass="error-message" />
				</div>
				<h:panelGroup rendered="#{not empty procedureController.prescribedMedicines}">
					<div class="button-group">
						<h:commandButton value="Edit last medicine"
							action="#{procedureController.editLastMedicine()}"
							styleClass="action-button edit-button" />
					</div>
				</h:panelGroup>
				<h:panelGroup rendered="#{not empty procedureController.procedureTests}">
					<div class="button-group">
						<h:commandButton value="Edit last test"
							action="#{procedureController.editLastTest()}"
							styleClass="action-button edit-button" />
					</div>
				</h:panelGroup>
				<div class="button-group">
					<h:commandButton value="Edit Prescription"
						action="AddPrescription?faces-redirect=true"
						styleClass="action-button edit-button" />
				</div>
				<h:panelGroup rendered="#{procedureController.flag}">
					<div class="button-group">
						<h:commandButton value="Edit Procedure"
							action="#{procedureController.gotoProcedureForm()}"
							styleClass="action-button edit-button" />
					</div>
				</h:panelGroup>

				<div class="button-group">
					<h:commandButton id="submit" value="Submit"
						action="#{procedureController.prescriptionDetailsSubmit()}"
						styleClass="action-button submit-button" />
					<h:message for="submit" styleClass="error-message" />
				</div>

				<div class="button-group">
					<h:commandButton id="back" value="Back"
						action="#{procedureController.backFromPrescription()}"
						styleClass="action-button submit-button" />
					<h:message for="back" styleClass="error-message" />
				</div>

			</div>
		</h:form>
	</div>
</f:view>
</body>
</html>