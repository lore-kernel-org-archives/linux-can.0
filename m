From: "Pankajkumar Misra (RBEI/EEA2)" <Pankaj.Kumar@in.bosch.com>
Subject: CAN implementation on A20 Allwinner
Date: Thu, 27 Nov 2014 17:54:18 +0000
Message-ID: <369acf6bdf8b4ae3840b69bef10b5082@SGPMBX1004.APAC.bosch.com>
References: <2d24e34ceb8e4fe4b0b7c74b9a36da44@SGPMBX1006.APAC.bosch.com>
 <54770F0F.7050904@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:28371 "EHLO
	smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784AbaK0RyY (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 27 Nov 2014 12:54:24 -0500
Received: from vsmta11.fe.internet.bosch.com (unknown [10.4.98.51])
	by imta24.fe.bosch.de (Postfix) with ESMTP id 7CBE0D8019D
	for <linux-can@vger.kernel.org>; Thu, 27 Nov 2014 18:54:22 +0100 (CET)
Received: from FE-MBX1010.de.bosch.com (vsgw23.fe.internet.bosch.com [10.4.98.23])
	by vsmta11.fe.internet.bosch.com (Postfix) with ESMTP id 3BA0E238027F
	for <linux-can@vger.kernel.org>; Thu, 27 Nov 2014 18:54:22 +0100 (CET)
In-Reply-To: <54770F0F.7050904@hartkopp.net>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

SGVsbG8gQWxsLA0KDQpJIGFtIGN1cnJlbnRseSB3b3JraW5nIG9uIE9saW1leCBBMjAtT2xpbnV4
aW5vIE1pY3JvIGJvYXJkLg0KDQpJIGFtIHRyeWluZyB0byBicmluZy11cCBDQU4gZGV2aWNlIGF2
YWlsYWJsZSBvbiBBMjAgQWxsd2lubmVyIGNoaXAgYXQgYmFzZSBhZGRyZXNzIDB4MDFjMkJDMDAu
DQoNCkluIGluaXRpYWxpemF0aW9uIEkgYW0gZW5hYmxpbmcgY2xvY2ssIHNldHRpbmcgcGlucyBm
b3IgVHggJiBSeCwgSVJRICYgSVNSIGFyZSBzZXQuIEludGVycnVwdCxUeCAmIFJ4IGVuYWJsZWQu
DQpJbiB0cmFuc21pdCBmcmFtZSBmdW5jdGlvbiwgYWZ0ZXIgYWRkaW5nIHJlcXVpcmVkIGRhdGEg
aW50byBidWZmZXIgSSBhbSBzZXR0aW5nIGNvbW1hbmQgdG8gMHgwMSwgd2hpY2ggbWVhbnMgdHJh
bnNtaXQgcmVxdWVzdCBzZXQuDQpCdXQgZGF0YSBpcyBuZXZlciB0cmFuc21pdHRlZCBmcm9tIHRo
ZSBidWZmZXIuIENhbiBzdGF0dXMgc2F5cyAiY29udHJvbGxlciBpbiB0aGUgcHJvY2VzcyBvZiB0
cmFuc21pdHRpbmcgYSBtc2ciLiBCdXQgaXQgbmV2ZXIgdHJhbnNtaXRzLg0KSW50ZXJydXB0IGlz
IG5ldmVyIGdlbmVyYXRlZCBmb3IgdHguIElTUiBpcyBuZXZlciBjYWxsZWQuIE5vdGhpbmcgY29t
ZXMgb24gY2FuZHVtcC4NCg0KT25lIHN0cmFuZ2UgdGhpbmcgaXMgdGhhdCBpdCBpcyBub3QgcmVz
cG9uZGluZyB0byBjYW5zZW5kIGFnYWluLiBpLmUuIHBvc3NpYmx5IGl0IGlzIGdvaW5nIGluIGlu
ZmluaXRlIGxvb3Agc29tZXdoZXJlLg0KDQpXaGF0IGFtIEkgbWlzc2luZyAhIQ0KDQpCZXN0IFJl
Z2FyZHMsDQpQYW5rYWoNCg==
