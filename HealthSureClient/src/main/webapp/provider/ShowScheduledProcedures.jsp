<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core" %>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html" %>

<f:view>
<html>
<head>
    <meta charset="UTF-8">
    <title>Scheduled Procedures</title>
    <style>
        /* Base page styling */
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background-color: #f4f8fc;
            color: #2e3e50;
            margin: 0;
            padding: 20px;
        }

        h2 {
            color: #1E88E5;
            font-size: 28px;
            margin-bottom: 20px;
            border-bottom: 2px solid #BBDEFB;
            padding-bottom: 6px;
        }
.sort-icon {
	font-size: 0.7em;
	padding: 0;
	margin: 0;
	line-height: 1;
	display: inline-block;
}

.sort-icons {
	display: inline-flex;
	flex-direction: column;
	align-items: center;
	margin-left: 4px;
}
        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: inline-block;
            width: 140px;
            font-weight: bold;
            color: #2E7D32;
        }

        .form-control {
            padding: 8px;
            width: 250px;
            font-size: 14px;
            border: 1px solid #90CAF9;
            border-radius: 4px;
            background-color: #ffffff;
            transition: border-color 0.3s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: #1E88E5;
            box-shadow: 0 0 4px rgba(30, 136, 229, 0.3);
        }

        .error {
            display: block;
            color: #f44336;
            font-size: 14px;
            font-weight: 600;
            margin-top: 6px;
        }

        /* Button base */
        .btn {
            border: none;
            border-radius: 4px;
            padding: 8px 14px;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-right: 10px;
        }
        .btn-primary {
            background-color: #1E88E5;
            color: #ffffff;
        }
        .btn-primary:hover {
            background-color: #1565C0;
        }
        .btn-secondary {
            background-color: #43A047;
            color: #ffffff;
        }
        .btn-secondary:hover {
            background-color: #2E7D32;
        }
        .btn-tertiary {
            background-color: #ffffff;
            color: #1E88E5;
            border: 2px solid #1E88E5;
        }
        .btn-tertiary:hover {
            background-color: #e3f2fd;
        }

        /* Data table */
        .data-table {
            width: 100%;
            margin-top: 30px;
            border-collapse: collapse;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }
        .data-table th {
            background-color: #1E88E5;
            color: #ffffff;
            font-weight: 600;
            padding: 10px;
            text-align: center;
            border: 1px solid #90CAF9;
        }
        .data-table td {
            background-color: #ffffff;
            color: #2e3e50;
            padding: 10px;
            text-align: center;
            border: 1px solid #cfd8dc;
        }
        .data-table tr:nth-child(even) {
            background-color: #e8f5e9;
        }
        .data-table tr:hover {
            background-color: #BBDEFB;
        }

        .pagination-group {
            margin-top: 20px;
        }

        @media (max-width: 600px) {
            h2 { font-size: 24px; }
            .form-control { width: 100%; }
            .data-table th,
            .data-table td {
                font-size: 13px;
                padding: 6px;
            }
        }
    </style>
</head>

<body>
    <h:form prependId="false">
        <h2>Search Scheduled Procedures</h2>

        <div class="form-group">
            <label for="doctorId"><span style="color: red;">*</span>Doctor ID:</label>
            <h:inputText id="doctorId"
                         value="#{procedureController.doctorId}"
                         styleClass="form-control" />
            <h:message for="doctorId" styleClass="error" />
        </div>

        <div class="form-group">
            <label for="procedureId">Procedure ID (optional):</label>
            <h:inputText id="procedureId"
                         value="#{procedureController.procedureId}"
                         styleClass="form-control" />
            <h:message for="procedureId" styleClass="error" />
        </div>

        <div class="form-group">
            <h:commandButton value="Search"
                             action="#{procedureController.fetchScheduledProceduresController()}"
                             styleClass="btn btn-primary" />
            <h:commandButton value="Reset"
                             action="#{procedureController.resetPage()}"
                             immediate="true"
                             styleClass="btn btn-secondary" />
            <h:commandButton value="Go to Dashboard"
                             action="#{procedureController.goToDashboard1()}"
                             styleClass="btn btn-tertiary" />
        </div>

        <h:panelGroup rendered="#{not empty procedureController.scheduledProcedures}">
            <h:outputText value="Total: #{procedureController.allScheduledProcedures.size()} procedures"
                          style="font-weight: bold; display: block; margin-top: 20px;" />

           <h:dataTable value="#{procedureController.scheduledProcedures}"
             var="p"
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
        <h:outputText value="#{p.appointment.appointmentId}" />
    </h:column>

    <!-- Procedure ID -->
    <h:column>
        <f:facet name="header">
            <h:panelGroup layout="block" style="display: flex; align-items: center;">
                <h:outputText value="Procedure ID" />
                <h:panelGroup styleClass="sort-icons">
                    <h:commandLink action="#{procedureController.sortByAsc('procedureId')}"
                                  rendered="#{!(procedureController.sortField eq 'procedureId' and procedureController.sortAscending)}"
                                  styleClass="sort-icon">▲</h:commandLink>
                    <h:commandLink action="#{procedureController.sortByDesc('procedureId')}"
                                  rendered="#{!(procedureController.sortField eq 'procedureId' and not procedureController.sortAscending)}"
                                  styleClass="sort-icon">▼</h:commandLink>
                </h:panelGroup>
            </h:panelGroup>
        </f:facet>
        <h:outputText value="#{p.procedureId}" />
    </h:column>

    <!-- Recipient First Name -->
    <h:column>
        <f:facet name="header">
            <h:panelGroup layout="block" style="display: flex; align-items: center;">
                <h:outputText value="Recipient First Name" />
                <h:panelGroup styleClass="sort-icons">
                    <h:commandLink action="#{procedureController.sortByAsc('recipientFirstName')}"
                                  rendered="#{!(procedureController.sortField eq 'recipientFirstName' and procedureController.sortAscending)}"
                                  styleClass="sort-icon">▲</h:commandLink>
                    <h:commandLink action="#{procedureController.sortByDesc('recipientFirstName')}"
                                  rendered="#{!(procedureController.sortField eq 'recipientFirstName' and not procedureController.sortAscending)}"
                                  styleClass="sort-icon">▼</h:commandLink>
                </h:panelGroup>
            </h:panelGroup>
        </f:facet>
        <h:outputText value="#{p.recipient.firstName}" />
    </h:column>

    <!-- Recipient Last Name -->
    <h:column>
        <f:facet name="header">
            <h:panelGroup layout="block" style="display: flex; align-items: center;">
                <h:outputText value="Recipient Last Name" />
                <h:panelGroup styleClass="sort-icons">
                    <h:commandLink action="#{procedureController.sortByAsc('recipientLastName')}"
                                  rendered="#{!(procedureController.sortField eq 'recipientLastName' and procedureController.sortAscending)}"
                                  styleClass="sort-icon">▲</h:commandLink>
                    <h:commandLink action="#{procedureController.sortByDesc('recipientLastName')}"
                                  rendered="#{!(procedureController.sortField eq 'recipientLastName' and not procedureController.sortAscending)}"
                                  styleClass="sort-icon">▼</h:commandLink>
                </h:panelGroup>
            </h:panelGroup>
        </f:facet>
        <h:outputText value="#{p.recipient.lastName}" />
    </h:column>

    <!-- Doctor Name -->
    <h:column>
        <f:facet name="header">
            <h:panelGroup layout="block" style="display: flex; align-items: center;">
                <h:outputText value="Doctor" />
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
        <h:outputText value="#{p.doctor.doctorName}" />
    </h:column>

    <!-- Provider Name -->
    <h:column>
        <f:facet name="header">
            <h:panelGroup layout="block" style="display: flex; align-items: center;">
                <h:outputText value="Provider" />
                <h:panelGroup styleClass="sort-icons">
                    <h:commandLink action="#{procedureController.sortByAsc('providerName')}"
                                  rendered="#{!(procedureController.sortField eq 'providerName' and procedureController.sortAscending)}"
                                  styleClass="sort-icon">▲</h:commandLink>
                    <h:commandLink action="#{procedureController.sortByDesc('providerName')}"
                                  rendered="#{!(procedureController.sortField eq 'providerName' and not procedureController.sortAscending)}"
                                  styleClass="sort-icon">▼</h:commandLink>
                </h:panelGroup>
            </h:panelGroup>
        </f:facet>
        <h:outputText value="#{p.provider.name}" />
    </h:column>

    <!-- Scheduled Date -->
    <h:column>
        <f:facet name="header">
            <h:panelGroup layout="block" style="display: flex; align-items: center;">
                <h:outputText value="Scheduled Date" />
                <h:panelGroup styleClass="sort-icons">
                    <h:commandLink action="#{procedureController.sortByAsc('scheduledDate')}"
                                  rendered="#{!(procedureController.sortField eq 'scheduledDate' and procedureController.sortAscending)}"
                                  styleClass="sort-icon">▲</h:commandLink>
                    <h:commandLink action="#{procedureController.sortByDesc('scheduledDate')}"
                                  rendered="#{!(procedureController.sortField eq 'scheduledDate' and not procedureController.sortAscending)}"
                                  styleClass="sort-icon">▼</h:commandLink>
                </h:panelGroup>
            </h:panelGroup>
        </f:facet>
        <h:outputText value="#{p.scheduledDate}">
            <f:convertDateTime pattern="yyyy-MM-dd" />
        </h:outputText>
    </h:column>

    <!-- Action Column -->
    <h:column>
        <f:facet name="header">
            <h:outputText value="Action" />
        </f:facet>
        <h:commandButton value="Start Procedure"
                         action="#{procedureController.startProcedure(p)}"
                         styleClass="btn btn-primary" />
    </h:column>
</h:dataTable>
            <div class="pagination-group">
                <h:panelGrid columns="5" cellpadding="10">
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
            </div>

        </h:panelGroup>
    </h:form>
</body>
</html>
</f:view>