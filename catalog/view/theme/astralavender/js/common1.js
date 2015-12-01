
/* Navigation */
jQuery(document).ready(function() {
    "use strict";
    jQuery(".toggle"). on("click", function() {
        return jQuery(".submenu").is(":hidden") ? jQuery(".submenu").slideDown("fast") : jQuery(".submenu").slideUp("fast"), !1
    }), jQuery(".topnav").accordion({
        accordion: !1,
        speed: 300,
        closedSign: "+",
        openedSign: "-"
    }), jQuery("#nav > li").hover(function() {
        var e = jQuery(this).find(".level0-wrapper");
        e.hide(), e.css("left", "0"), e.stop(true, true).delay(150).fadeIn(300, "easeOutCubic")
    }, function() {
        jQuery(this).find(".level0-wrapper").stop(true, true).delay(300).fadeOut(300, "easeInCubic")
    });
    jQuery("#nav li.level0.drop-menu").mouseover(function() {
        return jQuery(window).width() >= 740 && jQuery(this).children("ul.level1").fadeIn(100), !1
    }).mouseleave(function() {
        return jQuery(window).width() >= 740 && jQuery(this).children("ul.level1").fadeOut(100), !1
    }), jQuery("#nav li.level0.drop-menu li").mouseover(function() {
        if (jQuery(window).width() >= 740) {
            jQuery(this).children("ul").css({
                top: 0,
                left: "165px"
            });
            var e = jQuery(this).offset();
            e && jQuery(window).width() < e.left + 325 ? (jQuery(this).children("ul").removeClass("right-sub"), jQuery(this).children("ul").addClass("left-sub"), jQuery(this).children("ul").css({
                top: 0,
                left: "-167px"
            })) : (jQuery(this).children("ul").removeClass("left-sub"), jQuery(this).children("ul").addClass("right-sub")), jQuery(this).children("ul").fadeIn(100)
        }
    }).mouseleave(function() {
        jQuery(window).width() >= 740 && jQuery(this).children("ul").fadeOut(100)
    }),

 slideEffectAjax()

/* Best Seller Slider */
	 jQuery("#best-seller-slider .slider-items").owlCarousel({
        items: 4,
        itemsDesktop: [1024, 4],
        itemsDesktopSmall: [900, 3],
        itemsTablet: [600, 2],
        itemsMobile: [320, 1],
        navigation: !0,
        navigationText: ['<a class="flex-prev"></a>', '<a class="flex-next"></a>'],
        slideSpeed: 500,
        pagination: !1
    }),
	
	
/* Featured Slider */	
	 jQuery("#featured-slider .slider-items").owlCarousel({
        items: 4,
        itemsDesktop: [1024, 4],
        itemsDesktopSmall: [900, 3],
        itemsTablet: [600, 2],
        itemsMobile: [320, 1],
        navigation: !0,
        navigationText: ['<a class="flex-prev"></a>', '<a class="flex-next"></a>'],
        slideSpeed: 500,
        pagination: !1
    }),
	
	
/* Bag Seller Slider */	
	 jQuery("#bag-slider .slider-items").owlCarousel({
        items: 6,
        itemsDesktop: [1124, 4],
        itemsDesktopSmall: [900, 3],
        itemsTablet: [600, 2],
        itemsMobile: [320, 1],
        navigation: !0,
        navigationText: ['<a class="flex-prev"></a>', '<a class="flex-next"></a>'],
        slideSpeed: 500,
        pagination: !1
    }),
	

/* Shoes Slider */	
	 jQuery("#shoes-slider .slider-items").owlCarousel({
        items: 3,
        itemsDesktop: [1024, 4],
        itemsDesktopSmall: [900, 3],
        itemsTablet: [600, 2],
        itemsMobile: [320, 1],
        navigation: !0,
        navigationText: ['<a class="flex-prev"></a>', '<a class="flex-next"></a>'],
        slideSpeed: 500,
        pagination: !1
    }),
	
	
/* Recommended Seller Slider */	
	 jQuery("#recommend-slider .slider-items").owlCarousel({
        items: 6,
        itemsDesktop: [1024, 4],
        itemsDesktopSmall: [900, 3],
        itemsTablet: [600, 2],
        itemsMobile: [320, 1],
        navigation: !0,
        navigationText: ['<a class="flex-prev"></a>', '<a class="flex-next"></a>'],
        slideSpeed: 500,
        pagination: !1
    }),
	
	
/* Brand Logo Slider */	
	 jQuery("#brand-logo-slider .slider-items").owlCarousel({
        autoplay: !0,
        items: 6,
        itemsDesktop: [1024, 4],
        itemsDesktopSmall: [900, 3],
        itemsTablet: [600, 2],
        itemsMobile: [320, 1],
        navigation: !0,
        navigationText: ['<a class="flex-prev"></a>', '<a class="flex-next"></a>'],
        slideSpeed: 500,
        pagination: !1
    }),
	
	
/* Category Description Slider */	
	 jQuery("#category-desc-slider .slider-items").owlCarousel({
        autoplay: !0,
        items: 1,
        itemsDesktop: [1024, 1],
        itemsDesktopSmall: [900, 1],
        itemsTablet: [600, 1],
        itemsMobile: [320, 1],
        navigation: !0,
        navigationText: ['<a class="flex-prev"></a>', '<a class="flex-next"></a>'],
        slideSpeed: 500,
        pagination: !1
    }),
	
	
/* More View Slider */		
	 jQuery("#more-views-slider .slider-items").owlCarousel({
        autoplay: !0,
        items: 4,
        itemsDesktop: [1024, 4],
        itemsDesktopSmall: [900, 3],
        itemsTablet: [600, 2],
        itemsMobile: [320, 1],
        navigation: !0,
        navigationText: ['<a class="flex-prev"></a>', '<a class="flex-next"></a>'],
        slideSpeed: 500,
        pagination: !1
    }), 
	
	
/* Related Product Slider */	
	 jQuery("#related-products-slider .slider-items").owlCarousel({
        items: 4,
        itemsDesktop: [1024, 4],
        itemsDesktopSmall: [900, 3],
        itemsTablet: [600, 2],
        itemsMobile: [320, 1],
        navigation: !0,
        navigationText: ['<a class="flex-prev"></a>', '<a class="flex-next"></a>'],
        slideSpeed: 500,
        pagination: !1
    }),
	
	
/* UPsell Product Slider */	
	 jQuery("#upsell-products-slider .slider-items").owlCarousel({
        items: 4,
        itemsDesktop: [1024, 4],
        itemsDesktopSmall: [900, 3],
        itemsTablet: [600, 2],
        itemsMobile: [320, 1],
        navigation: !0,
        navigationText: ['<a class="flex-prev"></a>', '<a class="flex-next"></a>'],
        slideSpeed: 500,
        pagination: !1
    }),
	
	
	
/* More View Slider */	
	 jQuery("#more-views-slider .slider-items").owlCarousel({
        autoplay: !0,
        items: 3,
        itemsDesktop: [1024, 4],
        itemsDesktopSmall: [900, 3],
        itemsTablet: [600, 2],
        itemsMobile: [320, 1],
        navigation: !0,
        navigationText: ['<a class="flex-prev"></a>', '<a class="flex-next"></a>'],
        slideSpeed: 500,
        pagination: !1
    }), jQuery("ul.accordion li.parent, ul.accordion li.parents, ul#magicat li.open").each(function() {
        jQuery(this).append('<em class="open-close">&nbsp;</em>')
    }), jQuery("ul.accordion, ul#magicat").accordionNew(), jQuery("ul.accordion li.active, ul#magicat li.active").each(function() {
        jQuery(this).children().next("div").css("display", "block")
    }),	
	  jQuery("#os-phrases > h2").lettering("words").children("span").lettering().children("span").lettering()
});
     
	
var isTouchDevice = "ontouchstart" in window || navigator.msMaxTouchPoints > 0;
jQuery(window).on("load", function() {
        isTouchDevice && jQuery("#nav a.level-top").on("click", function() {
            if (jQueryt = jQuery(this), jQueryparent = jQueryt.parent(), jQueryparent.hasClass("parent")) {
                if (!jQueryt.hasClass("menu-ready")) return jQuery("#nav a.level-top").removeClass("menu-ready"), jQueryt.addClass("menu-ready"), !1;
                jQueryt.removeClass("menu-ready")
            }
        }), jQuery().UItoTop()
    }), jQuery(window).scroll(function() {
        jQuery(this).scrollTop() > 1 ? jQuery("nav").addClass("sticky") : jQuery("nav").removeClass("sticky")
    }),
	
	
/* ToTop*/	
    function(e) {
        jQuery.fn.UItoTop = function(i) {
            var t = {
                    text: "",
                    min: 200,
                    inDelay: 600,
                    outDelay: 400,
                    containerID: "toTop",
                    containerHoverID: "toTopHover",
                    scrollSpeed: 1200,
                    easingType: "linear"
                },
                n = e.extend(t, i),
                s = "#" + n.containerID,
                a = "#" + n.containerHoverID;
            jQuery("body").append('<a href="#" id="' + n.containerID + '">' + n.text + "</a>"), jQuery(s).hide().on("click", function() {
                return jQuery("html, body").animate({
                    scrollTop: 0
                }, n.scrollSpeed, n.easingType), jQuery("#" + n.containerHoverID, this).stop().animate({
                    opacity: 0
                }, n.inDelay, n.easingType), !1
            }).prepend('<span id="' + n.containerHoverID + '"></span>').hover(function() {
                jQuery(a, this).stop().animate({
                    opacity: 1
                }, 600, "linear")
            }, function() {
                jQuery(a, this).stop().animate({
                    opacity: 0
                }, 700, "linear")
            }), jQuery(window).scroll(function() {
                var i = e(window).scrollTop();
                "undefined" == typeof document.body.style.maxHeight && jQuery(s).css({
                    position: "absolute",
                    top: e(window).scrollTop() + e(window).height() - 50
                }), i > n.min ? jQuery(s).fadeIn(n.inDelay) : jQuery(s).fadeOut(n.Outdelay)
            })
        }
    }(jQuery), 
	
	
/* Accordian */		
	 jQuery.extend(jQuery.easing, {
        easeInCubic: function(e, i, t, n, s) {
            return n * (i /= s) * i * i + t
        },
        easeOutCubic: function(e, i, t, n, s) {
            return n * ((i = i / s - 1) * i * i + 1) + t
        }
    }),
    function(e) {
        e.fn.extend({
            accordion: function() {
                return this.each(function() {})
            }
        })
    }(jQuery), jQuery(function(e) {
        e(".accordion").accordion(), e(".accordion").each(function() {
            var i = e(this).find("li.active");
            i.each(function(t) {
                e(this).children("ul").css("display", "block"), t == i.length - 1 && e(this).addClass("current")
            })
        })
    }),
	
	
	
/* Responsive Nav */	
    function(e) {
        e.fn.extend({
            accordion: function(i) {
                var t = {
                        accordion: "true",
                        speed: 300,
                        closedSign: "[+]",
                        openedSign: "[-]"
                    },
                    n = e.extend(t, i),
                    s = e(this);
                s.find("li").each(function() {
                    0 != e(this).find("ul").size() && (e(this).find("a:first").after("<em>" + n.closedSign + "</em>"), "#" == e(this).find("a:first").attr("href") && e(this).find("a:first").on("click", function() {
                        return !1
                    }))
                }), s.find("li em").on("click", function() {
                    0 != e(this).parent().find("ul").size() && (n.accordion && (e(this).parent().find("ul").is(":visible") || (parents = e(this).parent().parents("ul"), visible = s.find("ul:visible"), visible.each(function(i) {
                        var t = !0;
                        parents.each(function(e) {
                            return parents[e] == visible[i] ? (t = !1, !1) : void 0
                        }), t && e(this).parent().find("ul") != visible[i] && e(visible[i]).slideUp(n.speed, function() {
                            e(this).parent("li").find("em:first").html(n.closedSign)
                        })
                    }))), e(this).parent().find("ul:first").is(":visible") ? e(this).parent().find("ul:first").slideUp(n.speed, function() {
                        e(this).parent("li").find("em:first").delay(n.speed).html(n.closedSign)
                    }) : e(this).parent().find("ul:first").slideDown(n.speed, function() {
                        e(this).parent("li").find("em:first").delay(n.speed).html(n.openedSign)
                    }))
                })
            }
        })
    }(jQuery),
    function(e) {
        e.fn.extend({
            accordionNew: function() {
                return this.each(function() {
                    function i(i, n) {
                        e(i).parent(r).siblings().removeClass(s).children(l).slideUp(o), e(i).siblings(l)[n || a]("show" == n ? o : !1, function() {
                            e(i).siblings(l).is(":visible") ? e(i).parents(r).not(t.parents()).addClass(s) : e(i).parent(r).removeClass(s), "show" == n && e(i).parents(r).not(t.parents()).addClass(s), e(i).parents().show()
                        })
                    }
                    var t = e(this),
                        n = "accordiated",
                        s = "active",
                        a = "slideToggle",
                        l = "ul, div",
                        o = "fast",
                        r = "li";
                    if (t.data(n)) return !1;
                    e.each(t.find("ul, li>div"), function() {
                        e(this).data(n, !0), e(this).hide()
                    }), e.each(t.find("em.open-close"), function() {
                        e(this).on("click", function() {
                            return void i(this, a)
                        }), e(this).bind("activate-node", function() {
                            t.find(l).not(e(this).parents()).not(e(this).siblings()).slideUp(o), i(this, "slideDown")
                        })
                    });
                    var c = location.hash ? t.find("a[href=" + location.hash + "]")[0] : t.find("li.current a")[0];
                    c && i(c, !1)
                })
            }
        })
    }(jQuery),
    function(e) {
        function i(i, t, n, s) {
            var a = i.text().split(t),
                l = "";
            a.length && (e(a).each(function(e, i) {
                l += '<span class="' + n + (e + 1) + '">' + i + "</span>" + s
            }), i.empty().append(l))
        }
        var t = {
            init: function() {
                return this.each(function() {
                    i(e(this), "", "char", "")
                })
            },
            words: function() {
                return this.each(function() {
                    i(e(this), " ", "word", " ")
                })
            },
            lines: function() {
                return this.each(function() {
                    var t = "eefec303079ad17405c889e092e105b0";
                    i(e(this).children("br").replaceWith(t).end(), t, "line", "")
                })
            }
        };
        e.fn.lettering = function(i) {
            return i && t[i] ? t[i].apply(this, [].slice.call(arguments, 1)) : "letters" !== i && i ? (e.error("Method " + i + " does not exist on jQuery.lettering"), this) : t.init.apply(this, [].slice.call(arguments, 0))
        }
    }(jQuery);
	
	/* Top Cart */

function slideEffectAjax() {
    jQuery(".top-cart-contain").mouseenter(function() {
        jQuery(this).find(".top-cart-content").stop(true, true).slideDown()
    }), jQuery(".top-cart-contain").mouseleave(function() {
        jQuery(this).find(".top-cart-content").stop(true, true).slideUp()
    })
}
