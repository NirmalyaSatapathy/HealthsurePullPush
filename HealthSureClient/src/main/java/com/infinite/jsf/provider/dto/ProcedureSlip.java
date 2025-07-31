package com.infinite.jsf.provider.dto;
 
public class ProcedureSlip {
	private String recipientId;
    private String recipientName;
    private String procedureDate; // For single-day procedures
    private String fromDate;      // For long-term procedures
    private String toDate;        // For long-term procedures
    private String doctorName;
    private String providerContact;
    private String providerEmail;
    private String procedureType;
    private String procedureId;
	public String getRecipientId() {
		return recipientId;
	}
	public void setRecipientId(String recipientId) {
		this.recipientId = recipientId;
	}
	public String getRecipientName() {
		return recipientName;
	}
	public void setRecipientName(String recipientName) {
		this.recipientName = recipientName;
	}
	public String getProcedureDate() {
		return procedureDate;
	}
	public void setProcedureDate(String procedureDate) {
		this.procedureDate = procedureDate;
	}
	public String getFromDate() {
		return fromDate;
	}
	public void setFromDate(String fromDate) {
		this.fromDate = fromDate;
	}
	public String getToDate() {
		return toDate;
	}
	public void setToDate(String toDate) {
		this.toDate = toDate;
	}
	public String getDoctorName() {
		return doctorName;
	}
	public void setDoctorName(String doctorName) {
		this.doctorName = doctorName;
	}
	public String getProviderContact() {
		return providerContact;
	}
	public void setProviderContact(String providerContact) {
		this.providerContact = providerContact;
	}
	public String getProviderEmail() {
		return providerEmail;
	}
	public void setProviderEmail(String providerEmail) {
		this.providerEmail = providerEmail;
	}
	public String getProcedureType() {
		return procedureType;
	}
	public void setProcedureType(String procedureType) {
		this.procedureType = procedureType;
	}
	public String getProcedureId() {
		return procedureId;
	}
	public void setProcedureId(String procedureId) {
		this.procedureId = procedureId;
	}
	public ProcedureSlip(String recipientId, String recipientName, String procedureDate, String fromDate, String toDate,
			String doctorName, String providerContact, String providerEmail, String procedureType, String procedureId) {
		this.recipientId = recipientId;
		this.recipientName = recipientName;
		this.procedureDate = procedureDate;
		this.fromDate = fromDate;
		this.toDate = toDate;
		this.doctorName = doctorName;
		this.providerContact = providerContact;
		this.providerEmail = providerEmail;
		this.procedureType = procedureType;
		this.procedureId = procedureId;
	}
	
	public ProcedureSlip() {
		super();
		// TODO Auto-generated constructor stub
	}
 
}
 