/**
 * 사이드 메뉴
 */

$(function(){
    var menu = $(".menu-list > ul");
    var navDepth1 = menu.find(" > li");

    navDepth1.each(function() {
        var thisLength = $(this).find("> ul").size();
        if(thisLength){
            $(this).addClass("has-children");
        }
    });

    navDepth1.find(" > a").on("click",function(event){
        var thisItem = $(this).parent("li"),
            thisLength = $(this).next("ul").size();
        if(thisLength){
            event.preventDefault();
            if (!thisItem.hasClass("active")){
                navDepth1.not(thisItem).removeClass("active");
                $(this).parent().addClass("active");
            }  else {
                $(this).parent().removeClass("active");
            }
        }
    });
});


/**
 * side height 적용 - 브라우저 높이에 따라 구분하여 적용
 */
var resizeSideVar = {
    side: $(".menu-list-wrap"),
    item: $(".menu-list"),
    container: $("#container"),
    state: null
};

function resizeSideReset() {
    resizeSideVar.item.css({
        height: "auto"
    });
}

/**
 * side 높이 지정 및 copyright position 변경
 * @param side
 * @param sideWrap
 * @param state
 */
function resizeSideEffect(side, sideWrap) {
    var vSide = side,
        vSideWrap = sideWrap;
        resizeSideVar.side.css("height", vSide);
        resizeSideVar.item.css("height", vSideWrap);
}

function resizeSide() {
    resizeSideReset();
    var windowHeight = $(window).height(),
        containerHeight = resizeSideVar.container.innerHeight(),
        sideHeight = resizeSideVar.item.innerHeight();
        //sideRealHeight = Math.abs(sideHeight - resizeSideVar.item.outerHeight(true) - resizeSideVar.item.height()) + 30;
        //resizeSideVar.state = false;

    if (containerHeight < windowHeight) {
        resizeSideEffect("100vh", sideHeight);
    } else{
        if (sideHeight < containerHeight) {
            resizeSideEffect("100%", sideHeight);
        }else{
            resizeSideEffect(sideHeight, sideHeight);
        }
    }
}

$(document).ready(function(){
 resizeSide();
});



$(function () {
    /**
     * affix default 확인
     * @param element
     * @param options
     * @constructor
     */
    var Affix = function(element, options) {
        var setDefault = {
            offset: 0,
            target: window
        };
        this.window  = $(window);
        this.body    = $(document.body);
        this.options = $.extend({}, setDefault, options);
        this.$target = $(this.options.target)
        .on("scroll.affix, resize.affix", $.proxy(this.checkPosition, this));
        this.$element     = $(element);
        this.affixed      = null;
        this.checkPosition();
    };

    /**
     * 상태 확인, 현재 스크롤 위치가  offsetTop 보다 크면 실행된것으로 상태는 false로 리턴
     * @param scrollHeight
     * @param height
     * @param offsetTop
     * @returns {*}
     */
    Affix.prototype.getState = function(scrollHeight, height, offsetTop) {
        var scrollTop    = this.$target.scrollTop();

        if (offsetTop != null && this.affixed == "top") {
            return scrollTop < offsetTop ? "top" : false;
        }

        if (offsetTop != null && scrollTop <= offsetTop) {
            return "top";
        }
        return false
    };

    Affix.prototype.getLonger = function(windowHeight, height) {
        var scrollTop = this.$target.scrollTop(),
            distanceHeight = Math.abs(windowHeight - height);
        

        if (scrollTop >= distanceHeight) {
            return "longer";
        }
        else {
            return "longer-top";
        }
    };

    /**
     * css 등 state 체크 적용
     * @type {string}
     */
    Affix.RESET    = "affix affix-top affix-bottom affix-longer affix-longer-top";

    Affix.prototype.checkPosition = function() {
        if (!this.$element.is(":visible")) return;
        var height          = this.$element.innerHeight();   //해당 영역 높이
        var offset          = this.options.offset;      //해당 영역 지정 offset
        var logerUse        = this.options.longer;    //해당 영역 높이가 브라우저 높이 보다 큰 경우 실행
        var addAffix        = this.options.addaffix;
        var offsetTop       = offset.top;
        var scrollHeight    = Math.max($(document).height(), $(document.body).height());
        var windowHeight    =  this.window.height();
        var affix;

        if (typeof offsetTop == "function"){
            offsetTop    = offset.top(this.$element);
        }

        if (logerUse && (height > windowHeight)) {

            affix = this.getLonger(windowHeight, height);

        }
        else{
            //현재 정보 체크하여 top / bottom / false 가져옴
            affix = this.getState(scrollHeight, height, offsetTop);
        }

        //affix 상태가 false일떄 현재 체크도  false이면 실행 안함
        if (this.affixed !== affix) {
            if (this.affixed !== affix) {


                var affixType = "affix" + (affix ? "-" + affix : "");  // affix-top / affix-bottom / affix / affix-longer / affix-longer-top 등 type을 만듬

                this.affixed = affix;
                this.$element
                .removeClass(Affix.RESET)
                .addClass(affixType);
                if (addAffix) {
                    //console.log(addAffix);
                    $(addAffix)
                    .removeClass(Affix.RESET)
                    .addClass(affixType);
                }
            }
        }
    };

    /**
     * 로딩 또는 호출시 각 영역을 체크하여 실행함
     * @param option
     * @returns {JQuery|*}
     */
    function affix(option){
        return this.each(function() {
            var $this   = $(this);
            var data    = $this.data("affix");
            var options = typeof option == "object" && option;

            if (!data) $this.data("affix", (data = new Affix(this, options)));
            if (typeof option == "string") data[option]()
        })
    }

    /**
     * js로 호출시 ($.fn.affix)  affix 함수 실행
     * @type {affix}
     */
    $.fn.affix             = affix;

    /**
     * html 문서의  data-spy, data-offset-top 확인하여 실행
     */
    $(window).on("load", function() {
        $("[data-spy=\"affix\"]").each(function () {
            var $spy = $(this);
            var data = $spy.data();

            data.offset = data.offset || {};

            if (data.offsetTop    != null) {
                data.offset.top    = data.offsetTop;
            }

            affix.call($spy,data)
        })
    });
});

$(document).ready(function(){
    $(".header").affix();
});


/* onClick - add/remove Class */
$(function(){
    var template =  {
        body : $(".template, .main, .gnb--template"),
        button : $(".gnb--template, .template__button"),
        activeClass : "temp_active"
    };
    template.button.on("click", function () {
        if (!template.body.hasClass(template.activeClass)){
            template.body.addClass(template.activeClass);
        }  else {
            template.body.removeClass(template.activeClass);
        }
    });
});





