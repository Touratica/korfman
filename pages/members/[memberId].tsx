import { useRouter } from "next/router";
import {
  GetServerSideProps,
  GetServerSidePropsContext,
  InferGetServerSidePropsType,
} from "next";
import { getMember } from "../api/members/[memberId]";

export const getServerSideProps: GetServerSideProps = async ({
  params,
}: GetServerSidePropsContext) => {
  const memberId = params?.memberId;
  const data = await getMember(Number(memberId));

  if (!data) return { notFound: true };

  return {
    props: { member: data },
  };
};

const MemberComponent = ({
  member,
}: InferGetServerSidePropsType<typeof getServerSideProps>) => {
  const router = useRouter();
  const { memberId } = router.query;

  return (
    <>
      <h1>Hello {memberId}</h1>
      <h2>{member.firstName}</h2>
    </>
  );
};

export default MemberComponent;
