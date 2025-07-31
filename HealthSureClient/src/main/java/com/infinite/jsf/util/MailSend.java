package com.infinite.jsf.util;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.infinite.jsf.provider.dto.ProcedureSlip;

public class MailSend {
	public static String sendMail(String toEmail, String subject, String htmlContent) {
        // Existing implementation remains unchanged
        String from = "infinitehealthsure@gmail.com";
        String host = "smtp.gmail.com";
 
        Properties properties = new Properties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", "465");
        properties.put("mail.smtp.ssl.enable", "true");
        properties.put("mail.smtp.auth", "true");
 
        Session session = Session.getInstance(properties, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, "xrascqydsfthxttk");
            }
        });
 
        session.setDebug(true);
 
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            message.setSubject(subject);
            message.setContent(htmlContent, "text/html");
            Transport.send(message);
            return "Mail Sent Successfully...";
        } catch (MessagingException mex) {
            mex.printStackTrace();
            return "Error: " + mex.getMessage();
        }
    }
 
	// Updated procedure completion method with support for both single-day and long-term procedures

	public static String procedureCompletion(ProcedureSlip slip, String procedureName) {

	    boolean isLongTerm = "LONG_TERM".equals(slip.getProcedureType());

	    String htmlContent = "<html><body style='font-family:Arial, sans-serif;'>"

	            + "<h2 style='color:#27AE60;'>Your procedure has been completed</h2>"

	            + "<p>Dear " + slip.getRecipientName() + ",</p>"

	            + "<p>We're pleased to inform you that your <strong>" + procedureName + "</strong> procedure with Dr. "

	            + slip.getDoctorName() + " has been successfully completed.</p>"

	            + "<table style='border-collapse: collapse; width: 100%; margin-top: 10px;'>"

	            + "<tr><td style='padding: 8px; border: 1px solid #ddd;'>Recipient ID</td>"

	            + "<td style='padding: 8px; border: 1px solid #ddd;'>" + slip.getRecipientId() + "</td></tr>"

	            + "<tr><td style='padding: 8px; border: 1px solid #ddd;'>Recipient Name</td>"

	            + "<td style='padding: 8px; border: 1px solid #ddd;'>" + slip.getRecipientName() + "</td></tr>"

	            + "<tr><td style='padding: 8px; border: 1px solid #ddd;'>Procedure</td>"

	            + "<td style='padding: 8px; border: 1px solid #ddd;'><strong>" + procedureName + "</strong></td></tr>"

	            + "<tr><td style='padding: 8px; border: 1px solid #ddd;'>Procedure ID</td>"

	            + "<td style='padding: 8px; border: 1px solid #ddd;'>" + slip.getProcedureId() + "</td></tr>"

	            + "<tr><td style='padding: 8px; border: 1px solid #ddd;'>Procedure Type</td>"

	            + "<td style='padding: 8px; border: 1px solid #ddd;'>" + slip.getProcedureType() + "</td></tr>";

	    if (isLongTerm) {

	        htmlContent += "<tr><td style='padding: 8px; border: 1px solid #ddd;'>Start Date</td>"

	                + "<td style='padding: 8px; border: 1px solid #ddd;'>" + slip.getFromDate() + "</td></tr>"

	                + "<tr><td style='padding: 8px; border: 1px solid #ddd;'>Completion Date</td>"

	                + "<td style='padding: 8px; border: 1px solid #ddd;'>" + slip.getToDate() + "</td></tr>";

	    } else {

	        htmlContent += "<tr><td style='padding: 8px; border: 1px solid #ddd;'>Procedure Date</td>"

	                + "<td style='padding: 8px; border: 1px solid #ddd;'>" + slip.getProcedureDate() + "</td></tr>";

	    }

	    htmlContent += "<tr><td style='padding: 8px; border: 1px solid #ddd;'>Doctor</td>"

	            + "<td style='padding: 8px; border: 1px solid #ddd;'>" + slip.getDoctorName() + "</td></tr>"

	            + "<tr><td style='padding: 8px; border: 1px solid #ddd;'>Provider Email</td>"

	            + "<td style='padding: 8px; border: 1px solid #ddd;'>" + slip.getProviderEmail() + "</td></tr>"

	            + "<tr><td style='padding: 8px; border: 1px solid #ddd;'>Provider Contact</td>"

	            + "<td style='padding: 8px; border: 1px solid #ddd;'>" + slip.getProviderContact() + "</td></tr>"

	            + "</table>"

	            + "<p style='margin-top: 20px;'>Please follow any post-procedure instructions provided by your doctor.</p>"

	            + "<p>If you experience any unusual symptoms or have concerns about your recovery, "

	            + "please contact us immediately at:<br>"

	            + "Email: " + slip.getProviderEmail() + "<br>"

	            + "Phone: " + slip.getProviderContact() + "</p>"

	            + "<p>We appreciate you choosing our healthcare services and wish you a speedy recovery.</p>"

	            + "<p>Sincerely,<br>The Healthcare Team</p>"

	            + "<hr></body></html>";

	    return htmlContent;

	}
	 
	// Helper method to actually send the procedure completion email

	public static void sendProcedureCompletionMail(ProcedureSlip slip, String procedureName, String recipientEmail) {

	    try {

	        String subject = "Procedure Completion: " + procedureName;

	        String htmlContent = procedureCompletion(slip, procedureName);

	        sendMail(recipientEmail, subject, htmlContent);

	    } catch (Exception e) {

	        System.err.println("Error sending procedure completion email: " + e.getMessage());

	        throw new RuntimeException("Failed to send procedure completion email", e);

	    }

	}
	 
 
 
	public static String sendInfo(String toEmail, String subject, String data) {
		
        //String to = "prasanna.trainer@gmail.com";

        // Sender's email ID needs to be mentioned
        String from = "prasanna.vsp80@gmail.com";

        // Assuming you are sending email from through gmails smtp
        String host = "smtp.gmail.com";

        // Get system properties
        Properties properties = System.getProperties();

        // Setup mail server
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", "465");
        properties.put("mail.smtp.ssl.enable", "true");
        properties.put("mail.smtp.auth", "true");

        // Get the Session object.// and pass username and password
        Session session = Session.getInstance(properties, new javax.mail.Authenticator() {

            protected PasswordAuthentication getPasswordAuthentication() {

                return new PasswordAuthentication("prasanna.vsp80@gmail.com", "soqdhechjkcchkgl");

            }

        });

        // Used to debug SMTP issues
        session.setDebug(true);

        try {
            // Create a default MimeMessage object.
            MimeMessage message = new MimeMessage(session);

            // Set From: header field of the header.
            message.setFrom(new InternetAddress(from));

            // Set To: header field of the header.
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));

            // Set Subject: header field
            message.setSubject(subject);

            // Now set the actual message
            message.setText(data);

            System.out.println("sending...");
            // Send message
            Transport.send(message);
            System.out.println("Sent message successfully....");
            return "Mail Send Successfully...";
        } catch (MessagingException mex) {
            mex.printStackTrace();
            return mex.getMessage();
        }

	}
}