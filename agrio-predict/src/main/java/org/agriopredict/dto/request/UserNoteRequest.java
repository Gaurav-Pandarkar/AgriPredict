package org.agriopredict.dto.request;

import java.util.List;

import org.springframework.stereotype.Component;

@Component
public class UserNoteRequest {
	
	private long mobileNo;
	
	private String userNoteId;
	
	private List<Note> notes; 

	public long getMobileNo() {
		return mobileNo;
	}

	public void setMobileNo(long mobileNo) {
		this.mobileNo = mobileNo;
	}

	public String getUserNoteId() {
		return userNoteId;
	}

	public void setUserNoteId(String userNoteId) {
		this.userNoteId = userNoteId;
	}

	public List<Note> getNotes() {
		return notes;
	}

	public void setNotes(List<Note> notes) {
		this.notes = notes;
	}

	
	
}
