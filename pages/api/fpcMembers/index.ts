import type { NextApiRequest, NextApiResponse } from 'next';
import prisma from '../../../lib/prisma';

const handle = async (req:NextApiRequest, res:NextApiResponse<any>) => {
	switch (req.method) {
		case "GET":
			await handleGET(res);
			break;
		default:
			throw new Error(`The HTTP ${req.method} method is not supported at this route.`);
	}
};

// GET /api/fpcMembers/list
const handleGET = async (res: NextApiResponse<any>) => {
	try {
		const result = await prisma.fpcMember.findMany();
		res.status(200).json(result);
	} catch (error) {
		res.status(500).json({message: `Could not retrieve the FPC members list.`})
	}
};

export default handle;