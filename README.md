# Image Catalog API (Hasura)

This project is an image catalog API built using Hasura GraphQL Engine.

## Features

- JWT authentication
- Three access levels: public, author, admin
- Image upload support through Imgur
- Advanced tag-based search
- PL/SQL functions for complex business logic

## Installation and Setup

1. Environment setup:
```bash
cp .env.example .env
# Fill in the required environment variables
```

2. Start the project:
```bash
docker-compose up -d
```

3. Apply migrations:
```bash
hasura migrate apply
hasura metadata apply
hasura seeds apply
```

## API Reference

### Authentication

```graphql
mutation Authenticate {
  authenticate(email: "author1@example.com", password: "password") {
    token
  }
}
```

### Image Upload Methods

1. Direct URL insertion:
```graphql
mutation InsertImage {
  insert_images_one(object: {
    url: "https://example.com/image.jpg",
    collection_id: "uuid",
    author_id: "uuid",
    status: "draft"
  }) {
    id
    url
    status
  }
}
```

2. File upload via Action:
```graphql
mutation UploadImage {
  uploadImage(
    file: "base64_encoded_image_data",
    collection_id: "uuid"
  ) {
    id
    url
    status
  }
}
```

### Image Search

1. By tags:
```graphql
query {
  search_images_by_tags(
    args: {
      tag_ids_str: "uuid1,uuid2"
    }
  ) {
    id
    url
    status
    author {
      email
    }
    collection {
      name
    }
  }
}
```

2. By collections:
```graphql
query GetCollectionImages {
  images(
    where: {collection_id: {_eq: "uuid"}}
    order_by: {created_at: desc}
  ) {
    id
    url
    status
    author {
      email
    }
  }
}
```

### Get recommended images

1. By user ID:
```graphql
query {
  get_recommended_images(args: { user_id: "uuid", limit_count: 5 }) {
    id
    url
    author {
      email
    }
  }
}
```


## Roles and Permissions

1. **Public**:
    - View published images
    - Search by tags and collections

2. **Author**:
    - All Public permissions
    - Add new images
    - Edit own images
    - Manage tags for own images

3. **Admin**:
    - All Author permissions
    - Manage collections
    - Manage authors
    - Assign authors to collections

## Test Data

Test data available for API testing:
- Admin: admin@example.com
- Authors: author1@example.com, author2@example.com
- Collections: Nature, Architecture, Art, Technology
- Tags: landscape, modern, abstract, digital, minimal, urban, nature, wildlife
