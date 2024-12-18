import { preHandlerHookHandler } from 'fastify';
import jwt from 'jsonwebtoken';

export const authMiddleware: preHandlerHookHandler = async (request, reply) => {
    try {
        const authHeader = request.headers.authorization;
        if (authHeader && authHeader.startsWith('Bearer ')) {
            const token = authHeader.substring(7);
            const decoded = jwt.verify(token, `${process.env.JWT_SECRET}`) as any;

            request.body = {
                ...request.body as object,
                session_variables: {
                    ...(request.body as any)?.session_variables,
                    ...decoded['https://hasura.io/jwt/claims']
                }
            };
        }
    } catch (error) {
        console.error('JWT verification failed:', error);
        reply.code(401).send({ error: 'Invalid token' });
    }
};
