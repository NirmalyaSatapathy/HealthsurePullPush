<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<f:view>
<html>
<head>
	<meta charset="UTF-8">
	<title>Procedure Navigation Panel</title>
	<link rel="stylesheet" href="css/healthsure-style.css" />
	<style>
		body {
			font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
			background-color: #f2f7fb;
			margin: 0;
			padding: 0;
		}

		.nav-container {
			max-width: 720px;
			margin: 60px auto;
			padding: 2rem;
			background-color: #ffffff;
			border-radius: 0.75rem;
			box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
			text-align: center;
			margin-top: 130px;
		}

		.nav-title {
			font-size: 2rem;
			font-weight: 700;
			color: #2c3e50;
			margin-bottom: 1.5rem;
			line-height: 1.2;
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
		}

		.button-group {
			flex: 0 1 140px;
		}

		/* Base Button Styling */
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

		/* 🔵 First Row Buttons */
		.action-button.first-row {
			background-color: mediumturquoise;
			color: white;
		}

		.action-button.first-row:hover {
			background-color: lightgray;
			color: #1f2937;
		}

		/* 🟢 Second Row Buttons */
		.action-button.second-row {
			background-color: grey;
			color: #1f2937;
		}

		.action-button.second-row:hover {
			background-color: darkseagreen;
			color: white;
		}

		.action-button:focus {
			outline: 2px solid #31b0d5;
			outline-offset: 2px;
		}
	</style>
</head>
<body>
	<jsp:include page="/navbar/NavProvider.jsp" />

	<div class="nav-container">
		<div class="nav-title">Procedure Navigation Panel</div>

		<h:form prependId="false">

			<!-- Summary Section -->
			<h:panelGroup rendered="#{not empty procedureController.procedure}">
				<div class="summary-section">
					<div class="summary-item">
						<strong>Recipient Name:</strong>
						<h:outputText value="#{procedureController.procedure.recipient.firstName}" />
					</div>
					<div class="summary-item">
						<strong>Diagnosis:</strong>
						<h:outputText value="#{procedureController.procedure.diagnosis}" />
					</div>
					<div class="summary-item">
						<strong>Procedure Date:</strong>
						<h:outputText value="#{procedureController.procedure.procedureDate}">
							<f:convertDateTime pattern="dd MMM yyyy" />
						</h:outputText>
					</div>
					<div class="summary-item">
						<strong>Procedure Doctor:</strong>
						<h:outputText value="#{procedureController.procedure.doctor.doctorName}" />
					</div>
				</div>
			</h:panelGroup>

			<!-- 🔵 Button Row 1: Add & Review -->
			<div class="button-row">
				<div class="button-group">
					<h:commandButton value="Add Prescription"
						action="#{procedureController.createNewPrescription()}"
						styleClass="action-button first-row" />
				</div>
				<h:panelGroup rendered="#{not empty procedureController.prescriptions}">
					<div class="button-group">
						<h:commandButton value="Review Prescriptions"
							action="#{procedureController.loadViewPrescriptions()}"
							styleClass="action-button first-row" />
					</div>
				</h:panelGroup>
			</div>

			<!-- 🟢 Button Row 2: Submit & Edit -->
			<div class="button-row">
				<div class="button-group">
					<h:commandButton value="Submit Procedure"
						action="#{procedureController.procedureSubmit()}"
						styleClass="action-button second-row" />
				</div>
				<h:panelGroup layout="block" rendered="#{procedureController.isFlag() ne false}">
					<div class="button-group">
						<h:commandButton value="Edit Procedure"
							action="#{procedureController.gotoProcedureForm()}"
							styleClass="action-button second-row" />
					</div>
				</h:panelGroup>
			</div>

		</h:form>
	</div>
</body>
</html>
</f:view>