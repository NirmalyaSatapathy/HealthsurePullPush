<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>

<f:view>
	<html>
<head>
<title>Add Procedure Test</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/AddTest.css" />
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
						<h:outputLabel for="testName"><span
								style="color: red">*</span>Test Name 
						</h:outputLabel>
						<h:inputText id="testName"
							value="#{procedureController.procedureTest.testName}"
							styleClass="form-control" />
						<h:message for="testName" styleClass="error-message" />
					</div>

					<div class="form-group">
						<h:outputLabel for="testDate"><span
								style="color: red">*</span>Test Date (yyyy-MM-dd) 
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
						<h:outputLabel for="resultSummary"><span
								style="color: red">*</span>Result Summary 
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
							action="#{procedureController.backFromAddTest()}"
							styleClass="shared-button" />
					</div>
				</h:form>
			</div>
		</div>
	</div>
</body>
	</html>
</f:view>