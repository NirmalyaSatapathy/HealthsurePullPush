package com.infinite.jsf.provider.model;

import java.util.Date;

public class RelatedPatientInsuranceDetails {

    private String subscribeId;
    private String memberHId;
    private String memberName;
    private int memberAge;
    private String memberGender;
    private String relationWithProposer;
    private String proposerName;
    private Date enrollmentDate;
    private Date coverageStartDate;
    private Date coverageEndDate;
    private String coverageStatus;
    private String coverageType;
    private double coverageLimit;
    private double remaining;
    private double claimed;
    private Date lastClaimDate;
    private String planName;
    private String companyName;

    public String getPlanName() {
        return planName;
    }

    public void setPlanName(String planName) {
        this.planName = planName;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    // Getters and Setters
    public String getSubscribeId() {
        return subscribeId;
    }

    public void setSubscribeId(String subscribeId) {
        this.subscribeId = subscribeId;
    }

    public String getMemberHId() {
        return memberHId;
    }

    public void setMemberHId(String memberHId) {
        this.memberHId = memberHId;
    }

    public String getMemberName() {
        return memberName;
    }

    public void setMemberName(String memberName) {
        this.memberName = memberName;
    }

    public int getMemberAge() {
        return memberAge;
    }

    public void setMemberAge(int memberAge) {
        this.memberAge = memberAge;
    }

    public String getMemberGender() {
        return memberGender;
    }

    public void setMemberGender(String memberGender) {
        this.memberGender = memberGender;
    }

    public String getRelationWithProposer() {
        return relationWithProposer;
    }

    public void setRelationWithProposer(String relationWithProposer) {
        this.relationWithProposer = relationWithProposer;
    }

    public String getProposerName() {
        return proposerName;
    }

    public void setProposerName(String proposerName) {
        this.proposerName = proposerName;
    }

    public Date getEnrollmentDate() {
        return enrollmentDate;
    }

    public void setEnrollmentDate(Date enrollmentDate) {
        this.enrollmentDate = enrollmentDate;
    }

    public Date getCoverageStartDate() {
        return coverageStartDate;
    }

    public void setCoverageStartDate(Date coverageStartDate) {
        this.coverageStartDate = coverageStartDate;
    }

    public Date getCoverageEndDate() {
        return coverageEndDate;
    }

    public void setCoverageEndDate(Date coverageEndDate) {
        this.coverageEndDate = coverageEndDate;
    }

    public String getCoverageStatus() {
        return coverageStatus;
    }

    public void setCoverageStatus(String coverageStatus) {
        this.coverageStatus = coverageStatus;
    }

    public String getCoverageType() {
        return coverageType;
    }

    public void setCoverageType(String coverageType) {
        this.coverageType = coverageType;
    }

    public double getCoverageLimit() {
        return coverageLimit;
    }

    public void setCoverageLimit(double coverageLimit) {
        this.coverageLimit = coverageLimit;
    }

    public double getRemaining() {
        return remaining;
    }

    public void setRemaining(double remaining) {
        this.remaining = remaining;
    }

    public double getClaimed() {
        return claimed;
    }

    public void setClaimed(double claimed) {
        this.claimed = claimed;
    }

    public Date getLastClaimDate() {
        return lastClaimDate;
    }

    public void setLastClaimDate(Date lastClaimDate) {
        this.lastClaimDate = lastClaimDate;
    }
}