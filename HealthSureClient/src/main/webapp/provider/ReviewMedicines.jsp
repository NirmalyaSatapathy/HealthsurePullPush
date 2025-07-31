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
    </style>
</head>
<body>
    <center>
       
        <h2><h:outputText value="Medicine Details" /></h2>
    </center>
	<h:form prependId="false">
    <h:dataTable value="#{procedureController.meds}" var="m" styleClass="med-table" border="1">

        <h:column>
            <f:facet name="header">
                <h:outputText value="Prescription ID" />
            </f:facet>
            <h:outputText value="#{m.prescription.prescriptionId}" />
        </h:column>

        <h:column>
            <f:facet name="header">
                <h:outputText value="Medicine Name" />
            </f:facet>
            <h:outputText value="#{m.medicineName}" />
        </h:column>

        <h:column>
            <f:facet name="header">
                <h:outputText value="Type" />
            </f:facet>
            <h:outputText value="#{m.type}" />
        </h:column>

        <h:column>
            <f:facet name="header">
                <h:outputText value="Dosage" />
            </f:facet>
            <h:outputText value="#{m.dosage}" />
        </h:column>

        <h:column>
            <f:facet name="header">
                <h:outputText value="Duration" />
            </f:facet>
            <h:outputText value="#{m.duration}" />
        </h:column>

        <h:column>
            <f:facet name="header">
                <h:outputText value="Start Date" />
            </f:facet>
            <h:outputText value="#{m.startDate}" />
        </h:column>

        <h:column>
            <f:facet name="header">
                <h:outputText value="End Date" />
            </f:facet>
            <h:outputText value="#{m.endDate}" />
        </h:column>
         <h:column>
            <f:facet name="header">
                <h:outputText value="Action" />
            </f:facet>
            <h:commandButton value="edit" action="#{procedureController.editMedicine(m)}" />
        </h:column>

    </h:dataTable>
    <h:commandButton value="back" action="ReviewPrescriptions?faces-redirect=true"/>
    </h:form>
</body>
</html>
</f:view>