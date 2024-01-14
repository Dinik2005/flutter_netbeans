/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.nilai.nilai.repository;

import com.nilai.nilai.entity.Nilai;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author 
 */
@Repository
public interface NilaiRepository extends JpaRepository<Nilai, Long>{
    
}
