# JWT Rails API

A learning project focused on implementing JWT (JSON Web Token) authentication in a Ruby on Rails API. This app prioritizes understanding how stateless authentication works over production-readiness — database constraints, validations, uniqueness checks, and error handling are intentionally omitted to keep the focus on JWT fundamentals.

# Testing JWT Authentication with cURL

A step-by-step guide to testing JWT Rails API using cURL commands.

## 1. Create Sample Data

Open the Rails console:

```bash
rails console
```

Create a test user and product:

```ruby
User.create(username: "emi", password: "password")
Product.create(name: "Rad Ruby", description: "A book collection of Ruby tips")
```

Exit the console with `exit`.

---

## 2. Test Login with Invalid Credentials

Try logging in with a user that doesn't exist:

```bash
curl -H "Content-Type: application/json" \
  -X POST \
  -d '{"username":"manny","password":"password"}' \
  http://localhost:3000/login
```

**Expected response:**

```json
{"error":"unauthorized"}
```

---

## 3. Test Login with Valid Credentials

Log in with the user we created:

```bash
curl -H "Content-Type: application/json" \
  -X POST \
  -d '{"username":"emi","password":"password"}' \
  http://localhost:3000/login
```

**Expected response** (your token will be different):

```json
{
  "token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE2ODU0NTEyMTR9.1UEYAbmFOSF93yp9pJqNEzkdHr3rVqutPNZWRIPDYkY",
  "expires_at": 1685432077
}
```

Save this token — you'll need it for the next steps.

---

## 4. Test Accessing Products with a Bad Token

Try accessing the products endpoint with a tampered token (change a random character):

```bash
curl -H "Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE2ODU0NTEyMTR9.1UEYAbmFOSF93yp9pJqNEzkdHr3rVqutPNZWRIPZYkY" \
  http://localhost:3000/products
```

**Expected response:**

```json
{"decode_error":"decode error"}
```

This confirms that tampered tokens are rejected.

---

## 5. Test Accessing Products with a Valid Token

Use the valid token you received in Step 3:

```bash
curl -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  http://localhost:3000/products
```

**Expected response:**

```json
[
  {
    "id": 1,
    "name": "Rad Ruby",
    "description": "A book collection of Ruby tips",
    "created_at": "2023-05-29T19:33:30.826Z",
    "updated_at": "2023-05-29T19:33:30.826Z"
  }
]
```

Access granted to the protected product resource.

---

## Summary

| Test | Expected Result |
|------|-----------------|
| Login with bad credentials | `{"error":"unauthorized"}` |
| Login with good credentials | Returns a signed JWT token |
| Access products with tampered token | `{"decode_error":"decode error"}` |
| Access products with valid token | Returns product data |


