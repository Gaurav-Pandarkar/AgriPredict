package org.agriopredict.dto.response;

import java.time.LocalDate;

import org.springframework.stereotype.Component;

@Component
public class AgronomistResponse {

	private String argonomistId;
	private String agronomistName;
	private String mobileNo;
	private String address;
	private LocalDate createdDate;
	private String message;
	private String ResponseCode;

	public String getArgonomistId() {
		return argonomistId;
	}

	public void setArgonomistId(String argonomistId) {
		this.argonomistId = argonomistId;
	}

	public String getAgronomistName() {
		return agronomistName;
	}

	public void setAgronomistName(String agronomistName) {
		this.agronomistName = agronomistName;
	}

	public String getMobileNo() {
		return mobileNo;
	}

	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public LocalDate getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(LocalDate createdDate) {
		this.createdDate = createdDate;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getResponseCode() {
		return ResponseCode;
	}

	public void setResponseCode(String responseCode) {
		ResponseCode = responseCode;
	}

}
