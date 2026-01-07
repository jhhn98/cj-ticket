
function fn_searchMainSubmit(obj) {
	var categoryVal = $('input[name="CATEGORY_KEY"]:checked').val();
	
	if( !categoryVal ) {
		alert("분류 선택(Step2) 항목을 선택해 주세요");
		return false;
	}
	
	/*if( !$('input[name="searchOperSttus"]').is(':checked') ) {
		alert("예약상태 선택값을 선택해 주세요");
		return false;
	}*/
	
	var actionUrl = "";
	var searchKey = "";
	switch( categoryVal ) {
		case 'EXPRN': actionUrl = '/www/selectExprnWebList.do'; searchKey='8'; break;
		case 'FCLTY': actionUrl = '/www/selectFcltyWebList.do'; searchKey='14'; break;
		case 'EDU': actionUrl = '/www/selectEduLctreWebList.do'; searchKey='19'; break;
    }
	
	$('#searchKey').val(searchKey);
	$(obj).attr('action', actionUrl);
	
	return true;
}

$(document).ready(function() {    
    loadResveCnt();
	loadResveList();
});

$(document).on('change', '#searchAreaGu, #searchAreaEmd', function() {
	loadResveCnt();
});

$(document).on('click', 'a[aria-label]', function() {
	loadResveCnt();
});

function loadResveCnt() {
    $.ajax({
        url: '/www/selectResveTotCntJson.do',
        type: 'POST',
        data: $('#searchMainForm').serialize(),
        dataType: 'json',
        beforeSend: function() {
            //$('em.count i').text('...');
        },
        success: function(response) {
			const eduCnt = response['EDU'];
			const exprnCnt = response['EXPRN'];
			const fcltyCnt = response['FCLTY'];
			
			$('.category1 em.count i').text(exprnCnt);	// 관광·체험
            $('.category2 em.count i').text(fcltyCnt.toLocaleString());	// 시설예약
            $('.category3 em.count i').text(eduCnt.toLocaleString());	// 교육·강좌
			
			var areaGuTxt = $('#searchAreaGu option:selected').text();
			var areaEmdTxt = $('#searchAreaEmd option:selected').text();
			var searchTxt = "지역과 분류를 선택해주세요.";
			
			if( areaGuTxt != "구 선택" ) {
				searchTxt = areaGuTxt+"의 프로그램을 검색합니다.";
				if( areaEmdTxt != "읍/면/동 선택" ) searchTxt = areaGuTxt+" "+areaEmdTxt+"의 프로그램을 검색합니다.";
			}
			
			$('#searchTxt').text(searchTxt);
        },
        error: function() {
			console.log("Get loadResveCnt Error !!");
            //$('em.count i').text('에러');
        }
    });
}

$(document).on('click', '.cateDiv button[data-filter-keyword]', function() {
	loadResveList();
});

function loadResveList() {

	var targetValue = $('.cateDiv')
					.find('button.selected')
			        .map(function() {
						return $(this).data('target-value');
			        })
					.get();
	
	var resveValue = $('.cateDiv')
					.find('button.selected')
			        .map(function() {
						return $(this).data('resve-value');
			        })
					.get();

	$.ajax({
		url: '/www/selectResveMainListJson.do',
		type: 'POST',
		data: {'targetValue': targetValue.join(','),'resveValue': resveValue.join(',')},
		dataType: 'json',
		success: function(response) {
			resveItems(response);  // 템플릿 렌더링
			loadResveCnt();  // 카운트 갱신
		},
        error: function(xhr, status, error) {
            console.error('AJAX 에러:', error);
        }
	});
}

function resveItems(dataList) {
    const $container = $('.reserve-item-list');

	if ($container.hasClass('slick-initialized')) {
        $container.slick('unslick');
    }
	$container.empty();
	let strValue = [];

    dataList.forEach(function(item, index) {
		if( index < 8 ) {
			const methodMap = {
				'FIRST': { text: '선착순', classNm: 'first-come' },
				'DRWLT':  { text: '추첨', classNm: 'lottery' },
				'CONFM':  { text: '승인', classNm: 'waiting' }
			};

			item.slctMthdCdText = methodMap[item.slctMthdCd]?.text || item.slctMthdCd || '';
			item.slctMthdCdClass = methodMap[item.slctMthdCd]?.classNm || '';

			const sttusMap = {
				'RCPT_ING': { text: '접수중', classNm: 'apcType1' },
				'RCPT_WAIT':  { text: '접수대기', classNm: 'apcType2' },
				'RCPT_END':  { text: '접수마감', classNm: 'apcType3' },
				'ADD_ING':  { text: '추가모집', classNm: 'apcType4' },
				'WAIT_ING':  { text: '대기자접수', classNm: 'apcType5' },
				'OPER_CNCL':  { text: '폐강', classNm: 'apcType6' },
				'OPER_ING':  { text: '운영중', classNm: 'apcType7' },
				'OPER_END':  { text: '종료', classNm: 'apcType8' }
			};

			item.sttusText = sttusMap[item.rceptSttus]?.text || item.rceptSttus || '';
			item.sttusClass = sttusMap[item.rceptSttus]?.classNm || '';

			const resveLinkMap = {
				'EDU': { url: './selectEduLctreWebView.do?key=19&lctreNo='},
				'EXPRN':  { url: './selectExprnWebView.do?key=8&exprnNo='},
				'FCLTY':  { url: './selectFcltyWebView.do?key=14&fcltyNo='}
			};

			item.linkUrlText = resveLinkMap[item.resveSe]?.url || item.resveSe || '';
			item.linkTarget = '';
			if (item.resveSe === 'EXPRN' && item.aditIem1 === 'LINK_URL') {
				item.linkUrlText = item.aditIem2;
				item.resveNo = '';
				item.linkTarget = ' target="_blank"';
			}

			const targetMap = {
				'TARGET01': '#영유아', 'TARGET02': '#아동', 'TARGET03': '#초등학생', 'TARGET04': '#청소년', 'TARGET05': '#성인', 'TARGET06': '#어르신', 'TARGET07': '#장애인', 'TARGET08': '#기타'
			};

			item.targetCdText = (item.targetCd || '').split('|').map(code => code.trim()).filter(code => targetMap[code]).map(code => targetMap[code]).join('') || '';

			// 예약상태별 색상
			let gradientColors = '';
			if (item.sttusClass === 'apcType1' || item.sttusClass === 'apcType4' || item.sttusClass === 'apcType5' || item.sttusClass === 'apcType7') {
				// 접수중, 추가모집, 대기자접수, 운영중
				gradientColors = '<stop offset="0%" stop-color="#e33d83"/><stop offset="100%" stop-color="#ff7f73"/>';
			} else if (item.sttusClass === 'apcType2') {
				// 접수대기
				gradientColors = '<stop offset="0%" stop-color="#bac8e0"/><stop offset="100%" stop-color="#93a5cf"/>';
			} else if (item.sttusClass === 'apcType3' || item.sttusClass === 'apcType6' || item.sttusClass === 'apcType8') {
				// 접수마감, 폐강, 종료
				gradientColors = '<stop offset="0%" stop-color="#e1e1e1"/><stop offset="100%" stop-color="#868686"/>';
			}

			const html = `
				<div class="slide-item" data-filter-keyword="${item.sttusText}">
					<a href="${item.linkUrlText}${item.resveNo}"${item.linkTarget}>
						<i class="state ${item.sttusClass}">
							<svg>
								<defs>
									<linearGradient id="grad-shared${index}" x1="0%" y1="0%" x2="100%" y2="0%">
										${gradientColors}
									</linearGradient>
								</defs>
								<use href="/site/www/images/main/sprite-main.svg#icon-chip" fill="url(#grad-shared${index})"></use>
							</svg>
							<span>${item.sttusText}</span>
						</i>
						<span class="keyword">
							<i class="price">₩ ${item.pchrgAt==='Y' ? '유료' : '무료'}</i>
							<i class="draw">${item.slctMthdCdText}</i>
						</span>
						<strong class="title">${item.resveNm}</strong>
						<span class="info location">
							<svg><use href="/site/www/images/main/sprite-main.svg#icon-location"></use></svg>
							<em>기관</em> ${item.insttNm}
						</span>
						<span class="info calendar">
							<svg><use href="/site/www/images/main/sprite-main.svg#icon-calendar"></use></svg>
							<em>접수</em> ${item.rceptBgn.replace(/(\d{4})(\d{2})(\d{2}).*/, '$1.$2.$3')}~${item.rceptEnd.replace(/(\d{4})(\d{2})(\d{2}).*/, '$1.$2.$3')}
						</span>
						<span class="filter">${item.targetCdText}</span>
					</a>
				</div>
			`;
			strValue.push(html);
		}
    });

	$container.append(strValue.join(''));

	slideProgram('.reservationList')
}

function slideProgram( slideObject ){
	const $slideObject = $(slideObject)
	console.log($slideObject)
	const $slideList = $slideObject.find('.reserve-item-list')
	console.log($slideList)
	const $controller = $slideObject.find('.controller')
	const $buttonPrev = $controller.find('.prev')
	const $buttonNext = $controller.find('.next')

	if ($slideList.hasClass('slick-initialized')) {
		$slideList.slick('unslick');
	}

	const visibleCount = $('.reserve-item-list .slide-item:visible').length

	if (visibleCount === 0) {
		console.warn('No visible slide items, slick not initialized');
		return;
	}

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