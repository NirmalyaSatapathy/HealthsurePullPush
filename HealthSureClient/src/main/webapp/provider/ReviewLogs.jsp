<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>

<f:view>
<html>
<head>
    <meta charset="UTF-8">
    <title>Prescription & Procedure Logs</title>
    <style>
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
    </style>
</head>
<body>
    <h:form prependId="false">
        <!-- 🌟 Procedure Logs  -->
        <center>
            <h2><h:outputText value="Procedure Logs" /></h2>
        </center>

        <h:dataTable value="#{procedureController.procedureLogs}" var="log" styleClass="data-table" border="1">
<h:column>
                <f:facet name="header">
                    <h:outputText value="Log Id" />
                </f:facet>
                <h:outputText value="#{log.logId}" />
            </h:column>
            <h:column>
                <f:facet name="header">
                    <h:outputText value="Log Date" />
                </f:facet>
                <h:outputText value="#{log.logDate}" />
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="Vitals" />
                </f:facet>
                <h:outputText value="#{log.vitals}" />
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="Notes" />
                </f:facet>
                <h:outputText value="#{log.notes}" />
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="Logged By" />
                </f:facet>
                <h:outputText value="#{log.loggedDoctor.doctorId}" />
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="Procedure Diagnosis" />
                </f:facet>
                <h:outputText value="#{log.medicalProcedure.diagnosis}" />
            </h:column>
             <h:column>
                <f:facet name="header">
                    <h:outputText value="Action" />
                </f:facet>
                <h:commandButton value="edit" action="#{procedureController.editLog(log)}" />
            </h:column>
        </h:dataTable>
        <h:commandButton value="back" action="LongTermProcedureDashboard?faces-redirect=true"/>
    </h:form>
</body>
</html>
</f:view>