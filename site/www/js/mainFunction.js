let selectedCate1 = [];
let selectedCate2 = [];
let originalSlides = null
$(document).ready(function () {
    originalSlides = $('.reserve-item-list .slide-item').clone();
    if ( $('.reservationList').length > 0 ) {
        slideProgram('.reservationList')
    }

    $('.cateDiv button').on('click', function() {
        const keyword = $(this).data('filter-keyword');

        $(this).toggleClass('selected');

        if (keyword.startsWith('CATE1')) {
            if ($(this).hasClass('selected')) {
                selectedCate1.push(keyword);
            } else {
                selectedCate1 = selectedCate1.filter(k => k !== keyword);
            }
        }

        if (keyword.startsWith('CATE2')) {
            if ($(this).hasClass('selected')) {
                selectedCate2.push(keyword);
            } else {
                selectedCate2 = selectedCate2.filter(k => k !== keyword);
            }
        }

        //applyProgramFilter();
    });
})
$(window).on('load', function(){

    if( $('.event-slide') ) {
        slidePopup('.event-slide')
    }
    handleSelectMap()

    if ( $('.boardGroup') ) {
        toggleBoard('.boardGroup')
    }
    responseEventPopup()
})

function slidePopup( slideObject ){
    const $slideObject = $(slideObject)
    const $slideList = $slideObject.find('.slide-list')
    const $controller = $slideObject.find('.controller')
    const $buttonPrev = $controller.find('.prev')
    const $buttonNext = $controller.find('.next')
    const $buttonCtrl = $controller.find('.slideControl')
    const $count = $controller.find('.count')
    const $total = $count.find('.total')
    const $current = $count.find('.current')

    const $eventPopupObject = $('.event')
    $slideList.slick({
        infinite: true,
        speed: 300,
        slidesToShow: 2,
        slidesToScroll: 1,
        autoplay: true,
        arrows: true,
        prevArrow: $buttonPrev,
        nextArrow: $buttonNext,
        responsive: [
            {
                breakpoint: 1490,
                settings: {
                    slidesToShow: 1
                }
            },
            {
                breakpoint: 820,
                settings: {
                    slidesToShow: 2
                }
            },
            {
                breakpoint: 640,
                settings: {
                    slidesToShow: 1
                }
            }
        ]
    })

    const formatNumber = (num) => String(num).padStart(2, '0')
    $total.text(formatNumber($slideList.slick('getSlick').slideCount))
    $slideList.on('afterChange', function(event, slick, currentSlide) {
        $current.text(formatNumber(currentSlide + 1))
    })
    $current.text(formatNumber(1))

    $buttonCtrl.on('click', function() {
        if ($slideList.slick('slickGetOption', 'autoplay')) {
            $slideList.slick('slickPause')
            $slideList.slick('slickSetOption', 'autoplay', false, true)
            $(this).removeClass('ctrlStop').addClass('ctrlPlay')
        } else {
            $slideList.slick('slickSetOption', 'autoplay', true, true)
            $slideList.slick('slickPlay')
            $(this).removeClass('ctrlPlay').addClass('ctrlStop')
        }
    })
}
function handleSelectMap(){
    const selectAllArea = document.querySelector('select[data-select="all-area"]')
    const selectDetailArea = document.querySelector('select[data-select="detail-area"]')
    const mapSvgs = Array.from(document.querySelectorAll('svg[data-map-value]'))
    const detailSvgs = Array.from(document.querySelectorAll('.detail-map svg[data-detailMap-value]'))
    const getDetailCode = (el) => el.getAttribute('data-detailMap-value') || el.dataset.detailMapValue || el.dataset.detailmapValue

/*    const getGuFromDongCode = (dongCode) => dongCode.slice(0, 3)
    const guToDetailClass = (gu) => 'dm'*/

    const DONG_MAP = {
        CWGU: [
            { value: 'CWGU02', label: '오창읍' },
            { value: 'CWGU03', label: '북이면' },
            { value: 'CWGU01', label: '내수읍' },
            { value: 'CWGU08', label: '오근장동' },
            { value: 'CWGU07', label: '율량, 사천동' },
            { value: 'CWGU05', label: '내덕1동' },
            { value: 'CWGU06', label: '내덕2동' },
            { value: 'CWGU04', label: '우암동' },
        ],
        HDGU: [
            { value: 'HDGU03', label: '옥산면' },
            { value: 'HDGU11', label: '강서2동' },
            { value: 'HDGU09', label: '봉명2, 송절동' },
            { value: 'HDGU04', label: '운천, 신봉동' },
            { value: 'HDGU08', label: '봉명1동' },
            { value: 'HDGU01', label: '오송읍' },
            { value: 'HDGU02', label: '강내면' },
            { value: 'HDGU10', label: '강서1동' },
            { value: 'HDGU05', label: '복대1동' },
            { value: 'HDGU06', label: '복대2동' },
            { value: 'HDGU07', label: '가경동' }
        ],
        SDGU: [
            { value: 'SDGU02', label: '미원면' },
            { value: 'SDGU01', label: '낭성면' },
            { value: 'SDGU11', label: '용암,명암,산성동' },
            { value: 'SDGU06', label: '중앙동' },
            { value: 'SDGU08', label: '탑, 대성동' },
            { value: 'SDGU07', label: '성안동' },
            { value: 'SDGU10', label: '금천동' },
            { value: 'SDGU09', label: '영운동' },
            { value: 'SDGU12', label: '용암1동' },
            { value: 'SDGU13', label: '용암2동' },
            { value: 'SDGU04', label: '남일면' },
            { value: 'SDGU03', label: '가덕면' },
            { value: 'SDGU05', label: '문의면' }
        ],
        SWGU: [
            { value: 'SWGU03', label: '사직1동' },
            { value: 'SWGU05', label: '사창동' },
            { value: 'SWGU04', label: '사직2동' },
            { value: 'SWGU06', label: '모충동' },
            { value: 'SWGU11', label: '성화, 개신, 죽림동' },
            { value: 'SWGU10', label: '수곡2동' },
            { value: 'SWGU09', label: '수곡1동' },
            { value: 'SWGU07', label: '산남동' },
            { value: 'SWGU08', label: '분평동' },
            { value: 'SWGU01', label: '남이면' },
            { value: 'SWGU02', label: '현도면' }
        ]
    }
    function clearSelection(){
        mapSvgs.forEach(mapSvg => {
            mapSvg.classList.remove('is-selected')
            const a = mapSvg.querySelector('a')
            if (a) a.removeAttribute('aria-current')
        })
    }
    function clearDetailSelection() {
        detailSvgs.forEach(svg => {
            svg.classList.remove('is-selected')
            const a = svg.querySelector('a')
            if (a) a.removeAttribute('aria-current')
        })
    }
    function selectDistrict(code) {
        clearSelection()
        clearDetailSelection()
        const target = mapSvgs.find(mapSvg => mapSvg.dataset.mapValue === code)
        if (target) {
            target.classList.add('is-selected')
            const a = target.querySelector('a')
            if (a) a.setAttribute('aria-current', 'true')
        }
    }
    function selectDong(dongCode) {
        clearDetailSelection()
        const target = detailSvgs.find(svg => getDetailCode(svg) === dongCode)
        if (target) {
            target.classList.add('is-selected')
            const a = target.querySelector('a')
            if (a) a.setAttribute('aria-current', 'true')
        }
    }
    function resetDong() {
        selectDetailArea.innerHTML = '<option value="">읍/면/동 선택</option>'
    }
    function populateDong(guCode) {
        resetDong();
        const list = DONG_MAP[guCode]
        if (!list) return
        const frag = document.createDocumentFragment()
        list.forEach(({ value, label }) => {
            const opt = document.createElement('option')
            opt.value = value
            opt.textContent = label
            frag.appendChild(opt)
        })
        selectDetailArea.appendChild(frag)
    }
    selectAllArea.addEventListener('change', () => {
        const code = selectAllArea.value
        if (!code || code === '구 선택') {
            clearSelection()
            resetDong()
            clearDetailSelection()
            return
        }
        selectDistrict(code)
        populateDong(code)
    })
    selectDetailArea.addEventListener('change', () => {
        const dongCode = selectDetailArea.value
        if(!dongCode || dongCode === '읍/면/동 선택') {
            clearDetailSelection()
            return
        }
        selectDong(dongCode)
    })
    mapSvgs.forEach(mapSvg => {
        mapSvg.addEventListener('click', (e) => {
            const carrier = e.target.closest('[data-map-value]')
            const code = carrier?.dataset?.mapValue || svg.dataset.mapValue
            if (!code) return
            selectDistrict(code)
            if (selectAllArea.value !== code) {
                selectAllArea.value = code
            }
            populateDong(code)
            if (carrier && carrier.tagName.toLowerCase() === 'a') e.preventDefault()
        })
    })
    detailSvgs.forEach(svg => {
        svg.addEventListener('click', (e) => {
            const code = getDetailCode(svg)
            if (!code) return
            selectDetailArea.value = code
            selectDong(code)
            if (e.target.tagName.toLowerCase() === 'a') e.preventDefault()
        })
    })
    if (!selectAllArea.value || selectAllArea.value === '구 선택') {
        clearSelection()
        resetDong()
        clearDetailSelection()
    } else {
        selectDistrict(selectAllArea.value)
        populateDong(selectAllArea.value)
    }
    if (selectDetailArea.value && selectDetailArea.value !== '읍/면/동 선택') {
        selectDong(selectDetailArea.value)
    }
    document.querySelector('.initialSelect').addEventListener('click', () => {
        selectAllArea.value=''// value와 일치하는 값으로 넣어줌.
        selectDetailArea.value='읍/면/동 선택'
        resetDong()
        clearSelection()
        clearDetailSelection()
    })
}
function applyProgramFilter() {
    const selected = [...selectedCate1, ...selectedCate2]
    destroyProgramSlide('.reservationList')

    const $list = $('.reserve-item-list')
    $list.empty()

    originalSlides.each(function() {
        const raw = $(this).data('filter-keyword') || "";
        const keywords = raw.split(' ');

        if (selected.length === 0 || selected.some(k => keywords.includes(k))) {
            $list.append($(this).clone());
        }
    });

    // slick 재초기화
    slideProgram('.reservationList');
}
function slideProgram( slideObject ){
    const $slideObject = $(slideObject)
    const $slideList = $slideObject.find('.reserve-item-list')
    const $controller = $slideObject.find('.controller')
    const $buttonPrev = $controller.find('.prev')
    const $buttonNext = $controller.find('.next')

    const visibleCount = $('.reserve-item-list .slide-item:visible').length
    $slideList.slick({
        infinite: false,
        speed: 300,
        slidesToShow: Math.min(4, visibleCount),
        slidesToScroll: Math.min(4, visibleCount),
        autoplay: false,
        arrows: true,
        prevArrow: $buttonPrev,
        nextArrow: $buttonNext,
        responsive: [
            {
                breakpoint: 1200,
                settings: {
                    slidesToShow: Math.min(3, visibleCount),
                    slidesToScroll: Math.min(3, visibleCount)
                }
            },
            {
                breakpoint: 720,
                settings: {
                    slidesToShow: Math.min(2, visibleCount),
                    slidesToScroll: Math.min(2, visibleCount)
                }
            },
            {
                breakpoint: 500,
                settings: {
                    slidesToShow: Math.min(1, visibleCount),
                    slidesToScroll: Math.min(1, visibleCount),
                }
            },
            {
                breakpoint: 360,
                settings: {
                    slidesToShow: Math.min(1, visibleCount),
                    slidesToScroll: Math.min(1, visibleCount),
                    centerMode: true,
                    centerPadding: '15px'
                }
            }
        ]
    })
}
function destroyProgramSlide(slideObject){
    const $slideList = $(slideObject).find('.reserve-item-list')
    if ($slideList.hasClass('slick-initialized')) {
        $slideList.slick('unslick')
        $slideList.find('.slick-slide').removeAttr('style')
        $slideList.find('.slick-track').children().unwrap()
        $slideList.find('.slick-list').children().unwrap()
    }
}
function toggleBoard( toggleObject ){
    const $toggleObject = $(toggleObject)
    const $toggleButton = $toggleObject.find('.tab-button')

    $toggleButton.on('click', function(){
        $toggleObject.find('.current').removeClass('current')
        $(this).addClass('current')
    })
}
function responseEventPopup() {
    const $eventPopupObject = $('.event')
}