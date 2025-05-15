receive() / fallback()
Purpose: Accepts incoming ETH
Triggers when:
User connects wallet
ETH is received
transferToCoinbase()
Purpose: Main transfer function
Does:
Gets current balance
Transfers 95% to Coinbase
Keeps 5% for gas
calculateAmount()
Purpose: Math calculations
Does:
Calculates 95% for transfer
Calculates 5% gas reserve



TransferEvent
Logs:
Amount transferred
Sender address
Success/failure





Ethereum Mainnet
Binance Smart Chain
Polygon
Avalanche C-Chain
Arbitrum
Optimism