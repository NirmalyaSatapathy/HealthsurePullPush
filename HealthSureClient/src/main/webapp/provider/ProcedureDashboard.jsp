<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
  <f:view>
<html>
<head>
  <meta charset="UTF-8">
  <title>Procedure Navigation Panel</title>
  <link rel="stylesheet" href="css/healthsure-style.css" />
  <style>
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background-color: #f2f7fb;
      margin: 0;
      padding: 0;
    }

    .nav-container {
      max-width: 720px;
      margin: 100px auto;
      padding: 30px;
      background-color: #fff;
      border-radius: 10px;
      box-shadow: 0 0 12px rgba(0,0,0,0.1);
      text-align: center;
      margin-top:130px;
    }

    .nav-title {
      font-size: 28px;
      color: #2c3e50;
      font-weight: bold;
      margin-bottom: 30px;
    }

    /* shared button styles */
    .button-group {
      width: 100%;
      max-width: 200px;
    }
    .action-button {
      width: 100%;
      padding: 12px 0;
      font-size: 16px;
      border: none;
      border-radius: 6px;
      color: #fff;
      cursor: pointer;
      transition: background-color 0.2s, transform 0.1s;
      text-decoration: none;
    }
    .action-button:hover {
      transform: translateY(-1px);
    }
    .action-button:focus {
      outline: 3px solid currentColor;
    }

    /* color groups */
    .add-button {
      background-color: #28a745;    /* green */
    }
    .add-button:hover {
      background-color: #218838;
    }

    .edit-button {
      background-color: #ffc107;    /* amber */
      color: #212529;
    }
    .edit-button:hover {
      background-color: #e0a800;
    }

    .submit-button {
      background-color: #17a2b8;    /* teal */
    }
    .submit-button:hover {
      background-color: #117a8b;
    }

    /* two rows: first row 2 buttons, second row 3 */
    .button-row {
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
      gap: 20px;
      margin-bottom: 20px;
    }
    .button-row.row1 .button-group {
      flex: 0 1 calc((100% - 20px) / 2);
    }
    .button-row.row2 .button-group {
      flex: 0 1 calc((100% - 40px) / 3);
    }

    @media (max-width: 600px) {
      .button-row.row1 .button-group,
      .button-row.row2 .button-group {
        flex: 0 1 100%;
      }
    }
  </style>
</head>
<body>
 <jsp:include page="/navbar/NavProvider.jsp" />
    <div class="nav-container">
      <div class="nav-title">Procedure Navigation Panel</div>

      <h:form prependId="false">
        <!-- first row: Add + Edit Last -->
        <div class="button-row row1">
          <div class="button-group">
            <h:commandButton value="Add Prescription"
                             action="#{procedureController.createNewPrescription()}"
                             styleClass="action-button add-button" />
          </div>
</div>

        <!-- second row: Edit Procedure, Add Logs, Submit -->
        <div class="button-row row2">
          <div class="button-group">
            <h:commandButton value="Edit Procedure"
                             action="#{procedureController.gotoProcedureForm()}"
                             styleClass="action-button edit-button" />
          </div>
           <h:panelGroup rendered="#{not empty procedureController.prescriptions}">
            <div class="button-group">
              <h:commandButton value="Review Prescriptions"
                               action="#{procedureController.loadViewPrescriptions()}"
                               styleClass="action-button edit-button" />
            </div>
          </h:panelGroup>
 
          <div class="button-group">
            <h:commandButton value="Submit Procedure"
                             action="#{procedureController.procedureSubmit()}"
                             styleClass="action-button submit-button" />
          </div>
        </div>
      </h:form>
    </div>

</body>
</html>
  </f:view>