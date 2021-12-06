
package com.patronage.CalculatorFX.model;

import lombok.Getter;
import lombok.Setter;
import java.util.List;


@Getter
@Setter
public class NBPPojo {
    private String currency;
    private String code;
    private List<Rate> rates = null;

}
