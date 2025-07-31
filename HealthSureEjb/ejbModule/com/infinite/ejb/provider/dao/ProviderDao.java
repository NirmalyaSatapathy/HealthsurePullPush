package com.infinite.ejb.provider.dao;
import java.sql.SQLException;
import java.util.List;

import com.infinite.ejb.provider.model.MedicalProcedure;
import com.infinite.ejb.provider.model.PrescribedMedicines;
import com.infinite.ejb.provider.model.Prescription;
import com.infinite.ejb.provider.model.ProcedureDailyLog;
import com.infinite.ejb.provider.model.ProcedureTest;

public interface ProviderDao {
	public String addMedicalProcedure(MedicalProcedure medicalProcedure) throws ClassNotFoundException, java.sql.SQLException;
	public String addPrescription(Prescription prescription) throws ClassNotFoundException, SQLException;
	public String addTest(ProcedureTest procedureTest) throws ClassNotFoundException, SQLException;
	public String addPrescribedMedicines(PrescribedMedicines prescribedMedicines) throws ClassNotFoundException, SQLException;
	public String generateNewPrescriptionId() throws ClassNotFoundException, SQLException;
	public String generateNewPrescribedMedicineId() throws ClassNotFoundException, SQLException;
	public String generateNewProcedureTestId() throws ClassNotFoundException, SQLException;
	public String generateNewProcedureId() throws SQLException, ClassNotFoundException;
	public String addProcedureDailyLog(ProcedureDailyLog log) throws ClassNotFoundException, SQLException;
	public String generateNewProcedureLogId() throws ClassNotFoundException, SQLException;
	public String updateProcedureStatus(MedicalProcedure procedure);
	public MedicalProcedure getProcedureById(String id);
	public List<MedicalProcedure> getScheduledProceduresByDoctor(String doctorId, String procedureId);
	public List<MedicalProcedure> getInProgressProceduresByDoctor(String doctorId, String procedureId);
	public List<Prescription> fetchPrescriptions(String procedureID);
	public List<PrescribedMedicines> fetchMedicines(String prescriptionId);
	public List<ProcedureTest> fetchTests(String prescriptionId);
	public List<ProcedureDailyLog> fetchLogs(String procedureID);
	public String updatePrescription(Prescription p) throws SQLException, ClassNotFoundException;
	public String updateMedicine(PrescribedMedicines m) throws ClassNotFoundException, SQLException;
	public String updateTest(ProcedureTest t) throws ClassNotFoundException, SQLException;
	public String updateLog(ProcedureDailyLog l)throws ClassNotFoundException, SQLException; 
	
}
