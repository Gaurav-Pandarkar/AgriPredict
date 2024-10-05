package org.agriopredict.entity;

import java.time.LocalDate;

import org.springframework.stereotype.Component;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "user_note")
@Component
public class UserNote {

   
    @GeneratedValue
    private String userNoteCode; 
    
    @Id
    private String userNoteId;

    private long mobileNo;

    private String title;  

    private String content;  
    
    private LocalDate createdDate;

    public long getMobileNo() {
        return mobileNo;
    }

    public void setMobileNo(long mobileNo) {
        this.mobileNo = mobileNo;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getUserNoteCode() {
        return userNoteCode;
    }

    public void setUserNoteCode(String userNoteCode) {
        this.userNoteCode = userNoteCode;
    }

	public String getUserNoteId() {
		return userNoteId;
	}

	public void setUserNoteId(String userNoteId) {
		this.userNoteId = userNoteId;
	}

	public LocalDate getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(LocalDate localDate) {
		this.createdDate = localDate;
	}
    
}
