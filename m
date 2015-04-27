From: "bhupesh.sharma@freescale.com" <bhupesh.sharma@freescale.com>
Subject: RE: [PATCH 3/3] can: flexcan: Add support for non RX-FIFO mode and
 ERRATA ERR005829
Date: Mon, 27 Apr 2015 07:11:31 +0000
Message-ID: <BY1PR0301MB130330B330A2FFBEA999DEB082E90@BY1PR0301MB1303.namprd03.prod.outlook.com>
References: <1428593056-13701-1-git-send-email-bhupesh.sharma@freescale.com>
 <1428593056-13701-3-git-send-email-bhupesh.sharma@freescale.com>
 <55269D84.1070606@pengutronix.de>
 <BY1PR0301MB1303A2C667A89188E2E9383B82FB0@BY1PR0301MB1303.namprd03.prod.outlook.com>
 <55269EDC.7040802@pengutronix.de>
 <BY1PR0301MB1303BCBCB7BBC7A10409D52E82FB0@BY1PR0301MB1303.namprd03.prod.outlook.com>
 <5526A4EE.8040401@pengutronix.de>
 <BY1PR0301MB1303410A178296C5EC58560B82FB0@BY1PR0301MB1303.namprd03.prod.outlook.com>
 <5526A9D7.8000205@pengutronix.de>
 <BY1PR0301MB1303351EFA537E82A02D2FC682E90@BY1PR0301MB1303.namprd03.prod.outlook.com>
 <553DDB0E.4060205@pengutronix.de>
 <BY1PR0301MB1303C0A7F5733B45719E05AE82E90@BY1PR0301MB1303.namprd03.prod.outlook.com>
 <553DE0D2.8090504@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bn1on0130.outbound.protection.outlook.com ([157.56.110.130]:19496
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932100AbbD0H12 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 27 Apr 2015 03:27:28 -0400
In-Reply-To: <553DE0D2.8090504@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "arnd@arndb.de" <arnd@arndb.de>, "bhupesh.linux@gmail.com" <bhupesh.linux@gmail.com>, "Sakar.Arora@freescale.com" <Sakar.Arora@freescale.com>

PiBGcm9tOiBNYXJjIEtsZWluZS1CdWRkZSBbbWFpbHRvOm1rbEBwZW5ndXRyb25peC5kZV0NCj4g
T24gMDQvMjcvMjAxNSAwODo1MSBBTSwgYmh1cGVzaC5zaGFybWFAZnJlZXNjYWxlLmNvbSB3cm90
ZToNCj4gDQo+ID4+PiBUaGUgZXJyYXRhIGxpc3QgaXMgbm90IGF2YWlsYWJsZSBmb3IgcHVibGlj
IGFjY2VzcyBvbg0KPiA+Pj4gd3d3LmZyZWVzY2FsZS5jb20NCj4gPj4gc28gZmFyLg0KPiA+Pj4g
VGhlIG5leHQgdmVyc2lvbiBvZiBMUzEwMjFBIFNvQywgaXMgZml4aW5nIHRoaXMgYnVnIGFuZCBz
aW5jZSBib3RoDQo+ID4+PiBhcmUgc3VwcG9zZWQgdG8gYmUgdXNlZCBieSBjdXN0b21lcnMsIHRo
ZSBrY29uZmlnIHRyaWNrIGlzIHJlcXVpcmVkDQo+ID4+PiB0byB0dXJuLW9mZiB0aGlzIGhhbmRs
aW5nIGZvciBvbmUgdmVyc2lvbiwgd2hpbGUga2VlcGluZyBpdCBpbnRhY3QNCj4gPj4+IGZvciB0
aGUNCj4gPj4gb3RoZXIuDQo+ID4+DQo+ID4+IFNvcnJ5LCBhIGNvbXBpbGUgdGltZSBzd2l0Y2gg
aXMgbm90IGFuIG9wdGlvbiBoZXJlLiBQbGVhc2UgY29uZmlndXJlDQo+ID4+IGl0IGR1cmluZyBy
dW50aW1lIHZpYSB0aGUgZGV2aWNlIHRyZWUuIFRoaXMgY2FuIGJlIGRvbmUgYnkgZGlmZmVyZW50
DQo+ID4+IGNvbXBhdGlibGVzLCBvbmUgZm9yIHRoZSBicm9rZW4gYW5vdGhlciBvbmUgZm9yIHRo
ZSBmaXhlZCBTb0MuDQo+ID4NCj4gPiBXZWxsLCBtb3N0IG9mIHRoZSBjb2RlIGlzIHdyaXR0ZW4g
dG8gaGFuZGxlIHRoaXMgb24gcnVuLXRpbWUgKG9uIGJhc2lzDQo+ID4gb2YgdGhlIGR0cykuIE1h
eWJlIEkgY2FuIGNyZWF0ZSB0d28gdmVyc2lvbnMgb2YNCj4gPiBmc2xfbHMxMDIxYV9kZXZ0eXBl
X2RhdGEgcmF0aGVyIHRoYW4gdXNpbmcgdGhlIGtDb25maWc6DQo+ID4NCj4gPiBGb3IgdGhlIGJy
b2tlbi0gU29DOg0KPiA+IHN0YXRpYyBzdHJ1Y3QgZmxleGNhbl9kZXZ0eXBlX2RhdGEgZnNsX2xz
MTAyMWFfZGV2dHlwZV9kYXRhID0gew0KPiA+IAkuZmVhdHVyZXMgPSBGTEVYQ0FOX0hBU19WMTBf
RkVBVFVSRVMgfCBGTEVYQ0FOX0hBU19NRUNSX0ZFQVRVUkVTDQo+ID4gCXwgRkxFWENBTl9VU0VT
X1JYX01CDQo+ID4gCSwNCj4gPiB9Ow0KPiA+DQo+ID4gYW5kIGZvciB0aGUgbmV3LVNvQzoNCj4g
PiBzdGF0aWMgc3RydWN0IGZsZXhjYW5fZGV2dHlwZV9kYXRhIGZzbF9sczEwMjFhX2RldnR5cGVf
ZGF0YSA9IHsNCj4gPiAJLmZlYXR1cmVzID0gRkxFWENBTl9IQVNfVjEwX0ZFQVRVUkVTIHwgRkxF
WENBTl9IQVNfTUVDUl9GRUFUVVJFUw0KPiA+IAksDQo+ID4gfTsNCj4gDQo+IFllcyAtIHVzZSB0
d28gZGlmZmVyZW50IHZhcmlhYmxlcyBmb3IgdGhpcyBhbmQgYXNzaWduIHRoZW0gdG8gdHdvDQo+
IGNvbXBhdGlibGUgZW50cmllcy4NCj4gDQo+ID4gTm90ZSB0aGF0IHRoZSBsZWdhY3kgKG5vbi1S
WCBGSUZPIG1vZGUpIHNob3VsZCB3b3JrIG9uIGFsbCB0aGUgRmxleENBTg0KPiA+IHZhcmlhbnRz
LCBzbyB0aGlzIGEgZmVhdHVyZSB3aGljaCBzb21lLW9uZSBjYW4gZXhwb3NlL2hpZGUgYXMgcGVy
DQo+ID4gdGhlaXIgdXNlLWNhc2UsIGFzIGxvbmcgYXMgdGhlIGRyaXZlciBzdXBwb3J0cyBib3Ro
IHRoZSBSeC1GSUZPIGFuZA0KPiBub24tUlgtRklGTyBtb2RlIGxlZ3MuDQo+IA0KPiBTdXJlLCBi
dXQgbm90IHZpYSBhIGNvbXBpbGUgdGltZSBzd2l0Y2guDQo+IA0KDQpBZ3JlZWQuIFNvIEkgd2ls
bCBzaG9ydGx5IHNwaW4tb3V0IGEgdjIgYWNjb3JkaW5nbHkuDQoNClJlZ2FyZHMsDQpCaHVwZXNo
DQoNCg==
