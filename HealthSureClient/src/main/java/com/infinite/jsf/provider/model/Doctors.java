package com.infinite.jsf.provider.model;

import java.io.Serializable;
import java.util.Set;

import com.infinite.jsf.provider.model.DoctorStatus;
import com.infinite.jsf.provider.model.DoctorType;
import com.infinite.jsf.provider.model.Gender;
import com.infinite.jsf.provider.model.MedicalProcedure;
import com.infinite.jsf.provider.model.Prescription;
import com.infinite.jsf.provider.model.Provider;
import com.infinite.jsf.pharmacy.model.DispensedEquipment;
import com.infinite.jsf.pharmacy.model.DispensedMedicine;

public class Doctors {
	private String doctorId;
    private String providerId;
    private String doctorName;
    private String qualification;
    private String specialization;
    private String phoneNumber;
    private String licenseNo;
    public Doctors() {
		super();
		// TODO Auto-generated constructor stub
	}

	private String email;
    private String address;
    private Gender gender;
    private String password;
    private DoctorType doctorType;  // STANDARD or ADHOC
    private DoctorStatus doctorStatus;

    // Relationships
    private Provider provider;  // Assuming mapped in Provider class
    private Set<MedicalProcedure> procedures;
    private Set<Prescription> prescriptions;

    // Getters and setters
    public String getDoctorId() { return doctorId; }
    public void setDoctorId(String doctorId) { this.doctorId = doctorId; }

    public String getProviderId() { return providerId; }
    public void setProviderId(String providerId) { this.providerId = providerId; }

    public String getDoctorName() { return doctorName; }
    public void setDoctorName(String doctorName) { this.doctorName = doctorName; }

    public String getQualification() { return qualification; }
    public void setQualification(String qualification) { this.qualification = qualification; }

    public String getSpecialization() { return specialization; }
    public void setSpecialization(String specialization) { this.specialization = specialization; }

    public String getLicenseNo() { return licenseNo; }
    public void setLicenseNo(String licenseNo) { this.licenseNo = licenseNo; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    
    

    public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public Gender getGender() {
		return gender;
	}
	public void setGender(Gender gender) {
		this.gender = gender;
	}
	public DoctorType getDoctorType() {
		return doctorType;
	}
	public void setDoctorType(DoctorType doctorType) {
		this.doctorType = doctorType;
	}
	public DoctorStatus getDoctorStatus() {
		return doctorStatus;
	}
	public void setDoctorStatus(DoctorStatus doctorStatus) {
		this.doctorStatus = doctorStatus;
	}
	public Provider getProvider() { return provider; }
    public void setProvider(Provider provider) { this.provider = provider; }

    public Set<MedicalProcedure> getProcedures() { return procedures; }
    public void setProcedures(Set<MedicalProcedure> procedures) { this.procedures = procedures; }

    public Set<Prescription> getPrescriptions() { return prescriptions; }
    public void setPrescriptions(Set<Prescription> prescriptions) { this.prescriptions = prescriptions; }
}