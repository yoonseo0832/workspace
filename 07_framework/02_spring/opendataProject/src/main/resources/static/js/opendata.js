// 모든 요소가 로드되었을 때
onload =() => {
	// 아이디 속성이 btn1인 요소가 클릭되었을 때 (이벤트 핸들러)
	document.getElementById("btn1").addEventListener("click", () => {
		// (함수 호출중)
		getAirPollution();
	});
	
	getAirPollutionV2();
}

// 대기 어렴 정보 조회(+ 페이지 정보 포함, 매개변수 위치에 1로 초기화)
const getAirPollutionV2 = async (page = 1) => {
	// [GET] /airPolution/v2?location=지역정보&currPage=페이지번호
	const location = document.getElementById("location").value;
	
	// 대기 오염 정보 요청 => 비동기 요청*(fetch)
	try{const response = await fetch("/airPollution/v2?location="+ location +"&currPage=" + page )
	const data = await response.json();
	console.log(data);
	
	// 조회 결과를 화면에 표시
	displayAirPollutionData(data.items);
	
	// 페이징바 변경
	displayPagination(data.totalCount, data.pageNo, data.numOfRows);
	}catch(error){
		console.log(error);
	}
}
// 대기오염 정보 조회
const getAirPollution = () => {
	// [GET] /airPollution?location=선택된 지역정보
	
	// 요청 전 작업 -> 선택된 지역 정보 값을 가져와야 함
	const location = document.getElementById("location").value;
	// alert(location);
	
	// 지역 정보를 담아 조회 요청 => 비동기 요청(fetch 함수(function))
	fetch("/airPollution?location="+ location ) 
	.then(response=>response.json())
	// response.text   => 문자열, 숫자.. 응답 데이터 추출
	// response.json() => 객체 형태로 응답 데이터 추출
	// => .then((response) => {return response.json(); }) (위의 코드와 동일함 생략된 것)
	.then(data=>{
		// 응답 결과 확인
		//console.log(data);
		
		displayAirPollutionData(data);
		
	})
	.catch(error=>{
		// 오류 내용 확인
		console.log(error);
	});
}

const displayAirPollutionData = (data) => {
	//전달된 데이터가 배열인지 확인
	//console.log("data::"+data);
	if(!Array.isArray(data)){
		console.log("data is not array");
		//console.error("data is not array");
	}
	// tbody 요소에 접근
	const target = document.querySelector("#air-list tbody");
	
	//전달된 데이터를 활용해 tr 요소 생성
	let tbodyData = "";
	/*
	for(const item of data){
		tbodyData +="<tr>"
					+ "<td>" +item.stationName+ "</td>"
					+ "<td>" +item['dataTime'] + "</td>"
					+ "<td>" +item.khaiValue+ "</td>"
					
					+ "<td>" +item.pm10Value+ "</td>"
					+ "<td>" +item.coValue+ "</td>"
					+ "<td>" +item.no2Value+ "</td>"
					+ "<td>" +item.so2Value+ "</td>"
					+ "<td>" +item.o3Value+ "</td>"
					+"</tr>" 
	})*/
	//target.innerHTML = tbodyData;
	
		for(const item of data){
			const trEle = document.createElement("tr");
						
					const tdEle1 = document.createElement("td");
					tdEle1.textContent = `${item.stationName}`;
					const tdEle2 = document.createElement("td");
					tdEle2.textContent = `${item['dataTime']}`;
					const tdEle3 = document.createElement("td");
					tdEle3.textContent = `${item.khaiValue}`;
						
					const tdEle4 = document.createElement("td");
					tdEle4.textContent = `${item.pm10Value}`;
					const tdEle5 = document.createElement("td");
					tdEle5.textContent = `${item.coValue}`;
					const tdEle6 = document.createElement("td");
					tdEle6.textContent = `${item.no2Value}`;
					const tdEle7 = document.createElement("td");
					tdEle7.textContent = `${item.so2Value}`;
					const tdEle8 = document.createElement("td");
					tdEle8.textContent = `${item.o3Value}`;
					//tdEle2, tdEle3, tdEle4, tdEle5, tdEle6, tdEle7, tdEle8
					trEle.appendChild(tdEle1);
					trEle.appendChild(tdEle2);
					trEle.appendChild(tdEle3);
					trEle.appendChild(tdEle4);
					trEle.appendChild(tdEle5);
					trEle.appendChild(tdEle6);
					trEle.appendChild(tdEle7);
					trEle.appendChild(tdEle8);
					
					target.appendChild(trEle);
		}
		
		
}
/**
 * totalCount ; 전체 개수
 * pageNo : 현재 페이지 번호
 * numOfRows : 페이지 당 개수
 */
const displayPagination = (totalCount, pageNo, numOfRows) => {
	// 전체 페이지 수(101개수 면 페이지 수 11 개 를 위해 올림처리)
	const totalPage = Math.ceil(totalCount / numOfRows);displayAirPollutionData
	
	// 페이징바 요소 접근
	const paginationArea = document.getElementById("pagination-area");
	
	let pageItems = "";
	// 이전 버튼 부분
	pageItems += `<li class="page-item ${pageNo === 1 ? "disabled": ""}">
					<a class="page-link"href="#" onclick="getAirPollutionV2(${pageNo-1})">Prevoius</a>
				  </li>`;

	// 페이지 번호 부분
	for(let i=1; i<=totalPage; i++){
		pageItems += `<li class="page-item ${pageNo === i ? "active" : ""} ">
						<a class="page-link" href="#" onclick="getAirPollutionV2(${i})">${i}</a>
					  </li>`;
	}

	/*
	<li class="page-item"><a class="page-link" href="#">1</a></li>
	<li class="page-item"><a class="page-link" href="#">2</a></li>
	<li class="page-item"><a class="page-link" href="#">3</a></li>
	*/
	// 다음 버튼 부분
	pageItems += `<li class="page-item ${pageNo === totalPage ? "disabled": ""}">
				  <a class="page-link" href="#" onclick="getAirPollutionV2(${pageNo+1})"}>Next</a>
				  </li>`;
	//paginationArea.innerHTML = pageItems;
	
	const liPrev = document.createElement("li");
	liPrev.classList.add("page-item");
	if (pageNo === 1) liPrev.classList.add("disabled");	
	//liPrev.textContent = `class="page-item ${pageNo === totalPage ? "disabled": ""}"`;
	const aPrev = document.createElement("a");
	//aPrev.textContent = `class="page-link" href="#" onclick="getAirPollutionV2(${pageNo+1})"}`;
	aPrev.classList.add("page-link");
	aPrev.setAttribute("href", "#");
	aPrev.addEventListener("click", ()=>{getAirPollutionV2(pageNo-1)});
	aPrev.textContent = "Previous";
	
	liPrev.appendChild(aPrev);
	
	
}