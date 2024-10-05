package org.agriopredict.repo;

import java.util.Optional;

import org.agriopredict.entity.RegisterUser;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;


@Component
@Repository
public interface RegisterUserRepo extends JpaRepository<RegisterUser,Long> {
	Optional<RegisterUser> findByMobileNoAndPassword(String mobileNo, String password);
	Optional<RegisterUser> findByMobileNo(String mobileNo);

}
