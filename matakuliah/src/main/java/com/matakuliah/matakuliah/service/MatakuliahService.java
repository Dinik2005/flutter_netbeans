package com.matakuliah.matakuliah.service;

import com.matakuliah.matakuliah.entity.Matakuliah;
import com.matakuliah.matakuliah.repository.MatakuliahRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.Objects;

@Service
public class MatakuliahService {

    private final MatakuliahRepository matakuliahRepository;

    @Autowired
    public MatakuliahService(MatakuliahRepository matakuliahRepository) {
        this.matakuliahRepository = matakuliahRepository;
    }

    public List<Matakuliah> getAll() {
        return matakuliahRepository.findAll();
    }

    public Matakuliah getMatakuliahById(Long id) {
        return matakuliahRepository.findById(id)
                .orElseThrow(() -> new IllegalStateException("Matakuliah not found"));
    }

    public void insert(Matakuliah matakuliah) {
        matakuliahRepository.save(matakuliah);
    }

    public void delete(Long matakuliahId) {
        boolean exists = matakuliahRepository.existsById(matakuliahId);
        if (!exists) {
            throw new IllegalStateException("Matakuliah with id " + matakuliahId + " does not exist");
        }
        matakuliahRepository.deleteById(matakuliahId);
    }

    @Transactional
    public void update(Long matakuliahId, String kode, String nama, int sks) {
        Matakuliah matakuliah = matakuliahRepository.findById(matakuliahId)
                .orElseThrow(() -> new IllegalStateException("Matakuliah not found"));

        if (kode != null && !kode.isEmpty() && !Objects.equals(matakuliah.getKode(), kode)) {
            matakuliah.setKode(kode);
        }

        if (nama != null && !nama.isEmpty() && !Objects.equals(matakuliah.getNama(), nama)) {
            matakuliah.setNama(nama);
        }

        if (sks >= 0 && sks != matakuliah.getSks()) {
            matakuliah.setSks(sks);
        } else {
            throw new IllegalArgumentException("SKS harus bernilai nol atau lebih");
        }

        matakuliahRepository.save(matakuliah);
    }
}
