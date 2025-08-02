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
			font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
			background-color: #eef5f9;
			margin: 0;
			padding: 0;
		}

		.dashboard-container {
			max-width: 720px;
			margin: 80px auto;
			padding: 2rem;
			background-color: #fff;
			border-radius: 0.75rem;
			box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
			text-align: center;
			margin-top: 130px;
		}

		.dashboard-title {
			font-size: 2rem;
			font-weight: 700;
			color: #2a3f54;
			margin-bottom: 1.5rem;
		}

		.summary-section {
			text-align: left;
			margin-bottom: 1.5rem;
			padding: 1rem 1.5rem;
			background-color: #f8f9fa;
			border-left: 4px solid #17a2b8;
			border-radius: 0.5rem;
			box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
		}

		.summary-item {
			font-size: 1rem;
			margin-bottom: 0.5rem;
			color: #34495e;
		}

		.button-row {
			display: flex;
			flex-wrap: wrap;
			justify-content: center;
			gap: 0.5rem;
			margin-top: 1rem;
			margin-bottom: 1rem;
		}

		.button-group {
			flex: 0 1 140px;
		}

		.action-button {
			display: inline-block;
			width: 100%;
			padding: 0.4rem 0.4rem;
			font-size: 0.95rem;
			font-weight: 600;
			border: none;
			border-radius: 0.375rem;
			cursor: pointer;
			transition: background-color 0.2s, transform 0.1s, box-shadow 0.2s;
			box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
			text-decoration: none;
		}

		/* 🔵 Add Buttons */
		.action-button.add-row {
			background-color: mediumturquoise;
			color: white;
		}

		.action-button.add-row:hover {
			background-color: lightgray;
			color: #1f2937;
		}

		/* 🟡 Edit Buttons */
		.action-button.edit-row {
			background-color: goldenrod;
			color: #212529;
		}

		.action-button.edit-row:hover {
			background-color: #e0a800;
			color: white;
		}

		/* 🟢 Submit/Back Buttons */
		.action-button.nav-row {
			background-color: grey;
			color: #1f2937;
		}

		.action-button.nav-row:hover {
			background-color: darkseagreen;
			color: white;
		}

		.action-button:focus {
			outline: 2px solid #31b0d5;
			outline-offset: 2px;
		}

		.error-message {
			margin-top: 5px;
			color: red;
			font-size: 12px;
		}
		.summary-grid {
	display: flex;
	flex-wrap: wrap;
	gap: 1rem;
}

.summary-item {
	flex: 1 1 45%;
}
	</style>
</head>
<body>
	<jsp:include page="/navbar/NavProvider.jsp" />
	<div class="dashboard-container">
		<div class="dashboard-title">Prescription Dashboard</div>

		<h:form prependId="false">

	<!-- Summary Section -->
<h:panelGroup rendered="#{not empty procedureController.procedure}">
	<div class="summary-section">
		<div class="summary-grid">
			<div class="summary-item">
				<strong>Recipient Name:</strong>
				<h:outputText value="#{procedureController.procedure.recipient.firstName}" />
			</div>
			<div class="summary-item">
				<strong>Diagnosis:</strong>
				<h:outputText value="#{procedureController.procedure.diagnosis}" />
			</div>
			<div class="summary-item">
				<strong>Prescribed By:</strong>
				<h:outputText value="#{procedureController.prescription.prescribedDoc.doctorName}">
					<f:convertDateTime pattern="dd MMM yyyy" />
				</h:outputText>
			</div>
			<div class="summary-item">
				<strong>Procedure Doctor:</strong>
				<h:outputText value="#{procedureController.procedure.doctor.doctorName}" />
			</div>
			<h:panelGroup rendered="#{not empty procedureController.prescription}">
				<div class="summary-item">
					<strong>Prescription Start Date:</strong>
					<h:outputText value="#{procedureController.prescription.startDate}">
						<f:convertDateTime pattern="dd MMM yyyy" />
					</h:outputText>
				</div>
				<div class="summary-item">
					<strong>Prescription End Date:</strong>
					<h:outputText value="#{procedureController.prescription.endDate}">
						<f:convertDateTime pattern="dd MMM yyyy" />
					</h:outputText>
				</div>
			</h:panelGroup>
		</div>
	</div>
</h:panelGroup>

			<!-- 🔵 Row 1: Add Actions -->
			<div class="button-row">
				<div class="button-group">
					<h:commandButton id="addMed" value="Add Medicine"
						action="#{procedureController.createNewPrescribedMedicine()}"
						styleClass="action-button add-row" />
					<h:message for="addMed" styleClass="error-message" />
				</div>

				<div class="button-group">
					<h:commandButton id="addTest" value="Add Test"
						action="#{procedureController.createNewProcedureTest()}"
						styleClass="action-button add-row" />
					<h:message for="addTest" styleClass="error-message" />
				</div>
			</div>

			<!-- 🟡 Row 2: Edit Actions -->
			<div class="button-row">
				<h:panelGroup rendered="#{not empty procedureController.prescribedMedicines}">
					<div class="button-group">
						<h:commandButton value="Edit Last Medicine"
							action="#{procedureController.editLastMedicine()}"
							styleClass="action-button edit-row" />
					</div>
				</h:panelGroup>

				<h:panelGroup rendered="#{not empty procedureController.procedureTests}">
					<div class="button-group">
						<h:commandButton value="Edit Last Test"
							action="#{procedureController.editLastTest()}"
							styleClass="action-button edit-row" />
					</div>
				</h:panelGroup>

				<div class="button-group">
					<h:commandButton value="Edit Prescription"
						action="AddPrescription?faces-redirect=true"
						styleClass="action-button edit-row" />
				</div>
			</div>

			<!-- 🟢 Row 3: Submit & Back -->
			<div class="button-row">
				<div class="button-group">
					<h:commandButton id="submit" value="Submit"
						action="#{procedureController.prescriptionDetailsSubmit()}"
						styleClass="action-button nav-row" />
					<h:message for="submit" styleClass="error-message" />
				</div>

				<div class="button-group">
					<h:commandButton id="back" value="Back"
						action="#{procedureController.backFromPrescription()}"
						styleClass="action-button nav-row" />
					<h:message for="back" styleClass="error-message" />
				</div>
			</div>
		</h:form>
	</div>
</body>
</html>
</f:view>