<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
  <f:view>
<html>
<head>
  <meta charset="UTF-8">
  <title>Procedure Action Panel</title>
  <link rel="stylesheet" href="css/healthsure-style.css" />
  <style>
    /*----------------------
      Base & Container
    ----------------------*/
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background-color: #f2f7fb;
      margin: 0;
      padding: 0;
    }
    .nav-container {
      max-width: 720px;
      margin: 60px auto;
      padding: 2rem;
      background-color: #ffffff;
      border-radius: 0.75rem;
      box-shadow: 0 4px 12px rgba(0,0,0,0.05);
      text-align: center;
      margin-top:130px;
    }
    .nav-title {
      font-size: 2rem;
      font-weight: 700;
      color: #2c3e50;
      margin-bottom: 1.5rem;
      line-height: 1.2;
    }

    /*----------------------
      Grid Layout
    ----------------------*/
    .button-row {
      display: grid;
      gap: 1rem;
    }
    .button-row.row1 {
      grid-template-columns: repeat(2, minmax(140px, 1fr));
    }
    .button-row.row2 {
      grid-template-columns: repeat(3, minmax(140px, 1fr));
      margin-top: 1.5rem;
    }
    @media (max-width: 600px) {
      .button-row.row1,
      .button-row.row2 {
        grid-template-columns: 1fr;
      }
    }

    /*----------------------
      Buttons
    ----------------------*/
    .button-row {
  display: grid;
  gap: 1rem;
}

/* Row 1 always two columns */
.button-row.row1 {
  grid-template-columns: repeat(2, minmax(140px, 1fr));
}

/* Row 2 adapts to number of child buttons */
.button-row.row2 {
  grid-template-columns: repeat(auto-fit, minmax(140px, 1fr));
  margin-top: 1.5rem;
}

/* …rest of your button styles… */
    
    .button-group {
      width: 100%;
      max-width: 200px;
    }
    .action-button {
      display: inline-block;
      width: 100%;
      padding: 0.75rem 0;
      font-size: 1rem;
      font-weight: 600;
      border: none;
      border-radius: 0.5rem;
      color: #fff;
      cursor: pointer;
      transition: background-color 0.2s, transform 0.1s, box-shadow 0.2s;
      box-shadow: 0 2px 4px rgba(0,0,0,0.1);
      text-decoration: none;
    }
    .action-button:hover {
      transform: translateY(-2px);
      box-shadow: 0 4px 8px rgba(0,0,0,0.12);
    }
    .action-button:focus {
      outline: 3px solid currentColor;
      outline-offset: 2px;
    }

    /* Color Variants */
    .add-button {
      background-color: #28a745;
    }
    .add-button:hover {
      background-color: #218838;
    }

    .edit-button {
      background-color: #ffc107;
      color: #212529;
    }
    .edit-button:hover {
      background-color: #e0a800;
    }

    .submit-button {
      background-color: #17a2b8;
    }
    .submit-button:hover {
      background-color: #117a8b;
    }
    .message-container ul {
  list-style: none; /* Remove bullet */
  padding-left: 0;
  margin: 0 0 1rem 0;
}

.message-container li {
  background-color: #ffe6e6; /* Light red background for visibility */
  color: #c62828;            /* Strong red text */
  padding: 0.5rem 1rem;
  margin-bottom: 0.5rem;
  border-radius: 0.5rem;
  font-weight: 500;
  box-shadow: 0 2px 6px rgba(0,0,0,0.05);
}
  </style>
</head>
<body>
 <jsp:include page="/navbar/NavProvider.jsp" />

    <div class="nav-container">
      <div class="nav-title">Procedure Action Panel</div>

      <h:form prependId="false">
<div class="message-container">
  <h:messages globalOnly="true" layout="list" />
</div>
        <!-- Row 1: Add Actions -->
        <div class="button-row row1">
          <div class="button-group">
            <h:commandButton
              value="Add Prescription"
              action="#{procedureController.createNewPrescription()}"
              styleClass="action-button add-button" />
          </div>
          <div class="button-group">
            <h:commandButton
              value="Add Procedure Logs"
              action="#{procedureController.createNewProcedureLog()}"
              styleClass="action-button add-button" />
          </div>
        </div>

        <!-- Row 2: Edit & Submit -->
        <div class="button-row row2">
          <h:panelGroup rendered="#{procedureController.isFlag() ne false}">
            <div class="button-group">
              <h:commandButton
                value="Edit Procedure"
                action="#{procedureController.gotoProcedureForm()}"
                styleClass="action-button edit-button" />
            </div>
          </h:panelGroup>
          <div class="button-group">
              <h:commandButton value="Review Prescriptions"
                               action="#{procedureController.loadViewPrescriptions()}"
                               styleClass="action-button edit-button" />
            </div>
             <div class="button-group">
              <h:commandButton value="Review Logs"
                               action="#{procedureController.loadViewLogs()}"
                               styleClass="action-button edit-button" />
            </div>
          <div class="button-group">
            <h:commandButton
              value="Submit Procedure"
              action="#{procedureController.procedureSubmit()}"
              styleClass="action-button submit-button" />
          </div>
        </div>

      </h:form>
    </div>

</body>
</html>
  </f:view>