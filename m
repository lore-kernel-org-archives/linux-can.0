From: "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
Subject: AW: [PATCH 0/4] can: flexcan: fix state transition, suppress irq
 flooding
Date: Mon, 2 Oct 2017 16:02:25 +0000
Message-ID: <6ec1215f241c4707983a7371165c311a@SI-MBX1030.de.bosch.com>
References: <da2a7a180eb8445f8fc6539aeca5d44e@SI-MBX1030.de.bosch.com>
 <ad3f6258-609c-bc1e-a26c-778dc792b463@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:52277 "EHLO
        smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751082AbdJBQC1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 2 Oct 2017 12:02:27 -0400
In-Reply-To: <ad3f6258-609c-bc1e-a26c-778dc792b463@pengutronix.de>
Content-Language: de-DE
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>, Wolfgang Grandegger <wg@grandegger.com>, Andri Yngvason <andri.yngvason@marel.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "hs@denx.de" <hs@denx.de>, "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>, "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>

SGVsbG8gTWFyYywNCg0KSSBoYXZlIHRvIGFwb2xvZ2l6ZSBidXQgSSBkaWQgbm90IHBpY2sgdGhl
IGxhdGVzdCB2ZXJzaW9uIG9mIHRoZSBwYXRjaCBzZXQgZm9yIHBva2luZyBXb2xmZ2FuZyB5b3Uu
DQoNCkkgc2Nhbm5lZCB0aHJvdWdoIHRoZSBtYWlsaW5nIGxpc3QgYXJjaGl2ZSBhbmQgdGhlIGxh
dGVzdCBzdGF0ZSBvZiB0aGUgcGF0Y2hlcyBpcyB0aGlzIG9uZToNCg0KRnJvbSAxODQxOTg0YTE5
YjU4NTA0ZmNmMWM3MzgyNTMyNmQyYzFiMDM0MDE5IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0K
RnJvbTogWmh1IFlpIDx5aS56aHU1QGNuLmJvc2NoLmNvbT4NCkRhdGU6IFRodSwgMTQgU2VwIDIw
MTcgMTA6MzM6NDggKzA4MDANClN1YmplY3Q6IFtQQVRDSCBWMSAwLzZdIGNhbjogZmxleGNhbjog
Zml4IHN0YXRlIHRyYW5zaXRpb24sIHN1cHByZXNzIGlycSBmbG9vZGluZw0KDQpJdCBhbHNvIGNv
bnRhaW5zIFdvbGZnYW5nJ3MgQWNrZWQtYnkuDQoNClNvIHRoaXMgb25lIGlzIGRlZmluaXRlbHkg
bm90IHRoZSBsYXRlc3Q6DQoNCj4gPj4gRnJvbSA5MjUzNzQxYjdkOGJkZDRmYWJlNDFhOGRjMjIx
MTg2OTU4OWYwZjE4IE1vbiBTZXAgMTcgMDA6MDA6MDANCj4gMjAwMQ0KPiA+PiBGcm9tOiBaaHUg
WWkgPHlpLnpodTVAY24uYm9zY2guY29tPg0KPiA+PiBEYXRlOiBUdWUsIDUgU2VwIDIwMTcgMTY6
MDk6MDQgKzA4MDANCj4gPj4gU3ViamVjdDogW1BBVENIIDAvNF0gY2FuOiBmbGV4Y2FuOiBmaXgg
c3RhdGUgdHJhbnNpdGlvbiwgc3VwcHJlc3MgaXJxIGZsb29kaW5nDQo+ID4NCj4gPiBJcyB0aGUg
cGF0Y2ggc2V0IGFscmVhZHkgb24gaXRzIHdheSB1cHN0cmVhbSBvciBpcyB0aGVyZSBzb21ldGhp
bmcgd2Ugc3RpbGwgbmVlZA0KPiB0byBkbz8NCj4gDQo+IEknbGwgcHVzaCB0aGUgc2VyaWVzIHRv
IHVwc3RyZWFtLg0KDQpSZWdhcmRzLA0KTWFyaw0K
