<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core" %>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html" %>

<f:view>
<html>
<head>
    <meta charset="UTF-8">
    <title>Patient Details</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f7fc;
            color: #333;
            padding: 20px;
        }

        center {
            margin-bottom: 30px;
        }

        h2 {
            color: #3f51b5;
            font-size: 28px;
            margin: 20px 0;
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 30px;
        }

        .data-table th,
        .data-table td {
            padding: 12px;
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
            margin-top: 20px;
            text-align: center;
        }

        @media (max-width: 600px) {
            h2 {
                font-size: 24px;
            }
        }
    </style>
</head>
<body>
<h2>Related as a Member Insurance Details</h2>
    <!-- Table to display patient details -->
<%-- <h:dataTable value="#{bean.list}" var="d" border="1" styleClass="data-table"> --%>
        <h:dataTable value="null" var="d" border="1" styleClass="data-table">
            <h:column>
                <f:facet name="header"><h:outputText value="Full Name" /></f:facet>
                <h:outputText value="Nrmalya" />
            </h:column>

            <h:column>
                <f:facet name="header"><h:outputText value="Age" /></f:facet>
                <h:outputText value="20" />
            </h:column>

            <h:column>
                <f:facet name="header"><h:outputText value="Gender" /></f:facet>
                <h:outputText value="Male" />
            </h:column>

            <h:column>
                <f:facet name="header"><h:outputText value="Relation" /></f:facet>
                <h:outputText value="son1"/>
            </h:column>
             <h:column>
                <f:facet name="header"><h:outputText value="Subscribed by" /></f:facet>
                <h:outputText value="Suman"/>
              
            </h:column>
             <h:column>
                <f:facet name="header"><h:outputText value="Subscribe Date" /></f:facet>
                <h:outputText value="2025-08-09">
                    <f:convertDateTime pattern="yyyy-MM-dd" />
                </h:outputText>
            </h:column>
              <h:column>
                <f:facet name="header"><h:outputText value="Coverage start Date" /></f:facet>
                <h:outputText value="2025-08-09">
                    <f:convertDateTime pattern="yyyy-MM-dd" />
                </h:outputText>
            </h:column>
            <h:column>
                <f:facet name="header"><h:outputText value="Coverage end Date" /></f:facet>
                <h:outputText value="2025-09-09">
                    <f:convertDateTime pattern="yyyy-MM-dd" />
                </h:outputText>
            </h:column>
            <h:column>
                <f:facet name="header"><h:outputText value="Coverage amount" /></f:facet>
                 <h:outputText value="08732973"/>
            </h:column>
            <h:column>
                <f:facet name="header"><h:outputText value="Remaining amount" /></f:facet>
                <h:outputText value="3893832"/>
            
            </h:column>
            <h:column>
                <f:facet name="header"><h:outputText value="Total claimed" /></f:facet>
                <h:outputText value="3883833"/>
            </h:column>
            <h:column>
                <f:facet name="header"><h:outputText value="Last claim date" /></f:facet>
                <h:outputText value="2025-09-09">
                    <f:convertDateTime pattern="yyyy-MM-dd" />
                </h:outputText>
            </h:column>
        </h:dataTable>
</body>
</html>
</f:view>
