import type { NextApiRequest, NextApiResponse } from 'next';
import prisma from '../../../lib/prisma';

// POST /api/payments/add
const handlePOST = async (req: NextApiRequest, res: NextApiResponse<any>) => {
  try {
    const result = await prisma.payment.create({
      data: {
        ...req.body,
      },
    });
    res.status(200).json(result);
  } catch (error) {
    res.status(418).json({ message: 'Could not create the payment.' });
  }
};

const handle = async (req: NextApiRequest, res: NextApiResponse) => {
  switch (req.method) {
    case 'POST':
      await handlePOST(req, res);
      break;
    default:
      throw new Error(`The HTTP ${req.method} method is not supported at this route.`);
  }

  await handlePOST(req, res);
};

export default handle;
