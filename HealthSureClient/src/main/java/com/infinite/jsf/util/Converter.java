package com.infinite.jsf.util;

import java.util.Calendar;
import java.util.Date;

import com.infinite.ejb.provider.model.Appointment;
import com.infinite.ejb.provider.model.AppointmentStatus;
import com.infinite.ejb.provider.model.Doctors;
import com.infinite.ejb.provider.model.DoctorAvailability;
import com.infinite.ejb.provider.model.MedicalProcedure;
import com.infinite.ejb.provider.model.Provider;
import com.infinite.ejb.recipient.model.Recipient;
import com.infinite.jsf.provider.model.ProcedureStatus;

public class Converter {
	public static Appointment convertToEJBAppointment(com.infinite.jsf.provider.model.Appointment jsfAppointment) {
	    if (jsfAppointment == null) return null;

	    Appointment ejbAppointment = new Appointment();

	    // Basic field mapping
	    ejbAppointment.setAppointmentId(jsfAppointment.getAppointmentId());
	    ejbAppointment.setRequestedAt(jsfAppointment.getRequestedAt());
	    ejbAppointment.setBookedAt(jsfAppointment.getBookedAt());
	    ejbAppointment.setStatus(AppointmentStatus.valueOf(jsfAppointment.getStatus().name()));
	    ejbAppointment.setNotes(jsfAppointment.getNotes());

	    // Entity mapping (custom conversion methods assumed)
	    ejbAppointment.setDoctor(convertToEJBDoctor(jsfAppointment.getDoctor()));
	    ejbAppointment.setRecipient(convertToEJBRecipient(jsfAppointment.getRecipient()));
	    ejbAppointment.setProvider(convertToEJBProvider(jsfAppointment.getProvider()));

	    return ejbAppointment;
	}
	public static com.infinite.ejb.provider.model.Doctors convertToEJBDoctor(
	        com.infinite.jsf.provider.model.Doctors jsfDoctor) {
	    if (jsfDoctor == null || jsfDoctor.getDoctorId() == null) return null;

	    com.infinite.ejb.provider.model.Doctors ejbDoctor = new com.infinite.ejb.provider.model.Doctors();
	    ejbDoctor.setDoctorId(jsfDoctor.getDoctorId());
	    ejbDoctor.setDoctorName(jsfDoctor.getDoctorName());
	    ejbDoctor.setAddress(jsfDoctor.getAddress());
	    ejbDoctor.setSpecialization(jsfDoctor.getSpecialization());
	    return ejbDoctor;
	}
	public static com.infinite.ejb.provider.model.Provider convertToEJBProvider(
	        com.infinite.jsf.provider.model.Provider jsfProvider) {
	    if (jsfProvider == null || jsfProvider.getProviderId() == null) return null;

	    com.infinite.ejb.provider.model.Provider ejbProvider = new com.infinite.ejb.provider.model.Provider();
	    ejbProvider.setProviderId(jsfProvider.getProviderId());
	    return ejbProvider;
	}
	public static com.infinite.ejb.recipient.model.Recipient convertToEJBRecipient(
	        com.infinite.jsf.recipient.model.Recipient jsfRecipient) {

	    if (jsfRecipient == null || jsfRecipient.gethId() == null) return null;

	    com.infinite.ejb.recipient.model.Recipient ejbRecipient = new com.infinite.ejb.recipient.model.Recipient();

	    ejbRecipient.sethId(jsfRecipient.gethId());
	    ejbRecipient.setFirstName(jsfRecipient.getFirstName());
	    ejbRecipient.setLastName(jsfRecipient.getLastName());
	    ejbRecipient.setMobile(jsfRecipient.getMobile());
	    ejbRecipient.setUserName(jsfRecipient.getUserName());
	    ejbRecipient.setDob(jsfRecipient.getDob());
	    ejbRecipient.setAddress(jsfRecipient.getAddress());
	    ejbRecipient.setCreatedAt(jsfRecipient.getCreatedAt());
	    ejbRecipient.setPassword(jsfRecipient.getPassword());
	    ejbRecipient.setEmail(jsfRecipient.getEmail());
	    ejbRecipient.setGender(
	    	    jsfRecipient.getGender() != null 
	    	    ? com.infinite.ejb.recipient.model.Gender.valueOf(jsfRecipient.getGender().name()) 
	    	    : null
	    	);

	    	ejbRecipient.setStatus(
	    	    jsfRecipient.getStatus() != null 
	    	    ? com.infinite.ejb.recipient.model.RecipientStatus.valueOf(jsfRecipient.getStatus().name()) 
	    	    : null
	    	);


	    return ejbRecipient;
	}
	public static MedicalProcedure convertToEJBProcedure(com.infinite.jsf.provider.model.MedicalProcedure jsfProcedure) {
	    if (jsfProcedure == null) return null;

	    MedicalProcedure ejbProcedure = new MedicalProcedure();

	    // Basic fields
	    ejbProcedure.setProcedureId(jsfProcedure.getProcedureId());
	    ejbProcedure.setScheduledDate(jsfProcedure.getScheduledDate());
	    ejbProcedure.setProcedureDate(jsfProcedure.getProcedureDate());
	    ejbProcedure.setFromDate(jsfProcedure.getFromDate());
	    ejbProcedure.setToDate(jsfProcedure.getToDate());
	    ejbProcedure.setDiagnosis(jsfProcedure.getDiagnosis());
	    ejbProcedure.setRecommendations(jsfProcedure.getRecommendations());
	    ejbProcedure.setProcedureStatus(
	    	    com.infinite.ejb.provider.model.ProcedureStatus.valueOf(jsfProcedure.getProcedureStatus().name())
	    	);

	    ejbProcedure.setCreatedAt(jsfProcedure.getCreatedAt());
	    // NOTE: Claims and Prescriptions are typically not transferred from JSF to EJB during creation,
	    // but if needed, you can copy them here as well using separate converters.

	    return ejbProcedure;
	}
	public static Date truncateTime(Date date) {
	    if (date == null) return null;
	    Calendar cal = Calendar.getInstance();
	    cal.setTime(date);
	    cal.set(Calendar.HOUR_OF_DAY, 0);
	    cal.set(Calendar.MINUTE, 0);
	    cal.set(Calendar.SECOND, 0);
	    cal.set(Calendar.MILLISECOND, 0);
	    return cal.getTime();
	}


}
