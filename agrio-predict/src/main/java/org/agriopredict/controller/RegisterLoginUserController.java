package org.agriopredict.controller;

import org.agriopredict.dto.request.RegisterUserRequest;
import org.agriopredict.dto.request.UserLoginRequest;
import org.agriopredict.dto.response.RegisterUserResponse;
import org.agriopredict.dto.response.UserLoginResponse;
import org.agriopredict.service.RegisterLoginUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/user")
public class RegisterLoginUserController {

    @Autowired
    private RegisterLoginUserService registerLoginUserService;

    @PostMapping("/register")
    public ResponseEntity<RegisterUserResponse> registerUser(@RequestBody RegisterUserRequest request) {
        RegisterUserResponse response = registerLoginUserService.registerUser(request);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @PostMapping("/login")
    public ResponseEntity<UserLoginResponse> loginUser(@RequestBody UserLoginRequest request) {
        UserLoginResponse response = registerLoginUserService.loginUser(request);
        HttpStatus status = response.getResponseCode().equals("200") ? HttpStatus.OK : HttpStatus.UNAUTHORIZED;
        return new ResponseEntity<>(response, status);
    }
}
