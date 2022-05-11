import type { NextApiRequest, NextApiResponse } from 'next';
import prisma from '../../../lib/prisma';

const handle = async (req:NextApiRequest, res:NextApiResponse<any>) => {
	switch (req.method) {
		case 'POST':
			await handlePOST(req, res);
			break;
		default:
			throw new Error(`The HTTP ${req.method} method is not supported at this route.`);
	}
};

// POST /api/staff/add
const handlePOST = async (req: NextApiRequest, res: NextApiResponse<any>) => {
	try {
		const result = await prisma.staff.create({
			data: {
				...req.body,
			},
		});
		res.status(200).json(result);
	} catch (error) {
		res.status(418).json({message: `Could not create the staff member.`})
	}
};

export default handle;
