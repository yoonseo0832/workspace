onload = () => {
	document.getElementById("search-btn").addEventListener("click", () => {
		getOpenData();
	});
}

const getOpenData = async () => {
	fetch("/V2/api/DSSP-IF-10944")
	.then(response => response.json())
	.then(data => {
		displayOpendata(data);
	})
	.catch(error => {
		console.log(error);
	})
}

const displayOpendata = (data) => {
	const target = document.querySelector("tbody");
	
	for(const item of data){
		const trEl = document.createElement("tr");
		
		const tdEle1 = document.createElement("td");
		tdEle1.textContent = `${item.shntPlaceNm}`;
		const tdEle2 = document.createElement("td");
		tdEle2.textContent = `${item.rnDtlAdres}`;
		const tdEle3 = document.createElement("td");
		tdEle3.textContent = `${item.arcd}`;				
		const tdEle4 = document.createElement("td");
		tdEle4.textContent = `${item.psblNmpr}`;
		
		trEl.appendChild(tdEle1);
		trEl.appendChild(tdEle2);
		trEl.appendChild(tdEle3);
		trEl.appendChild(tdEle4);
		
		target.appendChile(trEl);				
	}
}