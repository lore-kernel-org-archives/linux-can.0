From: "bhupesh.sharma@freescale.com" <bhupesh.sharma@freescale.com>
Subject: RE: [PATCH 3/3] can: flexcan: Add support for non RX-FIFO mode and
 ERRATA ERR005829
Date: Thu, 9 Apr 2015 15:53:15 +0000
Message-ID: <BY1PR0301MB1303BCBCB7BBC7A10409D52E82FB0@BY1PR0301MB1303.namprd03.prod.outlook.com>
References: <1428593056-13701-1-git-send-email-bhupesh.sharma@freescale.com>
 <1428593056-13701-3-git-send-email-bhupesh.sharma@freescale.com>
 <55269D84.1070606@pengutronix.de>
 <BY1PR0301MB1303A2C667A89188E2E9383B82FB0@BY1PR0301MB1303.namprd03.prod.outlook.com>
 <55269EDC.7040802@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bl2on0117.outbound.protection.outlook.com ([65.55.169.117]:45528
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755270AbbDIPxT (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 9 Apr 2015 11:53:19 -0400
In-Reply-To: <55269EDC.7040802@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "arnd@arndb.de" <arnd@arndb.de>, "bhupesh.linux@gmail.com" <bhupesh.linux@gmail.com>, "Sakar.Arora@freescale.com" <Sakar.Arora@freescale.com>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJjIEtsZWluZS1CdWRkZSBb
bWFpbHRvOm1rbEBwZW5ndXRyb25peC5kZV0NCj4gT24gMDQvMDkvMjAxNSAwNTo0NSBQTSwgYmh1
cGVzaC5zaGFybWFAZnJlZXNjYWxlLmNvbSB3cm90ZToNCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gPj4gRnJvbTogTWFyYyBLbGVpbmUtQnVkZGUgW21haWx0bzpta2xAcGVuZ3V0
cm9uaXguZGVdIE9uIDA0LzA5LzIwMTUNCj4gPj4gMDU6MjQgUE0sIEJodXBlc2ggU2hhcm1hIHdy
b3RlOg0KPiA+Pj4gVGhpcyBwYXRjaCBhZGRzIHN1cHBvcnQgZm9yIG5vbiBSWC1GSUZPIChsZWdh
Y3kpIG1vZGUgYW5kIEVSUkFUQQ0KPiA+Pj4gRVJSMDA1ODI5IGhhbmRsaW5nIGluIGZsZXhjYW4g
ZHJpdmVyLg0KPiA+Pg0KPiA+PiBXaGF0IGFib3V0DQo+ID4+IDI1ZTkyNDQ1MGZjYiBjYW46IGZs
ZXhjYW46IGltcGxlbWVudCB3b3JrYXJvdW5kIGZvciBlcnJhdGEgRVJSMDA1ODI5ID8NCj4gPg0K
PiA+IE9vcHMsIGxvb2tzIGxpa2UgYSB0eXBvLiBXaWxsIGZpeCBpbiBWMi4NCj4gPg0KPiA+Pj4g
Qm90aCB0aGVzZSBmZWF0dXJlcyBhcmUgbm93IHNlbGVjdGFibGUgdmlhIEtjb25maWcgZW50cmll
cyBhbmQgaGVuY2UNCj4gPj4+IGNhbiBiZSB0dXJuZWQtb24vb2ZmIGFzIHBlciBhIFNvQyBmZWF0
dXJlIHNldCBhdmFpbGFiaWxpdHkuDQo+ID4+DQo+ID4+IFNvcnJ5IEtjb25maWcgaXMgbm90IGFu
IG9wdGlvbiBoZXJlLg0KPiA+DQo+ID4gSSBtZWFudCB0aGUgZGVmY29uZmlnIGhlcmUuIEJ5IGRl
ZmF1bHQgdGhlIGVycmF0YSBoYW5kbGluZyB3b3VsZCBiZQ0KPiA+IHR1cm5lZC1vZmYgaW4gdGhl
IEtjb25maWcuDQo+ID4NCj4gPiBBbnkgb3RoZXIgaWRlYXM/DQo+IA0KPiBQbGVhc2UgbG9vayBh
dCB0aGUgbWFpbmxpbmUgY29tbWl0Og0KPiANCj4gMjVlOTI0NDUwZmNiIGNhbjogZmxleGNhbjog
aW1wbGVtZW50IHdvcmthcm91bmQgZm9yIGVycmF0YSBFUlIwMDU4MjkNCj4gDQoNCkhtbS4uIFRo
aXMgbG9va3MgbGlrZSBhIGZhaXJseSBzaW1wbGUgRVJSQVRBIHRvIGJlIGhhbmRsZWQgdy9vIEtj
b25maWcuDQpCdXQgd2l0aCB0aGUgbGVnYWN5IG1vZGUgc3VwcG9ydCBFUlJBVEEsIHdlIGhhdmUg
Y29tcGxldGVseSBkaWZmZXJlbnQgUlggc2V0dXBzIGZvcg0KdGhlIGxlZ2FjeSBhbmQgRklGTyBt
b2RlLg0KDQpFcnJhdGEgaGFuZGxpbmcgdmlhIEtjb25maWcgc2VlbXMgcHJldHR5IGNvbW1vbiBp
biB0aGUga2VybmVsIChzZWUgWzFdKQ0KDQpbMV0gQVJNNjRfRVJSQVRVTV84MjczMTk6IA0KaHR0
cHM6Ly9naXQua2VybmVsLm9yZy9jZ2l0L2xpbnV4L2tlcm5lbC9naXQvbmV4dC9saW51eC1uZXh0
LmdpdC90cmVlL2FyY2gvYXJtNjQvS2NvbmZpZz9pZD1yZWZzL3RhZ3MvbmV4dC0yMDE1MDQwOSNu
Mjg3DQoNClJlZ2FyZHMsDQpCaHVwZXNoDQo=
