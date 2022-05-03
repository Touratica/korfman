import type { NextApiRequest, NextApiResponse } from 'next';
import prisma from '../../../lib/prisma';

const handle = async (req:NextApiRequest, res:NextApiResponse) => {
	switch (req.method) {
		case 'POST':
			await handlePOST(req, res);
			break;
		default:
			throw new Error(`The HTTP ${req.method} method is not supported at this route.`);
	};
};

export default handle;

async function handlePOST(req: NextApiRequest, res: NextApiResponse<any>) {
	const result = await prisma.fpcMember.create({
		data: {
			...req.body,
		},
	});
	res.status(200).json(result);
}
