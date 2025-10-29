*** Variables ***
# URLs
${API_BASE_URL}         http://localhost:5000/api/v1
${FRONTEND_URL}         http://localhost:3002
${MONGO_URI}            mongodb://127.0.0.1:27017/cinema

# Timeouts
${DEFAULT_TIMEOUT}      10s
${LONG_TIMEOUT}         30s

# Test Data
${VALID_USER_EMAIL}     test@example.com
${VALID_USER_PASS}      password123
${ADMIN_EMAIL}          admin@cinema.com
${ADMIN_PASS}           admin123

# Browser Settings
${BROWSER}              Chrome
${HEADLESS}             False
${WINDOW_SIZE}          1920x1080

# Performance Thresholds
${MAX_RESPONSE_TIME}    2000
${MAX_PAGE_LOAD}        5000