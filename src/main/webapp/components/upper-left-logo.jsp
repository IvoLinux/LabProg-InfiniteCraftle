<style>
    .home-link{
        position: absolute;
        top: 0;
        left: 0;
        margin: 13px 13px;
    }
    .site-title{
        position: absolute;
        width: 110px;
    }
</style>
<%
    String rootURL = request.getContextPath();
    String imageURL = rootURL + "/resources/logo_002.svg";
%>
<a data-v-32e5f4a8="" href="http://localhost:3000/Infinite_war_exploded/" class="home-link">
    <img data-v-32e5f4a8="" src="<%= imageURL %>" class="site-title" alt="NEAL.FUN logo"/>
</a>