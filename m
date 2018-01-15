From: =?utf-8?B?U3TDqXBoYW5lIEdyb3NqZWFu?= <s.grosjean@peak-system.com>
Subject: RE: [PATCH] can: peak/usb: fix potential bug in packet fragmentation
Date: Mon, 15 Jan 2018 14:20:25 +0000
Message-ID: <VI1PR0302MB3325F6935A768304A38526A2D6EB0@VI1PR0302MB3325.eurprd03.prod.outlook.com>
References: <20180115104141.4352-1-s.grosjean@peak-system.com>
 <51f04cfe-cb9f-b6f8-25a3-8d6df20dfbad@pengutronix.de>
 <VI1PR0302MB332549CCF19F5E36A661F7FFD6EB0@VI1PR0302MB3325.eurprd03.prod.outlook.com>
 <c5907a33-a653-a2d3-61ea-ac5c64d06318@pengutronix.de>
 <VI1PR0302MB3325B674EB5235EEFC303D9ED6EB0@VI1PR0302MB3325.eurprd03.prod.outlook.com>
 <d7e89bb0-b0ec-8c0d-c3db-7f448c6cc17c@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-eopbgr60077.outbound.protection.outlook.com ([40.107.6.77]:35834
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754355AbeAOOU2 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 15 Jan 2018 09:20:28 -0500
In-Reply-To: <d7e89bb0-b0ec-8c0d-c3db-7f448c6cc17c@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can Mailing List <linux-can@vger.kernel.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyYyBLbGVpbmUtQnVk
ZGUgW21haWx0bzpta2xAcGVuZ3V0cm9uaXguZGVdDQo+IFNlbnQ6IGx1bmRpIDE1IGphbnZpZXIg
MjAxOCAxNTowMw0KPiBUbzogU3TDqXBoYW5lIEdyb3NqZWFuIDxzLmdyb3NqZWFuQHBlYWstc3lz
dGVtLmNvbT47IGxpbnV4LWNhbiBNYWlsaW5nDQo+IExpc3QgPGxpbnV4LWNhbkB2Z2VyLmtlcm5l
bC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGNhbjogcGVhay91c2I6IGZpeCBwb3RlbnRp
YWwgYnVnIGluIHBhY2tldA0KPiBmcmFnbWVudGF0aW9uDQo+DQo+IE9uIDAxLzE1LzIwMTggMDM6
MDAgUE0sIFN0w6lwaGFuZSBHcm9zamVhbiB3cm90ZToNCj4gPj4+PiBXaGF0IGFib3V0IHVzaW5n
IG1pbigpIGluc3RlYWQgb2Ygb3BlbiBjb2RpbmcgaXQ/DQo+ID4+Pg0KPiA+Pj4gVGhlIHRlc3Qg
aXM6DQo+ID4+Pg0KPiA+Pj4gSWYgKGEgJiYgKHAgPiBLKSkgdGhlbiBwID0gazsNCj4gPj4+DQo+
ID4+PiBBbmQgeW91J2QgbGlrZSBtZSB0byBjaGFuZ2UgaXQgaW50bzoNCj4gPj4+DQo+ID4+PiBJ
ZiAoYSkgdGhlbiBwID0gbWluKHAsIEspOw0KPiA+Pj4NCj4gPj4+IFJpZ2h0Pw0KPiA+Pg0KPiA+
PiBZZXMuLi4gbGlrZSB0aGlzOg0KPiA+Pg0KPiA+Pj4+ICsgICAgICAgaWYgKHVubGlrZWx5KGRl
di0+dWRldi0+c3BlZWQgIT0gVVNCX1NQRUVEX0hJR0gpKQ0KPiA+Pj4+ICsgICAgICAgICAgICAg
ICBwYWNrZXRfbGVuID0gbWluKHBhY2tldF9sZW4sDQo+ID4+Pj4gKyBQQ0FOX1VGRF9MT1NQRF9Q
S1RfU0laRSk7DQo+ID4+DQo+ID4NCj4gPiBZZXAhIE9rLiBCdXQgZm9yIG15IHBlcnNvbmFsIGtu
b3dsZWRnZSwgd2hhdCBjb3VsZCBiZSB0aGUgcmVhc29uPyBJcw0KPiB0aGVyZSBhbnkga2luZGEg
Z2NjIG9wdGltaXphdGlvbiBiZWhpbmQ/DQo+DQo+IFRoZXJlIGlzIHRoaXMgbWFjcm8gaW4gdGhl
IGtlcm5lbCwgaXQncyBlYXNpZXIgdG8gcmVhZCBhbmQgaXQgZG9lcyB0eXBlIGNoZWNraW5nLA0K
PiBzZWUNCj4gaHR0cDovL2VsaXhpci5mcmVlLQ0KPiBlbGVjdHJvbnMuY29tL2xpbnV4L2xhdGVz
dC9zb3VyY2UvaW5jbHVkZS9saW51eC9rZXJuZWwuaCNMNzk5DQo+DQoNCk9rLiBCdXQgZG9uJ3Qg
d2UgbG9zZSB0aGUgdW5saWtleSgpIG9wdGltaXphdGlvbiwgd2hlbiB1c2luZyB0aGUgbWluKCkg
bWFjcm8/IEkgbWVhbiB0aGF0IHRoZSBzaXplIG9mIHRoZSBjbWRzIHNlbnQgYnkgdGhpcyB3YXkg
aXMgZ2VuZXJhbGx5IGxlc3MgdGhhbiA2NCBCLi4uDQoNCj4gTWFyYw0KPg0KPiAtLQ0KPiBQZW5n
dXRyb25peCBlLksuICAgICAgICAgICAgICAgICAgfCBNYXJjIEtsZWluZS1CdWRkZSAgICAgICAg
ICAgfA0KPiBJbmR1c3RyaWFsIExpbnV4IFNvbHV0aW9ucyAgICAgICAgfCBQaG9uZTogKzQ5LTIz
MS0yODI2LTkyNCAgICAgfA0KPiBWZXJ0cmV0dW5nIFdlc3QvRG9ydG11bmQgICAgICAgICAgfCBG
YXg6ICAgKzQ5LTUxMjEtMjA2OTE3LTU1NTUgfA0KPiBBbXRzZ2VyaWNodCBIaWxkZXNoZWltLCBI
UkEgMjY4NiAgfCBodHRwOi8vd3d3LnBlbmd1dHJvbml4LmRlICAgfA0KDQoNCi0tDQpQRUFLLVN5
c3RlbSBUZWNobmlrIEdtYkgNClNpdHogZGVyIEdlc2VsbHNjaGFmdCBEYXJtc3RhZHQgLSBIUkIg
OTE4Mw0KR2VzY2hhZWZ0c2Z1ZWhydW5nOiBBbGV4YW5kZXIgR2FjaCAvIFV3ZSBXaWxoZWxtDQot
LQ0K
