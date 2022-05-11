import type { NextApiRequest, NextApiResponse } from 'next';
import prisma from '../../../lib/prisma';

const handle = async (req:NextApiRequest, res:NextApiResponse) => {
	switch (req.method) {
		case `GET`:
			await handleGET(res);
			break;	
		default:
			throw new Error(`The HTTP ${req.method} method is not supported at this route.`);
	}
};

const handleGET = async (res: NextApiResponse<any>) => {
	try {
		const result = await prisma.staff.findMany();
		res.status(200).json(result);		
	} catch (error) {
		res.status(500).json({message: `Could not retrieve the staff list.`})
	}
};

export default handle;
