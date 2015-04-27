From: "bhupesh.sharma@freescale.com" <bhupesh.sharma@freescale.com>
Subject: RE: [PATCH 3/3] can: flexcan: Add support for non RX-FIFO mode and
 ERRATA ERR005829
Date: Mon, 27 Apr 2015 06:38:21 +0000
Message-ID: <BY1PR0301MB1303351EFA537E82A02D2FC682E90@BY1PR0301MB1303.namprd03.prod.outlook.com>
References: <1428593056-13701-1-git-send-email-bhupesh.sharma@freescale.com>
 <1428593056-13701-3-git-send-email-bhupesh.sharma@freescale.com>
 <55269D84.1070606@pengutronix.de>
 <BY1PR0301MB1303A2C667A89188E2E9383B82FB0@BY1PR0301MB1303.namprd03.prod.outlook.com>
 <55269EDC.7040802@pengutronix.de>
 <BY1PR0301MB1303BCBCB7BBC7A10409D52E82FB0@BY1PR0301MB1303.namprd03.prod.outlook.com>
 <5526A4EE.8040401@pengutronix.de>
 <BY1PR0301MB1303410A178296C5EC58560B82FB0@BY1PR0301MB1303.namprd03.prod.outlook.com>
 <5526A9D7.8000205@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bn1bn0107.outbound.protection.outlook.com ([157.56.110.107]:43424
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752259AbbD0Gi0 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 27 Apr 2015 02:38:26 -0400
In-Reply-To: <5526A9D7.8000205@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "arnd@arndb.de" <arnd@arndb.de>, "bhupesh.linux@gmail.com" <bhupesh.linux@gmail.com>, "Sakar.Arora@freescale.com" <Sakar.Arora@freescale.com>

SGkgTWFyYywNCg0KU29ycnkgZm9yIHRoZSBsYXRlIHJlcGx5Lg0KDQo+IE9uIDA0LzA5LzIwMTUg
MDY6MTcgUE0sIGJodXBlc2guc2hhcm1hQGZyZWVzY2FsZS5jb20gd3JvdGU6DQo+ID4+IEZyb206
IE1hcmMgS2xlaW5lLUJ1ZGRlIFttYWlsdG86bWtsQHBlbmd1dHJvbml4LmRlXSBPbiAwNC8wOS8y
MDE1DQo+ID4+IDA1OjUzIFBNLCBiaHVwZXNoLnNoYXJtYUBmcmVlc2NhbGUuY29tIHdyb3RlOg0K
PiA+Pj4+IFBsZWFzZSBsb29rIGF0IHRoZSBtYWlubGluZSBjb21taXQ6DQo+ID4+Pj4NCj4gPj4+
PiAyNWU5MjQ0NTBmY2IgY2FuOiBmbGV4Y2FuOiBpbXBsZW1lbnQgd29ya2Fyb3VuZCBmb3IgZXJy
YXRhDQo+ID4+Pj4gRVJSMDA1ODI5DQo+ID4+Pg0KPiA+Pj4gSG1tLi4gVGhpcyBsb29rcyBsaWtl
IGEgZmFpcmx5IHNpbXBsZSBFUlJBVEEgdG8gYmUgaGFuZGxlZCB3L28NCj4gS2NvbmZpZy4NCj4g
Pj4+IEJ1dCB3aXRoIHRoZSBsZWdhY3kgbW9kZSBzdXBwb3J0IEVSUkFUQSwgd2UgaGF2ZSBjb21w
bGV0ZWx5DQo+ID4+PiBkaWZmZXJlbnQgUlggc2V0dXBzIGZvciB0aGUgbGVnYWN5IGFuZCBGSUZP
IG1vZGUuDQo+ID4+DQo+ID4+IENhbiB5b3UgZ2l2ZSBtZSBsaW5rIHRvIHRoZSAiRVJSQVRBIEVS
UjAwNTgyOSAoQS0wMDg5NjUpIiBkZXNjcmlwdGlvbj8NCj4gPj4NCj4gPj4gVGhlIGVycmF0YSBF
UlIwMDU4MjkgaXMgZGVzY3JpYmVkIGhlcmUNCj4gPj4gaHR0cDovL2NhY2hlLmZyZWVzY2FsZS5j
b20vZmlsZXMvMzJiaXQvZG9jL2VycmF0YS9JTVg2RFFDRS5wZGYgYW5kDQo+ID4+IGl0J3MgZml4
ZWQgYnkgbWFpbmxpbmUgY29tbWl0Og0KPiA+Pg0KPiA+PiAgICAgMjVlOTI0NDUwZmNiIGNhbjog
ZmxleGNhbjogaW1wbGVtZW50IHdvcmthcm91bmQgZm9yIGVycmF0YQ0KPiA+PiBFUlIwMDU4MjkN
Cj4gPj4NCj4gPj4gSXMgeW91ciAiRVJSQVRBIEVSUjAwNTgyOSAoQS0wMDg5NjUpIiBzb21ldGhp
bmcgZGlmZmVyZW50Pw0KPiA+DQo+ID4gWWVzLiBJIG1peGVkIHVwIHRoZSBlcnJhdGEgbnVtYmVy
cyBpbiB0aGUgZ2l0IGxvZyBieSBtaXN0YWtlLg0KPiA+DQo+ID4gSXRzIG51bWJlciBBLTAwODk2
NSBhbmQgaXMgcmVsYXRlZCB0byBMUzEwMjFBIEZsZXhDQU4gbm90IGJlaW5nIGFibGUNCj4gPiB0
byBzdXBwb3J0IFJYLUZJRk8gbW9kZS4NCj4gDQo+IERvIHlvdSBoYXZlIGEgbGluayB0byB0aGUg
ZXJyYXRhPyBXaGVyZSdzIHRoZSBjb3JyZXNwb25kaW5nIGtjb25maWcNCj4gcGF0Y2g/IFdoeSBk
byB5b3UgaGF2ZSB0byBzd2l0Y2ggb24vb2ZmIHRoZSBlcnJhdGEgYnkga2NvbmZpZz8gSXMgdGhl
cmUgYQ0KPiBMUzEwMjFBIHdpdGhvdXQgdGhlIGJ1Zz8NCg0KVGhlIGVycmF0YSBsaXN0IGlzIG5v
dCBhdmFpbGFibGUgZm9yIHB1YmxpYyBhY2Nlc3Mgb24gd3d3LmZyZWVzY2FsZS5jb20gc28gZmFy
Lg0KVGhlIG5leHQgdmVyc2lvbiBvZiBMUzEwMjFBIFNvQywgaXMgZml4aW5nIHRoaXMgYnVnIGFu
ZCBzaW5jZSBib3RoIGFyZSBzdXBwb3NlZA0KdG8gYmUgdXNlZCBieSBjdXN0b21lcnMsIHRoZSBr
Y29uZmlnIHRyaWNrIGlzIHJlcXVpcmVkIHRvIHR1cm4tb2ZmIHRoaXMgaGFuZGxpbmcNCmZvciBv
bmUgdmVyc2lvbiwgd2hpbGUga2VlcGluZyBpdCBpbnRhY3QgZm9yIHRoZSBvdGhlci4NCg0KUmVn
YXJkcywNCkJodXBlc2gNCg==
