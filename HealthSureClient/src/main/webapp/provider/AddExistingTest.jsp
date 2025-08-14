<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>

<f:view>
<html>
<head>
    <title>Add Procedure Test</title>
    <style>
    @charset "UTF-8";

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

    .input-small {
        width: 160px;
        margin: 0 auto;
        padding: 6px;
        font-size: 14px;
    }

    .error-message {
        display: block;
        color: #f44336 !important;
        font-size: 14px;
        font-weight: 600;
        margin-top: 3px;
    }

    .compact-auth {
        max-width: 350px;
        margin: 0 auto;
        text-align: center;
    }

    .auth-button-row,
    .button-row {
        display: flex;
        justify-content: center;
        gap: 10px;
        margin-top: 12px;
        flex-wrap: wrap;
    }

    .btn-small {
        width: auto;
        min-width: 100px;
        padding: 6px 12px;
        font-size: 14px;
    }

    .btn-add {
        background-color: #28a745;
        color: white;
        padding: 8px 16px;
        border: none;
        border-radius: 6px;
        font-size: 14px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    .btn-add:hover {
        background-color: #218838;
    }

    .btn-reset {
        background-color: #007bff;
        color: white;
        padding: 8px 16px;
        border: none;
        border-radius: 6px;
        font-size: 14px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    .btn-reset:hover {
        background-color: #0056b3;
    }

    .btn-back {
        background-color: #343a40;
        color: white;
        padding: 8px 16px;
        border: none;
        border-radius: 6px;
        font-size: 14px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    .btn-back:hover {
        background-color: #23272b;
    }

    .btn-authenticate {
        background-color: #4CAF50;
        color: white;
        padding: 8px 16px;
        border: none;
        border-radius: 6px;
        font-size: 14px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    .btn-authenticate:hover {
        background-color: #138496;
    }
    </style>

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
                <div class="form-title">Add Procedure Test</div>

                <h:form prependId="false">
                    <h:messages globalOnly="true" styleClass="error" />

                    <h:panelGroup rendered="#{procedureController.procedure.type ne 'SINGLE_DAY' and not procedureController.validDoctor}">
                        <div class="form-group center-group compact-auth">
                            <h:outputLabel for="doctorId" value="Enter Doctor ID:" />
                            <h:inputText id="doctorId" value="#{procedureController.authDoctorId}" styleClass="form-control input-small" />
                            <h:message for="doctorId" styleClass="error-message" />

                            <div class="auth-button-row">
                                <h:commandButton value="Authenticate"
                                    action="#{procedureController.authenticatePrescriptionDoctor(procedureController.authDoctorId)}"
                                    styleClass="btn-small btn-authenticate" />

                                <h:commandButton value="Back"
                                    action="ViewTests?faces-redirect=true"
                                    styleClass="btn-small btn-back" />
                            </div>
                        </div>
                    </h:panelGroup>

                    <h:panelGroup rendered="#{procedureController.validDoctor}">
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
                            <h:outputLabel for="testName"> <span style="color: red">*</span>Test Name</h:outputLabel>
                            <h:inputText id="testName"
                                value="#{procedureController.procedureTest.testName}"
                                styleClass="form-control" />
                            <h:message for="testName" styleClass="error-message" />
                        </div>

                        <div class="form-group">
                            <h:outputLabel for="testDate"> <span style="color: red">*</span>Test Date (yyyy-MM-dd)</h:outputLabel>
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
                            <h:outputLabel for="resultSummary"> <span style="color: red">*</span>Result Summary</h:outputLabel>
                            <h:inputTextarea id="resultSummary"
                                value="#{procedureController.procedureTest.resultSummary}"
                                rows="4" styleClass="form-control" />
                            <h:message for="resultSummary" styleClass="error-message" />
                        </div>

                        <div class="button-row">
                            <h:commandButton value="Add Test"
                                action="#{procedureController.addExistingPrescTest(procedureController.procedureTest)}"
                                styleClass="btn-small btn-add" />
							<h:commandButton value="Reset Form"
								action="#{procedureController.createNewExistingPrescProcedureTest()}"
								immediate="true" styleClass="btn-small btn-reset" />

							<h:commandButton value="Back"
								action="ViewTests?faces-redirect=true"
								styleClass="btn-small btn-back" />
						</div>
					</h:panelGroup>
				</h:form>
			</div>
		</div>
	</div>
</body>
	</html>
</f:view>