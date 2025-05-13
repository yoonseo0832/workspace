// 모든 요소가 로드되었을 때
onload =() => {
	// 아이디 속성이 btn1인 요소가 클릭되었을 때 (이벤트 핸들러)
	document.getElementById("btn1").addEventListener("click", () => {
		// (함수 호출중)
		getAirPollution();
	})
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
		console.log(data);
		const table = document.getElementsByTagName("table tr");			
		const newRow = table.insertRow();
		
		const cell1 = newRow.insertCell(0);
		const cell2 = newRow.insertCell(1);
		const cell3 = newRow.insertCell(2);
		const cell4 = newRow.insertCell(3);
		const cell5 = newRow.insertCell(4);
		const cell6 = newRow.insertCell(5);
		const cell7 = newRow.insertCell(6);
		const cell8 = newRow.insertCell(7);
		
		
	})
	.catch(error=>{
		// 오류 내용 확인
		console.log(error);
	})
}
