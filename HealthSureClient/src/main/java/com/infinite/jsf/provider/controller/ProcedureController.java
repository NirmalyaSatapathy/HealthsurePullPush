package com.infinite.jsf.provider.controller;

import java.lang.reflect.Field;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import javax.servlet.ServletContext;

import com.infinite.ejb.provider.bean.ProviderEjbImpl;
import com.infinite.ejb.provider.model.Doctors;
import com.infinite.ejb.provider.model.MedicalProcedure;
import com.infinite.ejb.provider.model.MedicineType;
import com.infinite.ejb.provider.model.PrescribedMedicines;
import com.infinite.ejb.provider.model.Prescription;
import com.infinite.ejb.provider.model.ProcedureStatus;
import com.infinite.ejb.provider.model.ProcedureTest;
import com.infinite.ejb.provider.model.ProcedureType;
import com.infinite.ejb.provider.model.Provider;
import com.infinite.ejb.recipient.model.Recipient;
import com.infinite.jsf.provider.daoImpl.ProviderDaoImpl;
import com.infinite.jsf.provider.dto.ProcedureSlip;
import com.infinite.ejb.provider.model.ProcedureDailyLog;
import com.infinite.jsf.util.Converter;
import com.infinite.jsf.util.MailSend;
import com.infinite.jsf.util.ProcedureIdGenerator;
import com.infinite.ejb.provider.model.Appointment;

public class ProcedureController {
	private ProviderEjbImpl providerEjb;
	private ProviderDaoImpl providerDao;
	Prescription prescription;
	Prescription tempPrescription;
	MedicalProcedure procedure;
	MedicalProcedure tempProcedure=new MedicalProcedure();
	PrescribedMedicines prescribedMedicine;
	PrescribedMedicines tempMedicine;
	ProcedureTest procedureTest;
	ProcedureTest tempTest=new ProcedureTest();
	ProcedureDailyLog procedureLog;
	ProcedureDailyLog tempLog=new ProcedureDailyLog();
	List<Prescription> prescriptions = new ArrayList<Prescription>();
	List<PrescribedMedicines> prescribedMedicines = new ArrayList<PrescribedMedicines>();
	List<ProcedureTest> procedureTests = new ArrayList<ProcedureTest>();
	List<ProcedureDailyLog> procedureLogs = new ArrayList<ProcedureDailyLog>();
	private String procedureType; // "single" or "scheduled"
	private String doctorId;
	private String procedureId;
	private String appointmentId;
	private List<MedicalProcedure> scheduledProcedures;
	private List<MedicalProcedure> allInProgressProcedures;
	private List<MedicalProcedure> allScheduledProcedures; // complete data for sorting
	private List<Appointment> allBookedAppointments;
	private List<Appointment> bookedAppointments;
	private List<MedicalProcedure> inProgressProcedures;
	private Appointment procedureAppointment;
	private int currentPage = 1;
	private int pageSize = 3;
	private int totalPages;
	private String sortField;
	private boolean sortAscending = true;
	private boolean flag = true;
	private List<Prescription> viewPrescriptions=new ArrayList<Prescription>();
	private List<Prescription> currentPagePrescriptions = new ArrayList<>();
	private List<PrescribedMedicines> viewMedicines = new ArrayList<PrescribedMedicines>();
	private List<ProcedureTest> viewTests = new ArrayList<ProcedureTest>();
	private List<ProcedureDailyLog> viewLogs = new ArrayList<ProcedureDailyLog>();
	// Pagination variables
	private int prescriptionFirst = 0;
	private int prescriptionPageSize = 3; // Default page size
	// Pagination variables
	private int medicineFirst = 0;
	private int medicinePageSize = 3; // Default page size
	// Pagination variables
	private int testFirst = 0;
	private int testPageSize = 5; // Default page size
	private int logFirst = 0;
	private int logPageSize = 5; // Default page size

	// Getters and setters
	public int getLogFirst() {
	    return logFirst;
	}

	public void setLogFirst(int logFirst) {
	    this.logFirst = logFirst;
	}

	public int getLogPageSize() {
	    return logPageSize;
	}

	public void setLogPageSize(int logPageSize) {
	    this.logPageSize = logPageSize;
	}
	// Getters and setters
	public int getTestFirst() {
	    return testFirst;
	}

	public void setTestFirst(int testFirst) {
	    this.testFirst = testFirst;
	}

	public int getTestPageSize() {
	    return testPageSize;
	}

	public void setTestPageSize(int testPageSize) {
	    this.testPageSize = testPageSize;
	}
	// Getters and setters
	public int getMedicineFirst() {
	    return medicineFirst;
	}

	public void setMedicineFirst(int medicineFirst) {
	    this.medicineFirst = medicineFirst;
	}

	public int getMedicinePageSize() {
	    return medicinePageSize;
	}

	public void setMedicinePageSize(int medicinePageSize) {
	    this.medicinePageSize = medicinePageSize;
	}

	// Pagination methods
	public List<PrescribedMedicines> getPaginatedMedicines() {
	    if (viewMedicines == null || viewMedicines.isEmpty()) {
	        return Collections.emptyList();
	    }
	    int toIndex = Math.min(medicineFirst + medicinePageSize, viewMedicines.size());
	    return viewMedicines.subList(medicineFirst, toIndex);
	}

	public void nextMedicinePage() {
	    if (medicineFirst + medicinePageSize < viewMedicines.size()) {
	        medicineFirst += medicinePageSize;
	    }
	}

	// Pagination methods
	public List<ProcedureDailyLog> getPaginatedLogs() {
	    if (viewLogs == null || viewLogs.isEmpty()) {
	        return Collections.emptyList();
	    }
	    int toIndex = Math.min(logFirst + logPageSize, viewLogs.size());
	    return viewLogs.subList(logFirst, toIndex);
	}

	public void nextLogPage() {
	    if (logFirst + logPageSize < viewLogs.size()) {
	        logFirst += logPageSize;
	    }
	}

	public void previousLogPage() {
	    if (logFirst - logPageSize >= 0) {
	        logFirst -= logPageSize;
	    }
	}

	public boolean isLogHasNextPage() {
	    return logFirst + logPageSize < (viewLogs != null ? viewLogs.size() : 0);
	}

	public int getLogTotalPages() {
	    if (viewLogs == null || viewLogs.isEmpty()) {
	        return 0;
	    }
	    return (int) Math.ceil((double) viewLogs.size() / logPageSize);
	}

	public int getLogCurrentPage() {
	    return (logFirst / logPageSize) + 1;
	}
	public void previousMedicinePage() {
	    if (medicineFirst - medicinePageSize >= 0) {
	        medicineFirst -= medicinePageSize;
	    }
	}

	public boolean isMedicineHasNextPage() {
	    return medicineFirst + medicinePageSize < (viewMedicines != null ? viewMedicines.size() : 0);
	}

	public int getMedicineTotalPages() {
	    int size = viewMedicines != null ? viewMedicines.size() : 0;
	    return (int) Math.ceil((double) size / medicinePageSize);
	}

	public int getMedicineCurrentPage() {
	    return (medicineFirst / medicinePageSize) + 1;
	}
	// Pagination methods
	public List<ProcedureTest> getPaginatedTests() {
	    if (viewTests == null || viewTests.isEmpty()) {
	        return Collections.emptyList();
	    }
	    int toIndex = Math.min(testFirst + testPageSize, viewTests.size());
	    return viewTests.subList(testFirst, toIndex);
	}

	public void nextTestPage() {
	    if (testFirst + testPageSize < viewTests.size()) {
	        testFirst += testPageSize;
	    }
	}

	public void previousTestPage() {
	    if (testFirst - testPageSize >= 0) {
	        testFirst -= testPageSize;
	    }
	}

	public boolean isTestHasNextPage() {
	    return testFirst + testPageSize < (viewTests != null ? viewTests.size() : 0);
	}

	public int getTestTotalPages() {
	    if (viewTests == null || viewTests.isEmpty()) {
	        return 0;
	    }
	    return (int) Math.ceil((double) viewTests.size() / testPageSize);
	}

	public int getTestCurrentPage() {
	    return (testFirst / testPageSize) + 1;
	}
	 private String currentSort;
	// Getters and setters
	public int getPrescriptionFirst() {
	    return prescriptionFirst;
	}

	public void setPrescriptionFirst(int prescriptionFirst) {
	    this.prescriptionFirst = prescriptionFirst;
	}

	public String getCurrentSort() {
		return currentSort;
	}

	public void setCurrentSort(String currentSort) {
		this.currentSort = currentSort;
	}

	public int getPrescriptionPageSize() {
	    return prescriptionPageSize;
	}

	public void setPrescriptionPageSize(int prescriptionPageSize) {
	    this.prescriptionPageSize = prescriptionPageSize;
	}

	// Pagination methods
	public List<Prescription> getPaginatedPrescriptions() {
	    if (viewPrescriptions == null || viewPrescriptions.isEmpty()) {
	        return Collections.emptyList();
	    }
	    int toIndex = Math.min(prescriptionFirst + prescriptionPageSize, viewPrescriptions.size());
	    return viewPrescriptions.subList(prescriptionFirst, toIndex);
	}

	public void nextPrescriptionPage() {
	    if (prescriptionFirst + prescriptionPageSize < viewPrescriptions.size()) {
	        prescriptionFirst += prescriptionPageSize;
	    }
	}

	public void previousPrescriptionPage() {
	    if (prescriptionFirst - prescriptionPageSize >= 0) {
	        prescriptionFirst -= prescriptionPageSize;
	    }
	}

	public boolean isPrescriptionHasNextPage() {
	    return prescriptionFirst + prescriptionPageSize < (viewPrescriptions != null ? viewPrescriptions.size() : 0);
	}

	public int getPrescriptionTotalPages() {
	    int size = viewPrescriptions != null ? viewPrescriptions.size() : 0;
	    return (int) Math.ceil((double) size / prescriptionPageSize);
	}

	public int getPrescriptionCurrentPage() {
	    return (prescriptionFirst / prescriptionPageSize) + 1;
	}

	// Sorting methods (similar to InsuranceController)
	private boolean ascending = true;

	public boolean isAscending() {
	    return ascending;
	}

	public void setAscending(boolean ascending) {
	    this.ascending = ascending;
	}

	public void sortByAsc(String listType, String field) {
	    currentSort = "asc";
	    this.sortField = field;
	    this.ascending = true;
	    sortBy(listType);
	}

	public void sortByDesc(String listType, String field) {
	    currentSort = "desc";
	    this.sortField = field;
	    this.ascending = false;
	    sortBy(listType);
	}

	public void sortBy(String listType) {
	    if ("prescriptions".equals(listType)) {
	        prescriptionFirst = 0;
	        sortPrescriptionList();
	    }
	    if ("medicines".equals(listType)) {
	        medicineFirst = 0;
	        sortMedicineList();
	    }
	    if ("tests".equals(listType)) {
	        testFirst = 0;
	        sortTestList();
	    }
	    if ("logs".equals(listType)) {
	        logFirst = 0;
	        sortLogList();
	    }
	}
	private void sortLogList() {
	    if (viewLogs == null || sortField == null) return;

	    Collections.sort(viewLogs, (l1, l2) -> {
	        try {
	            Field f = l1.getClass().getDeclaredField(sortField);
	            f.setAccessible(true);
	            Object v1 = f.get(l1);
	            Object v2 = f.get(l2);

	            if (v1 == null || v2 == null) return 0;

	            // Special handling for vitals field
	            if ("vitals".equals(sortField)) {
	                // Extract numeric values from vitals strings if possible
	                Double num1 = extractNumericFromVitals(v1.toString());
	                Double num2 = extractNumericFromVitals(v2.toString());
	                
	                // If both contain numbers, compare numerically
	                if (num1 != null && num2 != null) {
	                    return ascending ? Double.compare(num1, num2) : Double.compare(num2, num1);
	                }
	                // Otherwise fall back to string comparison
	                return ascending ? v1.toString().compareTo(v2.toString()) 
	                               : v2.toString().compareTo(v1.toString());
	            }
	            else if (v1 instanceof Date && v2 instanceof Date) {
	                return ascending ? ((Date) v1).compareTo((Date) v2) : ((Date) v2).compareTo((Date) v1);
	            } 
	            else if (v1 instanceof Comparable && v2 instanceof Comparable) {
	                return ascending ? ((Comparable) v1).compareTo(v2) : ((Comparable) v2).compareTo(v1);
	            } 
	            else {
	                return 0;
	            }
	        } catch (Exception e) {
	            return 0;
	        }
	    });
	}

	// Helper method to extract numeric values from vitals strings
	private Double extractNumericFromVitals(String vitals) {
	    if (vitals == null || vitals.isEmpty()) {
	        return null;
	    }
	    
	    // Try to find the first numeric sequence in the string
	    java.util.regex.Matcher matcher = java.util.regex.Pattern.compile("\\d+\\.?\\d*").matcher(vitals);
	    if (matcher.find()) {
	        try {
	            return Double.parseDouble(matcher.group());
	        } catch (NumberFormatException e) {
	            return null;
	        }
	    }
	    return null;
	}
	private void sortTestList() {
	    if (viewTests == null || sortField == null) return;

	    Collections.sort(viewTests, (t1, t2) -> {
	        try {
	            Field f = t1.getClass().getDeclaredField(sortField);
	            f.setAccessible(true);
	            Object v1 = f.get(t1);
	            Object v2 = f.get(t2);

	            if (v1 == null || v2 == null) return 0;

	            if (v1 instanceof Date && v2 instanceof Date) {
	                return ascending ? ((Date) v1).compareTo((Date) v2) : ((Date) v2).compareTo((Date) v1);
	            } else if (v1 instanceof Comparable && v2 instanceof Comparable) {
	                return ascending ? ((Comparable) v1).compareTo(v2) : ((Comparable) v2).compareTo(v1);
	            } else {
	                return 0;
	            }
	        } catch (Exception e) {
	            return 0;
	        }
	    });
	}
	private void sortMedicineList() {
	    if (viewMedicines == null || sortField == null) return;

	    Collections.sort(viewMedicines, (m1, m2) -> {
	        try {
	            Field f = m1.getClass().getDeclaredField(sortField);
	            f.setAccessible(true);
	            Object v1 = f.get(m1);
	            Object v2 = f.get(m2);

	            if (v1 == null || v2 == null) return 0;

	            // Special handling for dosage field
	            if ("dosage".equals(sortField)) {
	                // Extract numeric values from dosage strings (e.g., "5mg" -> 5)
	                double num1 = extractNumericValue(v1.toString());
	                double num2 = extractNumericValue(v2.toString());
	                return ascending ? Double.compare(num1, num2) : Double.compare(num2, num1);
	            }
	            else if (v1 instanceof Date && v2 instanceof Date) {
	                return ascending ? ((Date) v1).compareTo((Date) v2) : ((Date) v2).compareTo((Date) v1);
	            } 
	            else if (v1 instanceof Comparable && v2 instanceof Comparable) {
	                return ascending ? ((Comparable) v1).compareTo(v2) : ((Comparable) v2).compareTo(v1);
	            } 
	            else {
	                return 0;
	            }
	        } catch (Exception e) {
	            return 0;
	        }
	    });
	}

	// Helper method to extract numeric value from dosage string
	private double extractNumericValue(String dosage) {
	    try {
	        // Remove all non-digit characters (except decimal point if needed)
	        String numericPart = dosage.replaceAll("[^0-9.]", "");
	        return Double.parseDouble(numericPart);
	    } catch (NumberFormatException e) {
	        return 0; // Return 0 if parsing fails
	    }
	
	}
	private void sortPrescriptionList() {
	    if (viewPrescriptions == null || sortField == null) return;

	    Collections.sort(viewPrescriptions, (p1, p2) -> {
	        try {
	            Field f = p1.getClass().getDeclaredField(sortField);
	            f.setAccessible(true);
	            Object v1 = f.get(p1);
	            Object v2 = f.get(p2);

	            if (v1 == null || v2 == null) return 0;

	            if (v1 instanceof Date && v2 instanceof Date) {
	                return ascending ? ((Date) v1).compareTo((Date) v2) : ((Date) v2).compareTo((Date) v1);
	            } else if (v1 instanceof Comparable && v2 instanceof Comparable) {
	                return ascending ? ((Comparable) v1).compareTo(v2) : ((Comparable) v2).compareTo(v1);
	            } else {
	                return 0;
	            }
	        } catch (Exception e) {
	            return 0;
	        }
	    });
	}
	// Getters and Setters for sorting
	public String getSortField() {
		return sortField;
	}

	public void setSortField(String sortField) {
		this.sortField = sortField;
	}

	public List<MedicalProcedure> getInProgressProcedures() {
		return inProgressProcedures;
	}

	public void setInProgressProcedures(List<MedicalProcedure> inProgressProcedures) {
		this.inProgressProcedures = inProgressProcedures;
	}

	public int getPageSize() {
		return pageSize;
	}

	public List<Prescription> getViewPrescriptions() {
		return viewPrescriptions;
	}

	public void setViewPrescriptions(List<Prescription> viewPrescriptions) {
		this.viewPrescriptions = viewPrescriptions;
	}

	public MedicalProcedure getTempProcedure() {
		return tempProcedure;
	}

	public void setTempProcedure(MedicalProcedure tempProcedure) {
		this.tempProcedure = tempProcedure;
	}

	public Prescription getTempPrescription() {
		return tempPrescription;
	}

	public void setTempPrescription(Prescription tempPrescription) {
		this.tempPrescription = tempPrescription;
	}

	public PrescribedMedicines getTempMedicine() {
		return tempMedicine;
	}

	public void setTempMedicine(PrescribedMedicines tempMedicine) {
		this.tempMedicine = tempMedicine;
	}

	public ProcedureTest getTempTest() {
		return tempTest;
	}

	public void setTempTest(ProcedureTest tempTest) {
		this.tempTest = tempTest;
	}

	public ProcedureDailyLog getTempLog() {
		return tempLog;
	}

	public void setTempLog(ProcedureDailyLog tempLog) {
		this.tempLog = tempLog;
	}

	public List<PrescribedMedicines> getViewMedicines() {
		return viewMedicines;
	}

	public void setViewMedicines(List<PrescribedMedicines> viewMedicines) {
		this.viewMedicines = viewMedicines;
	}

	public List<ProcedureTest> getViewTests() {
		return viewTests;
	}

	public void setViewTests(List<ProcedureTest> viewTests) {
		this.viewTests = viewTests;
	}

	public List<ProcedureDailyLog> getViewLogs() {
		return viewLogs;
	}

	public void setViewLogs(List<ProcedureDailyLog> viewLogs) {
		this.viewLogs = viewLogs;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getTotalPages() {
		return totalPages;
	}

	public void setTotalPages(int totalPages) {
		this.totalPages = totalPages;
	}

	public String getAppointmentId() {
		return appointmentId;
	}

	public void setAppointmentId(String appointmentId) {
		this.appointmentId = appointmentId;
	}

	public List<Appointment> getAllBookedAppointments() {
		return allBookedAppointments;
	}

	public void setAllBookedAppointments(List<Appointment> allBookedAppointments) {
		this.allBookedAppointments = allBookedAppointments;
	}

	public void setScheduledProcedures(List<MedicalProcedure> scheduledProcedures) {
		this.scheduledProcedures = scheduledProcedures;
	}

	public MedicalProcedure getProcedure() {
		return procedure;
	}

	public void setProcedure(MedicalProcedure procedure) {
		this.procedure = procedure;
	}

	public Prescription getPrescription() {
		return prescription;
	}

	public void setPrescription(Prescription prescription) {
		this.prescription = prescription;
	}

	public PrescribedMedicines getPrescribedMedicine() {
		return prescribedMedicine;
	}

	public void setPrescribedMedicine(PrescribedMedicines prescribedMedicine) {
		this.prescribedMedicine = prescribedMedicine;
	}

	public ProcedureTest getProcedureTest() {
		return procedureTest;
	}

	public List<Prescription> getPrescriptions() {
		return prescriptions;
	}

	public boolean isFlag() {
		return flag;
	}

	public void setFlag(boolean flag) {
		this.flag = flag;
	}

	public void setPrescriptions(List<Prescription> prescriptions) {
		this.prescriptions = prescriptions;
	}

	public List<PrescribedMedicines> getPrescribedMedicines() {
		return prescribedMedicines;
	}

	public void setPrescribedMedicines(List<PrescribedMedicines> prescribedMedicines) {
		this.prescribedMedicines = prescribedMedicines;
	}

	public List<ProcedureTest> getProcedureTests() {
		return procedureTests;
	}

	public void setProcedureTests(List<ProcedureTest> procedureTests) {
		this.procedureTests = procedureTests;
	}

	public List<ProcedureDailyLog> getProcedureLogs() {
		return procedureLogs;
	}

	public void setProcedureLogs(List<ProcedureDailyLog> procedureLogs) {
		this.procedureLogs = procedureLogs;
	}

	public void setProcedureTest(ProcedureTest procedureTest) {
		this.procedureTest = procedureTest;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public List<MedicalProcedure> getAllScheduledProcedures() {
		return allScheduledProcedures;
	}

	public void setAllScheduledProcedures(List<MedicalProcedure> allScheduledProcedures) {
		this.allScheduledProcedures = allScheduledProcedures;
	}

	public List<MedicalProcedure> getAllInProgressProcedures() {
		return allInProgressProcedures;
	}

	public List<Prescription> getCurrentPagePrescriptions() {
		return currentPagePrescriptions;
	}

	public void setCurrentPagePrescriptions(List<Prescription> currentPagePrescriptions) {
		this.currentPagePrescriptions = currentPagePrescriptions;
	}

	public void setAllInProgressProcedures(List<MedicalProcedure> allInProgressProcedures) {
		this.allInProgressProcedures = allInProgressProcedures;
	}

	// ✅ Getters & setters
	public String getDoctorId() {
		return doctorId;
	}

	public void setDoctorId(String doctorId) {
		this.doctorId = doctorId;
	}

	public String getProcedureId() {
		return procedureId;
	}

	public void setProcedureId(String procedureId) {
		this.procedureId = procedureId;
	}

	public List<Appointment> getBookedAppointments() {
		return bookedAppointments;
	}

	public void setBookedAppointments(List<Appointment> bookedAppointments) {
		this.bookedAppointments = bookedAppointments;
	}

	public List<MedicalProcedure> getScheduledProcedures() {
		return scheduledProcedures;
	}

	public Appointment getProcedureAppointment() {
		return procedureAppointment;
	}

	public void setProcedureAppointment(Appointment procedureAppointment) {
		this.procedureAppointment = procedureAppointment;
	}

	public String getProcedureType() {
		return procedureType;
	}

	public void setProcedureType(String procedureType) {
		this.procedureType = procedureType;
	}

	public ProcedureController() {
		super();
	}

	public ProviderEjbImpl getProviderEjb() {
		return providerEjb;
	}

	public void setProviderEjb(ProviderEjbImpl providerEjb) {
		this.providerEjb = providerEjb;
	}

	public ProviderDaoImpl getProviderDao() {
		return providerDao;
	}

	public void setProviderDao(ProviderDaoImpl providerDao) {
		this.providerDao = providerDao;
	}

	public ProcedureDailyLog getProcedureLog() {
		return procedureLog;
	}

	public void setProcedureLog(ProcedureDailyLog procedureLog) {
		this.procedureLog = procedureLog;
	}

	public String addSingleDayMedicalProcedureController(MedicalProcedure medicalProcedure)
			throws ClassNotFoundException, SQLException {
		providerDao = new ProviderDaoImpl();
		FacesContext context = FacesContext.getCurrentInstance();
		boolean isValid = true;

		String hId = medicalProcedure.getRecipient().gethId();
		if (medicalProcedure.getRecipient().gethId().isEmpty()) {
			context.addMessage("recipientId",
					new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid Patient", "Enter Recipient Id:HIDXXX"));
			context.validationFailed();
			isValid = false;
		}
		if (!medicalProcedure.getRecipient().gethId().matches("^[Hh][Ii][Dd]\\d{3}$")) {
			context.addMessage("recipientId", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid Patient",
					"Correct HealthId format is HIDXXX"));
			context.validationFailed();
			isValid = false;
		}
		if (medicalProcedure.getProvider().getProviderId().isEmpty()) {
			context.addMessage("providerId",
					new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid Provider", "Enter Provider Id:PROVXXX"));
			context.validationFailed();
			isValid = false;
		}
		if (!medicalProcedure.getProvider().getProviderId().matches("^[Pp][Rr][Oo][Vv]\\d{3}$")) {
			context.addMessage("providerId", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid Provider",
					"Correct ProviderId format is PROVXXX"));
			context.validationFailed();
			isValid = false;
		}
		if (medicalProcedure.getDoctor().getDoctorId().isEmpty()) {
			context.addMessage("doctorId",
					new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid Doctor", "Enter Doctor Id:DOCXXX"));
			context.validationFailed();
			isValid = false;
		}
		if (!medicalProcedure.getDoctor().getDoctorId().matches("^[Dd][Oo][Cc]\\d{3}$")) {
			context.addMessage("doctorId", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid Doctor",
					"Correct DoctorId format is DOCXXX"));
			context.validationFailed();
			isValid = false;
		}
		if (medicalProcedure.getAppointment().getAppointmentId().isEmpty()) {
			context.addMessage("appointmentId", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid Appointment",
					"Enter Appointment Id:APPXXX"));
			context.validationFailed();
			isValid = false;
		}
		if (!medicalProcedure.getAppointment().getAppointmentId().matches("^[Aa][Pp][Pp]\\d{3}$")) {
			context.addMessage("appointmentId", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid Appointment",
					"Correct AppointmentID format is APPXXX"));
			context.validationFailed();
			isValid = false;
		}
		if (medicalProcedure.getDiagnosis().isEmpty()) {
			context.addMessage("diagnosis",
					new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid diagnosis", "Enter the diagnosis"));
			context.validationFailed();
			isValid = false;
		}
		if (!isValid)
			return null;
		Recipient recipient = providerDao.searchRecipientByHealthId(hId);
		if (recipient == null || !recipient.gethId().equalsIgnoreCase(hId)) {
			context.addMessage("recipientId", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid Patient",
					"Recipient with given Health ID not found."));
			context.validationFailed();
			isValid = false;
		}

		String providerId = medicalProcedure.getProvider().getProviderId();
		Provider provider = providerDao.searchProviderById(providerId);
		if (provider == null || !provider.getProviderId().equalsIgnoreCase(providerId)) {
			context.addMessage("providerId", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid Provider",
					"Provider with given ID not found."));
			context.validationFailed();
			isValid = false;
		}

		String doctorId = medicalProcedure.getDoctor().getDoctorId();
		Doctors doctor = providerDao.searchDoctorById(doctorId);
		if (doctor == null || !doctor.getDoctorId().equalsIgnoreCase(doctorId)) {
			context.addMessage("doctorId",
					new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid Doctor", "Doctor with given ID not found."));
			context.validationFailed();
			isValid = false;
		}

		String appointmentId = medicalProcedure.getAppointment().getAppointmentId();
		Appointment appointment = providerDao.searchAppointmentById(appointmentId);
		if (appointment == null || !appointment.getAppointmentId().equalsIgnoreCase(appointmentId)) {
			context.addMessage("appointmentId", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid Appointment",
					"Appointment with given ID not found."));
			context.validationFailed();
			isValid = false;
		} else {
			if (!appointment.getProvider().getProviderId().equalsIgnoreCase(providerId)) {
				context.addMessage("providerId", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Mismatch",
						"This appointment does not belong to the selected provider."));
				context.validationFailed();
				isValid = false;
			}
			if (!appointment.getDoctor().getDoctorId().equalsIgnoreCase(doctorId)) {
				context.addMessage("doctorId", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Mismatch",
						"This appointment does not involve the selected doctor."));
				context.validationFailed();
				isValid = false;
			}
			if (!appointment.getRecipient().gethId().equalsIgnoreCase(hId)) {
				context.addMessage("recipientId", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Mismatch",
						"This appointment is not for the selected patient."));
				context.validationFailed();
				isValid = false;
			}
		}

		// Validate Diagnosis
		if (medicalProcedure.getDiagnosis() == null || medicalProcedure.getDiagnosis().trim().length() < 2) {
			context.addMessage("diagnosis", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid Diagnosis",
					"Diagnosis must contain at least 2 letters."));
			context.validationFailed();
			isValid = false;
		}

		Date procedureDate = medicalProcedure.getProcedureDate();
		Date today = new Date();
		if (procedureDate == null) {
			context.addMessage("procedureDate",
					new FacesMessage(FacesMessage.SEVERITY_ERROR, "Missing Date", "Procedure Date is required."));
			context.validationFailed();
			isValid = false;
		} else if (procedureDate.after(today)) {
			context.addMessage("procedureDate", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid Date",
					"Procedure Date cannot be in the future."));
			context.validationFailed();
			isValid = false;
		}

		if (!isValid)
			return null;
		medicalProcedure.setRecipient(recipient);
		medicalProcedure.setDoctor(doctor);
		medicalProcedure.setFromDate(null);
		medicalProcedure.setToDate(null);
		medicalProcedure.setScheduledDate(null);
		medicalProcedure.setType(ProcedureType.SINGLE_DAY);
		medicalProcedure.setProcedureStatus(ProcedureStatus.COMPLETED);
		return "ProcedureDashboard?faces-redirect=true";
	}

	public String addScheduledMedicalProcedureController(MedicalProcedure medicalProcedure)
			throws ClassNotFoundException, SQLException {
		providerDao = new ProviderDaoImpl();
		FacesContext context = FacesContext.getCurrentInstance();
		boolean isValid = true;
		if (medicalProcedure.getRecipient().gethId().isEmpty()) {
			context.addMessage("recipientId",
					new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid Patient", "Enter Recipient Id:HIDXXX"));
			context.validationFailed();
			isValid = false;
		}
		if (!medicalProcedure.getRecipient().gethId().matches("^[Hh][Ii][Dd]\\d{3}$")) {
			context.addMessage("recipientId", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid Patient",
					"Correct HealthId format is HIDXXX"));
			context.validationFailed();
			isValid = false;
		}
		if (medicalProcedure.getProvider().getProviderId().isEmpty()) {
			context.addMessage("providerId",
					new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid Provider", "Enter Provider Id:PROVXXX"));
			context.validationFailed();
			isValid = false;
		}
		if (!medicalProcedure.getProvider().getProviderId().matches("^[Pp][Rr][Oo][Vv]\\d{3}$")) {
			context.addMessage("providerId", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid Provider",
					"Correct ProviderId format is PROVXXX"));
			context.validationFailed();
			isValid = false;
		}
		if (medicalProcedure.getDoctor().getDoctorId().isEmpty()) {
			context.addMessage("doctorId",
					new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid Doctor", "Enter Doctor Id:DOCXXX"));
			context.validationFailed();
			isValid = false;
		}
		if (!medicalProcedure.getDoctor().getDoctorId().matches("^[Dd][Oo][Cc]\\d{3}$")) {
			context.addMessage("doctorId", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid Doctor",
					"Correct DoctorId format is DOCXXX"));
			context.validationFailed();
			isValid = false;
		}
		if (medicalProcedure.getAppointment().getAppointmentId().isEmpty()) {
			context.addMessage("appointmentId", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid Appointment",
					"Enter Appointment Id:APPXXX"));
			context.validationFailed();
			isValid = false;
		}
		if (!medicalProcedure.getAppointment().getAppointmentId().matches("^[Aa][Pp][Pp]\\d{3}$")) {
			context.addMessage("appointmentId", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid Appointment",
					"Correct AppointmentID format is APPXXX"));
			context.validationFailed();
			isValid = false;
		}
		if (medicalProcedure.getDiagnosis().isEmpty()) {
			context.addMessage("diagnosis",
					new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid Diagnosis", "Enter the diagnosis"));
			context.validationFailed();
			isValid = false;
		}
		if (!isValid)
			return null;
		if (!providerEjb.generateNewProcedureId().equals(medicalProcedure.getProcedureId())) {
			context.addMessage("procedureId", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid procedure",
					"procedure with given Id exists"));
			context.validationFailed();
			isValid = false;
		}
		String hId = medicalProcedure.getRecipient().gethId();
		Recipient recipient = providerDao.searchRecipientByHealthId(hId);
		if (recipient == null || !recipient.gethId().equalsIgnoreCase(hId)) {
			context.addMessage("recipientId", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid Patient",
					"Recipient with given Health ID not found."));
			context.validationFailed();
			isValid = false;
		}

		String providerId = medicalProcedure.getProvider().getProviderId();
		Provider provider = providerDao.searchProviderById(providerId);
		if (provider == null || !provider.getProviderId().equalsIgnoreCase(providerId)) {
			context.addMessage("providerId", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid Provider",
					"Provider with given ID not found."));
			context.validationFailed();
			isValid = false;
		}

		String doctorId = medicalProcedure.getDoctor().getDoctorId();
		Doctors doctor = providerDao.searchDoctorById(doctorId);
		if (doctor == null || !doctor.getDoctorId().equalsIgnoreCase(doctorId)) {
			context.addMessage("doctorId",
					new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid Doctor", "Doctor with given ID not found."));
			context.validationFailed();
			isValid = false;
		}

		String appointmentId = medicalProcedure.getAppointment().getAppointmentId();
		Appointment appointment = providerDao.searchAppointmentById(appointmentId);
		if (appointment == null || !appointment.getAppointmentId().equalsIgnoreCase(appointmentId)) {
			context.addMessage("appointmentId", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid Appointment",
					"Appointment with given ID not found."));
			context.validationFailed();
			isValid = false;
		} else {
			if (!appointment.getProvider().getProviderId().equalsIgnoreCase(providerId)) {
				context.addMessage("providerId", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Mismatch",
						"This appointment does not belong to the selected provider."));
				context.validationFailed();
				isValid = false;
			}
			if (!appointment.getDoctor().getDoctorId().equalsIgnoreCase(doctorId)) {
				context.addMessage("doctorId", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Mismatch",
						"This appointment does not involve the selected doctor."));
				context.validationFailed();
				isValid = false;
			}
			if (!appointment.getRecipient().gethId().equalsIgnoreCase(hId)) {
				context.addMessage("recipientId", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Mismatch",
						"This appointment is not for the selected patient."));
				context.validationFailed();
				isValid = false;
			}
		}

		// Validate Diagnosis
		if (medicalProcedure.getDiagnosis() == null || medicalProcedure.getDiagnosis().trim().length() < 2) {
			context.addMessage("diagnosis", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid Diagnosis",
					"Diagnosis must contain at least 2 letters."));
			context.validationFailed();
			isValid = false;
		}

		Date scheduledDate = medicalProcedure.getScheduledDate();
		Date today = new Date();
		if (scheduledDate == null) {
			context.addMessage("scheduledDate",
					new FacesMessage(FacesMessage.SEVERITY_ERROR, "Missing Date", "Scheduled Date is required."));
			context.validationFailed();
			isValid = false;
		} else if (!scheduledDate.after(today)) {
			context.addMessage("scheduledDate", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid Date",
					"Scheduled Date must be in the future."));
			context.validationFailed();
			isValid = false;
		}

		if (!isValid)
			return null;
		medicalProcedure.setRecipient(recipient);
		medicalProcedure.setDoctor(doctor);
		medicalProcedure.setProcedureDate(null);
		medicalProcedure.setFromDate(null);
		medicalProcedure.setToDate(null);
		medicalProcedure.setType(ProcedureType.LONG_TERM);
		medicalProcedure.setProcedureStatus(ProcedureStatus.SCHEDULED);
		this.tempProcedure=medicalProcedure;
		String res = providerEjb.addMedicalProcedure(medicalProcedure);
		return res;
	}

	public String addInProgressMedicalProcedureController(MedicalProcedure medicalProcedure)
			throws ClassNotFoundException, SQLException {
		providerDao = new ProviderDaoImpl();
		FacesContext context = FacesContext.getCurrentInstance();
		boolean isValid = true;

		String hId = medicalProcedure.getRecipient().gethId();
		if (medicalProcedure.getRecipient().gethId().isEmpty()) {
			context.addMessage("recipientId",
					new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid Patient", "Enter Recipient Id:HIDXXX"));
			context.validationFailed();
			isValid = false;
		}
		if (!medicalProcedure.getRecipient().gethId().matches("^[Hh][Ii][Dd]\\d{3}$")) {
			context.addMessage("recipientId", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid Patient",
					"Correct HealthId format is HIDXXX"));
			context.validationFailed();
			isValid = false;
		}
		if (medicalProcedure.getProvider().getProviderId().isEmpty()) {
			context.addMessage("providerId",
					new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid Provider", "Enter Provider Id:PROVXXX"));
			context.validationFailed();
			isValid = false;
		}
		if (!medicalProcedure.getProvider().getProviderId().matches("^[Pp][Rr][Oo][Vv]\\d{3}$")) {
			context.addMessage("providerId", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid Provider",
					"Correct ProviderId format is PROVXXX"));
			context.validationFailed();
			isValid = false;
		}
		if (medicalProcedure.getDoctor().getDoctorId().isEmpty()) {
			context.addMessage("doctorId",
					new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid Doctor", "Enter Doctor Id:DOCXXX"));
			context.validationFailed();
			isValid = false;
		}
		if (!medicalProcedure.getDoctor().getDoctorId().matches("^[Dd][Oo][Cc]\\d{3}$")) {
			context.addMessage("doctorId", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid Doctor",
					"Correct DoctorId format is DOCXXX"));
			context.validationFailed();
			isValid = false;
		}
		if (medicalProcedure.getAppointment().getAppointmentId().isEmpty()) {
			context.addMessage("appointmentId", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid Appointment",
					"Enter Appointment Id:APPXXX"));
			context.validationFailed();
			isValid = false;
		}
		if (!medicalProcedure.getAppointment().getAppointmentId().matches("^[Aa][Pp][Pp]\\d{3}$")) {
			context.addMessage("appointmentId", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid Appointment",
					"Correct AppointmentID format is APPXXX"));
			context.validationFailed();
			isValid = false;
		}
		if (medicalProcedure.getDiagnosis().isEmpty()) {
			context.addMessage("diagnosis",
					new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid diagnosis", "Enter the diagnosis"));
			context.validationFailed();
			isValid = false;
		}
		if (!isValid)
			return null;
		Recipient recipient = providerDao.searchRecipientByHealthId(hId);
		if (recipient == null || !recipient.gethId().equalsIgnoreCase(hId)) {
			context.addMessage("recipientId", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid Patient",
					"Recipient with given Health ID not found."));
			context.validationFailed();
			isValid = false;
		}

		String providerId = medicalProcedure.getProvider().getProviderId();
		Provider provider = providerDao.searchProviderById(providerId);
		if (provider == null || !provider.getProviderId().equalsIgnoreCase(providerId)) {
			context.addMessage("providerId", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid Provider",
					"Provider with given ID not found."));
			context.validationFailed();
			isValid = false;
		}

		String doctorId = medicalProcedure.getDoctor().getDoctorId();
		Doctors doctor = providerDao.searchDoctorById(doctorId);
		if (doctor == null || !doctor.getDoctorId().equalsIgnoreCase(doctorId)) {
			context.addMessage("doctorId",
					new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid Doctor", "Doctor with given ID not found."));
			context.validationFailed();
			isValid = false;
		}

		String appointmentId = medicalProcedure.getAppointment().getAppointmentId();
		Appointment appointment = providerDao.searchAppointmentById(appointmentId);
		if (appointment == null || !appointment.getAppointmentId().equalsIgnoreCase(appointmentId)) {
			context.addMessage("appointmentId", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid Appointment",
					"Appointment with given ID not found."));
			context.validationFailed();
			isValid = false;
		} else {
			if (!appointment.getProvider().getProviderId().equalsIgnoreCase(providerId)) {
				context.addMessage("providerId", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Mismatch",
						"This appointment does not belong to the selected provider."));
				context.validationFailed();
				isValid = false;
			}
			if (!appointment.getDoctor().getDoctorId().equalsIgnoreCase(doctorId)) {
				context.addMessage("doctorId", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Mismatch",
						"This appointment does not involve the selected doctor."));
				context.validationFailed();
				isValid = false;
			}
			if (!appointment.getRecipient().gethId().equalsIgnoreCase(hId)) {
				context.addMessage("recipientId", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Mismatch",
						"This appointment is not for the selected patient."));
				context.validationFailed();
				isValid = false;
			}
		}
		Date fromDate = medicalProcedure.getFromDate();
		Date today = new Date();
		if (fromDate == null) {
			context.addMessage("fromDate",
					new FacesMessage(FacesMessage.SEVERITY_ERROR, "Missing Date", "from Date is required."));
			context.validationFailed();
			isValid = false;
		} else if (fromDate.after(today)) {
			context.addMessage("fromDate",
					new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid Date", "fromDate cant be in the future."));
			context.validationFailed();
			isValid = false;
		}
		// Validate Diagnosis
		if (medicalProcedure.getDiagnosis() == null || medicalProcedure.getDiagnosis().trim().length() < 2) {
			context.addMessage("diagnosis", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid Diagnosis",
					"Diagnosis must contain at least 2 letters."));
			context.validationFailed();
			isValid = false;
		}

		if (!isValid)
			return null;
		medicalProcedure.setRecipient(recipient);
		medicalProcedure.setDoctor(doctor);
		medicalProcedure.setScheduledDate(null);
		medicalProcedure.setProcedureDate(null);
		medicalProcedure.setToDate(null);
		medicalProcedure.setType(ProcedureType.LONG_TERM);
		medicalProcedure.setProcedureStatus(ProcedureStatus.IN_PROGRESS);
		this.tempProcedure=medicalProcedure;
		return "LongTermProcedureDashboard?faces-redirect=true";
	}

	public String addTestController(ProcedureTest procedureTest) throws ClassNotFoundException, SQLException {
	    procedureTests.removeIf(p -> p.getTestId().equals(procedureTest.getTestId()));
	    FacesContext context = FacesContext.getCurrentInstance();
	    Map<String, Object> sessionMap = context.getExternalContext().getSessionMap();
	    boolean isValid = true;
	    providerDao = new ProviderDaoImpl();

	    procedureTest.setPrescription(prescription);

	    // 1. Validate Test Name
	    String testName = procedureTest.getTestName();
	    if (testName.isEmpty()) {
	        context.addMessage("testName", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Enter Test name", null));
	        context.validationFailed();
	        isValid = false;
	    }

	    if (procedureTest.getTestDate() == null) {
	        context.addMessage("testDate", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Enter Test Date", null));
	        context.validationFailed();
	        isValid = false;
	    }

	    if (procedureTest.getResultSummary().isEmpty()) {
	        context.addMessage("resultSummary",
	                new FacesMessage(FacesMessage.SEVERITY_ERROR, "Enter Result summary", null));
	        context.validationFailed();
	        isValid = false;
	    }

	    if (!isValid)
	        return null;

	    // Check valid name format
	    if (testName == null || testName.trim().length() < 2 || !testName.matches("^[a-zA-Z0-9 ()/\\-.]+$")) {
	        context.addMessage("testName", new FacesMessage(FacesMessage.SEVERITY_ERROR,
	                "Test name must be at least 2 characters and contain only letters, numbers, spaces, (), /, -, and .",
	                null));
	        context.validationFailed();
	        isValid = false;
	    }

	    // Normalize test name
	    testName = testName.trim().replaceAll("\\s+", " ");
	    procedureTest.setTestName(testName);

	    // Check for duplicate test entry
	    loadViewTests(prescription);
	    for (ProcedureTest existingTest : viewTests) {
	        if (existingTest.getPrescription() != null
	                && existingTest.getPrescription().getPrescriptionId().equals(prescription.getPrescriptionId())
	                && existingTest.getTestName() != null && existingTest.getTestName().equalsIgnoreCase(testName)
	                && existingTest.getTestDate().equals(procedureTest.getTestDate())) {
	            context.addMessage("testName", new FacesMessage(FacesMessage.SEVERITY_ERROR,
	                    "This Test is already prescribed in this prescription for the given date.", null));
	            context.validationFailed();
	            isValid = false;
	        }
	    }

	    // 2. Validate Test Date Range
	    Date testDate = procedureTest.getTestDate();
	    Date prescriptionStart = prescription.getStartDate();
	    Date prescriptionEnd = prescription.getEndDate();

	    if (testDate.before(prescriptionStart)) {
	        context.addMessage("testDate", new FacesMessage(FacesMessage.SEVERITY_ERROR,
	                "Test date (" + formatDate(testDate) + ") cannot be before prescription start date (" + formatDate(prescriptionStart) + ").",
	                null));
	        context.validationFailed();
	        isValid = false;
	    }

	    if (testDate.after(prescriptionEnd)) {
	        context.addMessage("testDate", new FacesMessage(FacesMessage.SEVERITY_ERROR,
	                "Test date (" + formatDate(testDate) + ") cannot be after prescription end date (" + formatDate(prescriptionEnd) + ").",
	                null));
	        context.validationFailed();
	        isValid = false;
	    }

	    // 3. Validate Result Summary again (redundant but preserved)
	    String result = procedureTest.getResultSummary();
	    if (result.isEmpty()) {
	        context.addMessage("resultSummary",
	                new FacesMessage(FacesMessage.SEVERITY_ERROR, "Enter Result summary", null));
	        context.validationFailed();
	        isValid = false;
	    }

	    if (!isValid)
	        return null;

	    procedureTests.add(procedureTest);
	    return "PrescriptionDashboard?faces-redirect=true";
	}

	public String addPresribedMedicinesController(PrescribedMedicines prescribedMedicine)
	        throws ClassNotFoundException, SQLException {
	    prescribedMedicines.removeIf(p -> p.getPrescribedId().equals(prescribedMedicine.getPrescribedId()));
	    FacesContext context = FacesContext.getCurrentInstance();
	    Map<String, Object> sessionMap = context.getExternalContext().getSessionMap();
	    boolean isValid = true;
	    providerDao = new ProviderDaoImpl();
	    prescribedMedicine.setPrescription(prescription);

	    // 1. Medicine Name Validation
	    String medicineName = prescribedMedicine.getMedicineName();
	    if (medicineName == null || medicineName.trim().isEmpty()) {
	        context.addMessage("medicineName",
	                new FacesMessage(FacesMessage.SEVERITY_ERROR, "Enter medicine name", null));
	        context.validationFailed();
	        isValid = false;
	    }

	    if (prescribedMedicine.getDosage() == null || prescribedMedicine.getDosage().trim().isEmpty()) {
	        context.addMessage("dosage", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Enter dosage", null));
	        context.validationFailed();
	        isValid = false;
	    }

	    if (prescribedMedicine.getStartDate() == null) {
	        context.addMessage("startDate", new FacesMessage(FacesMessage.SEVERITY_ERROR,
	                "Enter from which date to start taking medicine", null));
	        context.validationFailed();
	        isValid = false;
	    }

	    if (prescribedMedicine.getDuration() == null || prescribedMedicine.getDuration().trim().isEmpty()) {
	        context.addMessage("duration", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Enter duration", null));
	        context.validationFailed();
	        isValid = false;
	    }

	    if (prescribedMedicine.getType() == null) {
	        context.addMessage("type", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Enter Medicine type", null));
	        context.validationFailed();
	        isValid = false;
	    }

	    if (!isValid) return null;

	    if (!medicineName.matches("^[a-zA-Z0-9()\\-+/'. ]{2,50}$")) {
	        context.addMessage("medicineName", new FacesMessage(FacesMessage.SEVERITY_ERROR,
	                "Medicine name must be 2–50 characters and can include letters, digits, -, /, +, (), '.', and spaces.",
	                null));
	        context.validationFailed();
	        isValid = false;
	    }

	    // Normalize medicine name
	    medicineName = medicineName.trim().replaceAll("\\s+", " ");
	    prescribedMedicine.setMedicineName(medicineName);

	    // 2. Check for duplicate medicine in same prescription
	    loadViewMedicines(prescription);
	    for (PrescribedMedicines existingMed : viewMedicines) {
	        if (existingMed.getPrescription() != null
	                && existingMed.getPrescription().getPrescriptionId().equals(prescription.getPrescriptionId())
	                && existingMed.getMedicineName() != null
	                && existingMed.getMedicineName().equalsIgnoreCase(medicineName)) {
	            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	            String currentStart = sdf.format(Converter.truncateTime(prescribedMedicine.getStartDate()));
	            String existingStart = sdf.format(Converter.truncateTime(existingMed.getStartDate()));
	            Date medEndTemp = null;

	            try {
	                int duration = Integer.parseInt(prescribedMedicine.getDuration().trim());
	                Calendar cal = Calendar.getInstance();
	                cal.setTime(prescribedMedicine.getStartDate());
	                cal.add(Calendar.DATE, duration - 1);
	                medEndTemp = cal.getTime();
	                prescribedMedicine.setEndDate(medEndTemp);
	            } catch (Exception e) {
	                context.addMessage("duration", new FacesMessage(FacesMessage.SEVERITY_ERROR,
	                        "Invalid duration format for calculation.", null));
	                context.validationFailed();
	                return null;
	            }

	            String currentEnd = sdf.format(Converter.truncateTime(medEndTemp));
	            String existingEnd = sdf.format(Converter.truncateTime(existingMed.getEndDate()));

	            if (currentStart.equals(existingStart) && currentEnd.equals(existingEnd)
	                    && existingMed.getType().equals(prescribedMedicine.getType())) {
	                context.addMessage("medicineName", new FacesMessage(FacesMessage.SEVERITY_ERROR,
	                        "This medicine is already prescribed in this prescription for the same date range and type",
	                        null));
	                context.validationFailed();
	                isValid = false;
	            }
	        }
	    }

	    // 3. Dosage Validation
	    String dosage = prescribedMedicine.getDosage();
	    MedicineType type = prescribedMedicine.getType();
	    String pattern = "";
	    String format = "";
	    switch (type) {
	        case TABLET:
	            pattern = "^\\d+\\s*tablet(s)?$";
	            format = "tablets";
	            break;
	        case SYRUP:
	            pattern = "^\\d+(\\.\\d+)?\\s*ml$";
	            format = "ml";
	            break;
	        case INJECTION:
	            pattern = "^(\\d+(\\.\\d+)?\\s*ml|\\d+\\s*dose(s)?)$";
	            format = "ml/dose";
	            break;
	        case DROP:
	            pattern = "^\\d+\\s*drop(s)?$";
	            format = "drops";
	            break;
	        default:
	            context.addMessage("type",
	                    new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid or missing medicine type.", null));
	            context.validationFailed();
	            isValid = false;
	    }

	    if (!dosage.trim().toLowerCase().matches(pattern)) {
	        context.addMessage("dosage", new FacesMessage(FacesMessage.SEVERITY_ERROR,
	                "Dosage format is invalid for " + type + " type: " + format, null));
	        context.validationFailed();
	        isValid = false;
	    }

	    // 4. Prescription Dates and Duration Calculation
	    Date prescriptionStart = prescription.getStartDate();
	    Date prescriptionEnd = prescription.getEndDate();
	    Date medStart = prescribedMedicine.getStartDate();
	    Date medEnd = null;
	    long durationDays = 0;

	    try {
	        durationDays = Long.parseLong(prescribedMedicine.getDuration().trim());

	        if (durationDays <= 0) {
	            context.addMessage("duration", new FacesMessage(FacesMessage.SEVERITY_ERROR,
	                    "Duration must be a positive integer.", null));
	            context.validationFailed();
	            isValid = false;
	        } else {
	            // Calculate end date from duration
	            Calendar cal = Calendar.getInstance();
	            cal.setTime(medStart);
	            cal.add(Calendar.DATE, (int) durationDays - 1); // inclusive
	            medEnd = cal.getTime();
	            prescribedMedicine.setEndDate(medEnd);
	        }
	    } catch (NumberFormatException e) {
	        context.addMessage("duration",
	                new FacesMessage(FacesMessage.SEVERITY_ERROR, "Duration must be a valid integer number.", null));
	        context.validationFailed();
	        isValid = false;
	    }

	    if (medStart.before(prescriptionStart)) {
	        context.addMessage("startDate", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Start date (" + medStart
	                + ") cannot be before prescription start date (" + prescriptionStart + ").", null));
	        context.validationFailed();
	        isValid = false;
	    }

	    if (medStart.after(prescriptionEnd)) {
	        context.addMessage("startDate", new FacesMessage(FacesMessage.SEVERITY_ERROR,
	                "Start date (" + medStart + ") cannot be after prescription end date (" + prescriptionEnd + ").",
	                null));
	        context.validationFailed();
	        isValid = false;
	    }

	    if (medEnd != null && medEnd.after(prescriptionEnd)) {
	        // Calculate the maximum valid duration from start date to prescription end date
	        long maxAllowedDuration = (prescriptionEnd.getTime() - medStart.getTime()) / (1000 * 60 * 60 * 24) + 1;

	        // Format the dates
	        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
	        String formattedMedStart = sdf.format(medStart);
	        String formattedPrescriptionEnd = sdf.format(prescriptionEnd);

	        context.addMessage("duration", new FacesMessage(FacesMessage.SEVERITY_ERROR,
	                "The given duration falls outside the prescription period. Maximum allowed duration from "
	                        + formattedMedStart + " to " + formattedPrescriptionEnd + " is " + maxAllowedDuration + " days.",
	                null));
	        context.validationFailed();
	        isValid = false;
	    }
	    if (!isValid)
	        return null;

	    prescribedMedicines.add(prescribedMedicine);
	    return "PrescriptionDashboard?faces-redirect=true";
	}

	public String addPrescriptionController(Prescription prescription) throws ClassNotFoundException, SQLException {

	    prescriptions.removeIf(p -> p.getPrescriptionId().equals(prescription.getPrescriptionId()));
	    FacesContext context = FacesContext.getCurrentInstance();
	    boolean isValid = true;

	    prescription.setProcedure(procedure);
	    prescription.setProvider(procedure.getProvider());
	    prescription.setDoctor(procedure.getDoctor());
	    prescription.setRecipient(procedure.getRecipient());

	    if (procedure.getType() != ProcedureType.SINGLE_DAY) {
	        if (prescription.getWrittenOn() == null) {
	            context.addMessage("writtenOn", new FacesMessage(FacesMessage.SEVERITY_ERROR,
	                    "Please enter the Prescription Written On date.", null));
	            context.validationFailed();
	            isValid = false;
	        }

	        if (prescription.getPrescribedDoc().getDoctorId() == null
	                || prescription.getPrescribedDoc().getDoctorId().isEmpty()) {
	            context.addMessage("prescribedBy", new FacesMessage(FacesMessage.SEVERITY_ERROR,
	                    "Please enter the Doctor who prescribed", null));
	            context.validationFailed();
	            isValid = false;
	        }

	        if (prescription.getPrescribedDoc().getDoctorId() != null
	                && !prescription.getPrescribedDoc().getDoctorId().isEmpty()) {
	            Doctors procedureDoctor = providerDao.searchDoctorById(procedure.getDoctor().getDoctorId());
	            Doctors prescriptionDoctor = providerDao.searchDoctorById(prescription.getPrescribedDoc().getDoctorId());

	            if (!procedureDoctor.getSpecialization().equals(prescriptionDoctor.getSpecialization())) {
	                context.addMessage("prescribedBy", new FacesMessage(FacesMessage.SEVERITY_ERROR,
	                        "Doctor specialization does not match with " + procedureDoctor.getSpecialization(), null));
	                context.validationFailed();
	                isValid = false;
	            } else {
	                prescription.setPrescribedDoc(prescriptionDoctor);
	            }
	        }
	    }

	    if (prescription.getStartDate() == null) {
	        context.addMessage("startDate", new FacesMessage(FacesMessage.SEVERITY_ERROR,
	                "Please enter the Prescription Start date.", null));
	        context.validationFailed();
	        isValid = false;
	    }

	    if (prescription.getEndDate() == null) {
	        context.addMessage("endDate", new FacesMessage(FacesMessage.SEVERITY_ERROR,
	                "Please enter the Prescription End date.", null));
	        context.validationFailed();
	        isValid = false;
	    }

	    if (!isValid) return null;

	    ProcedureType procedureType = procedure.getType();
	    ProcedureStatus procedureStatus = procedure.getProcedureStatus();
	    Date procedureDate = procedure.getProcedureDate();
	    Date fromDate = procedure.getFromDate();

	    if (procedureType == null) {
	        context.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,
	                "Missing Procedure Type for Procedure ID: " + procedureId, null));
	        context.validationFailed();
	        isValid = false;
	    }

	    if (procedureType == ProcedureType.SINGLE_DAY) {
	        prescription.setWrittenOn(procedureDate);
	        prescription.getPrescribedDoc().setDoctorId(prescription.getDoctor().getDoctorId());
	        prescription.getPrescribedDoc().setDoctorName(prescription.getDoctor().getDoctorName());

	        Date truncatedStartDate = Converter.truncateTime(prescription.getStartDate());
	        Date truncatedEndDate = Converter.truncateTime(prescription.getEndDate());
	        Date truncatedProcedureDate = Converter.truncateTime(procedureDate);

	        if (truncatedStartDate.before(truncatedProcedureDate)) {
	            context.addMessage("startDate", new FacesMessage(FacesMessage.SEVERITY_ERROR,
	                    "Prescription start date (" + formatDate(truncatedStartDate)
	                            + ") cannot be before the procedure date (" + formatDate(truncatedProcedureDate) + ").",
	                    null));
	            context.validationFailed();
	            isValid = false;
	        }

	        if (truncatedEndDate.before(truncatedStartDate)) {
	            context.addMessage("endDate", new FacesMessage(FacesMessage.SEVERITY_ERROR,
	                    "Prescription end date (" + formatDate(truncatedEndDate)
	                            + ") cannot be before the prescription start date (" + formatDate(truncatedStartDate) + ").",
	                    null));
	            context.validationFailed();
	            isValid = false;
	        }
	    }

	    if (procedureType == ProcedureType.LONG_TERM && procedureStatus == ProcedureStatus.IN_PROGRESS
	            && providerEjb.generateNewProcedureId().equalsIgnoreCase(procedure.getProcedureId())) {

	        if (!prescription.getPrescribedDoc().getDoctorId()
	                .equalsIgnoreCase(prescription.getDoctor().getDoctorId())) {
	            context.addMessage("prescribedBy", new FacesMessage(FacesMessage.SEVERITY_ERROR,
	                    "Prescribed by doctor for same day must be same as procedure doctor as it is same day", null));
	            context.validationFailed();
	            isValid = false;
	        }

	        Date truncatedWrittenOn = Converter.truncateTime(prescription.getWrittenOn());
	        Date truncatedFromDate = Converter.truncateTime(fromDate);

	        if (!formatDate(truncatedWrittenOn).equals(formatDate(truncatedFromDate))) {
	            context.addMessage("writtenOn", new FacesMessage(FacesMessage.SEVERITY_ERROR,
	                    "Written on date (" + formatDate(truncatedWrittenOn)
	                            + ") must be same as procedure start date (" + formatDate(truncatedFromDate) + ").",
	                    null));
	            context.validationFailed();
	            isValid = false;
	        }
	    }

	    if (procedureType == ProcedureType.LONG_TERM && procedureStatus == ProcedureStatus.IN_PROGRESS) {
	        Date writtenOn = Converter.truncateTime(prescription.getWrittenOn());

	        if (fromDate == null) {
	            context.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,
	                    "Missing From Date for LONG_TERM procedure ID: " + procedureId, null));
	            context.validationFailed();
	            isValid = false;
	        }

	        Date truncatedFromDate = Converter.truncateTime(fromDate);
	        if (writtenOn.before(truncatedFromDate)) {
	            context.addMessage("writtenOn", new FacesMessage(FacesMessage.SEVERITY_ERROR,
	                    "Written On date (" + formatDate(writtenOn)
	                            + ") must be after the Procedure From Date (" + formatDate(truncatedFromDate)
	                            + ") for long-term in-progress procedures.",
	                    null));
	            context.validationFailed();
	            isValid = false;
	        }

	        Date startDate = Converter.truncateTime(prescription.getStartDate());
	        Date endDate = Converter.truncateTime(prescription.getEndDate());

	        if (startDate.before(writtenOn)) {
	            context.addMessage("startDate", new FacesMessage(FacesMessage.SEVERITY_ERROR,
	                    "Prescription start date (" + formatDate(startDate)
	                            + ") cannot be before the prescription written date (" + formatDate(writtenOn) + ").",
	                    null));
	            context.validationFailed();
	            isValid = false;
	        }

	        if (endDate.before(startDate)) {
	            context.addMessage("endDate", new FacesMessage(FacesMessage.SEVERITY_ERROR,
	                    "Prescription end date (" + formatDate(endDate)
	                            + ") cannot be before the prescription start date (" + formatDate(startDate) + ").",
	                    null));
	            context.validationFailed();
	            isValid = false;
	        }
	    }

	    if (prescribedMedicines != null && !prescribedMedicines.isEmpty()) {
	        for (PrescribedMedicines pm : prescribedMedicines) {
	            if (pm.getPrescription().getPrescriptionId().equals(prescription.getPrescriptionId())) {
	                if (pm.getStartDate().before(prescription.getStartDate())) {
	                    context.addMessage("startDate", new FacesMessage(FacesMessage.SEVERITY_ERROR,
	                            "Prescription start date (" + formatDate(prescription.getStartDate())
	                                    + ") is after medicine start date (" + formatDate(pm.getStartDate())
	                                    + ") for " + pm.getMedicineName(),
	                            null));
	                    context.validationFailed();
	                    isValid = false;
	                    break;
	                }
	                if (pm.getEndDate().after(prescription.getEndDate())) {
	                    context.addMessage("endDate", new FacesMessage(FacesMessage.SEVERITY_ERROR,
	                            "Prescription end date (" + formatDate(prescription.getEndDate())
	                                    + ") is before medicine end date (" + formatDate(pm.getEndDate())
	                                    + ") for " + pm.getMedicineName(),
	                            null));
	                    context.validationFailed();
	                    isValid = false;
	                    break;
	                }
	            }
	        }
	    }

	    if (!isValid)
	        return null;

	    prescriptions.add(prescription);
	    return "PrescriptionDashboard?faces-redirect=true";
	}

	public String addProcedureLogController(ProcedureDailyLog procedureLog)
			throws ClassNotFoundException, SQLException {
		procedureLogs.removeIf(p -> p.getLogId().equals(procedureLog.getLogId()));
		FacesContext context = FacesContext.getCurrentInstance();
		Map<String, Object> sessionMap = context.getExternalContext().getSessionMap();
		boolean isValid = true;
		providerDao = new ProviderDaoImpl();

		procedureLog.setMedicalProcedure(procedure);

		// Date formatter
		SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy");

		// 1. Validate Log Date
		Date logDate = procedureLog.getLogDate();
		if (logDate == null) {
			context.addMessage("logDate", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Log date is required.", null));
			context.validationFailed();
			isValid = false;
		}
		if (procedureLog.getVitals().isEmpty()) {
			context.addMessage("vitals", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Enter vitals", null));
			context.validationFailed();
			isValid = false;
		}
		if (procedureLog.getloggedDoctor().getDoctorId() == null
				|| procedureLog.getloggedDoctor().getDoctorId().isEmpty()) {
			context.addMessage("loggedBy",
					new FacesMessage(FacesMessage.SEVERITY_ERROR, "Enter Doctor id who logged the details", null));
			context.validationFailed();
			isValid = false;
		}
		if (procedureLog.getloggedDoctor().getDoctorId() != null
				&& !procedureLog.getloggedDoctor().getDoctorId().isEmpty()) {
			Doctors procedureDoctor = providerDao.searchDoctorById(procedure.getDoctor().getDoctorId());
			Doctors logDoctor = providerDao.searchDoctorById(procedureLog.getloggedDoctor().getDoctorId());
			if (!procedureDoctor.getSpecialization().equals(logDoctor.getSpecialization())) {
				context.addMessage("loggedBy", new FacesMessage(FacesMessage.SEVERITY_ERROR,
						"Doctor specialization doesn't match with " + procedureDoctor.getSpecialization(), null));
				context.validationFailed();
				isValid = false;
			}
		}
		if (!isValid)
			return null;

		// Get procedure fromDate
		Date fromDate = procedure.getFromDate();
		if (fromDate == null) {
			context.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,
					"Unable to fetch procedure's start date for validation.", null));
			context.validationFailed();
			isValid = false;
		}

		// Truncate time parts before comparison
		Calendar logCal = Calendar.getInstance();
		logCal.setTime(logDate);
		logCal.set(Calendar.HOUR_OF_DAY, 0);
		logCal.set(Calendar.MINUTE, 0);
		logCal.set(Calendar.SECOND, 0);
		logCal.set(Calendar.MILLISECOND, 0);

		Calendar fromCal = Calendar.getInstance();
		fromCal.setTime(fromDate);
		fromCal.set(Calendar.HOUR_OF_DAY, 0);
		fromCal.set(Calendar.MINUTE, 0);
		fromCal.set(Calendar.SECOND, 0);
		fromCal.set(Calendar.MILLISECOND, 0);

		if (logCal.getTime().before(fromCal.getTime())) {
			context.addMessage("logDate", new FacesMessage(FacesMessage.SEVERITY_ERROR,
					"Log date (" + sdf.format(logDate) + ") cannot be before procedure start date (" + sdf.format(fromDate) + ").", null));
			context.validationFailed();
			isValid = false;
		}

		// 2. Validate vitals
		String vitals = procedureLog.getVitals();
		if (vitals != null && !vitals.trim().isEmpty()) {
			vitals = vitals.trim().replaceAll("\\s+", " ");
			if (vitals.length() > 300) {
				context.addMessage("vitals", new FacesMessage(FacesMessage.SEVERITY_ERROR,
						"Vitals should not exceed 300 characters.", null));
				context.validationFailed();
				isValid = false;
			}
			if (!vitals.matches("[a-zA-Z0-9:/.,\\s]+")) {
				context.addMessage("vitals", new FacesMessage(FacesMessage.SEVERITY_ERROR,
						"Vitals can only contain letters, numbers, spaces, colon (:), slash (/), comma (,), and dot (.)", null));
				context.validationFailed();
				isValid = false;
			}
			if (vitals.matches("\\d+")) {
				context.addMessage("vitals", new FacesMessage(FacesMessage.SEVERITY_ERROR,
						"Vitals cannot be only numeric. Please include proper labels like 'BP: 120/80'.", null));
				context.validationFailed();
				isValid = false;
			}
			procedureLog.setVitals(vitals);
		}

		// Check same-day procedure constraint
		if (providerEjb.generateNewProcedureId().equalsIgnoreCase(procedure.getProcedureId())) {
			if (!procedureLog.getloggedDoctor().getDoctorId().equalsIgnoreCase(procedure.getDoctor().getDoctorId())) {
				context.addMessage("loggedBy", new FacesMessage(FacesMessage.SEVERITY_ERROR,
						"Logged by doctor must be same as procedure doctor as it is a same-day procedure.", null));
				context.validationFailed();
				isValid = false;
			}
			Date truncatedLogDate = Converter.truncateTime(procedureLog.getLogDate());
			Date truncatedFromDate = Converter.truncateTime(procedure.getFromDate());
			if (!sdf.format(truncatedLogDate).equalsIgnoreCase(sdf.format(truncatedFromDate))) {
				context.addMessage("logDate", new FacesMessage(FacesMessage.SEVERITY_ERROR,
						"Log date must be same as procedure start date (" + sdf.format(truncatedFromDate) + ") for same-day procedures.", null));
				context.validationFailed();
				isValid = false;
			}
		}

		if (!isValid)
			return null;

		procedureLog.setCreatedAt(new Date());
		procedureLogs.add(procedureLog);
		return "LongTermProcedureDashboard?faces-redirect=true";
	}

	public String createNewProcedure() throws ClassNotFoundException, SQLException {
		procedure = new MedicalProcedure();
		procedure.setProcedureId(providerEjb.generateNewProcedureId());
		procedure.setAppointment(procedureAppointment);
		procedure.setProvider(procedureAppointment.getProvider());
		procedure.setRecipient(procedureAppointment.getRecipient());
		procedure.setDoctor(procedureAppointment.getDoctor());
		prescriptions.clear();
		prescribedMedicines.clear();
		procedureTests.clear();
		procedureLogs.clear();
		// Get today's date
		Date today = new Date(); // java.util.Date

		String nextPage = null;

		if ("single".equalsIgnoreCase(procedureType)) {
			procedure.setProcedureDate(today); // Single-day procedure done today
			procedure.setProcedureStatus(ProcedureStatus.COMPLETED);
			nextPage = "AddMedicalProcedure?faces-redirect=true";

		} else if ("scheduled".equalsIgnoreCase(procedureType)) {
			// No date set here. Will be chosen by user in future.
			nextPage = "AddScheduledMedicalProcedure?faces-redirect=true";

		} else if ("inprogress".equalsIgnoreCase(procedureType)) {
			procedure.setFromDate(today); // In-progress begins today
			procedure.setProcedureStatus(ProcedureStatus.IN_PROGRESS);
			nextPage = "AddInProgressMedicalProcedure?faces-redirect=true";
		} else {
			FacesContext.getCurrentInstance().addMessage(null,
					new FacesMessage(FacesMessage.SEVERITY_ERROR, "Please select a procedure type.", null));
			return null;
		}
		System.out.println("______________________________________new procedure created with values " + procedure);
		return nextPage;
	}

	public String createNewPrescription() throws ClassNotFoundException, SQLException {
		prescription = new Prescription();
		
		if (prescriptions != null && !prescriptions.isEmpty()) {
			prescription.setPrescriptionId(ProcedureIdGenerator.getNextPrescriptionId(prescriptions));
		} else {
			prescription.setPrescriptionId(providerEjb.generateNewPrescriptionId());
		}
		prescription.setWrittenOn(new Date());
		prescription.setStartDate(new Date());
		if (procedure.getType() == ProcedureType.LONG_TERM
				&& procedure.getProcedureStatus() == ProcedureStatus.IN_PROGRESS
				&& providerEjb.generateNewProcedureId().equalsIgnoreCase(procedure.getProcedureId())) {
			prescription.getPrescribedDoc().setDoctorId(procedure.getDoctor().getDoctorId());
			prescription.setWrittenOn(procedure.getFromDate());
		}
		return "AddPrescription?faces-redirect=true";
	}

	public String createNewPrescribedMedicine() throws ClassNotFoundException, SQLException {
		prescribedMedicine = new PrescribedMedicines();

		if (prescribedMedicines != null && !prescribedMedicines.isEmpty()) {
			prescribedMedicine.setPrescribedId(ProcedureIdGenerator.getNextPrescribedMedicineId(prescribedMedicines));
		} else {
			prescribedMedicine.setPrescribedId(providerEjb.generateNewPrescribedMedicineId());
		}
		prescribedMedicine.setStartDate(new Date());
		return "AddPrescribedMedicine?faces-redirect=true";
	}
	public String createNewexistingPrescPrescribedMedicine() throws ClassNotFoundException, SQLException {
		prescribedMedicine = new PrescribedMedicines();

		if (prescribedMedicines != null && !prescribedMedicines.isEmpty()) {
			prescribedMedicine.setPrescribedId(ProcedureIdGenerator.getNextPrescribedMedicineId(prescribedMedicines));
		} else {
			prescribedMedicine.setPrescribedId(providerEjb.generateNewPrescribedMedicineId());
		}
		prescribedMedicine.setStartDate(new Date());
		return "AddExistingPrescMedicine?faces-redirect=true";
	}
	public String createNewExistingPrescProcedureTest() throws ClassNotFoundException, SQLException {
		procedureTest = new ProcedureTest();

		if (procedureTests != null && !procedureTests.isEmpty()) {
			procedureTest.setTestId(ProcedureIdGenerator.getNextProcedureTestId(procedureTests));
		} else {
			procedureTest.setTestId(providerEjb.generateNewProcedureTestId());
		}
		procedureTest.setTestDate(new Date());
		return "AddExistingTest?faces-redirect=true";
	}

	public String createNewProcedureTest() throws ClassNotFoundException, SQLException {
		procedureTest = new ProcedureTest();

		if (procedureTests != null && !procedureTests.isEmpty()) {
			procedureTest.setTestId(ProcedureIdGenerator.getNextProcedureTestId(procedureTests));
		} else {
			procedureTest.setTestId(providerEjb.generateNewProcedureTestId());
		}
		procedureTest.setTestDate(new Date());
		return "AddTest?faces-redirect=true";
	}

	public String createNewProcedureLog() throws ClassNotFoundException, SQLException {
		procedureLog = new ProcedureDailyLog();

		if (procedureLogs != null && !procedureLogs.isEmpty()) {
			procedureLog.setLogId(ProcedureIdGenerator.getNextProcedureLogId(procedureLogs));
		} else {
			try {
				procedureLog.setLogId(providerEjb.generateNewProcedureLogId());
			} catch (Exception e) {
				e.printStackTrace();
				// Handle DB fallback error appropriately
			}
		}

		procedureLog.setLogDate(new Date());
		if (providerEjb.generateNewProcedureId().equalsIgnoreCase(procedure.getProcedureId())) {
			procedureLog.getloggedDoctor().setDoctorId(procedure.getDoctor().getDoctorId());
			procedureLog.setLogDate(procedure.getFromDate());
		}
		return "AddProcedureLog?faces-redirect=true";
	}

	public String fetchScheduledProceduresController() {
		allScheduledProcedures = null;
		scheduledProcedures = null;
		providerDao = new ProviderDaoImpl();
		if (doctorId == null || doctorId.trim().isEmpty()) {
			FacesContext.getCurrentInstance().addMessage("doctorId",
					new FacesMessage(FacesMessage.SEVERITY_ERROR, "Enter doctor id DOCXXX", null));
			return null;
		}

		if (!doctorId.trim().matches("^[Dd][Oo][Cc]\\d{3}$")) {
			FacesContext.getCurrentInstance().addMessage("doctorId",
					new FacesMessage(FacesMessage.SEVERITY_ERROR, "Correct doctor id format DOCXXX", null));
			return null;
		}

		Doctors doctor = providerDao.searchDoctorById(doctorId.trim());
		if (doctor == null) {
			FacesContext.getCurrentInstance().addMessage("doctorId", new FacesMessage(FacesMessage.SEVERITY_ERROR,
					"Doctor with ID " + doctorId + " does not exist.", null));
			return null;
		}

		List<MedicalProcedure> procedures;
		if (procedureId != null && !procedureId.trim().isEmpty()) {
			if (!procedureId.trim().matches("^[Pp][Rr][Oo][Cc].{3}$")) {
				FacesContext.getCurrentInstance().addMessage("procedureId",
						new FacesMessage(FacesMessage.SEVERITY_ERROR, "Correct procedure id format PROCXXX", null));
				return null;
			}
			procedures = providerEjb.getScheduledProceduresByDoctor(doctorId.trim(), procedureId.trim());
			if (procedures.isEmpty()) {
				FacesContext.getCurrentInstance().addMessage("procedureId", new FacesMessage(FacesMessage.SEVERITY_WARN,
						"No scheduled procedure found with ID " + procedureId + " for Doctor ID " + doctorId, null));
				return null;
			}
		} else {
			procedures = providerEjb.getScheduledProceduresByDoctor(doctorId.trim(), null);
			if (procedures.isEmpty()) {
				FacesContext.getCurrentInstance().addMessage("doctorId", new FacesMessage(FacesMessage.SEVERITY_INFO,
						"No scheduled procedures found for Doctor ID " + doctorId, null));
			}
		}
		allInProgressProcedures = null;
		inProgressProcedures = null;
		allScheduledProcedures = null;
		scheduledProcedures = null;
		allBookedAppointments = null;
		bookedAppointments = null;
		currentPage = 1;
		pageSize = 3;
		sortField = null;
		sortAscending = true;
		allScheduledProcedures = procedures;
		paginate();
		return null;
	}

	public String fetchInProgressProceduresController() {
		allInProgressProcedures = null;
		inProgressProcedures = null;
		providerDao = new ProviderDaoImpl();

		if (doctorId == null || doctorId.trim().isEmpty()) {
			FacesContext.getCurrentInstance().addMessage("doctorId",
					new FacesMessage(FacesMessage.SEVERITY_ERROR, "Enter doctor id DOCXXX", null));
			return null;
		}

		if (!doctorId.trim().matches("^[Dd][Oo][Cc]\\d{3}$")) {
			FacesContext.getCurrentInstance().addMessage("doctorId",
					new FacesMessage(FacesMessage.SEVERITY_ERROR, "Correct doctor id format DOCXXX", null));
			return null;
		}
		Doctors doctor = providerDao.searchDoctorById(doctorId.trim());
		if (doctor == null) {
			FacesContext.getCurrentInstance().addMessage("doctorId", new FacesMessage(FacesMessage.SEVERITY_ERROR,
					"Doctor with ID " + doctorId + " does not exist.", null));
			return null;
		}

		List<MedicalProcedure> procedures;
		if (procedureId != null && !procedureId.trim().isEmpty()) {
			if (!procedureId.trim().matches("^[Pp][Rr][Oo][Cc].{3}$")) {
				FacesContext.getCurrentInstance().addMessage("procedureId",
						new FacesMessage(FacesMessage.SEVERITY_ERROR, "Correct procedure id format PROCXXX", null));
				return null;
			}
			procedures = providerEjb.getInProgressProceduresByDoctor(doctorId.trim(), procedureId.trim());
			if (procedures.isEmpty()) {
				FacesContext.getCurrentInstance().addMessage("procedureId", new FacesMessage(FacesMessage.SEVERITY_WARN,
						"No in-progress procedure found with ID " + procedureId + " for Doctor ID " + doctorId, null));
				return null;
			}
		} else {
			procedures = providerEjb.getInProgressProceduresByDoctor(doctorId.trim(), null);
			if (procedures.isEmpty()) {
				FacesContext.getCurrentInstance().addMessage("doctorId", new FacesMessage(FacesMessage.SEVERITY_INFO,
						"No in-progress procedures found for Doctor ID " + doctorId, null));
			}
		}
		allInProgressProcedures = null;
		inProgressProcedures = null;
		allScheduledProcedures = null;
		scheduledProcedures = null;
		allBookedAppointments = null;
		bookedAppointments = null;
		currentPage = 1;
		pageSize = 3;
		sortField = null;
		sortAscending = true;
		totalPages = 0;
		allInProgressProcedures = procedures;
		paginate();
		return null;
	}

	public List<Appointment> fetchBookedAppointments() {
		allBookedAppointments = null;
		bookedAppointments = null;
		providerDao = new ProviderDaoImpl();

		if (doctorId == null || doctorId.trim().isEmpty()) {
			FacesContext.getCurrentInstance().addMessage("doctorId",
					new FacesMessage(FacesMessage.SEVERITY_ERROR, "Enter doctor id DOCXXX", null));
			return null;
		}

		if (!doctorId.trim().matches("^[Dd][Oo][Cc]\\d{3}$")) {
			FacesContext.getCurrentInstance().addMessage("doctorId",
					new FacesMessage(FacesMessage.SEVERITY_ERROR, "Correct doctor id format DOCXXX", null));
			return null;
		}
		Doctors doctor = providerDao.searchDoctorById(doctorId.trim());
		if (doctor == null) {
			FacesContext.getCurrentInstance().addMessage("doctorId", new FacesMessage(FacesMessage.SEVERITY_ERROR,
					"Doctor with ID " + doctorId + " does not exist.", null));
			return null;
		}

		List<Appointment> appointments;
		if (appointmentId != null && !appointmentId.trim().isEmpty()) {
			if (!appointmentId.trim().matches("^[Aa][Pp][Pp].{3}$")) {
				FacesContext.getCurrentInstance().addMessage("appointmentId",
						new FacesMessage(FacesMessage.SEVERITY_ERROR, "Correct appointment id format APPXXX", null));
				return null;
			}
			appointments = providerDao.getBookedAppointments(doctorId.trim(), appointmentId.trim());
			if (appointments.isEmpty()) {
				FacesContext.getCurrentInstance().addMessage("appointmentId",
						new FacesMessage(FacesMessage.SEVERITY_WARN,
								"No booked appointments  found with ID " + appointmentId + " for Doctor ID " + doctorId,
								null));
				return null;
			}
		} else {
			appointments = providerDao.getBookedAppointments(doctorId.trim(), null);
			if (appointments.isEmpty()) {
				FacesContext.getCurrentInstance().addMessage("doctorId", new FacesMessage(FacesMessage.SEVERITY_INFO,
						"No booked appointments  found for Doctor ID " + doctorId, null));
			}
		}
		allInProgressProcedures = null;
		inProgressProcedures = null;
		allScheduledProcedures = null;
		scheduledProcedures = null;
		allBookedAppointments = null;
		bookedAppointments = null;
		currentPage = 1;
		pageSize = 3;
		sortField = null;
		sortAscending = true;
		totalPages = 0;
		allBookedAppointments = appointments;
		paginate();
		return allBookedAppointments;
	}

	// Paginations
	public void paginate() {
		if (allScheduledProcedures != null) {
			int total = allScheduledProcedures.size();
			totalPages = (int) Math.ceil((double) total / pageSize);
			int fromIndex = (currentPage - 1) * pageSize;
			int toIndex = Math.min(fromIndex + pageSize, total);
			scheduledProcedures = allScheduledProcedures.subList(fromIndex, toIndex);
		}
		if (allInProgressProcedures != null) {
			int total = allInProgressProcedures.size();
			totalPages = (int) Math.ceil((double) total / pageSize);
			int fromIndex = (currentPage - 1) * pageSize;
			int toIndex = Math.min(fromIndex + pageSize, total);
			inProgressProcedures = allInProgressProcedures.subList(fromIndex, toIndex);
		}
		if (allBookedAppointments != null) {
			int total = allBookedAppointments.size();
			totalPages = (int) Math.ceil((double) total / pageSize);
			int fromIndex = (currentPage - 1) * pageSize;
			int toIndex = Math.min(fromIndex + pageSize, total);
			bookedAppointments = allBookedAppointments.subList(fromIndex, toIndex);
		}
		if (viewPrescriptions != null) {
	        int total = viewPrescriptions.size();
	        totalPages = (int) Math.ceil((double) total / pageSize);
	        int fromIndex = (currentPage - 1) * pageSize;
	        int toIndex = Math.min(fromIndex + pageSize, total);
	        System.out.println(viewPrescriptions);
	        currentPagePrescriptions = new ArrayList<>(viewPrescriptions.subList(fromIndex, toIndex));
	        System.out.println(currentPagePrescriptions);
	    }
		 
	}

	public void nextPage() {
		if (currentPage < totalPages) {
			currentPage++;
			paginate();
		}
	}

	public void previousPage() {
		if (currentPage > 1) {
			currentPage--;
			paginate();
		}
	}

	public boolean hasPreviousPage() {
		return currentPage > 1;
	}

	public boolean hasNextPage() {
		return currentPage < totalPages;
	}

	public void goToFirstPage() {
		currentPage = 1;
		paginate(); // refresh the current page content
	}

	public void goToLastPage() {
		currentPage = totalPages > 0 ? totalPages : 1;
		paginate(); // refresh the current page content
	}

	public boolean isSortAscending() {
		return sortAscending;
	}

	public void setSortAscending(boolean sortAscending) {
		this.sortAscending = sortAscending;
	}

	// Sorting logic
	// Sorting control methods
	public void sortByAsc(String field) {
		this.sortField = field;
		this.sortAscending = true;
		sortCurrentList();
	}

	public void sortByDesc(String field) {
		this.sortField = field;
		this.sortAscending = false;
		sortCurrentList();
	}

	private void sortCurrentList() {
	    if (allScheduledProcedures != null && !allScheduledProcedures.isEmpty()) {
	        sortScheduledProcedures();
	    } else if (allInProgressProcedures != null && !allInProgressProcedures.isEmpty()) {
	        sortInProgressProcedures();
	    } else if (allBookedAppointments != null && !allBookedAppointments.isEmpty()) {
	        sortBookedAppointments();
	    } else if (viewPrescriptions != null && !viewPrescriptions.isEmpty()) {
	        sortPrescriptions();
	    }
	    goToFirstPage(); // Reset to first page after sorting
	}

	// Comparator-based sorting implementations
	private void sortPrescriptions() {
	    Comparator<Prescription> comparator = getComparatorForPrescriptionField(sortField);
	    if (comparator != null) {
	        if (!sortAscending) {
	            comparator = comparator.reversed();
	        }
	        viewPrescriptions.sort(comparator);
	    }
	}
	private void sortScheduledProcedures() {
		Comparator<MedicalProcedure> comparator = getComparatorForField(sortField);
		if (comparator != null) {
			if (!sortAscending) {
				comparator = comparator.reversed();
			}
			allScheduledProcedures.sort(comparator);
		}
	}

	private void sortInProgressProcedures() {
		Comparator<MedicalProcedure> comparator = getComparatorForField(sortField);
		if (comparator != null) {
			if (!sortAscending) {
				comparator = comparator.reversed();
			}
			allInProgressProcedures.sort(comparator);
		}
	}

	private void sortBookedAppointments() {
		Comparator<Appointment> comparator = getComparatorForBookedField(sortField);
		if (comparator != null) {
			if (!sortAscending) {
				comparator = comparator.reversed();
			}
			allBookedAppointments.sort(comparator);
		}
	}
	private Comparator<Prescription> getComparatorForPrescriptionField(String field) {
	    switch (field) {
	        case "prescriptionId":
	            return Comparator.comparing(
	                Prescription::getPrescriptionId,
	                Comparator.nullsLast(Comparator.naturalOrder())
	            );
	        case "diagnosis":
	            return Comparator.comparing(
	                p -> p.getProcedure() != null ? p.getProcedure().getDiagnosis() : "",
	                Comparator.nullsLast(Comparator.naturalOrder())
	            );
	        case "procedureDoctor":
	            return Comparator.comparing(
	                p -> p.getDoctor() != null ? p.getDoctor().getDoctorId() : "",
	                Comparator.nullsLast(Comparator.naturalOrder())
	            );
	        case "prescribedDoctor":
	            return Comparator.comparing(
	                p -> p.getPrescribedDoc() != null ? p.getPrescribedDoc().getDoctorId() : "",
	                Comparator.nullsLast(Comparator.naturalOrder())
	            );
	        case "startDate":
	            return Comparator.comparing(
	                Prescription::getStartDate,
	                Comparator.nullsLast(Comparator.naturalOrder())
	            );
	        case "endDate":
	            return Comparator.comparing(
	                Prescription::getEndDate,
	                Comparator.nullsLast(Comparator.naturalOrder())
	            );
	        default:
	            return null;
	    }
	}

	private Comparator<MedicalProcedure> getComparatorForField(String field) {
		switch (field) {
		case "procedureId":
			return Comparator.comparing(MedicalProcedure::getProcedureId);
		case "scheduledDate":
			return Comparator.comparing(MedicalProcedure::getScheduledDate);
		case "recipientFirstName":
			return Comparator.comparing(p -> p.getRecipient().getFirstName(), Comparator.nullsLast(String::compareTo));
		case "recipientLastName":
			return Comparator.comparing(p -> p.getRecipient().getLastName(), Comparator.nullsLast(String::compareTo));
		case "doctorName":
			return Comparator.comparing(p -> p.getDoctor().getDoctorName(), Comparator.nullsLast(String::compareTo));
		case "providerName":
			return Comparator.comparing(p -> p.getProvider().getHospitalName(),
					Comparator.nullsLast(String::compareTo));
		case "appointmentId":
			return Comparator.comparing(p -> p.getAppointment().getAppointmentId());
		case "startedOn":
			return Comparator.comparing(MedicalProcedure::getFromDate);
		default:
			return null;
		}
	}

	private Comparator<Appointment> getComparatorForBookedField(String field) {
		switch (field) {
		case "appointmentId":
			return Comparator.comparing(Appointment::getAppointmentId);
		case "providerId":
			return Comparator.comparing(a -> a.getProvider().getProviderId(), Comparator.nullsLast(String::compareTo));
		case "doctorId":
			return Comparator.comparing(a -> a.getDoctor().getDoctorId(), Comparator.nullsLast(String::compareTo));
		case "doctorName":
			return Comparator.comparing(a -> a.getDoctor().getDoctorName(), Comparator.nullsLast(String::compareTo));
		case "recipientId":
			return Comparator.comparing(a -> a.getRecipient().gethId(), Comparator.nullsLast(String::compareTo));
		case "userName":
			return Comparator.comparing(a -> a.getRecipient().getUserName(), Comparator.nullsLast(String::compareTo));
		case "bookedAt":
			return Comparator.comparing(Appointment::getBookedAt, Comparator.nullsLast(Date::compareTo));

		default:
			return null;
		}
	}

	// Scheduled Reset
	public String resetPage() {
		// Reset form input fields
		this.doctorId = null;
		this.procedureId = null;

		// Clear data lists
		this.allScheduledProcedures = null;
		this.scheduledProcedures = null;

		// Reset sorting
		this.sortField = null;
		this.sortAscending = true;

		// Reset pagination
		this.currentPage = 1;
		this.totalPages = 0;
		this.pageSize = 3; // or your default page size

		// Optional: reset internal tracking states if any
		this.procedure = null;

		// Clear JSF view tree to force reload
		FacesContext.getCurrentInstance().getViewRoot().getChildren().clear();

		// Redirect to the same page to reset everything
		return null;
	}

	// In-progress reset
	public String resetSearchForm() {
		this.doctorId = null;
		this.procedureId = null;
		this.sortField = null;
		this.sortAscending = true;
		this.inProgressProcedures = null;
		this.allInProgressProcedures = null; // Clear previous search results if needed
		FacesContext.getCurrentInstance().getViewRoot().getChildren().clear();
		return null; // Return the same page name for reload
	}

	// Appointments reset
	public String reset() {
		this.doctorId = null;
		this.appointmentId = null;
		// reset sorting
		this.sortField = null;
		this.sortAscending = true;

		// Reset pagination
		this.currentPage = 1;
		this.totalPages = 0;
		this.pageSize = 3; // or your default page size
		this.allBookedAppointments = null;// Clear previous search results if needed
		this.bookedAppointments = null;
		FacesContext.getCurrentInstance().getViewRoot().getChildren().clear();
		return null; // Return the same page name for reload
	}

	// Scheduled back button
	public String goToDashboard1() {
		this.doctorId = null;
		this.procedureId = null;

		// Clear data lists
		this.allScheduledProcedures = null;
		this.scheduledProcedures = null;

		// Reset sorting
		this.sortField = null;
		this.sortAscending = true;

		// Reset pagination
		this.currentPage = 1;
		this.totalPages = 0;
		this.pageSize = 3; // or your default page size

		// Optional: reset internal tracking states if any
		this.procedure = null;

		// Clear JSF view tree to force reload
		FacesContext.getCurrentInstance().getViewRoot().getChildren().clear();

		return "ProviderDashboard?faces-redirect=true";
	}

	// ongoing backbutton
	public String goToDashboard2() {
		this.doctorId = null;
		this.procedureId = null;
		this.sortField = null;
		this.sortAscending = true;
		this.inProgressProcedures = null;
		this.allInProgressProcedures = null; // Clear previous search results if needed
		FacesContext.getCurrentInstance().getViewRoot().getChildren().clear();
		return "ProviderDashboard?faces-redirect=true";
	}

	// Appointments back button
	public String goToDashboard3() {
		this.doctorId = null;
		this.appointmentId = null;
		// reset sorting
		this.sortField = null;
		this.sortAscending = true;

		// Reset pagination
		this.currentPage = 1;
		this.totalPages = 0;
		this.pageSize = 3; // or your default page size
		this.allBookedAppointments = null;// Clear previous search results if needed
		this.bookedAppointments = null;
		FacesContext.getCurrentInstance().getViewRoot().getChildren().clear();
		return "ProviderDashboard?faces-redirect=true";
	}

	public String procedureSubmit() throws ClassNotFoundException, SQLException {
		FacesContext context = FacesContext.getCurrentInstance();
		// Step 1: Save the procedure
		if (providerEjb.generateNewProcedureId().equalsIgnoreCase(procedure.getProcedureId())) {
			providerEjb.addMedicalProcedure(procedure);
			// Send completion email if status is COMPLETED
//for long term procedure the status will be in progress when this method is called
			if (procedure.getProcedureStatus() == ProcedureStatus.COMPLETED) {
				try {
					ServletContext servletContext = (ServletContext) context.getExternalContext().getContext();
					SimpleDateFormat dateFormat = new SimpleDateFormat("MMM dd, yyyy");
					// Determine the appropriate date based on procedure type
					String procedureDate = (procedure.getType() == ProcedureType.SINGLE_DAY)
							? dateFormat.format(procedure.getProcedureDate())
							: dateFormat.format(procedure.getToDate());
					String fromDate = null;
					String toDate = null;
					// Create ProcedureSlip
					ProcedureSlip slip = new ProcedureSlip(procedure.getRecipient().gethId(),
							procedure.getRecipient().getFirstName() + " " + procedure.getRecipient().getLastName(),
							procedureDate, fromDate, toDate, procedure.getDoctor().getDoctorName(),
							servletContext.getInitParameter("providerContact"),
							servletContext.getInitParameter("providerEmail"), procedure.getType().toString(),
							procedure.getProcedureId()

					);
					// Get procedure name
					String procedureName = procedure.getDiagnosis();
					// Send email
					String subject = "Procedure Completed - " + procedureName;
					String htmlContent = MailSend.procedureCompletion(slip, procedureName);
					// ACTUAL EMAIL SEND CALL WAS MISSING - THIS IS THE FIX
					String sendResult = MailSend.sendMail(procedure.getRecipient().getEmail(), subject, htmlContent);
					context.addMessage(null,
							new FacesMessage(FacesMessage.SEVERITY_INFO, "Procedure completion notification sent to "
									+ procedure.getRecipient().getEmail() + ". Result: " + sendResult, null));
				} catch (Exception e) {
					e.printStackTrace(); // More detailed error logging
					context.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,
							"Failed to send completion notification: " + e.getMessage(), null));
				}
			}
		}
		// Save prescriptions
		for (Prescription p : prescriptions) {
			boolean flag = false;
			for (PrescribedMedicines pm : prescribedMedicines) {
				if (pm.getPrescription().getPrescriptionId().equals(p.getPrescriptionId())) {
					flag = true;
					break;
				}
			}
			for (ProcedureTest pt : procedureTests) {
				if (pt.getPrescription().getPrescriptionId().equals(p.getPrescriptionId())) {
					flag = true;
					break;
				}
			}
			if (flag == true) {

				providerEjb.addPrescription(p);

			}

		}

		// Save prescribed medicines

		for (PrescribedMedicines pm : prescribedMedicines) {

			providerEjb.addPrescribedMedicines(pm);

		}

		// Save tests

		for (ProcedureTest test : procedureTests) {

			providerEjb.addTest(test);

		}

		if (procedure.getType() == ProcedureType.LONG_TERM) {

			// Save logs

			for (ProcedureDailyLog log : procedureLogs) {

				providerEjb.addProcedureLog(log);

			}

		}

		providerDao = new ProviderDaoImpl();

		providerDao.updateAppointment(this.procedureAppointment);

		this.fetchBookedAppointments();

		// Step 3: Clear the session-level data

		procedure = null;

		prescription = null;

		prescriptions.clear();

		prescribedMedicine = null;

		prescribedMedicines.clear();

		procedureTest = null;

		procedureTests.clear();

		procedureLog = null;

		procedureLogs.clear();

		this.flag = true;

		// Step 4: Redirect to dashboard

		return "ProviderDashboard?faces-redirect=true";

	}

	public String prescriptionDetailsSubmit() {
		FacesContext context = FacesContext.getCurrentInstance();
		boolean hasItems = false;

		if (prescribedMedicines != null) {
			for (PrescribedMedicines pm : prescribedMedicines) {
				if (pm.getPrescription() != null
						&& pm.getPrescription().getPrescriptionId().equals(this.prescription.getPrescriptionId())) {
					hasItems = true;
					break;
				}
			}
		}

		if (!hasItems && procedureTests != null) {
			for (ProcedureTest pt : procedureTests) {
				if (pt.getPrescription() != null
						&& pt.getPrescription().getPrescriptionId().equals(this.prescription.getPrescriptionId())) {
					hasItems = true;
					break;
				}
			}
		}

		if (!hasItems) {
			context.addMessage("submit",
					new FacesMessage(FacesMessage.SEVERITY_ERROR, "No medicines/tests are added to submit", null));
			return null;
		}

		String result = "";

		if (procedure != null) {
			if (procedure.getProcedureStatus() == ProcedureStatus.COMPLETED
					&& procedure.getType() == ProcedureType.SINGLE_DAY) {
				result = "ProcedureDashboard?faces-redirect=true";
			}
			if (procedure.getProcedureStatus() == ProcedureStatus.IN_PROGRESS
					&& procedure.getType() == ProcedureType.LONG_TERM) {
				result = "LongTermProcedureDashboard?faces-redirect=true";
			}
		}

		return result;
	}

	public String backFromPrescription() {
		FacesContext context = FacesContext.getCurrentInstance();
		boolean flag = false;

		if (prescribedMedicines != null) {
			for (PrescribedMedicines pm : prescribedMedicines) {
				if (pm.getPrescription() != null
						&& pm.getPrescription().getPrescriptionId().equals(this.prescription.getPrescriptionId())) {
					flag = true;
					break;
				}
			}
		}

		if (!flag && procedureTests != null) {
			for (ProcedureTest pt : procedureTests) {
				if (pt.getPrescription() != null
						&& pt.getPrescription().getPrescriptionId().equals(this.prescription.getPrescriptionId())) {
					flag = true;
					break;
				}
			}
		}

		if (flag) {
			context.addMessage("back", new FacesMessage(FacesMessage.SEVERITY_ERROR,
					"Medicines/Tests are added. Please click on Submit.", null));
			return null;
		}

		String result = "";

		if (procedure != null) {
			if (procedure.getProcedureStatus() == ProcedureStatus.COMPLETED
					&& procedure.getType() == ProcedureType.SINGLE_DAY) {
				result = "ProcedureDashboard?faces-redirect=true";
			}
			if (procedure.getProcedureStatus() == ProcedureStatus.IN_PROGRESS
					&& procedure.getType() == ProcedureType.LONG_TERM) {
				result = "LongTermProcedureDashboard?faces-redirect=true";
			}
		}

		return result;
	}

	public String startProcedure(MedicalProcedure procedure) {
		System.out.println("in start procedure controller");

		// 1. Reload full procedure from DB using ID
		MedicalProcedure fullProc = providerEjb.getProcedureById(procedure.getProcedureId());
		System.out.println("obtained procedure is " + fullProc);
//		this.procedureAppointment=providerDao.searchAppointmentById(fullProc.getAppointment().getAppointmentId());
		this.procedureAppointment = fullProc.getAppointment();
		// 2. Set status and fromDate
		fullProc.setProcedureStatus(ProcedureStatus.IN_PROGRESS);
		fullProc.setFromDate(new java.sql.Date(System.currentTimeMillis()));
		this.procedure = fullProc;
		procedure = null;
		prescription = null;
		prescriptions.clear();

		prescribedMedicine = null;
		prescribedMedicines.clear();
		procedureTest = null;
		procedureTests.clear();
		procedureLog = null;
		procedureLogs.clear();
		// 6. Redirect to prescription entry page
		return "ViewProcedureDetails?faces-redirect=true"; // update path if needed
	}

	public String updateProcedure() {
		providerEjb.updateProcedureStatus(procedure);
		return "LongTermProcedureDashboard?faces-redirect=true";
	}

	public String completeProcedure(MedicalProcedure procedure) {

		System.out.println("in completeProcedure controller");
		providerDao = new ProviderDaoImpl();
		FacesContext context = FacesContext.getCurrentInstance();
		// 1. Reload full procedure from DB using ID

		MedicalProcedure fullProc = providerEjb.getProcedureById(procedure.getProcedureId());

		if (fullProc == null) {

			FacesContext.getCurrentInstance().addMessage(null,

					new FacesMessage(FacesMessage.SEVERITY_ERROR, "Procedure not found.", null));

			return null;

		}

		System.out.println("fetched procedure: " + fullProc);

		// 2. Set status and toDate

		fullProc.setProcedureStatus(ProcedureStatus.COMPLETED);

		fullProc.setToDate(new java.sql.Date(System.currentTimeMillis())); // set completion date

		// 3. Update in DB

		String result = providerEjb.updateProcedureStatus(fullProc);

		System.out.println("update result: " + result);

		// 4. Prepare and send completion email

		try {

			// Get recipient details (you'll need to implement this)

			// Create procedure slip
			ServletContext servletContext = (ServletContext) context.getExternalContext().getContext();
			SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");

			ProcedureSlip slip = new ProcedureSlip(

					fullProc.getRecipient().gethId(),

					fullProc.getRecipient().getFirstName() + fullProc.getRecipient().getLastName(),

					null, // procedureDate not used for long-term

					sdf.format(fullProc.getFromDate()), // fromDate

					sdf.format(fullProc.getToDate()), // toDate

					fullProc.getDoctor().getDoctorName(),

					servletContext.getInitParameter("providerContact"),
					servletContext.getInitParameter("providerEmail"),

					fullProc.getType().name(),

					fullProc.getProcedureId()

			);

			// Send email

			String procedureName = fullProc.getDiagnosis();

			MailSend.sendProcedureCompletionMail(slip, procedureName, fullProc.getRecipient().getEmail());

		} catch (Exception e) {

			System.err.println("Error sending completion email: " + e.getMessage());

			e.printStackTrace();

		}

		// 5. Clear session if needed

		Map<String, Object> sessionMap = FacesContext.getCurrentInstance().getExternalContext().getSessionMap();

		sessionMap.remove("procedureId");

		sessionMap.remove("fromDate");

		sessionMap.remove("procedureStatus");

		this.fetchInProgressProceduresController();

		// 6. Redirect to confirmation or listing page

		return "ShowOnGoingProcedures?faces-redirect=true";

	}

	public String goToAddProcedureDetails(MedicalProcedure p) {
		this.flag = false;

		System.out.println("in goToAddProcedureDetails controller");

		// 1. Reload full procedure from DB using ID
		MedicalProcedure fullProc = providerEjb.getProcedureById(p.getProcedureId());
		System.out.println("obtained procedure is " + fullProc);
		this.procedure = fullProc;
		tempProcedure = new MedicalProcedure();

		tempProcedure.setProcedureId(procedure.getProcedureId());
		tempProcedure.setAppointment(procedure.getAppointment());
		tempProcedure.setRecipient(procedure.getRecipient());
		tempProcedure.setProvider(procedure.getProvider());
		tempProcedure.setDoctor(procedure.getDoctor());

		tempProcedure.setScheduledDate(procedure.getScheduledDate());
		tempProcedure.setProcedureDate(procedure.getProcedureDate());
		tempProcedure.setFromDate(procedure.getFromDate());
		tempProcedure.setToDate(procedure.getToDate());

		tempProcedure.setDiagnosis(procedure.getDiagnosis());
		tempProcedure.setRecommendations(procedure.getRecommendations());
		tempProcedure.setType(procedure.getType());

		this.procedureAppointment = fullProc.getAppointment();
		// 4. Redirect to the appropriate dashboard
		return "LongTermProcedureDashboard?faces-redirect=true"; // Change path if needed
	}

	public List<Appointment> showBookedAppointmentsController() {
		providerDao = new ProviderDaoImpl();
		return providerDao.showBookedAppointments();
	}

	public String selectedAppointment(Appointment app) {
		System.out.println("controller called for selecting the appointment" + app);
		this.procedureAppointment = app;
		System.out.println("the selected appointment is " + procedureAppointment);

		return "ProcedureOptions?faces-redirect=true";
	}

	public String gotoProcedureForm() {
		System.out.println("in edit procedure________________" + procedure);
		String res = "";
		tempProcedure = new MedicalProcedure();

		tempProcedure.setProcedureId(procedure.getProcedureId());
		tempProcedure.setAppointment(procedure.getAppointment());
		tempProcedure.setRecipient(procedure.getRecipient());
		tempProcedure.setProvider(procedure.getProvider());
		tempProcedure.setDoctor(procedure.getDoctor());

		tempProcedure.setScheduledDate(procedure.getScheduledDate());
		tempProcedure.setProcedureDate(procedure.getProcedureDate());
		tempProcedure.setFromDate(procedure.getFromDate());
		tempProcedure.setToDate(procedure.getToDate());

		tempProcedure.setDiagnosis(procedure.getDiagnosis());
		tempProcedure.setRecommendations(procedure.getRecommendations());
		tempProcedure.setType(procedure.getType());

		tempProcedure.setProcedureStatus(procedure.getProcedureStatus()); // Assuming you have this field
		System.out.println("tempprocedure set "+tempProcedure);
		if (procedure.getType() == ProcedureType.SINGLE_DAY
				&& procedure.getProcedureStatus() == ProcedureStatus.COMPLETED) {
			res = "EditSingleDayProcedure?faces-redirect=true";
		}
		if (procedure.getType() == ProcedureType.LONG_TERM
				&& procedure.getProcedureStatus() == ProcedureStatus.IN_PROGRESS) {
			res = "EditInProgressProcedure?faces-redirect=true";
		}
		return res;
	}

	public String loadViewPrescriptions() {
		this.viewPrescriptions.clear();
		FacesContext context = FacesContext.getCurrentInstance();
		if (prescriptions != null && !prescriptions.isEmpty()) {
			this.viewPrescriptions.addAll(prescriptions);
		}
		this.viewPrescriptions.addAll(providerEjb.fetchPrescriptions(this.procedure.getProcedureId()));
		if (this.viewPrescriptions == null || this.viewPrescriptions.isEmpty()) {
			context.addMessage(null,
			        new FacesMessage(FacesMessage.SEVERITY_ERROR,
			            "No prescriptions found for this procedure.", null));
			return null;
		}
		
		paginate();
		return "ViewPrescriptions?faces-redirect=true";
	}

	public String loadViewMedicines(Prescription p) {
		System.out.println("loadViewMedicines called");
		this.viewMedicines.clear();
		this.medicineFirst=0;
		this.prescription = p;
		FacesContext context = FacesContext.getCurrentInstance();
		if (prescribedMedicines != null && !prescribedMedicines.isEmpty()) {
			for (PrescribedMedicines med : prescribedMedicines) {
				if (p.getPrescriptionId().equals(med.getPrescription().getPrescriptionId())) {
					this.viewMedicines.add(med);
				}
			}
		}
		this.viewMedicines.addAll(providerEjb.fetchMedicines(p.getPrescriptionId()));
		System.out.println("returned");
		return "ViewMedicines?faces-redirect=true";
	}

	public String loadViewTests(Prescription p) {
		this.viewTests.clear();
		this.testFirst=0;
		this.prescription = p;
		FacesContext context = FacesContext.getCurrentInstance();
		if (procedureTests != null && !procedureTests.isEmpty()) {
			for (ProcedureTest test : procedureTests) {
				if (p.getPrescriptionId().equals(test.getPrescription().getPrescriptionId())) {
					this.viewTests.add(test);
				}
			}
		}
		this.viewTests.addAll(providerEjb.fetchTests(p.getPrescriptionId()));
		return "ViewTests?faces-redirect=true";
	}

	public String loadViewLogs() {
		this.viewLogs.clear();
		FacesContext context = FacesContext.getCurrentInstance();
		if (viewLogs != null && !viewLogs.isEmpty()) {
			this.viewLogs.addAll(procedureLogs);
		}
		this.viewLogs.addAll(providerEjb.fetchLogs(procedure.getProcedureId()));
		if (this.viewLogs == null || this.viewLogs.isEmpty()) {
			context.addMessage(null,
			        new FacesMessage(FacesMessage.SEVERITY_ERROR,
			            "No logs found for this procedure.", null));
			return null;
		}
		return "ViewLogs?faces-redirect=true";
	}

	public String updatePrescription(Prescription p) throws ClassNotFoundException, SQLException {
	    Boolean isValid = true;
	    FacesContext context = FacesContext.getCurrentInstance();

	    if (p.getStartDate() == null) {
	        context.addMessage("startDate", new FacesMessage(FacesMessage.SEVERITY_ERROR,
	                "Please enter the Prescription Start date.", null));
	        context.validationFailed();
	        isValid = false;
	    }

	    if (p.getEndDate() == null) {
	        context.addMessage("endDate", new FacesMessage(FacesMessage.SEVERITY_ERROR,
	                "Please enter the Prescription End date.", null));
	        context.validationFailed();
	        isValid = false;
	    }

	    if (!isValid) {
	        return null;
	    }

	    // SINGLE_DAY validation
	    if (procedure.getType() == ProcedureType.SINGLE_DAY) {
	        Date procedureDate = procedure.getProcedureDate();
	        Date startDate = p.getStartDate();
	        Date endDate = p.getEndDate();
	        Date truncatedStartDate = Converter.truncateTime(startDate);
	        Date truncatedEndDate = Converter.truncateTime(endDate);
	        Date truncatedProcedureDate = Converter.truncateTime(procedureDate);

	        if (truncatedStartDate.before(truncatedProcedureDate)) {
	            context.addMessage("startDate", new FacesMessage(FacesMessage.SEVERITY_ERROR,
	                    "Prescription start date (" + formatDate(truncatedStartDate)
	                            + ") cannot be before the procedure date (" + formatDate(truncatedProcedureDate) + ").", null));
	            context.validationFailed();
	            isValid = false;
	        }

	        if (truncatedEndDate.before(truncatedStartDate)) {
	            context.addMessage("endDate", new FacesMessage(FacesMessage.SEVERITY_ERROR,
	                    "Prescription end date (" + formatDate(truncatedEndDate)
	                            + ") cannot be before the prescription start date (" + formatDate(truncatedStartDate) + ").", null));
	            context.validationFailed();
	            isValid = false;
	        }
	    }

	    // LONG_TERM validation
	    if (procedure.getType() == ProcedureType.LONG_TERM &&
	        procedure.getProcedureStatus() == ProcedureStatus.IN_PROGRESS) {

	        Date fromDate = procedure.getFromDate();
	        Date startDate = p.getStartDate();
	        Date endDate = p.getEndDate();
	        Date truncatedStartDate = Converter.truncateTime(startDate);
	        Date truncatedEndDate = Converter.truncateTime(endDate);
	        Date truncatedFromDate = Converter.truncateTime(fromDate);

	        if (truncatedStartDate.before(truncatedFromDate)) {
	            context.addMessage("startDate", new FacesMessage(FacesMessage.SEVERITY_ERROR,
	                    "Prescription start date (" + formatDate(truncatedStartDate)
	                            + ") cannot be before the procedure start date (" + formatDate(truncatedFromDate) + ").", null));
	            context.validationFailed();
	            isValid = false;
	        }

	        if (truncatedEndDate.before(truncatedStartDate)) {
	            context.addMessage("endDate", new FacesMessage(FacesMessage.SEVERITY_ERROR,
	                    "Prescription end date (" + formatDate(truncatedEndDate)
	                            + ") cannot be before the prescription start date (" + formatDate(truncatedStartDate) + ").", null));
	            context.validationFailed();
	            isValid = false;
	        }
	    }

	    // Validate against prescribed medicines
	    loadViewMedicines(p);
	    if (viewMedicines != null && !viewMedicines.isEmpty()) {
	        for (PrescribedMedicines pm : viewMedicines) {
	            if (pm.getPrescription().getPrescriptionId().equals(p.getPrescriptionId())) {
	                if (pm.getStartDate().before(p.getStartDate())) {
	                    context.addMessage("startDate", new FacesMessage(FacesMessage.SEVERITY_ERROR,
	                            "Prescription start date (" + formatDate(p.getStartDate())
	                                    + ") is after medicine start date (" + formatDate(pm.getStartDate()) + ") for "
	                                    + pm.getMedicineName(), null));
	                    context.validationFailed();
	                    isValid = false;
	                    break;
	                }
	                if (pm.getEndDate().after(p.getEndDate())) {
	                    context.addMessage("endDate", new FacesMessage(FacesMessage.SEVERITY_ERROR,
	                            "Prescription end date (" + formatDate(p.getEndDate())
	                                    + ") is before medicine end date (" + formatDate(pm.getEndDate()) + ") for "
	                                    + pm.getMedicineName(), null));
	                    context.validationFailed();
	                    isValid = false;
	                    break;
	                }
	            }
	        }
	    }

	    // Validate against prescribed tests
	    loadViewTests(p);
	    if (viewTests != null && !viewTests.isEmpty()) {
	        for (ProcedureTest pt : viewTests) {
	            if (pt.getPrescription().getPrescriptionId().equals(p.getPrescriptionId())) {
	                if (pt.getTestDate().before(p.getStartDate())) {
	                    context.addMessage("startDate", new FacesMessage(FacesMessage.SEVERITY_ERROR,
	                            "Prescription start date (" + formatDate(p.getStartDate())
	                                    + ") is after test start date (" + formatDate(pt.getTestDate()) + ") for "
	                                    + pt.getTestName(), null));
	                    context.validationFailed();
	                    isValid = false;
	                    break;
	                }
	               
	            }
	        }
	    }

	    if (!isValid) {
	        return null;
	    }

	    // Update in local list or DB
	    if (prescriptions != null && !prescriptions.isEmpty()) {
	        for (int i = 0; i < prescriptions.size(); i++) {
	            Prescription pr = prescriptions.get(i);
	            if (pr.getPrescriptionId().equals(p.getPrescriptionId())) {
	                prescriptions.set(i, p);
	                loadViewPrescriptions();
	                return "ViewPrescriptions?faces-redirect=True";
	            }
	        }
	    } else {
	        providerEjb.updatePrescription(p);
	        loadViewPrescriptions();
	        return "ViewPrescriptions?faces-redirect=True";
	    }

	    return null;
	}


	public String updateMedicine(PrescribedMedicines pm) throws ClassNotFoundException, SQLException {
		Boolean isValid = true;
		FacesContext context = FacesContext.getCurrentInstance();
		pm.setPrescription(this.prescription);

		// Basic field validations
		if (pm.getDosage() == null || pm.getDosage().trim().isEmpty()) {
			context.addMessage("dosage", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Enter dosage", null));
			context.validationFailed();
			isValid = false;
		}
		if (pm.getStartDate() == null) {
			context.addMessage("startDate", new FacesMessage(FacesMessage.SEVERITY_ERROR,
					"Enter from which date to start taking medicine", null));
			context.validationFailed();
			isValid = false;
		}
		if (pm.getDuration() == null || pm.getDuration().trim().isEmpty()) {
			context.addMessage("duration", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Enter duration", null));
			context.validationFailed();
			isValid = false;
		}

		if (!isValid) return null;

		// Dosage format validation
		String dosage = pm.getDosage();
		MedicineType type = pm.getType();
		String pattern = "";
		String format = "";

		switch (type) {
			case TABLET:
				pattern = "^\\d+\\s*tablet(s)?$";
				format = "tablets";
				break;
			case SYRUP:
				pattern = "^\\d+(\\.\\d+)?\\s*ml$";
				format = "ml";
				break;
			case INJECTION:
				pattern = "^(\\d+(\\.\\d+)?\\s*ml|\\d+\\s*dose(s)?)$";
				format = "ml/dose";
				break;
			case DROP:
				pattern = "^\\d+\\s*drop(s)?$";
				format = "drops";
				break;
			default:
				context.addMessage("type",
						new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid or missing medicine type.", null));
				context.validationFailed();
				isValid = false;
		}

		if (!dosage.trim().toLowerCase().matches(pattern)) {
			context.addMessage("dosage", new FacesMessage(FacesMessage.SEVERITY_ERROR,
					"Dosage format is invalid for " + type + " type: " + format, null));
			context.validationFailed();
			isValid = false;
		}

		// Prescription dates
		Date prescriptionStart = this.prescription.getStartDate();
		Date prescriptionEnd = this.prescription.getEndDate();
		Date medStart = pm.getStartDate();

		if (medStart.before(prescriptionStart)) {
			context.addMessage("startDate", new FacesMessage(FacesMessage.SEVERITY_ERROR,
					"Start date (" + medStart + ") cannot be before prescription start date (" + prescriptionStart + ").",
					null));
			context.validationFailed();
			isValid = false;
		}

		if (medStart.after(prescriptionEnd)) {
			context.addMessage("startDate", new FacesMessage(FacesMessage.SEVERITY_ERROR,
					"Start date (" + medStart + ") cannot be after prescription end date (" + prescriptionEnd + ").",
					null));
			context.validationFailed();
			isValid = false;
		}

		// Duration validation and end date calculation
		int durationDays = 0;
		Date medEnd = null;

		if (pm.getDuration() != null && !pm.getDuration().trim().isEmpty()) {
			try {
				durationDays = Integer.parseInt(pm.getDuration().trim());
				long medEndTime = medStart.getTime() + (durationDays - 1L) * 24 * 60 * 60 * 1000;
				medEnd = new Date(medEndTime);
				pm.setEndDate(medEnd); // Set the calculated end date

				// Check if end date falls within prescription
				if (medEnd != null && medEnd.after(prescriptionEnd)) {
				    // Calculate the maximum valid duration from start date to prescription end date
				    long maxAllowedDuration = (prescriptionEnd.getTime() - medStart.getTime()) / (1000 * 60 * 60 * 24) + 1;

				    // Format the dates
				    SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
				    String formattedMedStart = sdf.format(medStart);
				    String formattedPrescriptionEnd = sdf.format(prescriptionEnd);

				    context.addMessage("duration", new FacesMessage(FacesMessage.SEVERITY_ERROR,
				            "The given duration falls outside the prescription period. Maximum allowed duration from "
				                    + formattedMedStart + " to " + formattedPrescriptionEnd + " is " + maxAllowedDuration + " days.",
				            null));
				    context.validationFailed();
				    isValid = false;
				}
			} catch (NumberFormatException e) {
				context.addMessage("duration", new FacesMessage(FacesMessage.SEVERITY_ERROR,
						"Duration must be a valid integer number.", null));
				context.validationFailed();
				isValid = false;
			}
		}

		if (!isValid) return null;

		// Replace in list or update via EJB
		if (prescribedMedicines != null && !prescribedMedicines.isEmpty()) {
			for (int i = 0; i < prescribedMedicines.size(); i++) {
				PrescribedMedicines md = prescribedMedicines.get(i);
				if (md.getPrescribedId().equals(pm.getPrescribedId())) {
					prescribedMedicines.set(i, pm);
					loadViewMedicines(this.prescription);
					return "ViewMedicines?faces-redirect=true";
				}
			}
		} else {
			providerEjb.updateMedicine(pm);
			loadViewMedicines(this.prescription);
			return "ViewMedicines?faces-redirect=true";
		}

		return null;
	}

	public String updateTest(ProcedureTest test) throws ClassNotFoundException, SQLException {
	    Boolean isValid = true;
	    test.setPrescription(prescription);
	    FacesContext context = FacesContext.getCurrentInstance();

	    // Validation: Result Summary
	    if (test.getResultSummary() == null || test.getResultSummary().isEmpty()) {
	        context.addMessage("resultSummary",
	                new FacesMessage(FacesMessage.SEVERITY_ERROR, "Enter Result summary", null));
	        context.validationFailed();
	        isValid = false;
	    }

	    // Validation: Test Date
	    if (test.getTestDate() == null) {
	        context.addMessage("testDate", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Enter Test Date", null));
	        context.validationFailed();
	        isValid = false;
	    }

	    if (!isValid)
	        return null;

	    // Prescription dates
	    Date testDate = test.getTestDate();
	    Date prescriptionStart = this.prescription.getStartDate();
	    Date prescriptionEnd = this.prescription.getEndDate();

	    // Check if test date is before prescription start
	    if (testDate.before(prescriptionStart)) {
	        context.addMessage("testDate", new FacesMessage(FacesMessage.SEVERITY_ERROR,
	                "Test date (" + formatDate(testDate) + ") cannot be before prescription start date ("
	                        + formatDate(prescriptionStart) + ").",
	                null));
	        context.validationFailed();
	        isValid = false;
	    }

	    // Check if test date is after prescription end
	    if (testDate.after(prescriptionEnd)) {
	        context.addMessage("testDate", new FacesMessage(FacesMessage.SEVERITY_ERROR,
	                "Test date (" + formatDate(testDate) + ") cannot be after prescription end date ("
	                        + formatDate(prescriptionEnd) + ").",
	                null));
	        context.validationFailed();
	        isValid = false;
	    }

	    if (!isValid)
	        return null;

	    // Update in list or persist
	    if (procedureTests != null && !procedureTests.isEmpty()) {
	        for (int i = 0; i < procedureTests.size(); i++) {
	            ProcedureTest t = procedureTests.get(i);
	            if (test.getTestId().equals(t.getTestId())) {
	                procedureTests.set(i, test); // Replace existing test
	                loadViewTests(this.prescription);
	                return "ViewTests?faces-redirect=True";
	            }
	        }
	    } else {
	        providerEjb.updateTest(test);
	        loadViewTests(this.prescription);
	        return "ViewTests?faces-redirect=True";
	    }

	    return null;
	}

	public String updateLog(ProcedureDailyLog log) throws ClassNotFoundException, SQLException {
		
		if (procedureLogs != null && !procedureLogs.isEmpty()) {
			for (int i = 0; i < procedureLogs.size(); i++) {
				ProcedureDailyLog pLog = procedureLogs.get(i);
				if (pLog.getLogId().equals(log.getLogId())) {
					procedureLogs.set(i, log); // Replace the old medicine with the new one
					return "ViewLogs?faces-redirect=True"; // Optional status message
				}
			}
		} else {
			providerEjb.updateLog(log);
			return "ViewLogs?faces-redirect=True";
		}
		return null;
	}

	public String editPrescription(Prescription p) {
		this.prescription = p;
		tempPrescription = new Prescription();
		tempPrescription.setStartDate(p.getStartDate());
		tempPrescription.setEndDate(p.getEndDate());
		return "EditPrescription?faces-redirect=true";
	}

	public String editMedicine(PrescribedMedicines pm) {
		this.prescribedMedicine = pm;
		tempMedicine = new PrescribedMedicines();
		tempMedicine.setStartDate(pm.getStartDate());
		tempMedicine.setEndDate(pm.getEndDate());
		tempMedicine.setDuration(pm.getDuration());
		tempMedicine.setDosage(pm.getDosage());
		tempMedicine.setNotes(pm.getNotes());
		return "EditMedicine?faces-redirect=true";
	}

	public String editTest(ProcedureTest t) {
		this.procedureTest = t;
		tempTest = new ProcedureTest();
		tempTest.setTestDate(t.getTestDate());
		tempTest.setResultSummary(t.getResultSummary());
		return "EditTest?faces-redirect=true";
	}

	public String editLog(ProcedureDailyLog l) {
		this.procedureLog = l;
		tempLog = new ProcedureDailyLog();
		tempLog.setVitals(l.getVitals());
		tempLog.setNotes(l.getNotes());
		return "EditLog?faces-redirect=true";
	}

	public String resetEditPrescription() throws ClassNotFoundException, SQLException {
		this.prescription.setStartDate(tempPrescription.getStartDate());
		this.prescription.setEndDate(tempPrescription.getEndDate());
		return "EditPrescription?faces-redirect=true";
	}

	public String restEditMedicine() throws ClassNotFoundException, SQLException {
		this.prescribedMedicine.setStartDate(tempMedicine.getStartDate());
		this.prescribedMedicine.setEndDate(tempMedicine.getEndDate());
		this.prescribedMedicine.setDosage(tempMedicine.getDosage());
		this.prescribedMedicine.setDuration(tempMedicine.getDuration());
		this.prescribedMedicine.setNotes(tempMedicine.getNotes());
		return "EditMedicine?faces-redirect=true";
	}

	public String restEditTest() throws ClassNotFoundException, SQLException {
		this.procedureTest.setResultSummary(tempTest.getResultSummary());
		this.procedureTest.setTestDate(tempTest.getTestDate());
		return "EditTest?faces-redirect=true";
	}

	public String restEditLog() throws ClassNotFoundException, SQLException {
		this.procedureLog.setVitals(tempLog.getVitals());
		this.procedureLog.setNotes(tempLog.getNotes());
		return "EditLog?faces-redirect=true";
	}

	public String backFromViewPrescription() {
		this.procedure.setDiagnosis(tempProcedure.getDiagnosis());
		this.procedure.setRecommendations(tempProcedure.getRecommendations());
		if (procedure.getType() == ProcedureType.SINGLE_DAY) {
			return "ProcedureDashboard?faces-redirect=true";
		} else {
			return "LongTermProcedureDashboard?faces-redirect=true";
		}
	}

	public String updateInprogressProcedure(MedicalProcedure p) {
		FacesContext context = FacesContext.getCurrentInstance();
		boolean isValid = true;
		if (p.getDiagnosis().isEmpty()) {
			context.addMessage("diagnosis",
					new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid diagnosis", "Enter the diagnosis"));
			context.validationFailed();
			isValid = false;
		}
		if (!isValid)
			return null;
		// Validate Diagnosis
		if (p.getDiagnosis() == null || p.getDiagnosis().trim().length() < 2) {
			context.addMessage("diagnosis", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid Diagnosis",
					"Diagnosis must contain at least 2 letters."));
			context.validationFailed();
			isValid = false;
		}
		if (!isValid)
			return null;
		this.tempProcedure=p;
		return "LongTermProcedureDashboard?faces-redirect=true";
	}

	public String updateSingleDayProcedure(MedicalProcedure p) {
		FacesContext context = FacesContext.getCurrentInstance();
		boolean isValid = true;
		if (p.getDiagnosis().isEmpty()) {
			context.addMessage("diagnosis",
					new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid diagnosis", "Enter the diagnosis"));
			context.validationFailed();
			isValid = false;
		}
		if (!isValid)
			return null;
// Validate Diagnosis
		if (p.getDiagnosis() == null || p.getDiagnosis().trim().length() < 2) {
			context.addMessage("diagnosis", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid Diagnosis",
					"Diagnosis must contain at least 2 letters."));
			context.validationFailed();
			isValid = false;
		}
		if (!isValid)
			return null;
		this.tempProcedure=p;
		return "ProcedureDashboard?faces-redirect=true";
	}

	public String updateLastMedicine(PrescribedMedicines pm) {
		 boolean isValid = true;
		    FacesContext context = FacesContext.getCurrentInstance();
		    pm.setPrescription(this.prescription);

		    if (pm.getDosage() == null || pm.getDosage().trim().isEmpty()) {
		        context.addMessage("dosage", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Enter dosage", null));
		        context.validationFailed();
		        isValid = false;
		    }

		    if (pm.getStartDate() == null) {
		        context.addMessage("startDate", new FacesMessage(FacesMessage.SEVERITY_ERROR,
		                "Enter from which date to start taking medicine", null));
		        context.validationFailed();
		        isValid = false;
		    }

		    if (pm.getDuration() == null || pm.getDuration().trim().isEmpty()) {
		        context.addMessage("duration", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Enter duration", null));
		        context.validationFailed();
		        isValid = false;
		    }

		    if (!isValid) return null;

		    // Dosage format validation
		    String dosage = pm.getDosage().trim().toLowerCase();
		    MedicineType type = pm.getType();
		    String pattern = "", format = "";

		    switch (type) {
		        case TABLET:
		            pattern = "^\\d+\\s*tablet(s)?$";
		            format = "tablets";
		            break;
		        case SYRUP:
		            pattern = "^\\d+(\\.\\d+)?\\s*ml$";
		            format = "ml";
		            break;
		        case INJECTION:
		            pattern = "^(\\d+(\\.\\d+)?\\s*ml|\\d+\\s*dose(s)?)$";
		            format = "ml/dose";
		            break;
		        case DROP:
		            pattern = "^\\d+\\s*drop(s)?$";
		            format = "drops";
		            break;
		        default:
		            context.addMessage("type", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid or missing medicine type.", null));
		            context.validationFailed();
		            isValid = false;
		    }

		    if (!dosage.matches(pattern)) {
		        context.addMessage("dosage", new FacesMessage(FacesMessage.SEVERITY_ERROR,
		                "Dosage format is invalid for " + type + " type: " + format, null));
		        context.validationFailed();
		        isValid = false;
		    }

		    // Prescription date range
		    Date prescriptionStart = this.prescription.getStartDate();
		    Date prescriptionEnd = this.prescription.getEndDate();
		    Date medStart = pm.getStartDate();

		    if (medStart.before(prescriptionStart)) {
		        context.addMessage("startDate", new FacesMessage(FacesMessage.SEVERITY_ERROR,
		                "Start date (" + formatDate(medStart) + ") cannot be before prescription start date (" + formatDate(prescriptionStart) + ").", null));
		        context.validationFailed();
		        isValid = false;
		    }

		    if (medStart.after(prescriptionEnd)) {
		        context.addMessage("startDate", new FacesMessage(FacesMessage.SEVERITY_ERROR,
		                "Start date (" + formatDate(medStart) + ") cannot be after prescription end date (" + formatDate(prescriptionEnd) + ").", null));
		        context.validationFailed();
		        isValid = false;
		    }

		    // Duration validation and end date calculation
		    try {
		        int durationDays = Integer.parseInt(pm.getDuration().trim());
		        long medEndTime = medStart.getTime() + (durationDays - 1L) * 24 * 60 * 60 * 1000;
		        Date medEnd = new Date(medEndTime);
		        pm.setEndDate(medEnd); // calculated end date

		        if (medEnd.after(prescriptionEnd)) {
		            long maxAllowedDuration = (prescriptionEnd.getTime() - medStart.getTime()) / (1000 * 60 * 60 * 24) + 1;

		            context.addMessage("duration", new FacesMessage(FacesMessage.SEVERITY_ERROR,
		                    "The given duration falls outside the prescription period. "
		                            + "Maximum allowed duration from " + formatDate(medStart)
		                            + " to " + formatDate(prescriptionEnd) + " is " + maxAllowedDuration + " days.", null));
		            context.validationFailed();
		            isValid = false;
		        }

		    } catch (NumberFormatException e) {
		        context.addMessage("duration", new FacesMessage(FacesMessage.SEVERITY_ERROR,
		                "Duration must be a valid integer number.", null));
		        context.validationFailed();
		        isValid = false;
		    }

		    if (!isValid) return null;

		if (prescribedMedicines != null && !prescribedMedicines.isEmpty()) {
			prescribedMedicines.removeIf(p -> p.getPrescribedId().equals(pm.getPrescribedId()));
		}
		if (prescribedMedicines != null) {
		    prescribedMedicines.add(pm);
		}
		return "PrescriptionDashboard?faces-redirect=true";
	}

	public String updateLastTest(ProcedureTest t) {
		Boolean isValid = true;
		t.setPrescription(prescription);
		FacesContext context = FacesContext.getCurrentInstance();
		if (t.getResultSummary().isEmpty()) {
			context.addMessage("resultSummary",
					new FacesMessage(FacesMessage.SEVERITY_ERROR, "Enter Result summary", null));
			context.validationFailed();
			isValid = false;
		}
		if (t.getTestDate() == null) {
			context.addMessage("testDate", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Enter Test Date", null));
			context.validationFailed();
			isValid = false;
		}
		if (!isValid)
			return null;
		// 2. Validate Test Date
		Date testDate = t.getTestDate();

		Date prescriptionStart = this.prescription.getStartDate();
		Date prescriptionEnd = this.prescription.getEndDate();

		if (testDate.before(prescriptionStart)) {
			context.addMessage("testDate", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Test date (" + formatDate(testDate)
					+ ") cannot be before prescription start date (" + formatDate(prescriptionStart) + ").", null));
			context.validationFailed();
			isValid = false;
		}

		if (testDate.after(prescriptionEnd)) {
			context.addMessage("testDate", new FacesMessage(FacesMessage.SEVERITY_ERROR,
					"Test date (" + formatDate(testDate) + ") cannot be after prescription end date (" + formatDate(prescriptionEnd) + ").",
					null));
			context.validationFailed();
			isValid = false;
		}
		if (!isValid)
			return null;
		if (procedureTests != null) {
		    procedureTests.add(t);
		}
		return "PrescriptionDashboard?faces-redirect=true";
	}

	public String resetInProgress() {
		this.procedure.setDiagnosis(tempProcedure.getDiagnosis());
		this.procedure.setRecommendations(tempProcedure.getRecommendations());
		return "EditInProgressProcedure?faces-redirect=true";
	}

	public String resetSingleDay() {
		this.procedure.setDiagnosis(tempProcedure.getDiagnosis());
		this.procedure.setRecommendations(tempProcedure.getRecommendations());
		return "EditSingleDayProcedure?faces-redirect=true";
	}

	public String editLastMedicine() {
		tempMedicine = new PrescribedMedicines();
		tempMedicine.setStartDate(this.prescribedMedicine.getStartDate());
		tempMedicine.setEndDate(this.prescribedMedicine.getEndDate());
		tempMedicine.setDuration(this.prescribedMedicine.getDuration());
		tempMedicine.setDosage(this.prescribedMedicine.getDosage());
		tempMedicine.setNotes(this.prescribedMedicine.getNotes());
		return "EditLastMedicine?faces-redirect=true";
	}

	public String editLastTest() {
		tempTest = new ProcedureTest();
		tempTest.setResultSummary(this.procedureTest.getResultSummary());
		return "EditLastTest?faces-redirect=true";
	}
	public String addExistingPrescMedicine(PrescribedMedicines pm) {
		prescribedMedicines.removeIf(p -> p.getPrescribedId().equals(prescribedMedicine.getPrescribedId()));
		FacesContext context = FacesContext.getCurrentInstance();
		Map<String, Object> sessionMap = context.getExternalContext().getSessionMap();
		boolean isValid = true;
		providerDao = new ProviderDaoImpl();
		prescribedMedicine.setPrescription(prescription);

		// 1. Medicine Name Validation
		String medicineName = prescribedMedicine.getMedicineName();
		if (medicineName == null || medicineName.trim().isEmpty()) {
			context.addMessage("medicineName", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Enter medicine name", null));
			context.validationFailed();
			isValid = false;
		}

		// 2. Basic Field Validations
		if (prescribedMedicine.getDosage() == null || prescribedMedicine.getDosage().trim().isEmpty()) {
			context.addMessage("dosage", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Enter dosage", null));
			context.validationFailed();
			isValid = false;
		}
		if (prescribedMedicine.getStartDate() == null) {
			context.addMessage("startDate", new FacesMessage(FacesMessage.SEVERITY_ERROR,
					"Enter from which date to start taking medicine", null));
			context.validationFailed();
			isValid = false;
		}
		if (prescribedMedicine.getDuration() == null || prescribedMedicine.getDuration().trim().isEmpty()) {
			context.addMessage("duration", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Enter duration", null));
			context.validationFailed();
			isValid = false;
		}
		if (prescribedMedicine.getType() == null) {
			context.addMessage("type", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Enter Medicine type", null));
			context.validationFailed();
			isValid = false;
		}

		if (!isValid) return null;

		// 3. Format and Validate Medicine Name
		if (!medicineName.matches("^[a-zA-Z0-9()\\-+/'. ]{2,50}$")) {
			context.addMessage("medicineName", new FacesMessage(FacesMessage.SEVERITY_ERROR,
					"Medicine name must be 2–50 characters and can include letters, digits, -, /, +, (), '.', and spaces.",
					null));
			context.validationFailed();
			isValid = false;
		}
		medicineName = medicineName.trim().replaceAll("\\s+", " ");
		prescribedMedicine.setMedicineName(medicineName);

		// 4. Dosage Format Validation
		String dosage = prescribedMedicine.getDosage();
		MedicineType type = prescribedMedicine.getType();
		String pattern = "";
		String format = "";

		switch (type) {
			case TABLET:
				pattern = "^\\d+\\s*tablet(s)?$";
				format = "tablets";
				break;
			case SYRUP:
				pattern = "^\\d+(\\.\\d+)?\\s*ml$";
				format = "ml";
				break;
			case INJECTION:
				pattern = "^(\\d+(\\.\\d+)?\\s*ml|\\d+\\s*dose(s)?)$";
				format = "ml/dose";
				break;
			case DROP:
				pattern = "^\\d+\\s*drop(s)?$";
				format = "drops";
				break;
			default:
				context.addMessage("type",
						new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid or missing medicine type.", null));
				context.validationFailed();
				isValid = false;
		}

		if (!dosage.trim().toLowerCase().matches(pattern)) {
			context.addMessage("dosage", new FacesMessage(FacesMessage.SEVERITY_ERROR,
					"Dosage format is invalid for " + type + " type: " + format, null));
			context.validationFailed();
			isValid = false;
		}

		// 5. Calculate End Date and Validate Duration Against Prescription
		Date prescriptionStart = prescription.getStartDate();
		Date prescriptionEnd = prescription.getEndDate();
		Date medStart = prescribedMedicine.getStartDate();
		int durationDays = 0;

		try {
			durationDays = Integer.parseInt(prescribedMedicine.getDuration().trim());
			if (durationDays <= 0) throw new NumberFormatException();
		} catch (NumberFormatException e) {
			context.addMessage("duration",
					new FacesMessage(FacesMessage.SEVERITY_ERROR, "Duration must be a valid positive integer.", null));
			context.validationFailed();
			isValid = false;
			return null;
		}

		// Calculate end date
		Calendar cal = Calendar.getInstance();
		cal.setTime(medStart);
		cal.add(Calendar.DAY_OF_MONTH, durationDays - 1);
		Date medEnd = cal.getTime();
		prescribedMedicine.setEndDate(medEnd);

		// Validate date boundaries
		if (medStart.before(prescriptionStart)) {
			context.addMessage("startDate", new FacesMessage(FacesMessage.SEVERITY_ERROR,
					"Start date (" + formatDate(medStart) + ") cannot be before prescription start date (" + formatDate(prescriptionStart) + ").",
					null));
			context.validationFailed();
			isValid = false;
		}

		if (medEnd != null && medEnd.after(prescriptionEnd)) {
		    // Calculate the maximum valid duration from start date to prescription end date
		    long maxAllowedDuration = (prescriptionEnd.getTime() - medStart.getTime()) / (1000 * 60 * 60 * 24) + 1;

		    // Format the dates
		    SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
		    String formattedMedStart = sdf.format(medStart);
		    String formattedPrescriptionEnd = sdf.format(prescriptionEnd);

		    context.addMessage("duration", new FacesMessage(FacesMessage.SEVERITY_ERROR,
		            "The given duration falls outside the prescription period. Maximum allowed duration from "
		                    + formattedMedStart + " to " + formattedPrescriptionEnd + " is " + maxAllowedDuration + " days.",
		            null));
		    context.validationFailed();
		    isValid = false;
		}

		// 6. Duplicate check for same medicine & date range
		loadViewMedicines(prescription);
		for (PrescribedMedicines existingMed : viewMedicines) {
			if (existingMed.getPrescription() != null
					&& existingMed.getPrescription().getPrescriptionId().equals(prescription.getPrescriptionId())
					&& existingMed.getMedicineName() != null
					&& existingMed.getMedicineName().equalsIgnoreCase(medicineName)) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				String currentStart = sdf.format(Converter.truncateTime(medStart));
				String existingStart = sdf.format(Converter.truncateTime(existingMed.getStartDate()));
				String currentEnd = sdf.format(Converter.truncateTime(medEnd));
				String existingEnd = sdf.format(Converter.truncateTime(existingMed.getEndDate()));
				if (currentStart.equals(existingStart) && currentEnd.equals(existingEnd)
						&& existingMed.getType().equals(type)) {
					context.addMessage("medicineName", new FacesMessage(FacesMessage.SEVERITY_ERROR,
							"This medicine is already prescribed in this prescription for the same date range and type",
							null));
					context.validationFailed();
					isValid = false;
				}
			}
		}

		if (!isValid) return null;

		prescribedMedicines.add(prescribedMedicine);
		loadViewMedicines(prescription);
		return "ViewMedicines?faces-redirect=true";
	}

	public String addExistingPrescTest(ProcedureTest t)
	{
		procedureTests.removeIf(p -> p.getTestId().equals(procedureTest.getTestId()));
		FacesContext context = FacesContext.getCurrentInstance();
		Map<String, Object> sessionMap = context.getExternalContext().getSessionMap();
		boolean isValid = true;
		providerDao = new ProviderDaoImpl();

		procedureTest.setPrescription(prescription);
		// 1. Validate Test Name
		String testName = procedureTest.getTestName();
		if (testName.isEmpty()) {
			context.addMessage("testName", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Enter Test name", null));
			context.validationFailed();
			isValid = false;
		}
		if (procedureTest.getTestDate() == null) {
			context.addMessage("testDate", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Enter Test Date", null));
			context.validationFailed();
			isValid = false;
		}
		if (procedureTest.getResultSummary().isEmpty()) {
			context.addMessage("resultSummary",
					new FacesMessage(FacesMessage.SEVERITY_ERROR, "Enter Result summary", null));
			context.validationFailed();
			isValid = false;
		}
		if (!isValid)
			return null;
		if (testName == null || testName.trim().length() < 2 || !testName.matches("^[a-zA-Z0-9 ()/\\-.]+$")) {
			context.addMessage("testName", new FacesMessage(FacesMessage.SEVERITY_ERROR,
					"Test name must be at least 2 characters and contain only letters, numbers, spaces, (), /, -, and .",
					null));
			context.validationFailed();
			isValid = false;
		}
		//test duplicacy check
		testName = testName.trim().replaceAll("\\s+", " ");
		procedureTest.setTestName(testName);
		loadViewTests(prescription);
		for (ProcedureTest existingTest : viewTests) {
			if (existingTest.getPrescription() != null
					&& existingTest.getPrescription().getPrescriptionId().equals(prescription.getPrescriptionId())
					&& existingTest.getTestName() != null && existingTest.getTestName().equalsIgnoreCase(testName)
					&& existingTest.getTestDate().equals(procedureTest.getTestDate())) {
				context.addMessage("testName", new FacesMessage(FacesMessage.SEVERITY_ERROR,
						"This Test is already prescribed in this prescription for the given date.", null));
				context.validationFailed();
				isValid = false;
			}
		}
		// 2. Validate Test Date
		Date testDate = procedureTest.getTestDate();

		Date prescriptionStart = prescription.getStartDate();
		Date prescriptionEnd = prescription.getEndDate();

		if (testDate.before(prescriptionStart)) {
			context.addMessage("testDate", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Test date (" + formatDate(testDate)
					+ ") cannot be before prescription start date (" + formatDate(prescriptionStart) + ").", null));
			context.validationFailed();
			isValid = false;
		}

		if (testDate.after(prescriptionEnd)) {
			context.addMessage("testDate", new FacesMessage(FacesMessage.SEVERITY_ERROR,
					"Test date (" + formatDate(testDate) + ") cannot be after prescription end date (" + formatDate(prescriptionEnd) + ").",
					null));
			context.validationFailed();
			isValid = false;
		}

		// 3. Validate Result Summary
		String result = procedureTest.getResultSummary();
		if (result.isEmpty()) {
			context.addMessage("resultSummary",
					new FacesMessage(FacesMessage.SEVERITY_ERROR, "Enter Result summary", null));
			context.validationFailed();
			isValid = false;
		}
		if (!isValid)
			return null;
		procedureTests.add(procedureTest);
		loadViewTests(prescription);
		return "ViewTests?faces-redirect=true";
	}
	public String backFromEditTest() throws ClassNotFoundException, SQLException
	{
		restEditTest();
		return "ViewTests?faces-redirect=true";
	}
	public String backFromEditPrescription() throws ClassNotFoundException, SQLException
	{
		resetEditPrescription();
		return "ViewPrescriptions?faces-redirect=true";
	}
	public String backFromEditMedicine() throws ClassNotFoundException, SQLException
	{
		restEditMedicine();
		return "ViewMedicines?faces-redirect=true";
	}
	public String backFromEditLogs() throws ClassNotFoundException, SQLException
	{
		restEditLog();
		return "ViewLogs?faces-redirect=true";
	}
	public String backFromLastMedicine() throws ClassNotFoundException, SQLException
	{
		restEditMedicine();	
		return "PrescriptionDashboard?faces-redirect=true";
	}
	public String backFromLastTest() throws ClassNotFoundException, SQLException
	{
		restEditTest();	
		return "PrescriptionDashboard?faces-redirect=true";
	}
	private String formatDate(Date date) {
	    if (date == null) return "";
	    SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
	    return sdf.format(date);
	}
}