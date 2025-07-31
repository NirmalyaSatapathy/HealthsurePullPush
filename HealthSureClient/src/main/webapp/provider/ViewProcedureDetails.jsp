<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<f:view>
<html>
<head>
    <title>Started Procedure Details</title>

    <!-- Disable caching -->
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
    <meta http-equiv="Pragma" content="no-cache" />
    <meta http-equiv="Expires" content="0" />

    <style>
        html, body {
            margin: 0;
            padding: 0;
            height: 100%;
            font-family: 'Segoe UI', Tahoma, sans-serif;
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
            padding: 20px;
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
            gap: 10px;
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
            color: #2c3e50;
        }

        .form-control {
            width: 100%;
            padding: 6px;
            border-radius: 4px;
            border: 1px solid #ccc;
            font-size: 14px;
            box-sizing: border-box;
        }

        h\:inputTextarea.form-control {
            resize: vertical;
            min-height: 40px;
        }

        .error-message {
            color: #d32f2f;
            font-size: 13px;
            margin-top: 3px;
        }

        .button-group {
            display: flex;
            justify-content: center;
            gap: 16px;
            margin-top: 18px;
        }

        .green-button {
            background-color: #28a745;
            color: white;
            padding: 10px 20px;
            font-size: 14px;
            font-weight: bold;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .green-button:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
    <div class="page-wrapper">
        <jsp:include page="/navbar/NavProvider.jsp" />

        <div class="main-content">
            <div class="form-container">
                <div class="form-title">Procedure Details</div>

                <h:form prependId="false">
                    <h:messages globalOnly="true" styleClass="error-message" />

                    <div class="form-grid">
                        <div class="form-group">
                            <label for="procedureId">Procedure ID</label>
                            <h:inputText id="procedureId" value="#{procedureController.procedure.procedureId}" readonly="true" styleClass="form-control" />
                        </div>

                        <div class="form-group">
                            <label for="appointmentId">Appointment ID <span style="color:red">*</span></label>
                            <h:inputText id="appointmentId" value="#{procedureController.procedure.appointment.appointmentId}" readonly="true" styleClass="form-control" />
                            <h:message for="appointmentId" styleClass="error-message" />
                        </div>

                        <div class="form-group">
                            <label for="recipientId">Patient (h_id) <span style="color:red">*</span></label>
                            <h:inputText id="recipientId" value="#{procedureController.procedure.recipient.hId}" readonly="true" styleClass="form-control" />
                            <h:message for="recipientId" styleClass="error-message" />
                        </div>

                        <div class="form-group">
                            <label for="providerId">Provider ID <span style="color:red">*</span></label>
                            <h:inputText id="providerId" value="#{procedureController.procedure.provider.providerId}" readonly="true" styleClass="form-control" />
                            <h:message for="providerId" styleClass="error-message" />
                        </div>

                        <div class="form-group">
                            <label for="doctorId">Doctor ID <span style="color:red">*</span></label>
                            <h:inputText id="doctorId" value="#{procedureController.procedure.doctor.doctorId}" readonly="true" styleClass="form-control" />
                            <h:message for="doctorId" styleClass="error-message" />
                        </div>

                        <div class="form-group">
                            <label for="procedureDate">Procedure Start Date <span style="color:red">*</span></label>
                            <h:inputText id="fromDate" value="#{procedureController.procedure.fromDate}" readonly="true" styleClass="form-control">
                                <f:convertDateTime pattern="yyyy-MM-dd" />
                            </h:inputText>
                            <h:message for="procedureDate" styleClass="error-message" />
                        </div>

                        <div class="form-group full-width">
                            <label for="diagnosis">Diagnosis <span style="color:red">*</span></label>
                            <h:inputTextarea id="diagnosis" value="#{procedureController.procedure.diagnosis}" readonly="true" styleClass="form-control" />
                            <h:message for="diagnosis" styleClass="error-message" />
                        </div>

                        <div class="form-group full-width">
                            <label for="recommendations">Recommendations</label>
                            <h:inputTextarea id="recommendations" value="#{procedureController.procedure.recommendations}" styleClass="form-control" />
                            <h:message for="recommendations" styleClass="error-message" />
                        </div>
                    </div>

                    <div class="button-group">
                        <h:commandButton value="Add Details" styleClass="green-button" action="#{procedureController.updateProcedure()}" />
                    </div>
                </h:form>
            </div>
        </div>
    </div>
</body>
</html>
</f:view>