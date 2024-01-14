package com.nilai.nilai.service;

import com.nilai.nilai.entity.Nilai;
import com.nilai.nilai.repository.NilaiRepository;
import com.nilai.nilai.vo.Mahasiswa;
import com.nilai.nilai.vo.Matakuliah;
import com.nilai.nilai.vo.ResponseTemplateVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.List;
import java.util.Objects;

@Service
public class NilaiService {

    @Autowired
    private NilaiRepository nilaiRepository;

    @Autowired
    private RestTemplate restTemplate;

    public List<Nilai> getAllNilai() {
        return nilaiRepository.findAll();
    }

    public void insert(Nilai nilai) {
        nilaiRepository.save(nilai);
    }

    public ResponseTemplateVo getNilai(Long idnilai) {
        ResponseTemplateVo vo = new ResponseTemplateVo();
        Nilai nilai = nilaiRepository.findById(idnilai).orElse(null);

        if (nilai != null) {
            Mahasiswa mahasiswa = getMahasiswaById(nilai.getIdmahasiswa());
            Matakuliah matakuliah = getMatakuliahById(nilai.getIdmatakuliah());
            vo.setNilai(nilai);
            vo.setMahasiswa(mahasiswa);
            vo.setMatakuliah(matakuliah);
        }

        return vo;
    }

    public void update(Long idnilai, Double nilai) {
        Nilai existingNilai = nilaiRepository.findById(idnilai)
                .orElseThrow(() -> new IllegalStateException("Nilai tidak ditemukan"));

        if (nilai != null && !Objects.equals(existingNilai.getNilai(), nilai)) {
            existingNilai.setNilai(nilai);
            // Simpan perubahan ke dalam basis data
            nilaiRepository.save(existingNilai);
        }
    }

    public void delete(Long idnilai) {
        boolean exists = nilaiRepository.existsById(idnilai);
        if (!exists) {
            throw new IllegalStateException("Nilai dengan ID ini tidak ada");
        }
        nilaiRepository.deleteById(idnilai);
    }

    private Mahasiswa getMahasiswaById(Long mahasiswaId) {
        return restTemplate.getForObject("http://localhost:9001/api/v1/mahasiswa/" +
                mahasiswaId, Mahasiswa.class);
    }

    private Matakuliah getMatakuliahById(Long matakuliahId) {
        return restTemplate.getForObject("http://localhost:9002/api/v1/matakuliah/" +
                matakuliahId, Matakuliah.class);
    }
}
