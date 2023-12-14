# Liquid Staking

On a high level, they all work the same way. 

* Users deposit ETH into the platform's smart contract and get the "representation token" in return, which they can trade as usual in the market. 

* The contract will delegate the locked ETH to differnt node operators (according to contract logic). 

* The node operators will stake the ETH on the Beacon Chain on behalf of the users.

* Users can burn the "representation token" to get back to ETH and reward, or choose to the sell these token for profit.


### Platform Comparsion

The following is a short comparsion of three LS service platforms -- Lido, Rocketpool and Mantle.


|         | Minimum threshold    | Supported Network    | Node operator Permission    | Reward fee    | Token    |
| :---   | :--- | :--- | :--- | :--- | :--- |
| Libo | None   | Ethereum, Solana, Kusama, Polygon and Polkadot   | Have to go through the DAO to get added into the Node Operator list   | 10%   | rebase    |
| Rocketpool | 0.01 ETH   | Ethereum   | No DAO is needed   | 14%   | non-rebase    |
| Mantle | 0.02 ETH   | Ethereum   | No DAO is needed   | 10%   | non-rebase    |



### Rebase vs Non-Rebase Token

- One of the most obvious obstacle for implementing rebase token is complexity. It requires the project to have deep understanding on the underlying technology to work. While non-rebase token is pretty straightforward to implement.

- One of the advantage of rebase tokens is their ability to maintain price stability. However, in some cases the price of rebase tokens can still fluctuate significantly, and there is no guarantee that they will be able to maintain a stable price over the long term. So this advantage is not as obvious as one may expect.

- With rebase token, users don't have to interact with the defi protocol to claim the reward because the token will be rebased to reflect the reward. This may look attractive for projects that want to redistribute the value from time to time.


A bit of cliché to summarize, there is no clear cut answer which one is better. It all depends on how it is being implemented.

### Other Defi protocol to consider/research

#### Indigo Protocol (Cardano)

Indigo allows anyone to create synthetic assets, known as iAssets. iAssets can be created using currencies such as stablecoins and ADA. They have the same price effect as holding the asset being replicated. This allows you to gain profit from the increase in price of an asset without owning the original asset itself.

The usage is very obvious. If I am bullish on BTC and want to hold it, I have to literally purchase it, which would involve going to some exchange to buy it and withdraw back to my btc wallet, which also means I have to interact with the BTC network. With Indigo, I can simply mint iBTC directly on Cardano. If I want ETH, I can mint iETH as well. Many more iAsset are coming in the future.