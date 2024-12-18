CREATE OR REPLACE FUNCTION search_images_by_tags(
    tag_ids_str text,
    hasura_session json DEFAULT NULL
)
RETURNS SETOF images AS $$
DECLARE
    current_user_id UUID;
BEGIN
    IF hasura_session IS NOT NULL AND hasura_session->>'x-hasura-user-id' IS NOT NULL THEN
        current_user_id := (hasura_session->>'x-hasura-user-id')::UUID;
    END IF;

    RETURN QUERY
    SELECT i.*
    FROM images i
    JOIN (
        SELECT
            it.image_id,
            COUNT(DISTINCT it.tag_id) as tag_count,
            CASE
                WHEN i2.author_id = current_user_id THEN 1
                WHEN EXISTS (
                    SELECT 1 FROM collection_authors ca
                    WHERE ca.collection_id = i2.collection_id
                    AND ca.author_id = current_user_id
                ) THEN 2
                ELSE 3
            END as rank
        FROM image_tags it
        JOIN images i2 ON i2.id = it.image_id
        WHERE it.tag_id IN (
            SELECT CAST(trim(uuid) AS UUID)
            FROM unnest(string_to_array(tag_ids_str, ',')) AS uuid
        )
        GROUP BY it.image_id, i2.author_id, i2.collection_id
    ) ranked ON ranked.image_id = i.id
    WHERE (
        i.status = 'published'
        OR i.author_id = current_user_id
        OR EXISTS (
            SELECT 1 FROM collection_authors ca
            WHERE ca.collection_id = i.collection_id
            AND ca.author_id = current_user_id
        )
    )
    ORDER BY
        ranked.rank ASC,
        ranked.tag_count DESC,
        i.created_at DESC;
END;
$$ LANGUAGE plpgsql STABLE;
