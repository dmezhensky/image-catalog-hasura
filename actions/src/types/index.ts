import { FastifyRequest } from 'fastify';

export interface HasuraSessionVariables {
    'x-hasura-user-id'?: string;
    'x-hasura-role'?: string;
    [key: string]: string | undefined;
}

export interface HasuraRequestBody<T = any> {
    session_variables?: HasuraSessionVariables;
    input: T;
}

export interface AuthInput {
    email: string;
    password: string;
}

export interface UploadInput {
    file: string;
    collection_id: string;
}

export type AuthRequest = FastifyRequest<{
    Body: HasuraRequestBody<AuthInput>;
}>;

export type UploadRequest = FastifyRequest<{
    Body: HasuraRequestBody<UploadInput>;
}>;
