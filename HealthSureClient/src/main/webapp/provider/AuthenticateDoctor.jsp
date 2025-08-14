<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core" %>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html" %>
<f:view>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Doctor Authentication</title>
</head>
<body>
    <h:form>
        <h:panelGrid columns="2" cellpadding="5">
            <h:outputLabel for="doctorId" value="Enter Doctor ID:" />
            <h:inputText id="doctorId" value="#{procedureController.doctorId}" />

            <h:outputText value="" />
            <h:commandButton value="Authenticate" action="#{procedureController.authenticateDoctor(procedureController.doctorId)}" />
        </h:panelGrid>
    </h:form>
</body>
</html>
</f:view>