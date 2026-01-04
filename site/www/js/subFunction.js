//let calendarMobileInited = false

document.addEventListener("DOMContentLoaded", () => {
    if (document.querySelector('.contentNavigation')) {
        contentNavigation()
    }
    simpleToggleClass('.contentShare')
    if (document.querySelector('.pagination-searchResult')) {
        searchPagination('.pagination-searchResult')
    }
    /*if (document.querySelector('.pagination-default')) {
        searchPagination('.pagination-default')
    }*/
    if (document.querySelector('.programSearch')) {
        searchFunction()
    }
    if (document.querySelector('.asideInformation')) {
        listView()
    }
    if (document.querySelector('[data-toggle-button]')) {
        handleClassToggle('[data-toggle-button]')
    }
    if (document.querySelector('[data-modal-button]')) {
        handleModal()
    }
    if (document.querySelector('.viewProgram.simpleInformation')) {
        programViewImageSlide()
    }
    if (document.querySelector('.tab-eventList')) {
        filterEventList()
    }

    /*if (!document.querySelector('.programCalendar')) return
    handleCalendarResponsive()
    window.addEventListener('resize', handleCalendarResponsive)*/
})

function contentNavigation() {
    const contentNavigation = document.querySelector('.contentNavigation');
    const navigationButton = contentNavigation.querySelectorAll('button');

    navigationButton.forEach(item => {
        item.addEventListener('click', () => {
            const parentLi = item.closest('li');
            const isActive = item.classList.contains('active');

            // 이미 active 인 상태라면 → 해제하고 종료
            if (isActive) {
                item.classList.remove('active');
                parentLi.classList.remove('active');
                return;
            }

            // 기존 active 전체 제거
            contentNavigation.querySelectorAll('.active').forEach(el => {
                el.classList.remove('active');
            });

            // 클릭된 버튼 + 부모 li active
            item.classList.add('active');
            parentLi.classList.add('active');
        });
    });
}

function simpleToggleClass( tgButton ) {
    const button = document.querySelector(tgButton);

    if (!button) return;

    button.addEventListener('click', () => {
        if (button.classList.contains('active')) {
            button.classList.remove('active');
        } else {
            button.classList.add('active');
        }
    });
}

function searchPagination( pagination ) {
    const searchPagination = document.querySelector(pagination);
    const currentPage = searchPagination.querySelector('.current');

    currentPage.addEventListener('click', (e) => {
        e.preventDefault();
        if (window.innerWidth <= 600) {
            if( !e.target.classList.contains('active') ) {
                searchPagination.classList.add('active');
                e.target.classList.add('active');
            } else {
                searchPagination.classList.remove('active');
                e.target.classList.remove('active');
            }
        }
    })
}

function searchFunction() {
    const searchDetailButton = document.querySelector('.detailCloseButton')
    const searchBox = document.querySelector('.programSearch')

    searchDetailButton.addEventListener('click', (e) => {
        if( !e.currentTarget.classList.contains('open') ) {
            e.currentTarget.classList.add('open');
            searchBox.classList.add('showDetail');
        } else {
            e.currentTarget.classList.remove('open');
            searchBox.classList.remove('showDetail');
        }
    })
}

function listView() {
    const typeButton = document.querySelectorAll('.asideInformation button')
    const typeList = document.querySelectorAll('.listWrap')
    typeButton.forEach( item => {
        item.addEventListener('click', (e) => {
            const target = e.currentTarget
            const viewType = target.dataset.listView

            typeButton.forEach(btn => btn.classList.remove('active'))
            target.classList.add('active')
            typeList.forEach(list => list.classList.remove('show'))
            typeList.forEach(list => {
                if (list.classList.contains(viewType)) {
                    list.classList.add('show')
                }
            })
        })
    })
}

function handleClassToggle( button ) {
    const handleButtons = document.querySelectorAll(button)

    handleButtons.forEach( button => {
        button.addEventListener('click', (e) => {
            const target = e.currentTarget
            if( !target.classList.contains('active') ) {
                target.classList.add('active')
            } else {
                target.classList.remove('active')
            }
        })
    })
}

function handleModal() {
    const modalButtons = document.querySelectorAll('[data-modal-button]')
    const body = document.querySelector('body')
    const modalCloseButtons = document.querySelectorAll('.modalCloseButton, [data-modal-close]')

    modalButtons.forEach( button => {
        button.addEventListener('click', (e) => {
            const target = e.currentTarget
            const modalKey = target.dataset.modalButton
            const modalLayer = document.querySelector(`[data-modal-layer="${modalKey}"]`)
            if( !modalLayer.classList.contains('show') ) {
                modalLayer.classList.add('show')
            }
            if( !body.classList.contains('modalShow') ) {
                body.classList.add('modalShow')
            }
        })
    })
    modalCloseButtons.forEach( button => {
        button.addEventListener('click', (e) => {
            const target = e.currentTarget
            if( target.closest('.programModal').classList.contains('show') ) {
                target.closest('.programModal').classList.remove('show')
            }
            if( body.classList.contains('modalShow') ) {
                body.classList.remove('modalShow')
            }
        })
    })
}

function programViewImageSlide() {
    const $viewPageWrap = $('.viewProgram.simpleInformation')
    const $slideWrap = $viewPageWrap.find('.imageSlide')
    const $slideList = $slideWrap.find('.slideList')
    const $controllerWrap = $slideWrap.find('.controller')
    const $count = $controllerWrap.find('.count')
    const $countTotal = $count.find('.total')
    const $countCurrent = $count.find('.current')
    const $buttonPrev = $controllerWrap.find('.prev')
    const $buttonNext = $controllerWrap.find('.next')

    $slideList.slick({
        infinite: false,
        autoplay: false,
        slidesToShow: 1,
        slidesToScroll: 1,
        arrows: true,
        prevArrow: $buttonPrev,
        nextArrow: $buttonNext
    })

    const formatNumber = (num) => String(num)
    $countTotal.text(formatNumber($slideList.slick('getSlick').slideCount))
    $slideList.on('afterChange', function(event, slick, currentSlide) {
        $countCurrent.text(formatNumber(currentSlide + 1))
    })
    $countCurrent.text(formatNumber(1))
}

function filterEventList() {
    const filterTabButtonWrap = document.querySelector('.tab-eventList')
    const filterTabButtons = filterTabButtonWrap.querySelectorAll('button')
    const filterList = document.querySelector('.eventList')
    const filterListItems = filterList.querySelectorAll('[data-filter-type]')

    filterTabButtons.forEach( button => {
        button.addEventListener('click', (e) => {
            const target = e.currentTarget
            const filterKey = target.dataset.filterType

            filterTabButtons.forEach((btn) => btn.classList.remove('current'))
            target.classList.add('current')

            filterListItems.forEach((item) => {
                const itemType = item.dataset.filterType

                if (filterKey === 'all' || itemType === filterKey){
                    item.style.display = 'block'
                } else {
                    item.style.display = 'none'
                }
            })
        })
    })
}

let handleTouchStart = null
let handleTouchEnd = null
let handlePointerDown = null
let handlePointerUp = null
let handleCalendarResize = null

function handleCalendarResponsive() {
    if (!document.querySelector('.programCalendar')) return

    const isMobile = window.innerWidth <= 640

    if (isMobile) {
        if (!calendarMobileInited) {
            calendarMobileInit()
        }
    } else {
        if (calendarMobileInited) {
            calendarMobileDestroy()
        }
    }
}
function calendarMobileInit() {
    if (calendarMobileInited) return
    calendarMobileInited = true

    const calendarContainer = document.querySelector('.calendar')
    //const calendarHeader = calendarContainer.querySelector('.calendarHeader')
    const calendarBody = calendarContainer.querySelector('.calendarBody')
    const calendarWeek = calendarBody.querySelector('.weekly')
    const calendarWeekElement = calendarWeek.querySelector('[data-weekly-element]')
    const scrollWrap = calendarBody.querySelector('.scrollWrap-day')
    const calendarDay = calendarBody.querySelector('.day')
    const calendarDayElements = calendarDay.querySelectorAll('[data-day-element]')

    const DAYS_PER_WEEK = 7
    const totalWeeks = Math.ceil(calendarDayElements.length / DAYS_PER_WEEK)

    let currentWeek = 0
    let moveSize = calendarWeek.getBoundingClientRect().width
    let startX = 0
    let pointerDown = false
    let isScrolling = false

    const SWIPE_MIN = 30

    calendarDay.style.touchAction = 'pan-y'

    function updateSize() {
        moveSize = calendarWeek.getBoundingClientRect().width
        updatePosition()
    }
    function updatePosition() {
        const x = -currentWeek * moveSize
        calendarDay.style.transform = `translateX(${x}px)`
        updateEdgeState()
    }
    function goWeek(direction) {
        if (isScrolling) return

        const next = currentWeek + direction

        if (next < 0 || next > totalWeeks - 1) return

        isScrolling = true
        currentWeek = next

        updatePosition()
        /*if (currentWeek < 0) currentWeek = 0
        if (currentWeek > totalWeeks - 1) currentWeek = totalWeeks - 1*/

        setTimeout(() => {
            isScrolling = false
        }, 400)
    }
    function swipeStart(clientX) {
        if (isScrolling) return
        pointerDown = true
        startX = clientX
    }
    function swipeEnd(clientX) {
        if (!pointerDown || isScrolling) return
        pointerDown = false

        const diffX = clientX - startX

        if (Math.abs(diffX) < SWIPE_MIN) return
        if (diffX < 0) {
            goWeek(+1)
        } else {
            goWeek(-1)
        }
    }
    function updateEdgeState() {
        scrollWrap.classList.remove('is-start', 'is-middle', 'is-end')

        if (totalWeeks <= 1) return

        if (currentWeek === 0) {
            scrollWrap.classList.add('is-start')
        } else if (currentWeek === totalWeeks - 1) {
            scrollWrap.classList.add('is-end')
        } else {
            scrollWrap.classList.add('is-middle')
        }
    }
    const isTouchDevice = ('ontouchstart' in window) || (navigator.maxTouchPoints && navigator.maxTouchPoints > 0)

    if (isTouchDevice) {
        handleTouchStart = (e) =>  {
            if (!e.touches || !e.touches[0]) return
            swipeStart(e.touches[0].clientX)
        }
        handleTouchEnd = (e) => {
            if (!e.changedTouches || !e.changedTouches[0]) return
            swipeEnd(e.changedTouches[0].clientX)
        }
        calendarDay.addEventListener('touchstart', handleTouchStart,{ passive: true })
        calendarDay.addEventListener('touchend', handleTouchEnd)
    } else {
        handlePointerDown = (e) => {
            swipeStart(e.clientX)
        }
        handlePointerUp = (e) => {
            swipeEnd(e.clientX)
        }
        calendarDay.addEventListener('pointerdown', handlePointerDown)
        calendarDay.addEventListener('pointerup', handlePointerUp)
    }
    handleCalendarResize = () => {
        if (window.innerWidth <= 640) {
            updateSize()
        }
    }
    window.addEventListener('resize', handleCalendarResize)
    updatePosition()
}
function calendarMobileDestroy() {
    calendarMobileInited = false

    const calendarContainer = document.querySelector('.calendar')
    const calendarBody = calendarContainer.querySelector('.calendarBody')
    const scrollWrap = calendarBody.querySelector('.scrollWrap-day')
    const calendarDay = calendarBody.querySelector('.day')

    if (!calendarContainer) return

    calendarDay.style.transform = ''
    scrollWrap.classList.remove('is-start', 'is-middle', 'is-end')

    const isTouchDevice = ('ontouchstart' in window) || (navigator.maxTouchPoints && navigator.maxTouchPoints > 0)

    if (isTouchDevice) {
        if (handleTouchStart) {
            calendarDay.removeEventListener('touchstart', handleTouchStart)
        }
        if (handleTouchEnd) {
            calendarDay.removeEventListener('touchend', handleTouchEnd)
        }
    } else {
        if (handlePointerDown) {
            calendarDay.removeEventListener('pointerdown', handlePointerDown)
        }
        if (handlePointerUp) {
            calendarDay.removeEventListener('pointerup', handlePointerUp)
        }
    }
    if (handleCalendarResize) {
        window.removeEventListener('resize', handleCalendarResize)
    }
    handleTouchStart = null
    handleTouchEnd = null
    handlePointerDown = null
    handlePointerUp = null
    handleCalendarResize = null
}