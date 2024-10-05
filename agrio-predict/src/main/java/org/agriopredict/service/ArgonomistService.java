//package org.agriopredict.service;
//
//import java.util.Optional;
//
//import org.agriopredict.dto.request.UserNoteRequest;
//import org.agriopredict.dto.response.AgronomistResponse;
//import org.agriopredict.dto.response.UserNoteResponse;
//import org.agriopredict.entity.UserNote;
//import org.agriopredict.repo.AgronomistRepository;
//import org.agriopredict.repo.UserNoteRepository;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Service;
//
//@Service
//public class ArgonomistService {
//	
//	 @Autowired
//	    private AgronomistRepository agronomistRepository;
//
//	    @Autowired
//	    private AgronomistResponse agronomistResponse;
//
//	    public UserNoteResponse addOrUpdateNote(UserNoteRequest request) {
//	        if (request.getMobileNo() == 0 || request.getNote() == null || request.getNote().isEmpty()) {
//	            userNoteResponse.setMessage("Invalid input data");
//	            userNoteResponse.setResponseCode("400");
//	            return userNoteResponse;
//	        }
//
//	        Optional<UserNote> existingNote = userNoteRepository.findById(request.getMobileNo());
//
//	        UserNote note;
//	        if (existingNote.isPresent()) {
//	            note = existingNote.get();
//	            note.setNote(request.getNote());
//	            userNoteResponse.setMessage("Note updated successfully");
//	            userNoteResponse.setResponseCode("200");
//	        } else {
//	            note = new UserNote();
//	            note.setMobileNo(request.getMobileNo());
//	            note.setNote(request.getNote());
//	            userNoteResponse.setMessage("Note created successfully");
//	            userNoteResponse.setResponseCode("201");
//	        }
//
//	        userNoteRepository.save(note);
//	        userNoteResponse.setMobileNo(String.valueOf(request.getMobileNo()));
//	        
//	        return userNoteResponse;
//	    }
//
//	    public UserNoteResponse getNoteByMobileNo(long mobileNo) {
//	        if (mobileNo == 0) {
//	            userNoteResponse.setMessage("Invalid mobile number");
//	            userNoteResponse.setResponseCode("400");
//	            return userNoteResponse;
//	        }
//
//	        Optional<UserNote> note = userNoteRepository.findById(mobileNo);
//
//	        if (note.isPresent()) {
//	            userNoteResponse.setMessage(note.get().getNote());
//	            userNoteResponse.setMobileNo(String.valueOf(note.get().getMobileNo()));
//	            userNoteResponse.setResponseCode("200");
//	        } else {
//	            userNoteResponse.setMessage("Note not found for this mobile number");
//	            userNoteResponse.setResponseCode("404");
//	        }
//
//	        return userNoteResponse;
//	    }
//
//
//}
