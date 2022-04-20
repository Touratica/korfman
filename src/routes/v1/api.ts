import * as express from "express";
import pgPromise from "pg-promise";
import timestamp from "time-stamp";

export const register = ( app: express.Application ) => {
    const port = parseInt( process.env.PGPORT || "5432", 10 );
    const config = {
        database: process.env.PGDATABASE || "postgres",
        host: process.env.PGHOST || "localhost",
        port,
        user: process.env.PGUSER || "postgres"
    };

    const pgp = pgPromise();
    const db = pgp( config );

    app.get( `/api/members/all`, async ( req: express.Request, res: express.Response) => {
        try {
            const members = await db.any( `
                SELECT member_id, fpc_id, first_name, last_name, birth_date, mobile, email, is_permanent, dues_in_day FROM members
	            	ORDER BY member_id;`);
            return res.status(200).json( members );
        } catch ( error: any ) {
            console.error(error);
            res.status(418).json( { error: error.message || error } );
        }
    } );

	app.post(`/api/members/add`, async (req: express.Request, res: express.Response) => {
		try {
			const member = await db.one(`INSERT INTO members( fpc_id, first_name, last_name, birth_date, mobile, email, is_permanent, dues_in_day )
			VALUES( $[fpc_id], $[first_name], $[last_name], $[birth_date], $[mobile], $[email], $[is_permanent], $[dues_in_day] )
			RETURNING member_id;`, {...req.body});
			console.log(`[${timestamp(`YYYY/MM/DD HH:mm:ss.ms`)}] Member ${member.member_id} was added`);
			return res.status(201).json( { member } );
		} catch (error: any) {
			console.error( error ); // eslint-disable-line no-console
			res.status(418).json( { error: error.message || error } );
		}
	});

	app.post(`/api/fpc_members/add`, async (req: express.Request, res: express.Response) => {
		try {
			const fpc_member = await db.one(`INSERT INTO fpc_members( fpc_id, first_name, last_name, birth_date, mobile, email )
			VALUES( $[fpc_id], $[first_name], $[last_name], $[birth_date], $[mobile], $[email] )
			RETURNING fpc_id;`, {...req.body});
			console.log(`[${timestamp(`YYYY/MM/DD HH:mm:ss.ms`)}] FPC member ${fpc_member.fpc_id} was added`);
			return res.status(201).json( { fpc_member } );
		} catch (error: any) {
			console.error( error ); // eslint-disable-line no-console
			res.status(418).json( { error: error.message || error } );
		}
	});

};