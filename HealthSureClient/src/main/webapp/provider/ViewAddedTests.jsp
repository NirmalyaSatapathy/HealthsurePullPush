<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<f:view>
    <!DOCTYPE html>
    <html>
<head>
<meta charset="UTF-8">
<title>Review Tests</title>
<style>
@charset "UTF-8";
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background-color: #eef5f9;
    margin: 0;
    padding: 0;
}
.dashboard-container {
    max-width: 1200px;
    margin: 130px auto;
    padding: 2rem;
    background-color: #fff;
    border-radius: 0.75rem;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
}
.dashboard-title {
    font-size: 22px;
    font-weight: bold;
    color: #2a3f54;
    margin-bottom: 1.5rem;
    text-align: center;
}
.summary-section {
    margin-bottom: 1.5rem;
    padding: 1rem 1.5rem;
    background-color: #f8f9fa;
    border-left: 4px solid #17a2b8;
    border-radius: 0.5rem;
    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
}
.summary-grid {
    display: flex;
    flex-wrap: wrap;
    gap: 1rem;
}
.summary-item {
    flex: 1 1 45%;
    font-size: 15px;
    color: #34495e;
}
.summary-item strong {
    color: #2a3f54;
}
.med-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}
.med-table th, .med-table td {
    padding: 12px;
    text-align: left;
    border: 1px solid #ddd;
    font-size: 15px;
}
.med-table th {
    background-color: #3f51b5;
    color: white;
}
.med-table td {
    background-color: #fff;
    color: #333;
}
.med-table tr:nth-child(even) td {
    background-color: #f2f2f2;
}
.med-table tr:hover td {
    background-color: #e9e9e9;
}
/* Added styles for pagination and sorting */
.sort-icons {
    display: flex;
    flex-direction: column;
    margin-left: 6px;
}
.sort-icon {
    color: white;
    font-size: 0.7em;
    line-height: 1;
}
.sort-icon:hover {
    color: #c5cae9;
}
.pagination-controls {
    margin-top: 15px;
    text-align: center;
}
.action-button {
    padding: 5px 10px;
    font-size: 13px;
    font-weight: 600;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.2s;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    margin: 2px;
}
.action-button.primary {
    background-color: #3f51b5;
    color: white;
}
.action-button.primary:hover {
    background-color: #303f9f;
}
.action-button.secondary {
    background-color: #6c757d;
    color: white;
}
.action-button.secondary:hover {
    background-color: #5a6268;
}
input.action-button.secondary:disabled,
input.action-button.secondary[disabled] {
    opacity: 0.5;
    cursor: not-allowed;
    background-color: #f0f0f0;
    border-color: #b0bec5;
    color: #90a4ae;
}
.message-container {
    margin-bottom: 1rem;
}
.message-container li {
    background-color: #ffe6e6;
    color: #c62828;
    padding: 0.5rem 1rem;
    margin-bottom: 0.5rem;
    border-radius: 0.5rem;
    font-weight: 600;
    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
    list-style-type: none;
}
.button-row {
    display: flex;
    justify-content: flex-end;
    gap: 0.5rem;
    margin-bottom: 1rem;
}
@media (max-width: 768px) {
    .dashboard-container {
        padding: 1rem;
        margin-top: 100px;
    }
    .summary-item {
        flex: 1 1 100%;
    }
    .med-table th, .med-table td {
        padding: 8px;
        font-size: 13px;
    }
    .action-button {
        padding: 4px 8px;
        font-size: 12px;
    }
    .button-row {
        justify-content: center;
        flex-wrap: wrap;
    }
}
</style>
</head>
<body>
    <jsp:include page="/navbar/NavProvider.jsp" />
    <div class="dashboard-container">
        <div class="dashboard-title">Test Details</div>
        <div class="summary-section">
            <div class="summary-grid">
                <div class="summary-item">
                    <strong>Prescription ID:</strong>
                    <h:outputText value="#{procedureController.prescription.prescriptionId}" />
                </div>
                <div class="summary-item">
                    <strong>Recipient Name:</strong>
                    <h:outputText value="#{procedureController.procedure.recipient.firstName}" />
                </div>
                <div class="summary-item">
                    <strong>Diagnosis:</strong>
                    <h:outputText value="#{procedureController.procedure.diagnosis}" />
                </div>
                <div class="summary-item">
                    <strong>Prescribed Doctor:</strong>
                    <h:outputText value="#{procedureController.prescription.prescribedDoc.doctorName}" />
                </div>
                <div class="summary-item">
                    <strong>Start Date:</strong>
                    <h:outputText value="#{procedureController.prescription.startDate}">
                        <f:convertDateTime pattern="yyyy-MM-dd" />
                    </h:outputText>
                </div>
                <div class="summary-item">
                    <strong>End Date:</strong>
                    <h:outputText value="#{procedureController.prescription.endDate}">
                        <f:convertDateTime pattern="yyyy-MM-dd" />
                    </h:outputText>
                </div>
            </div>
        </div>
        
        <h:form prependId="false">
            <div class="message-container">
                <h:messages globalOnly="true" layout="list" />
            </div>
            
            <!-- Top Right Buttons -->
            <div class="button-row">
                <h:commandButton value="Back" styleClass="action-button secondary"
                    action="PrescriptionDashboard?faces-redirect=true" />
            </div>
            
            <h:outputText value="Total tests: #{procedureController.currentPrescribedTests.size()}"
                          style="font-weight: bold; display: block; margin-bottom: 10px;" />
            
            <h:dataTable value="#{procedureController.getPaginatedCurrentTests()}" var="t"
                styleClass="med-table" border="1">
                
                <h:column>
                    <f:facet name="header">
                        <h:panelGroup layout="block" style="display: flex; align-items: center;">
   <h:outputText value="Test Id" />
                            <h:panelGroup styleClass="sort-icons">
                                <h:commandLink
                                    action="#{procedureController.sortByAsc('currentTests','testId')}"
                                    rendered="#{!(procedureController.sortField eq 'testId' and procedureController.isAscending())}"
                                    styleClass="sort-icon">▲</h:commandLink>
                                <h:commandLink
                                    action="#{procedureController.sortByDesc('currentTests','testId')}"
                                    rendered="#{!(procedureController.sortField eq 'testId' and not procedureController.isAscending())}"
                                    styleClass="sort-icon">▼</h:commandLink>
                            </h:panelGroup>
                        </h:panelGroup>
                    </f:facet>
                    <h:outputText value="#{t.testId}" />
                </h:column>
                
                <h:column>
                    <f:facet name="header">
                        <h:panelGroup layout="block" style="display: flex; align-items: center;">
                            <h:outputText value="Test Name" />
                            <h:panelGroup styleClass="sort-icons">
                                <h:commandLink
                                    action="#{procedureController.sortByAsc('currentTests','testName')}"
                                    rendered="#{!(procedureController.sortField eq 'testName' and procedureController.isAscending())}"
                                    styleClass="sort-icon">▲</h:commandLink>
                                <h:commandLink
                                    action="#{procedureController.sortByDesc('currentTests','testName')}"
                                    rendered="#{!(procedureController.sortField eq 'testName' and not procedureController.isAscending())}"
                                    styleClass="sort-icon">▼</h:commandLink>
                            </h:panelGroup>
                        </h:panelGroup>
                    </f:facet>
                    <h:outputText value="#{t.testName}" />
                </h:column>
                
                <h:column>
                    <f:facet name="header">
                        <h:panelGroup layout="block" style="display: flex; align-items: center;">
                            <h:outputText value="Test Date" />
                            <h:panelGroup styleClass="sort-icons">
                                <h:commandLink
                                    action="#{procedureController.sortByAsc('currentTests','testDate')}"
                                    rendered="#{!(procedureController.sortField eq 'testDate' and procedureController.isAscending())}"
                                    styleClass="sort-icon">▲</h:commandLink>
                                <h:commandLink
                                    action="#{procedureController.sortByDesc('currentTests','testDate')}"
                                    rendered="#{!(procedureController.sortField eq 'testDate' and not procedureController.isAscending())}"
                                    styleClass="sort-icon">▼</h:commandLink>
                            </h:panelGroup>
                        </h:panelGroup>
                    </f:facet>
                    <h:outputText value="#{t.testDate}">
                    <f:convertDateTime pattern="yyyy-MM-dd" />
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header">
                        <h:panelGroup layout="block" style="display: flex; align-items: center;">
                            <h:outputText value="Result" />
                            <h:panelGroup styleClass="sort-icons">
                                <h:commandLink
                                    action="#{procedureController.sortByAsc('currentTests','resultSummary')}"
                                    rendered="#{!(procedureController.sortField eq 'resultSummary' and procedureController.isAscending())}"
                                    styleClass="sort-icon">▲</h:commandLink>
                                <h:commandLink
                                    action="#{procedureController.sortByDesc('currentTests','resultSummary')}"
                                    rendered="#{!(procedureController.sortField eq 'resultSummary' and not procedureController.isAscending())}"
                                    styleClass="sort-icon">▼</h:commandLink>
                            </h:panelGroup>
                        </h:panelGroup>
                    </f:facet>
                    <h:outputText value="#{t.resultSummary}" />
                </h:column>
                
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="Action" />
                    </f:facet>
                    <h:commandButton value="Edit" styleClass="action-button primary"
                        action="#{procedureController.editCurrentTest(t)}" />
                </h:column>
            </h:dataTable>
            
            <!-- Pagination Controls -->
            <div class="pagination-controls">
                <h:commandButton value="First"
                                 action="#{procedureController.setCurrentTestFirst(0)}"
                                 disabled="#{procedureController.currentTestFirst == 0}"
                                 styleClass="action-button secondary" />
                
                <h:commandButton value="Previous"
                                 action="#{procedureController.previousCurrentTestPage()}"
                                 disabled="#{procedureController.currentTestFirst == 0}"
                                 styleClass="action-button secondary" />
                
                <h:outputText value="Page #{procedureController.currentTestCurrentPage} of #{procedureController.currentTestTotalPages}"
                              style="margin: 0 12px; font-weight:bold;" />
                
                <h:commandButton value="Next"
                                 action="#{procedureController.nextCurrentTestPage()}"
                                 disabled="#{!procedureController.isTestHasNextPage()}"
                                 styleClass="action-button secondary" />
                
                <h:commandButton value="Last"
                                 action="#{procedureController.setCurrentTestFirst((procedureController.currentMedicineTotalPages - 1) * procedureController.currentTestSize)}"
                                 disabled="#{!procedureController.isTestHasNextPage()}"
                                 styleClass="action-button secondary" />
            </div>
        </h:form>
    </div>
</body>
    </html>
</f:view>
 