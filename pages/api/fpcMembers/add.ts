import type { NextApiRequest, NextApiResponse } from "next";
import type { FpcMember } from "@prisma/client";
import prisma from "../../../lib/prisma";

// POST /api/fpcMembers/add
const handlePOST = async (req: NextApiRequest, res: NextApiResponse<any>) => {
  try {
    const fpcMember: FpcMember = JSON.parse(req.body);

    const result = await prisma.fpcMember.create({
      data: fpcMember,
    });
    res.status(200).json(result);
  } catch (error) {
    res.status(418).json({ message: "Could not create the FPC member." });
  }
};

const handle = async (req: NextApiRequest, res: NextApiResponse<any>) => {
  switch (req.method) {
    case "POST":
      await handlePOST(req, res);
      break;
    default:
      throw new Error(
        `The HTTP ${req.method} method is not supported at this route.`
      );
  }
};

export default handle;
