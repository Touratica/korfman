import type { NextApiRequest, NextApiResponse } from 'next';
import prisma from '../../../lib/prisma';
import { Prisma } from "@prisma/client";

const handle = async (req:NextApiRequest, res:NextApiResponse<any>) => {
	const fpcMemberId = req.query.fpcMemberId;

	switch (req.method) {
		case 'GET':
			await handleGET(fpcMemberId, res);		
			break;
		case 'DELETE':
			await handleDELETE(fpcMemberId, res);
			break;
		default:
			throw new Error(`The HTTP ${req.method} method is not supported at this route.`);
	};
};

// GET /api/members/:memberId
const handleGET = async (fpcMemberId: string | string[], res: NextApiResponse<any>) => {
		const member = await prisma.member.findFirst({
			where: {
				memberId: Number(fpcMemberId),
			}
		});
		if (member) res.status(200).json(member);
		else res.status(404).json({ message: `FPC member with id: ${fpcMemberId} not found.`});
};

// DELETE /api/members/:memberId
const handleDELETE = async (fpcMemberId: string | string[], res: NextApiResponse<any>) => {
	try {
		const member = await prisma.member.delete({
			where: {
				memberId: Number(fpcMemberId),
			}
		});
		res.status(200).json(member);
	} catch (error) {
		if (error instanceof Prisma.PrismaClientKnownRequestError) {
			if (error.code === 'P2025') {	// https://www.prisma.io/docs/reference/api-reference/error-reference#p2025
				res.status(404).json({ message: `FPC member with id: ${fpcMemberId} not found.`});
			}
		}
	}
};

export default handle;
