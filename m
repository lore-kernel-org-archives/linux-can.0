From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH] can: flexcan: change .tseg1_min value to 2 in bittiming const
Date: Mon, 29 Apr 2019 07:48:00 +0000
Message-ID: <20190429074551.25754-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <netdev-owner@vger.kernel.org>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: "wg@grandegger.com" <wg@grandegger.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "davem@davemloft.net" <davem@davemloft.net>
Cc: dl-linux-imx <linux-imx@nxp.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Joakim Zhang <qiangqing.zhang@nxp.com>
List-Id: linux-can.vger.kernel.org

VGltZSBTZWdtZW50MSh0c2VnMSkgaXMgY29tcG9zZWQgb2YgUHJvcGFnYXRlIFNlZ21lbnQocHJv
cF9zZWcpIGFuZA0KUGhhc2UgU2VnbWVuZzEocGhhc2Vfc2VnMSkuIFRoZSByYW5nZSBvZiBUaW1l
IFNlZ21lbnQxKHBsdXMgMikgaXMgMg0KdXAgdG8gMTYgYWNjb3JkaW5nIHRvIGxhdGVzdCByZWZl
cmVuY2UgbWFudWFsLiBUaGF0IG1lYW5zIHRoZSBtaW5pbXVtDQp2YWx1ZSBvZiBQUk9QU0VHIGFu
ZCBQU0VHMSBiaXQgZmllbGQgaXMgMC4gU28gY2hhbmdlIC50c2VnMSBtaW4gdmFsdWUNCnRvIDIu
DQoNClNpZ25lZC1vZmYtYnk6IEpvYWtpbSBaaGFuZyA8cWlhbmdxaW5nLnpoYW5nQG54cC5jb20+
DQotLS0NCiBkcml2ZXJzL25ldC9jYW4vZmxleGNhbi5jIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9u
ZXQvY2FuL2ZsZXhjYW4uYyBiL2RyaXZlcnMvbmV0L2Nhbi9mbGV4Y2FuLmMNCmluZGV4IGUzNTA4
M2ZmMzFlZS4uMmVhMzVlZjRhYTI3IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvY2FuL2ZsZXhj
YW4uYw0KKysrIGIvZHJpdmVycy9uZXQvY2FuL2ZsZXhjYW4uYw0KQEAgLTMyNyw3ICszMjcsNyBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IGZsZXhjYW5fZGV2dHlwZV9kYXRhIGZzbF9sczEwMjFhX3Iy
X2RldnR5cGVfZGF0YSA9IHsNCiANCiBzdGF0aWMgY29uc3Qgc3RydWN0IGNhbl9iaXR0aW1pbmdf
Y29uc3QgZmxleGNhbl9iaXR0aW1pbmdfY29uc3QgPSB7DQogCS5uYW1lID0gRFJWX05BTUUsDQot
CS50c2VnMV9taW4gPSA0LA0KKwkudHNlZzFfbWluID0gMiwNCiAJLnRzZWcxX21heCA9IDE2LA0K
IAkudHNlZzJfbWluID0gMiwNCiAJLnRzZWcyX21heCA9IDgsDQotLSANCjIuMTcuMQ0KDQo=
