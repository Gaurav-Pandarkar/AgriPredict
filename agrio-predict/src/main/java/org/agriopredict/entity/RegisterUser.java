package org.agriopredict.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDate;

import org.springframework.stereotype.Component;

@Entity
@Table(name = "register_users")
@Component
public class RegisterUser {
	
	@GeneratedValue
	private long userRegisterCode;

    @Id
    private String userId;
    
    private String username;
    private String mobileNo;
    private String address;
    private LocalDate createdDate;
    private String password;
    
    // Getters and Setters
    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
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

	public long getUserRegisterCode() {
		return userRegisterCode;
	}

	public void setUserRegisterCode(long userRegisterCode) {
		this.userRegisterCode = userRegisterCode;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
    
}

