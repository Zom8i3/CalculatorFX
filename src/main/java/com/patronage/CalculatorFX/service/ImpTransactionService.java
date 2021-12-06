package com.patronage.CalculatorFX.service;

import com.patronage.CalculatorFX.model.Transaction;
import com.patronage.CalculatorFX.repository.TransactionRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public class ImpTransactionService implements TransactionService{

   private final TransactionRepository transactionRepository;

    public ImpTransactionService(TransactionRepository transactionRepository) {
        this.transactionRepository = transactionRepository;
    }

    @Override
    public void add(Transaction transaction) {
        transactionRepository.save(transaction);
    }

    @Override
    public List<Transaction> getAllTransactionsByDate(Long currencyId, LocalDate date1, LocalDate date2) {
        List<Transaction> transactionsByRateIdAndDate = transactionRepository.getTransactionsByRateIdAndDate(currencyId,date1,date2);
        return transactionsByRateIdAndDate;
    }


}
