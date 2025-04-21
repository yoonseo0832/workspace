
function ProfileCard(){
    const name = "홍화연";
    const age = 27;
    const job = "배우";
    const isStudent = false; // 학생 여부
    const cardStyle = {textAlign:'center', border:'2px solid pink', width: '300px', margin:'2px auto'};
    return(
        <div style={cardStyle}>
            <h3>이름: {name}</h3>
            <h3>나이: {age}</h3>
            <h3>직업: {job}</h3>
            <p>
                {/*학생인 경우 '학생입니다', 그렇지 않으면 '학생이 아닙니다' */}
                {isStudent ?'학생입니다':'학생이 아닙니다'}
            </p>
            {/*버튼 클릭 시 "안녕하세요, xx님" 알림창 */}
            <button onClick={()=>alert(`안녕하세요, ${name}님`)}>확인</button>
        </div>
    );
}
// 컴포넌트 내보내기: 다른 파일에서 해당 텀포넌트를 사용항 수 있게 됨
export default ProfileCard;