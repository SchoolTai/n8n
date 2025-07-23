# 步驟 1: 從 n8n 官方發布的、最新的 Debian 映像開始
FROM n8nio/n8n:latest-debian

# 步驟 2: 強制切換到 root 使用者，並且不再切換回來
USER root

# 步驟 3: 將我們的 package.json 複製到一個臨時目錄
COPY package.json /tmp/

# 步驟 4: 在該臨時目錄下為 root 使用者安裝 ethers
RUN npm install --prefix /tmp/

# 步驟 5: 將安裝好的 ethers 模組複製到 n8n 的全域模組路徑
# 這是最關鍵的一步，確保 n8n 能找到它
RUN cp -r /tmp/node_modules/* /usr/local/lib/node_modules/

# 由於我們始終是 root，不再需要 chown 或 USER node 指令
# 基礎映像內建的 CMD 指令將會以 root 身份執行


