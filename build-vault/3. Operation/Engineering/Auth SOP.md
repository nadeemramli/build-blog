---
draft: false
title: Auth SOP
date: 2025-02-08
tags:
---
Latest: 4.2 (Done!)

Auth:
1. User Interface and Experience
	1. Adding Google Auth
	2. Session Management (remember option to keep users logged in)
	3. Session Expiry
	4. Privacy Policy and Terms of Service confirmation and user agreement during sign up.
2. Security Enhancement
	1. Rate Limiting: Implement rate limiting to prevent brute-force attacks on login attempts.
	2. Password Strength Indicator: Provide real-time feedback on password strength to encourage users to use stronger passwords.
	3. Account Lockout Policy: After several failed login attempts, temporarily lock the account or require CAPTCHA.
3. Error Handling and Feedbacks
	1. Sign up dialog (confirmation of signing up success and ask user to check email for confirmation)
	2. Forgot Password (explanation, as of now when user try to reset their password, after they input their email, there's nothing happen, despite they will get an email asking for reset password, there must be a message to tell the user to check the email, or that forgot password request is successful)
	3. Wrong Password / Account have not created etc (a detailed error messages, telling either the email not yet verified, no account with this email, invalid credential for wrong password)

Implementing email verification handling
- Adding password reset functionality
1. Copywriting for Sign Up : email


SPA/Better Flow
1. Sign Up
2. Verify Email - Confirm at Email
3. Re-login with verified email
4. Need to update email CSS/HTML using Resend for this matter.