<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>

<f:view>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Review Medicines</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f0f4f8;
            color: #333;
            padding: 20px;
        }
        h2 {
            color: #2c3e50;
            font-size: 28px;
            margin-bottom: 20px;
        }
        .med-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .med-table th, .med-table td {
            padding: 12px;
            border: 1px solid #ccc;
            text-align: left;
        }
        .med-table th {
            background-color: #2980b9;
            color: white;
        }
        .med-table tr:nth-child(even) {
            background-color: #ecf0f1;
        }
        .med-table tr:hover {
            background-color: #dfe6e9;
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
            background-color: #2980b9;
            color: #ffffff;
        }
        
        .btn-primary:hover {
            background-color: #1a5276;
        }
        
        .btn-tertiary {
            background-color: #ffffff;
            color: #2980b9;
            border: 2px solid #2980b9;
        }
        
        .btn-tertiary:hover {
            background-color: #d4e6f1;
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
            color: #d4e6f1;
        }
        
        .sort-header-group {
            display: flex;
            align-items: center;
        }
        
        @media (max-width: 600px) {
            h2 {
                font-size: 24px;
            }
            .med-table th,
            .med-table td {
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
        <h2><h:outputText value="Medicine Details" /></h2>
    </center>
   
    <h:form prependId="false">
        <h:commandButton value="Add Medicine" styleClass="btn btn-primary" 
            action="#{procedureController.createNewexistingPrescPrescribedMedicine()}" />
            
           <h:dataTable value="#{empty procedureController.viewMedicines ? ['dummy'] : procedureController.getPaginatedMedicines()}"
             var="m"
             rendered="#{empty procedureController.viewMedicines}"
             styleClass="med-table"
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
<h:outputText value="No medicines added."
              style="font-weight: bold; color: red; display: block; margin-top: 10px; text-align: center; width: 100%;"
              rendered="#{empty procedureController.viewMedicines}" />
            
            <h:panelGroup rendered="#{not empty procedureController.viewMedicines}">
        <h:outputText value="Total medicines: #{procedureController.viewMedicines.size()}"
                      style="font-weight: bold; display: block; margin: 10px 0;" />
        
        <h:dataTable value="#{procedureController.getPaginatedMedicines()}" var="m" 
            styleClass="med-table" border="1">
            
            <h:column>
                <f:facet name="header">
                    <h:panelGroup layout="block" style="display: flex; align-items: center;">
                        <h:outputText value="Prescription ID" />
                        <h:panelGroup styleClass="sort-icons">
                            <h:commandLink
                                action="#{procedureController.sortByAsc('medicines','prescriptionId')}"
                                rendered="#{!(procedureController.sortField eq 'prescriptionId' and procedureController.isAscending())}"
                                styleClass="sort-icon">▲</h:commandLink>
                            <h:commandLink
                                action="#{procedureController.sortByDesc('medicines','prescriptionId')}"
                                rendered="#{!(procedureController.sortField eq 'prescriptionId' and not procedureController.isAscending())}"
                                styleClass="sort-icon">▼</h:commandLink>
                        </h:panelGroup>
                    </h:panelGroup>
                </f:facet>
                <h:outputText value="#{m.prescription.prescriptionId}" />
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:panelGroup layout="block" style="display: flex; align-items: center;">
                        <h:outputText value="Medicine Name" />
                        <h:panelGroup styleClass="sort-icons">
                            <h:commandLink
                                action="#{procedureController.sortByAsc('medicines','medicineName')}"
                                rendered="#{!(procedureController.sortField eq 'medicineName' and procedureController.isAscending())}"
                                styleClass="sort-icon">▲</h:commandLink>
                            <h:commandLink
                                action="#{procedureController.sortByDesc('medicines','medicineName')}"
                                rendered="#{!(procedureController.sortField eq 'medicineName' and not procedureController.isAscending())}"
                                styleClass="sort-icon">▼</h:commandLink>
                        </h:panelGroup>
                    </h:panelGroup>
                </f:facet>
                <h:outputText value="#{m.medicineName}" />
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:panelGroup layout="block" style="display: flex; align-items: center;">
                        <h:outputText value="Type" />
                        <h:panelGroup styleClass="sort-icons">
                            <h:commandLink
                                action="#{procedureController.sortByAsc('medicines','type')}"
                                rendered="#{!(procedureController.sortField eq 'type' and procedureController.isAscending())}"
                                styleClass="sort-icon">▲</h:commandLink>
                            <h:commandLink
                                action="#{procedureController.sortByDesc('medicines','type')}"
                                rendered="#{!(procedureController.sortField eq 'type' and not procedureController.isAscending())}"
                                styleClass="sort-icon">▼</h:commandLink>
                        </h:panelGroup>
                    </h:panelGroup>
                </f:facet>
                <h:outputText value="#{m.type}" />
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:panelGroup layout="block" style="display: flex; align-items: center;">
                        <h:outputText value="Dosage" />
                        <h:panelGroup styleClass="sort-icons">
                            <h:commandLink
                                action="#{procedureController.sortByAsc('medicines','dosage')}"
                                rendered="#{!(procedureController.sortField eq 'dosage' and procedureController.isAscending())}"
                                styleClass="sort-icon">▲</h:commandLink>
                            <h:commandLink
                                action="#{procedureController.sortByDesc('medicines','dosage')}"
                                rendered="#{!(procedureController.sortField eq 'dosage' and not procedureController.isAscending())}"
                                styleClass="sort-icon">▼</h:commandLink>
                        </h:panelGroup>
                    </h:panelGroup>
                </f:facet>
                <h:outputText value="#{m.dosage}" />
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:panelGroup layout="block" style="display: flex; align-items: center;">
                        <h:outputText value="Duration" />
                        <h:panelGroup styleClass="sort-icons">
                            <h:commandLink
                                action="#{procedureController.sortByAsc('medicines','duration')}"
                                rendered="#{!(procedureController.sortField eq 'duration' and procedureController.isAscending())}"
                                styleClass="sort-icon">▲</h:commandLink>
                            <h:commandLink
                                action="#{procedureController.sortByDesc('medicines','duration')}"
                                rendered="#{!(procedureController.sortField eq 'duration' and not procedureController.isAscending())}"
                                styleClass="sort-icon">▼</h:commandLink>
                        </h:panelGroup>
                    </h:panelGroup>
                </f:facet>
                <h:outputText value="#{m.duration}" />
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:panelGroup layout="block" style="display: flex; align-items: center;">
                        <h:outputText value="Start Date" />
                        <h:panelGroup styleClass="sort-icons">
                            <h:commandLink
                                action="#{procedureController.sortByAsc('medicines','startDate')}"
                                rendered="#{!(procedureController.sortField eq 'startDate' and procedureController.isAscending())}"
                                styleClass="sort-icon">▲</h:commandLink>
                            <h:commandLink
                                action="#{procedureController.sortByDesc('medicines','startDate')}"
                                rendered="#{!(procedureController.sortField eq 'startDate' and not procedureController.isAscending())}"
                                styleClass="sort-icon">▼</h:commandLink>
                        </h:panelGroup>
                    </h:panelGroup>
                </f:facet>
                <h:outputText value="#{m.startDate}" />
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:panelGroup layout="block" style="display: flex; align-items: center;">
                        <h:outputText value="End Date" />
                        <h:panelGroup styleClass="sort-icons">
                            <h:commandLink
                                action="#{procedureController.sortByAsc('medicines','endDate')}"
                                rendered="#{!(procedureController.sortField eq 'endDate' and procedureController.isAscending())}"
                                styleClass="sort-icon">▲</h:commandLink>
                            <h:commandLink
                                action="#{procedureController.sortByDesc('medicines','endDate')}"
                                rendered="#{!(procedureController.sortField eq 'endDate' and not procedureController.isAscending())}"
                                styleClass="sort-icon">▼</h:commandLink>
                        </h:panelGroup>
                    </h:panelGroup>
                </f:facet>
                <h:outputText value="#{m.endDate}" />
            </h:column>
            
            <h:column>
                <f:facet name="header">
                    <h:outputText value="Action" />
                </f:facet>
                <h:commandButton value="Edit" styleClass="btn btn-primary" 
                    action="#{procedureController.editMedicine(m)}" />
            </h:column>
        </h:dataTable>
        
      <!-- Pagination Controls -->
<div class="pagination-controls">
    <h:commandButton value="First"
                     action="#{procedureController.setMedicineFirst(0)}"
                     disabled="#{procedureController.medicineFirst == 0}"
                     styleClass="btn btn-tertiary" />
    
    <h:commandButton value="Previous"
                     action="#{procedureController.previousMedicinePage()}"
                     disabled="#{procedureController.medicineFirst == 0}"
                     styleClass="btn btn-tertiary" />
    
    <h:outputText value="Page #{procedureController.medicineCurrentPage} of #{procedureController.medicineTotalPages}"
                  style="margin: 0 12px; font-weight:bold;" />
    
    <h:commandButton value="Next"
                     action="#{procedureController.nextMedicinePage()}"
                     disabled="#{!procedureController.isMedicineHasNextPage()}"
                     styleClass="btn btn-tertiary" />
    
    <h:commandButton value="Last"
                     action="#{procedureController.setMedicineFirst((procedureController.medicineTotalPages - 1) * procedureController.medicinePageSize)}"
                     disabled="#{!procedureController.isMedicineHasNextPage()}"
                     styleClass="btn btn-tertiary" />
</div>
         </h:panelGroup>
        <h:commandButton value="Back" styleClass="btn btn-primary" 
            action="ViewPrescriptions?faces-redirect=true"/>
    </h:form>
   
</body>
</html>
</f:view>