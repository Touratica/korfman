import type { NextApiRequest, NextApiResponse } from "next";
import prisma from "../../../lib/prisma";

const handle = async (req: NextApiRequest, res: NextApiResponse) => {
  switch (req.method) {
    case `GET`:
      await handleGET(res);
      break;
    default:
      throw new Error(
        `The HTTP ${req.method} method is not supported at this route.`
      );
  }
};

// GET /api/members/list
const handleGET = async (res: NextApiResponse<any>) => {
  try {
    const result = await getMembers();
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ message: `Could not retrieve the members list.` });
  }
};

export const getMembers = async () => {
  return await prisma.member.findMany();
};

export default handle;
