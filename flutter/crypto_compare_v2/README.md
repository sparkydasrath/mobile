# Crypto Snapshot
(Renamed from Crypto Compare)

This next iteration contains much nore info than the previous, which only had a single currency/price pair. The coins and currencies requested are still hard coded to fixed set (https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,EOS,BCH,XRP,LTC,ETC&tsyms=USD,EUR,GBP,JPY");

There are several improvements that can be made:
1. Instead of a manual refresh, have data streaming in BUT that has to the job of some sort of app server. Additionally, to make this smarter, you would only want to get data based on the visible items. Futhermore, once you get the first snapshot on app startup, it would be better for the app server to send you update objects rather than the full ones from the crypto api to reduce network load.
2. Make the currency price tick. Again, this is best done on the app server side where you can cache the items and as new ones come in, compare the prices and send a up/down notice to the client. As such, all you have to do is animate a color change only.
3. Fix expanders auto closing. This happens if you expand an item, scroll down, expand another and scroll so that none of the first expander (and children) is in view. When you scroll back up, the expander is closed.
4. Smart UI update. When debugging I see that the widgets are recreated on each update. Ideally, I would like to avoid that and update just some fields but not sure just yet.
5. Preferences - allow user to set default list of coins and currencies to get data for
6. Change layout when in landscape mode
7. Add some more color 



[Trello Board](https://trello.com/b/izp7FogS)
