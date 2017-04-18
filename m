From: "Huettel Mario (AE/PJ-SCI1)" <Mario.Huettel@de.bosch.com>
Subject: AW: [PATCH v4 7/7] can: m_can: Enable TX FIFO Handling for M_CAN IP
 version >= v3.1.x
Date: Tue, 18 Apr 2017 06:04:19 +0000
Message-ID: <c04fdd22a8364cc5a6d22f0b957d0fa8@SI-MBX1034.de.bosch.com>
References: <20170408121015.11428-1-mario.huettel@gmx.net>
 <20170408121015.11428-7-mario.huettel@gmx.net>
 <1f88411b-aa58-4e17-02cb-43fc0ffb953c@Microchip.com>
 <a3e6f8f0-8356-4e34-d26c-1cf243caffa0@hartkopp.net>
 <dce17476-21cb-2be8-202f-2662c75d1f3b@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:61568 "EHLO
        smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750917AbdDRGEW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 18 Apr 2017 02:04:22 -0400
In-Reply-To: <dce17476-21cb-2be8-202f-2662c75d1f3b@free-electrons.com>
Content-Language: de-DE
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Quentin Schulz <quentin.schulz@free-electrons.com>, "wenyou.yang@microchip.com" <wenyou.yang@microchip.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

SGkgUXVlbnRpbiwgaGkgV2VueW91LA0KDQpUb2RheSBJJ3ZlIHJlY2VpdmVkIGFub3RoZXIgZW1h
aWwgdGhhdCB0aGUgZHJpdmVyIGlzIG5vdCB3b3JraW5nIHdpdGggdGhlDQpNX0NBTiBpbiBBdG1l
bCdzIFNBTUE1RDIuDQoNCkNhbiB5b3Ugc2VuZCBtZSB0aGUgZGV2aWNlIHRyZWUgeW91J3JlIHVz
aW5nIGFuZCBwb3N0IHRoZSBkbWVzZyBvdXRwdXQNCm9mIHRoZSBtX2NhbiBkcml2ZXI/DQoNClRo
ZXJlIG1pZ2h0IGJlIGEgY2x1ZSB3aHkgaXQgaXNuJ3Qgd29ya2luZy4NClRoZSBmYWN0IHRoYXQg
aXQgaXMgd29ya2luZyBvbmUgdGltZSBhbmQgdGhlbiBzdG9wcyB3b3JraW5nIGxvb2tzIGxpa2Ug
c29tZSBwcm9ibGVtDQpJbiB0aGUgVFggRklGTyB0byBtZS4gQ2FuIHlvdSBwbGVhc2UgY2hlY2sg
d2l0aCBzb21lIHRoaXJkIGRldmljZS9vc2NpbGxvc2NvcGUsDQppZiB0aGUgY29udHJvbGxlciBp
cyBzZW5kaW5nIGRhdGEuIEkgd2FudCB0byBrbm93IGVocmUgdGhlIHByb2JsZW0gbGllcy4gSWYg
aXQncyBpbiB0aGUgVFggb3INClJYIHBhdGguDQoNCkFzIGZvciBub3cgSSBjYW4gb25seSB0aHJv
dyBzb21lIGlkZWFzIGludG8gdGhlIHJvdW5kOg0KKiBXaGF0IGFyZSB0aGUgUENMSyBhbmQgQ0NM
SyB2YWx1ZXM/IENDTEsgPj0gUENMSz8NCiogVFggRklGTyBjb25maWd1cmVkIHRvIG9uZSBlbGVt
ZW50IGFuZCBzb21ldGhpbmcgaGFwcGVucyBpbiB0aGF0IGNhc2UuDQoqIE5vIFRYIEV2ZW50IEZJ
Rk8gZWxlbWVudCBjb25maWd1cmVkLiBUaGUgZHJpdmVyIGFsc28gZG9lc24ndCB3b3JrIGluIHRo
aXMgY2FzZS4NCg0KDQpRdWVudGluIHdyb3RlOg0KPiBIaSBPbGl2ZXIsDQo+IA0KPiBPbiAxMy8w
NC8yMDE3IDA4OjMwLCBPbGl2ZXIgSGFydGtvcHAgd3JvdGU6DQo+PiBIaSBXZW55b3UsDQo+PiAN
Cj4+IGFzIFF1ZW50aW4gaGFkIG5vIHByb2JsZW1zIGluIGhpcyBzZXR1cDoNCj4+IA0KPiANCj4g
QWN0dWFsbHkganVzdCByZXRlc3RlZCBieSBkb2luZyB0aGUgc2FtZSBhcyBXZW55b3Ugb24gbXkg
U0FNQTVEMg0KPiBYcGxhaW5lZCBhbmQgSSBjYW4gYXR0ZXN0IEknbSBoYXZpbmcgdGhlIHNhbWUg
YmVoYXZpb3IgYXMgV2VueW91Lg0KPg0KPiBCZXN0IHJlZ2FyZHMsDQo+IFF1ZW50aW4NCg0KDQo=
