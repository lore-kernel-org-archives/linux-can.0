From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 0/2] can: flexcan: fix regression from v4.16-rc1
Date: Wed, 25 Apr 2018 16:50:38 +0200
Message-ID: <20180425145040.22031-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Gavin Schenk <g.schenk@eckelmann.de>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

SGVsbG8sCgp3aGVuIHBvcnRpbmcgdGhlIGtlcm5lbCBmcm9tIGEgaS5NWDI1IGJhc2VkIG1hY2hp
bmUgdG8gNC4xNy1yYzEgKGJ1dApzdGlsbCB1c2luZyB0aGUgb2xkIGR0YikgY2FuIGZhaWxlZCB0
byBwcm9iZS4gQWZ0ZXIgc29tZSByZXNlYXJjaCB3ZQpub3RpY2VkIHRoYXQgYSBjb21taXQgdGhh
dCB3YXMgbWVyZ2VkIGluIHRoZSB2NC4xNiBtZXJnZSB3aW5kb3cKaW50cm9kdWNlZCBhIGNoYW5n
ZSB0aGF0IGJyb2tlIHVzaW5nIGFuIG9sZGVyIGRldmljZSB0cmVlLgoKVGhpcyBzZXJpZXMgZmly
c3QgY29tbWl0IGZpeGVzIHRoZSBpc3N1ZS4KVGhlIHNlY29uZCBwYXRjaCBpbnRyb2R1Y2VzIGEg
ZmFsbGJhY2sgY29tcGF0aWJsZSB3aGljaCBtYXRjaGVzIHRoZQp1c3VhbCBkdC1zdHlsZSBvbiBp
Lk1YLiAoQmVmb3JlIHY0LjE2LXJjMSB0aGVyZSB3YXMgYSB3cm9uZyBmYWxsYmFjawpjb21wYXRp
YmxlIHRoYXQgd2FzIHJlbW92ZWQuKQoKQmVzdCByZWdhcmRzClV3ZQoKVXdlIEtsZWluZS1Lw7Zu
aWcgKDIpOgogIGNhbjogZmxleGNhbjogZml4IGVuZGlhbmVzcyBkZXRlY3Rpb24KICBhcm06IGR0
czogaW14WzM1XSo6IGRlY2xhcmUgZmxleGNhbiBkZXZpY2VzIHRvIGJlIGNvbXBhdGlibGUgdG8K
ICAgIGlteDI1J3MgZmxleGNhbgoKIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDM1LmR0c2kgfCAgNCAr
Ky0tCiBhcmNoL2FybS9ib290L2R0cy9pbXg1My5kdHNpIHwgIDQgKystLQogZHJpdmVycy9uZXQv
Y2FuL2ZsZXhjYW4uYyAgICB8IDI2ICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0tCiAzIGZpbGVz
IGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQoKLS0gCjIuMTcuMAoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFy
bS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1r
ZXJuZWwK
