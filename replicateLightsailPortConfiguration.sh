#!/bin/bash
# Replace the network configuration for a Lightsail instance with the network configuration from another instance.
# This does not add/update ports and will replace the network configuration with the configuration of the source instance.


# Initialize variables with default values
PROFILE="codence"

# Function to display script usage
usage() {
    echo "Usage: $0 [OPTIONS]"
    echo "Required arguments:"
    echo "  -s, --source VALUE   Specify the source instance name"
    echo "  -t, --target VALUE   Specify the target instance name"

    echo "Optional arguments:"
    echo "  -p, --profile VALUE    Specify the port (Default: codence)"
    echo "  --help                 Display this help message"
    exit 1
}

# Loop through all arguments provided on the command line
while [[ $# -gt 0 ]]; do
    case "$1" in
        -s|--source)
            # Check if a value follows the flag and isn't another flag
            if [[ -z "$2" || "$2" == -* ]]; then
                echo "Error: Argument for $1 is missing." >&2
                usage
            fi
            SOURCE="$2"
            shift 2
            ;;
        -t|--target)
            # Check if a value follows the flag and isn't another flag
            if [[ -z "$2" || "$2" == -* ]]; then
                echo "Error: Argument for $1 is missing." >&2
                usage
            fi
            TARGET="$2"
            shift 2
            ;;
        -p|--profile)
            if [[ -z "$2" || "$2" == -* ]]; then
                echo "Error: Argument for $1 is missing." >&2
                usage
            fi
            PROFILE="$2"
            shift 2
            ;;
        --help)
            usage
            ;;
        *)
            echo "Unknown option: $1" >&2
            usage
            ;;
    esac
done

# ==============================================================================
# VALIDATION: Enforce Required Arguments
# ==============================================================================
# This catches cases where the flag was completely omitted from the command line
if [[ -z "$SOURCE" ]]; then
  echo "Error: The required --source (-s) flag was not provided." >&2
  usage
  exit
elif [[ -z "$TARGET" ]]; then
  echo "Error: The required --target (-t) flag was not provided." >&2
  usage
  exit
fi

# --- Main Script Execution ---
echo "The instance '$TARGET' network configuration will be replaced with the network configuration from instance '$SOURCE':"
while true; do
    read -p "Overwrite $TARGET network configuration? (y/n): " yn
    case $yn in
        [Yy]* ) echo "Replacing port states on $TARGET with the port states from $SOURCE:"; break;;
        [Nn]* ) echo "Exiting..."; exit;;
        * ) echo "Please answer yes or no.";;
    esac
done


aws --profile $PROFILE lightsail get-instance-port-states --instance-name $SOURCE --query '{portInfos: portStates[*].{fromPort: fromPort,toPort: toPort,protocol: protocol, cidrs: cidrs, ipv6Cidrs: ipv6Cidrs, cidrListAliases: cidrListAliases}}' > $SOURCE.json
aws --profile $PROFILE lightsail put-instance-public-ports --instance-name $TARGET --cli-input-json file://$SOURCE.json
rm $SOURCE.json