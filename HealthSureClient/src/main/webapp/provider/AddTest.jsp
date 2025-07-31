<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>

<f:view>
	<html>
<head>
<title>Add Procedure Test</title>

<!-- Prevent caching -->
<meta http-equiv="Cache-Control"
	content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />

<script type="text/javascript">
    window.addEventListener('pageshow', function(event) {
      var navEntries = performance.getEntriesByType?.("navigation");
      var navType = navEntries?.length ? navEntries[0].type : "";
      if (event.persisted || navType === "back_forward") {
        document.querySelectorAll('.error-message').forEach(el => el.textContent = '');
      }
    });
  </script>

<style>
html, body {
	margin: 0;
	padding: 0;
	height: 100%;
	font-family: 'Segoe UI', sans-serif;
	background-color: #f4f8fb;
	overflow: hidden;
}

.page-wrapper {
	display: flex;
	flex-direction: column;
	height: 100vh;
}

.main-content {
	flex-grow: 1;
	display: flex;
	justify-content: center;
	align-items: center;
	padding: 10px;
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

.form-group {
	display: flex;
	flex-direction: column;
	margin-bottom: 10px;
}

label, h\:outputLabel {
	font-weight: bold;
	margin-bottom: 4px;
	font-size: 15px;
	color: #2c3e50;
}

.form-control {
	width: 100%;
	padding: 6px;
	border-radius: 4px;
	border: 1px solid #ccc;
	box-sizing: border-box;
	font-size: 15px;
}

.error-message {
	display: block;
	color: #f44336 !important;
	font-size: 14px;
	font-weight: 600;
	margin-top: 3px;
}

.button-row {
	display: flex;
	flex-wrap: wrap;
	gap: 10px;
	justify-content: center;
	margin-top: 15px;
}

.shared-button {
	flex: 1;
	min-width: 100px;
	padding: 8px 14px;
	font-size: 14px;
	border: none;
	border-radius: 5px;
	color: white;
	background-color: #00796b;
	cursor: pointer;
	text-align: center;
	transition: background-color 0.3s ease;
}

.shared-button:hover {
	background-color: #004d40;
}
</style>
</head>

<body>
	<div class="page-wrapper">
		<jsp:include page="/navbar/NavProvider.jsp" />
		<div class="main-content">
			<div class="form-container">
				<div class="form-title">Add Procedure Test</div>

				<h:form prependId="false">
					<h:messages globalOnly="true" styleClass="error-message" />

					<div class="form-group">
						<h:outputLabel for="prescriptionId" value="Prescription ID:" />
						<h:inputText id="prescriptionId"
							value="#{procedureController.prescription.prescriptionId}"
							readonly="true" styleClass="form-control" />
					</div>

					<div class="form-group">
						<h:outputLabel for="testId" value="Test ID:" />
						<h:inputText id="testId"
							value="#{procedureController.procedureTest.testId}"
							readonly="true" styleClass="form-control" />
						<h:message for="testId" styleClass="error-message" />
					</div>

					<div class="form-group">
						<h:outputLabel for="testName">Test Name <span
								style="color: red">*</span>
						</h:outputLabel>
						<h:inputText id="testName"
							value="#{procedureController.procedureTest.testName}"
							styleClass="form-control" />
						<h:message for="testName" styleClass="error-message" />
					</div>

					<div class="form-group">
						<h:outputLabel for="testDate">Test Date (yyyy-MM-dd) <span
								style="color: red">*</span>
						</h:outputLabel>
						<h:inputText id="testDate"
							value="#{procedureController.procedureTest.testDate}"
							styleClass="form-control">
							<f:convertDateTime pattern="yyyy-MM-dd" />
						</h:inputText>
						<h:message for="testDate" styleClass="error-message" />
						<script>
                                let e = document.querySelector('#testDate');
                                if (e) e.setAttribute('type', 'date');
                            </script>
					</div>

					<div class="form-group">
						<h:outputLabel for="resultSummary">Result Summary <span
								style="color: red">*</span>
						</h:outputLabel>
						<h:inputTextarea id="resultSummary"
							value="#{procedureController.procedureTest.resultSummary}"
							rows="4" styleClass="form-control" />
						<h:message for="resultSummary" styleClass="error-message" />
					</div>

					<div class="button-row">
						<h:commandButton value="Save Test"
							action="#{procedureController.addTestController(procedureController.procedureTest)}"
							styleClass="shared-button" />
						<h:commandButton value="Reset Form"
							action="#{procedureController.createNewProcedureTest()}"
							immediate="true" styleClass="shared-button" />
						<h:commandButton value="back"
							action="PrescriptionDashboard?faces-redirect=true"
							styleClass="shared-button" />
					</div>
				</h:form>
			</div>
		</div>
	</div>
</body>
	</html>
</f:view>