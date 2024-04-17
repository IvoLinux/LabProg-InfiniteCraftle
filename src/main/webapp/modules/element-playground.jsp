<%String resourcesURL = request.getContextPath() + "/resources";%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<link rel="stylesheet" href="<%= resourcesURL + "/css/sidebar.css"%>">

<div class="sidebar">
    <div class="sidebar-inner">
        <div class="items">
            <div class="items-inner"></div>
        </div>
    </div>
    <div class="sidebar-controls sidebar-controls-fade-show">
        <div class="sidebar-sorting">
            <div class="sidebar-discoveries sidebar-sorting-item">
                <img src="<%= resourcesURL + "/images/magic.svg" %>" class="sidebar-sorting-icon"
                     alt="first discoveries icon" height="13px"/>
                Discoveries
            </div>
            <div class="sidebar-sort sidebar-sorting-item">
                <img src="<%= resourcesURL + "/images/time.svg" %>" class="sidebar-sorting-icon"
                     alt="sort by time icon" height="13px"/>
                Sort by time
            </div>
        </div>
        <div class="sidebar-search">
            <input placeholder="Search (n) items..." class="sidebar-input"/>
            <img src="<%= resourcesURL + "/images/close.svg" %>" class="sidebar-input-close" style="display: none"
                 alt="close icon" height="13px"/>
        </div>
    </div>
</div>
<div class="instances">
    <div>
        <div id="instance-0" class="item instance instance-hide">
            <span class="instance-emoji">💧</span>
            Water
        </div>
    </div>
</div>

<script src="<%= resourcesURL + "/javascript/elementDragging.js" %>" defer="defer"></script>