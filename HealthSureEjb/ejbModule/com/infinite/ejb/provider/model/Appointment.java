package com.infinite.ejb.provider.model;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Date;
import java.util.Set;

import com.infinite.ejb.recipient.model.Recipient;
public class Appointment implements Serializable{

    private String appointmentId;
    private Doctors doctor;
    private Recipient recipient;
    private DoctorAvailability availability;
    private Provider provider;
    private Date requestedAt;
    private Date bookedAt;
    private AppointmentStatus status;
    private String notes;
    private Date start;
    private Date end;
    private int slotNo;
    
    public Date getStart() {
		return start;
	}

	public void setStart(Date start) {
		this.start = start;
	}

	public Date getEnd() {
		return end;
	}

	public void setEnd(Date end) {
		this.end = end;
	}

	public int getSlotNo() {
		return slotNo;
	}

	public void setSlotNo(int slotNo) {
		this.slotNo = slotNo;
	}

	@Override
	public String toString() {
		return "Appointment [appointmentId=" + appointmentId + ", doctor=" + doctor + ", recipient=" + recipient
				+ ", availability=" + availability + ", provider=" + provider + ", requestedAt=" + requestedAt
				+ ", bookedAt=" + bookedAt + ", status=" + status + ", notes=" + notes + ", procedures=" + procedures
				+ "]";
	}

	// One-to-many: One appointment can have multiple procedures
    private Set<MedicalProcedure> procedures;

    // Getters and Setters

    public String getAppointmentId() {
        return appointmentId;
    }

    public void setAppointmentId(String appointmentId) {
        this.appointmentId = appointmentId;
    }

    public Doctors getDoctor() {
        return doctor;
    }

    public void setDoctor(Doctors doctor) {
        this.doctor = doctor;
    }

    public Recipient getRecipient() {
        return recipient;
    }

    public void setRecipient(Recipient recipient) {
        this.recipient = recipient;
    }

    public DoctorAvailability getAvailability() {
        return availability;
    }

    public void setAvailability(DoctorAvailability availability) {
        this.availability = availability;
    }

    public Provider getProvider() {
        return provider;
    }

    public void setProvider(Provider provider) {
        this.provider = provider;
    }

    public Date getRequestedAt() {
        return requestedAt;
    }

    public void setRequestedAt(Date requestedAt) {
        this.requestedAt = requestedAt;
    }

    public Date getBookedAt() {
        return bookedAt;
    }

    public void setBookedAt(Date bookedAt) {
        this.bookedAt = bookedAt;
    }

    public AppointmentStatus getStatus() {
        return status;
    }

    public Appointment() {
		super();
		// TODO Auto-generated constructor stub
	}

	public void setStatus(AppointmentStatus status) {
        this.status = status;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public Set<MedicalProcedure> getProcedures() {
        return procedures;
    }

    public void setProcedures(Set<MedicalProcedure> procedures) {
        this.procedures = procedures;
    }
}
