# claude-jamfconcepts-mcphub
Configure Claude (macOS) to use Jamf Concepts mcp hub with credentials stored in your Keychain
1. install python3
2. in Terminal, clone the repo and change into the dir

    `git clone https://github.com/Jamf-Concepts/mcp-hub.git`

    `cd mcp-hub`
	
3. setup a virtual env (venv) and activate it

	`python3 -m venv .venv`

	`source .venv/bin/activate`
	
4. install the python requirements

	`pip install -e .`
	
5. deactivate the venv

	`deactivate`
	
6. create the tokens for Jamf Pro (Settings --> System --> API roles and clients), Jamf Protect (Settings --> API Clients) and Jamf Security Cloud (Integrations --> Risk API)
You can use `api-role.json` with the Jamf Pro API (`/v1/api-roles` endpoint) to create a Jamf Pro role with the required roles. Fell free to change `displayName` in the json. Use the gui to create the client and generate the credentials.
Make sure you save the client ids and secrets for the next step. If you don't have/use Jamf Protect or Jamf Security Cloud, you can skip those

7. create the Keychain entries for the 3 products. SKip any that you aren't using
	
	i. open Keychain
	
	ii. File (menu) --> New Password Item...
	
	iii. enter jamf_token for "Keychain Item Name"
	
	iv. enter your API client ID in "Account Name"
	
	v. paste the secret (from step 6)
	
	vi. click Add
	
	vii. repeat with the other 2 tokens. Use protect_token and seccloud_token for "Keychain Item Name"
	
8. create `~/Library/Application Support/Claude/scripts` and copy in `jamf.sh`

9. edit the three variables as indicated
```
JAMF_PRO_URL="<full Jamf Pro URL>" - eg https://myjamf.jamfcloud.com
JAMF_PROTECT_INSTANCE_NAME="<protect instance name" - eg myjamf
GITHUB_PATH="<path to cloned mcp-hub repo" - eg /Users/myusername/mcp-hub. Run pwd in Terminal where you cloned the mcp-hub repo in step 2
```

10. add the following json to ~/Library/Application Support/Claude/claude_desktop_config.json. Replace `<Mac username>` with your local Mac username. Run `echo $USER` in Terminal if you're unsure
```
"mcpServers": {
	"jamf": {
		"command": "sh",
		"args": [
			"/Users/<Mac username>/Library/Application Support/Claude/scripts/jamf.sh"
		]
	}
}
```

11. quit/open Claude

12. when prompted, enter your Mac password. You can choose to "Always Allow" to stop the prompts each time Claude is opened
    
13. Ask Calude something about your Jamf products, eg "Please give me a status update on my policies in Jamf Pro" or "Are there any alerts in Jamf Protect that need my attention"
