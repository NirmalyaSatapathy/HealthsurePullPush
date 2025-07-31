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
/* Reusing your existing table styles */
body {
    font-family: 'Arial', sans-serif;
    background-color: #f9f9f9;
    color: #333;
    padding: 20px;
}

h2 {
    color: #3f51b5;
    font-size: 30px;
    margin: 20px 0;
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

.data-table tr:nth-child(even) {
    background-color: #f2f2f2;
}

.data-table tr:hover {
    background-color: #ddd;
}

.message-container li {
    background-color: #ffe6e6;
    color: #c62828;
    padding: 0.5rem 1rem;
    margin-bottom: 0.5rem;
    border-radius: 0.5rem;
    font-weight: 500;
    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
}

/* Pagination controls */
.pagination-controls {
    margin-top: 15px;
    text-align: center;
}

.btn {
    border: none;
    border-radius: 4px;
    padding: 6px 12px;
    font-size: 14px;
    cursor: pointer;
    transition: background-color 0.3s ease;
    margin: 0 4px;
}

.btn-primary {
    background-color: #3f51b5;
    color: #ffffff;
}

.btn-primary:hover {
    background-color: #303f9f;
}

.btn-tertiary {
    background-color: #ffffff;
    color: #3f51b5;
    border: 2px solid #3f51b5;
}

.btn-tertiary:hover {
    background-color: #e8eaf6;
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
    color: #c5cae9;
}

.sort-header-group {
    display: flex;
    align-items: center;
}

@media (max-width: 600px) {
    h2 {
        font-size: 24px;
    }
    .data-table th,
    .data-table td {
        font-size: 13px;
        padding: 6px;
    }
    .btn {
        width: 100%;
        margin: 6px 0;
    }
}
</style>
</head>
<body>
    <center>
        <h2>
            <h:outputText value="Prescriptions" />
        </h2>
    </center>
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
                        <h:outputText value="Procedure" />
                        <h:panelGroup styleClass="sort-icons">
                            <h:commandLink
                                action="#{procedureController.sortByAsc('prescriptions','diagnosis')}"
                                rendered="#{!(procedureController.sortField eq 'diagnosis' and procedureController.isAscending())}"
                                styleClass="sort-icon">▲</h:commandLink>
                            <h:commandLink
                                action="#{procedureController.sortByDesc('prescriptions','diagnosis')}"
                                rendered="#{!(procedureController.sortField eq 'diagnosis' and not procedureController.isAscending())}"
                                styleClass="sort-icon">▼</h:commandLink>
                        </h:panelGroup>
                    </h:panelGroup>
                </f:facet>
                <h:outputText value="#{procedureController.procedure.diagnosis}" />
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:panelGroup layout="block" style="display: flex; align-items: center;">
                        <h:outputText value="Procedure Doctor" />
                        <h:panelGroup styleClass="sort-icons">
                            <h:commandLink
                                action="#{procedureController.sortByAsc('prescriptions','doctorId')}"
                                rendered="#{!(procedureController.sortField eq 'doctorId' and procedureController.isAscending())}"
                                styleClass="sort-icon">▲</h:commandLink>
                            <h:commandLink
                                action="#{procedureController.sortByDesc('prescriptions','doctorId')}"
                                rendered="#{!(procedureController.sortField eq 'doctorId' and not procedureController.isAscending())}"
                                styleClass="sort-icon">▼</h:commandLink>
                        </h:panelGroup>
                    </h:panelGroup>
                </f:facet>
                <h:outputText value="#{p.doctor.doctorId}" />
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
                <h:outputText value="#{p.prescribedDoc.doctorId}" />
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
                    <h:outputText value="Action" />
                </f:facet>
                <h:commandButton value="edit" styleClass="btn btn-primary"
                    action="#{procedureController.editPrescription(p)}" />
            </h:column>
            
            <h:column>
                <f:facet name="header">
                    <h:outputText value="Action" />
                </f:facet>
                <h:commandButton value="viewMedicines" styleClass="btn btn-primary"
                    action="#{procedureController.loadViewMedicines(p)}" />
            </h:column>
            
            <h:column>
                <f:facet name="header">
                    <h:outputText value="Action" />
                </f:facet>
                <h:commandButton value="viewTests" styleClass="btn btn-primary"
                    action="#{procedureController.loadViewTests(p)}" />
            </h:column>
        </h:dataTable>

     <!-- Pagination Controls -->
<div class="pagination-controls">
    <h:commandButton value="First"
                     action="#{procedureController.setPrescriptionFirst(0)}"
                     disabled="#{procedureController.prescriptionFirst == 0}"
                     styleClass="btn btn-tertiary" />

    <h:commandButton value="Previous"
                     action="#{procedureController.previousPrescriptionPage()}"
                     disabled="#{procedureController.prescriptionFirst == 0}"
                     styleClass="btn btn-tertiary" />

    <h:outputText value="Page #{procedureController.prescriptionCurrentPage} of #{procedureController.prescriptionTotalPages}"
                  style="margin: 0 12px; font-weight:bold;" />

    <h:commandButton value="Next"
                     action="#{procedureController.nextPrescriptionPage()}"
                     disabled="#{!procedureController.isPrescriptionHasNextPage()}"
                     styleClass="btn btn-tertiary" />

    <h:commandButton value="Last"
                     action="#{procedureController.setPrescriptionFirst((procedureController.prescriptionTotalPages - 1) * procedureController.prescriptionPageSize)}"
                     disabled="#{!procedureController.isPrescriptionHasNextPage()}"
                     styleClass="btn btn-tertiary" />
</div>
        <h:commandButton value="back" styleClass="btn btn-primary"
            action="#{procedureController.backFromViewPrescription()}" />
    </h:form>
</body>
    </html>
</f:view>