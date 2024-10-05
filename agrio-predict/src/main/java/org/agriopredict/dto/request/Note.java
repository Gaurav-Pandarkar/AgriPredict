package org.agriopredict.dto.request;

import java.time.LocalDate;

import org.springframework.stereotype.Component;

@Component
public class Note {
	
	private String title;
	private String content;
	private LocalDate createdDate;
	
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
	public LocalDate getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(LocalDate createdDate) {
		this.createdDate = createdDate;
	}
	
	

}
