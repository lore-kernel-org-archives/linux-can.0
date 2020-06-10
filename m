From: Felix Riemann <Felix.Riemann@sma.de>
Subject: RE: [PATCH] can: c_can: Handle lost bus-off interrupt while IRQs are
 disabled
Date: Wed, 10 Jun 2020 08:08:28 +0000
Message-ID: <AM0PR04MB6273640802E04C4009CE5BC588830@AM0PR04MB6273.eurprd04.prod.outlook.com>
References: <20200326104318.15086-1-felix.riemann@sma.de>
 <20200326134015.GC27785@x1.vandijck-laurijssen.be>
 <AM0PR04MB5427D3BF64C3D3DA3961920488CF0@AM0PR04MB5427.eurprd04.prod.outlook.com>
 <20200326193837.GF760@x1.vandijck-laurijssen.be>
 <AM0PR04MB542742337A89900E12A8732288CC0@AM0PR04MB5427.eurprd04.prod.outlook.com>
 <20200330070203.GE22500@x1.vandijck-laurijssen.be>
 <AM0PR04MB54271EA5CC205263750BDBD288CB0@AM0PR04MB5427.eurprd04.prod.outlook.com>
 <20200429084733.GA27733@x1.vandijck-laurijssen.be>
 <20200429090618.GB27733@x1.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-eopbgr80111.outbound.protection.outlook.com ([40.107.8.111]:36933
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726207AbgFJIIc (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 10 Jun 2020 04:08:32 -0400
In-Reply-To: <20200429090618.GB27733@x1.vandijck-laurijssen.be>
Content-Language: de-DE
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Andre Kalb <Andre.Kalb@sma.de>

SGkgS3VydCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLdXJ0IFZh
biBEaWpjayA8ZGV2Lmt1cnRAdmFuZGlqY2stbGF1cmlqc3Nlbi5iZT4NCj4gU2VudDogV2VkbmVz
ZGF5LCBBcHJpbCAyOSwgMjAyMCAxMTowNiBBTQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBjYW46
IGNfY2FuOiBIYW5kbGUgbG9zdCBidXMtb2ZmIGludGVycnVwdCB3aGlsZSBJUlFzIGFyZQ0KPiBk
aXNhYmxlZA0KPg0KPiBJIGhhdmUgdGhlIGltcHJlc3Npb24gdGhhdCB0aGUgcmVjdiBwYXRoIGlz
IGNvdmVyZWQsIGF0IGxlYXN0IHRoZSBudWxsIHB0ciB3b3VsZA0KPiBoYXZlIGNhdXNlZCBpc3N1
ZWQgZWFybGllciBhbHJlYWR5Lg0KPiBXb3VsZCB0aGUgcHJvYmxlbSBhcmlzZSBpbiBjX2Nhbl9k
b190eCBmZXRjaGluZyBhIE5VTEwgZWNob19za2I/DQoNCkl0IHJlYWxseSBsb29rcyBsaWtlIGl0
Lg0KDQpBZGRpbmcgYSBCVUdfT04gdG8gdGhlIGxvb3AgaW4gY19jYW5fZG9fdHggdHJpZ2dlcnMg
d2l0aCBhIE5VTEwgc2tiIHJldHVybmVkIGJ5IF9fY2FuX2dldF9lY2hvX3NrYigpLg0KDQpGb3Ig
dGVzdGluZyBJIHJlcGxhY2VkIHRoZSBCVUdfT04gd2l0aCBhIGNoZWNrIHRoYXQgc2tpcHMgdGhl
IHNrYiBpZiB0aGF0IGhhcHBlbnMgKG5vdCBzdXJlIGlmIHRoYXQgd291bGQgYmUgYSB2YWxpZCBm
aXggaW4gdGhhdCBwbGFjZSk6DQoNCndoaWxlICgob2JqID0gY19jYW5fZmZzNjQocGVuZCkpKSB7
DQpwZW5kICY9IH4oKHU2NCkxIDw8IChvYmogLSAxKSk7DQpjX2Nhbl9pbnZhbF90eF9vYmplY3Qo
ZGV2LCBJRl9SWCwgb2JqKTsNCmlkeCA9IG9iaiAtIHByaXYtPm9iai5zZW5kX2Zyc3Q7DQpza2Ig
PSBfX2Nhbl9nZXRfZWNob19za2IoZGV2LCBpZHgsICZsZW4pOw0KaWYoIXNrYikNCmNvbnRpbnVl
Ow0KY2FuX3J4X29mZmxvYWRfaXJxX3JlY2VpdmVfc2tiKCZwcml2LT5vZmZsb2FkLCBza2IpOw0K
Ynl0ZXMgKz0gbGVuOw0KcGt0cysrOw0KfQ0KDQpTbyBmYXIgaXQgZ290IHRocm91Z2ggdGhlIG5p
Z2h0IHdpdGhvdXQgY3Jhc2hpbmcgb3IgZGVhZGxvY2tpbmcsIGJ1dCBJIGNhbid0IHJlYWxseSB0
ZWxsIGlmIHdlIGFyZSBtaXNzaW5nIHBha2V0cyB0aG91Z2guDQoNClJlZ2FyZHMsDQoNCkZlbGl4
DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCg0K
U01BIFNvbGFyIFRlY2hub2xvZ3kgQUcNCkF1ZnNpY2h0c3JhdDogVXdlIEtsZWlua2F1ZiAoVm9y
c2l0emVuZGVyKQ0KVm9yc3RhbmQ6IFVscmljaCBIYWRkaW5nLCBEci4tSW5nLiBKdWVyZ2VuIFJl
aW5lcnQNCkhhbmRlbHNyZWdpc3RlcjogQW10c2dlcmljaHQgS2Fzc2VsIEhSQiAzOTcyDQpTaXR6
IGRlciBHZXNlbGxzY2hhZnQ6IDM0MjY2IE5pZXN0ZXRhbA0KVVN0LUlELU5yLiBERSAxMTMgMDgg
NTkgNTQNCldFRUUtUmVnLi1Oci4gREUgOTU4ODExNTANCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXw0K
