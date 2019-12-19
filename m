From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: RE: [PATCH V2 1/2] can: flexcan: disable runtime PM if register
 flexcandev failed
Date: Thu, 19 Dec 2019 04:59:58 +0000
Message-ID: <VI1PR04MB46223042279D18D20C955881E6520@VI1PR04MB4622.eurprd04.prod.outlook.com>
References: <20191210085721.9853-1-qiangqing.zhang@nxp.com>
 <DB7PR04MB46181D2F1538A53B4F1892E2E6500@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <935f466b-a9c9-de73-be12-6ebb7b77e058@geanix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <935f466b-a9c9-de73-be12-6ebb7b77e058@geanix.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Sean Nyekjaer <sean@geanix.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNlYW4gTnlla2phZXIgPHNl
YW5AZ2Vhbml4LmNvbT4NCj4gU2VudDogMjAxOcTqMTLUwjE4yNUgMjI6MDQNCj4gVG86IEpvYWtp
bSBaaGFuZyA8cWlhbmdxaW5nLnpoYW5nQG54cC5jb20+OyBta2xAcGVuZ3V0cm9uaXguZGU7DQo+
IGxpbnV4LWNhbkB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGRsLWxpbnV4LWlteCA8bGludXgtaW14
QG54cC5jb20+OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
VjIgMS8yXSBjYW46IGZsZXhjYW46IGRpc2FibGUgcnVudGltZSBQTSBpZiByZWdpc3Rlcg0KPiBm
bGV4Y2FuZGV2IGZhaWxlZA0KPiANCj4gDQo+IA0KPiBPbiAxNy8xMi8yMDE5IDA3LjM2LCBKb2Fr
aW0gWmhhbmcgd3JvdGU6DQo+ID4NCj4gPiBIaSBTZWFuLA0KPiA+DQo+ID4gSGF2ZSB5b3UgZm91
bmQgdGltZSB0byB0ZXN0IHRoaXMgcGF0Y2ggc2V0PyBUaGFua3MgOi0pDQo+ID4NCj4gPiBCZXN0
IFJlZ2FyZHMsDQo+ID4gSm9ha2ltIFpoYW5nDQo+ID4NCj4gDQo+IEhpIEpvYWtpbQ0KPiANCj4g
U29ycnkgZm9yIHRoZSBkZWxheSA6KQ0KPiANCj4gSSBoYXZlIHRlc3RlZCB0aGlzIHBhdGNoc2V0
IGFuZCBmb3VuZCBubyBpc3N1ZXMuLi4NClRoYW5rcyBhIGxvdCBmb3IgeW91ciB0ZXN0LCBTZWFu
IDotKQ0KDQo+IEp1c3QgYSBoZWFkcyB1cCB3aGVuIGFkZGluZyAiQ2hhbmdlTG9nOiIgZG8gaXQg
dW5kZXIgdGhlICItLS0iIGFuZCBhYm92ZSB0aGUNCj4gZGlmZi4gVGhhdCB3YXkgdGhlIENoYW5n
ZUxvZyBkb2Vzbid0IGVuZCB1cCBpbiB0aGUgY29tbWl0IG1zZy4uLg0KSSB3aWxsIGtlZXAgaW4g
bWluZCwgcGF5IGF0dGVudGlvbiB0byBpdCBuZXh0IHRpbWUuDQoNCkJlc3QgUmVnYXJkcywNCkpv
YWtpbSBaaGFuZw0KPiAvU2Vhbg0KPiANCg0K
