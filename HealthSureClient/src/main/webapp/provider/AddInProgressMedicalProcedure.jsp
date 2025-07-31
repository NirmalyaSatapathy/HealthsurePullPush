<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>

<f:view>
<html>
<head>
    <title>Add In-Progress Medical Procedure</title>

    <!-- Disable caching -->
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
    <meta http-equiv="Pragma" content="no-cache" />
    <meta http-equiv="Expires" content="0" />

    <script type="text/javascript">
        window.addEventListener('pageshow', function(event) {
            var navEntries = performance.getEntriesByType && performance.getEntriesByType("navigation");
            var navType = navEntries && navEntries.length ? navEntries[0].type : "";
            if (event.persisted || navType === "back_forward") {
                document.querySelectorAll('.error').forEach(function(el) {
                    el.textContent = '';
                });
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
             margin-top:90px;
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

        label {
            font-weight: bold;
            margin-bottom: 4px;
            font-size: 15px;
        }

        .form-control {
            width: 100%;
            padding: 6px;
            border-radius: 4px;
            border: 1px solid #ccc;
            box-sizing: border-box;
            font-size: 15px;
        }

        h\:inputTextarea.form-control {
            resize: vertical;
            min-height: 36px;
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
            margin-top: 10px;
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
</head>
<body>
    <div class="page-wrapper">
        <jsp:include page="/navbar/NavProvider.jsp" />

        <div class="main-content">
            <div class="form-container">
                <div class="form-title">In-Progress Long-Term Medical Procedure</div>

                <h:form prependId="false">
                    <h:messages globalOnly="true" styleClass="error" />

                    <div class="form-grid">
                        <div class="form-group">
                            <label for="procedureId">Procedure ID</label>
                            <h:inputText id="procedureId" value="#{procedureController.procedure.procedureId}" readonly="true" styleClass="form-control" />
                            <h:message for="procedureId" styleClass="error" />
                        </div>

                        <div class="form-group">
                            <label for="appointmentId">Appointment ID <span style="color:red">*</span></label>
                            <h:inputText id="appointmentId" value="#{procedureController.procedure.appointment.appointmentId}" readonly="true" styleClass="form-control" />
                            <h:message for="appointmentId" styleClass="error" />
                        </div>

                        <div class="form-group">
                            <label for="recipientId">Patient (h_id) <span style="color:red">*</span></label>
                            <h:inputText id="recipientId" value="#{procedureController.procedure.recipient.hId}" readonly="true" styleClass="form-control" />
                            <h:message for="recipientId" styleClass="error" />
                        </div>

                        <div class="form-group">
                            <label for="providerId">Provider ID <span style="color:red">*</span></label>
                            <h:inputText id="providerId" value="#{procedureController.procedure.provider.providerId}" readonly="true" styleClass="form-control" />
                            <h:message for="providerId" styleClass="error" />
                        </div>

                        <div class="form-group">
                            <label for="doctorId">Doctor ID <span style="color:red">*</span></label>
                            <h:inputText id="doctorId" value="#{procedureController.procedure.doctor.doctorId}" readonly="true" styleClass="form-control" />
                            <h:message for="doctorId" styleClass="error" />
                        </div>

                        <div class="form-group">
                            <label for="startDate">Start Date <span style="color:red">*</span></label>
                            <h:inputText id="startDate" value="#{procedureController.procedure.fromDate}"  styleClass="form-control">
                                <f:convertDateTime pattern="yyyy-MM-dd" />
                            </h:inputText>
                            <h:message for="startDate" styleClass="error" />
                             <script>
                                let s = document.querySelector('#startDate');
                                if (s) s.setAttribute('type', 'date');
                            </script>
                        </div>

                        <div class="form-group full-width">
                            <label for="diagnosis"><span style="color:red">*</span>Diagnosis</label>
                            <h:inputTextarea id="diagnosis" value="#{procedureController.procedure.diagnosis}" styleClass="form-control" />
                            <h:message for="diagnosis" styleClass="error" />
                        </div>

                        <div class="form-group full-width">
                            <label for="recommendations">Recommendations</label>
                            <h:inputTextarea id="recommendations" value="#{procedureController.procedure.recommendations}" styleClass="form-control" />
                            <h:message for="recommendations" styleClass="error" />
                        </div>
                    </div>

                    <div class="button-group">
                        <h:commandButton value="Add In-Progress Procedure"
                                         styleClass="btn-add"
                                         action="#{procedureController.addInProgressMedicalProcedureController(procedureController.procedure)}" />

                        <h:commandButton value="Reset Form"
                                         styleClass="btn-reset"
                                         action="#{procedureController.createNewProcedure()}" />
                    </div>
                </h:form>
            </div>
        </div>
    </div>
</body>
</html>
</f:view>