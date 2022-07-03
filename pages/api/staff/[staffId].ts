import type { NextApiRequest, NextApiResponse } from "next";
import { Prisma } from "@prisma/client";
import prisma from "../../../lib/prisma";

// GET /api/staff/:staffId
const handleGET = async (
  staffId: string | string[],
  res: NextApiResponse<any>
) => {
  const member = await prisma.staff.findFirst({
    where: {
      staffId: Number(staffId),
    },
  });
  if (member) res.status(200).json(member);
  else
    res
      .status(404)
      .json({ message: `Staff member with id: ${staffId} not found.` });
};

// DELETE /api/staff/:staffId
const handleDELETE = async (
  staffId: string | string[],
  res: NextApiResponse<any>
) => {
  try {
    const member = await prisma.staff.delete({
      where: {
        staffId: Number(staffId),
      },
    });
    res.status(200).json(member);
  } catch (error) {
    if (error instanceof Prisma.PrismaClientKnownRequestError) {
      if (error.code === "P2025") {
        // https://www.prisma.io/docs/reference/api-reference/error-reference#p2025
        res
          .status(404)
          .json({ message: `Staff member with id: ${staffId} not found.` });
      }
    }
  }
};

const handle = async (req: NextApiRequest, res: NextApiResponse<any>) => {
  const { staffId } = req.query;

  switch (req.method) {
    case "GET":
      handleGET(staffId, res);
      break;
    case "DELETE":
      handleDELETE(staffId, res);
      break;
    default:
      throw new Error(
        `The HTTP ${req.method} method is not supported at this route.`
      );
  }
};

export default handle;
