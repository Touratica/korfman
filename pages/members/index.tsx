import { GetServerSideProps, InferGetServerSidePropsType } from 'next';
import { Member } from '@prisma/client';
import { getMembers } from '../api/members';
import { SearchableSortableTable } from '../../lib/components/SearchableSortableTable';

const memberType = {
  honorary: 'honorário',
  effective: 'efetivo',
  founder: 'fundador',
  sympathizer: 'simpatizante',
};

export const getServerSideProps: GetServerSideProps = async () => {
  try {
    const data = await getMembers();

    if (!data) return { notFound: true };

    return {
      props: { members: data },
    };
  } catch (error: any) {
    return { props: { errors: error.message } };
  }
};

export default function Table({ members }: InferGetServerSidePropsType<typeof getServerSideProps>) {
  const rows = members.map((member: Member) => (
    <tr
      key={member.memberId}
      onClick={() => {
        window.location.href = `members/${member.memberId}`;
      }}
      style={{ cursor: 'pointer' }}
    >
      <td>{member.memberId}</td>
      <td>{memberType[member.type]}</td>
      <td>
        {member.firstName} {member.lastName}
      </td>
      <td>{member.birthDate.toLocaleDateString('pt-PT')}</td>
    </tr>
  ));

  return (
    <>
      <SearchableSortableTable
        headers={{
          memberId: 'Nº Sócio',
          memberType: 'Tipo',
          fullName: 'Nome completo',
          birthDate: 'DDN',
        }}
        items={members}
      ></SearchableSortableTable>
    </>
  );
}
