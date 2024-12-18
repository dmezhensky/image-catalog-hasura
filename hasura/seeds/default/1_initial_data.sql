TRUNCATE TABLE image_tags CASCADE;
TRUNCATE TABLE images CASCADE;
TRUNCATE TABLE tags CASCADE;
TRUNCATE TABLE collection_authors CASCADE;
TRUNCATE TABLE collections CASCADE;
TRUNCATE TABLE authors CASCADE;

INSERT INTO authors (id, email, role) VALUES
('123e4567-e89b-12d3-a456-426614174000', 'admin@example.com', 'admin'),
('123e4567-e89b-12d3-a456-426614174001', 'author1@example.com', 'author'),
('123e4567-e89b-12d3-a456-426614174002', 'author2@example.com', 'author'),
('123e4567-e89b-12d3-a456-426614174003', 'author3@example.com', 'author');

INSERT INTO collections (id, name) VALUES
('223e4567-e89b-12d3-a456-426614174000', 'Nature'),
('223e4567-e89b-12d3-a456-426614174001', 'Architecture'),
('223e4567-e89b-12d3-a456-426614174002', 'Art'),
('223e4567-e89b-12d3-a456-426614174003', 'Technology');

INSERT INTO collection_authors (collection_id, author_id) VALUES
('223e4567-e89b-12d3-a456-426614174000', '123e4567-e89b-12d3-a456-426614174001'),
('223e4567-e89b-12d3-a456-426614174001', '123e4567-e89b-12d3-a456-426614174001'),
('223e4567-e89b-12d3-a456-426614174002', '123e4567-e89b-12d3-a456-426614174002'),
('223e4567-e89b-12d3-a456-426614174003', '123e4567-e89b-12d3-a456-426614174003');

INSERT INTO tags (id, name) VALUES
('323e4567-e89b-12d3-a456-426614174000', 'landscape'),
('323e4567-e89b-12d3-a456-426614174001', 'modern'),
('323e4567-e89b-12d3-a456-426614174002', 'abstract'),
('323e4567-e89b-12d3-a456-426614174003', 'digital'),
('323e4567-e89b-12d3-a456-426614174004', 'minimal'),
('323e4567-e89b-12d3-a456-426614174005', 'urban'),
('323e4567-e89b-12d3-a456-426614174006', 'nature'),
('323e4567-e89b-12d3-a456-426614174007', 'wildlife');

INSERT INTO images (id, url, author_id, collection_id, status) VALUES
-- Nature Collection
('423e4567-e89b-12d3-a456-426614174000', 'https://example.com/nature/mountain.jpg', '123e4567-e89b-12d3-a456-426614174001', '223e4567-e89b-12d3-a456-426614174000', 'published'),
('423e4567-e89b-12d3-a456-426614174001', 'https://example.com/nature/forest.jpg', '123e4567-e89b-12d3-a456-426614174001', '223e4567-e89b-12d3-a456-426614174000', 'published'),
('423e4567-e89b-12d3-a456-426614174002', 'https://example.com/nature/lake.jpg', '123e4567-e89b-12d3-a456-426614174001', '223e4567-e89b-12d3-a456-426614174000', 'draft'),

-- Architecture Collection
('423e4567-e89b-12d3-a456-426614174003', 'https://example.com/architecture/modern-building.jpg', '123e4567-e89b-12d3-a456-426614174001', '223e4567-e89b-12d3-a456-426614174001', 'published'),
('423e4567-e89b-12d3-a456-426614174004', 'https://example.com/architecture/bridge.jpg', '123e4567-e89b-12d3-a456-426614174001', '223e4567-e89b-12d3-a456-426614174001', 'published'),

-- Art Collection
('423e4567-e89b-12d3-a456-426614174005', 'https://example.com/art/abstract1.jpg', '123e4567-e89b-12d3-a456-426614174002', '223e4567-e89b-12d3-a456-426614174002', 'published'),
('423e4567-e89b-12d3-a456-426614174006', 'https://example.com/art/minimal1.jpg', '123e4567-e89b-12d3-a456-426614174002', '223e4567-e89b-12d3-a456-426614174002', 'published'),

-- Technology Collection
('423e4567-e89b-12d3-a456-426614174007', 'https://example.com/tech/gadget1.jpg', '123e4567-e89b-12d3-a456-426614174003', '223e4567-e89b-12d3-a456-426614174003', 'published'),
('423e4567-e89b-12d3-a456-426614174008', 'https://example.com/tech/robot.jpg', '123e4567-e89b-12d3-a456-426614174003', '223e4567-e89b-12d3-a456-426614174003', 'draft');

INSERT INTO image_tags (image_id, tag_id) VALUES
-- Nature Collection Images
('423e4567-e89b-12d3-a456-426614174000', '323e4567-e89b-12d3-a456-426614174000'), -- mountain: landscape
('423e4567-e89b-12d3-a456-426614174000', '323e4567-e89b-12d3-a456-426614174006'), -- mountain: nature
('423e4567-e89b-12d3-a456-426614174001', '323e4567-e89b-12d3-a456-426614174006'), -- forest: nature
('423e4567-e89b-12d3-a456-426614174001', '323e4567-e89b-12d3-a456-426614174007'), -- forest: wildlife
('423e4567-e89b-12d3-a456-426614174002', '323e4567-e89b-12d3-a456-426614174000'), -- lake: landscape
('423e4567-e89b-12d3-a456-426614174002', '323e4567-e89b-12d3-a456-426614174006'), -- lake: nature

-- Architecture Collection Images
('423e4567-e89b-12d3-a456-426614174003', '323e4567-e89b-12d3-a456-426614174001'), -- modern-building: modern
('423e4567-e89b-12d3-a456-426614174003', '323e4567-e89b-12d3-a456-426614174005'), -- modern-building: urban
('423e4567-e89b-12d3-a456-426614174004', '323e4567-e89b-12d3-a456-426614174004'), -- bridge: minimal
('423e4567-e89b-12d3-a456-426614174004', '323e4567-e89b-12d3-a456-426614174005'), -- bridge: urban

-- Art Collection Images
('423e4567-e89b-12d3-a456-426614174005', '323e4567-e89b-12d3-a456-426614174002'), -- abstract1: abstract
('423e4567-e89b-12d3-a456-426614174005', '323e4567-e89b-12d3-a456-426614174004'), -- abstract1: minimal
('423e4567-e89b-12d3-a456-426614174006', '323e4567-e89b-12d3-a456-426614174004'), -- minimal1: minimal

-- Technology Collection Images
('423e4567-e89b-12d3-a456-426614174007', '323e4567-e89b-12d3-a456-426614174003'), -- gadget1: digital
('423e4567-e89b-12d3-a456-426614174007', '323e4567-e89b-12d3-a456-426614174004'), -- gadget1: minimal
('423e4567-e89b-12d3-a456-426614174008', '323e4567-e89b-12d3-a456-426614174003'); -- robot: digital
