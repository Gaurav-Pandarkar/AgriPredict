//package org.agriopredict.entity;
//
//import java.time.LocalDate;
//
//import org.springframework.stereotype.Component;
//
//import jakarta.persistence.Entity;
//import jakarta.persistence.GeneratedValue;
//import jakarta.persistence.GenerationType;
//import jakarta.persistence.Id;
//import jakarta.persistence.Table;
//
//@Entity
//@Table(name = "agronomist")
//@Component
//public class Agronomist {
//
//	@GeneratedValue(strategy = GenerationType.IDENTITY)
//    private String agronomistId;
//    
//    private String agronomistName;
//    private String mobileNo;
//    private String address;
//    private LocalDate createdDate;
//    
//	public String getAgronomistId() {
//		return agronomistId;
//	}
//	public void setAgronomistId(String agronomistId) {
//		this.agronomistId = agronomistId;
//	}
//	public String getAgronomistName() {
//		return agronomistName;
//	}
//	public void setAgronomistName(String agronomistName) {
//		this.agronomistName = agronomistName;
//	}
//	public String getMobileNo() {
//		return mobileNo;
//	}
//	public void setMobileNo(String mobileNo) {
//		this.mobileNo = mobileNo;
//	}
//	public String getAddress() {
//		return address;
//	}
//	public void setAddress(String address) {
//		this.address = address;
//	}
//	public LocalDate getCreatedDate() {
//		return createdDate;
//	}
//	public void setCreatedDate(LocalDate createdDate) {
//		this.createdDate = createdDate;
//	}
//    
//}
