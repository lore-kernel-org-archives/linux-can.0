From: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>
Subject: RE: [PATCH 3/4] can: flexcan: implement error passive state quirk
Date: Mon, 11 Sep 2017 02:29:27 +0000
Message-ID: <6903931307914574bcc729ece55c0b0d@SGPMBX1017.APAC.bosch.com>
References: <87faf67d90a246938e0b51d2ddbc8b82@SGPMBX1017.APAC.bosch.com>
 <cc678b44-0aa8-ac91-567e-8b9c234ed024@grandegger.com>
 <ad3cf1da-ca4b-6149-876a-0c983f9d48c8@grandegger.com>
 <dfb4fd69b6d0463ca565245f4c072b90@SGPMBX1017.APAC.bosch.com>
 <1685670a-c87d-2204-7e46-c36ebb8b072f@grandegger.com>
 <bf6cad90aa9d4e8da439a5ac2e21eafd@SGPMBX1017.APAC.bosch.com>
 <20820cdf-afff-9d04-3c9c-511e45bd0853@grandegger.com>
 <1ccdad7593e34103bd4d96f5b1e64ea7@SGPMBX1017.APAC.bosch.com>
 <92d997b5-957e-7e0b-70aa-bff16e289e81@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:45456 "EHLO
        smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751918AbdIKC3d (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 10 Sep 2017 22:29:33 -0400
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Andri Yngvason <andri.yngvason@marel.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "hs@denx.de" <hs@denx.de>, "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>, "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>

SGVsbG8gV29sZmdhbmcsDQoNClRoYW5rcyBhIGxvdCBmb3Igd29ya2VkIHdpdGggdXMgdG8gaW1w
cm92ZSBhbmQgdGVzdCB0aGUgcGF0Y2hlcyBpbg0KdGhlc2UgZGF5cywgYW5kIGFwcHJlY2lhdGUg
eW91ciB2YWx1YWJsZSBpbnB1dHMgZm9yIG1ha2luZyB0aGUNCnBhdGNoZXMgYmV0dGVyLiA6KQ0K
DQpBY2NvcmRpbmcgdG8gdGhlIHRlc3QgcmVzdWx0cywgc2VlbXMgdGhlIHBhdGNoZXMgYXJlIHdv
cmtlZCBmaW5lIHdpdGgNCmkuTVg2LCBpLk1YNTMgYW5kIGkuTVgyOCBhdCBsZWFzdCwgc28gd2Un
cmUgd29uZGVyaW5nOg0KMS4gRG8geW91IHRoaW5rIHRoZSBwYXRjaGVzIGFyZSByZWFkeSBmb3Ig
YWNjZXB0LCBvciB0aGVyZSdyZSBzb21ldGhpbmcNCiAgIGxlZnQgd2Ugc2hvdWxkIHdvcmsgb24/
IEFuZCB3aGF0IGRvIHlvdSB0aGluayB3ZSBjYW4gaGVscCB3aXRoIHRvDQogICBtYWtlIHRoZSBw
YXRjaGVzIGZpbmFsaXplPw0KDQoyLiBBZnRlciB0aGUgcGF0Y2hlcyBhcmUgcmVhZHksIGNvdWxk
IHlvdSBwbGVhc2UgaGVscCB0byBjcmVhdGUgcGF0Y2hlcw0KICAgZm9yIGkuTVg1MyBhbmQgaS5N
WDI4IGFzIHlvdSBhbHJlYWR5IHRlc3RlZCB0aGVtPyBTbyB0aGF0IHdlIGNhbiBmaXgNCiAgIHN0
YXRlIHRyYW5zaXRpb25zIGFuZCB0aHJvdHRsZSBpbnRlcnJ1cHQgZmxvb2RpbmcgZm9yIHRoZXNl
IDMgY29yZXMNCiAgIGF0IGxlYXN0Lg0KDQpCZXN0IHJlZ2FyZHMNCllpDQo=
