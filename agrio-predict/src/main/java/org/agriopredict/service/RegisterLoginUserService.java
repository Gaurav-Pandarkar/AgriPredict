package org.agriopredict.service;

import java.time.LocalDate;
import java.util.Optional;

import org.agriopredict.common.RandomStringGenerator;
import org.agriopredict.dto.request.RegisterUserRequest;
import org.agriopredict.dto.request.UserLoginRequest;
import org.agriopredict.dto.response.RegisterUserResponse;
import org.agriopredict.dto.response.UserLoginResponse;
import org.agriopredict.entity.RegisterUser;
import org.agriopredict.repo.RegisterUserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RegisterLoginUserService {
	
    @Autowired
    private RegisterUserRepo userRepository;

    @Autowired
    private RegisterUserResponse registerUserResponse;

    @Autowired
    private UserLoginResponse userLoginResponse;

    public RegisterUserResponse registerUser(RegisterUserRequest request) {
        // Validate input
        if (isInvalidRequest(request)) {
            return createErrorResponse("Invalid input data", "400");
        }

        // Check for existing user
        Optional<RegisterUser> existingUser = userRepository.findByMobileNo(request.getMobileNo());
        if (existingUser.isPresent()) {
            return createErrorResponse("Mobile number already registered", "409");
        }

        // Create and save new user
        RegisterUser user = new RegisterUser();
        user.setUserId(RandomStringGenerator.generateUserId(4));
        user.setUsername(request.getUsername());
        user.setMobileNo(request.getMobileNo());
        user.setAddress(request.getAddress());
        user.setPassword(request.getPassword());
        user.setCreatedDate(LocalDate.now());
        
        user = userRepository.save(user);
        return populateSuccessResponse(user);
    }

    private boolean isInvalidRequest(RegisterUserRequest request) {
        return request.getUsername() == null || request.getUsername().isEmpty() ||
               request.getMobileNo() == null ||
               request.getAddress() == null || request.getAddress().isEmpty() ||
               request.getPassword() == null || request.getPassword().isEmpty();
    }

    private RegisterUserResponse createErrorResponse(String message, String responseCode) {
        registerUserResponse.setMessage(message);
        registerUserResponse.setResponseCode(responseCode);
        return registerUserResponse;
    }

    private RegisterUserResponse populateSuccessResponse(RegisterUser user) {
        registerUserResponse.setUserId(user.getUserId());
        registerUserResponse.setUsername(user.getUsername());
        registerUserResponse.setMobileNo(user.getMobileNo());
        registerUserResponse.setAddress(user.getAddress());
        registerUserResponse.setCreatedDate(user.getCreatedDate());
        registerUserResponse.setMessage("User registered successfully");
        registerUserResponse.setResponseCode("200");
        return registerUserResponse;
    }

    public UserLoginResponse loginUser(UserLoginRequest request) {
        Optional<RegisterUser> user = userRepository.findByMobileNoAndPassword(request.getMobileNo(), request.getPassword());

        if (user.isPresent()) {
            RegisterUser foundUser = user.get();
            userLoginResponse.setUsername(foundUser.getUsername());
            userLoginResponse.setMessage("Login successful");
            userLoginResponse.setResponseCode("200");
        } else {
            userLoginResponse.setMessage("Invalid mobile number or password");
            userLoginResponse.setResponseCode("401");
        }

        return userLoginResponse;
    }
}
