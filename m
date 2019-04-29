From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH] can: flexcan: bump FLEXCAN_TIMEOUT_US to 250
Date: Mon, 29 Apr 2019 08:53:19 +0000
Message-ID: <e9b2b895-aa65-72be-5e6e-d38365ff2624@prevas.dk>
References: <20190307150024.23628-1-rasmus.villemoes@prevas.dk>
 <a418bbc9-186c-174a-20d8-18cedeaf0089@pengutronix.de>
 <5615c217-8ba6-e452-1aaa-1e3b32eb4cca@prevas.dk>
 <f1fb86fb-1b6b-1860-899d-820d4bc672cf@pengutronix.de>
 <4471c611-1a58-6365-2ab6-1b39c310265a@prevas.dk>
 <b03e9868-3070-ce35-3477-3119d691baec@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b03e9868-3070-ce35-3477-3119d691baec@pengutronix.de>
Content-Language: en-US
Content-ID: <9689F66843FFC84F9F2B01A6B923C809@EURPRD10.PROD.OUTLOOK.COM>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, "David S. Miller" <davem@davemloft.net>
Cc: Thomas Winding <twi@deif.com>, Fabio Estevam <festevam@gmail.com>, Per Christensen <pnc@deif.com>, Rasmus Villemoes <Rasmus.Villemoes@prevas.se>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Joakim Zhang <qiangqing.zhang@nxp.com>
List-Id: linux-can.vger.kernel.org

T24gMjIvMDMvMjAxOSAwOC41MSwgTWFyYyBLbGVpbmUtQnVkZGUgd3JvdGU6DQo+IE9uIDMvMjIv
MTkgODo0NSBBTSwgUmFzbXVzIFZpbGxlbW9lcyB3cm90ZToNCj4+IE9uIDIxLzAzLzIwMTkgMTYu
MzAsIE1hcmMgS2xlaW5lLUJ1ZGRlIHdyb3RlOg0KPj4+IE9uIDMvMjEvMTkgMzozNCBQTSwgUmFz
bXVzIFZpbGxlbW9lcyB3cm90ZToNCj4+Pj4gT24gMjAvMDMvMjAxOSAxNC4xOCwgTWFyYyBLbGVp
bmUtQnVkZGUgd3JvdGU6DQo+Pj4NCj4+PiBDYW4geW91IHByb3Bvc2UgYW4gdXBkYXRlZCBjb21t
aXQgbWVzc2FnZSBmb3IgSm9ha2ltIFpoYW5nJ3MgcGF0Y2g/DQo+Pj4NCj4+PiBodHRwczovL2dp
dC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9ta2wvbGludXgtY2FuLmdpdC9j
b21taXQvP2g9dGVzdGluZyZpZD05ZGFlZDg5YWU4YTNmYzQ0Y2NkMmIyYmI5YzNjNGQzZTM0MzE5
MDRkDQo+Pj4NCj4+PiBJJ2xsIGFkZCBpdCBieSBoYW5kIGFuZCBpbmNyZWFzZSB0aGUgdGltZW91
dCB0byAyNTAuIE9rPw0KPj4NCj4+IFNvdW5kcyBmaW5lLiBJbiBvcmRlciBub3QgdG8gY2hhbmdl
IEpvYWtpbSdzIGNvbW1pdCBsb2cgdG9vIG11Y2gsIGhvdw0KPj4gYWJvdXQgYWRkaW5nIHNvbWV0
aGluZyBsaWtlICh3aXRoIHlvdXIgaW5pdGlhbHMsIHNpbmNlIHlvdSdyZSBuZXh0IGluDQo+PiB0
aGUgc2lnbi1vZmYgY2hhaW4pDQo+Pg0KPj4gW21rbDogTWVhbndoaWxlLCBSYXNtdXMgVmlsbGVt
b2VzIHJlcG9ydGVkIHRoYXQgZXZlbiB3aXRoIGEgdGltZW91dCBvZg0KPj4gMTAwLCBmbGV4Y2Fu
X3Byb2JlKCkgZmFpbHMgb24gdGhlIE1QQzgzMDksIHdoaWNoIHJlcXVpcmVzIGEgdmFsdWUgb2Yg
YXQNCj4+IGxlYXN0IDE0MCB0byB3b3JrIHJlbGlhYmx5LiAyNTAgd29ya3MgZm9yIGV2ZXJ5b25l
Ll0NCj4+DQo+PiA/IEZlZWwgZnJlZSB0byBlZGl0IGFzIHlvdSB3aXNoLg0KPiANCj4gVGhhbmtz
LCBJJ3ZlIGFkZGVkIHRoYXQgdG8gdGhlIGNvbW1pdCBtZXNzYWdlIGl0c2VsZi4NCg0KV2hhdCdz
IHRoZSBzdGF0dXMgb2YgdGhpcz8gSSBjYW4ndCBmaW5kIGFueXRoaW5nIGluIC1uZXh0IChhcyBv
Zg0KbmV4dC0yMDE5MDQyNiksIG5laXRoZXIgSm9ha2ltJ3Mgb3JpZ2luYWwgb3IgdGhlIGFtZW5k
ZWQgcGF0Y2guDQoNClRoYW5rcywNClJhc211cw0K
