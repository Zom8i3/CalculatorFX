package com.patronage.CalculatorFX.controllers;


import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.patronage.CalculatorFX.model.Currency;
import com.patronage.CalculatorFX.model.NBPPojo;
import com.patronage.CalculatorFX.model.Rate;
import com.patronage.CalculatorFX.model.Transaction;
import com.patronage.CalculatorFX.repository.RateRepository;
import com.patronage.CalculatorFX.service.ImpTransactionService;
import com.patronage.CalculatorFX.service.RateService;
import com.patronage.CalculatorFX.service.TransactionService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Controller
public class RateController {

    private final RateService rateService;
    private final RateRepository rateRepository;
    private final TransactionService transactionService;
    private final ImpTransactionService impTransactionService;

    public RateController(RateService rateService, RateRepository rateRepository, TransactionService transactionService, ImpTransactionService impTransactionService) {
        this.rateService = rateService;
        this.rateRepository = rateRepository;
        this.transactionService = transactionService;
        this.impTransactionService = impTransactionService;
    }

    @GetMapping("/start")
    public String rates(Model model) {
        model.addAttribute("currencies", getCurrencyList());
        return "start";
    }

    @GetMapping("/rates")
    public String getCurrency(@RequestParam("curr") String curr, Model model) {
        Rate rate = getHistoricalInfo(curr);
        rateService.add(rate);
        Long id = rateRepository.findByCode(rate.getCode()).getId();
        rate.setId(id);
        model.addAttribute("rate", rate);
        model.addAttribute("currencies", getCurrencyList());
        return "details";
    }

    @PostMapping("/transactions/add/{currencyId}")
    public String addTransaction(@PathVariable Long currencyId, @RequestParam String button, @RequestParam String amount, @RequestParam String buyPrice, Model model){
        Rate rate = getRate(currencyId, model);
        Transaction transaction = new Transaction();
        transaction.setRate(rate);
        transaction.setAmount(Double.parseDouble(amount));
        double price = Double.parseDouble(buyPrice);
        if(button.equals("SELL")){
            price*=-1;
            transaction.setTransaction("SELL");
        }else{
            transaction.setTransaction("BUY");
        }
        transaction.setPrice(price);
        LocalDate date = LocalDate.now();
        transaction.setDate(date);
        transactionService.add(transaction);
        model.addAttribute("currencies", getCurrencyList());
        return "details";
    }


    @PostMapping("/transactions/{currencyId}")
    public String getTransactionsByDate(@PathVariable Long currencyId, @RequestParam String date1, @RequestParam String date2, Model model){
        Rate rate = getRate(currencyId, model);
        model.addAttribute("rate", rate);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate start = LocalDate.parse(date1,formatter);
        LocalDate end = LocalDate.parse(date2,formatter);
        List<Transaction> allTransactionsByDate = impTransactionService.getAllTransactionsByDate(currencyId, start, end);
        model.addAttribute("transactions",allTransactionsByDate);
        model.addAttribute("currencies", getCurrencyList());
        System.out.println("SIZE: " + allTransactionsByDate.size());
        return "details";
    }

    private Rate getRate(Long currencyId, Model model) {
        Optional<Rate> optionalRate = rateRepository.findById(currencyId);
        Rate rate = getHistoricalInfo(optionalRate.get().getCode());
        rate.setId(currencyId);
        model.addAttribute("rate", rate);
        return rate;
    }


    public Rate getHistoricalInfo(String code) {
        LocalDate end = LocalDate.now();
        LocalDate start = end.minusDays(11);
        String url = "http://api.nbp.pl/api/exchangerates/rates/a/" + code + "/" + start.toString() + "/" + end.toString();
        try {
            HttpClient client = HttpClient.newHttpClient();
            HttpRequest request = HttpRequest.newBuilder().uri(new URI(url)).GET().build();
            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
            GsonBuilder builder = new GsonBuilder();
            builder.setPrettyPrinting();
            Gson gson = builder.create();
            NBPPojo nbpPojo = gson.fromJson(response.body(), NBPPojo.class);
            Rate rate = new Rate();
            rate.setCurrency(nbpPojo.getCurrency().toUpperCase());
            rate.setCode(nbpPojo.getCode());
            rate.setMid(nbpPojo.getRates().get(7).getMid());  //current rate
            rate.setD7(nbpPojo.getRates().get(0).getMid());
            rate.setD7_date(nbpPojo.getRates().get(0).getEffectiveDate());
            rate.setD6(nbpPojo.getRates().get(1).getMid());
            rate.setD6_date(nbpPojo.getRates().get(1).getEffectiveDate());
            rate.setD5(nbpPojo.getRates().get(2).getMid());
            rate.setD5_date(nbpPojo.getRates().get(2).getEffectiveDate());
            rate.setD4(nbpPojo.getRates().get(3).getMid());
            rate.setD4_date(nbpPojo.getRates().get(3).getEffectiveDate());
            rate.setD3(nbpPojo.getRates().get(4).getMid());
            rate.setD3_date(nbpPojo.getRates().get(4).getEffectiveDate());
            rate.setD2(nbpPojo.getRates().get(5).getMid());
            rate.setD2_date(nbpPojo.getRates().get(5).getEffectiveDate());
            rate.setD1(nbpPojo.getRates().get(6).getMid());
            rate.setD1_date(nbpPojo.getRates().get(6).getEffectiveDate());
            return rate;
        } catch (URISyntaxException | InterruptedException | IOException e) {
            e.printStackTrace();
        }
        return null;
    }


    public List<Currency> getCurrencyList() {
        String url = "http://api.nbp.pl/api/exchangerates/tables/a";
        try {
            HttpClient client = HttpClient.newHttpClient();
            HttpRequest request = HttpRequest.newBuilder().uri(new URI(url)).GET().build();
            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
            GsonBuilder builder = new GsonBuilder();
            builder.setPrettyPrinting();
            Gson gson = builder.create();
            NBPPojo[] array = gson.fromJson(response.body(), NBPPojo[].class);
            List<Currency> currencyList = new ArrayList<>();
            for (NBPPojo n : array) {
                List<Rate> rates = n.getRates();
                for (Rate r : rates) {
                    Currency currency = new Currency();
                    currency.setCurrency(r.getCurrency());
                    currency.setCode(r.getCode());
                    currencyList.add(currency);
                }
                return currencyList;
            }
        } catch (URISyntaxException | InterruptedException | IOException e) {
            e.printStackTrace();
        }
        return null;
    }


}
