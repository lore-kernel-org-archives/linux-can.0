From: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Subject: RE: Adding new CAN driver
Date: Wed, 2 Nov 2016 13:38:22 +0000
Message-ID: <SG2PR06MB10384C09F05B12731B6D7151C3A00@SG2PR06MB1038.apcprd06.prod.outlook.com>
References: <CAKT-o-cOb0sqRmvH+BKjX4yvBLp5_GqVd6=ifr2jm5T75-hcZA@mail.gmail.com>
 <c8ba150c-11d2-176c-f3b7-936d89f54de2@hartkopp.net>
 <CAKT-o-cDp0vUY12=Tyv909QC-ZcGpxFKxzSAuf0mrzAojS38Jw@mail.gmail.com>
 <ce34a9f7-d310-00aa-6d53-ad08b45cfa3f@hartkopp.net>
 <CAKT-o-cZryPfqkU2rOPu1SdEp8imkTke_NzVgwgghOY6RxrZmg@mail.gmail.com>
 <22552.25820.453841.413376@gargle.gargle.HOWL>
 <CAKT-o-d_tLkZgAuJz7rrRaDPxmi3hDiLmVhLcpjNBc1weDLvyg@mail.gmail.com>
 <ddb4ed13-819f-ad8c-8ce2-da7585a79098@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:23839 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751795AbcKBNsH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 2 Nov 2016 09:48:07 -0400
In-Reply-To: <ddb4ed13-819f-ad8c-8ce2-da7585a79098@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, =?utf-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?= <remigiusz.kollataj@mobica.com>, Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Oliver Hartkopp <socketcan@hartkopp.net>

PiBPbiAxMS8wMi8yMDE2IDA4OjIzIEFNLCBLb8WCxYLEhXRhaiwgUmVtaWdpdXN6IHdyb3RlOg0K
PiA+IEhpIFV3ZSwNCj4gPg0KPiA+IE5vdCBzdXJlIGlmIHlvdSBhcmUgYXNraW5nIGFib3V0IHRl
cm1pbmF0aW9uIG9yIGFib3V0IHRoZSBkcml2ZXINCj4gPiBpdHNlbGYsIHNvIGxldCBtZSBnaXZl
IHR3byBhbnN3ZXJzLg0KPiA+DQo+ID4gSSdsbCB0cnkgdG8gc2VuZCB0aGUgcGF0Y2ggdGlsbCBl
bmQgb2YgdGhpcyB3ZWVrLiBJbiB0aGUgbWVhbnRpbWUgeW91DQo+ID4gbWF5IHN0aWxsIHVzZSB0
aGUgZHJpdmVyIGZyb20gdGhlIGdpdGh1YiByZXBvc2l0b3J5DQo+ID4gKGh0dHBzOi8vZ2l0aHVi
LmNvbS9ya29sbGF0YWovbWNiYV91c2IpLiBJIGFtIGtlZXBpbmcgaXQgdXAgdG8gZGF0ZS4NCj4g
Pg0KPiA+IEkgZGlkbid0IGdldCBhIGNoYW5jZSB0byB3b3JrIG9uIGFkZGluZyBzdXBwb3J0IGZv
ciB0ZXJtaW5hdGlvbiB0bw0KPiA+ICJpcCIuIEJlZm9yZSBpbnZlc3RpbmcgYW55IGVmZm9ydCBJ
IHdvdWxkIHByZWZlciB0byBnZXQgY29uZmlybWF0aW9uDQo+ID4gZnJvbSBPbGl2ZXIgb2YgTWFy
YyB0aGF0IHRoZSBkaXJlY3Rpb24gaXMgcmlnaHQuIEFueXdheSBzZXR0aW5nIHVwDQo+ID4gdGVy
bWluYXRpb24gdmlhIHN5c2ZzIHdvcmtzIGp1c3QgZmluZS4gSXQgaXMgZGVzY3JpYmVkIGluIHJl
YWRtZSBmaWxlDQo+ID4gaW4gcmVwb3NpdG9yeS4NCj4gDQo+IEknZCBsaWtlIHRvIHNlZSBhIG5l
dGxpbmsgaW50ZXJmYWNlIGZvciB0aGlzLiBPbGl2ZXIgd2hhdCBhYm91dCBhZGRpbmcgaXQNCj4g
dG8gQ1RSTF9NT0RFPw0KDQpJcyBpdCBhYm91dCB0aGUgQ0FOIGJ1cyB0ZXJtaW5hdGlvbj8gV2h5
IHRoZSBkcml2ZXIgbmVlZCB0byBiZSBhd2FyZSBvZiBpdD8NCklmIGl0IG5lZWRlZCBmb3Igc29t
ZSByZWFzb24gc2hvdWxkbid0IGl0IGJlIGEgZGV2aWNlIHRyZWUgcHJvcGVydHkgb2YgdGhhdCBk
ZXZpY2UvYnJpZGdlIG5vZGU/DQoNClRoYW5rcywNClJhbWVzaA0K
