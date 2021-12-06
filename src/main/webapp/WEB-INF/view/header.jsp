<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>FX Waluta</title>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet"
      integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
<style>
    body {
        background: #0e0e0f !important;
    }
    .login-body {
        overflow: hidden;
        font-size: 1.5em;
        margin: 0px;
    }
    .form-div {
        background-color: #0e0e0f;;
        color: #f2c341;
        display: block;
        text-align: center;
        font: inherit;
    }

    .btn, .btn-dark{
        color: #f2c341 !important;
        font-size: 1rem !important;
    }

    .btn-login {
        display: inline-block;
        font-weight: 400;
        line-height: 1.5;
        color: #f2c341;
        text-align: center;
        text-decoration: none;
        vertical-align: middle;
        cursor: pointer;
        -webkit-user-select: none;
        -moz-user-select: none;
        user-select: none;
        background-color: transparent;
        border: 1px solid transparent;
        border-top-color: transparent;
        border-right-color: transparent;
        border-bottom-color: transparent;
        border-left-color: transparent;
        padding: .375rem .75rem;
        font-size: 1rem;
        border-radius: .25rem;
        transition: color .15s ease-in-out, background-color .15s ease-in-out, border-color .15s ease-in-out, box-shadow .15s ease-in-out;
    }

    .btn-dark-login {
        background-color: #212529;
        border-color: #212529;
        color: #f2c341;
    }

    .font-login {
        font-family: "Arial Black", Gadget, sans-serif;
        font-size: 1rem;
        margin: 10px;
    }
    .hide{
        display: none;
    }
    .form-error{
        color: #ff0303;
        font-family: Arial;
        font-size: 1.2rem ;
    }
</style>
<div class=header-body>
    <div class="header">
        <div class="darkTable">
            <div class="col-md divTableHead h4">
                <a style="text-decoration: none" href="/start">FX_WALUTA_5000</a>
            </div>
        </div>
<%--        <div class="row divTableRow">--%>
<%--            <div class="col-md divTableHead h4">--%>
<%--                <h3>FX_WALUTA_5000</h3>--%>
<%--            </div>--%>
<%--        </div>--%>
        <div>
            <label for="curr">Choose a currency</label>
            <form>
                <select name="curr" id="curr">
                    <c:forEach var="currency" items="${currencies}">
                        <option value="${currency.getCode()}">${currency.getCurrency()}</option>
                    </c:forEach>
                </select>
                <input type="submit" value="Get Rate!" formaction="/rates">
            </form>
        </div>
    </div>
</div>
</html>
