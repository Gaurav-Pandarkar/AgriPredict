package org.agriopredict.controller;

import org.agriopredict.dto.request.UserNoteRequest;
import org.agriopredict.dto.response.UserNoteResponse;
import org.agriopredict.service.UserNoteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/notes")  
public class UserNoteMakingController {

    @Autowired
    private UserNoteService userNoteService;
    @PostMapping("/userNotes")
    public ResponseEntity<UserNoteResponse> addOrUpdateNote(@RequestBody UserNoteRequest request) {
        UserNoteResponse response = userNoteService.addOrUpdateNote(request);
        return ResponseEntity.status(getHttpStatus(response.getResponseCode())).body(response);
    }

    @GetMapping("/{mobileNo}")
    public ResponseEntity<UserNoteResponse> getNoteByMobileNo(@PathVariable long mobileNo) {
        UserNoteResponse response = userNoteService.getNoteByMobileNo(mobileNo);
        return ResponseEntity.status(getHttpStatus(response.getResponseCode())).body(response);
    }

    @DeleteMapping("/{mobileNo}")
    public ResponseEntity<UserNoteResponse> deleteNoteByMobileNo(@PathVariable long mobileNo) {
        UserNoteResponse response = userNoteService.deleteNoteByMobileNo(mobileNo);
        return ResponseEntity.status(getHttpStatus(response.getResponseCode())).body(response);
    }

    private int getHttpStatus(String responseCode) {
        switch (responseCode) {
            case "200":
                return 200; // OK
            case "201":
                return 201; // Created
            case "400":
                return 400; // Bad Request
            case "404":
                return 404; // Not Found
            default:
                return 500; // Internal Server Error
        }
    }
}
