<%@include file="header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html>
<link rel="stylesheet" type="text/css" href="/resources/css/style.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet"
      integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const addprice = document.querySelector("#addprice")
        const addamount = document.querySelector("#addamount")
        let addvalue = document.querySelector("#addvalue");
        addprice.addEventListener('input', () => {
            if (addprice.value.length !== 0) {
                addamount.addEventListener('input', () => {
                    if (addamount.value.length !== 0) {
                        addvalue.innerText = (addprice.value * addamount.value).toLocaleString('en');
                    } else {
                        addvalue.innerText = "";
                    }
                })
            }
        })
        addamount.addEventListener('input', () => {
            if (addamount.value.length !== 0) {
                addprice.addEventListener('input', () => {
                    if (addprice.value.length !== 0) {
                        addvalue.innerText = (addprice.value * addamount.value).toLocaleString('en');
                    } else {
                        addvalue.innerText = "";
                    }
                })
            }
        })

        const editable = document.querySelectorAll(".editable");
        editable.forEach(el => {
            const row = el.parentElement;
            const buysell = row.querySelector(".pair-style");
            const txvalue = row.querySelector("#tx_value");
            const txval = row.querySelector("#tx_val");
            const txprice = row.querySelector("#tx_price").value;
            const txamount = row.querySelector("#tx_amt").value;
            txval.value = (txprice * txamount);
            txvalue.innerText = (txprice * txamount).toLocaleString('en');

            if (buysell.innerText === "BUY") {
                row.classList.add("buy-button")
            } else {
                row.classList.add("sell-button")
            }
        })
    })
</script>
<body>
<div class="darkTable">
    <div class="row divTableRow">
        <div class="col-md divTableHead h4">
            <h3>Currency</h3>
        </div>
        <div class="col-md divTableHead h4 ">
            <h3>Code</h3>
        </div>
        <div class="col-md divTableHead h4 ">
            <h3>Current Rate</h3>
        </div>
    </div>

    <div class="row divTableRow btn-dark">
        <div class="col-md divTableCell">
            <div class="pair-style">${rate.getCurrency()}</div>
        </div>
        <div class="col-md divTableCell">
            <div>${rate.getCode()}</div>
        </div>
        <div class="col-md divTableCell">
            <div>${rate.getMid()}</div>
        </div>
    </div>
    <div class="row divTableRow" style="padding-bottom: 20px"></div>
    <div class="darkTable">
        <div class="row divTableRow">
            <div class="col-md divTableHead h4">
                <h3>7 Day Rate History</h3>
            </div>
        </div>

        <div class="row divTableRow btn-dark">
            <div class="col-md divTableHead">${rate.getD1_date()}</div>
            <div class="col-md divTableHead">${rate.getD2_date()}</div>
            <div class="col-md divTableHead">${rate.getD3_date()}</div>
            <div class="col-md divTableHead">${rate.getD4_date()}</div>
            <div class="col-md divTableHead">${rate.getD5_date()}</div>
            <div class="col-md divTableHead">${rate.getD6_date()}</div>
            <div class="col-md divTableHead">${rate.getD7_date()}</div>
        </div>
        <div class="row divTableRow btn-dark">
            <div class="col-md divTableHead">${rate.getD1()}</div>
            <div class="col-md divTableHead">${rate.getD2()}</div>
            <div class="col-md divTableHead">${rate.getD3()}</div>
            <div class="col-md divTableHead">${rate.getD4()}</div>
            <div class="col-md divTableHead">${rate.getD5()}</div>
            <div class="col-md divTableHead">${rate.getD6()}</div>
            <div class="col-md divTableHead">${rate.getD7()}</div>
        </div>

    <div class="row divTableRow" style="padding-bottom: 20px"></div>
    <div class="darkTable">
        <div class="row divTableRow">
            <div class="col-md divTableHead h4">
                <h3>Transaction History</h3>
            </div>
        </div>
        <form method="post" action="/transactions/${rate.getId()}">
            <div class="row divTableRow btn-dark">
                <div class="col-md divTableHead">SHOW TRANSACTIONS :</div>
                <div class="col-md divTableHead input">
                    <input type="date" name="date1" size="10" autocomplete="off" class="btn-dark" id="date1"/>
                </div>
                <div class="col-md divTableHead input">
                    <input type="date" name="date2" size="8" autocomplete="off" class="btn-dark empty" id="date2"/>
                </div>
                <div class="col-md divTableHead"></div>
                <div class="col-md divTableHead">
                    <input type="submit" name="button" value="Retrieve History"
                           class="btn btn-dark buy-btn buy-button:hover">
                </div>
            </div>
        </form>


        <c:choose>
        <c:when test="${empty transactions}">
        <div class="row divTableRow">
            <div class="col-md divTableHead h4">
                <h3>No transactions found. Select date range above.</h3>
            </div>
            </c:when>
            <c:otherwise>
            <div class="darkTable">
                <div class="row divTableRow">
                    <div class="col-md divTableHead h4">
                        <h3>Type</h3>
                    </div>
                    <div class="col-md divTableHead h4">
                        <h3>Price</h3>
                    </div>
                    <div class="col-md divTableHead h4">
                        <h3>QTY</h3>
                    </div>
                    <div class="col-md divTableHead h4">
                        <h3>Total</h3>
                    </div>
                    <div class="col-md divTableHead h4 ">
                        <h3>Date</h3>
                    </div>
                </div>
                <c:forEach var="transaction" items="${transactions}">
                <div class="row divTableRow btn-dark" id="tx_row">
                    <div class="hide" id="tx_id">${transaction.getId()}</div>
                    <div>
                        <input type="hidden" value="${transaction.getTransaction()}">
                    </div>
                    <div class="col-md divTableCell idClass">
                        <div class="pair-style" id="tx_type">${transaction.getTransaction()}</div>
                    </div>
                        <%--BUYPRICE--%>
                    <div class="col-md divTableCell editable">
                        <div>
                            <fmt:formatNumber type="number" maxFractionDigits="10" value="${transaction.getPrice()}"/>
                        </div>
                        <input type="hidden" size="8" value="${transaction.getPrice()}" id="tx_price"/>
                        <input type="hidden" value="${transaction.getId()}"/>
                        <input type="hidden" value="${transaction.getTransaction()}"/>
                    </div>
                        <%--AMOUNT--%>
                    <div class="col-md divTableCell editable">
                        <div id="tx_amount">
                            <fmt:formatNumber type="number" maxFractionDigits="10" value="${transaction.getAmount()}"/>
                        </div>
                        <input type="hidden" size="8" value="${transaction.getAmount()}" id="tx_amt"/>
                    </div>
                    <div class="col-md divTableCell" id="value_div">
                        <div id="tx_value"></div>
                        <input type="hidden" id="tx_val">
                    </div>
                        <%--DATE--%>
                    <div class="col-md divTableCell">
                        <div>
                                ${transaction.getDate()}
                        </div>
                    </div>
                </div>
                </c:forEach>
                </c:otherwise>
                </c:choose>

                <div class="row divTableRow" style="padding-bottom: 100px"></div>


                <form method="post" action="/transactions/add/${rate.getId()}">
                    <div class="row divTableRow btn-dark" id="new_tx">
                        <div class="col-md divTableHead">ADD TRANSACTION :</div>
                        <div class="col-md divTableHead input">
                            <input type="numeric" name="buyPrice" size="10"
                                   Placeholder=${rate.getMid()} autocomplete="off" class="btn-dark" id="addprice"/>
                        </div>
                        <div class="col-md divTableHead input">
                            <input inputmode="numeric" name="amount" Placeholder="Amount" size="8" autocomplete="off"
                                   class="btn-dark empty" id="addamount"/>
                        </div>
                        <div class="col-md divTableHead" id="addvalue"></div>
                        <div class="col-md divTableHead">
                            <input type="submit" name="button" value="BUY"
                                   class="btn btn-dark buy-btn buy-button:hover">
                            <input type="submit" name="button" value="SELL"
                                   class="btn btn-dark sell-btn sell-button:hover">
                        </div>
                    </div>
                </form>

</body>
</html>