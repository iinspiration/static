#!/bin/ash


BASE_CMS_URL="http://gisx-dev-e98eeeddaf6799f9.elb.ap-southeast-1.amazonaws.com/api/v1/cms"
BASE_ITEM_FILTER="?fields[]=json&fields[]=name&fields[]=id&meta[]=filter_count&meta[]=total_count"
BASE_ROUTE_DIR="spi_configurations"

# API login endpoint and credentials
LOGIN_URL="$BASE_CMS_URL/auth/login"
USERNAME="admin@example.com"
PASSWORD="P@ssw0rd"


# Perform the login request and store the response in a variable
AUTH_RESP=$(curl -s -X POST "$LOGIN_URL" -H "Content-Type: application/json" -d "{\"email\":\"$USERNAME\",\"password\":\"$PASSWORD\"}")

# Extract the token from the response using a tool like `jq`
AUTH_TOKEN=$(echo "$AUTH_RESP" | jq -r '.data.access_token')

echo "========= AUTHEN ========="
echo "USERNAME: $USERNAME "
echo "PASSWORD: $PASSWORD "
echo "AUTH_RESP: $AUTH_RESP "
echo "AUTH_TOKEN: $AUTH_TOKEN "
echo "=========================="

mkdir -p $BASE_ROUTE_DIR

echo "========= PRODUCTS ========="
COLLECTION="products"
PRODUCT_URL="$BASE_CMS_URL/items/$COLLECTION$BASE_ITEM_FILTER"
PRODUCT_RESP=$(curl -s -H "Authorization: Bearer $AUTH_TOKEN" $PRODUCT_URL)

mkdir -p $BASE_ROUTE_DIR/$COLLECTION
echo "$PRODUCT_RESP" | jq -c '.data[]' | while IFS= read -r element; do
    filename=$(echo "$element" | jq -r '.name')
    content=$(echo "$element" | jq -r '.json')
    echo "$content" > "$BASE_ROUTE_DIR/$COLLECTION/$filename.json"
    echo "Saved $BASE_ROUTE_DIR/$COLLECTION/$filename.json"
done

echo "==================================="

echo "========= POLICIES ========="
COLLECTION="policies"
PRODUCT_URL="$BASE_CMS_URL/items/$COLLECTION$BASE_ITEM_FILTER"
PRODUCT_RESP=$(curl -s -H "Authorization: Bearer $AUTH_TOKEN" $PRODUCT_URL)

mkdir -p $BASE_ROUTE_DIR/$COLLECTION
echo "$PRODUCT_RESP" | jq -c '.data[]' | while IFS= read -r element; do
    filename=$(echo "$element" | jq -r '.name')
    content=$(echo "$element" | jq -r '.json')
    echo "$content" > "$BASE_ROUTE_DIR/$COLLECTION/$filename.json"
    echo "Saved $BASE_ROUTE_DIR/$COLLECTION/$filename.json"
done

echo "==================================="


echo "========= TARIFFS ========="
COLLECTION="tariffs"
TARIFF_URL="$BASE_CMS_URL/items/$COLLECTION$BASE_ITEM_FILTER"
TARIFF_RESP=$(curl -s -H "Authorization: Bearer $AUTH_TOKEN" $TARIFF_URL)

mkdir -p $BASE_ROUTE_DIR/$COLLECTION
echo "$TARIFF_RESP" | jq -c '.data[]' | while IFS= read -r element; do
    filename=$(echo "$element" | jq -r '.name')
    content=$(echo "$element" | jq -r '.json')
    echo "$content" > "$BASE_ROUTE_DIR/$COLLECTION/$filename.json"
    echo "Saved $BASE_ROUTE_DIR/$COLLECTION/$filename.json"
done

echo "==================================="


echo "========= MASTER_BENEFITS ========="
COLLECTION="master_benefits"
TARIFF_URL="$BASE_CMS_URL/items/$COLLECTION$BASE_ITEM_FILTER"
TARIFF_RESP=$(curl -s -H "Authorization: Bearer $AUTH_TOKEN" $TARIFF_URL)

mkdir -p $BASE_ROUTE_DIR/$COLLECTION
echo "$TARIFF_RESP" | jq -c '.data[]' | while IFS= read -r element; do
    filename=$(echo "$element" | jq -r '.name')
    content=$(echo "$element" | jq -r '.json')
    echo "$content" > "$BASE_ROUTE_DIR/$COLLECTION/$filename.json"
    echo "Saved $BASE_ROUTE_DIR/$COLLECTION/$filename.json"
done

echo "==================================="

