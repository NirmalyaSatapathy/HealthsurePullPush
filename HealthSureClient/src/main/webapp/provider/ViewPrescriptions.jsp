<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<f:view>
    <html>
<head>
<meta charset="UTF-8">
<title>Prescription List</title>
<style>
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background-color: #eef5f9;
    margin: 0;
    padding: 0;
}

.dashboard-container {
    max-width: 1200px;
    margin: 80px auto;
    padding: 2rem;
    background-color: #fff;
    border-radius: 0.75rem;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
    margin-top: 130px;
}

.dashboard-title {
    font-size: 2rem;
    font-weight: 700;
    color: #2a3f54;
    margin-bottom: 1.5rem;
    text-align: center;
}

.summary-section {
    text-align: left;
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
    font-size: 1rem;
    margin-bottom: 0.5rem;
    color: #34495e;
}

.summary-item strong {
    color: #2a3f54;
}

.data-table {
    width: 100%;
    margin-top: 30px;
    border-collapse: collapse;
}

.data-table th, .data-table td {
    padding: 12px;
    text-align: left;
    border: 1px solid #ddd;
}

.data-table th {
    background-color: #3f51b5;
    color: white;
}

.data-table td {
    background-color: #fff;
    color: #333;
}

.data-table tr:nth-child(even) td {
    background-color: #f2f2f2;
}

.data-table tr:hover td {
    background-color: #e9e9e9;
}

.action-button {
    display: inline-block;
    padding: 0.4rem 0.8rem;
    font-size: 0.95rem;
    font-weight: 600;
    border: none;
    border-radius: 0.375rem;
    cursor: pointer;
    transition: background-color 0.2s, transform 0.1s, box-shadow 0.2s;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    text-decoration: none;
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

.pagination-controls {
    margin-top: 15px;
    text-align: center;
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
    font-weight: 500;
    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
    list-style-type: none;
}

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
    color: #c5cae9;
}

.sort-header-group {
    display: flex;
    align-items: center;
}

@media (max-width: 768px) {
    .dashboard-container {
        padding: 1rem;
        margin-top: 100px;
    }
    
    .summary-item {
        flex: 1 1 100%;
    }
    
    .data-table th, 
    .data-table td {
        padding: 8px;
        font-size: 14px;
    }
    
    .action-button {
        padding: 0.3rem 0.6rem;
        font-size: 0.85rem;
    }
}
</style>
</head>
<body>
    <jsp:include page="/navbar/NavProvider.jsp" />
    <div class="dashboard-container">
        <div class="dashboard-title">Prescription List</div>

        <!-- Procedure Summary Section -->
        <h:panelGroup rendered="#{not empty procedureController.procedure}">
            <div class="summary-section">
                <div class="summary-grid">
                    <div class="summary-item">
                        <strong>Recipient Name:</strong>
                        <h:outputText value="#{procedureController.procedure.recipient.firstName}" />
                    </div>
                    <div class="summary-item">
                        <strong>Diagnosis:</strong>
                        <h:outputText value="#{procedureController.procedure.diagnosis}" />
                    </div>
                    <div class="summary-item">
                        <strong>Procedure Doctor:</strong>
                        <h:outputText value="#{procedureController.procedure.doctor.doctorName}" />
                    </div>
                    <div class="summary-item">
						<strong>Procedure Start Date:</strong>
						<h:outputText value="#{procedureController.procedure.fromDate}">
							<f:convertDateTime pattern="dd MMM yyyy" />
						</h:outputText>
					</div>
                </div>
            </div>
        </h:panelGroup>

        <h:form prependId="false">
            <div class="message-container">
                <h:messages globalOnly="true" layout="list" />
            </div>
            
            <h:outputText value="Total prescriptions: #{procedureController.viewPrescriptions.size()}"
                          style="font-weight: bold; display: block; margin-bottom: 10px;" />
            
            <h:dataTable value="#{procedureController.getPaginatedPrescriptions()}" var="p"
                styleClass="data-table" border="1">
                <h:column>
                    <f:facet name="header">
                        <h:panelGroup layout="block" style="display: flex; align-items: center;">
                            <h:outputText value="Prescription ID" />
                            <h:panelGroup styleClass="sort-icons">
                                <h:commandLink
                                    action="#{procedureController.sortByAsc('prescriptions','prescriptionId')}"
                                    rendered="#{!(procedureController.sortField eq 'prescriptionId' and procedureController.isAscending())}"
                                    styleClass="sort-icon">▲</h:commandLink>
                                <h:commandLink
                                    action="#{procedureController.sortByDesc('prescriptions','prescriptionId')}"
                                    rendered="#{!(procedureController.sortField eq 'prescriptionId' and not procedureController.isAscending())}"
                                    styleClass="sort-icon">▼</h:commandLink>
                            </h:panelGroup>
                        </h:panelGroup>
                    </f:facet>
                    <h:outputText value="#{p.prescriptionId}" />
                </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:panelGroup layout="block" style="display: flex; align-items: center;">
                            <h:outputText value="Prescribed Doctor" />
                            <h:panelGroup styleClass="sort-icons">
                                <h:commandLink
                                    action="#{procedureController.sortByAsc('prescriptions','prescribedDocId')}"
                                    rendered="#{!(procedureController.sortField eq 'prescribedDocId' and procedureController.isAscending())}"
                                    styleClass="sort-icon">▲</h:commandLink>
                                <h:commandLink
                                    action="#{procedureController.sortByDesc('prescriptions','prescribedDocId')}"
                                    rendered="#{!(procedureController.sortField eq 'prescribedDocId' and not procedureController.isAscending())}"
                                    styleClass="sort-icon">▼</h:commandLink>
                            </h:panelGroup>
                        </h:panelGroup>
                    </f:facet>
                    <h:outputText value="#{p.prescribedDoc.doctorName}" />
                </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:panelGroup layout="block" style="display: flex; align-items: center;">
                            <h:outputText value="Start Date" />
                            <h:panelGroup styleClass="sort-icons">
                                <h:commandLink
                                    action="#{procedureController.sortByAsc('prescriptions','startDate')}"
                                    rendered="#{!(procedureController.sortField eq 'startDate' and procedureController.isAscending())}"
                                    styleClass="sort-icon">▲</h:commandLink>
                                <h:commandLink
                                    action="#{procedureController.sortByDesc('prescriptions','startDate')}"
                                    rendered="#{!(procedureController.sortField eq 'startDate' and not procedureController.isAscending())}"
                                    styleClass="sort-icon">▼</h:commandLink>
                            </h:panelGroup>
                        </h:panelGroup>
                    </f:facet>
                    <h:outputText value="#{p.startDate}">
                        <f:convertDateTime pattern="yyyy-MM-dd" />
                    </h:outputText>
                </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:panelGroup layout="block" style="display: flex; align-items: center;">
                            <h:outputText value="End Date" />
                            <h:panelGroup styleClass="sort-icons">
                                <h:commandLink
                                    action="#{procedureController.sortByAsc('prescriptions','endDate')}"
                                    rendered="#{!(procedureController.sortField eq 'endDate' and procedureController.isAscending())}"
                                    styleClass="sort-icon">▲</h:commandLink>
                                <h:commandLink
                                    action="#{procedureController.sortByDesc('prescriptions','endDate')}"
                                    rendered="#{!(procedureController.sortField eq 'endDate' and not procedureController.isAscending())}"
                                    styleClass="sort-icon">▼</h:commandLink>
                            </h:panelGroup>
                        </h:panelGroup>
                    </f:facet>
                    <h:outputText value="#{p.endDate}">
                        <f:convertDateTime pattern="yyyy-MM-dd" />
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="Actions" />
                    </f:facet>
                    <h:commandButton value="Edit" styleClass="action-button primary"
                        action="#{procedureController.editPrescription(p)}" />
                    <h:commandButton value="Medicines" styleClass="action-button secondary"
                        action="#{procedureController.loadViewMedicines(p)}" />
                    <h:commandButton value="Tests" styleClass="action-button secondary"
                        action="#{procedureController.loadViewTests(p)}" />
                </h:column>
            </h:dataTable>

            <!-- Pagination Controls -->
            <div class="pagination-controls">
                <h:commandButton value="First"
                                 action="#{procedureController.setPrescriptionFirst(0)}"
                                 disabled="#{procedureController.prescriptionFirst == 0}"
                                 styleClass="action-button secondary" />

                <h:commandButton value="Previous"
                                 action="#{procedureController.previousPrescriptionPage()}"
                                 disabled="#{procedureController.prescriptionFirst == 0}"
                                 styleClass="action-button secondary" />

                <h:outputText value="Page #{procedureController.prescriptionCurrentPage} of #{procedureController.prescriptionTotalPages}"
                              style="margin: 0 12px; font-weight:bold;" />

                <h:commandButton value="Next"
                                 action="#{procedureController.nextPrescriptionPage()}"
                                 disabled="#{!procedureController.isPrescriptionHasNextPage()}"
                                 styleClass="action-button secondary" />

                <h:commandButton value="Last"
                                 action="#{procedureController.setPrescriptionFirst((procedureController.prescriptionTotalPages - 1) * procedureController.prescriptionPageSize)}"
                                 disabled="#{!procedureController.isPrescriptionHasNextPage()}"
                                 styleClass="action-button secondary" />
            </div>
            
            <div style="margin-top: 20px; text-align: center;">
                <h:commandButton value="Back" styleClass="action-button primary"
                    action="#{procedureController.backFromViewPrescription()}" />
            </div>
        </h:form>
    </div>
</body>
    </html>
</f:view>