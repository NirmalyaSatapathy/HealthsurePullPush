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
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/PrescriptionDashboard.css" />
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
							<h:outputText
								value="#{procedureController.procedure.recipient.firstName}" />
						</div>
						<div class="summary-item">
							<strong>Diagnosis:</strong>
							<h:outputText value="#{procedureController.procedure.diagnosis}" />
						</div>
						<div class="summary-item">
							<strong>Prescribed By:</strong>
							<h:outputText
								value="#{procedureController.prescription.prescribedDoc.doctorName}">
								<f:convertDateTime pattern="dd MMM yyyy" />
							</h:outputText>
						</div>
						<div class="summary-item">
							<strong>Procedure Doctor:</strong>
							<h:outputText
								value="#{procedureController.procedure.doctor.doctorName}" />
						</div>
						<div class="summary-item">
							<strong>Prescription Start Date:</strong>
							<h:outputText
								value="#{procedureController.prescription.startDate}">
								<f:convertDateTime pattern="dd MMM yyyy" />
							</h:outputText>
						</div>
						<div class="summary-item">
							<strong>Prescription End Date:</strong>
							<h:outputText value="#{procedureController.prescription.endDate}">
								<f:convertDateTime pattern="dd MMM yyyy" />
							</h:outputText>
						</div>
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
				<h:panelGroup
					rendered="#{not empty procedureController.currentPrescribedMedicines}">
					<div class="button-group">
						<h:commandButton value="View added medicines"
							action="#{procedureController.viewCurrentMedicines()}"
							styleClass="action-button edit-row" />
					</div>
				</h:panelGroup>
				<h:panelGroup
					rendered="#{not empty procedureController.currentPrescribedTests}">
					<div class="button-group">
						<h:commandButton value="View added tests"
							action="#{procedureController.viewCurrentTests()}"
							styleClass="action-button edit-row" />
					</div>
				</h:panelGroup>
				<h:panelGroup rendered="#{procedureController.prescription != null}">
					<div class="button-group">
						<h:commandButton value="Edit Prescription"
							action="#{procedureController.editLastPrescription()}"
							styleClass="action-button edit-row" />
					</div>
				</h:panelGroup>
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