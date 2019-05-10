From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V3 0/7] can: flexcan: add CAN FD support for i.MX8
Date: Fri, 10 May 2019 10:49:53 +0000
Message-ID: <20190510104639.15170-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <netdev-owner@vger.kernel.org>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, "wg@grandegger.com" <wg@grandegger.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>, Joakim Zhang <qiangqing.zhang@nxp.com>
List-Id: linux-can.vger.kernel.org

SGkgTWFyYywNCg0KU3RlZmFuLWdhYnJpZWwgTWlyZWEgd2FzIHN1Y2Nlc3NmdWxseSB2YWxpZGF0
ZWQgdGhpcyBwYXRjaCBzZXQgb24gYW4gUzMyVjIzNA0KYmFzZWQgYm9hcmQsIGFuZCBJIGhhdmUg
aW1wcm92ZWQgdGhlIGRyaXZlciB3aXRoIGhpcyB2YWx1YWJsZSBmZWVkYmFjay4NCg0KSSBhbHNv
IHNwbGl0IHRoZSBwYXRjaCBzZXQgaW50byBzbWFsbCBwYXJ0aWNsZSBzaXplIHRoYXQgd2lsbCBl
YXN5IHlvdXINCnBhdGNoIHJldmlldy4NCg0KUmVnYXJkcywNCkpvYWtpbSBaaGFuZw0KDQpEb25n
IEFpc2hlbmcgKDMpOg0KICBjYW46IGZsZXhjYW46IGltcHJvdmUgYml0dGltaW5nIHNldHRpbmcg
Zm9yIGZkIG1vZGUNCiAgY2FuOiBmbGV4Y2FuOiBhZGQgQ0FORkQgQlJTIHN1cHBvcnQNCiAgY2Fu
OiBmbGV4Y2FuOiBhZGQgaW14OHFtIHN1cHBvcnQNCg0KSm9ha2ltIFpoYW5nICg0KToNCiAgY2Fu
OiBmbGV4Y2FuOiBhbGxvY2F0ZSBza2IgaW4gbWFpbGJveF9yZWFkDQogIGNhbjogZmxleGNhbjog
dXNlIHN0cnVjdCBjYW5mZF9mcmFtZSBmb3Igbm9ybWFsIENBTiBmcmFtZQ0KICBjYW46IGZsZXhj
YW46IGFkZCBDQU4gRkQgbW9kZSBzdXBwb3J0DQogIGNhbjogZmxleGNhbjogYWRkIElTTyBDQU4g
RkQgZmVhdHVyZSBzdXBwb3J0DQoNCiBkcml2ZXJzL25ldC9jYW4vZmxleGNhbi5jICAgICAgfCAy
ODMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tDQogZHJpdmVycy9uZXQvY2FuL3J4
LW9mZmxvYWQuYyAgIHwgIDMzICsrLS0NCiBpbmNsdWRlL2xpbnV4L2Nhbi9yeC1vZmZsb2FkLmgg
fCAgIDUgKy0NCiAzIGZpbGVzIGNoYW5nZWQsIDI1NSBpbnNlcnRpb25zKCspLCA2NiBkZWxldGlv
bnMoLSkNCg0KLS0gDQoyLjE3LjENCg0K
