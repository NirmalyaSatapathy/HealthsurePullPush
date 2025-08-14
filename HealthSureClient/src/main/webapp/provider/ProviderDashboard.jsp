<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core" %>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html" %>

<f:view>
<html>
<head>
  <meta charset="UTF-8">
  <title>Provider Dashboard</title>
 <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/ProviderDashboard.css" />
</head>

<body>
  <jsp:include page="/navbar/NavProvider.jsp" />

  <h:form prependId="false">
    <div class="dashboard-container">
      <h2>Welcome to Provider's Patient Dashboard</h2>

      <div class="button-container">
        <h:commandButton value="Booked Appointments"
                         action="ShowBookedAppointments"
                         styleClass="dashboard-button btn-blue" />

        <h:commandButton value="Patient Insurance Details"
                         action="showInsuranceDetails"
                         styleClass="dashboard-button btn-purple" />
                         
        <h:commandButton value="Ongoing Procedures"
                         action="ShowOnGoingProcedures"
                         styleClass="dashboard-button btn-orange" />
      </div>
    </div>
  </h:form>
</body>
</html>
</f:view>