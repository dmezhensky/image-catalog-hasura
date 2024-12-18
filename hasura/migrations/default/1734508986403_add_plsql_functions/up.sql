CREATE OR REPLACE FUNCTION get_recommended_images(
    user_id UUID,
    limit_count INTEGER DEFAULT 10
)
RETURNS SETOF images AS $$
BEGIN
    RETURN QUERY
    WITH user_tags AS (
        SELECT DISTINCT tag_id
        FROM images i
        JOIN image_tags it ON it.image_id = i.id
        WHERE i.author_id = user_id
    )
    SELECT DISTINCT i.*
    FROM images i
    JOIN image_tags it ON it.image_id = i.id
    WHERE
        it.tag_id IN (SELECT tag_id FROM user_tags)
        AND i.author_id != user_id
        AND i.status = 'published'
    ORDER BY i.created_at DESC
    LIMIT limit_count;
END;
$$ LANGUAGE plpgsql STABLE;
