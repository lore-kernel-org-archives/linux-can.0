From: "bhupesh.sharma@freescale.com" <bhupesh.sharma@freescale.com>
Subject: RE: [PATCH 3/3] can: flexcan: Add support for non RX-FIFO mode and
 ERRATA ERR005829
Date: Thu, 9 Apr 2015 16:17:41 +0000
Message-ID: <BY1PR0301MB1303410A178296C5EC58560B82FB0@BY1PR0301MB1303.namprd03.prod.outlook.com>
References: <1428593056-13701-1-git-send-email-bhupesh.sharma@freescale.com>
 <1428593056-13701-3-git-send-email-bhupesh.sharma@freescale.com>
 <55269D84.1070606@pengutronix.de>
 <BY1PR0301MB1303A2C667A89188E2E9383B82FB0@BY1PR0301MB1303.namprd03.prod.outlook.com>
 <55269EDC.7040802@pengutronix.de>
 <BY1PR0301MB1303BCBCB7BBC7A10409D52E82FB0@BY1PR0301MB1303.namprd03.prod.outlook.com>
 <5526A4EE.8040401@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bl2on0117.outbound.protection.outlook.com ([65.55.169.117]:21312
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755477AbbDIQRo (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 9 Apr 2015 12:17:44 -0400
In-Reply-To: <5526A4EE.8040401@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "arnd@arndb.de" <arnd@arndb.de>, "bhupesh.linux@gmail.com" <bhupesh.linux@gmail.com>, "Sakar.Arora@freescale.com" <Sakar.Arora@freescale.com>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJjIEtsZWluZS1CdWRkZSBb
bWFpbHRvOm1rbEBwZW5ndXRyb25peC5kZV0NCj4gT24gMDQvMDkvMjAxNSAwNTo1MyBQTSwgYmh1
cGVzaC5zaGFybWFAZnJlZXNjYWxlLmNvbSB3cm90ZToNCj4gPj4gUGxlYXNlIGxvb2sgYXQgdGhl
IG1haW5saW5lIGNvbW1pdDoNCj4gPj4NCj4gPj4gMjVlOTI0NDUwZmNiIGNhbjogZmxleGNhbjog
aW1wbGVtZW50IHdvcmthcm91bmQgZm9yIGVycmF0YSBFUlIwMDU4MjkNCj4gPg0KPiA+IEhtbS4u
IFRoaXMgbG9va3MgbGlrZSBhIGZhaXJseSBzaW1wbGUgRVJSQVRBIHRvIGJlIGhhbmRsZWQgdy9v
IEtjb25maWcuDQo+ID4gQnV0IHdpdGggdGhlIGxlZ2FjeSBtb2RlIHN1cHBvcnQgRVJSQVRBLCB3
ZSBoYXZlIGNvbXBsZXRlbHkgZGlmZmVyZW50DQo+ID4gUlggc2V0dXBzIGZvciB0aGUgbGVnYWN5
IGFuZCBGSUZPIG1vZGUuDQo+IA0KPiBDYW4geW91IGdpdmUgbWUgbGluayB0byB0aGUgIkVSUkFU
QSBFUlIwMDU4MjkgKEEtMDA4OTY1KSIgZGVzY3JpcHRpb24/DQo+IA0KPiBUaGUgZXJyYXRhIEVS
UjAwNTgyOSBpcyBkZXNjcmliZWQgaGVyZQ0KPiBodHRwOi8vY2FjaGUuZnJlZXNjYWxlLmNvbS9m
aWxlcy8zMmJpdC9kb2MvZXJyYXRhL0lNWDZEUUNFLnBkZiBhbmQgaXQncw0KPiBmaXhlZCBieSBt
YWlubGluZSBjb21taXQ6DQo+IA0KPiAgICAgMjVlOTI0NDUwZmNiIGNhbjogZmxleGNhbjogaW1w
bGVtZW50IHdvcmthcm91bmQgZm9yIGVycmF0YSBFUlIwMDU4MjkNCj4gDQo+IElzIHlvdXIgIkVS
UkFUQSBFUlIwMDU4MjkgKEEtMDA4OTY1KSIgc29tZXRoaW5nIGRpZmZlcmVudD8NCg0KWWVzLiBJ
IG1peGVkIHVwIHRoZSBlcnJhdGEgbnVtYmVycyBpbiB0aGUgZ2l0IGxvZyBieSBtaXN0YWtlLg0K
DQpJdHMgbnVtYmVyIEEtMDA4OTY1IGFuZCBpcyByZWxhdGVkIHRvIExTMTAyMUEgRmxleENBTiBu
b3QgYmVpbmcNCmFibGUgdG8gc3VwcG9ydCBSWC1GSUZPIG1vZGUuDQoNClJlZ2FyZHMsDQpCaHVw
ZXNoDQoNCj4gDQo+ID4gRXJyYXRhIGhhbmRsaW5nIHZpYSBLY29uZmlnIHNlZW1zIHByZXR0eSBj
b21tb24gaW4gdGhlIGtlcm5lbCAoc2VlDQo+ID4gWzFdKQ0KPiANCj4gWWVzLCBmb3IgdGhlIEFS
TSBDb3JlIGl0c2VsZi4NCj4gDQo+IE1hcmMNCj4gDQo+IC0tDQo+IFBlbmd1dHJvbml4IGUuSy4g
ICAgICAgICAgICAgICAgICB8IE1hcmMgS2xlaW5lLUJ1ZGRlICAgICAgICAgICB8DQo+IEluZHVz
dHJpYWwgTGludXggU29sdXRpb25zICAgICAgICB8IFBob25lOiArNDktMjMxLTI4MjYtOTI0ICAg
ICB8DQo+IFZlcnRyZXR1bmcgV2VzdC9Eb3J0bXVuZCAgICAgICAgICB8IEZheDogICArNDktNTEy
MS0yMDY5MTctNTU1NSB8DQo+IEFtdHNnZXJpY2h0IEhpbGRlc2hlaW0sIEhSQSAyNjg2ICB8IGh0
dHA6Ly93d3cucGVuZ3V0cm9uaXguZGUgICB8DQoNCg==
