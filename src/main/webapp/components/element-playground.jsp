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
                <svg width="13px" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 50 50">
                    <path d="M49.306 26.548l-11.24-3.613-3.613-11.241C34.319 11.28 33.935 11 33.5 11s-.819.28-.952.694l-3.613 11.241-11.24 3.613C17.28 26.681 17 27.065 17 27.5s.28.819.694.952l11.24 3.613 3.613 11.241C32.681 43.72 33.065 44 33.5 44s.819-.28.952-.694l3.613-11.241 11.24-3.613C49.72 28.319 50 27.935 50 27.5S49.72 26.681 49.306 26.548zM1.684 13.949l7.776 2.592 2.592 7.776C12.188 24.725 12.569 25 13 25s.813-.275.948-.684l2.592-7.776 7.776-2.592C24.725 13.813 25 13.431 25 13s-.275-.813-.684-.949L16.54 9.459l-2.592-7.776C13.813 1.275 13.431 1 13 1s-.813.275-.948.684L9.46 9.459l-7.776 2.592C1.275 12.188 1 12.569 1 13S1.275 13.813 1.684 13.949zM17.316 39.05l-5.526-1.842-1.842-5.524C9.813 31.276 9.431 31 9 31s-.813.275-.948.684L6.21 37.208.685 39.05c-.408.136-.684.518-.684.949s.275.813.684.949l5.526 1.842 1.841 5.524C8.188 48.721 8.569 48.997 9 48.997s.813-.275.948-.684l1.842-5.524 5.526-1.842C17.725 40.811 18 40.429 18 39.999S17.725 39.186 17.316 39.05z"></path>
                </svg>
                Discoveries
            </div>
            <div class="sidebar-sort sidebar-sorting-item">
                <svg width="13px" viewBox="0 0 43 47" xmlns="http://www.w3.org/2000/svg" xml:space="preserve"
                     style="fill-rule:evenodd;clip-rule:evenodd;stroke-linejoin:round;stroke-miterlimit:2;">
    <g transform="matrix(1,0,0,1,-3.725,-1.725)">
        <path d="M21,2L21,5L23,5L23,6.098C12.35,7.107 4,16.089 4,27C4,38.586 13.414,48 25,48C36.586,48 46,38.586 46,27C46,16.089 37.65,7.107 27,6.098L27,5L29,5L29,2L21,2ZM40.236,5.146L38.23,7.152L42.846,11.768L44.852,9.762L40.236,5.146ZM25,8C35.505,8 44,16.495 44,27C44,37.505 35.505,46 25,46C14.495,46 6,37.505 6,27C6,16.495 14.495,8 25,8ZM14.99,15.99C14.442,15.99 13.99,16.442 13.99,16.99C13.99,17.26 14.1,17.519 14.293,17.707L23.07,26.484C23.025,26.652 23.001,26.826 23,27C23,28.097 23.903,29 25,29C25.175,29 25.349,28.977 25.518,28.932L27.293,30.707C27.481,30.903 27.742,31.014 28.014,31.014C28.563,31.014 29.014,30.563 29.014,30.014C29.014,29.742 28.903,29.481 28.707,29.293L26.93,27.516C26.975,27.348 26.999,27.174 27,27C27,25.903 26.097,25 25,25C24.825,25 24.651,25.023 24.482,25.068L15.707,16.293C15.519,16.1 15.26,15.99 14.99,15.99Z"
              style="fill-rule:nonzero;stroke:black;stroke-width:0.55px;"></path>
    </g>
</svg>
                Sort by time
            </div>
        </div>
        <div class="sidebar-search">
            <input class="sidebar-input"/>
            <img src="<%= resourcesURL + "/images/close.svg" %>" class="sidebar-input-close" style="display: none"
                 alt="close icon"/>
        </div>
    </div>
</div>
<div class="instances">
    <div id="instance-0" class="item instance instance-hide">
        <span class="instance-emoji">💧</span>
        Water
    </div>
</div>

<script src="resources/javascript/elementDragging.js"></script>