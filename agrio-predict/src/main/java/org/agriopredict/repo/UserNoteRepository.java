package org.agriopredict.repo;

import java.util.Optional;

import org.agriopredict.entity.UserNote;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

@Component
@Repository
public interface UserNoteRepository extends JpaRepository<UserNote,Long> {
	
	Optional<UserNote> findByMobileNo(long mobileNo);
}


