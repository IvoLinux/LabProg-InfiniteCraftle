<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<style>
    .instance {
        position: fixed;
        font-size: 18px;
        z-index: 11;
        left: 0;
        top: 0;
        padding: 11px 10px 10px;
        transition: scale 0.15s ease-in;
        border-radius: 5px;
        transform-origin: center center;
        display: flex;
        align-items: center;
        contain: layout;
        border: 1px solid var(--instance-border);
        background: var(--instance-bg);
    }

    .instance-emoji {
        font-size: 21px;
        margin-right: 5px;
    }

    .instance-hide {
        display: none !important;
        pointer-events: none !important;
    }

    @media screen and (min-width: 1150px) {
        .instance {
            font-size: 20px;
            padding: 11px 11px 10px;
        }
    }

    @media screen and (max-width: 800px) {
        .instance {
            min-height: 34px;
            line-height: 34px;
            font-size: 16px;
        }
    }
</style>

<div class="instances">
    <div>
        <div id="instance-0" class="item instance instance-hide">
            <span class="instance-emoji">💧</span>
            Water
        </div>
        <div id="instance-1" class="item instance" style="translate: 292px 249px; z-index: 22;">
            <span class="instance-emoji">🥐💦</span>
            French Cum
        </div>
    </div>
</div>