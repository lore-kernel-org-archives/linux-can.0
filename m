From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: RE: [PATCH REPOST 1/2] can: flexcan: fix deadlock when using self
 wakeup
Date: Thu, 5 Sep 2019 07:10:35 +0000
Message-ID: <DB7PR04MB461868320DA0B25CC8255213E6BB0@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <20190816081749.19300-1-qiangqing.zhang@nxp.com>
 <20190816081749.19300-2-qiangqing.zhang@nxp.com>
 <dd8f5269-8403-702b-b054-e031423ffc73@geanix.com>
 <DB7PR04MB4618A1F984F2281C66959B06E6AB0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <35190c5b-f8be-8784-5b4f-32a691a6cffe@geanix.com>
 <6a9bc081-334a-df91-3a23-b74a6cdd3633@geanix.com>
 <DB7PR04MB4618E527339B69AEAD46FB06E6A20@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <588ab34d-613d-ac01-7949-921140ca4543@geanix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <588ab34d-613d-ac01-7949-921140ca4543@geanix.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Sean Nyekjaer <sean@geanix.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, =?utf-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@geanix.com>
List-Id: linux-can.vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNlYW4gTnlla2phZXIgPHNl
YW5AZ2Vhbml4LmNvbT4NCj4gU2VudDogMjAxOeW5tDnmnIg15pelIDEzOjU4DQo+IFRvOiBKb2Fr
aW0gWmhhbmcgPHFpYW5ncWluZy56aGFuZ0BueHAuY29tPjsgbWtsQHBlbmd1dHJvbml4LmRlOw0K
PiBsaW51eC1jYW5Admdlci5rZXJuZWwub3JnDQo+IENjOiB3Z0BncmFuZGVnZ2VyLmNvbTsgbmV0
ZGV2QHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14DQo+IDxsaW51eC1pbXhAbnhwLmNvbT47
IE1hcnRpbiBIdW5kZWLDuGxsIDxtYXJ0aW5AZ2Vhbml4LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCBSRVBPU1QgMS8yXSBjYW46IGZsZXhjYW46IGZpeCBkZWFkbG9jayB3aGVuIHVzaW5nIHNl
bGYNCj4gd2FrZXVwDQo+IA0KPiANCj4gDQo+IE9uIDI5LzA4LzIwMTkgMDkuMzAsIEpvYWtpbSBa
aGFuZyB3cm90ZToNCj4gPiBIaSBTZWFuLA0KPiA+DQo+ID4gSSdtIHNvcnJ5IHRoYXQgSSBjYW4n
dCBnZXQgdGhlIGRlYnVnIGxvZyBhcyB0aGUgc2l0ZSBjYW4ndCBiZSByZWFjaGVkLiBBbmQgSQ0K
PiBjb25uZWN0IHR3byBib2FyZHMgdG8gZG8gdGVzdCBhdCBteSBzaWRlLCB0aGlzIGlzc3VlIGNh
bid0IGJlIHJlcHJvZHVjZWQuDQo+ID4NCj4gPiBCZXN0IFJlZ2FyZHMsDQo+ID4gSm9ha2ltIFpo
YW5nDQo+IA0KPiBIaSBKb2FraW0sDQo+IA0KPiBXaGF0IGNvbW1pdCBhbmQgYnJhbmNoIGFyZSB5
b3UgZG9pbmcgeW91ciB0ZXN0cyB3aXRoPw0KDQpIaSBTZWFuLA0KDQpDb3VsZCB5b3UgdXBkYXRl
IGxhc3Rlc3QgZmxleGNhbiBkcml2ZXIgdXNpbmcgbGludXgtY2FuLW5leHQvZmxleGNhbiBhbmQg
dGhlbiBtZXJnZSBiZWxvdyB0d28gcGF0Y2hlcyBmcm9tIGxpbnV4LWNhbi90ZXN0aW5nPw0KZDBi
NTM2MTY3MTZlIChIRUFEIC0+IHRlc3RpbmcsIG9yaWdpbi90ZXN0aW5nKSBjYW46IGZsZXhjYW46
IGFkZCBMUFNSIG1vZGUgc3VwcG9ydCBmb3IgaS5NWDdEDQo4MDNlYjZiYWQ2NWIgY2FuOiBmbGV4
Y2FuOiBmaXggZGVhZGxvY2sgd2hlbiB1c2luZyBzZWxmIHdha2V1cA0KDQpCZXN0IFJlZ2FyZHMs
DQpKb2FraW0gWmhhbmcNCj4gL1NlYW4NCg==
