<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core" %>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html" %>

<f:view>
<html>
<head>
  <meta charset="UTF-8" />
  <title>Patient Insurance Details</title>
  <style>
    /* Base page styling */
    body {
      font-family: 'Segoe UI', Arial, sans-serif;
      background-color: #f4f8fc;
      color: #2e3e50;
      margin: 0;
      padding: 20px;
    }
    h2 {
      color: #1E88E5;
      font-size: 28px;
      margin-bottom: 20px;
      border-bottom: 2px solid #BBDEFB;
      padding-bottom: 6px;
    }

    /* Form controls */
    .form-group {
      margin-bottom: 0px;
    }
    .form-group label {
      display: inline-block;
      width: 160px;
      font-weight: bold;
      color: #2E7D32;
      margin-bottom: 5px;
    }
    .form-control {
      padding: 8px 10px;
      width: 260px;
      font-size: 14px;
      box-sizing: border-box;
      transition: border-color 0.3s ease;
    }
    .form-control:focus {
      outline: none;
      border-color: #1E88E5;
      box-shadow: 0 0 4px rgba(30,136,229,0.3);
    }
    .error-message {
      display: block;
      color: #f44336;
      font-size: 14px;
      font-weight: 600;
      margin-top: 6px;
      margin-left: 165px;
    }

    /* Buttons */
    .btn {
      border: none;
      border-radius: 4px;
      padding: 8px 16px;
      font-size: 14px;
      cursor: pointer;
      transition: background-color 0.3s ease;
      margin: 5px 8px 5px 0;
    }
    .btn-primary {
      background-color: #1E88E5;
      color: #ffffff;
    }
    .btn-primary:hover {
      background-color: #1565C0;
    }
    .btn-secondary {
      background-color: #43A047;
      color: #ffffff;
    }
    .btn-secondary:hover {
      background-color: #2E7D32;
    }
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
      background-color: #ffffff;
      box-shadow: 0 2px 8px rgba(0,0,0,0.08);
    }
    .data-table th {
      background-color: #1E88E5;
      color: #ffffff;
      font-weight: 600;
      padding: 12px;
      text-align: center;
      border: 1px solid #90CAF9;
    }
    .data-table td {
      border: 1px solid #cfd8dc;
      padding: 10px;
      font-size: 15px;
      text-align: center;
      color: #2e3e50;
    }
    .data-table tr:nth-child(even) {
      background-color: #e8f5e9;
    }
    .data-table tr:hover {
      background-color: #BBDEFB;
    }

    /* Pagination groups */
    .pagination-group {
      margin-top: 20px;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    @media (max-width: 600px) {
      h2 { font-size: 24px; }
      .form-control { width: 100%; }
      .data-table th,
      .data-table td {
        font-size: 13px;
        padding: 6px;
      }
      .btn {
        width: 100%;
        margin: 6px 0;
      }
      .pagination-group {
        flex-direction: column;
        gap: 8px;
      }
    }
    /* remove input‐box styling for this radio group */
/* remove any focus outline or glow on all radios */
input[type="radio"],
input[type="radio"]:focus {
  outline: none !important;
  box-shadow: none !important;
}

/* Firefox inner focus border */
input[type="radio"]::-moz-focus-inner {
  border: 0;
}
  </style>
</head>

<body>
  <h2>Patient Insurance Details</h2>

  <!-- Search Form -->
  <h:form prependId="false">
    <div class="form-group">
      <label for="doctorId" escape="false">
        Enter Doctor ID:<span style="color:red;">*</span>
      </label>
      <h:inputText id="doctorId"
                   value="#{insuranceController.doctorId}"
                   styleClass="form-control" />
      <h:message for="doctorId" styleClass="error-message" />
    </div>

    <div class="form-group">
      <label for="recipientId">Enter Patient ID (optional):</label>
      <h:inputText id="recipientId"
                   value="#{insuranceController.healthId}"
                   styleClass="form-control" />
      <h:message for="recipientId" styleClass="error-message" />
    </div>

    <div class="form-group">
      <label for="patientName">Patient Name (optional):</label>
      <h:inputText id="patientName"
                   value="#{insuranceController.patientName}"
                   styleClass="form-control" />
      <h:message for="patientName" styleClass="error-message" />
    </div>
 <div class="form-group">
      <h:selectOneRadio id="insuranceType"
                        value="#{insuranceController.insuranceType}"
                        layout="lineDirection"
                        styleClass="form-control">
        <f:selectItem itemLabel="Own" itemValue="own" />
        <f:selectItem itemLabel="Related as a member"  itemValue="relatedAsAMember" />
      </h:selectOneRadio>
      <h:message for="insuranceType" styleClass="error-message" />
    </div>
    <div class="form-group">
      <h:selectOneRadio id="matchType"
                        value="#{insuranceController.matchType}"
                        layout="lineDirection"
                        styleClass="form-control">
        <f:selectItem itemLabel="Starts With" itemValue="startsWith" />
        <f:selectItem itemLabel="Contains"  itemValue="contains" />
      </h:selectOneRadio>
      <h:message for="matchType" styleClass="error-message" />
    </div>

    <div>
      <h:commandButton value="Search"
                       action="#{insuranceController.handleSearch()}"
                       styleClass="btn btn-primary" />
      <h:commandButton value="Reset"
                       action="#{insuranceController.resetPage()}"
                       immediate="true"
                       styleClass="btn btn-secondary" />
      <h:commandButton value="Go to Dashboard"
                       action="#{insuranceController.goToDashboard()}"
                       styleClass="btn btn-tertiary" />
    </div>
  </h:form>

  <!-- Top Message -->
  <h:panelGroup rendered="#{not empty insuranceController.topMessage}">
    <h:outputText value="#{insuranceController.pullTopMessage()}"
                  style="color:#f44336; font-weight:bold; display:block; margin-top:20px;" />
  </h:panelGroup>

  <!-- Associated Patients Table -->
  <h:panelGroup rendered="#{insuranceController.showPatientsFlag}">
    <h:form prependId="false">
      <h:outputText value="Total Associated Patients: #{insuranceController.associatedPatients.size()}"
                    style="font-weight:bold; display:block; margin-top:20px;" />

      <h:dataTable value="#{insuranceController.getPaginatedAssociatedPatients()}"
                   var="patient"
                   styleClass="data-table">

        <h:column>
          <f:facet name="header">
            <h:commandLink value="Health ID#{insuranceController.sortField eq 'hId'
                               ? (insuranceController.ascending ? ' ↑' : ' ↓') : ''}"
                           action="#{insuranceController.sortBy('patients','hId')}" />
          </f:facet>
          <h:outputText value="#{patient.hId}" />
        </h:column>

        <h:column>
          <f:facet name="header">
            <h:commandLink value="User Name#{insuranceController.sortField eq 'userName'
                               ? (insuranceController.ascending ? ' ↑' : ' ↓') : ''}"
                           action="#{insuranceController.sortBy('patients','userName')}" />
          </f:facet>
          <h:outputText value="#{patient.userName}" />
        </h:column>

        <h:column>
          <f:facet name="header">
            <h:commandLink value="First Name#{insuranceController.sortField eq 'firstName'
                               ? (insuranceController.ascending ? ' ↑' : ' ↓') : ''}"
                           action="#{insuranceController.sortBy('patients','firstName')}" />
          </f:facet>
          <h:outputText value="#{patient.firstName}" />
        </h:column>

        <h:column>
          <f:facet name="header">
            <h:commandLink value="Last Name#{insuranceController.sortField eq 'lastName'
                               ? (insuranceController.ascending ? ' ↑' : ' ↓') : ''}"
                           action="#{insuranceController.sortBy('patients','lastName')}" />
          </f:facet>
          <h:outputText value="#{patient.lastName}" />
        </h:column>

        <h:column>
          <f:facet name="header">
            <h:outputText value="Show Insurance" />
          </f:facet>
          <h:commandButton value="Own"
                           action="#{insuranceController.showInsuranceForPatient(patient.hId)}"
                           styleClass="btn btn-primary" />
          <h:commandButton value="As a member"
                           action="#{insuranceController.showRelatedInsuranceController(patient.hId)}"
                           styleClass="btn btn-primary" />
        </h:column>
      </h:dataTable>

      <div class="pagination-group">
        <div>
          <h:commandButton value="First"
                           action="#{insuranceController.setPatientFirst(0)}"
                           disabled="#{insuranceController.patientFirst == 0}"
                           styleClass="btn btn-tertiary" />
          <h:commandButton value="Previous"
                           action="#{insuranceController.previousPatientPage()}"
                           disabled="#{insuranceController.patientFirst == 0}"
                           styleClass="btn btn-tertiary" />
        </div>
        <div>
          <h:outputText value="Page #{insuranceController.associatedPatientsCurrentPage}
                               of #{insuranceController.associatedPatientsTotalPages}"
                        style="font-weight:bold;" />
        </div>
        <div>
          <h:commandButton value="Next"
                           action="#{insuranceController.nextPatientPage()}"
                           disabled="#{!insuranceController.isPatientHasNextPage()}"
                           styleClass="btn btn-tertiary" />
          <h:commandButton value="Last"
                           action="#{insuranceController.setPatientFirst(
                                     insuranceController.associatedPatients.size()
                                     - (insuranceController.associatedPatients.size()
                                        mod insuranceController.patientPageSize))}"
                           disabled="#{!insuranceController.isPatientHasNextPage()}"
                           styleClass="btn btn-tertiary" />
        </div>
      </div>
    </h:form>
  </h:panelGroup>

  <!-- Patient Insurance Table -->
  <h:panelGroup rendered="#{insuranceController.showInsuranceFlag}">
    <h:form prependId="false">
      <h:outputText value="Total Insurance Records: #{insuranceController.patientInsuranceList.size()}"
                    style="font-weight:bold; display:block; margin-top:20px;" />

      <h:dataTable value="#{insuranceController.getPaginatedInsuranceList()}"
                   var="insurance"
                   styleClass="data-table">

        <h:column>
          <f:facet name="header">
            <h:commandLink value="Patient Name#{insuranceController.sortField eq 'patientName'
                               ? (insuranceController.ascending ? ' ↑' : ' ↓') : ''}"
                           action="#{insuranceController.sortBy('insurance','patientName')}" />
          </f:facet>
          <h:outputText value="#{insurance.patientName}" />
        </h:column>

        <h:column>
          <f:facet name="header">
            <h:commandLink value="Company Name#{insuranceController.sortField eq 'companyName'
                               ? (insuranceController.ascending ? ' ↑' : ' ↓') : ''}"
                           action="#{insuranceController.sortBy('insurance','companyName')}" />
          </f:facet>
          <h:outputText value="#{insurance.companyName}" />
        </h:column>

        <h:column>
          <f:facet name="header">
            <h:commandLink value="Plan Name#{insuranceController.sortField eq 'planName'
                               ? (insuranceController.ascending ? ' ↑' : ' ↓') : ''}"
                           action="#{insuranceController.sortBy('insurance','planName')}" />
          </f:facet>
          <h:outputText value="#{insurance.planName}" />
        </h:column>

        <h:column>
          <f:facet name="header">
            <h:commandLink value="Enrollment Date#{insuranceController.sortField eq 'enrollmentDate'
                               ? (insuranceController.ascending ? ' ↑' : ' ↓') : ''}"
                           action="#{insuranceController.sortBy('insurance','enrollmentDate')}" />
          </f:facet>
          <h:outputText value="#{insurance.enrollmentDate}">
            <f:convertDateTime pattern="yyyy-MM-dd" />
          </h:outputText>
        </h:column>

        <h:column>
          <f:facet name="header">
            <h:commandLink value="Coverage Start#{insuranceController.sortField eq 'coverageStartDate'
                               ? (insuranceController.ascending ? ' ↑' : ' ↓') : ''}"
                           action="#{insuranceController.sortBy('insurance','coverageStartDate')}" />
          </f:facet>
          <h:outputText value="#{insurance.coverageStartDate}">
            <f:convertDateTime pattern="yyyy-MM-dd" />
          </h:outputText>
        </h:column>

        <h:column>
          <f:facet name="header">
            <h:commandLink value="Coverage End#{insuranceController.sortField eq 'coverageEndDate'
                               ? (insuranceController.ascending ? ' ↑' : ' ↓') : ''}"
                           action="#{insuranceController.sortBy('insurance','coverageEndDate')}" />
          </f:facet>
          <h:outputText value="#{insurance.coverageEndDate}">
            <f:convertDateTime pattern="yyyy-MM-dd" />
          </h:outputText>
        </h:column>

        <h:column>
          <f:facet name="header">
            <h:commandLink value="Coverage Type#{insuranceController.sortField eq 'coverageType'
                               ? (insuranceController.ascending ? ' ↑' : ' ↓') : ''}"
                           action="#{insuranceController.sortBy('insurance','coverageType')}" />
          </f:facet>
          <h:outputText value="#{insurance.coverageType}" />
        </h:column>

        <h:column>
          <f:facet name="header">
            <h:commandLink value="Status#{insuranceController.sortField eq 'coverageStatus'
                               ? (insuranceController.ascending ? ' ↑' : ' ↓') : ''}"
                           action="#{insuranceController.sortBy('insurance','coverageStatus')}" />
          </f:facet>
          <h:outputText value="#{insurance.coverageStatus}" />
        </h:column>

        <h:column>
          <f:facet name="header">
            <h:commandLink value="Coverage Limit#{insuranceController.sortField eq 'coverageLimit'
                               ? (insuranceController.ascending ? ' ↑' : ' ↓') : ''}"
                           action="#{insuranceController.sortBy('insurance','coverageLimit')}" />
          </f:facet>
          <h:outputText value="#{insurance.coverageLimit}" />
        </h:column>

        <h:column>
          <f:facet name="header">
            <h:commandLink value="Remaining Amount#{insuranceController.sortField eq 'remaining'
                               ? (insuranceController.ascending ? ' ↑' : ' ↓') : ''}"
                           action="#{insuranceController.sortBy('insurance','remaining')}" />
          </f:facet>
          <h:outputText value="#{insurance.remaining}" />
        </h:column>

        <h:column>
          <f:facet name="header">
            <h:commandLink value="Claimed Amount#{providerController.sortField eq 'claimed'
                               ? (providerController.ascending ? ' ↑' : ' ↓') : ''}"
                           action="#{providerController.sortBy('insurance','claimed')}" />
          </f:facet>
          <h:outputText value="#{insurance.claimed}" />
        </h:column>

        <h:column>
          <f:facet name="header">
            <h:commandLink value="Last Claim Date#{insuranceController.sortField eq 'lastClaimDate'
                               ? (insuranceController.ascending ? ' ↑' : ' ↓') : ''}"
                           action="#{insuranceController.sortBy('insurance','lastClaimDate')}" />
          </f:facet>
          <h:outputText value="#{insurance.lastClaimDate}">
            <f:convertDateTime pattern="yyyy-MM-dd" />
          </h:outputText>
        </h:column>

        <h:column>
          <f:facet name="header">
            <h:outputText value="Action" />
          </f:facet>
          <h:panelGroup rendered="#{insurance.coverageType eq 'FAMILY'}">
            <h:commandButton value="View Members"
                             action="#{insuranceController.redirect(insurance)}"
                             styleClass="btn btn-primary" />
          </h:panelGroup>
        </h:column>
      </h:dataTable>

      <div class="pagination-group">
        <div>
          <h:commandButton value="First"
                           action="#{insuranceController.setInsuranceFirst(0)}"
                           disabled="#{insuranceController.insuranceFirst == 0}"
                           styleClass="btn btn-tertiary" />
          <h:commandButton value="Previous"
                           action="#{insuranceController.previousInsurancePage()}"
                           disabled="#{insuranceController.insuranceFirst == 0}"
                           styleClass="btn btn-tertiary" />
        </div>
        <div>
          <h:outputText value="Page #{insuranceController.insuranceCurrentPage}
                               of #{insuranceController.insuranceTotalPages}"
                        style="font-weight:bold;" />
        </div>
        <div>
          <h:commandButton value="Next"
                           action="#{insuranceController.nextInsurancePage()}"
                           disabled="#{!insuranceController.isInsuranceHasNextPage()}"
                           styleClass="btn btn-tertiary" />
          <h:commandButton value="Last"
                           action="#{insuranceController.setInsuranceFirst(
                                     insuranceController.patientInsuranceList.size()
                                     - (insuranceController.patientInsuranceList.size()
                                        mod insuranceController.insurancePageSize))}"
                           disabled="#{!insuranceController.isInsuranceHasNextPage()}"
                           styleClass="btn btn-tertiary" />
        </div>
      </div>

      <h:panelGroup rendered="#{insuranceController.cameFromPatientSearch and insuranceController.showInsuranceFlag}"
                    style="margin-top:20px;">
        <h:commandButton value="Back to Patient Lists"
                         action="#{insuranceController.backToPatients()}"
                         styleClass="btn btn-tertiary" />
      </h:panelGroup>
    </h:form>
  </h:panelGroup>
  <!-- Related Member Insurance Table -->
<h:panelGroup rendered="#{insuranceController.showRelatedInsuranceFlag}">
<h:form prependId="false">
    <h3>Related Member Insurance Details</h3>
    <h:dataTable value="#{insuranceController.relatedInsuranceList}" 
                 var="d" 
                 styleClass="data-table">
        
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
    
    <h:commandButton value="Back to Patient Lists"
                         action="#{insuranceController.backFromRelatedInsurance()}"
                         styleClass="btn btn-tertiary"
                         rendered="#{insuranceController.cameFromPatientSearch and insuranceController.showRelatedInsuranceFlag}"/>
     </h:form>
</h:panelGroup>
</body>
</html>
</f:view>