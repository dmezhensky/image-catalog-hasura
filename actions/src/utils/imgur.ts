import fetch from 'node-fetch';
import FormData from 'form-data';

export const uploadToImgur = async (file: string) => {
    if (!file || !file.includes(',')) {
        throw new Error('Invalid file format');
    }

    const formData = new FormData();
    formData.append('image', file.split(',')[1]);

    const response = await fetch('https://api.imgur.com/3/image', {
        method: 'POST',
        headers: {
            'Authorization': `Client-ID ${process.env.IMGUR_CLIENT_ID}`
        },
        body: formData
    });

    const result = await response.json();

    if (!result.success) throw new Error('Imgur upload failed');

    return result.data.link;
};
