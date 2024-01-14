package com.matakuliah.matakuliah.repository;

import com.matakuliah.matakuliah.entity.Matakuliah;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MatakuliahRepository extends JpaRepository<Matakuliah, Long> {
    Optional<Matakuliah> findMatakuliahByNama(String nama);
    Optional<Matakuliah> findMatakuliahById(Long id); 
    
}
