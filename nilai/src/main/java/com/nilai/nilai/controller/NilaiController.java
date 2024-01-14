package com.nilai.nilai.controller;

import com.nilai.nilai.entity.Nilai;
import com.nilai.nilai.service.NilaiService;
import com.nilai.nilai.vo.ResponseTemplateVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import org.springframework.transaction.annotation.Transactional;

@RestController
@RequestMapping("api/v1/nilai")
public class NilaiController {

    @Autowired
    private NilaiService nilaiService;

    @GetMapping
    public List<Nilai> getAll() {
        return nilaiService.getAllNilai();
    }

    @GetMapping(path = "{id}")
    public ResponseTemplateVo getNilai(@PathVariable("id") Long idnilai) {
        return nilaiService.getNilai(idnilai);
    }

    @PostMapping
    public void insert(@RequestBody Nilai nilai) {
        nilaiService.insert(nilai);
    }

    @PutMapping(path = "{id}")
    public void update(@PathVariable("id") Long idnilai,
                       @RequestParam(required = false) Double nilai) {
        nilaiService.update(idnilai, nilai);
    }

    @DeleteMapping(path = "{id}")
    public void deleteNilai(@PathVariable("id") Long idnilai) {
        nilaiService.delete(idnilai);
    }

    @Transactional
    @PostMapping(path = "{id}", consumes = "application/json")
    public ResponseEntity<String> updateNilaiWithRequestBody(
            @PathVariable("id") Long idnilai,
            @RequestBody Nilai nilai) {
        System.out.println("Received update request: " + nilai.toString());

        try {
            // Perform data update here
            nilaiService.update(idnilai, nilai.getNilai());
            return ResponseEntity.ok("Update successful");
        } catch (Exception e) {
            // Handle update errors
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Update failed");
        }
    }
}
