import fastify, { FastifyRequest, FastifyReply } from 'fastify';
import { authHandler } from './handlers/auth';
import { uploadHandler } from './handlers/upload';
import { authMiddleware } from './middleware/auth';
import { AuthInput, UploadInput, HasuraRequestBody } from './types';

const app = fastify({ logger: true });

app.addHook('preHandler', authMiddleware);

const handleRequest = async <T, R>(
    handler: (req: FastifyRequest<{ Body: HasuraRequestBody<T> }>) => Promise<R>,
    request: FastifyRequest<{ Body: HasuraRequestBody<T> }>,
    reply: FastifyReply
) => {
    try {
        const result = await handler(request);
        return reply.code(200).send(result);
    } catch (error) {
        reply.code(400).send({
            message: error instanceof Error ? error.message : 'Unknown error',
        });
    }
};

app.post<{
    Body: HasuraRequestBody<AuthInput>;
}>('/auth', (request, reply) => handleRequest(authHandler, request, reply));

app.post<{
    Body: HasuraRequestBody<UploadInput>;
}>('/upload', (request, reply) => handleRequest(uploadHandler, request, reply));

app.setErrorHandler((error, request, reply) => {
    app.log.error(`Unhandled error: ${error.message}`);
    reply.code(500).send({ message: 'Internal Server Error' });
});

const start = async () => {
    try {
        await app.listen({ port: 3000, host: '0.0.0.0' });
        console.log('Server running on port 3000');
    } catch (err) {
        app.log.error(err);
        process.exit(1);
    }
};

start().catch(err => {
    console.error('Fatal error:', err);
    process.exit(1);
});
