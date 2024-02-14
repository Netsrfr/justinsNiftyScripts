# Microsoft Temporary Access Pass
A temporary pass can be provided to users to complete multi-factor authentication when the have not previously configured a multi-factor authentication method or their previously configured method becomes unavailable.

1. Navigate to Users in [Microsoft Entra ID](https://portal.azure.com/#view/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/~/Overview).
2. Select the user.
	1. Select **Manage** -> **Authentication methods** 
	2. Select **+ Add authentication method**
3. From the *Choose method* drop-down, select **Temporary Access Pass**.
	1. The *Activation duration* should be set to the minimum duration necessary for the user to complete authentication. If a user is not available to complete authentication immediately, a *Delayed start time* can be configured to activate the pass at a specific time.
	2. Set **One-time use** to **Yes**.
		1. The temporary access pass must be a one-time use access pass. If a multi-use access pass is generated, the user will receive an error when attempting to complete multi-factor authentication and a new one-time access pass will need to be generated.
		2. Only one temporary access pass can be active for a user at any time.
	3. Select **Add**
4. Provide the user with the temporary access pass.

It may take a few minutes for *Temporary Access Pass* to display as an available authentication method. It is recommended that the user use the temporary access pass to configure Microsoft Authenticator on their mobile device so that they can complete additional verification prompts as needed. If *Temporary Access Pass* is not an available authentication method in Microsoft Authenticator, have the user quit and re-launch the application.

If a user does not complete the authentication flow after redeeming the temporary access pass or the user redeems the temporary access pass to sign into a third-party service using SSO, a new access pass will need to be generated to allow the user to configure a multi-factor authentication method.