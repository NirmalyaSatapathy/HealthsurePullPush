<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<f:view>
<html>
<head>
    <title>Edit Procedure Log</title>

    <!-- Prevent HTML caching -->
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
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
            grid-column: 1 / -1;
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

        .button-group {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 10px;
        }

        .btn-add, .btn-reset, .action-button {
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

        .action-button {
            background-color: #6c757d;
        }

        .action-button:hover {
            background-color: #5a6268;
        }
    </style>
</head>
<body>
<div class="page-wrapper">
    <jsp:include page="/navbar/NavProvider.jsp" />

    <div class="main-content">
        <div class="form-container">
            <div class="form-title">Edit Daily Procedure Log</div>

            <h:form prependId="false">
                <h:messages globalOnly="true" styleClass="error-message" />

                <div class="form-grid">
                    <div class="form-group">
                        <h:outputLabel for="procedureId" value="Procedure ID:" />
                        <h:inputText id="procedureId" value="#{procedureController.procedure.procedureId}" readonly="true" styleClass="form-control" />
                    </div>

                    <div class="form-group">
                        <h:outputLabel for="logId" value="Log ID:" />
                        <h:inputText id="logId" value="#{procedureController.procedureLog.logId}" readonly="true" styleClass="form-control" />
                    </div>
					<div class="form-group">
                        <h:outputLabel for="loggedBy" value="Logged By:" />
                        <h:inputText id="loggedBy" value="#{procedureController.procedureLog.loggedDoctor.doctorId}" styleClass="form-control" readonly="true"/>
                    <h:message for="loggedBy" styleClass="error-message" />
                    </div>
                    <div class="form-group full-width">
                        <h:outputLabel for="logDate">Log Date <span style="color:red">*</span></h:outputLabel>
                        <h:inputText id="logDate" value="#{procedureController.procedureLog.logDate}" styleClass="form-control" readonly="true">
                            <f:convertDateTime pattern="yyyy-MM-dd" />
                        </h:inputText>
                        <h:message for="logDate" styleClass="error-message" />
                         <script>
                                let e = document.querySelector('#logDate');
                                if (e) e.setAttribute('type', 'date');
                            </script>
                    </div>

                    <div class="form-group full-width">
                        <h:outputLabel for="vitals"><span style="color:red">*</span>Vitals</h:outputLabel>
                        <h:inputText id="vitals" value="#{procedureController.procedureLog.vitals}" styleClass="form-control" />
                        <h:message for="vitals" styleClass="error-message" />
                    </div>

                    <div class="form-group full-width">
                        <h:outputLabel for="notes">Notes <span style="color:red">*</span></h:outputLabel>
                        <h:inputTextarea id="notes" value="#{procedureController.procedureLog.notes}" rows="4" styleClass="form-control" />
                        <h:message for="notes" styleClass="error-message" />
                    </div>
                </div>

                <div class="button-group">
                    <h:commandButton value="Save Log" action="#{procedureController.updateLog(procedureController.procedureLog)}" styleClass="btn-add" />
                    <h:commandButton value="Reset Form" action="#{procedureController.restEditLog()}" immediate="true" styleClass="btn-reset" />
                <h:commandButton value="back"
							action="ViewLogs?faces-redirect=true"
							styleClass="shared-button" />
                </div>
            </h:form>
        </div>
    </div>
</div>
</body>
</html>
</f:view>