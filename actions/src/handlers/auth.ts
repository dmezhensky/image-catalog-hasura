import { AuthRequest } from '../types';
import { generateToken } from '../utils/jwt';
import { pool } from '../models/auth.model';

export const authHandler = async (request: AuthRequest) => {
    const { email } = request.body.input;

    try {
        const { rows } = await pool.query(
            'SELECT id, role FROM authors WHERE email = $1',
            [email]
        );

        if (rows.length === 0) {
            throw new Error('Authentication failed');
        }

        const token = generateToken(rows[0].id, rows[0].role)

        return { token };
    } catch (error) {
        console.error('Auth error:', error);
        throw error;
    }
};
