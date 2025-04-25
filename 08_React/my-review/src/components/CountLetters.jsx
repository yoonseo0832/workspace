import {useState} from 'react';
function CountLetters(){
    const [letters, setLetters] = useState('');

    return(
        <div style={{textAlign:'center', paddingTop:'200px'}}>
            <textarea value={letters} onChange={(e) => { setLetters(e.target.value)}} style={{ width: '600px', height: '400px', fontSize:'16px'}}></textarea>
            <hr />
            <div>공백 포함 {letters.length}자</div>
            <div>공백 제외 {letters.replace(/ /gi, '').length}자</div>
            <hr />
            <button onClick={() => {setLetters('')}}>초기화</button>
        </div>
    );
}
export default CountLetters;