package com.matakuliah.matakuliah.controller;

import com.matakuliah.matakuliah.entity.Matakuliah;
import com.matakuliah.matakuliah.request.MatakuliahRequest;
import com.matakuliah.matakuliah.service.MatakuliahService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/matakuliah")
public class MatakuliahController {

    @Autowired
    private MatakuliahService matakuliahService;

    @GetMapping
    public List<Matakuliah> getAllMatakuliah() {
        return matakuliahService.getAll();
    }

    @GetMapping("/{matakuliahId}")
    public Matakuliah getMatakuliahById(@PathVariable("matakuliahId") Long matakuliahId) {
        return matakuliahService.getMatakuliahById(matakuliahId);
    }

    @PostMapping
    public void insertMatakuliah(@RequestBody Matakuliah matakuliah) {
        matakuliahService.insert(matakuliah);
    }

    @DeleteMapping("/{matakuliahId}")
    public void deleteMatakuliah(@PathVariable("matakuliahId") Long matakuliahId) {
        matakuliahService.delete(matakuliahId);
    }

    @PostMapping(path = "/{matakuliahId}")
    public void update(@PathVariable("matakuliaId") Long MatakuliahId,
            @RequestParam(required = false) String kode,
            @RequestParam(required = false) String nama){
        matakuliahService.update(MatakuliahId, kode, nama); 
    }
    @Transactional
    @PostMapping(path = "/{matakuliahId}", consumes = "application/json")
    public ResponseEntity<String> updateMatakuliahWithRequestBody(
            @PathVariable("matakuliahId") Long matakuliahId,
            @RequestBody MatakuliahRequest matakuliahRequest) {
        System.out.println("Received update request: " + matakuliahRequest.toString());

        try {
            // Lakukan pembaruan data di sini
            matakuliahService.update(matakuliahId, matakuliahRequest.getKode(), matakuliahRequest.getNama());
            return ResponseEntity.ok("Update successful");
        } catch (Exception e) {
            // Tangani kesalahan pembaruan
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Update failed");
        }
    }
}