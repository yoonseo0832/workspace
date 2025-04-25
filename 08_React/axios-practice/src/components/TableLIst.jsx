function TableBody({ dataList, keyName }) {
  return (
    <tbody>
      {dataList.map((data, index) => {
        return (
          <tr key={keyName + index}>
            {Object.keys(data).map((key, idx) => {
              return <td key={idx}>{data[key]}</td>;
            })}
          </tr>
        );
      })}
    </tbody>
  );
}

function TableHead({ typeList }) {
  return (
    <thead>
      <tr>
        {typeList.map((type, index) => {
          return <th key={"type_" + index}>{type}</th>;
        })}
      </tr>
    </thead>
  );
}
export default function TableList({ keyName, dataList, typeList }) {
  return (
    <table>
      <TableHead typeList={typeList} />
      <TableBody dataList={dataList} keyName={keyName} />
    </table>
  );
}
