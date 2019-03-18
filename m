From: Rasmus Villemoes <Rasmus.Villemoes@prevas.se>
Subject: Re: [PATCH] can: flexcan: bump FLEXCAN_TIMEOUT_US to 250
Date: Mon, 18 Mar 2019 07:40:49 +0000
Message-ID: <1b3e9a9d-50ed-ca75-300a-b4a0cba38e7b@prevas.se>
References: <20190307150024.23628-1-rasmus.villemoes@prevas.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190307150024.23628-1-rasmus.villemoes@prevas.dk>
Content-Language: en-US
Content-ID: <68B8D8787FA2ED439AF9B2857098CB0D@EURPRD10.PROD.OUTLOOK.COM>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>
Cc: Thomas Winding <twi@deif.com>, Fabio Estevam <festevam@gmail.com>, Per Christensen <pnc@deif.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

cGluZw0KDQpPbiAwNy8wMy8yMDE5IDE2LjAwLCBSYXNtdXMgVmlsbGVtb2VzIHdyb3RlOg0KPiBX
aGlsZSB0cnlpbmcgdG8gYWRkIHN1cHBvcnQgZm9yIHRoZSBGbGV4Y2FuIG1vZHVsZXMgb24gdGhl
IE1QQzgzMDksDQo+IEknbSBoaXR0aW5nIEVUSU1FRE9VVCBpbiBmbGV4Y2FuX2NoaXBfZGlzYWJs
ZSgpLiBXaXRoIHRoaXMsIHByb2JpbmcNCj4gc3VjY2VlZHMuIENoZWNraW5nIHRoZSBsZWZ0b3Zl
ciB2YWx1ZSBvZiB0aW1lb3V0IHdpdGggYSBwcmltaXRpdmUNCj4gDQo+ICAgcHJfZXJyKCIlczog
dGltZW91dD09JWRcbiIsIF9fZnVuY19fLCB0aW1lb3V0KTsNCj4gDQo+IGFmdGVyIHRoZSBsb29w
IGluIGNoaXBfZGlzYWJsZSgpIHR5cGljYWxseSBzaG93cyB2YWx1ZXMgYXJvdW5kIDEyLTE0LA0K
PiBpLmUuIHN1Z2dlc3RpbmcgdGhhdCBpdCB0YWtlcyBhYm91dCAxMTAtMTMwIHVzIGZvciB0aGUg
TFBNX0FDSyBiaXQgdG8NCj4gYXBwZWFyLiBTbyBhIHRpbWVvdXQgdmFsdWUgb2YgYWJvdXQgdHdp
Y2UgdGhhdCBzZWVtcyByZWFzb25hYmxlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmFzbXVzIFZp
bGxlbW9lcyA8cmFzbXVzLnZpbGxlbW9lc0BwcmV2YXMuZGs+DQo+IC0tLQ0KPiAgZHJpdmVycy9u
ZXQvY2FuL2ZsZXhjYW4uYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2Nhbi9mbGV4
Y2FuLmMgYi9kcml2ZXJzL25ldC9jYW4vZmxleGNhbi5jDQo+IGluZGV4IDc1Y2UxMTM5NWVlOC4u
NWYzMjA1M2Y3OGRlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9jYW4vZmxleGNhbi5jDQo+
ICsrKyBiL2RyaXZlcnMvbmV0L2Nhbi9mbGV4Y2FuLmMNCj4gQEAgLTE2NSw3ICsxNjUsNyBAQA0K
PiAgI2RlZmluZSBGTEVYQ0FOX01CX0NOVF9MRU5HVEgoeCkJKCgoeCkgJiAweGYpIDw8IDE2KQ0K
PiAgI2RlZmluZSBGTEVYQ0FOX01CX0NOVF9USU1FU1RBTVAoeCkJKCh4KSAmIDB4ZmZmZikNCj4g
IA0KPiAtI2RlZmluZSBGTEVYQ0FOX1RJTUVPVVRfVVMJCSg1MCkNCj4gKyNkZWZpbmUgRkxFWENB
Tl9USU1FT1VUX1VTCQkoMjUwKQ0KPiAgDQo+ICAvKiBGTEVYQ0FOIGhhcmR3YXJlIGZlYXR1cmUg
ZmxhZ3MNCj4gICAqDQo+IA0KDQo=
