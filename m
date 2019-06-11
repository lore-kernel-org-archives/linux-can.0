From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: RE: [PATCH] can: flexcan: fix deadlock when using self wakeup
Date: Tue, 11 Jun 2019 07:21:28 +0000
Message-ID: <DB7PR04MB46189DAF8C292DD7F00718F8E6ED0@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <20190517023652.19285-1-qiangqing.zhang@nxp.com>
 <fbbe474f-bdf7-a97a-543d-da17dfd2a114@geanix.com>
 <DB7PR04MB46181EE74BF030D728042FD6E6ED0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <23fcfa1b-a664-7768-a793-26627b14463e@geanix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <23fcfa1b-a664-7768-a793-26627b14463e@geanix.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Sean Nyekjaer <sean@geanix.com>
Cc: "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "wg@grandegger.com" <wg@grandegger.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNlYW4gTnlla2phZXIgPHNl
YW5AZ2Vhbml4LmNvbT4NCj4gU2VudDogMjAxOeW5tDbmnIgxMeaXpSAxNTowOA0KPiBUbzogSm9h
a2ltIFpoYW5nIDxxaWFuZ3FpbmcuemhhbmdAbnhwLmNvbT4NCj4gQ2M6IG1rbEBwZW5ndXRyb25p
eC5kZTsgbGludXgtY2FuQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14DQo+IDxsaW51eC1p
bXhAbnhwLmNvbT47IHdnQGdyYW5kZWdnZXIuY29tOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnDQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGNhbjogZmxleGNhbjogZml4IGRlYWRsb2NrIHdoZW4gdXNp
bmcgc2VsZiB3YWtldXANCj4gDQo+IA0KPiANCj4gT24gMTEvMDYvMjAxOSAwOC41OCwgSm9ha2lt
IFpoYW5nIHdyb3RlOg0KPiA+Pg0KPiA+PiBIb3cgaXMgaXQgZ29pbmcgd2l0aCB0aGUgdXBkYXRl
ZCBwYXRjaD8NCj4gPg0KPiA+IEhpIFNlYW4sDQo+ID4NCj4gPiAJSSBzdGlsbCBuZWVkIGRpc2N1
c3Mgd2l0aCBNYXJjIGFib3V0IHRoZSBzb2x1dGlvbi4NCj4gPg0KPiA+IEpvYWtpbSBaaGFuZw0K
PiANCj4gSGksIEpvYWtpbQ0KPiANCj4gUGxlYXNlIGluY2x1ZGUgbWUgaW4gdGhlIGxvb3AgOi0p
DQoNCk9rYXksIHdpbGwgYWRkIHlvdSBpZiBhbnl0aGluZyB1cGRhdGUuDQoNCkpvYWtpbSBaaGFu
Zw0KPiANCj4gL1NlYW4NCg==
