package org.agriopredict.dto.response;

import org.agriopredict.dto.request.Note;

public class UserNoteResponse {
	
	private String userNoteId;
	private String message;
    private String responseCode;
    private String mobileNo;
    private Note note;
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getResponseCode() {
		return responseCode;
	}
	public void setResponseCode(String responseCode) {
		this.responseCode = responseCode;
	}
	public String getMobileNo() {
		return mobileNo;
	}
	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}
	public String getUserNoteId() {
		return userNoteId;
	}
	public void setUserNoteId(String userNoteId) {
		this.userNoteId = userNoteId;
	}
	public Note getNote() {
		return note;
	}
	public void setNote(Note note) {
		this.note = note;
	}

	
}
