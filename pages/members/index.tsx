import { getMembers } from "../api/members";
import type { Member } from "@prisma/client";
import {
  GetServerSideProps,
  GetServerSidePropsContext,
  InferGetServerSidePropsType,
} from "next";
import {} from "react";

const memberType = {
  honorary: "honorário",
  effective: "efetivo",
  founder: "fundador",
  sympathizer: "simpatizante",
};

export const getServerSideProps: GetServerSideProps = async ({
  params,
}: GetServerSidePropsContext) => {
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

const MembersList = ({
  members,
}: InferGetServerSidePropsType<typeof getServerSideProps>) => (
  <>
    <h1>Membros</h1>
    <table>
      <thead>
        <tr>
          <th>Nº Sócio</th>
          <th>Tipo</th>
          <th>Nome completo</th>
          <th>DDN</th>
        </tr>
      </thead>
      <tbody>
        {members.map((member: Member) => (
          <tr
            key={member.memberId}
            onClick={() =>
              (window.location.href = `members/${member.memberId}`)
            }
            style={{ cursor: "pointer" }}
          >
            <td>{member.memberId}</td>
            <td>{memberType[member.type]}</td>
            <td>
              {member.firstName} {member.lastName}
            </td>
            <td>{member.birthDate.toLocaleDateString("pt-PT")}</td>
          </tr>
        ))}
      </tbody>
    </table>
  </>
);

export default MembersList;
