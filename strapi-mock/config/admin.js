module.exports = ({ env }) => ({
  auth: {
    secret: env('ADMIN_JWT_SECRET'),
  },
  url: env('PUBLIC_ADMIN_URL', '/admin'),
  apiToken: {
    salt: env('API_TOKEN_SALT'),
  },
});
