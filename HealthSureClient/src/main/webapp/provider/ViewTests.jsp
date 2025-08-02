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
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f6f9fc;
            padding: 30px;
        }
        h2 {
            color: #34495e;
            font-size: 26px;
        }
        .test-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 25px;
        }
        .test-table th, .test-table td {
            padding: 10px;
            border: 1px solid #bbb;
        }
        .test-table th {
            background-color: #16a085;
            color: white;
        }
        .test-table tr:nth-child(even) {
            background-color: #ecf0f1;
        }
        
        /* Pagination controls */
        .pagination-controls {
            margin-top: 15px;
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
            background-color: #16a085;
            color: white;
        }
        
        .btn-primary:hover {
            background-color: #1abc9c;
        }
        
        .btn-secondary {
            background-color: #ecf0f1;
            color: #34495e;
            border: 1px solid #bdc3c7;
        }
        
        .btn-secondary:hover {
            background-color: #dfe6e9;
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
            color: #a3e4d7;
        }
        
        .sort-header-group {
            display: flex;
            align-items: center;
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
    <center>
        <h2><h:outputText value="Test Details" /></h2>
    </center>
    
    <h:form prependId="false">
        <h:commandButton value="Add Test" styleClass="btn btn-primary" 
            action="#{procedureController.createNewExistingPrescProcedureTest()}"/>
               <h:dataTable value="#{empty procedureController.viewTests ? ['dummy'] : procedureController.getPaginatedTests()}"
             var="m"
             rendered="#{empty procedureController.viewTests}"
             styleClass="test-table"
             border="1">

    <!-- Table Header -->
    <h:column>
        <f:facet name="header">
            <h:outputText value="Prescription ID" />
        </f:facet>
        <h:outputText value="N/A" />
    </h:column>

    <h:column>
        <f:facet name="header">
            <h:outputText value="Medicine Name" />
        </f:facet>
        <h:outputText value="N/A" />
    </h:column>

    <h:column>
        <f:facet name="header">
            <h:outputText value="Type" />
        </f:facet>
        <h:outputText value="N/A" />
    </h:column>

    <h:column>
        <f:facet name="header">
            <h:outputText value="Dosage" />
        </f:facet>
        <h:outputText value="N/A" />
    </h:column>

    <h:column>
        <f:facet name="header">
            <h:outputText value="Duration" />
        </f:facet>
        <h:outputText value="N/A" />
    </h:column>

    <h:column>
        <f:facet name="header">
            <h:outputText value="Start Date" />
        </f:facet>
        <h:outputText value="N/A" />
    </h:column>

    <h:column>
        <f:facet name="header">
            <h:outputText value="End Date" />
        </f:facet>
        <h:outputText value="N/A" />
    </h:column>

    <h:column>
        <f:facet name="header">
            <h:outputText value="Action" />
        </f:facet>
        <h:outputText value="N/A" />
    </h:column>
</h:dataTable>
<!-- Message below the table -->
<h:outputText value="No tests added."
              style="font-weight: bold; color: red; display: block; margin-top: 10px; text-align: center; width: 100%;"
              rendered="#{empty procedureController.viewTests}" />
       <h:panelGroup rendered="#{not empty procedureController.viewTests}">
        <h:outputText value="Total tests: #{procedureController.viewTests.size()}"
                      style="font-weight: bold; display: block; margin: 10px 0;" />
        
        <h:dataTable value="#{procedureController.getPaginatedTests()}" var="t" 
            styleClass="test-table" border="1">
            
            <h:column>
                <f:facet name="header">
                    <h:panelGroup layout="block" style="display: flex; align-items: center;">
                        <h:outputText value="Prescription ID" />
                        <h:panelGroup styleClass="sort-icons">
                            <h:commandLink
                                action="#{procedureController.sortByAsc('tests','prescriptionId')}"
                                rendered="#{!(procedureController.sortField eq 'prescriptionId' and procedureController.isAscending())}"
                                styleClass="sort-icon">▲</h:commandLink>
                            <h:commandLink
                                action="#{procedureController.sortByDesc('tests','prescriptionId')}"
                                rendered="#{!(procedureController.sortField eq 'prescriptionId' and not procedureController.isAscending())}"
                                styleClass="sort-icon">▼</h:commandLink>
                        </h:panelGroup>
                    </h:panelGroup>
                </f:facet>
                <h:outputText value="#{t.prescription.prescriptionId}" />
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:panelGroup layout="block" style="display: flex; align-items: center;">
                        <h:outputText value="Test Name" />
                        <h:panelGroup styleClass="sort-icons">
                            <h:commandLink
                                action="#{procedureController.sortByAsc('tests','testName')}"
                                rendered="#{!(procedureController.sortField eq 'testName' and procedureController.isAscending())}"
                                styleClass="sort-icon">▲</h:commandLink>
                            <h:commandLink
                                action="#{procedureController.sortByDesc('tests','testName')}"
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
                                action="#{procedureController.sortByAsc('tests','testDate')}"
                                rendered="#{!(procedureController.sortField eq 'testDate' and procedureController.isAscending())}"
                                styleClass="sort-icon">▲</h:commandLink>
                            <h:commandLink
                                action="#{procedureController.sortByDesc('tests','testDate')}"
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
                        <h:outputText value="Result Summary" />
                        <h:panelGroup styleClass="sort-icons">
                            <h:commandLink
                                action="#{procedureController.sortByAsc('tests','resultSummary')}"
                                rendered="#{!(procedureController.sortField eq 'resultSummary' and procedureController.isAscending())}"
                                styleClass="sort-icon">▲</h:commandLink>
                            <h:commandLink
                                action="#{procedureController.sortByDesc('tests','resultSummary')}"
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
                <h:commandButton value="Edit" styleClass="btn btn-secondary" 
                    action="#{procedureController.editTest(t)}" />
            </h:column>
        </h:dataTable>
        
        <!-- Pagination Controls -->
        <div class="pagination-controls">
            <h:commandButton value="First"
                             action="#{procedureController.setTestFirst(0)}"
                             disabled="#{procedureController.testFirst == 0}"
                             styleClass="btn btn-secondary" />
            
            <h:commandButton value="Previous"
                             action="#{procedureController.previousTestPage()}"
                             disabled="#{procedureController.testFirst == 0}"
                             styleClass="btn btn-secondary" />
            
            <h:outputText value="Page #{procedureController.testCurrentPage} of #{procedureController.testTotalPages}"
                          style="margin: 0 12px; font-weight:bold;" />
            
            <h:commandButton value="Next"
                             action="#{procedureController.nextTestPage()}"
                             disabled="#{!procedureController.isTestHasNextPage()}"
                             styleClass="btn btn-secondary" />
            
            <h:commandButton value="Last"
                             action="#{procedureController.setTestFirst((procedureController.testTotalPages - 1) * procedureController.testPageSize)}"
                             disabled="#{!procedureController.isTestHasNextPage()}"
                             styleClass="btn btn-secondary" />
        </div>
        </h:panelGroup>
        <h:commandButton value="Back" styleClass="btn btn-primary" 
            action="ViewPrescriptions?faces-redirect=true"/>
    </h:form>
</body>
</html>
</f:view>