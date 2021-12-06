package com.patronage.CalculatorFX.service;

import com.patronage.CalculatorFX.model.Rate;
import com.patronage.CalculatorFX.repository.RateRepository;
import org.springframework.stereotype.Repository;

@Repository

public class ImpRateService implements RateService{

    private final RateRepository rateRepository;

    public ImpRateService(RateRepository rateRepository) {
        this.rateRepository = rateRepository;
    }


    @Override
    public void add(Rate rate) {
        if(rateRepository.findByCode(rate.getCode())!=null){  //means this currency is in DB, and we need to override all fields to update
          Rate updatedRate = new Rate();
          Rate oldRate = rateRepository.findByCode(rate.getCode());
          updatedRate.setId(oldRate.getId());
          updatedRate.setCode(oldRate.getCode());
          updatedRate.setCurrency(oldRate.getCurrency());
          updatedRate.setMid(rate.getMid());
          updatedRate.setD1_date(rate.getD1_date());
          updatedRate.setD2_date(rate.getD2_date());
          updatedRate.setD3_date(rate.getD3_date());
          updatedRate.setD4_date(rate.getD4_date());
          updatedRate.setD5_date(rate.getD5_date());
          updatedRate.setD6_date(rate.getD6_date());
          updatedRate.setD7_date(rate.getD7_date());
          updatedRate.setD1(rate.getD1());
          updatedRate.setD2(rate.getD2());
          updatedRate.setD3(rate.getD3());
          updatedRate.setD4(rate.getD4());
          updatedRate.setD5(rate.getD5());
          updatedRate.setD6(rate.getD6());
          updatedRate.setD7(rate.getD7());
          rateRepository.save(updatedRate);
        }else{  //not yet in DB, so add
            rateRepository.save(rate);
        }
    }

}
