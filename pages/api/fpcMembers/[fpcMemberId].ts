import { Prisma } from "@prisma/client";
import type { NextApiRequest, NextApiResponse } from "next";
import prisma from "../../../lib/prisma";

// GET /api/fpcMembers/:fpcMemberId
const handleGET = async (
  fpcMemberId: string | string[],
  res: NextApiResponse<unknown>
) => {
  const member = await prisma.member.findFirst({
    where: {
      memberId: Number(fpcMemberId),
    },
  });
  if (member) res.status(200).json(member);
  else
    res
      .status(404)
      .json({ message: `FPC member with id: ${fpcMemberId} not found.` });
};

// DELETE /api/fpcMembers/:fpcMemberId
const handleDELETE = async (
  fpcMemberId: string | string[],
  res: NextApiResponse<unknown>
) => {
  try {
    const member = await prisma.member.delete({
      where: {
        memberId: Number(fpcMemberId),
      },
    });
    res.status(200).json(member);
  } catch (error) {
    if (error instanceof Prisma.PrismaClientKnownRequestError) {
      if (error.code === "P2025") {
        // https://www.prisma.io/docs/reference/api-reference/error-reference#p2025
        res
          .status(404)
          .json({ message: `FPC member with id: ${fpcMemberId} not found.` });
      }
    }
  }
};

const handle = async (req: NextApiRequest, res: NextApiResponse<unknown>) => {
  const { fpcMemberId } = req.query;

  if (typeof fpcMemberId === "string") {
    switch (req.method) {
      case "GET":
        await handleGET(fpcMemberId, res);
        break;
      case "DELETE":
        await handleDELETE(fpcMemberId, res);
        break;
      default:
        throw new Error(
          `The HTTP ${req.method} method is not supported at this route.`
        );
    }
  }
};

export default handle;
