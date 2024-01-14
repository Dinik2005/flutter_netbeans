package com.matakuliah.matakuliah.service;

import com.matakuliah.matakuliah.entity.Matakuliah;
import com.matakuliah.matakuliah.repository.MatakuliahRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

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
        return matakuliahRepository.findById(id).get();
        }

    public void insert(Matakuliah matakuliah) {
         Optional<Matakuliah> matakuliahOptional = 
                matakuliahRepository.findMatakuliahByNama(matakuliah.getNama());
        if(matakuliahOptional.isPresent()){
            throw new IllegalStateException("Nama sudah ada");
        }
        matakuliahRepository.save(matakuliah);
    }

    public void delete(Long matakuliahId) {
        boolean ada = matakuliahRepository.existsById(matakuliahId);
        if (!ada) {
            throw new IllegalStateException("Matakuliah ini tidak ada");
        }
        matakuliahRepository.deleteById(matakuliahId);
    }

    @Transactional
    public void update(Long matakuliahId, String kode, String nama, String sks) {
        Matakuliah matakuliah = matakuliahRepository.findById(matakuliahId)
                .orElseThrow(() -> new IllegalStateException("Matakuliah tidak ada"));
        if (kode != null && kode.length() > 0 && !Objects.equals(matakuliah.getKode(), kode)) {
            matakuliah.setKode(kode);
        }

        if (nama != null && nama.length() > 0 && !Objects.equals(matakuliah.getNama(), nama)) {
             Optional<Matakuliah> matakuliahOptional = matakuliahRepository.findMatakuliahByNama(nama);
       
            if (matakuliahOptional.isPresent()) {
                throw new IllegalStateException("Matakuliah sudah ada");
            }
            matakuliah.setNama(nama);     
        }
        matakuliahRepository.save(matakuliah);  
    }
        @jakarta.transaction.Transactional
    public void update(Long matakuliahId, String kode, String nama) {
        Optional<Matakuliah> matakuliahOptional = matakuliahRepository.findById(matakuliahId);

        matakuliahOptional.ifPresent(matakuliah -> {
            if (kode != null && kode.length() > 0) {
                matakuliah.setKode(kode);
            }

            if (nama != null && nama.length() > 0) {
                matakuliah.setNama(nama);
            }

            // Simpan Mahasiswa setelah pembaruan propertinya
            matakuliahRepository.save(matakuliah);
        });
    }

}
