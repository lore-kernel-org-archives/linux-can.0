From: Lederhilger Martin <M.Lederhilger@ds-automotion.com>
Subject: [PATCH] CAN NETWORK DRIVERS: set cf->can_id to CAN_ERR_CRTL when
 cf->data[1] is filled with either CAN_STATE_ERROR_WARNING or
 CAN_STATE_ERROR_PASSIVE
Date: Thu, 21 Dec 2017 14:42:44 +0000
Message-ID: <d2b8a0f4-e274-ef88-4428-b17c8a4f1966@ds-automotion.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.ds-automotion.com ([193.228.233.25]:40686 "EHLO
        mail.ds-automotion.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750921AbdLUO5v (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 21 Dec 2017 09:57:51 -0500
Content-Language: de-DE
Content-ID: <2DAB74A8B988E849A0C2F92026A20D26@fts.linz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "wg@grandegger.com" <wg@grandegger.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

VGhpcyBwYXRjaCBpbXByb3ZlcyBlcnJvciByZXBvcnRpbmcgb2YgdGhlIENBTiBkcml2ZXIgZm9y
IEVNUyBEci4gVGhvbWFzIFd1ZW5zY2hlIENQQy1VU0IvQVJNNy4NClNpZ25lZC1vZmYtYnk6IE1h
cnRpbiBMZWRlcmhpbGdlciA8bS5sZWRlcmhpbGdlckBkcy1hdXRvbW90aW9uLmNvbT4NCi0tLQ0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2Nhbi91c2IvZW1zX3VzYi5jIGIvZHJpdmVycy9uZXQv
Y2FuL3VzYi9lbXNfdXNiLmMNCmluZGV4IGIzZDAyNzU5YzIyNi4uY2Q4ZjI2MzMzZTBmIDEwMDY0
NA0KLS0tIGEvZHJpdmVycy9uZXQvY2FuL3VzYi9lbXNfdXNiLmMNCisrKyBiL2RyaXZlcnMvbmV0
L2Nhbi91c2IvZW1zX3VzYi5jDQpAQCAtMzkzLDYgKzM5Myw3IEBAIHN0YXRpYyB2b2lkIGVtc191
c2JfcnhfZXJyKHN0cnVjdCBlbXNfdXNiICpkZXYsIHN0cnVjdCBlbXNfY3BjX21zZyAqbXNnKQ0K
IA0KIAkJaWYgKGRldi0+Y2FuLnN0YXRlID09IENBTl9TVEFURV9FUlJPUl9XQVJOSU5HIHx8DQog
CQkgICAgZGV2LT5jYW4uc3RhdGUgPT0gQ0FOX1NUQVRFX0VSUk9SX1BBU1NJVkUpIHsNCisJCQlj
Zi0+Y2FuX2lkIHw9IENBTl9FUlJfQ1JUTDsNCiAJCQljZi0+ZGF0YVsxXSA9ICh0eGVyciA+IHJ4
ZXJyKSA/DQogCQkJICAgIENBTl9FUlJfQ1JUTF9UWF9QQVNTSVZFIDogQ0FOX0VSUl9DUlRMX1JY
X1BBU1NJVkU7DQogCQl9DQo=
