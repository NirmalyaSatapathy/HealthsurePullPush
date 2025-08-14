<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<f:view>
	<html>
<head>
<title>Select Procedure Type</title>
<style>
body {
	font-family: 'Segoe UI', sans-serif;
	background-color: #f0f8ff; /* Light blue background */
	margin: 0;
	padding: 0;
}

.container {
	width: 500px;
	margin: 100px auto;
	background-color: white;
	padding: 40px 50px;
	border-radius: 16px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
	text-align: center;
}

h2 {
	color: #2e7d32; /* Green */
	margin-bottom: 30px;
	font-size: 24px;
}

.radio-group {
	display: flex;
	flex-direction: column;
	align-items: center;
	gap: 15px;
	margin-bottom: 30px;
	font-size: 18px;
	color: #333;
}

.radio-item {
	display: flex;
	align-items: center;
}

.radio-item input[type="radio"] {
	margin-right: 10px;
}

.button-group {
	display: flex;
	justify-content: center;
	gap: 20px;
	margin-top: 20px;
}

.error-message {
	display: block;
	color: #f44336 !important;
	font-size: 14px;
	font-weight: 600;
	margin-top: 3px;
}

.submit-btn {
	padding: 10px 20px;
	background-color: #4CAF50; /* Green */
	color: white;
	border: none;
	border-radius: 8px;
	cursor: pointer;
	font-size: 14px;
	transition: background-color 0.3s ease;
}

.submit-btn:hover {
	background-color: #388e3c;
}

.back-btn {
	background-color: #2196F3; /* Blue */
	color: white;
}

.back-btn:hover {
	background-color: #1976D2;
}
</style>
</head>
<body>
	<jsp:include page="/navbar/NavProvider.jsp" />
	<h:form prependId="false">
		<div class="container">
			<h2>Select Procedure Type</h2>
			<div class="radio-group">
				<div class="radio-item">
					<h:selectOneRadio value="#{procedureController.procedureType}"
						layout="lineDirection" id="procedureType">
						<f:selectItem itemLabel="Single Day" itemValue="single" />
						<f:selectItem itemLabel="Long-Term" itemValue="inprogress" />
					</h:selectOneRadio>
				</div>
				<h:message for="procedureType" styleClass="error-message" />
			</div>
			<div class="button-group">
				<h:commandButton value="Create New Procedure"
					action="#{procedureController.createNewProcedure()}"
					styleClass="submit-btn" />

				<h:commandButton value="Back"
					action="ShowBookedAppointments?faces-redirect=true"
					styleClass="submit-btn back-btn" />
			</div>
		</div>
	</h:form>
</body>
	</html>
</f:view>