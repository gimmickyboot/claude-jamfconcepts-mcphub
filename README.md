# claude-jamfconcepts-mcphub
Configure Claude (macOS) to use Jamf Concepts mcp hub with credentials stored in your Keychain
1. install python3
2. in Terminal, clone the repo and change into the dir

    `git clone https://github.com/Jamf-Concepts/mcp-hub.git`

    `cd mcp-hub`
	
4. setup a virtual env (venv) and activate it

	`python3 -m venv .venv`

	`source .venv/bin/activate`
	
6. install the python requirements

	`pip install -e .`
	
8. deactivate the venv

	`deactivate`
	
10. create the tokens for Jamf Pro (Settings --> System --> API roles and clients), Jamf Protect (Settings --> API Clients) and Jamf Security Cloud (Integrations --> Risk API)
You can use `api-role.json` with the Jamf Pro API (`/v1/api-roles` endpoint) to create a Jamf Pro role with the required roles. Fell free to change `displayName` in the json. Use the gui to create the client and generate the credentials.
Make sure you save the client ids and secrets for the next step. If you don't have/use Jamf Protect or Jamf Security Cloud, you can skip those

11. create the Keychain entries for the 3 products. SKip any that you aren't using
	
	i. open Keychain
	
	ii. File (menu) --> New Password Item...
	
	iii. enter jamf_token for "Keychain Item Name"
	
	iv. enter you Mac's username in "Account Name". Run `echo $USER` in Terminal if you're unsure
	
	v. paste the secret (from step 6)
	
	vi. click Add
	
	vii. repeat with the other 2 tokens. Use protect_token and seccloud_token for "Keychain Item Name"
	
12. create `~/Library/Application Support/Claude/scripts` and copy in `jamf.sh`

13. change the following items in `jamf.sh`. Skip any that you're not using
```
JAMF_PRO_URL - replace <your instance> with your Jamf Cloud instance name or replace the entire URL with your custom/vanity URL
JAMF_PRO_CLIENT_ID - replace <your client id> with your Jamf Pro API client id
JAMF_PROTECT_URL - replace <your instance> with your Jamf Protect instance name. Do NOT add graphql
JAMF_PROTECT_CLIENT_ID - replace <your client id> with your Jamf Protect API client id
JAMF_SECURITY_APP_ID - replace <your client id> with your Jamf Security Cloud Risk API client id
```

10. in `jamf.sh` change `<path to repo>` to the dir where you cloned the repo in step 2. Run `pwd` in Terminal to get the full path to `mcp-hub`

12. quit/open Claude

13. when prompted, enter your Mac password. You can choose to "Always Allow" to stop the prompts each time Claude is opened
    
14. Ask Calude something about your Jmaf products, eg "Please give me a status update on my policies in Jamf Pro" or "Are there any alerts in Jamf Protect that need my attention"
