<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.prudnikova.onlinebanking.model.Stat"%>
<%@page import="com.prudnikova.onlinebanking.model.Stat"%>
<%@page import="java.util.List"%>
<%@page import="com.prudnikova.onlinebanking.service.StatService"%>
<%@page import="com.prudnikova.onlinebanking.model.User"%>
<%@page import="com.prudnikova.SessionBean"%>
<%@page import="com.prudnikova.SpringFactory"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link rel="stylesheet" href="resources/css/bootstrap.min.css">
        <script src="resources/js/bootstrap.min.js"></script>
        <link href="resources/css/bank.css" rel="stylesheet">

        <title>Statistic menu page</title>
    </head>
    <body>
        <div class="container">
            <h3>Банковская система онлайн.Меню статистики</h3>
            <br>
            <h4>
                <span class="glyphicon glyphicon-user"></span>
                <%
                    SessionBean sessionBean = (SessionBean) SpringFactory.getspringApplicationContext().getBean("sessionBean");
                    User user = sessionBean.getCurrentUser();
                    String login = "";
                    if (user != null) {
                        login = user.getName();

                        String admin = user.getAdmin();
                        login += " (" + admin + ")";
                    }

                %>
                <%=login%>

            </h4>
            <br>

            <table class="table table-striped">
                <tr>
                    <th>Дата</th>
                    <th>Описание</th>
                </tr>

                <%
                    StatService statService = (StatService) SpringFactory.getspringApplicationContext().getBean("statService");
                    List<Stat> statsList = new ArrayList<>();
                    statsList = statService.getAllStats();
                    List<Stat> finalStatsList = new ArrayList<>();

                    for (int i = 0; i < statsList.size(); i++) {
                        Stat stat = statsList.get(i);
                        if (stat != null) {
                            int userId = stat.getUserId();
                            if (userId == user.getId()) {
                                finalStatsList.add(stat);
                            }
                        }
                    }

                    for (int i = 0; i < finalStatsList.size(); i++) {
                        Stat stat = finalStatsList.get(i);
                        if (stat != null) {
                            out.write("<tr>");
                            Date statDate = stat.getDate();
                            if (statDate != null) {
                                SimpleDateFormat sdf = new SimpleDateFormat("dd-M-yyyy");
                                String date = sdf.format(statDate);
                                out.write("<td>" + date + "</td>");
                            }

                            String statDescription = stat.getDescription();
                            out.write("<td>" + statDescription + "</td>");

                            out.write("</tr>");
                        }

                        out.write("");
                    }
                %>

            </table>
            <br>

            <form action="main-menu.jsp">
                <button class="btn btn-info">
                    <span class="glyphicon glyphicon-home"></span> Вернуться в главное меню
                </button>
            </form>

        </div>
    </body>
</html>
