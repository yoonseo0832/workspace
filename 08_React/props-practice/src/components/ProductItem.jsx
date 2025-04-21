function ProductItem({ name, price, isSale }){
    return(
        <div style={{border:'2px solid pink'}}>
            <h3>{name}</h3>
            <p>\{price}</p>
            {isSale && "세일중"}
        </div>
    );
}
export default ProductItem;