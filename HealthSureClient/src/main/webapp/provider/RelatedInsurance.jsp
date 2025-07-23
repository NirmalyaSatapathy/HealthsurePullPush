<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core" %>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html" %>

<f:view>
<html>
<head>
    <meta charset="UTF-8">
    <title>Patient Insurance Details</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f7fc;
            color: #333;
            padding: 20px;
        }

        h2 {
            color: #3f51b5;
            font-size: 28px;
            margin-bottom: 20px;
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
        }

        .data-table th,
        .data-table td {
            padding: 10px;
            text-align: left;
            border: 1px solid #ddd;
        }

        .data-table th {
            background-color: #3f51b5;
            color: white;
        }

        .data-table tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .data-table tr:hover {
            background-color: #e0e0e0;
        }

        .message {
            color: red;
            font-weight: bold;
            text-align: center;
        }
    </style>
</head>
<body>
    <h2>Related Member Insurance Details</h2>

    <h:dataTable value="#{insuranceController.relatedInsuranceList}" var="d" styleClass="data-table" border="1">

        <h:column>
            <f:facet name="header"><h:outputText value="Full Name" /></f:facet>
            <h:outputText value="#{d.memberName}" />
        </h:column>

        <h:column>
            <f:facet name="header"><h:outputText value="Age" /></f:facet>
            <h:outputText value="#{d.memberAge}" />
        </h:column>

        <h:column>
            <f:facet name="header"><h:outputText value="Gender" /></f:facet>
            <h:outputText value="#{d.memberGender}" />
        </h:column>

        <h:column>
            <f:facet name="header"><h:outputText value="Relation" /></f:facet>
            <h:outputText value="#{d.relationWithProposer}" />
        </h:column>

        <h:column>
            <f:facet name="header"><h:outputText value="Subscribed By" /></f:facet>
            <h:outputText value="#{d.proposerName}" />
        </h:column>
<h:column>
            <f:facet name="header"><h:outputText value="Company " /></f:facet>
            <h:outputText value="#{d.companyName}" />
        </h:column>
        <h:column>
            <f:facet name="header"><h:outputText value="Plan " /></f:facet>
            <h:outputText value="#{d.planName}" />
        </h:column>
        <h:column>
            <f:facet name="header"><h:outputText value="Subscribe Date" /></f:facet>
            <h:outputText value="#{d.enrollmentDate}">
                <f:convertDateTime pattern="yyyy-MM-dd" />
            </h:outputText>
        </h:column>

        <h:column>
            <f:facet name="header"><h:outputText value="Coverage Start" /></f:facet>
            <h:outputText value="#{d.coverageStartDate}">
                <f:convertDateTime pattern="yyyy-MM-dd" />
            </h:outputText>
        </h:column>

        <h:column>
            <f:facet name="header"><h:outputText value="Coverage End" /></f:facet>
            <h:outputText value="#{d.coverageEndDate}">
                <f:convertDateTime pattern="yyyy-MM-dd" />
            </h:outputText>
        </h:column>

        <h:column>
            <f:facet name="header"><h:outputText value="Coverage Amount" /></f:facet>
            <h:outputText value="#{d.coverageLimit}" />
        </h:column>

        <h:column>
            <f:facet name="header"><h:outputText value="Remaining Amount" /></f:facet>
            <h:outputText value="#{d.remaining}" />
        </h:column>

        <h:column>
            <f:facet name="header"><h:outputText value="Total Claimed" /></f:facet>
            <h:outputText value="#{d.claimed}" />
        </h:column>

        <h:column>
            <f:facet name="header"><h:outputText value="Last Claim Date" /></f:facet>
            <h:outputText value="#{d.lastClaimDate}">
                <f:convertDateTime pattern="yyyy-MM-dd" />
            </h:outputText>
        </h:column>

    </h:dataTable>
</body>
</html>
</f:view>
