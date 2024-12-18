import { UploadRequest } from '../types';
import { uploadToImgur } from '../utils/imgur';
import { pool } from '../models/auth.model';

export const uploadHandler = async (request: UploadRequest) => {
    try {
        const userId = request.body.session_variables?.['x-hasura-user-id'];

        if (!userId) {
            throw new Error('User ID not found in session variables');
        }

        const { file, collection_id } = request.body.input;


        const imgurDataLink = await uploadToImgur(file);

        const { rows } = await pool.query(
            `INSERT INTO images (url, author_id, collection_id, status)
             VALUES ($1, $2, $3, 'draft')
             RETURNING id, url, status`,
            [imgurDataLink, userId, collection_id]
        );

        return rows[0];
    } catch (error) {
        console.error('Upload error:', error);
        throw error;
    }
};
