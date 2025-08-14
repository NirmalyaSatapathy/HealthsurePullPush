<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<f:view>
	<html>
<head>
<title>Edit Prescription</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/EditLastPrescription.css" />
<!-- Disable caching -->
<meta http-equiv="Cache-Control"
	content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />

<script type="text/javascript">
	window
			.addEventListener(
					'pageshow',
					function(event) {
						var navEntries = performance.getEntriesByType
								&& performance.getEntriesByType("navigation");
						var navType = navEntries && navEntries.length ? navEntries[0].type
								: "";
						if (event.persisted || navType === "back_forward") {
							document.querySelectorAll('.error').forEach(
									function(el) {
										el.textContent = '';
									});
						}
					});
</script>

</head>

<body>
	<div class="page-wrapper">
		<jsp:include page="/navbar/NavProvider.jsp" />

		<div class="main-content">
			<div class="form-container">
				<div class="form-title">Edit current Prescription</div>

				<h:form prependId="false">
					<h:messages globalOnly="true" styleClass="error" />

					<!-- Top IDs grid -->
					<div class="form-grid">
						<div class="form-group">
							<label for="prescriptionId">Prescription ID</label>
							<h:inputText id="prescriptionId"
								value="#{procedureController.prescription.prescriptionId}"
								styleClass="form-control" readonly="true" />
						</div>

						<div class="form-group">
							<label for="procedureId">Procedure ID</label>
							<h:inputText id="procedureId"
								value="#{procedureController.procedure.procedureId}"
								styleClass="form-control" readonly="true" />
						</div>

						<div class="form-group">
							<label for="recipientId">Recipient ID</label>
							<h:inputText id="recipientId"
								value="#{procedureController.procedure.recipient.hId}"
								styleClass="form-control" readonly="true" />
						</div>

						<div class="form-group">
							<label for="providerId">Provider ID</label>
							<h:inputText id="providerId"
								value="#{procedureController.procedure.provider.providerId}"
								styleClass="form-control" readonly="true" />
						</div>

						<div class="form-group">
							<label for="doctorId">Doctor ID</label>
							<h:inputText id="doctorId"
								value="#{procedureController.procedure.doctor.doctorId}"
								styleClass="form-control" readonly="true" />
						</div>
						<h:panelGroup
							rendered="#{procedureController.procedure.type ne 'SINGLE_DAY'}"
							styleClass="form-group full-width">
							<div class="form-group">
								<label for="prescribedBy"><span style="color:red">*</span>Prescribed BY</label>
								<h:inputText id="prescribedBy"
									value="#{procedureController.prescription.prescribedDoc.doctorId}"
									styleClass="form-control" readonly="true" />
								<h:message for="prescribedBy" styleClass="error" />
							</div>
						</h:panelGroup>
					</div>

					<!-- Date fields grid -->
					<div class="form-grid" style="margin-top: 12px;">
						<h:panelGroup
							rendered="#{procedureController.procedure.type ne 'SINGLE_DAY'}"
							styleClass="form-group full-width">
							<label for="writtenOn"><span
								style="color: red">*</span>Written On</label>
							<h:inputText id="writtenOn"
								value="#{procedureController.prescription.writtenOn}"
								styleClass="form-control" readonly="true">
								<f:convertDateTime pattern="yyyy-MM-dd" />
							</h:inputText>
							<h:message for="writtenOn" styleClass="error" />
							<script>
								let w = document.querySelector('#writtenOn');
								if (w)
									w.setAttribute('type', 'date');
							</script>
						</h:panelGroup>

						<div class="form-group full-width">
							<label for="startDate"><span
								style="color: red">*</span>Start Date</label>
							<h:inputText id="startDate"
								value="#{procedureController.prescription.startDate}"
								styleClass="form-control">
								<f:convertDateTime pattern="yyyy-MM-dd" />
							</h:inputText>
							<h:message for="startDate" styleClass="error" />
							<script>
								let s = document.querySelector('#startDate');
								if (s)
									s.setAttribute('type', 'date');
							</script>
						</div>

						<div class="form-group full-width">
							<label for="endDate"><span style="color: red">*</span>End Date</label>
							<h:inputText id="endDate"
								value="#{procedureController.prescription.endDate}"
								styleClass="form-control">
								<f:convertDateTime pattern="yyyy-MM-dd" />
							</h:inputText>
							<h:message for="endDate" styleClass="error" />
							<script>
								let e = document.querySelector('#endDate');
								if (e)
									e.setAttribute('type', 'date');
							</script>
						</div>
						<div class="form-group full-width">
							<label for="notes">Notes</label>
							<h:inputTextarea id="notes"
								value="#{procedureController.prescription.notes}"
								styleClass="form-control" />
							<h:message for="notes" styleClass="error" />
						</div>
					</div>

					<!-- Action buttons -->
					<div class="button-group">
						<h:commandButton value="Save Prescription" styleClass="btn-add"
							action="#{procedureController.updateLastPrescription(procedureController.prescription)}" />

						<h:commandButton value="Reset Form" styleClass="btn-reset"
							immediate="true"
							action="#{procedureController.resetEditLastPrescription()}" />
						<h:commandButton value="back"
							action="#{procedureController.backFromLastPrescription()}"
						styleClass="shared-button" />
					</div>
				</h:form>
			</div>
		</div>
	</div>
</body>
	</html>
</f:view>