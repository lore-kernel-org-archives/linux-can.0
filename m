From: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>
Subject: RE: flexcan missing error state transitions
Date: Fri, 1 Sep 2017 08:24:50 +0000
Message-ID: <ba24d7adc2204f598dabadd10714e39b@SGPMBX1017.APAC.bosch.com>
References: <5213bc7ebd454acea568aba682d696ca@SGPMBX1017.APAC.bosch.com>
 <8e8b90f72f374fb1ab82bc29b8cfc108@SI-MBX1030.de.bosch.com>
 <150333966184.28484.15326759292718336833@maxwell>
 <e54b0db7ec524bcca65e1975aaf13b2b@SI-MBX1030.de.bosch.com>
 <71679863-5b47-faf2-ca44-27eb1abf16c6@pengutronix.de>
 <2ec91a72-49b2-ca43-9472-8f079b278c80@grandegger.com>
 <a257405ba06949a9be5d64912d72d0ba@SGPMBX1017.APAC.bosch.com>
 <23b53bdc-b7d4-f6de-b192-629ffe9795b0@grandegger.com>
 <c5b11618c98a41108dfbe6cf034398f0@SGPMBX1017.APAC.bosch.com>
 <3486f6ae-f4ef-fc94-e706-775f8af60826@grandegger.com>
 <2245ab57e90f44d88e53449156cc1e1b@SGPMBX1017.APAC.bosch.com>
 <6bd916d4-3eb2-c247-2072-6b4c95dd5c69@grandegger.com>
 <9904cd2d80964810b56b8612cc02bfb6@SGPMBX1017.APAC.bosch.com>
 <5faf942d-4680-45a7-74f2-208a2b9f73f8@grandegger.com>
 <db68b0a396574fe7883f962863804a4a@SGPMBX1017.APAC.bosch.com>
 <c3bb7b46-d7f6-b188-73a2-d74e42ebf4f1@grandegger.com>
 <1305c2749a86402fa15c48113bb0ed54@SGPMBX1017.APAC.bosch.com>
 <5c1b52f3-56b9-b885-add2-57b5fbc05107@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:35958 "EHLO
        smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751457AbdIAIZK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 1 Sep 2017 04:25:10 -0400
In-Reply-To: <5c1b52f3-56b9-b885-add2-57b5fbc05107@grandegger.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Andri Yngvason <andri.yngvason@marel.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "hs@denx.de" <hs@denx.de>, "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>, "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>

SGVsbG8gV29sZmdhbmcsDQoNCj4gRnJvbTogV29sZmdhbmcgR3JhbmRlZ2dlciBbbWFpbHRvOndn
QGdyYW5kZWdnZXIuY29tXQ0KPiBTZW50OiBUaHVyc2RheSwgQXVndXN0IDMxLCAyMDE3IDU6NTQg
UE0NCj4gDQo+IFsuLi5dDQo+ID4gQWx0aG91Z2ggb25seSBwMTAxMCBlbmFibGVkIHRoZSBxdWly
ayBzbyBmYXIsIGJ1dCB0byBvdXIgdW5kZXJzdGFuZGluZywNCj4gPiB0aGUgcmVzdCBjb3JlIHNl
ZW1zIGFsc28gbmVlZCB0aGUgcXVpcmsgZW5hYmxlZCB0byByZXBvcnQgY29ycmVjdCBzdGF0ZQ0K
PiA+IHRyYW5zaXRpb25zLCBlLmcuLCBpLk1YNi4NCj4gDQo+IEkgd2lsbCBoYXZlIGEgaS5NWDUz
IGFuZCBpLk1YMjggYm9hcmQgc29vbiBvbiBteSB0YWJsZSB0byBjaGVjayBlcnJvcg0KPiBwYXNz
aXZlIGhhbmRsaW5nLiBXb3VsZCBiZSBuaWNlIHRvIHJlZHVjZSBpbnRlcnJ1cHQgZmxvb2Rpbmcg
b24gdGhlc2UgYXMNCj4gd2VsbC4NClRoYXQncyByZWFsbHkgZ3JlYXQuIDopDQpJJ20gbG9va2lu
ZyBmb3J3YXJkIHRvIHRoZSByZXN1bHQgYW5kIGhvcGUgdGhlIHBhdGNoIGNhbiB3b3JrIGZvciB0
aGVtIQ0KDQo+IA0KPiA+IEhvd2V2ZXIsIGFzIG5laXRoZXIgb2YgdXMgY2FuIHRlc3QgdGhlIGxl
Z2FjeSBhbmQgb3RoZXIgY29yZXMsIHNvIHdlDQo+ID4gY2Fubm90IHRvdWNoIHRoZW0gd2l0aG91
dCB0ZXN0aW5nLiBQZXJoYXBzIHNvbWVvbmUgd2hvIGhhcyB0aGUgYWNjZXNzDQo+ID4gdG8gdGhl
c2UgY29yZXMgY2FuIGdpdmUgYSBoYW5kIHRvIHZlcmlmeSB0aGF0IGluIGZ1dHVyZS4NCj4gDQo+
IE90aGVyIHRlc3RlciBhcmUgd2VsY29tZSENCj4gDQo+IFsuLi5dDQo+IFdlIGRpc2FibGUgdGhl
IGJ1cyBlcnJvcnMgd2hlbiBlcnJvciBwYXNzaXZlIGlzIHJlYWNoZWQuIEJ1dCB3aGF0DQo+IGhh
cHBlbnMgaWYgdGhlIGVycm9yIHN0YXRlIGRlY3JlYXNlcy4gSXQgd2lsbCByZXF1aXJlIHN1Y2Nl
c3NmdWwNCj4gdHJhbnNtaXNzaW9ucy4gV2hlbiB0aGUgVFggZG9uZSBpbnRlcnJ1cHQgY29tZXMs
IGNoYW5nZXMgdG8gZXJyb3INCj4gd2FybmluZyBhcmUgcmVhbGl6ZWQuIFRoZW4gd2UgcmUtZW5h
YmxlIHRoZSBlcnJvciBpbnRlcnJ1cHQuIEJ1dCBiZWxvdw0KPiBlcnJvciB3YXJuaW5nLCB3ZSB3
b3VsZCBsaWtlIHRvIGRpc2FibGUgdGhlIGVycm9yIGludGVycnVwdCAoZm9yIHRoZQ0KPiBteDZx
KS4gVGhhdCBtaWdodCBiZSBhIHByb2JsZW0gYnV0IGNvdWxkIGJlIGZpeGVkIGJ5IHNwZWNpYWwg
dHJlYXRtZW50DQo+IChmb3IgbGVnYWN5IGNvcmVzKS4NClllcy4gSSB0aGluayB0aGlzIGlzIGFs
c28gcmVsYXRlZCB0byB0aGUgZGlzY3Vzc2lvbiBvZiBwYXRjaCAzIHRocmVhZA0KKGh0dHBzOi8v
bWFyYy5pbmZvLz9sPWxpbnV4LWNhbiZtPTE1MDQyNDYyNjIwNjU4NiZ3PTIpLiBJJ2xsIGZpeCB0
aGlzDQphZnRlciB3ZSBjb21lIHRvIGEgY29uY2x1c2lvbiB0aGVyZS4NCg0KVGhhbmtzIQ0KWWkN
Cg==
