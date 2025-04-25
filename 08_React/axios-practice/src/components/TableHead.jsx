export default function TableHead({ typeList }) {
  return (
    <>
      <tr>
        {typeList.map((type, index) => {
          return <th key={"type_" + index}>{type}</th>;
        })}
      </tr>
    </>
  );
}
