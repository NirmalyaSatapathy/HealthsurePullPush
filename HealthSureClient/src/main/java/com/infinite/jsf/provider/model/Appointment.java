package com.infinite.jsf.provider.model;

import java.sql.Timestamp;
import java.util.Date;
import java.util.Set;

import com.infinite.jsf.recipient.model.Recipient;

public class Appointment {
    private String appointmentId;
    private Doctors doctor;
    private Recipient recipient;
    private DoctorAvailability availability;
    private Provider provider;
    private Date requestedAt;
    private Date bookedAt;
    private AppointmentStatus status;
    private Date start;
    private Date end;
    private int slotNo;
    private Date cancelledAt;
    public Date getStart() {
		return start;
	}

	public void setStart(Date start) {
		this.start = start;
	}

	public Date getEnd() {
		return end;
	}

	public Date getCancelledAt() {
		return cancelledAt;
	}

	public void setCancelledAt(Date cancelledAt) {
		this.cancelledAt = cancelledAt;
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
    public Set<MedicalProcedure> getProcedures() {
		return procedures;
	}

	public void setProcedures(Set<MedicalProcedure> procedures) {
		this.procedures = procedures;
	}

	private String notes;
    private Set<MedicalProcedure> procedures;
    // Constructors
    public Appointment() {}

    public Appointment(String appointmentId, Doctors doctor, Recipient recipient, 
                      DoctorAvailability availability, Provider provider) {
        this.appointmentId = appointmentId;
        this.doctor = doctor;
        this.recipient = recipient;
        this.availability = availability;
        this.provider = provider;
        this.status = AppointmentStatus.PENDING;
        this.requestedAt = new Date();
    }

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

    public void setStatus(AppointmentStatus status) {
        this.status = status;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    @Override
    public String toString() {
        return "Appointment{" +
               "appointmentId='" + appointmentId + '\'' +
               ", doctor=" + (doctor != null ? doctor.getDoctorId() : "null") +
               ", recipient=" + (recipient != null ? recipient.gethId() : "null") +
               ", availability=" + (availability != null ? availability.getAvailabilityId() : "null") +
               ", provider=" + (provider != null ? provider.getProviderId() : "null") +
               ", requestedAt=" + requestedAt +
               ", bookedAt=" + bookedAt +
               ", status=" + status +
               ", notes='" + notes + '\'' +
               '}';
    }

}