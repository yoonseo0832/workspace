function Search() {
    return (
        <form action="" className="search-form">
            <div className="select">
                <select name="condition" id="" className="custom-select form-select">
                    <option value="writer">작성자</option>
                    <option value="title">제목</option>
                    <option value="content">내용</option>
                </select>
            </div>
            <div className="text text-sm">F
                <input type="text" className="form-control" name="keyword" />
            </div>
            <button className="btn-search btn">검색</button>
        </form>
    );
}
export default Search;