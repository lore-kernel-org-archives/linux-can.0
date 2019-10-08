From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: RE: [PATCH REPOST 1/2] can: flexcan: fix deadlock when using self
 wakeup
Date: Tue, 8 Oct 2019 10:20:59 +0000
Message-ID: <DB7PR04MB4618DEF0873D110536724818E69A0@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <20190816081749.19300-1-qiangqing.zhang@nxp.com>
 <20190816081749.19300-2-qiangqing.zhang@nxp.com>
 <dd8f5269-8403-702b-b054-e031423ffc73@geanix.com>
 <DB7PR04MB4618A1F984F2281C66959B06E6AB0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <35190c5b-f8be-8784-5b4f-32a691a6cffe@geanix.com>
 <6a9bc081-334a-df91-3a23-b74a6cdd3633@geanix.com>
 <DB7PR04MB4618E527339B69AEAD46FB06E6A20@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <588ab34d-613d-ac01-7949-921140ca4543@geanix.com>
 <DB7PR04MB461868320DA0B25CC8255213E6BB0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <739eee2e-2919-93b4-24fe-8d0d198ae042@geanix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <739eee2e-2919-93b4-24fe-8d0d198ae042@geanix.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Sean Nyekjaer <sean@geanix.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, =?utf-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@geanix.com>
List-Id: linux-can.vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNlYW4gTnlla2phZXIgPHNl
YW5AZ2Vhbml4LmNvbT4NCj4gU2VudDogMjAxOeW5tDnmnIgxMOaXpSAxNTo1Mw0KPiBUbzogSm9h
a2ltIFpoYW5nIDxxaWFuZ3FpbmcuemhhbmdAbnhwLmNvbT47IG1rbEBwZW5ndXRyb25peC5kZTsN
Cj4gbGludXgtY2FuQHZnZXIua2VybmVsLm9yZw0KPiBDYzogd2dAZ3JhbmRlZ2dlci5jb207IG5l
dGRldkB2Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5jb20+
OyBNYXJ0aW4gSHVuZGViw7hsbCA8bWFydGluQGdlYW5peC5jb20+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggUkVQT1NUIDEvMl0gY2FuOiBmbGV4Y2FuOiBmaXggZGVhZGxvY2sgd2hlbiB1c2luZyBz
ZWxmDQo+IHdha2V1cA0KPiANCj4gDQo+IA0KPiBPbiAwNS8wOS8yMDE5IDA5LjEwLCBKb2FraW0g
Wmhhbmcgd3JvdGU6DQo+ID4gSGkgU2VhbiwNCj4gPg0KPiA+IENvdWxkIHlvdSB1cGRhdGUgbGFz
dGVzdCBmbGV4Y2FuIGRyaXZlciB1c2luZyBsaW51eC1jYW4tbmV4dC9mbGV4Y2FuIGFuZCB0aGVu
DQo+IG1lcmdlIGJlbG93IHR3byBwYXRjaGVzIGZyb20gbGludXgtY2FuL3Rlc3Rpbmc/DQo+ID4g
ZDBiNTM2MTY3MTZlIChIRUFEIC0+IHRlc3RpbmcsIG9yaWdpbi90ZXN0aW5nKSBjYW46IGZsZXhj
YW46IGFkZCBMUFNSDQo+ID4gbW9kZSBzdXBwb3J0IGZvciBpLk1YN0QgODAzZWI2YmFkNjViIGNh
bjogZmxleGNhbjogZml4IGRlYWRsb2NrIHdoZW4NCj4gPiB1c2luZyBzZWxmIHdha2V1cA0KPiA+
DQo+ID4gQmVzdCBSZWdhcmRzLA0KPiA+IEpvYWtpbSBaaGFuZw0KPiANCj4gSGkNCj4gDQo+IEkg
cmV2ZXJ0ZWQgMiBjb21taXRzIG9uIHRodyBuYW5kIGRyaXZlciBhbmQgZ290IHRoZSB0ZXN0aW5n
IGtlcm5lbCB0byB3b3JrLg0KPiANCj4gSSBjYW4gY29uZmlybSB0aGUgaXNzdWUgaXMgcmVzb2x2
ZWQgd2l0aCB0aGlzIHBhdGNoIDotKQ0KDQpIaSBNYXJjLA0KDQpIb3cgYWJvdXQgdGhlc2UgdHdv
IGZpeGVzIGZvciBGbGV4Y2FuPw0KDQpCZXN0IFJlZ2FyZHMsDQpKb2FraW0gWmhhbmcNCj4gL1Nl
YW4NCg==
