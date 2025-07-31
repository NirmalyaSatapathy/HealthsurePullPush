<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<f:view>
    <html>
<head>
<meta charset="UTF-8">
<title>Procedure Logs</title>
<style>
body {
    font-family: 'Arial', sans-serif;
    background-color: #f4f4f4;
    color: #333;
    padding: 20px;
}

h2 {
    color: #0077cc;
    font-size: 28px;
    margin: 20px 0;
    text-align: center;
}

.data-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}

.data-table th, .data-table td {
    border: 1px solid #ccc;
    padding: 10px;
    text-align: left;
}

.data-table th {
    background-color: #0077cc;
    color: white;
}

.data-table tr:nth-child(even) {
    background-color: #f9f9f9;
}

.data-table tr:hover {
    background-color: #e0e0e0;
}

/* Pagination controls */
.pagination-controls {
    margin-top: 20px;
    text-align: center;
}

.btn {
    border: none;
    border-radius: 4px;
    padding: 8px 16px;
    font-size: 14px;
    cursor: pointer;
    transition: background-color 0.3s ease;
    margin: 0 5px;
}

.btn-primary {
    background-color: #0077cc;
    color: white;
}

.btn-primary:hover {
    background-color: #0066b3;
}

.btn-secondary {
    background-color: #f9f9f9;
    color: #333;
    border: 1px solid #ccc;
}

.btn-secondary:hover {
    background-color: #e0e0e0;
}

/* Sort icons */
.sort-icons {
    display: flex;
    flex-direction: column;
    margin-left: 6px;
}

.sort-icon {
    color: white;
    font-size: 0.7em;
    padding: 0;
    margin: 0;
    line-height: 1;
    display: inline-block;
}

.sort-icon:hover {
    color: #b3d9ff;
}

.sort-header-group {
    display: flex;
    align-items: center;
}

.back-button {
    margin-top: 20px;
    text-align: center;
}

@media (max-width: 600px) {
    .btn {
        width: 100%;
        margin: 5px 0;
    }
}
</style>
</head>
<body>
    <h2>
        <h:outputText value="Procedure Daily Logs" />
    </h2>

    <h:form prependId="false">
        <h:outputText value="Total logs: #{procedureController.viewLogs.size()}"
                      style="font-weight: bold; display: block; margin-bottom: 10px;" />
        
        <h:dataTable value="#{procedureController.getPaginatedLogs()}" var="log"
            styleClass="data-table" border="1">
            
            <h:column>
                <f:facet name="header">
                    <h:panelGroup layout="block" style="display: flex; align-items: center;">
                        <h:outputText value="Log ID" />
                        <h:panelGroup styleClass="sort-icons">
                            <h:commandLink
                                action="#{procedureController.sortByAsc('logs','logId')}"
                                rendered="#{!(procedureController.sortField eq 'logId' and procedureController.isAscending())}"
                                styleClass="sort-icon">▲</h:commandLink>
                            <h:commandLink
                                action="#{procedureController.sortByDesc('logs','logId')}"
                                rendered="#{!(procedureController.sortField eq 'logId' and not procedureController.isAscending())}"
                                styleClass="sort-icon">▼</h:commandLink>
                        </h:panelGroup>
                    </h:panelGroup>
                </f:facet>
                <h:outputText value="#{log.logId}" />
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:panelGroup layout="block" style="display: flex; align-items: center;">
                        <h:outputText value="Procedure ID" />
                        <h:panelGroup styleClass="sort-icons">
                            <h:commandLink
                                action="#{procedureController.sortByAsc('logs','procedureId')}"
                                rendered="#{!(procedureController.sortField eq 'procedureId' and procedureController.isAscending())}"
                                styleClass="sort-icon">▲</h:commandLink>
                            <h:commandLink
                                action="#{procedureController.sortByDesc('logs','procedureId')}"
                                rendered="#{!(procedureController.sortField eq 'procedureId' and not procedureController.isAscending())}"
                                styleClass="sort-icon">▼</h:commandLink>
                        </h:panelGroup>
                    </h:panelGroup>
                </f:facet>
                <h:outputText value="#{log.medicalProcedure.procedureId}" />
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:panelGroup layout="block" style="display: flex; align-items: center;">
                        <h:outputText value="Logged Doctor" />
                        <h:panelGroup styleClass="sort-icons">
                            <h:commandLink
                                action="#{procedureController.sortByAsc('logs','doctorId')}"
                                rendered="#{!(procedureController.sortField eq 'doctorId' and procedureController.isAscending())}"
                                styleClass="sort-icon">▲</h:commandLink>
                            <h:commandLink
                                action="#{procedureController.sortByDesc('logs','doctorId')}"
                                rendered="#{!(procedureController.sortField eq 'doctorId' and not procedureController.isAscending())}"
                                styleClass="sort-icon">▼</h:commandLink>
                        </h:panelGroup>
                    </h:panelGroup>
                </f:facet>
                <h:outputText value="#{log.loggedDoctor.doctorId}" />
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:panelGroup layout="block" style="display: flex; align-items: center;">
                        <h:outputText value="Log Date" />
                        <h:panelGroup styleClass="sort-icons">
                            <h:commandLink
                                action="#{procedureController.sortByAsc('logs','logDate')}"
                                rendered="#{!(procedureController.sortField eq 'logDate' and procedureController.isAscending())}"
                                styleClass="sort-icon">▲</h:commandLink>
                            <h:commandLink
                                action="#{procedureController.sortByDesc('logs','logDate')}"
                                rendered="#{!(procedureController.sortField eq 'logDate' and not procedureController.isAscending())}"
                                styleClass="sort-icon">▼</h:commandLink>
                        </h:panelGroup>
                    </h:panelGroup>
                </f:facet>
                <h:outputText value="#{log.logDate}">
                    <f:convertDateTime pattern="yyyy-MM-dd HH:mm" />
                </h:outputText>
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:panelGroup layout="block" style="display: flex; align-items: center;">
                        <h:outputText value="Vitals" />
                        <h:panelGroup styleClass="sort-icons">
                            <h:commandLink
                                action="#{procedureController.sortByAsc('logs','vitals')}"
                                rendered="#{!(procedureController.sortField eq 'vitals' and procedureController.isAscending())}"
                                styleClass="sort-icon">▲</h:commandLink>
                            <h:commandLink
                                action="#{procedureController.sortByDesc('logs','vitals')}"
                                rendered="#{!(procedureController.sortField eq 'vitals' and not procedureController.isAscending())}"
                                styleClass="sort-icon">▼</h:commandLink>
                        </h:panelGroup>
                    </h:panelGroup>
                </f:facet>
                <h:outputText value="#{log.vitals}" />
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:panelGroup layout="block" style="display: flex; align-items: center;">
                        <h:outputText value="Notes" />
                        <h:panelGroup styleClass="sort-icons">
                            <h:commandLink
                                action="#{procedureController.sortByAsc('logs','notes')}"
                                rendered="#{!(procedureController.sortField eq 'notes' and procedureController.isAscending())}"
                                styleClass="sort-icon">▲</h:commandLink>
                            <h:commandLink
                                action="#{procedureController.sortByDesc('logs','notes')}"
                                rendered="#{!(procedureController.sortField eq 'notes' and not procedureController.isAscending())}"
                                styleClass="sort-icon">▼</h:commandLink>
                        </h:panelGroup>
                    </h:panelGroup>
                </f:facet>
                <h:outputText value="#{log.notes}" />
            </h:column>
            
            <h:column>
                <f:facet name="header">
                    <h:outputText value="Action" />
                </f:facet>
                <h:commandButton value="Edit" styleClass="btn btn-secondary"
                    action="#{procedureController.editLog(log)}" />
            </h:column>
        </h:dataTable>
        
        <!-- Pagination Controls -->
        <div class="pagination-controls">
            <h:commandButton value="First"
                             action="#{procedureController.setLogFirst(0)}"
                             disabled="#{procedureController.logFirst == 0}"
                             styleClass="btn btn-secondary" />
            
            <h:commandButton value="Previous"
                             action="#{procedureController.previousLogPage()}"
                             disabled="#{procedureController.logFirst == 0}"
                             styleClass="btn btn-secondary" />
            
            <h:outputText value="Page #{procedureController.logCurrentPage} of #{procedureController.logTotalPages}"
                          style="margin: 0 12px; font-weight:bold;" />
            
            <h:commandButton value="Next"
                             action="#{procedureController.nextLogPage()}"
                             disabled="#{!procedureController.isLogHasNextPage()}"
                             styleClass="btn btn-secondary" />
            
            <h:commandButton value="Last"
                             action="#{procedureController.setLogFirst((procedureController.logTotalPages - 1) * procedureController.logPageSize)}"
                             disabled="#{!procedureController.isLogHasNextPage()}"
                             styleClass="btn btn-secondary" />
        </div>
        
        <div class="back-button">
            <h:commandButton value="Back" styleClass="btn btn-primary"
                action="LongTermProcedureDashboard?faces-redirect=true" />
        </div>
    </h:form>
</body>
    </html>
</f:view>