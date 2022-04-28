import type { NextApiRequest, NextApiResponse } from 'next';
import prisma from '../../../lib/prisma';

const handle = async (req:NextApiRequest, res:NextApiResponse) => {
	const result = await prisma.fpcMember.create({
		data: {
			...req.body,
		},
	});
	res.status(200).json(result);
};

export default handle;