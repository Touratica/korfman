import { useState } from 'react';

interface Header {
  id: string;
  value: string;
}

interface TableComponents {
  headers: Header[];
  items: object;
}

const SearchableSortableTable = ({ headers, items: items }: TableComponents) => {
  const [sortedField, setSortedField] = useState<string | null>(null);
  return (
    <>
      <table className="relative">
        <thead className="fixed top-0 left-0">
          <tr>
            {headers.map((header) => (
              <th>
                <button onClick={() => setSortedField(header.id)}></button>
                {header.value}
              </th>
            ))}
          </tr>
        </thead>
        <tbody>{items}</tbody>
      </table>
    </>
  );
};

export default SearchableSortableTable;
