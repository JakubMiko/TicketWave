# TicketWave API Documentation

## Public Endpoints

### 1. List All Events
- **Endpoint:** `GET /api/v1/events`
- **Description:** Retrieves a list of all available events
- **Response:** Returns an array of event details including name, description, date, place, and category
- **Example Command:**
  ```bash
  curl -X GET http://localhost:3000/api/v1/events
  ```

### 2. Get Specific Event Details
- **Endpoint:** `GET /api/v1/events/:id`
- **Description:** Retrieves details for a specific event by its ID
- **Parameters:**
  - `:id` - Unique identifier of the event
- **Example Command:**
  ```bash
  curl -X GET http://localhost:3000/api/v1/events/1
  ```

### 3. Check Event Ticket Availability
- **Endpoint:** `GET /api/v1/events/:id/ticket_availability`
- **Description:** Provides detailed ticket availability information for a specific event
- **Parameters:**
  - `:id` - Unique identifier of the event
- **Information Returned:**
  - Total available tickets
  - Details of ticket batches (quantity, price, sale period)
- **Example Command:**
  ```bash
  curl -X GET http://localhost:3000/api/v1/events/1/ticket_availability
  ```

## Private Endpoints (Requires Authentication) 

### 1. User Order History
- **Endpoint:** `GET /api/v1/orders`
- **Description:** Retrieves the order history for the authenticated user
- **Authentication Methods:**
  1. Query Parameter:
     ```bash
     curl -X GET "http://localhost:3000/api/v1/orders?api_token=YOUR_API_TOKEN"
     np. curl -X GET "http://localhost:3000/api/v1/orders?api_token=7bedee52c6091fd3a1e7a3d3c830353e670b38f8958fdc2271af1c6a02b737db"
     ```
  2. Request Header:
     ```bash
     curl -X GET http://localhost:3000/api/v1/orders -H "X-API-Token: YOUR_API_TOKEN"
     ```
- **Information Returned:**
  - Order details
  - User information
  - Ticket batch details
  - Event information

## Authentication

### API Token
- Each user has a unique API token for accessing private endpoints
- Token can be regenerated if needed
- Two ways to authenticate:
  1. Add `api_token` as a query parameter
  2. Send `X-API-Token` in the request header

## Best Practices
- Keep your API token secret
- Use HTTPS in production
- Regenerate token if compromised
- Respect rate limits (if implemented)

## Troubleshooting
- Ensure you're using the correct API token
- Check network connectivity
- Verify the local server is running
- Validate input parameters