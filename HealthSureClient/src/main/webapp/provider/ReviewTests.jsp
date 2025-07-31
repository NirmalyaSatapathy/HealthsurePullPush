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
    </style>
</head>
<body>
    <center>
       
        <h2><h:outputText value="Test Details" /></h2>
    </center>
<h:form prependId="false">
    <h:dataTable value="#{procedureController.tests}" var="t" styleClass="test-table" border="1">

        <h:column>
            <f:facet name="header">
                <h:outputText value="Prescription ID" />
            </f:facet>
            <h:outputText value="#{t.prescription.prescriptionId}" />
        </h:column>

        <h:column>
            <f:facet name="header">
                <h:outputText value="Test Name" />
            </f:facet>
            <h:outputText value="#{t.testName}" />
        </h:column>

        <h:column>
            <f:facet name="header">
                <h:outputText value="Test Date" />
            </f:facet>
            <h:outputText value="#{t.testDate}" />
        </h:column>

        <h:column>
            <f:facet name="header">
                <h:outputText value="Result Summary" />
            </f:facet>
            <h:outputText value="#{t.resultSummary}" />
        </h:column>

        <h:column>
            <f:facet name="header">
                <h:outputText value="Action" />
            </f:facet>
            <h:commandButton value="edit" action="#{procedureController.editTest(t)}" />
        </h:column>

    </h:dataTable>
     <h:commandButton value="back" action="ReviewPrescriptions?faces-redirect=true"/>
    </h:form>
</body>
</html>
</f:view>