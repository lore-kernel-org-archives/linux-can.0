From: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>
Subject: RE: [PATCH 5/6] can: flexcan: fix i.MX28 state transition issue
Date: Thu, 14 Sep 2017 08:27:29 +0000
Message-ID: <6c6626de8719436c965678c563951a7b@SGPMBX1017.APAC.bosch.com>
References: <b1bfae3d42ca46ecaa83fe8a943da591@SGPMBX1017.APAC.bosch.com>
 <cad7ad55-6c91-3b64-3479-9221d1b31346@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:50128 "EHLO
        smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751174AbdINI1e (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 14 Sep 2017 04:27:34 -0400
In-Reply-To: <cad7ad55-6c91-3b64-3479-9221d1b31346@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Andri Yngvason <andri.yngvason@marel.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "hs@denx.de" <hs@denx.de>, "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>, "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>

SGVsbG8gTWFyYywNCg0KPkZyb206IE1hcmMgS2xlaW5lLUJ1ZGRlIFttYWlsdG86bWtsQHBlbmd1
dHJvbml4LmRlXQ0KPlNlbnQ6IFdlZG5lc2RheSwgU2VwdGVtYmVyIDEzLCAyMDE3IDg6NTAgUE0N
Cj4gWy4uLl0NCj5PbiAwOS8xMy8yMDE3IDExOjM5IEFNLCBaSFUgWWkgKFNULUZJUi9FTkcxLVpo
dSkgd3JvdGU6DQo+PiBGcm9tIDE5YTJlOTY2ODNkZWJiNTE0YjI2NmQxNDM1MzI3YWI0ZWRkOGY4
ODIgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxDQo+PiBGcm9tOiBXb2xmZ2FuZyBHcmFuZGVnZ2Vy
IDx3Z0BncmFuZGVnZ2VyLmNvbT4NCj4+IERhdGU6IE1vbiwgMTEgU2VwIDIwMTcgMDg6NTk6NTMg
KzAyMDANCj4+IFN1YmplY3Q6IFtQQVRDSCA1LzZdIGNhbjogZmxleGNhbjogZml4IGkuTVgyOCBz
dGF0ZSB0cmFuc2l0aW9uIGlzc3VlDQo+Pg0KPj4gRW5hYmxlIEZMRVhDQU5fUVVJUktfQlJPS0VO
X1BFUlJfU1RBVEUgZm9yIGkuTVgyOCB0byByZXBvcnQgY29ycmVjdA0KPj4gc3RhdGUgdHJhbnNp
dGlvbnMsIGVzcGVjaWFsbHkgdG8gZXJyb3IgcGFzc2l2ZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBXb2xmZ2FuZyBHcmFuZGVnZ2VyIDx3Z0BncmFuZGVnZ2VyLmNvbT4NCj4NCj5QbGVhc2UgYWRk
IHlvdXIgUy1vLWIgd2hlbiBzZW5kaW5nIHBhdGNoZXMgZnJvbSBvdGhlciBwZW9wbGUuIElzIGl0
IG9rIG8NCj5hZGQgeW91cidzIHdoaWxlIGFwcGx5aW5nIHRoZSBwYXRjaD8NClN1cmUsIHRoYW5r
cyBmb3IgdGhlIGhpbnQhIEknbGwgYWRkIG91ciBzLW8tYiBoZXJlIHRvby4NCg0KQmVzdCByZWdh
cmRzDQpZaQ0K
