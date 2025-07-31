package com.infinite.jsf.provider.daoImpl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.AnnotationConfiguration;

import com.infinite.ejb.provider.model.Appointment;
import com.infinite.ejb.provider.model.AppointmentStatus;
import com.infinite.ejb.provider.model.Doctors;
import com.infinite.ejb.provider.model.MedicalProcedure;
import com.infinite.ejb.provider.model.Provider;
import com.infinite.ejb.recipient.model.Recipient;
import com.infinite.jsf.util.Converter;

public class ProviderDaoImpl {
	static SessionFactory sessionFactory;
	static {
		try {
			sessionFactory = new AnnotationConfiguration().configure().buildSessionFactory();
		} catch (Throwable ex) {
			System.err.println("🔥 Hibernate SessionFactory initialization failed.");
			ex.printStackTrace(); // <-- THIS WILL PRINT THE ACTUAL ROOT CAUSE
			throw new ExceptionInInitializerError(ex);
		}
	}

	public Recipient searchRecipientByHealthId(String healthId) {
		Session session = sessionFactory.openSession();
		com.infinite.jsf.recipient.model.Recipient recipient = null;
		recipient = (com.infinite.jsf.recipient.model.Recipient) session
				.get(com.infinite.jsf.recipient.model.Recipient.class, healthId);
		session.close();
		return Converter.convertToEJBRecipient(recipient);
	}

	public Doctors searchDoctorById(String doctorId) {
		Session session = sessionFactory.openSession();
		com.infinite.jsf.provider.model.Doctors doctor = null;
		doctor = (com.infinite.jsf.provider.model.Doctors) session.get(com.infinite.jsf.provider.model.Doctors.class,
				doctorId);
		session.close();
		return Converter.convertToEJBDoctor(doctor);
	}

	public Provider searchProviderById(String providerId) {
		Session session = sessionFactory.openSession();
		com.infinite.jsf.provider.model.Provider provider = null;
		provider = (com.infinite.jsf.provider.model.Provider) session
				.get(com.infinite.jsf.provider.model.Provider.class, providerId);
		session.close();
		return Converter.convertToEJBProvider(provider);
	}

	public Appointment searchAppointmentById(String appointmentId) {
		Session session = sessionFactory.openSession();
		com.infinite.jsf.provider.model.Appointment appointment = null;
		appointment = (com.infinite.jsf.provider.model.Appointment) session
				.get(com.infinite.jsf.provider.model.Appointment.class, appointmentId);
		session.close();
		return Converter.convertToEJBAppointment(appointment);
	}

	public MedicalProcedure getProcedureById(String procedureId1) {
		Date startDate = null;
		Session session = sessionFactory.openSession();
		Transaction tx = session.beginTransaction();
		System.out.println(procedureId1);

		com.infinite.jsf.provider.model.MedicalProcedure procedure = (com.infinite.jsf.provider.model.MedicalProcedure) session
				.get(com.infinite.jsf.provider.model.MedicalProcedure.class, procedureId1);
		System.out.println(procedure);
		MedicalProcedure ejbProcedure = Converter.convertToEJBProcedure(procedure);
		System.out.println("printing from method");
		System.out.println(procedure);
		tx.commit();
		session.close();
		return ejbProcedure;
	}

	public boolean isDoctorPatientAssociatedByAppointment(String doctorId, String hId) {
		String hql = "SELECT count(a) FROM Appointment a WHERE a.doctor.doctorId = :doctorId AND a.recipient.hId = :hId";
		Session session = sessionFactory.openSession();
		Long count = (Long) session.createQuery(hql).setParameter("doctorId", doctorId).setParameter("hId", hId)
				.uniqueResult();
		return count != null && count > 0;
	}

	public List<Recipient> getPatientListByDoctorId(String doctorId) {
		Session session = sessionFactory.openSession();
		Transaction tx = session.beginTransaction();

		String hql = "SELECT DISTINCT a.recipient FROM com.infinite.jsf.provider.model.Appointment a "
				+ "WHERE a.doctor.doctorId = :doctorId";

		List<com.infinite.jsf.recipient.model.Recipient> jsfRecipientList = session.createQuery(hql)
				.setParameter("doctorId", doctorId).list();

		tx.commit();
		session.close();

		List<Recipient> ejbRecipientList = new ArrayList<Recipient>();
		for (com.infinite.jsf.recipient.model.Recipient jsfRecipient : jsfRecipientList) {
			ejbRecipientList.add(Converter.convertToEJBRecipient(jsfRecipient));
		}

		return ejbRecipientList;
	}

	public List<Recipient> searchPatientsByName(String doctorId, String name, String matchType) {
		Session session = sessionFactory.openSession();
		Transaction tx = session.beginTransaction();

		String hql = "";
		String namePattern = "";
		String cleanedName = name.toLowerCase().replaceAll("\\s+", "");

		switch (matchType.toLowerCase()) {
		case "startswith":
			namePattern = cleanedName + "%";
			hql = "SELECT DISTINCT a.recipient FROM Appointment a " + "WHERE a.doctor.doctorId = :doctorId AND "
					+ "lower(replace(concat(a.recipient.firstName, a.recipient.lastName), ' ', '')) LIKE :name";
			break;

		case "contains":
			namePattern = "%" + cleanedName + "%";
			hql = "SELECT DISTINCT a.recipient FROM Appointment a " + "WHERE a.doctor.doctorId = :doctorId AND "
					+ "lower(replace(concat(a.recipient.firstName, a.recipient.lastName), ' ', '')) LIKE :name";
			break;

		default:
			tx.commit();
			session.close();
			return Collections.emptyList(); // invalid match type
		}

		List<com.infinite.jsf.recipient.model.Recipient> jsfRecipientList = session.createQuery(hql)
				.setParameter("doctorId", doctorId).setParameter("name", namePattern).list();

		tx.commit();
		session.close();

		List<Recipient> ejbRecipientList = new ArrayList<>();
		for (com.infinite.jsf.recipient.model.Recipient jsfRecipient : jsfRecipientList) {
			ejbRecipientList.add(Converter.convertToEJBRecipient(jsfRecipient));
		}

		return ejbRecipientList;
	}

	public List<Recipient> searchPatientsByExactName(String doctorId, String name) {
		Session session = sessionFactory.openSession();
		Transaction tx = session.beginTransaction();

		String cleanedName = name.toLowerCase().replaceAll("\\s+", "");

		String hql = "SELECT DISTINCT a.recipient FROM Appointment a " + "WHERE a.doctor.doctorId = :doctorId AND "
				+ "lower(replace(concat(a.recipient.firstName, a.recipient.lastName), ' ', '')) = :name";

		List<com.infinite.jsf.recipient.model.Recipient> jsfRecipientList = session.createQuery(hql)
				.setParameter("doctorId", doctorId).setParameter("name", cleanedName).list();

		tx.commit();
		session.close();

		List<Recipient> ejbRecipientList = new ArrayList<>();
		for (com.infinite.jsf.recipient.model.Recipient jsfRecipient : jsfRecipientList) {
			ejbRecipientList.add(Converter.convertToEJBRecipient(jsfRecipient));
		}

		return ejbRecipientList;
	}

	public List<Date> getPrescriptionDates(String prescriptionId) {
		List<Date> dates = new ArrayList<>();
		Session session = null;
		Transaction tx = null;

		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();

			// HQL to get only startDate and endDate
			Object[] result = (Object[]) session
					.createQuery("SELECT p.startDate, p.endDate FROM Prescription p WHERE p.prescriptionId = :id")
					.setParameter("id", prescriptionId).uniqueResult();

			if (result != null) {
				dates.add((Date) result[0]); // startDate
				dates.add((Date) result[1]); // endDate
			}

			tx.commit();
		} catch (Exception e) {
			if (tx != null)
				tx.rollback();
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}

		return dates;
	}

	public List<String> getMedicineNamesByPrescriptionId(String prescriptionId) {
		List<String> medicineNames = new ArrayList<>();
		Session session = null;
		Transaction tx = null;

		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();

			// HQL to fetch only medicine names
			List<String> result = session.createQuery(
					"SELECT pm.medicineName FROM PrescribedMedicines pm WHERE pm.prescription.prescriptionId = :prescriptionId")
					.setParameter("prescriptionId", prescriptionId).list();

			if (result != null) {
				medicineNames.addAll(result);
			}

			tx.commit();
		} catch (Exception e) {
			if (tx != null)
				tx.rollback();
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		System.out.println(medicineNames);
		return medicineNames;
	}

	public Date getPrescriptionWrittenOnDate(String prescriptionId) {
		Session session = sessionFactory.openSession();
		Date result = null;
		try {
			result = (Date) session.createQuery("SELECT p.writtenOn FROM Prescription p WHERE p.prescriptionId = :id")
					.setParameter("id", prescriptionId).uniqueResult();
		} finally {
			session.close();
		}
		return result;
	}

	public Date getProcedureEndDate(String procedureId) {
		Session session = sessionFactory.openSession();
		Date result = null;
		try {
			result = (Date) session.createQuery("SELECT p.toDate FROM MedicalProcedure p WHERE p.procedureId = :id")
					.setParameter("id", procedureId).uniqueResult();
		} finally {
			session.close();
		}
		return result;
	}

	public List<com.infinite.ejb.provider.model.Appointment> showBookedAppointments() {
		List<com.infinite.ejb.provider.model.Appointment> ejbAppointments = new ArrayList<>();

		Session session = sessionFactory.openSession();
		String hql = "FROM Appointment WHERE status = 'BOOKED'";
		List<com.infinite.jsf.provider.model.Appointment> jsfAppointmentList = session.createQuery(hql).list();

		for (com.infinite.jsf.provider.model.Appointment jsfAppointment : jsfAppointmentList) {
			com.infinite.ejb.provider.model.Appointment converted = Converter.convertToEJBAppointment(jsfAppointment);

			if (converted != null) {
				ejbAppointments.add(converted);
			}
		}

		return ejbAppointments;
	}

	public List<com.infinite.ejb.provider.model.Appointment> getBookedAppointments(String doctorId,
			String appointmentId) {

		List<com.infinite.ejb.provider.model.Appointment> ejbAppointments = new ArrayList<>();

		// Try-with-resources will auto-close the Session
		Session session = sessionFactory.openSession();
		StringBuilder hql = new StringBuilder().append("SELECT a ")
				.append("FROM com.infinite.jsf.provider.model.Appointment a ").append("JOIN FETCH a.doctor d ")
				.append("JOIN FETCH a.recipient r ").append("JOIN FETCH a.provider p ")
				.append("JOIN FETCH a.availability av ").append("WHERE a.status = :status ")
				.append("AND d.doctorId = :doctorId");

		if (appointmentId != null && !appointmentId.trim().isEmpty()) {
			hql.append(" AND a.appointmentId = :appointmentId");
		}

		// Create a typed query so getResultList() returns List<JSF Appointment>
		Query query = session.createQuery(hql.toString());

		query.setParameter("status", AppointmentStatus.BOOKED);
		query.setParameter("doctorId", doctorId);

		if (appointmentId != null && !appointmentId.trim().isEmpty()) {
			query.setParameter("appointmentId", appointmentId);
		}

		// This correctly returns the list of JSF-layer Appointments
		List<com.infinite.jsf.provider.model.Appointment> jsfAppointments = query.list();

		// Convert each to EJB-layer Appointment
		for (com.infinite.jsf.provider.model.Appointment jsf : jsfAppointments) {
			com.infinite.ejb.provider.model.Appointment ejb = Converter.convertToEJBAppointment(jsf);

			if (ejb != null) {
				ejbAppointments.add(ejb);
			}
		}

		return ejbAppointments;
	}

	public String updateAppointment(Appointment app) {
		Session session = sessionFactory.openSession();
		Transaction tx = null;
		tx = session.beginTransaction();
		System.out.println(app);
		if (app == null || app.getAppointmentId() == null) {
			return "Invalid appointment data";
		}
		// Load the existing appointment from the database
		com.infinite.jsf.provider.model.Appointment existing = (com.infinite.jsf.provider.model.Appointment) session
				.get(com.infinite.jsf.provider.model.Appointment.class, app.getAppointmentId());
		// Check if appointment exists and status is BOOKED

		if (existing != null && existing.getStatus()==com.infinite.jsf.provider.model.AppointmentStatus.BOOKED) {
			existing.setStatus(com.infinite.jsf.provider.model.AppointmentStatus.COMPLETED);
			session.update(existing); // update the entity
			tx.commit();
			session.close();
			System.out.println("appointment updated");
			return "Appointment updated to COMPLETED";
		} else {
			System.out.println("appointment not updated");
			tx.rollback();
			session.close();
			return "Appointment not found";
		}

		
	}
}
