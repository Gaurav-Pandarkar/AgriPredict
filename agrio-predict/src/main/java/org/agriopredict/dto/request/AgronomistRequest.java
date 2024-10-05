package org.agriopredict.dto.request;

import org.springframework.stereotype.Component;

@Component
public class AgronomistRequest {

	private String agronomistName;
	private String mobileNo;
	private String address;

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

}
