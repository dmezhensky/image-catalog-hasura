import jwt from 'jsonwebtoken';

export const generateToken = (userId: string, role: string): string => {
    if (!userId || !role) {
        throw new Error('UserId and role are required');
    }

    const claims = {
        "sub": userId,
        "https://hasura.io/jwt/claims": {
            "x-hasura-allowed-roles": [role],
            "x-hasura-default-role": role,
            "x-hasura-user-id": userId,
            "x-hasura-role": role
        },
        "iat": Math.floor(Date.now() / 1000)
    };

    try {
        return jwt.sign(claims, `${process.env.JWT_SECRET}`);
    } catch (error) {
        console.error('Error generating token:', error);
        throw error;
    }
};
