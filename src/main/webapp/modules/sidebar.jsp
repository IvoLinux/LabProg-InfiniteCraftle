<%String resourcesURL = request.getContextPath() + "/resources";%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<link rel="stylesheet" href="<%= resourcesURL + "/css/sidebar.css"%>">

<div class="sidebar">
    <div class="sidebar-inner">
        <div class="items">
            <div class="items-inner">
                <div class="item item-discovered">
                    <span class="item-emoji">💧</span>
                    Water
                </div>
                <div class="item item-discovered">
                    <span class="item-emoji">🔥</span>
                    Fire
                </div>
                <div class="item">
                    <span class="item-emoji">🌬️</span>
                    Wind
                </div>
                <div class="item">
                    <span class="item-emoji">🌍</span>
                    Earth
                </div>
            </div>
        </div>
    </div>
    <div class="sidebar-controls sidebar-controls-fade-show">
        <div class="sidebar-sorting">
            <div class="sidebar-discoveries sidebar-sorting-item">
                <img src="<%= resourcesURL + "/magic.svg" %>" class="sidebar-sorting-icon"
                     alt="first discoveries icon"/>
                Discoveries
            </div>
            <div class="sidebar-sort sidebar-sorting-item">
                <img data-v-32e5f4a8="" src="<%= resourcesURL + "/time.svg" %>" class="sidebar-sorting-icon"
                     alt="sort by time icon"/>
                Sort by time
            </div>
        </div>
        <div class="sidebar-search">
            <input placeholder="Search (n) items..." class="sidebar-input"/>
            <img src="<%= resourcesURL + "/close.svg" %>" class="sidebar-input-close" style="display: none"
                 alt="close icon"/>
        </div>
    </div>
</div>