<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core" %>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Provider Home</title>
    <link rel="stylesheet" type="text/css" href="/HealthSureClient/resources/css/provider.css" />
</head>

<body class="center-wrapper">
<f:view>

    <!-- 🌐 Navigation -->
    <jsp:include page="/navbar/NavProvider.jsp" />

    <!-- 👋 Welcome Message -->
    <div class="container-xl">
        <h2 class="welcome-heading">
            Welcome, <h:outputText value="#{providerBean.providerName}" /> 👋
        </h2>
        <p class="subtext">Here’s a snapshot of your practice this week.</p>
    </div>

    <!-- 📊 Dashboard Overview -->
    <div class="container-xl">
        <div class="dashboard-grid">

            <div class="card">
                <h3 class="card-title" style="color: #3b82f6;">Appointments</h3>
                <p class="card-value"><h:outputText value="#{providerBean.totalAppointments}" /></p>
                <p class="card-note">Scheduled this week</p>
            </div>

            <div class="card">
                <h3 class="card-title" style="color: #10b981;">Patients</h3>
                <p class="card-value"><h:outputText value="#{providerBean.totalPatients}" /></p>
                <p class="card-note">Under your care</p>
            </div>

            <div class="card">
                <h3 class="card-title" style="color: #8b5cf6;">Claims</h3>
                <p class="card-value"><h:outputText value="#{providerBean.totalClaims}" /></p>
                <p class="card-note">Filed this month</p>
            </div>

            <div class="card">
                <h3 class="card-title" style="color: #ef4444;">Payments</h3>
                <p class="card-value">₹<h:outputText value="#{providerBean.totalPayments}" /></p>
                <p class="card-note">Total received</p>
            </div>

        </div>
    </div>

    <!-- 💡 Insights -->
    <div class="container-md">
        <div class="insight-box">
            <p class="insight-text">
                "The good physician treats the disease; the great physician treats the patient who has the disease." — William Osler
            </p>
        </div>
    </div>

    <!-- 🚀 Quick Actions -->
    <div class="container-xl quick-actions">
        <h3 class="quick-actions-title">Quick Actions</h3>
        <div class="action-grid">

            <h:form>
                <h:commandButton value="📅 Update Availability"
                                 action="#{providerBean.manageAppointments}"
                                 styleClass="action-button btn-blue" />
            </h:form>

            <h:form>
                <h:commandButton value="📅 View Appointments"
                                 action="#{providerBean.viewHistory}"
                                 styleClass="action-button btn-green" />
            </h:form>

            <h:form>
                <h:commandButton value="🧾 Scheduled Procedures"
                                 action="ShowScheduledProcedures"
                                 styleClass="action-button btn-purple" />
            </h:form>

            <h:form>
                <h:commandButton value="🧾 Ongoing Procedures"
                                 action="ShowOnGoingProcedures"
                                 styleClass="action-button btn-pink" />
            </h:form>

            <h:form>
                <h:commandButton value="💳 File Insurance Claim"
                                 action="#{claimController.searchUnclaimedProcedure}"
                                 styleClass="action-button btn-indigo" />
            </h:form>

            <h:form>
                <h:commandButton value="💳 Update Insurance Claim"
                                 action="#{claimController.showPendingClaims}"
                                 styleClass="action-button btn-indigo" />
            </h:form>

            <h:form>
                <h:commandButton value="💳 Claims History"
                                 action="#{providerBean.searchPayments}"
                                 styleClass="action-button btn-teal" />
            </h:form>

            <h:form>
                <h:commandButton value="💳 Payment Records"
                                 action="#{providerBean.createClaim}"
                                 styleClass="action-button btn-fuchsia" />
            </h:form>

        </div>
    </div>

    <!-- 📎 Footer -->
    <jsp:include page="/footer/Footer.jsp" />

</f:view>
</body>
</html>