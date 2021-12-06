
package com.patronage.CalculatorFX.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;
import org.springframework.stereotype.Component;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Component
@ToString

public class Rate {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @JsonProperty("currency")
    private String currency;
    @JsonProperty("code")
    private String code;
    private Double mid;
    @Transient
    private String effectiveDate;
    private Double d1;
    private String d1_date;
    private Double d2;
    private String d2_date;
    private Double d3;
    private String d3_date;
    private Double d4;
    private String d4_date;
    private Double d5;
    private String d5_date;
    private Double d6;
    private String d6_date;
    private Double d7;
    private String d7_date;


    @OneToMany(fetch = FetchType.EAGER,cascade = CascadeType.REMOVE,orphanRemoval = true)
    List<Transaction> transactions = new ArrayList<>();


}
