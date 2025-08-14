<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<f:view>
	<!DOCTYPE html>
	<html>
<head>
<meta charset="UTF-8">
<title>Procedure Logs</title>
<style>
body {
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background-color: #eef5f9;
	margin: 0;
	padding: 0;
	color: #34495e;
}

.dashboard-container {
	max-width: 1200px;
	margin: 130px auto;
	padding: 2rem;
	background-color: #fff;
	border-radius: 0.75rem;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
}

.dashboard-title {
	font-size: 22px;
	font-weight: bold;
	color: #2a3f54;
	margin-bottom: 1.5rem;
	text-align: center;
}

.summary-section {
	margin-bottom: 1.5rem;
	padding: 1rem 1.5rem;
	background-color: #f8f9fa;
	border-left: 4px solid #17a2b8;
	border-radius: 0.5rem;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
}

.summary-grid {
	display: flex;
	flex-wrap: wrap;
	gap: 1rem;
}

.summary-item {
	flex: 1 1 45%;
	font-size: 15px;
	color: #34495e;
}

.summary-item strong {
	color: #2a3f54;
}

.message-container {
text-align: center;
	margin-bottom: 1rem;
}

.message-container li {
	background-color: #ffe6e6;
	color: #c62828;
	padding: 0.5rem 1rem;
	margin-bottom: 0.5rem;
	border-radius: 0.5rem;
	font-weight: 600;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
	list-style-type: none;
}

.button-row {
	display: flex;
	justify-content: flex-end;
	gap: 0.5rem;
	margin-bottom: 1rem;
}

.action-button {
	padding: 5px 10px;
	font-size: 13px;
	font-weight: 600;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	transition: background-color 0.2s;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	margin: 2px;
}

.action-button.primary {
	background-color: #3f51b5;
	color: white;
}

.action-button.primary:hover {
	background-color: #303f9f;
}

.action-button.secondary {
	background-color: #6c757d;
	color: white;
}

.action-button.secondary:hover {
	background-color: #5a6268;
}

.data-table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
}

.data-table th, .data-table td {
	padding: 10px;
	text-align: left;
	border: 1px solid #ddd;
	font-size: 14px;
}

.data-table th {
	background-color: #3f51b5;
	color: white;
}

.data-table td {
	background-color: #fff;
	color: #333;
}

.data-table tr:nth-child(even) td {
	background-color: #f2f2f2;
}

.data-table tr:hover td {
	background-color: #e9e9e9;
}

.sort-icons {
	display: flex;
	flex-direction: column;
	margin-left: 6px;
}

.sort-icon {
	color: white;
	font-size: 0.7em;
	line-height: 1;
}

.sort-icon:hover {
	color: #c5cae9;
}

.pagination-controls {
	margin-top: 15px;
	text-align: center;
}

input.action-button.secondary:disabled, input.action-button.secondary[disabled]
	{
	opacity: 0.5;
	cursor: not-allowed;
	background-color: #f0f0f0;
	border-color: #b0bec5;
	color: #90a4ae;
}

@media ( max-width : 768px) {
	.dashboard-container {
		padding: 1rem;
		margin-top: 100px;
	}
	.summary-item {
		flex: 1 1 100%;
	}
	.data-table th, .data-table td {
		padding: 8px;
		font-size: 13px;
	}
	.action-button {
		padding: 4px 8px;
		font-size: 12px;
	}
	.button-row {
		justify-content: center;
		flex-wrap: wrap;
	}
}

.custom-search-btn {
	background-color: #4CAF50; /* green */
	color: white;
	border: none;
	padding: 6px 12px;
	border-radius: 4px;
	cursor: pointer;
}

.custom-search-btn:hover {
	background-color: #45a049;
}

.reset-btn {
	background-color: black; /* red */
	color: white;
	border: none;
	padding: 6px 12px;
	border-radius: 4px;
	cursor: pointer;
}

.reset-btn:hover {
	background-color: #d73833;
}
</style>
</head>
<body>
	<jsp:include page="/navbar/NavProvider.jsp" />
	<div class="dashboard-container">
		<div class="dashboard-title">Procedure Daily Logs</div>

		<h:panelGroup rendered="#{not empty procedureController.procedure}">
			<div class="summary-section">
				<div class="summary-grid">
					<div class="summary-item">
						<strong>Recipient Name:</strong>
						<h:outputText
							value="#{procedureController.procedure.recipient.firstName}" />
					</div>
					<div class="summary-item">
						<strong>Diagnosis:</strong>
						<h:outputText value="#{procedureController.procedure.diagnosis}" />
					</div>
					<div class="summary-item">
						<strong>Procedure Doctor:</strong>
						<h:outputText
							value="#{procedureController.procedure.doctor.doctorName}" />
					</div>
					<div class="summary-item">
						<strong>Procedure Start Date:</strong>
						<h:outputText value="#{procedureController.procedure.fromDate}">
							<f:convertDateTime pattern="dd MMM yyyy" />
						</h:outputText>
					</div>
				</div>
			</div>
		</h:panelGroup>
		<h:form prependId="false">
		<h:panelGroup
			rendered="#{not procedureController.firstLongterm and not empty procedureController.procedureLogs}"
			layout="block"
			style="display:flex; justify-content:flex-end; align-items:center; gap:10px; margin-bottom:15px;">

			<!-- Radio buttons -->
			<h:selectOneRadio value="#{procedureController.selectedLogType}"
				layout="lineDirection">
				<f:selectItem itemLabel="Current" itemValue="CURRENT" />
				<f:selectItem itemLabel="Previous" itemValue="PREVIOUS" />
			</h:selectOneRadio>

			<!-- Search button -->
			<h:commandButton value="Search"
				styleClass="action-button custom-search-btn"
				action="#{procedureController.filterLogs()}" />

			<!-- Reset button -->
			<h:commandButton value="Reset" styleClass="action-button reset-btn"
				action="#{procedureController.resetLogs()}" />
		</h:panelGroup>
			<div class="message-container">
				<h:messages globalOnly="true" layout="list" />
			</div>

			<!-- Top Right Buttons -->
			<div class="button-row">

				<h:commandButton value="Back" styleClass="action-button secondary"
					action="#{procedureController.backFromViewLogs()}" />
			</div>
			<h:panelGroup rendered="#{procedureController.showAll}">
				<h:outputText
					value="Total logs: #{procedureController.viewLogs.size()}"
					style="font-weight: bold; display: block; margin-bottom: 10px;" />

				<h:dataTable value="#{procedureController.getPaginatedLogs()}"
					var="log" styleClass="data-table" border="1">

					<h:column>
						<f:facet name="header">
							<h:panelGroup layout="block"
								style="display: flex; align-items: center;">
								<h:outputText value="Log ID" />
								<h:panelGroup styleClass="sort-icons">
									<h:commandLink
										action="#{procedureController.sortByAsc('logs','logId')}"
										rendered="#{!(procedureController.sortField eq 'logId' and procedureController.isAscending())}"
										styleClass="sort-icon">▲</h:commandLink>
									<h:commandLink
										action="#{procedureController.sortByDesc('logs','logId')}"
										rendered="#{!(procedureController.sortField eq 'logId' and not procedureController.isAscending())}"
										styleClass="sort-icon">▼</h:commandLink>
								</h:panelGroup>
							</h:panelGroup>
						</f:facet>
						<h:outputText value="#{log.logId}" />
					</h:column>

					<h:column>
						<f:facet name="header">
							<h:panelGroup layout="block"
								style="display: flex; align-items: center;">
								<h:outputText value="Procedure ID" />
								<h:panelGroup styleClass="sort-icons">
									<h:commandLink
										action="#{procedureController.sortByAsc('logs','procedureId')}"
										rendered="#{!(procedureController.sortField eq 'procedureId' and procedureController.isAscending())}"
										styleClass="sort-icon">▲</h:commandLink>
									<h:commandLink
										action="#{procedureController.sortByDesc('logs','procedureId')}"
										rendered="#{!(procedureController.sortField eq 'procedureId' and not procedureController.isAscending())}"
										styleClass="sort-icon">▼</h:commandLink>
								</h:panelGroup>
							</h:panelGroup>
						</f:facet>
						<h:outputText value="#{log.medicalProcedure.procedureId}" />
					</h:column>

					<h:column>
						<f:facet name="header">
							<h:panelGroup layout="block"
								style="display: flex; align-items: center;">
								<h:outputText value="Logged By" />
								<h:panelGroup styleClass="sort-icons">
									<h:commandLink
										action="#{procedureController.sortByAsc('logs','loggedDoctor')}"
										rendered="#{!(procedureController.sortField eq 'loggedDoctor' and procedureController.isAscending())}"
										styleClass="sort-icon">▲</h:commandLink>
									<h:commandLink
										action="#{procedureController.sortByDesc('logs','loggedDoctor')}"
										rendered="#{!(procedureController.sortField eq 'loggedDoctor' and not procedureController.isAscending())}"
										styleClass="sort-icon">▼</h:commandLink>
								</h:panelGroup>
							</h:panelGroup>
						</f:facet>
						<h:outputText value="#{log.loggedDoctor.doctorName}" />
					</h:column>

					<h:column>
						<f:facet name="header">
							<h:panelGroup layout="block"
								style="display: flex; align-items: center;">
								<h:outputText value="Log Date" />
								<h:panelGroup styleClass="sort-icons">
									<h:commandLink
										action="#{procedureController.sortByAsc('logs','logDate')}"
										rendered="#{!(procedureController.sortField eq 'logDate' and procedureController.isAscending())}"
										styleClass="sort-icon">▲</h:commandLink>
									<h:commandLink
										action="#{procedureController.sortByDesc('logs','logDate')}"
										rendered="#{!(procedureController.sortField eq 'logDate' and not procedureController.isAscending())}"
										styleClass="sort-icon">▼</h:commandLink>
								</h:panelGroup>
							</h:panelGroup>
						</f:facet>
						<h:outputText value="#{log.logDate}">
							<f:convertDateTime pattern="yyyy-MM-dd" />
						</h:outputText>
					</h:column>

					<h:column>
						<f:facet name="header">
							<h:panelGroup layout="block"
								style="display: flex; align-items: center;">
								<h:outputText value="Vitals" />
								<h:panelGroup styleClass="sort-icons">
									<h:commandLink
										action="#{procedureController.sortByAsc('logs','vitals')}"
										rendered="#{!(procedureController.sortField eq 'vitals' and procedureController.isAscending())}"
										styleClass="sort-icon">▲</h:commandLink>
									<h:commandLink
										action="#{procedureController.sortByDesc('logs','vitals')}"
										rendered="#{!(procedureController.sortField eq 'vitals' and not procedureController.isAscending())}"
										styleClass="sort-icon">▼</h:commandLink>
								</h:panelGroup>
							</h:panelGroup>
						</f:facet>
						<h:outputText value="#{log.vitals}" />
					</h:column>

					<h:column>
						<f:facet name="header">
							<h:panelGroup layout="block"
								style="display: flex; align-items: center;">
								<h:outputText value="Notes" />
								<h:panelGroup styleClass="sort-icons">
									<h:commandLink
										action="#{procedureController.sortByAsc('logs','notes')}"
										rendered="#{!(procedureController.sortField eq 'notes' and procedureController.isAscending())}"
										styleClass="sort-icon">▲</h:commandLink>
									<h:commandLink
										action="#{procedureController.sortByDesc('logs','notes')}"
										rendered="#{!(procedureController.sortField eq 'notes' and not procedureController.isAscending())}"
										styleClass="sort-icon">▼</h:commandLink>
								</h:panelGroup>
							</h:panelGroup>
						</f:facet>
						<h:outputText value="#{log.notes}" />
					</h:column>

					<h:column>
						<f:facet name="header">
							<h:outputText value="Action" />
						</f:facet>
						<h:commandButton value="Edit" styleClass="action-button primary"
							action="#{procedureController.editLog(log)}" />
					</h:column>
				</h:dataTable>

				<!-- Pagination Controls -->
				<div class="pagination-controls">
					<h:commandButton value="First"
						action="#{procedureController.setLogFirst(0)}"
						disabled="#{procedureController.logFirst == 0}"
						styleClass="action-button secondary" />

					<h:commandButton value="Previous"
						action="#{procedureController.previousLogPage()}"
						disabled="#{procedureController.logFirst == 0}"
						styleClass="action-button secondary" />

					<h:outputText
						value="Page #{procedureController.logCurrentPage} of #{procedureController.logTotalPages}"
						style="margin: 0 12px; font-weight:bold;" />

					<h:commandButton value="Next"
						action="#{procedureController.nextLogPage()}"
						disabled="#{!procedureController.isLogHasNextPage()}"
						styleClass="action-button secondary" />

					<h:commandButton value="Last"
						action="#{procedureController.setLogFirst((procedureController.logTotalPages - 1) * procedureController.logPageSize)}"
						disabled="#{!procedureController.isLogHasNextPage()}"
						styleClass="action-button secondary" />
				</div>
			</h:panelGroup>
			<h:panelGroup rendered="#{procedureController.showCurrent}">
			<h:outputText
				value="Current logs: #{procedureController.procedureLogs.size()}"
				style="font-weight: bold; display: block; margin-bottom: 10px;" />
				<h:dataTable value="#{procedureController.getPaginatedCurrentLogs()}"
					var="log" styleClass="data-table" border="1">

					<h:column>
						<f:facet name="header">
							<h:panelGroup layout="block"
								style="display: flex; align-items: center;">
								<h:outputText value="Log ID" />
								<h:panelGroup styleClass="sort-icons">
									<h:commandLink
										action="#{procedureController.sortByAsc('currentLogs','logId')}"
										rendered="#{!(procedureController.sortField eq 'logId' and procedureController.isAscending())}"
										styleClass="sort-icon">▲</h:commandLink>
									<h:commandLink
										action="#{procedureController.sortByDesc('currentLogs','logId')}"
										rendered="#{!(procedureController.sortField eq 'logId' and not procedureController.isAscending())}"
										styleClass="sort-icon">▼</h:commandLink>
								</h:panelGroup>
							</h:panelGroup>
						</f:facet>
						<h:outputText value="#{log.logId}" />
					</h:column>

					<h:column>
						<f:facet name="header">
							<h:panelGroup layout="block"
								style="display: flex; align-items: center;">
								<h:outputText value="Procedure ID" />
								<h:panelGroup styleClass="sort-icons">
									<h:commandLink
										action="#{procedureController.sortByAsc('currentLogs','procedureId')}"
										rendered="#{!(procedureController.sortField eq 'procedureId' and procedureController.isAscending())}"
										styleClass="sort-icon">▲</h:commandLink>
									<h:commandLink
										action="#{procedureController.sortByDesc('currentLogs','procedureId')}"
										rendered="#{!(procedureController.sortField eq 'procedureId' and not procedureController.isAscending())}"
										styleClass="sort-icon">▼</h:commandLink>
								</h:panelGroup>
							</h:panelGroup>
						</f:facet>
						<h:outputText value="#{log.medicalProcedure.procedureId}" />
					</h:column>

					<h:column>
						<f:facet name="header">
							<h:panelGroup layout="block"
								style="display: flex; align-items: center;">
								<h:outputText value="Logged By" />
								<h:panelGroup styleClass="sort-icons">
									<h:commandLink
										action="#{procedureController.sortByAsc('currentLogs','loggedDoctor')}"
										rendered="#{!(procedureController.sortField eq 'loggedDoctor' and procedureController.isAscending())}"
										styleClass="sort-icon">▲</h:commandLink>
									<h:commandLink
										action="#{procedureController.sortByDesc('currentLogs','loggedDoctor')}"
										rendered="#{!(procedureController.sortField eq 'loggedDoctor' and not procedureController.isAscending())}"
										styleClass="sort-icon">▼</h:commandLink>
								</h:panelGroup>
							</h:panelGroup>
						</f:facet>
						<h:outputText value="#{log.loggedDoctor.doctorName}" />
					</h:column>

					<h:column>
						<f:facet name="header">
							<h:panelGroup layout="block"
								style="display: flex; align-items: center;">
								<h:outputText value="Log Date" />
								<h:panelGroup styleClass="sort-icons">
									<h:commandLink
										action="#{procedureController.sortByAsc('currentLogs','logDate')}"
										rendered="#{!(procedureController.sortField eq 'logDate' and procedureController.isAscending())}"
										styleClass="sort-icon">▲</h:commandLink>
									<h:commandLink
										action="#{procedureController.sortByDesc('currentLogs','logDate')}"
										rendered="#{!(procedureController.sortField eq 'logDate' and not procedureController.isAscending())}"
										styleClass="sort-icon">▼</h:commandLink>
								</h:panelGroup>
							</h:panelGroup>
						</f:facet>
						<h:outputText value="#{log.logDate}">
							<f:convertDateTime pattern="yyyy-MM-dd" />
						</h:outputText>
					</h:column>

					<h:column>
						<f:facet name="header">
							<h:panelGroup layout="block"
								style="display: flex; align-items: center;">
								<h:outputText value="Vitals" />
								<h:panelGroup styleClass="sort-icons">
									<h:commandLink
										action="#{procedureController.sortByAsc('currentLogs','vitals')}"
										rendered="#{!(procedureController.sortField eq 'vitals' and procedureController.isAscending())}"
										styleClass="sort-icon">▲</h:commandLink>
									<h:commandLink
										action="#{procedureController.sortByDesc('currentLogs','vitals')}"
										rendered="#{!(procedureController.sortField eq 'vitals' and not procedureController.isAscending())}"
										styleClass="sort-icon">▼</h:commandLink>
								</h:panelGroup>
							</h:panelGroup>
						</f:facet>
						<h:outputText value="#{log.vitals}" />
					</h:column>

					<h:column>
						<f:facet name="header">
							<h:panelGroup layout="block"
								style="display: flex; align-items: center;">
								<h:outputText value="Notes" />
								<h:panelGroup styleClass="sort-icons">
									<h:commandLink
										action="#{procedureController.sortByAsc('currentLogs','notes')}"
										rendered="#{!(procedureController.sortField eq 'notes' and procedureController.isAscending())}"
										styleClass="sort-icon">▲</h:commandLink>
									<h:commandLink
										action="#{procedureController.sortByDesc('currentLogs','notes')}"
										rendered="#{!(procedureController.sortField eq 'notes' and not procedureController.isAscending())}"
										styleClass="sort-icon">▼</h:commandLink>
								</h:panelGroup>
							</h:panelGroup>
						</f:facet>
						<h:outputText value="#{log.notes}" />
					</h:column>

					<h:column>
						<f:facet name="header">
							<h:outputText value="Action" />
						</f:facet>
						<h:commandButton value="Edit" styleClass="action-button primary"
							action="#{procedureController.editLog(log)}" />
					</h:column>
				</h:dataTable>
				<!-- Pagination Controls -->
				<div class="pagination-controls">
					<h:commandButton value="First"
						action="#{procedureController.setCurrentLogsFirst(0)}"
						disabled="#{procedureController.currentLogsFirst == 0}"
						styleClass="action-button secondary" />

					<h:commandButton value="Previous"
						action="#{procedureController.previousCurrentLogsPage()}"
						disabled="#{procedureController.currentLogsFirst == 0}"
						styleClass="action-button secondary" />

					<h:outputText
						value="Page #{procedureController.currentLogsCurrentPage} of #{procedureController.currentLogsTotalPages}"
						style="margin: 0 12px; font-weight:bold;" />

					<h:commandButton value="Next"
						action="#{procedureController.nextCurrentLogsPage()}"
						disabled="#{!procedureController.isCurrentLogsHasNextPage()}"
						styleClass="action-button secondary" />

					<h:commandButton value="Last"
						action="#{procedureController.setCurrentLogsFirst((procedureController.currentLogsTotalPages - 1) * procedureController.currentLogsPageSize)}"
						disabled="#{!procedureController.isCurrentLogsHasNextPage()}"
						styleClass="action-button secondary" />
				</div>
			</h:panelGroup>
			<h:panelGroup rendered="#{procedureController.showPrevious}">
			<h:outputText
				value="Previous logs: #{procedureController.previousLogs.size()}"
				style="font-weight: bold; display: block; margin-bottom: 10px;" />
				<h:dataTable value="#{procedureController.getPaginatedPreviousLogs()}"
					var="log" styleClass="data-table" border="1">

					<h:column>
						<f:facet name="header">
							<h:panelGroup layout="block"
								style="display: flex; align-items: center;">
								<h:outputText value="Log ID" />
								<h:panelGroup styleClass="sort-icons">
									<h:commandLink
										action="#{procedureController.sortByAsc('previousLogs','logId')}"
										rendered="#{!(procedureController.sortField eq 'logId' and procedureController.isAscending())}"
										styleClass="sort-icon">▲</h:commandLink>
									<h:commandLink
										action="#{procedureController.sortByDesc('previousLogs','logId')}"
										rendered="#{!(procedureController.sortField eq 'logId' and not procedureController.isAscending())}"
										styleClass="sort-icon">▼</h:commandLink>
								</h:panelGroup>
							</h:panelGroup>
						</f:facet>
						<h:outputText value="#{log.logId}" />
					</h:column>

					<h:column>
						<f:facet name="header">
							<h:panelGroup layout="block"
								style="display: flex; align-items: center;">
								<h:outputText value="Procedure ID" />
								<h:panelGroup styleClass="sort-icons">
									<h:commandLink
										action="#{procedureController.sortByAsc('previousLogs','procedureId')}"
										rendered="#{!(procedureController.sortField eq 'procedureId' and procedureController.isAscending())}"
										styleClass="sort-icon">▲</h:commandLink>
									<h:commandLink
										action="#{procedureController.sortByDesc('previousLogs','procedureId')}"
										rendered="#{!(procedureController.sortField eq 'procedureId' and not procedureController.isAscending())}"
										styleClass="sort-icon">▼</h:commandLink>
								</h:panelGroup>
							</h:panelGroup>
						</f:facet>
						<h:outputText value="#{log.medicalProcedure.procedureId}" />
					</h:column>

					<h:column>
						<f:facet name="header">
							<h:panelGroup layout="block"
								style="display: flex; align-items: center;">
								<h:outputText value="Logged By" />
								<h:panelGroup styleClass="sort-icons">
									<h:commandLink
										action="#{procedureController.sortByAsc('previousLogs','loggedDoctor')}"
										rendered="#{!(procedureController.sortField eq 'loggedDoctor' and procedureController.isAscending())}"
										styleClass="sort-icon">▲</h:commandLink>
									<h:commandLink
										action="#{procedureController.sortByDesc('previousLogs','loggedDoctor')}"
										rendered="#{!(procedureController.sortField eq 'loggedDoctor' and not procedureController.isAscending())}"
										styleClass="sort-icon">▼</h:commandLink>
								</h:panelGroup>
							</h:panelGroup>
						</f:facet>
						<h:outputText value="#{log.loggedDoctor.doctorName}" />
					</h:column>

					<h:column>
						<f:facet name="header">
							<h:panelGroup layout="block"
								style="display: flex; align-items: center;">
								<h:outputText value="Log Date" />
								<h:panelGroup styleClass="sort-icons">
									<h:commandLink
										action="#{procedureController.sortByAsc('previousLogs','logDate')}"
										rendered="#{!(procedureController.sortField eq 'logDate' and procedureController.isAscending())}"
										styleClass="sort-icon">▲</h:commandLink>
									<h:commandLink
										action="#{procedureController.sortByDesc('previousLogs','logDate')}"
										rendered="#{!(procedureController.sortField eq 'logDate' and not procedureController.isAscending())}"
										styleClass="sort-icon">▼</h:commandLink>
								</h:panelGroup>
							</h:panelGroup>
						</f:facet>
						<h:outputText value="#{log.logDate}">
							<f:convertDateTime pattern="yyyy-MM-dd" />
						</h:outputText>
					</h:column>

					<h:column>
						<f:facet name="header">
							<h:panelGroup layout="block"
								style="display: flex; align-items: center;">
								<h:outputText value="Vitals" />
								<h:panelGroup styleClass="sort-icons">
									<h:commandLink
										action="#{procedureController.sortByAsc('previousLogs','vitals')}"
										rendered="#{!(procedureController.sortField eq 'vitals' and procedureController.isAscending())}"
										styleClass="sort-icon">▲</h:commandLink>
									<h:commandLink
										action="#{procedureController.sortByDesc('previousLogs','vitals')}"
										rendered="#{!(procedureController.sortField eq 'vitals' and not procedureController.isAscending())}"
										styleClass="sort-icon">▼</h:commandLink>
								</h:panelGroup>
							</h:panelGroup>
						</f:facet>
						<h:outputText value="#{log.vitals}" />
					</h:column>

					<h:column>
						<f:facet name="header">
							<h:panelGroup layout="block"
								style="display: flex; align-items: center;">
								<h:outputText value="Notes" />
								<h:panelGroup styleClass="sort-icons">
									<h:commandLink
										action="#{procedureController.sortByAsc('previousLogs','notes')}"
										rendered="#{!(procedureController.sortField eq 'notes' and procedureController.isAscending())}"
										styleClass="sort-icon">▲</h:commandLink>
									<h:commandLink
										action="#{procedureController.sortByDesc('previousLogs','notes')}"
										rendered="#{!(procedureController.sortField eq 'notes' and not procedureController.isAscending())}"
										styleClass="sort-icon">▼</h:commandLink>
								</h:panelGroup>
							</h:panelGroup>
						</f:facet>
						<h:outputText value="#{log.notes}" />
					</h:column>

					<h:column>
						<f:facet name="header">
							<h:outputText value="Action" />
						</f:facet>
						<h:commandButton value="Edit" styleClass="action-button primary"
							action="#{procedureController.editLog(log)}" />
					</h:column>
				</h:dataTable>
					<!-- Pagination Controls -->
				<div class="pagination-controls">
					<h:commandButton value="First"
						action="#{procedureController.setPreviousLogsFirst(0)}"
						disabled="#{procedureController.previousLogsFirst == 0}"
						styleClass="action-button secondary" />

					<h:commandButton value="Previous"
						action="#{procedureController.previousPreviousLogsPage()}"
						disabled="#{procedureController.previousLogsFirst == 0}"
						styleClass="action-button secondary" />

					<h:outputText
						value="Page #{procedureController.previousLogsCurrentPage} of #{procedureController.previousLogsTotalPages}"
						style="margin: 0 12px; font-weight:bold;" />

					<h:commandButton value="Next"
						action="#{procedureController.nextPreviousLogsPage()}"
						disabled="#{!procedureController.isPreviousLogsHasNextPage()}"
						styleClass="action-button secondary" />

					<h:commandButton value="Last"
						action="#{procedureController.setPreviousLogsFirst((procedureController.previousLogsTotalPages - 1) * procedureController.previousLogsPageSize)}"
						disabled="#{!procedureController.isPreviousLogsHasNextPage()}"
						styleClass="action-button secondary" />
				</div>
			</h:panelGroup>
		</h:form>
	</div>
</body>
	</html>
</f:view>