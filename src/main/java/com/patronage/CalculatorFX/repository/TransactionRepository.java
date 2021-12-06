package com.patronage.CalculatorFX.repository;

import com.patronage.CalculatorFX.model.Transaction;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface TransactionRepository extends JpaRepository<Transaction,Long> {

    @Query("SELECT t FROM Transaction t WHERE t.rate.id = ?1 AND t.date between ?2 AND ?3")
    List<Transaction> getTransactionsByRateIdAndDate(Long currencyId, LocalDate date1, LocalDate date2);

}
