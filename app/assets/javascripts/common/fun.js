/* console */
var Fun = (function($) {
    // window.console = { info: function() {}, log:function(){} };
    var funObj = {};

    //==========detectmobile ========== 
    /*
        isMobile        :Boolean
        isIPhone        :Boolean
        isIPad          :Boolean
        isIosChrome     :Boolean
        fbApp           :String (ios/android)
     */
    funObj.detectmobile = { };//isMobile isIPhone isIPad isIosChrome fbApp
    var ua = navigator.userAgent.toLowerCase();
    var MOBILES_NAME/*Array*/ = [ 
        "android","iphone","windows ce","windows phone","symbian","blackberry",
        "mobile","phone","midp","cldc","opera mini","minimo","up.browser","up.link","docomo",
        "avantgo","palmos","ppc","xv6850","htc_","kindle","wap","mmp/","teleca","lge","portalmmm",
        "nintendo","nokia","armv","j2me","nook browser","webos","blazer","epoc","samsung","novarra-vision",
        "netfront","sec-sgh","sharp","au-mic/1.1.4.0","reqwirelessweb","sonyericsson","playstation","vodafone",
        "ucweb"
    ];

    for(var a in MOBILES_NAME){
        if(ua.indexOf(MOBILES_NAME[a]) != -1){
            funObj.detectmobile.isMobile = true;
            break;
        }
    }

    if(ua.indexOf('iphone') > -1) funObj.detectmobile.isIPhone = true;
    if(ua.indexOf('ipad') > -1) funObj.detectmobile.isIPad = true;

    if(ua.indexOf('fbav') != -1){
        if(ua.indexOf('fb_iab') != -1 || ua.indexOf('fb4a') != -1){
            funObj.detectmobile.fbApp = "android";
        }else if(ua.indexOf('fban') != -1 || ua.indexOf('fbios') != -1){
            funObj.detectmobile.fbApp = "ios";
        }
    }

    if(funObj.detectmobile.isIPhone || funObj.detectmobile.isIPad){
        if(ua.indexOf('crios') > -1) funObj.detectmobile.isIosChrome = true;
    }

    if(ua.indexOf('line') != -1){
        funObj.detectmobile.fbApp = "ios";
        //funObj.detectmobile.isLine = true;
    }

    //==========數字轉字串 補字==========
    funObj.str_pad = function(pNum, pPlaces, pPad, pAlign) {
        pAlign = pAlign || "left";
        var inStr = pNum + "";
        while (inStr.length < pPlaces) {
            if (pAlign === "left") {
                inStr = pPad + inStr;
            } else if (pAlign === "right") {
                inStr = inStr + pPad;
            };
        };
        return inStr;
    };

    //取得網頁參數
    funObj.getQueryVariable = function (variable) {
        var query = window.location.search.substring(1);
        var vars = query.split('&');
        for (var i = 0, max = vars.length; i < max; i++) {
            var pair = vars[i].split('=');
            if (decodeURIComponent(pair[0]) == variable) {
                return decodeURIComponent(pair[1]);
            }
        }
    }

    //表單設定
    funObj.setForm = function() {
        $("[prompt]").each(function(i) {
            $(this).val($(this).attr('prompt'));
        });
        $("[prompt]").focus(function() {
            if ($(this).val() == $(this).attr("prompt")) {
                $(this).val("");
            }
            $(this).parent('div').find("input[name='sentence']").attr("checked", "true");
        });
        $("[prompt]").blur(function() {
            $(this).val(funObj.trim($(this).val()));
            if ($(this).val() == "" || $(this).val() == $(this).attr("prompt")) {
                $(this).val($(this).attr("prompt"));
            };
        });
    }

    funObj.eleFadeIn = function(pEle, pSpeed, pComplete) {
        pSpeed = pSpeed || "normal";
        if (!this.isIE8()) {
            pEle.stop(true, true).fadeIn(pSpeed);
        } else {
            pEle.show();
        }
    }

    funObj.eleFadeOut = function(pEle, pSpeed, pComplete) {
        pSpeed = pSpeed || "normal";
        if (!this.isIE8()) {
            pEle.stop(true, true).fadeOut(pSpeed, function() {
                if (typeof pComplete === 'function') {
                    pComplete();
                }
            });
        } else {
            pEle.hide();
            if (typeof pComplete === 'function') {
                pComplete();
            }
        }
    }

    //判斷是否為IE8,IE7,IE6
    funObj.isIE8 = function() {
        return (navigator.userAgent.search("MSIE 7") > -1 || navigator.userAgent.search("MSIE 8") > -1 || navigator.userAgent.search("MSIE 6") > -1);;
    }

    //去左右空白
    funObj.trim = function(strvalue) {
        var ptntrim = /(^\s*)|(\s*$)/g;
        return strvalue.replace(ptntrim, "");
    }

    //取代換行 pVal預設為空值
    funObj.replaceBr = function(pKey, pVal) {
        pVal = pVal || "";
        pKey = pKey.replace(/<\/?.+?>/g, pVal);
        pKey = pKey.replace(/[\r\n]/g, pVal);
        return pKey;
    }

    //
    funObj.getFileName = function() {
        var fileName = getRedirectParam();
        fileName = fileName.split('?');
        fileName = fileName[0];
        fileName = fileName.split('#');
        fileName = fileName[0];
        return fileName;
    }

    //
    funObj.getRedirectParam = function() {
        var param = location.href.split('/');
        param = param[param.length - 1];
        return param;
    }

    //
    funObj.checkLeapYear = function(pY) {
        return (pY % 400 == 0) || (pY % 4 == 0 && pY % 100 != 0);
    }

    //check protocol
    funObj.checkProtocol = function() {
        var protocolStr = window.location.protocol;
        if (protocolStr == "http:") {
            var url = window.location.href;
            url = url.replace("http:", "https:");
            window.location.replace(url);
        }
    }


    //========== Loading ==========
    funObj.loadingChange = function(pBol) {
        pBol = pBol || false;
        if ($('#loading').attr('id') == undefined) {
            $('body').append(randerLoading());
        }
        if (pBol) {
            $("#loading").show();
        } else {
            $("#loading").hide();
        }
    }

    function randerLoading() {
        var $loading = $('<div id="loading"><img src="images/ajax-loader.gif"/><div class="loading_bg"></div></div>');
        $loading.css({
            'width': '100%',
            'height': '970px',
            'z-index': '9999',
            'position': 'fixed',
            'display': 'none',
            'top': '0px',
            'bottom': '0px',
            'left': '0px',
            'right': '0px',
            'margin': 'auto'
        });
        $loading.find('img').css({
            'top': '50%',
            'left': '50%',
            'margin': '-16px 0 0 -16px',
            'position': 'absolute',
            'z-index': 100
        });
        $loading.find('.loading_bg').css({
            'width': '100%',
            'height': '100%',
            'position': 'absolute',
            'background-color': '#fff',
            'opacity': 0
        });
        return $loading;
    }

    funObj.loadImg = function(url, callback) {
        var imgLoad = new Image();
        $(imgLoad).load(function() {
            callback(true);
            // console.log(this.clientWidth);
        }).error(function() {
            callback(false);
            console.log($(this).attr('src'));
        }).attr('src', url);
    }


    //補低階瀏覽器缺少的屬性
    if (!Array.prototype.indexOf) {
        Array.prototype.indexOf = function(elt /*, from*/ ) {
            var len = this.length >>> 0;
            var from = Number(arguments[1]) || 0;
            from = (from < 0) ? Math.ceil(from) : Math.floor(from);
            if (from < 0) from += len;

            for (; from < len; from++) {
                if (from in this && this[from] === elt) return from;
            }
            return -1;
        };
    }

    return funObj;
})(jQuery);
