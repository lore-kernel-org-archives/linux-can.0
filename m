From: Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [PATCH V2 1/1] can: sja1000: f81601: add Fintek F81601 support
Date: Wed, 24 Jul 2019 19:46:45 +0000
Message-ID: <bbe907bf7fa1ebe1adfd6bdc9887e4c41ff624bd.camel@mellanox.com>
References: <1563776521-28317-1-git-send-email-hpeter+linux_kernel@gmail.com>
         <bb38703fa94f19578ac67f763bb1a0ad34196757.camel@mellanox.com>
         <37a8be8d-3ce7-e983-93da-35413cfb5da1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <37a8be8d-3ce7-e983-93da-35413cfb5da1@gmail.com>
Content-Language: en-US
Content-ID: <18B299C888EC964D8E66BC19C63FE5D5@eurprd05.prod.outlook.com>
Sender: netdev-owner@vger.kernel.org
To: "peter_hong@fintek.com.tw" <peter_hong@fintek.com.tw>, "wg@grandegger.com" <wg@grandegger.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "hpeter@gmail.com" <hpeter@gmail.com>
Cc: "hpeter+linux_kernel@gmail.com" <hpeter+linux_kernel@gmail.com>, "f.suligoi@asem.it" <f.suligoi@asem.it>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

T24gV2VkLCAyMDE5LTA3LTI0IGF0IDEzOjE5ICswODAwLCBKaS1aZSBIb25nIChQZXRlciBIb25n
KSB3cm90ZToNCj4gSGksDQo+IA0KPiBTYWVlZCBNYWhhbWVlZCDmlrwgMjAxOS83LzI0IOS4iuWN
iCAwNTozOCDlr6vpgZM6DQo+ID4gT24gTW9uLCAyMDE5LTA3LTIyIGF0IDE0OjIyICswODAwLCBK
aS1aZSBIb25nIChQZXRlciBIb25nKSB3cm90ZToNCj4gPiA+IFRoaXMgcGF0Y2ggYWRkIHN1cHBv
cnQgZm9yIEZpbnRlayBQQ0lFIHRvIDIgQ0FOIGNvbnRyb2xsZXINCj4gPiA+IHN1cHBvcnQNCj4g
PiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogSmktWmUgSG9uZyAoUGV0ZXIgSG9uZykgPA0KPiA+
ID4gaHBldGVyK2xpbnV4X2tlcm5lbEBnbWFpbC5jb20NCj4gPiA+IC0tLQ0KPiA+ID4gQ2hhbmdl
bG9nOg0KPiA+ID4gdjI6DQo+ID4gPiAJMTogRml4IGNvbW1lbnQgb24gdGhlIHNwaW5sb2NrIHdp
dGggd3JpdGUgYWNjZXNzLg0KPiA+ID4gCTI6IFVzZSBBUlJBWV9TSVpFIGluc3RlYWQgb2YgRjgx
NjAxX1BDSV9NQVhfQ0hBTi4NCj4gPiA+IAkzOiBDaGVjayB0aGUgc3RyYXAgcGluIG91dHNpZGUg
dGhlIGxvb3AuDQo+ID4gPiAJNDogRml4IHRoZSBjbGVhbnVwIGlzc3VlIGluIGY4MTYwMV9wY2lf
YWRkX2NhcmQoKS4NCj4gPiA+IAk1OiBSZW1vdmUgdW51c2VkICJjaGFubmVscyIgaW4gc3RydWN0
IGY4MTYwMV9wY2lfY2FyZC4NCj4gPiA+IA0KPiA+ID4gICBkcml2ZXJzL25ldC9jYW4vc2phMTAw
MC9LY29uZmlnICB8ICAgOCArKw0KPiA+ID4gICBkcml2ZXJzL25ldC9jYW4vc2phMTAwMC9NYWtl
ZmlsZSB8ICAgMSArDQo+ID4gPiAgIGRyaXZlcnMvbmV0L2Nhbi9zamExMDAwL2Y4MTYwMS5jIHwg
MjE1DQo+ID4gPiANCg0KWy4uLl0gDQoNCj4gPiA+IA0KPiA+ID4gKwkvKiBEZXRlY3QgYXZhaWxh
YmxlIGNoYW5uZWxzICovDQo+ID4gPiArCWZvciAoaSA9IDA7IGkgPCBjb3VudDsgaSsrKSB7DQo+
ID4gPiArCQlkZXYgPSBhbGxvY19zamExMDAwZGV2KDApOw0KPiA+ID4gKwkJaWYgKCFkZXYpIHsN
Cj4gPiA+ICsJCQllcnIgPSAtRU5PTUVNOw0KPiA+ID4gKwkJCWdvdG8gZmFpbHVyZV9jbGVhbnVw
Ow0KPiA+ID4gKwkJfQ0KPiA+ID4gKw0KPiA+IA0KPiA+IGRvbid0IHlvdSBuZWVkIHRvIHJvbGxi
YWNrIGFuZCBjbGVhbnVwL3VucmVnaXN0ZXIgcHJldmlvdXNseQ0KPiA+IGFsbG9jYXRlZA0KPiA+
IGRldnMgPw0KPiA+IA0KPiANCj4gSSdsbCBkbyBjbGVhbnVwIHdoZW4gZXJyb3JzIGp1bXAgdG8g
ZmFpbHVyZV9jbGVhbnVwIGxhYmVsIGFuZCBkbw0KPiBmODE2MDFfcGNpX2RlbF9jYXJkKCkuDQo+
IA0KDQpSaWdodCAhLCB0aGFua3MgZm9yIHRoZSBjbGFyaWZpY2F0aW9uLiANCg==
