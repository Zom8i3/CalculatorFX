package com.patronage.CalculatorFX.service;

import com.patronage.CalculatorFX.model.Transaction;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
public interface TransactionService {

    void add(Transaction transaction);
    List<Transaction> getAllTransactionsByDate(Long currencyId, LocalDate date1, LocalDate date2);

}
