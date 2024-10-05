package org.agriopredict.common;

import org.agriopredict.dto.response.UserNoteResponse;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class AppConfig {

    @Bean
    public UserNoteResponse userNoteResponse() {
        return new UserNoteResponse();
    }
}
