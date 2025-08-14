<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<f:view>
<html>
<head>
    <title>Add Procedure Log</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/AddProcedureLog.css" />
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
</head>
<body>
<div class="page-wrapper">
    <jsp:include page="/navbar/NavProvider.jsp" />

    <div class="main-content">
        <div class="form-container">
            <div class="form-title">Add Daily Procedure Log</div>

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
                        <h:outputLabel for="loggedBy"> <span style="color: red">*</span>Logged by</h:outputLabel>
                        <h:inputText id="loggedBy" value="#{procedureController.procedureLog.loggedDoctor.doctorId}" styleClass="form-control" />
                    <h:message for="loggedBy" styleClass="error-message" />
                    </div>
                    <div class="form-group full-width">
                        <h:outputLabel for="logDate"><span style="color:red">*</span>Log Date</h:outputLabel>
                        <h:inputText id="logDate" value="#{procedureController.procedureLog.logDate}" styleClass="form-control">
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
                        <h:outputLabel for="notes">Notes</h:outputLabel>
                        <h:inputTextarea id="notes" value="#{procedureController.procedureLog.notes}" rows="4" styleClass="form-control" />
                        <h:message for="notes" styleClass="error-message" />
                    </div>
                </div>

                <div class="button-group">
                    <h:commandButton value="Save Log" action="#{procedureController.addProcedureLogController(procedureController.procedureLog)}" styleClass="btn-add" />
                    <h:commandButton value="Reset Form" action="#{procedureController.createNewProcedureLog()}" immediate="true" styleClass="btn-reset" />
                </div>
                <h:commandButton value="back"
							action="LongTermProcedureDashboard?faces-redirect=true"
							styleClass="shared-button" />
            </h:form>
        </div>
    </div>
</div>
</body>
</html>
</f:view>