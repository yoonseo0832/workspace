import { useContext, useState } from 'react';
import MyContext from '../contexts/MyContext';
function PhoneInput() {
    const [name, setName] = useState('');
    const [phone, setPhone] = useState('');
    const onChangeName = (e) => setName(e.target.value);
    const onChangePhone = (e) => setPhone(e.target.value);
    const {addPhone} = useContext(MyContext);

    const onClickAlert = () => {
        alert(`${name} : ${phone}`);
        // 리스트에 name, phone을 저장
        addPhone({name: name, number: phone});
        
        // 이름, 전화번호 초기화 --> 상태값을 ''빈값으로 업데이트 
        setName('');
        setPhone('');
    }
    

    return (
        <div>
            <label htmlFor="name">이름</label>
            {/* (e)=>{console.log(e.target.value)} */}
            <input type="text" id="name" value={name} onChange={onChangeName} />
            <label htmlFor="phone">연락처</label>
            <input type="tel" id="phone" value={phone} onChange={onChangePhone} />
            <input type="button" value="추가" onClick={onClickAlert}  />
        </div>
    );
}
export default PhoneInput;