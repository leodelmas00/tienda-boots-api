-- Migration: Add rol column to Cliente table
-- Default role is 'cliente'. Set to 'admin' for admin users.

ALTER TABLE Cliente
ADD COLUMN rol VARCHAR(20) NOT NULL DEFAULT 'cliente';

-- Example: make a specific user an admin
-- UPDATE Cliente SET rol = 'admin' WHERE username = 'admin_user';
