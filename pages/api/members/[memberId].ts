import type { NextApiRequest, NextApiResponse } from 'next';
import prisma from '../../../lib/prisma';
import { Prisma } from "@prisma/client";

type Data = {
	memberId: number
};

const handle = async (req:NextApiRequest, res:NextApiResponse<any>) => {
	const memberId = req.query.memberId;

	switch (req.method) {
		case 'GET':
			handleGET(memberId, res);		
			break;
		case 'DELETE':
			handleDELETE(memberId, res);
			break;
		default:
			throw new Error(`The HTTP ${req.method} method is not supported at this route.`);
	};
};

// GET /api/members/:memberId
const handleGET = async (memberId: string | string[], res: NextApiResponse<any>) => {
		const member = await prisma.member.findFirst({
			where: {
				memberId: Number(memberId),
			}
		});
		if (member) res.status(200).json(member);
		else res.status(404).json({ message: `Member with id: ${memberId} not found.`});
};

// DELETE /api/members/:memberId
const handleDELETE = async (memberId: string | string[], res: NextApiResponse<any>) => {
	try {
		const member = await prisma.member.delete({
			where: {
				memberId: Number(memberId),
			}
		});
		res.status(200).json(member);
	} catch (error) {
		if (error instanceof Prisma.PrismaClientKnownRequestError) {
			if (error.code === 'P2025') {	// https://www.prisma.io/docs/reference/api-reference/error-reference#p2025
				res.status(404).json({ message: `Member with id: ${memberId} not found.`});
			}
		}
	}
};

export default handle;