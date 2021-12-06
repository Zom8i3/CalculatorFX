package com.patronage.CalculatorFX.repository;

import com.patronage.CalculatorFX.model.Rate;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RateRepository extends JpaRepository<Rate,Long> {

    Rate findByCode(String code);

}
