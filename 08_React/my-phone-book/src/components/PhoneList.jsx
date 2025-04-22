import { useContext } from 'react';
import MyContext from '../contexts/MyContext';
function PhoneList() {
    const {list} = useContext(MyContext);
    return (
        <>
            <table>
                <thead>
                    <tr>
                        <th>이름</th>
                        <th>연락처</th>
                    </tr>
                </thead>
                <tbody>
                    { list.length === 0 && 
                        <tr>
                            <td colSpan={2}>저장된 연락처가 없습니다</td>
                        </tr>
                    }
                    {
                        // value, index값을 map은 불러올수 있음
                        // 중괄호를 사용하는 경우 return(); 으로 감싸야함, {} 안 쓰는 경우에는 리턴없이 소괄호만 사용();
                        list.map((phone, index) => {
                            return (
                                <tr key={'phone_'+index}>
                                    <td>{phone.name}</td>
                                    <td>{phone.number}</td>
                                </tr>
                            );
                        })}
                    
                        {/*
                        list.map((phone, index) => (
                                <tr key={'phone_'+index}>
                                    <td>{phone.name}</td>
                                    <td>{phone.number}</td>
                                </tr>
                            );
                        )}
                        */}
                </tbody>
            </table>
        </>
    );
}
export default PhoneList;