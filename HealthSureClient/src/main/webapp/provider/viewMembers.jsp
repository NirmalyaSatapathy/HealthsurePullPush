<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core" %>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html" %>
 
<f:view>
<html>
<head>
    <meta charset="UTF-8">
    <title>Subscribed Family Members</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/viewMembers.css" />
</head>
<body>
<h2>Subscribed Family Members</h2>
<h:form prependId="false">
    <h:outputText value="Total members: #{insuranceController.subscribedMembers.size()}"
                  style="font-weight: bold; display: block; margin-bottom: 10px;" />
 
    <h:dataTable value="#{insuranceController.getPaginatedSubscribedMembers()}"
                 var="member"
                 styleClass="data-table">
 
        <!-- Member ID Column -->
        <h:column>
            <f:facet name="header">
                <h:panelGroup layout="block" style="display: flex; align-items: center;">
                    <h:outputText value="Member ID" />
                    <h:panelGroup styleClass="sort-icons">
                        <h:commandLink
                            action="#{insuranceController.sortByAsc('members','memberId')}"
                            rendered="#{!(insuranceController.sortField eq 'memberId' and insuranceController.isAscending())}"
                            styleClass="sort-icon">▲</h:commandLink>
                        <h:commandLink
                            action="#{insuranceController.sortByDesc('members','memberId')}"
                            rendered="#{!(insuranceController.sortField eq 'memberId' and not insuranceController.isAscending())}"
                            styleClass="sort-icon">▼</h:commandLink>
                    </h:panelGroup>
                </h:panelGroup>
            </f:facet>
            <h:outputText value="#{member.memberId}" />
        </h:column>
 
        <!-- Full Name Column -->
        <h:column>
            <f:facet name="header">
                <h:panelGroup layout="block" style="display: flex; align-items: center;">
                    <h:outputText value="Full Name" />
                    <h:panelGroup styleClass="sort-icons">
                        <h:commandLink
                            action="#{insuranceController.sortByAsc('members','fullName')}"
                            rendered="#{!(insuranceController.sortField eq 'fullName' and insuranceController.isAscending())}"
                            styleClass="sort-icon">▲</h:commandLink>
                        <h:commandLink
                            action="#{insuranceController.sortByDesc('members','fullName')}"
                            rendered="#{!(insuranceController.sortField eq 'fullName' and not insuranceController.isAscending())}"
                            styleClass="sort-icon">▼</h:commandLink>
                    </h:panelGroup>
                </h:panelGroup>
            </f:facet>
            <h:outputText value="#{member.fullName}" />
        </h:column>
 
        <!-- Age Column -->
        <h:column>
            <f:facet name="header">
                <h:panelGroup layout="block" style="display: flex; align-items: center;">
                    <h:outputText value="Age" />
                    <h:panelGroup styleClass="sort-icons">
                        <h:commandLink
                            action="#{insuranceController.sortByAsc('members','age')}"
                            rendered="#{!(insuranceController.sortField eq 'age' and insuranceController.isAscending())}"
                            styleClass="sort-icon">▲</h:commandLink>
                        <h:commandLink
                            action="#{insuranceController.sortByDesc('members','age')}"
                            rendered="#{!(insuranceController.sortField eq 'age' and not insuranceController.isAscending())}"
                            styleClass="sort-icon">▼</h:commandLink>
                    </h:panelGroup>
                </h:panelGroup>
            </f:facet>
            <h:outputText value="#{member.age}" />
        </h:column>
 
        <!-- Gender Column -->
        <h:column>
            <f:facet name="header">
                <h:panelGroup layout="block" style="display: flex; align-items: center;">
                    <h:outputText value="Gender" />
                    <h:panelGroup styleClass="sort-icons">
                        <h:commandLink
                            action="#{insuranceController.sortByAsc('members','gender')}"
                            rendered="#{!(insuranceController.sortField eq 'gender' and insuranceController.isAscending())}"
                            styleClass="sort-icon">▲</h:commandLink>
                        <h:commandLink
                            action="#{insuranceController.sortByDesc('members','gender')}"
                            rendered="#{!(insuranceController.sortField eq 'gender' and not insuranceController.isAscending())}"
                            styleClass="sort-icon">▼</h:commandLink>
                    </h:panelGroup>
                </h:panelGroup>
            </f:facet>
            <h:outputText value="#{member.gender}" />
        </h:column>
 
        <!-- Relation Column -->
        <h:column>
            <f:facet name="header">
                <h:panelGroup layout="block" style="display: flex; align-items: center;">
                    <h:outputText value="Relation" />
                    <h:panelGroup styleClass="sort-icons">
                        <h:commandLink
                            action="#{insuranceController.sortByAsc('members','relationWithProposer')}"
                            rendered="#{!(insuranceController.sortField eq 'relationWithProposer' and insuranceController.isAscending())}"
                            styleClass="sort-icon">▲</h:commandLink>
                        <h:commandLink
                            action="#{insuranceController.sortByDesc('members','relationWithProposer')}"
                            rendered="#{!(insuranceController.sortField eq 'relationWithProposer' and not insuranceController.isAscending())}"
                            styleClass="sort-icon">▼</h:commandLink>
                    </h:panelGroup>
                </h:panelGroup>
            </f:facet>
            <h:outputText value="#{member.relationWithProposer}" />
        </h:column>
 
        <!-- Aadhar No Column -->
        <h:column>
            <f:facet name="header">
                <h:panelGroup layout="block" style="display: flex; align-items: center;">
                    <h:outputText value="Aadhar No" />
                    <h:panelGroup styleClass="sort-icons">
                        <h:commandLink
                            action="#{insuranceController.sortByAsc('members','aadharNo')}"
                            rendered="#{!(insuranceController.sortField eq 'aadharNo' and insuranceController.isAscending())}"
                            styleClass="sort-icon">▲</h:commandLink>
                        <h:commandLink
                            action="#{insuranceController.sortByDesc('members','aadharNo')}"
                            rendered="#{!(insuranceController.sortField eq 'aadharNo' and not insuranceController.isAscending())}"
                            styleClass="sort-icon">▼</h:commandLink>
                    </h:panelGroup>
                </h:panelGroup>
            </f:facet>
            <h:outputText value="#{member.aadharNo}" />
        </h:column>
    </h:dataTable>
 
    <!-- Pagination Controls -->
    <div class="pagination-controls">
        <h:commandButton value="First"
                         action="#{insuranceController.setMemberFirst(0)}"
                         disabled="#{insuranceController.memberFirst == 0}"
                         styleClass="btn btn-tertiary" />
 
        <h:commandButton value="Previous"
                         action="#{insuranceController.previousMemberPage()}"
                         disabled="#{insuranceController.memberFirst == 0}"
                         styleClass="btn btn-tertiary" />
 
        <h:outputText value="Page #{insuranceController.memberCurrentPage} of #{insuranceController.memberTotalPages}"
                      style="margin: 0 12px; font-weight:bold;" />
 
        <h:commandButton value="Next"
                         action="#{insuranceController.nextMemberPage()}"
                         disabled="#{!insuranceController.isMemberHasNextPage()}"
                         styleClass="btn btn-tertiary" />
 
        <h:commandButton value="Last"
                         action="#{insuranceController.setMemberFirst(insuranceController.subscribedMembers.size() -
                                  (insuranceController.subscribedMembers.size() mod insuranceController.memberPageSize))}"
                         disabled="#{!insuranceController.isMemberHasNextPage()}"
                         styleClass="btn btn-tertiary" />
    </div>
 
    <!-- Back Button -->
    <div class="back-button">
        <h:commandButton value="Back to Insurance Details"
                         action="showInsuranceDetails"
                         styleClass="btn btn-primary" />
    </div>
</h:form>
</body>
</html>
</f:view>