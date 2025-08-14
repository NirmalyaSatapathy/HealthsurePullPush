<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>

<f:view>
	<html>
<head>
<meta charset="UTF-8" />
<title>Patient Insurance Details</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/showInsuranceDetails.css" />
</head>

<body>
	<h2>Patient Insurance Details</h2>

	<!-- Search Form -->
	<h:form prependId="false">
		<div class="form-group">
			<label for="doctorId" escape="false"><span
				style="color: red;">*</span>Enter Doctor ID: </label>
			<h:inputText id="doctorId" value="#{insuranceController.doctorId}"
				styleClass="form-control" />
			<h:message for="doctorId" styleClass="error-message" />
		</div>

		<!-- Patient ID Field -->
		<div class="form-group">
			<label for="recipientId">Enter Patient ID (optional):</label>
			<h:inputText id="recipientId" value="#{insuranceController.healthId}"
				styleClass="form-control" />
			<h:message for="recipientId" styleClass="error-message" />
		</div>

		<!-- Insurance Type Under Patient ID -->
		<div class="form-group">
			<h:selectOneRadio id="insuranceType"
				value="#{insuranceController.insuranceType}" layout="lineDirection"
				styleClass="form-control">
				<f:selectItem itemLabel="Own" itemValue="own" />
				<f:selectItem itemLabel="Related as a member"
					itemValue="relatedAsAMember" />
			</h:selectOneRadio>
			<h:message for="insuranceType" styleClass="error-message" />
		</div>

		<!-- Patient Name Field -->
		<div class="form-group">
			<label for="patientName">Patient Name (optional):</label>
			<h:inputText id="patientName"
				value="#{insuranceController.patientName}" styleClass="form-control" />
			<h:message for="patientName" styleClass="error-message" />
		</div>

		<!-- Match Type Under Patient Name -->
		<div class="form-group">
			<h:selectOneRadio id="matchType"
				value="#{insuranceController.matchType}" layout="lineDirection"
				styleClass="form-control">
				<f:selectItem itemLabel="Starts With" itemValue="startsWith" />
				<f:selectItem itemLabel="Contains" itemValue="contains" />
			</h:selectOneRadio>
			<h:message for="matchType" styleClass="error-message" />
		</div>
		<div>
			<h:commandButton value="Search"
				action="#{insuranceController.handleSearch()}"
				styleClass="btn btn-primary" />
			<h:commandButton value="Reset"
				action="#{insuranceController.resetPage()}" immediate="true"
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
			<h:outputText
				value="Total Associated Patients: #{insuranceController.associatedPatients.size()}"
				style="font-weight:bold; display:block; margin-top:20px;" />
			<h:dataTable
				value="#{insuranceController.getPaginatedAssociatedPatients()}"
				var="patient" styleClass="data-table">
				<!-- Health ID Column -->
				<h:column>
					<f:facet name="header">
						<h:panelGroup layout="block"
							style="display: flex; align-items: center;">
							<h:outputText value="Health ID" />
							<h:panelGroup styleClass="sort-icons">
								<h:commandLink
									action="#{insuranceController.sortByAsc('patients','hId')}"
									rendered="#{!(insuranceController.sortField eq 'hId' and insuranceController.isAscending())}"
									styleClass="sort-icon">▲</h:commandLink>
								<h:commandLink
									action="#{insuranceController.sortByDesc('patients','hId')}"
									rendered="#{!(insuranceController.sortField eq 'hId' and not insuranceController.isAscending())}"
									styleClass="sort-icon">▼</h:commandLink>
							</h:panelGroup>
						</h:panelGroup>
					</f:facet>
					<h:outputText value="#{patient.hId}" />
				</h:column>
				<!-- User Name Column -->
				<h:column>
					<f:facet name="header">
						<h:panelGroup layout="block"
							style="display: flex; align-items: center;">
							<h:outputText value="User Name" />
							<h:panelGroup styleClass="sort-icons">
								<h:commandLink
									action="#{insuranceController.sortByAsc('patients','userName')}"
									rendered="#{!(insuranceController.sortField eq 'userName' and insuranceController.isAscending())}"
									styleClass="sort-icon">▲</h:commandLink>
								<h:commandLink
									action="#{insuranceController.sortByDesc('patients','userName')}"
									rendered="#{!(insuranceController.sortField eq 'userName' and not insuranceController.isAscending())}"
									styleClass="sort-icon">▼</h:commandLink>
							</h:panelGroup>
						</h:panelGroup>
					</f:facet>
					<h:outputText value="#{patient.userName}" />
				</h:column>
				<!-- First Name Column -->
				<h:column>
					<f:facet name="header">
						<h:panelGroup layout="block"
							style="display: flex; align-items: center;">
							<h:outputText value="First Name" />
							<h:panelGroup styleClass="sort-icons">
								<h:commandLink
									action="#{insuranceController.sortByAsc('patients','firstName')}"
									rendered="#{!(insuranceController.sortField eq 'firstName' and insuranceController.isAscending())}"
									styleClass="sort-icon">▲</h:commandLink>
								<h:commandLink
									action="#{insuranceController.sortByDesc('patients','firstName')}"
									rendered="#{!(insuranceController.sortField eq 'firstName' and not insuranceController.isAscending())}"
									styleClass="sort-icon">▼</h:commandLink>
							</h:panelGroup>
						</h:panelGroup>
					</f:facet>
					<h:outputText value="#{patient.firstName}" />
				</h:column>
				<!-- Last Name Column -->
				<h:column>
					<f:facet name="header">
						<h:panelGroup layout="block"
							style="display: flex; align-items: center;">
							<h:outputText value="Last Name" />
							<h:panelGroup styleClass="sort-icons">
								<h:commandLink
									action="#{insuranceController.sortByAsc('patients','lastName')}"
									rendered="#{!(insuranceController.sortField eq 'lastName' and insuranceController.isAscending())}"
									styleClass="sort-icon">▲</h:commandLink>
								<h:commandLink
									action="#{insuranceController.sortByDesc('patients','lastName')}"
									rendered="#{!(insuranceController.sortField eq 'lastName' and not insuranceController.isAscending())}"
									styleClass="sort-icon">▼</h:commandLink>
							</h:panelGroup>
						</h:panelGroup>
					</f:facet>
					<h:outputText value="#{patient.lastName}" />
				</h:column>
				<!-- Show Insurance Column (no sorting) -->
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
			<!-- Pagination controls remain unchanged -->
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
					<h:outputText
						value="Page #{insuranceController.associatedPatientsCurrentPage}
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
			<h:outputText
				value="Total Insurance Records: #{insuranceController.patientInsuranceList.size()}"
				style="font-weight:bold; display:block; margin-top:20px;" />

			<h:dataTable
				value="#{insuranceController.getPaginatedInsuranceList()}"
				var="insurance" styleClass="data-table">

				<!-- Patient Name Column -->
				<h:column>
					<f:facet name="header">
						<h:panelGroup layout="block"
							style="display: flex; align-items: center;">
							<h:outputText value="Patient Name" />
							<h:panelGroup styleClass="sort-icons">
								<h:commandLink
									action="#{insuranceController.sortByAsc('insurance','patientName')}"
									rendered="#{!(insuranceController.sortField eq 'patientName' and insuranceController.isAscending())}"
									styleClass="sort-icon">▲</h:commandLink>
								<h:commandLink
									action="#{insuranceController.sortByDesc('insurance','patientName')}"
									rendered="#{!(insuranceController.sortField eq 'patientName' and not insuranceController.isAscending())}"
									styleClass="sort-icon">▼</h:commandLink>
							</h:panelGroup>
						</h:panelGroup>
					</f:facet>
					<h:outputText value="#{insurance.patientName}" />
				</h:column>

				<!-- Company Name Column -->
				<h:column>
					<f:facet name="header">
						<h:panelGroup layout="block"
							style="display: flex; align-items: center;">
							<h:outputText value="Company Name" />
							<h:panelGroup styleClass="sort-icons">
								<h:commandLink
									action="#{insuranceController.sortByAsc('insurance','companyName')}"
									rendered="#{!(insuranceController.sortField eq 'companyName' and insuranceController.isAscending())}"
									styleClass="sort-icon">▲</h:commandLink>
								<h:commandLink
									action="#{insuranceController.sortByDesc('insurance','companyName')}"
									rendered="#{!(insuranceController.sortField eq 'companyName' and not insuranceController.isAscending())}"
									styleClass="sort-icon">▼</h:commandLink>
							</h:panelGroup>
						</h:panelGroup>
					</f:facet>
					<h:outputText value="#{insurance.companyName}" />
				</h:column>

				<!-- Plan Name Column -->
				<h:column>
					<f:facet name="header">
						<h:panelGroup layout="block"
							style="display: flex; align-items: center;">
							<h:outputText value="Plan Name" />
							<h:panelGroup styleClass="sort-icons">
								<h:commandLink
									action="#{insuranceController.sortByAsc('insurance','planName')}"
									rendered="#{!(insuranceController.sortField eq 'planName' and insuranceController.isAscending())}"
									styleClass="sort-icon">▲</h:commandLink>
								<h:commandLink
									action="#{insuranceController.sortByDesc('insurance','planName')}"
									rendered="#{!(insuranceController.sortField eq 'planName' and not insuranceController.isAscending())}"
									styleClass="sort-icon">▼</h:commandLink>
							</h:panelGroup>
						</h:panelGroup>
					</f:facet>
					<h:outputText value="#{insurance.planName}" />
				</h:column>


				<!-- Enrollment Date Column -->
				<h:column>
					<f:facet name="header">
						<h:panelGroup layout="block"
							style="display: flex; align-items: center;">
							<h:outputText value="Enrollment Date" />
							<h:panelGroup styleClass="sort-icons">
								<h:commandLink
									action="#{insuranceController.sortByAsc('insurance','enrollmentDate')}"
									rendered="#{!(insuranceController.sortField eq 'enrollmentDate' and insuranceController.isAscending())}"
									styleClass="sort-icon">▲</h:commandLink>
								<h:commandLink
									action="#{insuranceController.sortByDesc('insurance','enrollmentDate')}"
									rendered="#{!(insuranceController.sortField eq 'enrollmentDate' and not insuranceController.isAscending())}"
									styleClass="sort-icon">▼</h:commandLink>
							</h:panelGroup>
						</h:panelGroup>
					</f:facet>
					<h:outputText value="#{insurance.enrollmentDate}">
						<f:convertDateTime pattern="yyyy-MM-dd" />
					</h:outputText>
				</h:column>

				<!-- Coverage Start Column -->
				<h:column>
					<f:facet name="header">
						<h:panelGroup layout="block"
							style="display: flex; align-items: center;">
							<h:outputText value="Coverage Start" />
							<h:panelGroup styleClass="sort-icons">
								<h:commandLink
									action="#{insuranceController.sortByAsc('insurance','coverageStartDate')}"
									rendered="#{!(insuranceController.sortField eq 'coverageStartDate' and insuranceController.isAscending())}"
									styleClass="sort-icon">▲</h:commandLink>
								<h:commandLink
									action="#{insuranceController.sortByDesc('insurance','coverageStartDate')}"
									rendered="#{!(insuranceController.sortField eq 'coverageStartDate' and not insuranceController.isAscending())}"
									styleClass="sort-icon">▼</h:commandLink>
							</h:panelGroup>
						</h:panelGroup>
					</f:facet>
					<h:outputText value="#{insurance.coverageStartDate}">
						<f:convertDateTime pattern="yyyy-MM-dd" />
					</h:outputText>
				</h:column>

				<!-- Coverage End Column -->
				<h:column>
					<f:facet name="header">
						<h:panelGroup layout="block"
							style="display: flex; align-items: center;">
							<h:outputText value="Coverage End" />
							<h:panelGroup styleClass="sort-icons">
								<h:commandLink
									action="#{insuranceController.sortByAsc('insurance','coverageEndDate')}"
									rendered="#{!(insuranceController.sortField eq 'coverageEndDate' and insuranceController.isAscending())}"
									styleClass="sort-icon">▲</h:commandLink>
								<h:commandLink
									action="#{insuranceController.sortByDesc('insurance','coverageEndDate')}"
									rendered="#{!(insuranceController.sortField eq 'coverageEndDate' and not insuranceController.isAscending())}"
									styleClass="sort-icon">▼</h:commandLink>
							</h:panelGroup>
						</h:panelGroup>
					</f:facet>
					<h:outputText value="#{insurance.coverageEndDate}">
						<f:convertDateTime pattern="yyyy-MM-dd" />
					</h:outputText>
				</h:column>

				<!-- Coverage Type Column -->
				<h:column>
					<f:facet name="header">
						<h:panelGroup layout="block"
							style="display: flex; align-items: center;">
							<h:outputText value="Coverage Type" />
							<h:panelGroup styleClass="sort-icons">
								<h:commandLink
									action="#{insuranceController.sortByAsc('insurance','coverageType')}"
									rendered="#{!(insuranceController.sortField eq 'coverageType' and insuranceController.isAscending())}"
									styleClass="sort-icon">▲</h:commandLink>
								<h:commandLink
									action="#{insuranceController.sortByDesc('insurance','coverageType')}"
									rendered="#{!(insuranceController.sortField eq 'coverageType' and not insuranceController.isAscending())}"
									styleClass="sort-icon">▼</h:commandLink>
							</h:panelGroup>
						</h:panelGroup>
					</f:facet>
					<h:outputText value="#{insurance.coverageType}" />
				</h:column>

				<!-- Status Column -->
				<h:column>
					<f:facet name="header">
						<h:panelGroup layout="block"
							style="display: flex; align-items: center;">
							<h:outputText value="Status" />
							<h:panelGroup styleClass="sort-icons">
								<h:commandLink
									action="#{insuranceController.sortByAsc('insurance','coverageStatus')}"
									rendered="#{!(insuranceController.sortField eq 'coverageStatus' and insuranceController.isAscending())}"
									styleClass="sort-icon">▲</h:commandLink>
								<h:commandLink
									action="#{insuranceController.sortByDesc('insurance','coverageStatus')}"
									rendered="#{!(insuranceController.sortField eq 'coverageStatus' and not insuranceController.isAscending())}"
									styleClass="sort-icon">▼</h:commandLink>
							</h:panelGroup>
						</h:panelGroup>
					</f:facet>
					<h:outputText value="#{insurance.coverageStatus}" />
				</h:column>

				<!-- Coverage Limit Column -->
				<h:column>
					<f:facet name="header">
						<h:panelGroup layout="block"
							style="display: flex; align-items: center;">
							<h:outputText value="Coverage Limit" />
							<h:panelGroup styleClass="sort-icons">
								<h:commandLink
									action="#{insuranceController.sortByAsc('insurance','coverageLimit')}"
									rendered="#{!(insuranceController.sortField eq 'coverageLimit' and insuranceController.isAscending())}"
									styleClass="sort-icon">▲</h:commandLink>
								<h:commandLink
									action="#{insuranceController.sortByDesc('insurance','coverageLimit')}"
									rendered="#{!(insuranceController.sortField eq 'coverageLimit' and not insuranceController.isAscending())}"
									styleClass="sort-icon">▼</h:commandLink>
							</h:panelGroup>
						</h:panelGroup>
					</f:facet>
					<h:outputText value="#{insurance.coverageLimit}" />
				</h:column>

				<!-- Remaining Amount Column -->
				<h:column>
					<f:facet name="header">
						<h:panelGroup layout="block"
							style="display: flex; align-items: center;">
							<h:outputText value="Remaining Amount" />
							<h:panelGroup styleClass="sort-icons">
								<h:commandLink
									action="#{insuranceController.sortByAsc('insurance','remaining')}"
									rendered="#{!(insuranceController.sortField eq 'remaining' and insuranceController.isAscending())}"
									styleClass="sort-icon">▲</h:commandLink>
								<h:commandLink
									action="#{insuranceController.sortByDesc('insurance','remaining')}"
									rendered="#{!(insuranceController.sortField eq 'remaining' and not insuranceController.isAscending())}"
									styleClass="sort-icon">▼</h:commandLink>
							</h:panelGroup>
						</h:panelGroup>
					</f:facet>
					<h:outputText value="#{insurance.remaining}" />
				</h:column>

				<!-- Claimed Amount Column -->
				<h:column>
					<f:facet name="header">
						<h:panelGroup layout="block"
							style="display: flex; align-items: center;">
							<h:outputText value="Claimed Amount" />
							<h:panelGroup styleClass="sort-icons">
								<h:commandLink
									action="#{insuranceController.sortByAsc('insurance','claimed')}"
									rendered="#{!(insuranceController.sortField eq 'claimed' and insuranceController.isAscending())}"
									styleClass="sort-icon">▲</h:commandLink>
								<h:commandLink
									action="#{insuranceController.sortByDesc('insurance','claimed')}"
									rendered="#{!(insuranceController.sortField eq 'claimed' and not insuranceController.isAscending())}"
									styleClass="sort-icon">▼</h:commandLink>
							</h:panelGroup>
						</h:panelGroup>
					</f:facet>
					<h:outputText value="#{insurance.claimed}" />
				</h:column>

				<!-- Last Claim Date Column -->
				<h:column>
					<f:facet name="header">
						<h:panelGroup layout="block"
							style="display: flex; align-items: center;">
							<h:outputText value="Last Claim Date" />
							<h:panelGroup styleClass="sort-icons">
								<h:commandLink
									action="#{insuranceController.sortByAsc('insurance','lastClaimDate')}"
									rendered="#{!(insuranceController.sortField eq 'lastClaimDate' and insuranceController.isAscending())}"
									styleClass="sort-icon">▲</h:commandLink>
								<h:commandLink
									action="#{insuranceController.sortByDesc('insurance','lastClaimDate')}"
									rendered="#{!(insuranceController.sortField eq 'lastClaimDate' and not insuranceController.isAscending())}"
									styleClass="sort-icon">▼</h:commandLink>
							</h:panelGroup>
						</h:panelGroup>
					</f:facet>
					<h:outputText value="#{insurance.lastClaimDate}">
						<f:convertDateTime pattern="yyyy-MM-dd" />
					</h:outputText>
				</h:column>

				<!-- Action Column (no sorting) -->
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
					<h:outputText
						value="Page #{insuranceController.insuranceCurrentPage}
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

			<h:panelGroup
				rendered="#{insuranceController.cameFromPatientSearch and insuranceController.showInsuranceFlag}"
				style="margin-top:20px;">
				<h:commandButton value="Back to Patient Lists"
					action="#{insuranceController.backToPatients()}"
					styleClass="btn btn-tertiary" />
			</h:panelGroup>
		</h:form>
	</h:panelGroup>
	<!-- Related Member Insurance Table -->
	<h:panelGroup
		rendered="#{insuranceController.showRelatedInsuranceFlag}">
		<h:form prependId="false">
			<h3>Related Member Insurance Details</h3>
			<h:outputText
				value="Total related insurance Records: #{insuranceController.relatedInsuranceList.size()}"
				style="font-weight:bold; display:block; margin-top:20px;" />
			<!-- Data Table -->
			<h:dataTable
				value="#{insuranceController.paginatedRelatedInsuranceList}" var="d"
				styleClass="data-table">
				<!-- Full Name -->
				<h:column>
					<f:facet name="header">
						<h:panelGroup layout="block"
							style="display: flex; align-items: center;">
							<h:outputText value="Full Name" />
							<h:panelGroup styleClass="sort-icons">
								<h:commandLink
									action="#{insuranceController.sortByAsc('related','memberName')}"
									rendered="#{!(insuranceController.sortField eq 'memberName' and insuranceController.isAscending())}"
									styleClass="sort-icon">▲</h:commandLink>
								<h:commandLink
									action="#{insuranceController.sortByDesc('related','memberName')}"
									rendered="#{!(insuranceController.sortField eq 'memberName' and not insuranceController.isAscending())}"
									styleClass="sort-icon">▼</h:commandLink>
							</h:panelGroup>
						</h:panelGroup>
					</f:facet>
					<h:outputText value="#{d.memberName}" />
				</h:column>

				<!-- Age -->
				<h:column>
					<f:facet name="header">
						<h:panelGroup layout="block"
							style="display: flex; align-items: center;">
							<h:outputText value="Age" />
							<h:panelGroup styleClass="sort-icons">
								<h:commandLink
									action="#{insuranceController.sortByAsc('related','memberAge')}"
									rendered="#{!(insuranceController.sortField eq 'memberAge' and insuranceController.isAscending())}"
									styleClass="sort-icon">▲</h:commandLink>
								<h:commandLink
									action="#{insuranceController.sortByDesc('related','memberAge')}"
									rendered="#{!(insuranceController.sortField eq 'memberAge' and not insuranceController.isAscending())}"
									styleClass="sort-icon">▼</h:commandLink>
							</h:panelGroup>
						</h:panelGroup>
					</f:facet>
					<h:outputText value="#{d.memberAge}" />
				</h:column>

				<!-- Gender -->
				<h:column>
					<f:facet name="header">
						<h:panelGroup layout="block"
							style="display: flex; align-items: center;">
							<h:outputText value="Gender" />
							<h:panelGroup styleClass="sort-icons">
								<h:commandLink
									action="#{insuranceController.sortByAsc('related','memberGender')}"
									rendered="#{!(insuranceController.sortField eq 'memberGender' and insuranceController.isAscending())}"
									styleClass="sort-icon">▲</h:commandLink>
								<h:commandLink
									action="#{insuranceController.sortByDesc('related','memberGender')}"
									rendered="#{!(insuranceController.sortField eq 'memberGender' and not insuranceController.isAscending())}"
									styleClass="sort-icon">▼</h:commandLink>
							</h:panelGroup>
						</h:panelGroup>
					</f:facet>
					<h:outputText value="#{d.memberGender}" />
				</h:column>

				<!-- Relation -->
				<h:column>
					<f:facet name="header">
						<h:panelGroup layout="block"
							style="display: flex; align-items: center;">
							<h:outputText value="Relation" />
							<h:panelGroup styleClass="sort-icons">
								<h:commandLink
									action="#{insuranceController.sortByAsc('related','relationWithProposer')}"
									rendered="#{!(insuranceController.sortField eq 'relationWithProposer' and insuranceController.isAscending())}"
									styleClass="sort-icon">▲</h:commandLink>
								<h:commandLink
									action="#{insuranceController.sortByDesc('related','relationWithProposer')}"
									rendered="#{!(insuranceController.sortField eq 'relationWithProposer' and not insuranceController.isAscending())}"
									styleClass="sort-icon">▼</h:commandLink>
							</h:panelGroup>
						</h:panelGroup>
					</f:facet>
					<h:outputText value="#{d.relationWithProposer}" />
				</h:column>

				<!-- Subscribed By -->
				<h:column>
					<f:facet name="header">
						<h:panelGroup layout="block"
							style="display: flex; align-items: center;">
							<h:outputText value="Subscribed By" />
							<h:panelGroup styleClass="sort-icons">
								<h:commandLink
									action="#{insuranceController.sortByAsc('related','proposerName')}"
									rendered="#{!(insuranceController.sortField eq 'proposerName' and insuranceController.isAscending())}"
									styleClass="sort-icon">▲</h:commandLink>
								<h:commandLink
									action="#{insuranceController.sortByDesc('related','proposerName')}"
									rendered="#{!(insuranceController.sortField eq 'proposerName' and not insuranceController.isAscending())}"
									styleClass="sort-icon">▼</h:commandLink>
							</h:panelGroup>
						</h:panelGroup>
					</f:facet>
					<h:outputText value="#{d.proposerName}" />
				</h:column>

				<!-- Company -->
				<h:column>
					<f:facet name="header">
						<h:panelGroup layout="block"
							style="display: flex; align-items: center;">
							<h:outputText value="Company" />
							<h:panelGroup styleClass="sort-icons">
								<h:commandLink
									action="#{insuranceController.sortByAsc('related','companyName')}"
									rendered="#{!(insuranceController.sortField eq 'companyName' and insuranceController.isAscending())}"
									styleClass="sort-icon">▲</h:commandLink>
								<h:commandLink
									action="#{insuranceController.sortByDesc('related','companyName')}"
									rendered="#{!(insuranceController.sortField eq 'companyName' and not insuranceController.isAscending())}"
									styleClass="sort-icon">▼</h:commandLink>
							</h:panelGroup>
						</h:panelGroup>
					</f:facet>
					<h:outputText value="#{d.companyName}" />
				</h:column>

				<!-- Plan -->
				<h:column>
					<f:facet name="header">
						<h:panelGroup layout="block"
							style="display: flex; align-items: center;">
							<h:outputText value="Plan" />
							<h:panelGroup styleClass="sort-icons">
								<h:commandLink
									action="#{insuranceController.sortByAsc('related','planName')}"
									rendered="#{!(insuranceController.sortField eq 'planName' and insuranceController.isAscending())}"
									styleClass="sort-icon">▲</h:commandLink>
								<h:commandLink
									action="#{insuranceController.sortByDesc('related','planName')}"
									rendered="#{!(insuranceController.sortField eq 'planName' and not insuranceController.isAscending())}"
									styleClass="sort-icon">▼</h:commandLink>
							</h:panelGroup>
						</h:panelGroup>
					</f:facet>
					<h:outputText value="#{d.planName}" />
				</h:column>
				<!-- Subscribe Date -->
				<h:column>
					<f:facet name="header">
						<h:panelGroup layout="block"
							style="display: flex; align-items: center;">
							<h:outputText value="Subscribe Date" />
							<h:panelGroup styleClass="sort-icons">
								<h:commandLink
									action="#{insuranceController.sortByAsc('related','enrollmentDate')}"
									rendered="#{!(insuranceController.sortField eq 'enrollmentDate' and insuranceController.isAscending())}"
									styleClass="sort-icon">▲</h:commandLink>
								<h:commandLink
									action="#{insuranceController.sortByDesc('related','enrollmentDate')}"
									rendered="#{!(insuranceController.sortField eq 'enrollmentDate' and not insuranceController.isAscending())}"
									styleClass="sort-icon">▼</h:commandLink>
							</h:panelGroup>
						</h:panelGroup>
					</f:facet>
					<h:outputText value="#{d.enrollmentDate}">
						<f:convertDateTime pattern="yyyy-MM-dd" />
					</h:outputText>
				</h:column>

				<!-- Coverage Start -->
				<h:column>
					<f:facet name="header">
						<h:panelGroup layout="block"
							style="display: flex; align-items: center;">
							<h:outputText value="Coverage Start" />
							<h:panelGroup styleClass="sort-icons">
								<h:commandLink
									action="#{insuranceController.sortByAsc('related','coverageStartDate')}"
									rendered="#{!(insuranceController.sortField eq 'coverageStartDate' and insuranceController.isAscending())}"
									styleClass="sort-icon">▲</h:commandLink>
								<h:commandLink
									action="#{insuranceController.sortByDesc('related','coverageStartDate')}"
									rendered="#{!(insuranceController.sortField eq 'coverageStartDate' and not insuranceController.isAscending())}"
									styleClass="sort-icon">▼</h:commandLink>
							</h:panelGroup>
						</h:panelGroup>
					</f:facet>
					<h:outputText value="#{d.coverageStartDate}">
						<f:convertDateTime pattern="yyyy-MM-dd" />
					</h:outputText>
				</h:column>

				<!-- Coverage End -->
				<h:column>
					<f:facet name="header">
						<h:panelGroup layout="block"
							style="display: flex; align-items: center;">
							<h:outputText value="Coverage End" />
							<h:panelGroup styleClass="sort-icons">
								<h:commandLink
									action="#{insuranceController.sortByAsc('related','coverageEndDate')}"
									rendered="#{!(insuranceController.sortField eq 'coverageEndDate' and insuranceController.isAscending())}"
									styleClass="sort-icon">▲</h:commandLink>
								<h:commandLink
									action="#{insuranceController.sortByDesc('related','coverageEndDate')}"
									rendered="#{!(insuranceController.sortField eq 'coverageEndDate' and not insuranceController.isAscending())}"
									styleClass="sort-icon">▼</h:commandLink>
							</h:panelGroup>
						</h:panelGroup>
					</f:facet>
					<h:outputText value="#{d.coverageEndDate}">
						<f:convertDateTime pattern="yyyy-MM-dd" />
					</h:outputText>
				</h:column>

				<!-- Coverage Amount -->
				<h:column>
					<f:facet name="header">
						<h:panelGroup layout="block"
							style="display: flex; align-items: center;">
							<h:outputText value="Coverage Amount" />
							<h:panelGroup styleClass="sort-icons">
								<h:commandLink
									action="#{insuranceController.sortByAsc('related','coverageLimit')}"
									rendered="#{!(insuranceController.sortField eq 'coverageLimit' and insuranceController.isAscending())}"
									styleClass="sort-icon">▲</h:commandLink>
								<h:commandLink
									action="#{insuranceController.sortByDesc('related','coverageLimit')}"
									rendered="#{!(insuranceController.sortField eq 'coverageLimit' and not insuranceController.isAscending())}"
									styleClass="sort-icon">▼</h:commandLink>
							</h:panelGroup>
						</h:panelGroup>
					</f:facet>
					<h:outputText value="#{d.coverageLimit}" />
				</h:column>

				<!-- Remaining Amount -->
				<h:column>
					<f:facet name="header">
						<h:panelGroup layout="block"
							style="display: flex; align-items: center;">
							<h:outputText value="Remaining Amount" />
							<h:panelGroup styleClass="sort-icons">
								<h:commandLink
									action="#{insuranceController.sortByAsc('related','remaining')}"
									rendered="#{!(insuranceController.sortField eq 'remaining' and insuranceController.isAscending())}"
									styleClass="sort-icon">▲</h:commandLink>
								<h:commandLink
									action="#{insuranceController.sortByDesc('related','remaining')}"
									rendered="#{!(insuranceController.sortField eq 'remaining' and not insuranceController.isAscending())}"
									styleClass="sort-icon">▼</h:commandLink>
							</h:panelGroup>
						</h:panelGroup>
					</f:facet>
					<h:outputText value="#{d.remaining}" />
				</h:column>

				<!-- Total Claimed -->
				<h:column>
					<f:facet name="header">
						<h:panelGroup layout="block"
							style="display: flex; align-items: center;">
							<h:outputText value="Total Claimed" />
							<h:panelGroup styleClass="sort-icons">
								<h:commandLink
									action="#{insuranceController.sortByAsc('related','claimed')}"
									rendered="#{!(insuranceController.sortField eq 'claimed' and insuranceController.isAscending())}"
									styleClass="sort-icon">▲</h:commandLink>
								<h:commandLink
									action="#{insuranceController.sortByDesc('related','claimed')}"
									rendered="#{!(insuranceController.sortField eq 'claimed' and not insuranceController.isAscending())}"
									styleClass="sort-icon">▼</h:commandLink>
							</h:panelGroup>
						</h:panelGroup>
					</f:facet>
					<h:outputText value="#{d.claimed}" />
				</h:column>

				<!-- Last Claim Date -->
				<h:column>
					<f:facet name="header">
						<h:panelGroup layout="block"
							style="display: flex; align-items: center;">
							<h:outputText value="Last Claim Date" />
							<h:panelGroup styleClass="sort-icons">
								<h:commandLink
									action="#{insuranceController.sortByAsc('related','lastClaimDate')}"
									rendered="#{!(insuranceController.sortField eq 'lastClaimDate' and insuranceController.isAscending())}"
									styleClass="sort-icon">▲</h:commandLink>
								<h:commandLink
									action="#{insuranceController.sortByDesc('related','lastClaimDate')}"
									rendered="#{!(insuranceController.sortField eq 'lastClaimDate' and not insuranceController.isAscending())}"
									styleClass="sort-icon">▼</h:commandLink>
							</h:panelGroup>
						</h:panelGroup>
					</f:facet>
					<h:outputText value="#{d.lastClaimDate}">
						<f:convertDateTime pattern="yyyy-MM-dd" />
					</h:outputText>
				</h:column>
			</h:dataTable>

			<!-- Updated Pagination Controls -->
			<div class="pagination-group">
				<div>
					<h:commandButton value="First"
						action="#{insuranceController.setRelatedFirst(0)}"
						disabled="#{insuranceController.relatedFirst == 0}"
						styleClass="btn btn-tertiary" />
					<h:commandButton value="Previous"
						action="#{insuranceController.previousRelatedPage()}"
						disabled="#{insuranceController.relatedFirst == 0}"
						styleClass="btn btn-tertiary" />
				</div>
				<div>
					<h:outputText
						value="Page #{insuranceController.getRelatedCurrentPage()} of #{insuranceController.getRelatedTotalPages()}" />

				</div>
				<div>
					<h:commandButton value="Next"
						action="#{insuranceController.nextRelatedPage()}"
						disabled="#{!insuranceController.isNextRelatedAvailable()}"
						styleClass="btn btn-tertiary" />
					<h:commandButton value="Last"
						action="#{insuranceController.setRelatedFirst( 
              (insuranceController.relatedInsuranceList.size() 
               - (insuranceController.relatedInsuranceList.size() 
                  mod insuranceController.relatedPageSize)))}"
						disabled="#{insuranceController.relatedFirst + insuranceController.relatedPageSize >= insuranceController.relatedInsuranceList.size()}"
						styleClass="btn btn-tertiary" />
				</div>
			</div>

			<!-- Back button if needed -->
			<h:panelGroup rendered="#{insuranceController.cameFromPatientSearch}"
				style="margin-top:20px;">
				<h:commandButton value="Back to Patient Lists"
					action="#{insuranceController.backToPatients()}"
					styleClass="btn btn-tertiary" />
			</h:panelGroup>
		</h:form>
	</h:panelGroup>
</body>
	</html>
</f:view>