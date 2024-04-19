<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en" data-n-head="%7B%22lang%22:%7B%22ssr%22:%22en%22%7D%7D">

<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
    <title>Infinite Craftle</title>
    <meta data-n-head="ssr" charset="utf-8"/>
    <meta data-n-head="ssr" name="title" content="Infinite Craftle"/>
    <meta data-n-head="ssr" name="description" content="Infinite Craftle with daily challenges. Recipes may vary"/>
    <meta data-n-head="ssr" property="og:type" content="website"/>
    <meta data-n-head="ssr" property="og:title" content="Infinite Craftle"/>
    <meta data-n-head="ssr" property="og:description" content="Infinite Craftle with daily challenges"/>
    <meta data-n-head="ssr" property="og:image" content="https://neal.fun/share-cards/infinite-craft.png"/>
    <link data-n-head="ssr" rel="canonical" href="https://neal.fun/infinite-craft/"/>
    <link data-n-head="ssr" rel="icon" type="image/png" href="https://neal.fun/favicons/infinite-craft.png"/>
    <style>
        html,
        body {
            font-family: Roboto, sans-serif;
            scroll-behavior: smooth;
        }

        a {
            color: inherit;
            text-decoration: none;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

    </style>
    <style>
        @import url('https://fonts.googleapis.com/css?family=Roboto:400,700');

        @font-face {
            font-family: 'Roboto';
            font-style: normal;
            font-weight: 700;
            src: url(https://fonts.gstatic.com/s/roboto/v30/KFOlCnqEu92Fr1MmWUlfBBc4.woff2) format('woff2');
            unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+0304, U+0308, U+0329, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
        }

        @media screen and (max-width: 800px) {
            .infinite-craft-body {
                position: fixed;
                top: 0;
                left: 0;
                overflow: hidden;
            }
        }

        .container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            font-family: Roboto, sans-serif;
            -webkit-user-select: none;
            -moz-user-select: none;
            user-select: none;
            --text-color: #040404;
            --background-color: #fff;
            --border-color: #c8c8c8;
            --item-bg: #fff;
            --instance-bg: linear-gradient(0deg, #f7feff, #fff 70%);
            --instance-bg-hover: linear-gradient(0deg, #d6fcff, #fff 90%);
            --instance-border: #91a8c1;
            --instance-border-hover: #91a8c1;
            --sidebar-bg: hsla(0, 0%, 100%, 0.93);
            --discoveries-bg-active: #fff9ea;
            background: var(--background-color);
            color: var(--text-color);
        }

        .logo {
            position: fixed;
            top: 10px;
            right: 320px;
            width: 80px;
            -webkit-user-select: none;
            -moz-user-select: none;
            user-select: none;
            pointer-events: none;
        }

        .side-controls {
            position: fixed;
            right: 314px;
            bottom: 7px;
            -webkit-user-select: none;
            -moz-user-select: none;
            user-select: none;
            display: flex;
            grid-gap: 19px;
        }

        .clear {
            width: 21px;
            cursor: pointer;
            opacity: 0.8;
            -webkit-user-select: none;
            -moz-user-select: none;
            user-select: none;
        }

        .particles {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
        }

        .reset {
            position: fixed;
            left: 10px;
            bottom: 10px;
            cursor: pointer;
            opacity: 0.7;
            font-size: 15px;
        }

        .login,
        .logout {
            position: fixed;
            left: 75px;
            bottom: 10px;
            cursor: pointer;
            opacity: 0.7;
            font-size: 15px;
            display: none;
        }

        .calendar-container {
            width: calc(100vw - 305px);
            display: flex;
            justify-content: center;
        }

        @keyframes sway-32e5f4a8 {
            0% {
                rotate: -6deg;
            }
            to {
                rotate: 6deg;
            }
        }

        @media screen and (min-width: 1150px) {
            .calendar-container {
                width: calc(100vw - 350px);
            }

            .logo {
                right: 362px;
                width: 85px;
            }

            .side-controls {
                right: 361px;
            }

            .clear {
                width: 23px;
            }
        }

        @media screen and (max-width: 800px) {
            .calendar-container {
                width: 100vw;
                display: flex;
                justify-content: center;
            }

            .particles {
                z-index: 1;
            }

            .side-controls {
                display: none;
            }

            .logo {
                position: absolute;
                right: 10px;
                left: auto;
                top: 10px;
            }

            .reset {
                bottom: 190px;
            }

            .login,
            .logout {
                bottom: 190px;
            }
        }
    </style>
</head>

<body class="infinite-craft-body vsc-initialized" style="background: white">
<div class="container">
    <%@include file="components/upper-left-logo.jsp" %>

    <%--    <script >--%>
    <%--        !function(e,t){"object"==typeof exports&&"object"==typeof module?module.exports=t():"function"==typeof define&&define.amd?define([],t):"object"==typeof exports?exports.datedreamer=t():e.datedreamer=t()}(this,(()=>(()=>{var e={353:function(e){e.exports=function(){"use strict";var e=6e4,t=36e5,n="millisecond",a="second",r="minute",i="hour",d="day",s="week",o="month",l="quarter",c="year",h="date",u="Invalid Date",p=/^(\d{4})[-/]?(\d{1,2})?[-/]?(\d{0,2})[Tt\s]*(\d{1,2})?:?(\d{1,2})?:?(\d{1,2})?[.:]?(\d+)?$/,m=/\[([^\]]+)]|Y{1,4}|M{1,4}|D{1,2}|d{1,4}|H{1,2}|h{1,2}|a|A|m{1,2}|s{1,2}|Z{1,2}|SSS/g,f={name:"en",weekdays:"Sunday_Monday_Tuesday_Wednesday_Thursday_Friday_Saturday".split("_"),months:"January_February_March_April_May_June_July_August_September_October_November_December".split("_"),ordinal:function(e){var t=["th","st","nd","rd"],n=e%100;return"["+e+(t[(n-20)%10]||t[n]||t[0])+"]"}},v=function(e,t,n){var a=String(e);return!a||a.length>=t?e:""+Array(t+1-a.length).join(n)+e},_={s:v,z:function(e){var t=-e.utcOffset(),n=Math.abs(t),a=Math.floor(n/60),r=n%60;return(t<=0?"+":"-")+v(a,2,"0")+":"+v(r,2,"0")},m:function e(t,n){if(t.date()<n.date())return-e(n,t);var a=12*(n.year()-t.year())+(n.month()-t.month()),r=t.clone().add(a,o),i=n-r<0,d=t.clone().add(a+(i?-1:1),o);return+(-(a+(n-r)/(i?r-d:d-r))||0)},a:function(e){return e<0?Math.ceil(e)||0:Math.floor(e)},p:function(e){return{M:o,y:c,w:s,d,D:h,h:i,m:r,s:a,ms:n,Q:l}[e]||String(e||"").toLowerCase().replace(/s$/,"")},u:function(e){return void 0===e}},g="en",y={};y[g]=f;var D="$isDayjsObject",b=function(e){return e instanceof $||!(!e||!e[D])},M=function e(t,n,a){var r;if(!t)return g;if("string"==typeof t){var i=t.toLowerCase();y[i]&&(r=i),n&&(y[i]=n,r=i);var d=t.split("-");if(!r&&d.length>1)return e(d[0])}else{var s=t.name;y[s]=t,r=s}return!a&&r&&(g=r),r||!a&&g},x=function(e,t){if(b(e))return e.clone();var n="object"==typeof t?t:{};return n.date=e,n.args=arguments,new $(n)},w=_;w.l=M,w.i=b,w.w=function(e,t){return x(e,{locale:t.$L,utc:t.$u,x:t.$x,$offset:t.$offset})};var $=function(){function f(e){this.$L=M(e.locale,null,!0),this.parse(e),this.$x=this.$x||e.x||{},this[D]=!0}var v=f.prototype;return v.parse=function(e){this.$d=function(e){var t=e.date,n=e.utc;if(null===t)return new Date(NaN);if(w.u(t))return new Date;if(t instanceof Date)return new Date(t);if("string"==typeof t&&!/Z$/i.test(t)){var a=t.match(p);if(a){var r=a[2]-1||0,i=(a[7]||"0").substring(0,3);return n?new Date(Date.UTC(a[1],r,a[3]||1,a[4]||0,a[5]||0,a[6]||0,i)):new Date(a[1],r,a[3]||1,a[4]||0,a[5]||0,a[6]||0,i)}}return new Date(t)}(e),this.init()},v.init=function(){var e=this.$d;this.$y=e.getFullYear(),this.$M=e.getMonth(),this.$D=e.getDate(),this.$W=e.getDay(),this.$H=e.getHours(),this.$m=e.getMinutes(),this.$s=e.getSeconds(),this.$ms=e.getMilliseconds()},v.$utils=function(){return w},v.isValid=function(){return!(this.$d.toString()===u)},v.isSame=function(e,t){var n=x(e);return this.startOf(t)<=n&&n<=this.endOf(t)},v.isAfter=function(e,t){return x(e)<this.startOf(t)},v.isBefore=function(e,t){return this.endOf(t)<x(e)},v.$g=function(e,t,n){return w.u(e)?this[t]:this.set(n,e)},v.unix=function(){return Math.floor(this.valueOf()/1e3)},v.valueOf=function(){return this.$d.getTime()},v.startOf=function(e,t){var n=this,l=!!w.u(t)||t,u=w.p(e),p=function(e,t){var a=w.w(n.$u?Date.UTC(n.$y,t,e):new Date(n.$y,t,e),n);return l?a:a.endOf(d)},m=function(e,t){return w.w(n.toDate()[e].apply(n.toDate("s"),(l?[0,0,0,0]:[23,59,59,999]).slice(t)),n)},f=this.$W,v=this.$M,_=this.$D,g="set"+(this.$u?"UTC":"");switch(u){case c:return l?p(1,0):p(31,11);case o:return l?p(1,v):p(0,v+1);case s:var y=this.$locale().weekStart||0,D=(f<y?f+7:f)-y;return p(l?_-D:_+(6-D),v);case d:case h:return m(g+"Hours",0);case i:return m(g+"Minutes",1);case r:return m(g+"Seconds",2);case a:return m(g+"Milliseconds",3);default:return this.clone()}},v.endOf=function(e){return this.startOf(e,!1)},v.$set=function(e,t){var s,l=w.p(e),u="set"+(this.$u?"UTC":""),p=(s={},s[d]=u+"Date",s[h]=u+"Date",s[o]=u+"Month",s[c]=u+"FullYear",s[i]=u+"Hours",s[r]=u+"Minutes",s[a]=u+"Seconds",s[n]=u+"Milliseconds",s)[l],m=l===d?this.$D+(t-this.$W):t;if(l===o||l===c){var f=this.clone().set(h,1);f.$d[p](m),f.init(),this.$d=f.set(h,Math.min(this.$D,f.daysInMonth())).$d}else p&&this.$d[p](m);return this.init(),this},v.set=function(e,t){return this.clone().$set(e,t)},v.get=function(e){return this[w.p(e)]()},v.add=function(n,l){var h,u=this;n=Number(n);var p=w.p(l),m=function(e){var t=x(u);return w.w(t.date(t.date()+Math.round(e*n)),u)};if(p===o)return this.set(o,this.$M+n);if(p===c)return this.set(c,this.$y+n);if(p===d)return m(1);if(p===s)return m(7);var f=(h={},h[r]=e,h[i]=t,h[a]=1e3,h)[p]||1,v=this.$d.getTime()+n*f;return w.w(v,this)},v.subtract=function(e,t){return this.add(-1*e,t)},v.format=function(e){var t=this,n=this.$locale();if(!this.isValid())return n.invalidDate||u;var a=e||"YYYY-MM-DDTHH:mm:ssZ",r=w.z(this),i=this.$H,d=this.$m,s=this.$M,o=n.weekdays,l=n.months,c=n.meridiem,h=function(e,n,r,i){return e&&(e[n]||e(t,a))||r[n].slice(0,i)},p=function(e){return w.s(i%12||12,e,"0")},f=c||function(e,t,n){var a=e<12?"AM":"PM";return n?a.toLowerCase():a};return a.replace(m,(function(e,a){return a||function(e){switch(e){case"YY":return String(t.$y).slice(-2);case"YYYY":return w.s(t.$y,4,"0");case"M":return s+1;case"MM":return w.s(s+1,2,"0");case"MMM":return h(n.monthsShort,s,l,3);case"MMMM":return h(l,s);case"D":return t.$D;case"DD":return w.s(t.$D,2,"0");case"d":return String(t.$W);case"dd":return h(n.weekdaysMin,t.$W,o,2);case"ddd":return h(n.weekdaysShort,t.$W,o,3);case"dddd":return o[t.$W];case"H":return String(i);case"HH":return w.s(i,2,"0");case"h":return p(1);case"hh":return p(2);case"a":return f(i,d,!0);case"A":return f(i,d,!1);case"m":return String(d);case"mm":return w.s(d,2,"0");case"s":return String(t.$s);case"ss":return w.s(t.$s,2,"0");case"SSS":return w.s(t.$ms,3,"0");case"Z":return r}return null}(e)||r.replace(":","")}))},v.utcOffset=function(){return 15*-Math.round(this.$d.getTimezoneOffset()/15)},v.diff=function(n,h,u){var p,m=this,f=w.p(h),v=x(n),_=(v.utcOffset()-this.utcOffset())*e,g=this-v,y=function(){return w.m(m,v)};switch(f){case c:p=y()/12;break;case o:p=y();break;case l:p=y()/3;break;case s:p=(g-_)/6048e5;break;case d:p=(g-_)/864e5;break;case i:p=g/t;break;case r:p=g/e;break;case a:p=g/1e3;break;default:p=g}return u?p:w.a(p)},v.daysInMonth=function(){return this.endOf(o).$D},v.$locale=function(){return y[this.$L]},v.locale=function(e,t){if(!e)return this.$L;var n=this.clone(),a=M(e,t,!0);return a&&(n.$L=a),n},v.clone=function(){return w.w(this.$d,this)},v.toDate=function(){return new Date(this.valueOf())},v.toJSON=function(){return this.isValid()?this.toISOString():null},v.toISOString=function(){return this.$d.toISOString()},v.toString=function(){return this.$d.toUTCString()},f}(),k=$.prototype;return x.prototype=k,[["$ms",n],["$s",a],["$m",r],["$H",i],["$W",d],["$M",o],["$y",c],["$D",h]].forEach((function(e){k[e[1]]=function(t){return this.$g(t,e[0],e[1])}})),x.extend=function(e,t){return e.$i||(e(t,$,x),e.$i=!0),x},x.locale=M,x.isDayjs=b,x.unix=function(e){return x(1e3*e)},x.en=y[g],x.Ls=y,x.p={},x}()},445:function(e){e.exports=function(){"use strict";var e={LTS:"h:mm:ss A",LT:"h:mm A",L:"MM/DD/YYYY",LL:"MMMM D, YYYY",LLL:"MMMM D, YYYY h:mm A",LLLL:"dddd, MMMM D, YYYY h:mm A"},t=/(\[[^[]*\])|([-_:/.,()\s]+)|(A|a|YYYY|YY?|MM?M?M?|Do|DD?|hh?|HH?|mm?|ss?|S{1,3}|z|ZZ?)/g,n=/\d\d/,a=/\d\d?/,r=/\d*[^-_:/,()\s\d]+/,i={},d=function(e){return(e=+e)+(e>68?1900:2e3)},s=function(e){return function(t){this[e]=+t}},o=[/[+-]\d\d:?(\d\d)?|Z/,function(e){(this.zone||(this.zone={})).offset=function(e){if(!e)return 0;if("Z"===e)return 0;var t=e.match(/([+-]|\d\d)/g),n=60*t[1]+(+t[2]||0);return 0===n?0:"+"===t[0]?-n:n}(e)}],l=function(e){var t=i[e];return t&&(t.indexOf?t:t.s.concat(t.f))},c=function(e,t){var n,a=i.meridiem;if(a){for(var r=1;r<=24;r+=1)if(e.indexOf(a(r,0,t))>-1){n=r>12;break}}else n=e===(t?"pm":"PM");return n},h={A:[r,function(e){this.afternoon=c(e,!1)}],a:[r,function(e){this.afternoon=c(e,!0)}],S:[/\d/,function(e){this.milliseconds=100*+e}],SS:[n,function(e){this.milliseconds=10*+e}],SSS:[/\d{3}/,function(e){this.milliseconds=+e}],s:[a,s("seconds")],ss:[a,s("seconds")],m:[a,s("minutes")],mm:[a,s("minutes")],H:[a,s("hours")],h:[a,s("hours")],HH:[a,s("hours")],hh:[a,s("hours")],D:[a,s("day")],DD:[n,s("day")],Do:[r,function(e){var t=i.ordinal,n=e.match(/\d+/);if(this.day=n[0],t)for(var a=1;a<=31;a+=1)t(a).replace(/\[|\]/g,"")===e&&(this.day=a)}],M:[a,s("month")],MM:[n,s("month")],MMM:[r,function(e){var t=l("months"),n=(l("monthsShort")||t.map((function(e){return e.slice(0,3)}))).indexOf(e)+1;if(n<1)throw new Error;this.month=n%12||n}],MMMM:[r,function(e){var t=l("months").indexOf(e)+1;if(t<1)throw new Error;this.month=t%12||t}],Y:[/[+-]?\d+/,s("year")],YY:[n,function(e){this.year=d(e)}],YYYY:[/\d{4}/,s("year")],Z:o,ZZ:o};function u(n){var a,r;a=n,r=i&&i.formats;for(var d=(n=a.replace(/(\[[^\]]+])|(LTS?|l{1,4}|L{1,4})/g,(function(t,n,a){var i=a&&a.toUpperCase();return n||r[a]||e[a]||r[i].replace(/(\[[^\]]+])|(MMMM|MM|DD|dddd)/g,(function(e,t,n){return t||n.slice(1)}))}))).match(t),s=d.length,o=0;o<s;o+=1){var l=d[o],c=h[l],u=c&&c[0],p=c&&c[1];d[o]=p?{regex:u,parser:p}:l.replace(/^\[|\]$/g,"")}return function(e){for(var t={},n=0,a=0;n<s;n+=1){var r=d[n];if("string"==typeof r)a+=r.length;else{var i=r.regex,o=r.parser,l=e.slice(a),c=i.exec(l)[0];o.call(t,c),e=e.replace(c,"")}}return function(e){var t=e.afternoon;if(void 0!==t){var n=e.hours;t?n<12&&(e.hours+=12):12===n&&(e.hours=0),delete e.afternoon}}(t),t}}return function(e,t,n){n.p.customParseFormat=!0,e&&e.parseTwoDigitYear&&(d=e.parseTwoDigitYear);var a=t.prototype,r=a.parse;a.parse=function(e){var t=e.date,a=e.utc,d=e.args;this.$u=a;var s=d[1];if("string"==typeof s){var o=!0===d[2],l=!0===d[3],c=o||l,h=d[2];l&&(h=d[2]),i=this.$locale(),!o&&h&&(i=n.Ls[h]),this.$d=function(e,t,n){try{if(["x","X"].indexOf(t)>-1)return new Date(("X"===t?1e3:1)*e);var a=u(t)(e),r=a.year,i=a.month,d=a.day,s=a.hours,o=a.minutes,l=a.seconds,c=a.milliseconds,h=a.zone,p=new Date,m=d||(r||i?1:p.getDate()),f=r||p.getFullYear(),v=0;r&&!i||(v=i>0?i-1:p.getMonth());var _=s||0,g=o||0,y=l||0,D=c||0;return h?new Date(Date.UTC(f,v,m,_,g,y,D+60*h.offset*1e3)):n?new Date(Date.UTC(f,v,m,_,g,y,D)):new Date(f,v,m,_,g,y,D)}catch(e){return new Date("")}}(t,s,a),this.init(),h&&!0!==h&&(this.$L=this.locale(h).$L),c&&t!=this.format(s)&&(this.$d=new Date("")),i={}}else if(s instanceof Array)for(var p=s.length,m=1;m<=p;m+=1){d[1]=s[m-1];var f=n.apply(this,d);if(f.isValid()){this.$d=f.$d,this.$L=f.$L,this.init();break}m===p&&(this.$d=new Date(""))}else r.call(this,e)}}}()},412:function(e,t,n){"use strict";var a=this&&this.__importDefault||function(e){return e&&e.__esModule?e:{default:e}};Object.defineProperty(t,"__esModule",{value:!0}),t.calendarToggle=void 0;const r=n(35),i=n(770),d=a(n(353)),s=a(n(445));d.default.extend(s.default);class o extends HTMLElement{constructor(e){super(),this.inputPlaceholder="Enter a date",this.options=e,this.element=e.element,this.attachShadow({mode:"open"}),this.init()}init(){null!=this.element?(this.generateTemplate(),document.addEventListener("click",(e=>{var t;this===e.target||this.contains(e.target)||null===(t=this.calendarWrapElement)||void 0===t||t.classList.remove("active")}))):console.error("No element was provided to calendar. Initializing aborted")}generateTemplate(){var e,t;let n;n="string"==typeof this.options.selectedDate||"object"==typeof this.options.selectedDate?(0,d.default)(this.options.selectedDate,this.options.format).format(this.options.format):(0,d.default)().format(this.options.format);const a=(0,i.calendarToggleRoot)(this.options.theme,this.options.styles,this.inputPlaceholder,n);let r;if("string"==typeof this.element?r=document.querySelector(this.element):"object"==typeof this.element&&(r=this.element),r){this.shadowRoot&&(this.shadowRoot.innerHTML=a),r.append(this);const n=null===(e=this.shadowRoot)||void 0===e?void 0:e.querySelector(".datedreamer__calendar-toggle__calendar"),i=null===(t=this.shadowRoot)||void 0===t?void 0:t.querySelector("#date-input");n&&(this.calendarWrapElement=n),i&&(this.inputElement=i,this.inputElement.addEventListener("focus",(()=>{var e;null===(e=this.calendarWrapElement)||void 0===e||e.classList.add("active")}))),this.generateCalendar()}else console.error(`Could not find ${this.element} in DOM.`)}generateCalendar(){const e=new r.calendar(Object.assign(Object.assign({},this.options),{element:this.calendarWrapElement||"",hideInputs:!0,onChange:e=>this.dateChangedHandler(e)}));this.calendarElement=e}dateChangedHandler(e){var t;this.inputElement.value=e.detail,null===(t=this.calendarWrapElement)||void 0===t||t.classList.remove("active"),this.options.onChange&&this.options.onChange(e)}}t.calendarToggle=o,customElements.define("datedreamer-calendar-toggle",o)},35:function(e,t,n){"use strict";var a=this&&this.__importDefault||function(e){return e&&e.__esModule?e:{default:e}};Object.defineProperty(t,"__esModule",{value:!0}),t.calendar=void 0;const r=n(770),i=a(n(353)),d=a(n(445));i.default.extend(d.default);class s extends HTMLElement{constructor(e){super(),this.calendarElement=null,this.headerElement=null,this.inputsElement=null,this.errorsElement=null,this.inputLabel="Set a date",this.inputPlaceholder="Enter a date",this.hideInputs=!1,this.darkMode=!1,this.hideOtherMonthDays=!1,this.errors=[],this.daysElement=null,this.selectedDate=new Date,this.displayedMonthDate=new Date,this.theme="unstyled",this.styles="",this.handleDayKeyDown=e=>{var t,n,a,r,i,d,s,o,l,c,h,u,p,m,f,v,_,g,y,D;if("ArrowLeft"===e.key){e.preventDefault();let a=null;(a=null===(t=e.target.parentElement)||void 0===t?void 0:t.previousSibling)&&(null===(n=a.firstChild)||void 0===n||n.focus())}if("ArrowRight"===e.key){e.preventDefault();let t=null;(t=null===(a=e.target.parentElement)||void 0===a?void 0:a.nextSibling)&&(null===(r=t.firstChild)||void 0===r||r.focus())}if("ArrowUp"===e.key){e.preventDefault();let t=null;(t=null===(h=null===(c=null===(l=null===(o=null===(s=null===(d=null===(i=e.target.parentElement)||void 0===i?void 0:i.previousSibling)||void 0===d?void 0:d.previousSibling)||void 0===s?void 0:s.previousSibling)||void 0===o?void 0:o.previousSibling)||void 0===l?void 0:l.previousSibling)||void 0===c?void 0:c.previousSibling)||void 0===h?void 0:h.previousSibling)?null===(u=t.firstChild)||void 0===u||u.focus():this.goToPrevMonth(e,!0)}if("ArrowDown"===e.key){e.preventDefault();let t=null;(t=null===(y=null===(g=null===(_=null===(v=null===(f=null===(m=null===(p=e.target.parentElement)||void 0===p?void 0:p.nextSibling)||void 0===m?void 0:m.nextSibling)||void 0===f?void 0:f.nextSibling)||void 0===v?void 0:v.nextSibling)||void 0===_?void 0:_.nextSibling)||void 0===g?void 0:g.nextSibling)||void 0===y?void 0:y.nextSibling)?null===(D=t.firstChild)||void 0===D||D.focus():this.goToNextMonth(e,!0)}},this.goToPrevMonth=(e,t=!1)=>{this.displayedMonthDate.setMonth(this.displayedMonthDate.getMonth()-1),t?this.rebuildCalendar(!1,"last"):this.rebuildCalendar(),this.onPrevNav&&this.onPrevNav(new CustomEvent("prevNav",{detail:this.displayedMonthDate}))},this.goToNextMonth=(e,t=!1)=>{this.displayedMonthDate.setMonth(this.displayedMonthDate.getMonth()+1),t?this.rebuildCalendar(!1,"first"):this.rebuildCalendar(),this.onNextNav&&this.onNextNav(new CustomEvent("prevNav",{detail:this.displayedMonthDate}))},this.setSelectedDay=e=>{const t=new Date(this.displayedMonthDate);if(t.setDate(e),this.rangeMode){if(this.connector){if(null!==this.connector.startDate&&null!==this.connector.endDate&&(this.connector.startDate=null,this.connector.endDate=null,this.connector.rebuildAllCalendars()),null==this.connector.startDate?this.connector.startDate=new Date(t):null==this.connector.endDate&&(this.connector.endDate=new Date(t)),null!==this.connector.startDate&&null!==this.connector.endDate){if(this.connector.startDate>this.connector.endDate){console.log("start date is larger than end date");const e=new Date(this.connector.endDate),t=new Date(this.connector.startDate);this.connector.startDate=e,this.connector.endDate=t,console.log(this.connector.startDate,this.connector.endDate)}this.connector.dateChangedCallback&&this.connector.dateChangedCallback(new CustomEvent("dateChanged"))}this.connector.rebuildAllCalendars()}}else this.selectedDate=new Date(t),this.rebuildCalendar(),this.dateChangedCallback(this.selectedDate)},this.element=e.element,e.format&&(this.format=e.format),e.theme&&(this.theme=e.theme),e.styles&&(this.styles=e.styles),e.iconNext&&(this.iconNext=e.iconNext),e.iconPrev&&(this.iconPrev=e.iconPrev),e.inputLabel&&(this.inputLabel=e.inputLabel),e.inputPlaceholder&&(this.inputPlaceholder=e.inputPlaceholder),e.hidePrevNav&&(this.hidePrevNav=e.hidePrevNav),e.hideNextNav&&(this.hideNextNav=e.hideNextNav),e.hideInputs&&(this.hideInputs=e.hideInputs),e.darkMode&&(this.darkMode=e.darkMode),e.rangeMode&&(this.rangeMode=e.rangeMode),e.connector&&(this.connector=e.connector,this.connector.calendars.push(this)),e.hideOtherMonthDays&&(this.hideOtherMonthDays=e.hideOtherMonthDays),"string"==typeof e.selectedDate?this.selectedDate=(0,i.default)(e.selectedDate,e.format).toDate():"object"==typeof e.selectedDate&&(this.selectedDate=e.selectedDate),this.attachShadow({mode:"open"}),this.onChange=e.onChange,this.onRender=e.onRender,this.onNextNav=e.onNextNav,this.onPrevNav=e.onPrevNav,this.displayedMonthDate=new Date(this.selectedDate),this.init()}init(){var e,t,n,a;if(null==this.element)return void console.error("No element was provided to calendar. Initializing aborted");const i=(0,r.calendarRoot)(this.theme,this.styles,this.darkMode);this.insertCalendarIntoSelector(i),this.headerElement=null===(e=this.shadowRoot)||void 0===e?void 0:e.querySelector(".datedreamer__calendar_header"),this.daysElement=null===(t=this.shadowRoot)||void 0===t?void 0:t.querySelector(".datedreamer__calendar_days"),this.inputsElement=null===(n=this.shadowRoot)||void 0===n?void 0:n.querySelector(".datedreamer__calendar_inputs"),this.errorsElement=null===(a=this.shadowRoot)||void 0===a?void 0:a.querySelector(".datedreamer__calendar_errors"),this.generateHeader(),this.generateInputs(),this.generateDays(),this.onRenderCallback()}insertCalendarIntoSelector(e){let t;"string"==typeof this.element?t=document.querySelector(this.element):"object"==typeof this.element&&(t=this.element),t?(this.shadowRoot&&(this.shadowRoot.innerHTML=e),t.append(this)):console.error(`Could not find ${this.element} in DOM.`)}generateHeader(){var e,t,n;if(!this.hidePrevNav){const t=document.createElement("button");t.classList.add("datedreamer__calendar_prev"),t.innerHTML=this.iconPrev?this.iconPrev:r.leftChevron,t.setAttribute("aria-label","Previous"),t.addEventListener("click",this.goToPrevMonth),null===(e=this.headerElement)||void 0===e||e.append(t)}const a=document.createElement("span");if(a.classList.add("datedreamer__calendar_title"),a.innerText=`${r.monthNames[this.displayedMonthDate.getMonth()]} ${this.displayedMonthDate.getFullYear()}`,null===(t=this.headerElement)||void 0===t||t.append(a),!this.hideNextNav){const e=document.createElement("button");e.classList.add("datedreamer__calendar_next"),e.innerHTML=this.iconNext?this.iconNext:r.rightChevron,e.setAttribute("aria-label","Next"),e.addEventListener("click",this.goToNextMonth),null===(n=this.headerElement)||void 0===n||n.append(e)}}generateInputs(){var e;if(this.hideInputs)return;const t=document.createElement("label");t.setAttribute("for","date-input"),t.textContent=this.inputLabel;const n=document.createElement("div");n.classList.add("datedreamer__calendar__inputs-wrap");const a=document.createElement("input");a.id="date-input",a.placeholder=this.inputPlaceholder,a.value=(0,i.default)(this.selectedDate).format(this.format),a.addEventListener("keyup",(e=>this.dateInputChanged(e))),a.setAttribute("title","Set a date");const r=document.createElement("button");r.innerText="Today",r.addEventListener("click",(()=>this.setDateToToday())),n.append(a,r),null===(e=this.inputsElement)||void 0===e||e.append(t,n)}generateErrors(){var e;const t=null===(e=this.inputsElement)||void 0===e?void 0:e.querySelector("input");t&&t.classList.remove("error"),this.errorsElement&&(this.errorsElement.innerHTML=""),this.errors.forEach((({type:e,message:n})=>{var a;const r=document.createElement("span");r.innerText=n,"input-error"==e&&t&&t.classList.add("error"),null===(a=this.errorsElement)||void 0===a||a.append(r)})),this.errors=[]}generateDays(e=!1){var t,n,a,i,d,s,o,l,c,h;const u=this.selectedDate.getDate(),p=this.displayedMonthDate.getMonth(),m=this.displayedMonthDate.getFullYear(),f=new Date(m,p+1,0).getDate(),v=new Date(m,p,1),_=new Date(m,p,f),g=r.weekdays.indexOf(v.toString().split(" ")[0]),y=6-r.weekdays.indexOf(_.toString().split(" ")[0]);for(let r=1;r<=g+f+y;r++)if(r>g&&r<=g+f){const c=document.createElement("div");c.classList.add("datedreamer__calendar_day");const h=document.createElement("button");if(h.addEventListener("click",(()=>this.setSelectedDay(r-g))),h.addEventListener("keydown",this.handleDayKeyDown),h.innerText=(r-g).toString(),h.setAttribute("type","button"),this.rangeMode){this.displayedMonthDate.getMonth()==(null===(n=null===(t=this.connector)||void 0===t?void 0:t.startDate)||void 0===n?void 0:n.getMonth())&&this.displayedMonthDate.getFullYear()==this.connector.startDate.getFullYear()&&r-g==this.connector.startDate.getDate()&&c.classList.add("active"),this.displayedMonthDate.getMonth()==(null===(i=null===(a=this.connector)||void 0===a?void 0:a.endDate)||void 0===i?void 0:i.getMonth())&&this.displayedMonthDate.getFullYear()==this.connector.endDate.getFullYear()&&r-g==this.connector.endDate.getDate()&&c.classList.add("active");const e=new Date(this.displayedMonthDate);e.setDate(r-g),(null===(d=this.connector)||void 0===d?void 0:d.startDate)&&this.connector.endDate&&(null===(s=this.connector)||void 0===s?void 0:s.startDate)<e&&(null===(o=this.connector)||void 0===o?void 0:o.endDate)>e&&c.classList.add("highlight")}else r==g+u&&this.displayedMonthDate.getMonth()==this.selectedDate.getMonth()&&this.displayedMonthDate.getFullYear()==this.selectedDate.getFullYear()&&c.classList.add("active");c.append(h),null===(l=this.daysElement)||void 0===l||l.append(c),e?("first"===e&&r===g+1||"last"===e&&r===g+f)&&h.focus():r==g+u&&this.displayedMonthDate.getMonth()==this.selectedDate.getMonth()&&this.displayedMonthDate.getFullYear()==this.selectedDate.getFullYear()&&h.focus()}else if(r<=g){const e=document.createElement("div");if(e.classList.add("datedreamer__calendar_day","disabled"),!this.hideOtherMonthDays){const t=document.createElement("button");t.innerText=new Date(m,p,0-(g-r)).getDate().toString(),t.setAttribute("disabled","true"),t.setAttribute("type","button"),e.append(t)}null===(c=this.daysElement)||void 0===c||c.append(e)}else if(r>g+f){const e=r-(g+y+f)+y,t=document.createElement("div");if(t.classList.add("datedreamer__calendar_day","disabled"),!this.hideOtherMonthDays){const n=document.createElement("button");n.innerText=new Date(m,p+1,e).getDate().toString(),n.setAttribute("disabled","true"),n.setAttribute("type","button"),t.append(n)}null===(h=this.daysElement)||void 0===h||h.append(t)}}rebuildCalendar(e=!0,t=!1){this.daysElement&&(this.daysElement.innerHTML=""),this.headerElement&&(this.headerElement.innerHTML=""),this.generateErrors(),t?this.generateDays(t):this.generateDays(),this.generateHeader(),e&&(this.inputsElement&&(this.inputsElement.innerHTML=""),this.generateInputs())}setDate(e){"string"==typeof e?this.selectedDate=new Date(e):"object"==typeof e&&(this.selectedDate=e),this.displayedMonthDate=this.selectedDate,this.rebuildCalendar(),this.dateChangedCallback(this.selectedDate)}setDateToToday(){this.selectedDate=new Date,this.displayedMonthDate=new Date,this.rebuildCalendar(),this.dateChangedCallback(this.selectedDate)}dateInputChanged(e){const t=(0,i.default)(e.target.value,this.format).toDate();isNaN(t.getUTCMilliseconds())?(this.errors.push({type:"input-error",message:"The entered date is invalid"}),this.generateErrors()):(this.selectedDate=t,this.displayedMonthDate=new Date(t),this.rebuildCalendar(!1),this.dateChangedCallback(this.selectedDate))}dateChangedCallback(e){if(this.onChange){const t=new CustomEvent("onChange",{detail:(0,i.default)(e).format(this.format)});this.onChange(t)}}onRenderCallback(){if(this.onRender){const e=new CustomEvent("onRender",{detail:{calendar:this.calendarElement}});this.onRender(e)}}setDisplayedMonthDate(e){this.displayedMonthDate=e,this.rebuildCalendar()}}t.calendar=s,customElements.define("datedreamer-calendar",s)},174:(e,t)=>{"use strict";Object.defineProperty(t,"__esModule",{value:!0}),t.default=class{constructor(){this.calendars=new Array,this.startDate=null,this.endDate=null,this.pickingEndDate=null}rebuildAllCalendars(){this.calendars.forEach((e=>{e.rebuildCalendar()}))}}},704:function(e,t,n){"use strict";var a=this&&this.__importDefault||function(e){return e&&e.__esModule?e:{default:e}};Object.defineProperty(t,"__esModule",{value:!0}),t.range=void 0;const r=a(n(353)),i=n(167),d=n(35),s=a(n(174));class o extends HTMLElement{constructor(e){super(),this.calendar1DisplayedDate=new Date,this.calendar2DisplayedDate=new Date,this.handleDateChange=e=>{var t,n;if(this.onChange){const e=new CustomEvent("onChange",{detail:{startDate:(0,r.default)(null===(t=this.connector)||void 0===t?void 0:t.startDate).format(this.format),endDate:(0,r.default)(null===(n=this.connector)||void 0===n?void 0:n.endDate).format(this.format)}});this.onChange(e)}},this.element=e.element,this.connector=new s.default,this.styles=e.styles,this.format=e.format,this.iconPrev=e.iconPrev,this.iconNext=e.iconNext,this.onChange=e.onChange,this.onRender=e.onRender,this.theme=e.theme,this.darkMode=e.darkMode,this.connector&&(this.connector.dateChangedCallback=this.handleDateChange),this.init()}init(){this.addStyles(),this.calendar1DisplayedDate.setDate(1),this.calendar2DisplayedDate.setDate(1),this.calendar2DisplayedDate.setMonth(this.calendar2DisplayedDate.getMonth()+1);const e=document.createElement("div");e.classList.add("datedreamer-range"),this.darkMode&&e.classList.add("dark");const t=document.createElement("div"),n=document.createElement("div");if(e.append(t,n),this.calendar1=new d.calendar({element:t,theme:this.theme,format:this.format,hideInputs:!0,hideNextNav:!0,styles:i.calendarStyles,iconPrev:this.iconPrev,onPrevNav:e=>this.prevHandler(e),rangeMode:!0,hideOtherMonthDays:!0,connector:this.connector,darkMode:this.darkMode}),this.calendar2=new d.calendar({element:n,theme:this.theme,format:this.format,hideInputs:!0,hidePrevNav:!0,styles:i.calendarStyles,iconNext:this.iconNext,onNextNav:e=>this.nextHandler(e),rangeMode:!0,hideOtherMonthDays:!0,connector:this.connector,darkMode:this.darkMode}),this.calendar2.setDisplayedMonthDate(this.calendar2DisplayedDate),this.append(e),"string"==typeof this.element){const e=document.querySelector(this.element);e&&e.append(this)}else"object"==typeof this.element&&this.element.append(this);if(this.onRender){const e=new CustomEvent("onRender");this.onRender(e)}}addStyles(){const e=`\n            .datedreamer-range {\n                display: inline-flex;\n                box-shadow: 0 10px 15px -3px rgb(0 0 0 / 10%), 0 4px 6px -4px rgb(0 0 0 / 10%);\n            }\n\n            .datedreamer-range.dark {\n                background: #2c3e50;\n            }\n            ${this.styles?this.styles:""}\n        `,t=document.createElement("style");t.innerHTML=e,this.append(t)}prevHandler(e){this.calendar1DisplayedDate=e.detail,this.calendar2DisplayedDate.setMonth(this.calendar2DisplayedDate.getMonth()-1),this.resetViewedDated()}nextHandler(e){this.calendar2DisplayedDate=e.detail,this.calendar1DisplayedDate.setMonth(this.calendar1DisplayedDate.getMonth()+1),this.resetViewedDated()}resetViewedDated(){var e,t;null===(e=this.calendar1)||void 0===e||e.setDisplayedMonthDate(this.calendar1DisplayedDate),null===(t=this.calendar2)||void 0===t||t.setDisplayedMonthDate(this.calendar2DisplayedDate)}}t.range=o,customElements.define("datedreamer-range",o)},770:(e,t)=>{"use strict";Object.defineProperty(t,"__esModule",{value:!0}),t.litePurple=t.unstyledTheme=t.calendarToggleRoot=t.calendarRoot=t.rightChevron=t.leftChevron=t.weekdays=t.monthNames=void 0,t.monthNames=["January","February","March","April","May","June","July","August","September","October","November","December"],t.weekdays=["Sun","Mon","Tue","Wed","Thu","Fri","Sat"],t.leftChevron='<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512"><path d="M9.4 233.4c-12.5 12.5-12.5 32.8 0 45.3l192 192c12.5 12.5 32.8 12.5 45.3 0s12.5-32.8 0-45.3L77.3 256 246.6 86.6c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0l-192 192z"/></svg>',t.rightChevron='<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512"><path d="M310.6 233.4c12.5 12.5 12.5 32.8 0 45.3l-192 192c-12.5 12.5-32.8 12.5-45.3 0s-12.5-32.8 0-45.3L242.7 256 73.4 86.6c-12.5-12.5-12.5-32.8 0-45.3s32.8-12.5 45.3 0l192 192z"/></svg>',t.calendarRoot=function(e,n="",a){return`\n  <style>\n      ${t.unstyledTheme}\n      ${"lite-purple"==e?t.litePurple:""}\n      \n      ${n}\n  </style>\n  <div class="datedreamer__calendar ${a?"dark":""}">\n      <div class="datedreamer__calendar_header"></div>\n  \n      <div class="datedreamer__calendar_inputs"></div>\n      <div class="datedreamer__calendar_errors"></div>\n  \n      <div class="datedreamer__calendar_days-wrap">\n          <div class="datedreamer__calendar_days-header">\n              <div class="datedreamer__calendar_day datedreamer__calendar_day-header">Su</div>    \n              <div class="datedreamer__calendar_day datedreamer__calendar_day-header">Mo</div>\n              <div class="datedreamer__calendar_day datedreamer__calendar_day-header">Tu</div>\n              <div class="datedreamer__calendar_day datedreamer__calendar_day-header">We</div>\n              <div class="datedreamer__calendar_day datedreamer__calendar_day-header">Th</div>\n              <div class="datedreamer__calendar_day datedreamer__calendar_day-header">Fr</div>\n              <div class="datedreamer__calendar_day datedreamer__calendar_day-header">Sat</div>\n          </div>\n  \n          <div class="datedreamer__calendar_days"></div>\n      </div>\n  </div>\n  `},t.calendarToggleRoot=function(e,t="",n,a){return`\n    <style>\n        .datedreamer__calendar-toggle {\n            position: relative;\n        }\n        .datedreamer__calendar-toggle__calendar {\n            display: none;\n            position: absolute;\n            top: 100%;\n            left: 0;\n        }\n\n        .datedreamer__calendar-toggle__calendar.active {\n            display: block;\n        }\n\n        ${"lite-purple"==e?"\n        .datedreamer__calendar-toggle__input input {\n            font-weight: 500;\n            border-radius: 4px;\n            border: 1px solid #e9e8ec;\n            font-size: 12px;\n            background: white;\n            display: block;\n            padding: 4px 4px 4px 8px;\n            margin-right: 8px;\n        }\n        ":""}\n\n        ${t}\n    </style>\n    <div class="datedreamer__calendar-toggle">\n        <div class="datedreamer__calendar-toggle__input">\n            <input id="date-input" placeholder="${n}" value="${a}" readonly/>\n        </div>\n\n        <div class="datedreamer__calendar-toggle__calendar"></div>\n    </div>\n  `},t.unstyledTheme="\n@import url('https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap');\n\n.datedreamer__calendar {\n    -webkit-font-smoothing: antialiased;\n    -moz-osx-font-smoothing: grayscale;\n    font-family: 'Roboto', sans-serif;\n    width: 100%;\n    max-width: 240px;\n    padding: 14px;\n    box-shadow: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);\n    background: #fff;\n    z-index: 0;\n    position: relative;\n    box-sizing: border-box;\n}\n\n.datedreamer__calendar.dark {\n  background: #2c3e50;\n}\n\n.datedreamer__calendar_header {\n    width: 100%;\n    display: flex;\n    align-items: center;\n}\n\n.datedreamer__calendar_prev,.datedreamer__calendar_next {\n    background: none;\n    border: none;\n    width: 16px;\n    height: 16px;\n    text-align: center;\n    cursor: pointer;\n    display: flex;\n    align-items: center;\n    justify-content: center;\n    color:#2d3436;\n}\n\n.dark .datedreamer__calendar_prev, .dark .datedreamer__calendar_next {\n  color: #fff;\n}\n\n.datedreamer__calendar_prev svg, .datedreamer__calendar_next svg {\n    transform: scale(2.875);\n}\n\n.dark .datedreamer__calendar_prev svg, .dark .datedreamer__calendar_next svg {\n  fill: #fff;\n}\n\n.datedreamer__calendar_title {\n    width: 100%;\n    display: block;\n    flex-grow: 1;\n    text-align: center;\n    color: #2d3436;\n    font-weight: 600;\n    font-size: 0.875rem;\n}\n\n.dark .datedreamer__calendar_title {\n  color: #fff;\n}\n\n.datedreamer__calendar_inputs {\n    margin-top: 12px;\n}\n\n.datedreamer__calendar_inputs label {\n  width: 100%;\n}\n\n.dark .datedreamer__calendar_inputs label {\n  color: #fff;\n}\n\n.datedreamer__calendar__inputs-wrap {\n  display: flex;\n}\n\n.datedreamer__calendar_inputs input {\n  width: 100%;\n}\n\n.datedreamer__calendar_inputs input.error {\n   border: 2px solid #d63031;\n}\n\n.datedreamer__calendar_errors {\n  margin: 8px 0;\n  color: #d63031;\n}\n\n.datedreamer__calendar_days, .datedreamer__calendar_days-header {\n    margin-top: 12px;\n    display: grid;\n    grid-template-columns: repeat(7,1fr);\n    text-align: center;\n}\n\n.datedreamer__calendar_days-header {\n  color: #2d3436;\n  font-size: 1rem;\n}\n\n.dark .datedreamer__calendar_days-header {\n  color: #fff;\n}\n\n.datedreamer__calendar_day {\n    width: 100%;\n    height: 100%;\n    display: block;\n}\n\n.datedreamer__calendar_day button {\n    display: block;\n    width: 100%;\n    height: 100%;\n    cursor: pointer;\n}\n\n.datedreamer__calendar_day.active button {\n    background: blue;\n    color: white;\n}\n\n.datedreamer__calendar_day.highlight button {\n  background: #236bb9;\n  color: white;\n}\n",t.litePurple='\n.datedreamer__calendar {\n  border-radius: 8px;\n}\n\n.datedreamer__calendar_prev svg, .datedreamer__calendar_next svg {\n  transform: scale(2);\n}\n\n.datedreamer__calendar_title {\n  font-size: 12px;\n}\n\n.datedreamer__calendar_inputs input, .datedreamer__calendar_inputs button {\n  font-weight: 500;\n  border-radius: 4px;\n  border: 1px solid #e9e8ec;\n  font-size: 12px;\n  background: white;\n}\n\n.datedreamer__calendar_inputs label {\n  font-size: 12px;\n}\n\n.datedreamer__calendar_inputs input {\n  flex-grow: 1;\n  width: calc(100% - 8px);\n  display: block;\n  padding: 4px 4px 4px 8px;\n  margin-right: 8px;\n}\n\n.dark .datedreamer__calendar_inputs input {\n  background: #4b6584;\n  border: #4b6584;\n  color: #fff;\n}\n\n.datedreamer__calendar_inputs button {\n  padding: 6px 12px;\n  display: inline-block;\n  cursor: pointer;\n  color: black;\n}\n\n.dark .datedreamer__calendar_inputs button {\n  background: #4b6584;\n  border: #4b6584;\n  color: #fff;\n}\n\n.datedreamer__calendar_errors {\n  font-size: 12px;\n  font-weight: bold;\n}\n\n.datedreamer__calendar_day-header.datedreamer__calendar_day {\n  font-size: 12px;\n}\n\n.datedreamer__calendar_days {\n  margin-top: 8px;\n}\n\n.datedreamer__calendar_days .datedreamer__calendar_day {\n  margin: 2px;\n}\n\n.datedreamer__calendar_days .datedreamer__calendar_day.disabled button{\n  color: #767676;\n  cursor: default;\n  font-weight: normal;\n}\n\n.datedreamer__calendar_days .datedreamer__calendar_day.active, .datedreamer__calendar_days .datedreamer__calendar_day.highlight {\n  position: relative;\n}\n\n.datedreamer__calendar_day.highlight:before{\n  content: "";\n  width: 100%;\n  height: 100%;\n  background: #BFA9F3;\n  position: absolute;\n  display: block;\n  z-index: -1;\n  top: 50%;\n  right: 0;\n  left: 0;\n  transform: translateY(-50%);\n}\n\n\n.datedreamer__calendar_days .datedreamer__calendar_day.active:before {\n  content: "";\n  width: 100%;\n  height: 100%;\n  background: #7d56da;\n  border-radius: 2px;\n  position: absolute;\n  display: block;\n  z-index: -1;\n  top: 50%;\n  right: 0;\n  left: 0;\n  transform: translateY(-50%);\n}\n\n.datedreamer__calendar_days .datedreamer__calendar_day button {\n  background: transparent;\n  border: none;\n  padding: 5px;\n  display: flex;\n  justify-content: center;\n  align-items: center;\n  font-size: 12px;\n  font-weight: bold;\n  color: black;\n}\n\n.datedreamer__calendar_days .datedreamer__calendar_day.active button {\n  color: #fff;\n}\n\n.dark .datedreamer__calendar_days .datedreamer__calendar_day button {\n  color: #ecf0f1;\n}\n'},167:(e,t)=>{"use strict";Object.defineProperty(t,"__esModule",{value:!0}),t.calendarStyles=void 0,t.calendarStyles="\n    .datedreamer__calendar {\n        box-shadow: none;\n    } \n"}},t={};function n(a){var r=t[a];if(void 0!==r)return r.exports;var i=t[a]={exports:{}};return e[a].call(i.exports,i,i.exports,n),i.exports}var a={};return(()=>{"use strict";var e=a;Object.defineProperty(e,"__esModule",{value:!0}),e.range=e.calendarToggle=e.calendar=void 0;const t=n(412);Object.defineProperty(e,"calendarToggle",{enumerable:!0,get:function(){return t.calendarToggle}});const r=n(35);Object.defineProperty(e,"calendar",{enumerable:!0,get:function(){return r.calendar}});const i=n(704);Object.defineProperty(e,"range",{enumerable:!0,get:function(){return i.range}})})(),a})()));--%>
    <%--    </script>--%>
    <div class="calendar-container">
        <div id="calendar" class="calendar"></div>
    </div>

    <div class="side-controls">
        <svg class="clear" viewBox="0 0 45 51" xmlns="http://www.w3.org/2000/svg"
             xml:space="preserve"
             style="fill-rule:evenodd;clip-rule:evenodd;stroke-linejoin:round;stroke-miterlimit:2;">
    <g transform="matrix(1,0,0,1,-5.99606,0.0332823)">
        <path d="M46.438,-0.031C46.27,-0.039 46.098,-0.023 45.938,0C45.266,0.094 44.688,0.422 44.281,1.031L44.25,1.094L44.219,1.125L35.656,17.219C34.691,16.859 33.734,16.648 32.844,16.625C31.883,16.602 30.977,16.75 30.156,17.094C28.574,17.754 27.379,19.047 26.594,20.688C26.559,20.738 26.527,20.789 26.5,20.844C26.496,20.852 26.504,20.867 26.5,20.875C26.488,20.895 26.477,20.918 26.469,20.938C26.457,20.977 26.445,21.02 26.438,21.063C25.895,22.418 25.27,23.637 24.563,24.719C24.555,24.73 24.539,24.738 24.531,24.75C24.441,24.828 24.367,24.926 24.313,25.031C24.309,25.039 24.316,25.055 24.313,25.063C24.277,25.113 24.246,25.164 24.219,25.219C21.832,28.637 18.723,30.695 15.781,31.969C11.773,33.703 7.938,33.887 7.094,33.813C6.691,33.773 6.305,33.977 6.113,34.332C5.926,34.688 5.965,35.125 6.219,35.438C17.613,49.5 34.375,50 34.375,50C34.574,50.004 34.77,49.949 34.938,49.844C34.938,49.844 37.008,48.531 39.5,45.406C41.371,43.059 43.504,39.664 45.344,34.969C45.355,34.957 45.363,34.949 45.375,34.938C45.605,34.723 45.723,34.41 45.688,34.094L45.688,34.063C46.172,32.754 46.641,31.379 47.063,29.875C47.078,29.813 47.09,29.75 47.094,29.688L47.094,29.656C48.426,26.219 46.941,22.434 43.75,20.781L49.938,3.625L49.938,3.594L49.969,3.563C50.172,2.852 49.938,2.168 49.563,1.625C49.207,1.113 48.688,0.711 48.063,0.438L48.063,0.406C48.043,0.398 48.02,0.414 48,0.406C47.988,0.402 47.98,0.379 47.969,0.375C47.48,0.145 46.945,-0.012 46.438,-0.031ZM46.313,2.063C46.539,2.027 46.836,2.027 47.156,2.188L47.188,2.219L47.219,2.219C47.543,2.348 47.813,2.566 47.938,2.75C48.063,2.934 48.027,3.043 48.031,3.031L41.938,19.938C41.203,19.605 40.695,19.371 39.656,18.906C38.883,18.559 38.148,18.223 37.5,17.938L45.938,2.156C45.93,2.164 46.086,2.098 46.313,2.063ZM32.813,18.625C33.508,18.645 34.27,18.785 35.125,19.125C35.145,19.137 35.168,19.148 35.188,19.156C35.414,19.512 35.84,19.688 36.25,19.594C36.363,19.641 36.352,19.637 36.469,19.688C37.145,19.98 37.996,20.34 38.844,20.719C40.086,21.273 40.871,21.613 41.594,21.938C41.613,21.961 41.633,21.98 41.656,22C41.871,22.297 42.23,22.453 42.594,22.406L42.625,22.406C45.016,23.5 46.07,26.105 45.25,28.625C44.855,28.613 44.555,28.633 43.813,28.469C43.258,28.348 42.719,28.152 42.313,27.906C41.906,27.66 41.672,27.418 41.563,27.094C41.477,26.813 41.27,26.586 40.996,26.473C40.727,26.355 40.418,26.367 40.156,26.5C39.82,26.668 38.973,26.605 38.219,26.219C37.844,26.027 37.508,25.758 37.281,25.531C37.055,25.305 36.992,25.09 37,25.125C36.945,24.832 36.766,24.578 36.504,24.434C36.246,24.289 35.934,24.27 35.656,24.375C35.629,24.387 35.297,24.418 34.906,24.344C34.516,24.27 34.063,24.109 33.625,23.906C33.188,23.703 32.785,23.457 32.531,23.25C32.277,23.043 32.254,22.828 32.281,23.094C32.215,22.566 31.75,22.18 31.219,22.219C30.215,22.313 29.273,21.574 28.719,21.094C29.305,20.105 30.031,19.316 30.938,18.938C31.492,18.707 32.117,18.605 32.813,18.625ZM27.813,22.969C28.508,23.469 29.473,23.988 30.625,24.094C30.809,24.363 31.008,24.582 31.25,24.781C31.684,25.141 32.219,25.457 32.781,25.719C33.344,25.98 33.934,26.199 34.531,26.313C34.84,26.371 35.156,26.254 35.469,26.25C35.617,26.477 35.684,26.777 35.875,26.969C36.281,27.375 36.766,27.719 37.313,28C38.125,28.418 39.102,28.563 40.063,28.438C40.391,28.93 40.785,29.344 41.25,29.625C41.934,30.035 42.68,30.285 43.375,30.438C43.863,30.543 44.309,30.59 44.719,30.625C44.441,31.523 44.141,32.367 43.844,33.188C43.484,33.176 43.043,33.156 42.563,33.063C41.469,32.852 40.434,32.367 40,31.531C39.766,31.094 39.246,30.895 38.781,31.063C38.285,31.238 37.387,31.164 36.625,30.813C35.863,30.461 35.285,29.852 35.156,29.406C35.074,29.137 34.879,28.914 34.621,28.797C34.367,28.676 34.074,28.672 33.813,28.781C33.57,28.883 32.625,28.855 31.844,28.5C31.063,28.145 30.559,27.547 30.5,27.219C30.449,26.941 30.285,26.703 30.047,26.555C29.809,26.406 29.52,26.363 29.25,26.438C28.305,26.691 27.566,26.355 26.969,25.906C26.762,25.754 26.609,25.586 26.469,25.438C26.953,24.668 27.402,23.852 27.813,22.969ZM25.313,27.094C25.461,27.23 25.602,27.363 25.781,27.5C26.52,28.055 27.656,28.449 28.938,28.375C29.402,29.246 30.156,29.914 31.031,30.313C31.895,30.707 32.816,30.832 33.719,30.719C34.219,31.535 34.914,32.227 35.781,32.625C36.707,33.051 37.746,33.16 38.75,33C39.684,34.168 41.012,34.805 42.188,35.031C42.5,35.09 42.809,35.129 43.094,35.156C41.43,39.176 39.566,42.117 37.938,44.156C35.852,46.77 34.441,47.758 34.125,47.969C33.77,47.953 31.164,47.77 27.5,46.75C27.801,46.555 28.125,46.352 28.469,46.094C30.137,44.844 32.32,42.805 34.438,39.656C34.66,39.332 34.676,38.91 34.473,38.574C34.27,38.234 33.891,38.047 33.5,38.094C33.207,38.125 32.945,38.285 32.781,38.531C30.797,41.484 28.754,43.375 27.25,44.5C25.82,45.57 24.992,45.902 24.906,45.938C22.656,45.145 20.164,44.059 17.625,42.531C17.992,42.41 18.383,42.25 18.813,42.063C20.711,41.234 23.25,39.688 25.844,36.781C26.156,36.469 26.227,35.988 26.02,35.602C25.809,35.211 25.371,35.004 24.938,35.094C24.707,35.133 24.496,35.258 24.344,35.438C21.938,38.129 19.684,39.496 18.031,40.219C16.379,40.941 15.438,41 15.438,41C15.395,41.008 15.352,41.02 15.313,41.031C13.238,39.57 11.168,37.793 9.219,35.656C11.121,35.508 13.57,35.121 16.594,33.813C19.578,32.52 22.762,30.41 25.313,27.094Z"
              style="fill-rule:nonzero;"></path>
    </g>
</svg>

    </div>
    <canvas class="particles" width="1920" height="972"></canvas>
    <%@include file="components/element-playground.jsp" %>

    <div class="reset">Reset</div>
    <a class="login" href="./login/">Log in</a>
    <a class="logout">Log out</a>
</div>

<script>
    const clearButton = document.querySelector('.clear')
    let retrievedData = sessionStorage.getItem("test-data")
    if (retrievedData == null) {
        let gameInstance = {
            "element-of-the-day": "Water",
            "elements": [{"text": "Water", "emoji": "💧", "discovered": true}, {
                "text": "Fire",
                "emoji": "🔥",
                "discovered": true
            }, {"text": "Wind", "emoji": "🌬️", "discovered": false}, {
                "text": "Earth",
                "emoji": "🌍",
                "discovered": false
            }, {"text": "Ebert is Mega Gay", "emoji": "🏳️‍🌈", "discovered": true}, {
                "text": "Mountain",
                "emoji": "🏔️",
                "discovered": false
            }, {"text": "Dust", "emoji": "🌫️", "discovered": false}, {
                "text": "Wave",
                "emoji": "🌊",
                "discovered": false
            }, {"text": "Tornado", "emoji": "🌪️", "discovered": false}, {
                "text": "Volcano",
                "emoji": "🌋",
                "discovered": false
            }, {"text": "Lake", "emoji": "🌊", "discovered": false}, {
                "text": "Island",
                "emoji": "🏝️",
                "discovered": false
            }, {"text": "Lava", "emoji": "🌋", "discovered": false}, {
                "text": "Mountain Range",
                "emoji": "🏔️",
                "discovered": false
            }, {"text": "Fjord", "emoji": "🏞️", "discovered": false}, {
                "text": "Tsunami",
                "emoji": "🌊",
                "discovered": false
            }, {"text": "Ocean", "emoji": "🌊", "discovered": false}, {
                "text": "Tree",
                "emoji": "🌳",
                "discovered": false
            }, {"text": "Forest", "emoji": "🌲", "discovered": false}, {
                "text": "Jungle",
                "emoji": "🌴",
                "discovered": false
            }, {"text": "Earthquake", "emoji": "🌋", "discovered": false}, {
                "text": "Smoke",
                "emoji": "💨",
                "discovered": false
            }, {"text": "Eruption", "emoji": "🌋", "discovered": false}, {
                "text": "Hurricane",
                "emoji": "🌀",
                "discovered": false
            }, {"text": "Steam", "emoji": "💨", "discovered": false}, {
                "text": "Cloud",
                "emoji": "☁️",
                "discovered": false
            }, {"text": "Rain", "emoji": "🌧️", "discovered": false}, {
                "text": "Rainbow",
                "emoji": "🌈",
                "discovered": false
            }, {"text": "Flood", "emoji": "🌊", "discovered": false}, {
                "text": "Unicorn",
                "emoji": "🦄",
                "discovered": false
            }, {"text": "Dragon", "emoji": "🐉", "discovered": false}, {
                "text": "Sea Serpent",
                "emoji": "🐍",
                "discovered": false
            }, {"text": "Kraken", "emoji": "🐙", "discovered": false}, {
                "text": "Poseidon",
                "emoji": "🌊",
                "discovered": false
            }, {"text": "Triton", "emoji": "🔱", "discovered": false}, {
                "text": "Mermaid",
                "emoji": "🧜‍♀️",
                "discovered": false
            }, {"text": "Atlantis", "emoji": "🌊", "discovered": false}, {
                "text": "Sand",
                "emoji": "🏖️",
                "discovered": false
            }, {"text": "Desert", "emoji": "🏜️", "discovered": false}, {
                "text": "Mirage",
                "emoji": "🌵",
                "discovered": false
            }, {"text": "Oasis", "emoji": "🏜️", "discovered": false}, {
                "text": "Cum",
                "emoji": "💦",
                "discovered": false
            }, {"text": "Potato", "emoji": "🥔", "discovered": false}, {
                "text": "Colonel",
                "emoji": "🪖",
                "discovered": false
            }, {"text": "Microprocessors", "emoji": "🖥️", "discovered": false}, {
                "text": "French Fries",
                "emoji": "🍟",
                "discovered": false
            }, {"text": "Mud", "emoji": "💩", "discovered": false}, {
                "text": "Dragonborn",
                "emoji": "🐉",
                "discovered": false
            }, {"text": "French Cum", "emoji": "🥐💦", "discovered": false}]
        }
        sessionStorage.setItem("test-data", JSON.stringify(gameInstance))
    }
    sessionStorage.setItem("listDates", JSON.stringify({"dates": ["2024-04-01", "2024-04-02", "2024-04-03", "2024-04-04", "2024-04-05", "2024-04-06", "2024-04-07", "2024-04-08", "2024-04-09", "2024-04-10", "2024-04-11", "2024-04-12", "2024-04-13", "2024-04-14", "2024-04-15", "2024-04-16", "2024-04-17", "2024-04-18", "2024-04-19", "2024-04-20"]}))
    document.addEventListener('DOMContentLoaded', function () {
        clearButton.addEventListener('mousedown', function () {
            document.querySelector('.instances').innerHTML = ''
        })
        // new datedreamer.calendarToggle({
        //     element: "#calendar",
        //     format: "YYYY-MM-DD",
        //     theme: "lite-purple",
        //     styles: `
        //         #date-input {
        //             width: 80px;
        //             background-size: 23px 23px;
        //             height: 32px;
        //             font-size: 14px;
        //             text-align: center;
        //             padding: 0 8px 0 8px;
        //         }`,
        //     onChange: (e) => {
        //         checkIfDateAvailable(e.detail)
        //     }
        // })
        if (sessionStorage.getItem('loggedIn') === 'true') document.querySelector('.logout').style.display = 'block';
        else document.querySelector('.login').style.display = 'block';
    })

    function checkIfDateAvailable(text) {
        if (!JSON.parse(sessionStorage.getItem("listDates")).dates.includes(text)) {
            window.alert('Data não disponível')
        }
    }
</script>

</body>
</html>
