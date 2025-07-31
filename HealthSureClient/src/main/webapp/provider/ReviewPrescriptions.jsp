<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core" %>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html" %>

<f:view>
<html>
<head>
  <meta charset="UTF-8">
  <title>Prescription List</title>
  <style>
    /* Base page and typography */
    body {
      font-family: 'Segoe UI', Arial, sans-serif;
      background-color: #f4f8fc;
      color: #2e3e50;
      margin: 0;
      padding: 20px;
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
    
    h2 {
      color: #1E88E5;
      font-size: 28px;
      margin-bottom: 20px;
      border-bottom: 2px solid #BBDEFB;
      padding-bottom: 6px;
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

    /* Primary (Blue) */
    .btn-primary {
      background-color: #1E88E5;
      color: #ffffff;
    }
    .btn-primary:hover {
      background-color: #1565C0;
    }

    /* Secondary (Green) */
    .btn-secondary {
      background-color: #43A047;
      color: #ffffff;
    }
    .btn-secondary:hover {
      background-color: #2E7D32;
    }

    /* Tertiary (Outline) */
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
      font-size: 15px;
    }

    .data-table tr:nth-child(even) {
      background-color: #e8f5e9;
    }

    .data-table tr:hover {
      background-color: #BBDEFB;
    }

    /* Pagination grid */
    .pagination-group {
      margin-top: 20px;
    }

    /* Responsive tweaks */
    @media (max-width: 600px) {
      h2 {
        font-size: 24px;
      }
      .data-table th,
      .data-table td {
        padding: 6px;
        font-size: 13px;
      }
    }
  </style>
</head>

<body>
  <center>
    <h2><h:outputText value="Prescriptions" /></h2>
  </center>
  
  <!-- Top Message -->
  <h:panelGroup rendered="#{not empty procedureController.topMessage}">
    <h:outputText value="#{procedureController.pullTopMessage()}"
      style="color:#f44336; font-weight:bold; display:block; margin-top:20px;" />
  </h:panelGroup>
  
  <h:form prependId="false">
    <h:panelGroup rendered="#{not empty procedureController.currentPagePrescriptions}">
      <h:outputText value="Total: #{procedureController.prescriptions.size()} prescriptions"
                    style="font-weight: bold; display: block; margin-top: 20px;" />

      <h:dataTable value="#{procedureController.prescriptions}" 
                   var="p" 
                   styleClass="data-table">
                   
        <!-- Prescription ID -->
        <h:column>
          <f:facet name="header">
            <h:panelGroup layout="block" style="display: flex; align-items: center;">
              <h:outputText value="Prescription ID" />
              <h:panelGroup styleClass="sort-icons">
                <h:commandLink action="#{procedureController.sortByAsc('prescriptionId')}"
                              rendered="#{!(procedureController.sortField eq 'prescriptionId' and procedureController.sortAscending)}"
                              styleClass="sort-icon">▲</h:commandLink>
                <h:commandLink action="#{procedureController.sortByDesc('prescriptionId')}"
                              rendered="#{!(procedureController.sortField eq 'prescriptionId' and not procedureController.sortAscending)}"
                              styleClass="sort-icon">▼</h:commandLink>
              </h:panelGroup>
            </h:panelGroup>
          </f:facet>
          <h:outputText value="#{p.prescriptionId}" />
        </h:column>

        <!-- Procedure Diagnosis -->
        <h:column>
          <f:facet name="header">
            <h:panelGroup layout="block" style="display: flex; align-items: center;">
              <h:outputText value="Diagnosis" />
              <h:panelGroup styleClass="sort-icons">
                <h:commandLink action="#{procedureController.sortByAsc('diagnosis')}"
                              rendered="#{!(procedureController.sortField eq 'diagnosis' and procedureController.sortAscending)}"
                              styleClass="sort-icon">▲</h:commandLink>
                <h:commandLink action="#{procedureController.sortByDesc('diagnosis')}"
                              rendered="#{!(procedureController.sortField eq 'diagnosis' and not procedureController.sortAscending)}"
                              styleClass="sort-icon">▼</h:commandLink>
              </h:panelGroup>
            </h:panelGroup>
          </f:facet>
          <h:outputText value="#{p.procedure.diagnosis}" />
        </h:column>

        <!-- Procedure Doctor -->
        <h:column>
          <f:facet name="header">
            <h:panelGroup layout="block" style="display: flex; align-items: center;">
              <h:outputText value="Procedure Doctor" />
              <h:panelGroup styleClass="sort-icons">
                <h:commandLink action="#{procedureController.sortByAsc('procedureDoctor')}"
                              rendered="#{!(procedureController.sortField eq 'procedureDoctor' and procedureController.sortAscending)}"
                              styleClass="sort-icon">▲</h:commandLink>
                <h:commandLink action="#{procedureController.sortByDesc('procedureDoctor')}"
                              rendered="#{!(procedureController.sortField eq 'procedureDoctor' and not procedureController.sortAscending)}"
                              styleClass="sort-icon">▼</h:commandLink>
              </h:panelGroup>
            </h:panelGroup>
          </f:facet>
          <h:outputText value="#{p.procedure.doctor.doctorId}" />
        </h:column>
        
        <!-- Prescribed Doctor -->
        <h:column>
          <f:facet name="header">
            <h:panelGroup layout="block" style="display: flex; align-items: center;">
              <h:outputText value="Prescribed Doctor" />
              <h:panelGroup styleClass="sort-icons">
                <h:commandLink action="#{procedureController.sortByAsc('prescribedDoctor')}"
                              rendered="#{!(procedureController.sortField eq 'prescribedDoctor' and procedureController.sortAscending)}"
                              styleClass="sort-icon">▲</h:commandLink>
                <h:commandLink action="#{procedureController.sortByDesc('prescribedDoctor')}"
                              rendered="#{!(procedureController.sortField eq 'prescribedDoctor' and not procedureController.sortAscending)}"
                              styleClass="sort-icon">▼</h:commandLink>
              </h:panelGroup>
            </h:panelGroup>
          </f:facet>
          <h:outputText value="#{p.prescribedDoc.doctorId}" />
        </h:column>

        <!-- Start Date -->
        <h:column>
          <f:facet name="header">
            <h:panelGroup layout="block" style="display: flex; align-items: center;">
              <h:outputText value="Start Date" />
              <h:panelGroup styleClass="sort-icons">
                <h:commandLink action="#{procedureController.sortByAsc('startDate')}"
                              rendered="#{!(procedureController.sortField eq 'startDate' and procedureController.sortAscending)}"
                              styleClass="sort-icon">▲</h:commandLink>
                <h:commandLink action="#{procedureController.sortByDesc('startDate')}"
                              rendered="#{!(procedureController.sortField eq 'startDate' and not procedureController.sortAscending)}"
                              styleClass="sort-icon">▼</h:commandLink>
              </h:panelGroup>
            </h:panelGroup>
          </f:facet>
          <h:outputText value="#{p.startDate}">
            <f:convertDateTime pattern="yyyy-MM-dd" />
          </h:outputText>
        </h:column>

        <!-- End Date -->
        <h:column>
          <f:facet name="header">
            <h:panelGroup layout="block" style="display: flex; align-items: center;">
              <h:outputText value="End Date" />
              <h:panelGroup styleClass="sort-icons">
                <h:commandLink action="#{procedureController.sortByAsc('endDate')}"
                              rendered="#{!(procedureController.sortField eq 'endDate' and procedureController.sortAscending)}"
                              styleClass="sort-icon">▲</h:commandLink>
                <h:commandLink action="#{procedureController.sortByDesc('endDate')}"
                              rendered="#{!(procedureController.sortField eq 'endDate' and not procedureController.sortAscending)}"
                              styleClass="sort-icon">▼</h:commandLink>
              </h:panelGroup>
            </h:panelGroup>
          </f:facet>
          <h:outputText value="#{p.endDate}">
            <f:convertDateTime pattern="yyyy-MM-dd" />
          </h:outputText>
        </h:column>

        <!-- Actions -->
        <h:column>
          <f:facet name="header">
            <h:outputText value="Actions" />
          </f:facet>
          <h:panelGroup>
            <h:commandButton value="Edit" 
                            action="#{procedureController.addPrescriptionController(p)}"
                            styleClass="btn btn-primary" />
            <h:commandButton value="Medicines" 
                            action="#{procedureController.reviewMedicines(p)}"
                            styleClass="btn btn-secondary" />
            <h:commandButton value="Tests" 
                            action="#{procedureController.reviewTests(p)}"
                            styleClass="btn btn-tertiary" />
          </h:panelGroup>
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
    
    <h:commandButton value="Back" 
                     action="#{procedureController.backToprocedure()}"
                     styleClass="btn btn-tertiary" />
  </h:form>
</body>
</html>
</f:view>