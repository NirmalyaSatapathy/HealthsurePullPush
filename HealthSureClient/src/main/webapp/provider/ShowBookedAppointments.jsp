<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core" %>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html" %>

<f:view>
<html>
<head>
  <meta charset="UTF-8">
  <title>Booked Appointments</title>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/ShowBookedAppointments.css" />
</head>

<body>
  <h:form prependId="false">
    <h2>Search Booked Appointments</h2>

    <div class="form-group">
      <label for="doctorId"><span style="color: red;">*</span>Doctor ID:</label>
      <h:inputText id="doctorId"
                   value="#{procedureController.doctorId}"
                   styleClass="form-control" />
      <h:message for="doctorId" styleClass="error" />
    </div>

    <div class="form-group">
      <label for="appointmentId">Appointment ID (optional):</label>
      <h:inputText id="appointmentId"
                   value="#{procedureController.appointmentId}"
                   styleClass="form-control" />
      <h:message for="appointmentId" styleClass="error" />
    </div>

    <div class="form-group">
      <h:commandButton value="Search"
                       action="#{procedureController.fetchBookedAppointments()}"
                       styleClass="btn btn-primary" />

      <h:commandButton value="Reset"
                       action="#{procedureController.reset()}"
                       immediate="true"
                       styleClass="btn btn-secondary" />

      <h:commandButton value="Go to Dashboard"
                       action="#{procedureController.goToDashboard3()}"
                       styleClass="btn btn-tertiary" />
    </div>

    <h:panelGroup rendered="#{not empty procedureController.bookedAppointments}">
      <h:outputText value="Total: #{procedureController.allBookedAppointments.size()} booked appointments"
                    style="font-weight: bold; display: block; margin-top: 20px;" />

<h:dataTable value="#{procedureController.bookedAppointments}"
             var="appt"
             styleClass="data-table">

    <!-- Appointment ID -->
    <h:column>
        <f:facet name="header">
            <h:panelGroup layout="block" style="display: flex; align-items: center;">
                <h:outputText value="Appointment ID" />
                <h:panelGroup styleClass="sort-icons">
                    <h:commandLink action="#{procedureController.sortByAsc('appointmentId')}"
                                  rendered="#{!(procedureController.sortField eq 'appointmentId' and procedureController.sortAscending)}"
                                  styleClass="sort-icon">▲</h:commandLink>
                    <h:commandLink action="#{procedureController.sortByDesc('appointmentId')}"
                                  rendered="#{!(procedureController.sortField eq 'appointmentId' and not procedureController.sortAscending)}"
                                  styleClass="sort-icon">▼</h:commandLink>
                </h:panelGroup>
            </h:panelGroup>
        </f:facet>
        <h:outputText value="#{appt.appointmentId}" />
    </h:column>

    <!-- Provider ID -->
    <h:column>
        <f:facet name="header">
            <h:panelGroup layout="block" style="display: flex; align-items: center;">
                <h:outputText value="Provider ID" />
                <h:panelGroup styleClass="sort-icons">
                    <h:commandLink action="#{procedureController.sortByAsc('providerId')}"
                                  rendered="#{!(procedureController.sortField eq 'providerId' and procedureController.sortAscending)}"
                                  styleClass="sort-icon">▲</h:commandLink>
                    <h:commandLink action="#{procedureController.sortByDesc('providerId')}"
                                  rendered="#{!(procedureController.sortField eq 'providerId' and not procedureController.sortAscending)}"
                                  styleClass="sort-icon">▼</h:commandLink>
                </h:panelGroup>
            </h:panelGroup>
        </f:facet>
        <h:outputText value="#{appt.provider.providerId}" />
    </h:column>

    <!-- Doctor ID -->
    <h:column>
        <f:facet name="header">
            <h:panelGroup layout="block" style="display: flex; align-items: center;">
                <h:outputText value="Doctor ID" />
                <h:panelGroup styleClass="sort-icons">
                    <h:commandLink action="#{procedureController.sortByAsc('doctorId')}"
                                  rendered="#{!(procedureController.sortField eq 'doctorId' and procedureController.sortAscending)}"
                                  styleClass="sort-icon">▲</h:commandLink>
                    <h:commandLink action="#{procedureController.sortByDesc('doctorId')}"
                                  rendered="#{!(procedureController.sortField eq 'doctorId' and not procedureController.sortAscending)}"
                                  styleClass="sort-icon">▼</h:commandLink>
                </h:panelGroup>
            </h:panelGroup>
        </f:facet>
        <h:outputText value="#{appt.doctor.doctorId}" />
    </h:column>

    <!-- Doctor Name -->
    <h:column>
        <f:facet name="header">
            <h:panelGroup layout="block" style="display: flex; align-items: center;">
                <h:outputText value="Doctor Name" />
                <h:panelGroup styleClass="sort-icons">
                    <h:commandLink action="#{procedureController.sortByAsc('doctorName')}"
                                  rendered="#{!(procedureController.sortField eq 'doctorName' and procedureController.sortAscending)}"
                                  styleClass="sort-icon">▲</h:commandLink>
                    <h:commandLink action="#{procedureController.sortByDesc('doctorName')}"
                                  rendered="#{!(procedureController.sortField eq 'doctorName' and not procedureController.sortAscending)}"
                                  styleClass="sort-icon">▼</h:commandLink>
                </h:panelGroup>
            </h:panelGroup>
        </f:facet>
        <h:outputText value="#{appt.doctor.doctorName}" />
    </h:column>

    <!-- Recipient ID -->
    <h:column>
        <f:facet name="header">
            <h:panelGroup layout="block" style="display: flex; align-items: center;">
                <h:outputText value="Recipient ID" />
                <h:panelGroup styleClass="sort-icons">
                    <h:commandLink action="#{procedureController.sortByAsc('recipientId')}"
                                  rendered="#{!(procedureController.sortField eq 'recipientId' and procedureController.sortAscending)}"
                                  styleClass="sort-icon">▲</h:commandLink>
                    <h:commandLink action="#{procedureController.sortByDesc('recipientId')}"
                                  rendered="#{!(procedureController.sortField eq 'recipientId' and not procedureController.sortAscending)}"
                                  styleClass="sort-icon">▼</h:commandLink>
                </h:panelGroup>
            </h:panelGroup>
        </f:facet>
        <h:outputText value="#{appt.recipient.hId}" />
    </h:column>

    <!-- User Name -->
    <h:column>
        <f:facet name="header">
            <h:panelGroup layout="block" style="display: flex; align-items: center;">
                <h:outputText value="User Name" />
                <h:panelGroup styleClass="sort-icons">
                    <h:commandLink action="#{procedureController.sortByAsc('userName')}"
                                  rendered="#{!(procedureController.sortField eq 'userName' and procedureController.sortAscending)}"
                                  styleClass="sort-icon">▲</h:commandLink>
                    <h:commandLink action="#{procedureController.sortByDesc('userName')}"
                                  rendered="#{!(procedureController.sortField eq 'userName' and not procedureController.sortAscending)}"
                                  styleClass="sort-icon">▼</h:commandLink>
                </h:panelGroup>
            </h:panelGroup>
        </f:facet>
        <h:outputText value="#{appt.recipient.userName}" />
    </h:column>

    <!-- Booked At -->
    <h:column>
        <f:facet name="header">
            <h:panelGroup layout="block" style="display: flex; align-items: center;">
                <h:outputText value="Booked At" />
                <h:panelGroup styleClass="sort-icons">
                    <h:commandLink action="#{procedureController.sortByAsc('bookedAt')}"
                                  rendered="#{!(procedureController.sortField eq 'bookedAt' and procedureController.sortAscending)}"
                                  styleClass="sort-icon">▲</h:commandLink>
                    <h:commandLink action="#{procedureController.sortByDesc('bookedAt')}"
                                  rendered="#{!(procedureController.sortField eq 'bookedAt' and not procedureController.sortAscending)}"
                                  styleClass="sort-icon">▼</h:commandLink>
                </h:panelGroup>
            </h:panelGroup>
        </f:facet>
        <h:outputText value="#{appt.bookedAt}">
            <f:convertDateTime pattern="yyyy-MM-dd HH:mm" />
        </h:outputText>
    </h:column>

    

    <!-- Action -->
    <h:column>
        <f:facet name="header">
            <h:outputText value="Action" />
        </f:facet>
        <h:commandButton value="Add Procedure"
                         action="#{procedureController.selectedAppointment(appt)}"
                         styleClass="btn btn-primary" />
    </h:column>
</h:dataTable>
      <h:panelGrid columns="5" cellpadding="10" styleClass="pagination-group">
        <h:commandButton value="First"
                         action="#{procedureController.goToFirstPage()}"
                         disabled="#{!procedureController.hasPreviousPage()}"
                         styleClass="btn btn-tertiary" />

        <h:commandButton value="Previous"
                         action="#{procedureController.previousPage()}"
                         disabled="#{!procedureController.hasPreviousPage()}"
                         styleClass="btn btn-tertiary" />

        <h:outputText value="Page #{procedureController.currentPage} of #{procedureController.totalPages}"
                      style="font-weight: bold; align-self: center;" />

        <h:commandButton value="Next"
                         action="#{procedureController.nextPage()}"
                         disabled="#{!procedureController.hasNextPage()}"
                         styleClass="btn btn-tertiary" />

        <h:commandButton value="Last"
                         action="#{procedureController.goToLastPage()}"
                         disabled="#{!procedureController.hasNextPage()}"
                         styleClass="btn btn-tertiary" />
      </h:panelGrid>
    </h:panelGroup>
  </h:form>
</body>
</html>
</f:view>