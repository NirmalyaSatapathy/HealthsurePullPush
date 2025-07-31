package com.infinite.ejb.recipient.model;

import java.io.Serializable;
import java.util.Date;
import java.util.Set;

import com.infinite.ejb.provider.model.Appointment;
import com.infinite.ejb.insurance.model.Subscribe;
import com.infinite.ejb.admin.model.PaymentHistory;
import com.infinite.ejb.provider.model.Claims;
import com.infinite.ejb.provider.model.MedicalProcedure;

public class Recipient implements Serializable{
    private String hId;
    private String firstName;
    private String lastName;
    private String mobile;
    private String userName;
    private Gender gender;
    private Date dob;
    private String address;
    private Date createdAt;
    private String password;
    public Recipient() {
		super();
		// TODO Auto-generated constructor stub
	}
	private String email;
    private RecipientStatus status;
    

    // Getters & Setters
    public String gethId() { return hId; }
    public void sethId(String hId) { this.hId = hId; }

    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }

    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }

    public String getMobile() { return mobile; }
    public void setMobile(String mobile) { this.mobile = mobile; }

    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }

    public Gender getGender() { return gender; }
    public void setGender(Gender gender) { this.gender = gender; }

    public Date getDob() { return dob; }
    public void setDob(Date dob) { this.dob = dob; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public RecipientStatus getStatus() { return status; }
    public void setStatus(RecipientStatus status) { this.status = status; }
	public Recipient(String hId, String firstName, String lastName, String mobile, String userName, Gender gender,
			Date dob, String address, Date createdAt, String password, String email, RecipientStatus status) {
		super();
		this.hId = hId;
		this.firstName = firstName;
		this.lastName = lastName;
		this.mobile = mobile;
		this.userName = userName;
		this.gender = gender;
		this.dob = dob;
		this.address = address;
		this.createdAt = createdAt;
		this.password = password;
		this.email = email;
		this.status = status;
	}


   
}
