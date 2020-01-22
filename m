From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH 1/3] dt-bindings: net: can: m_can: Add Documentation for
 stb-gpios
Date: Wed, 22 Jan 2020 07:35:52 -0600
Message-ID: <c3b0eeb8-bd78-aa96-4783-62dc93f03bfe@ti.com>
References: <20200122080310.24653-1-faiz_abbas@ti.com>
 <20200122080310.24653-2-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <20200122080310.24653-2-faiz_abbas@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Faiz Abbas <faiz_abbas@ti.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org
Cc: mark.rutland@arm.com, nm@ti.com, catalin.marinas@arm.com, sriram.dash@samsung.com, t-kristo@ti.com, robh+dt@kernel.org, mkl@pengutronix.de, davem@davemloft.net, wg@grandegger.com
List-Id: linux-can.vger.kernel.org

RmFpegoKT24gMS8yMi8yMCAyOjAzIEFNLCBGYWl6IEFiYmFzIHdyb3RlOgo+IFRoZSBDQU4gdHJh
bnNjZWl2ZXIgb24gc29tZSBib2FyZHMgaGFzIGFuIFNUQiBwaW4gd2hpY2ggaXMKPiB1c2VkIHRv
IGNvbnRyb2wgaXRzIHN0YW5kYnkgbW9kZS4gQWRkIGFuIG9wdGlvbmFsIHByb3BlcnR5Cj4gc3Ri
LWdwaW9zIHRvIHRvZ2dsZSB0aGUgc2FtZS4KPgo+IFNpZ25lZC1vZmYtYnk6IEZhaXogQWJiYXMg
PGZhaXpfYWJiYXNAdGkuY29tPgo+IFNpZ25lZC1vZmYtYnk6IFNla2hhciBOb3JpIDxuc2VraGFy
QHRpLmNvbT4KPiAtLS0KPiAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQv
Y2FuL21fY2FuLnR4dCB8IDIgKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykK
Pgo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2Nh
bi9tX2Nhbi50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2Nhbi9t
X2Nhbi50eHQKPiBpbmRleCBlZDYxNDM4M2FmOWMuLmNjOGJhM2Y3YTJhYSAxMDA2NDQKPiAtLS0g
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2Nhbi9tX2Nhbi50eHQKPiAr
KysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2Nhbi9tX2Nhbi50eHQK
PiBAQCAtNDgsNiArNDgsOCBAQCBPcHRpb25hbCBTdWJub2RlOgo+ICAgCQkJICB0aGF0IGNhbiBi
ZSB1c2VkIGZvciBDQU4vQ0FOLUZEIG1vZGVzLiBTZWUKPiAgIAkJCSAgRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9jYW4vY2FuLXRyYW5zY2VpdmVyLnR4dAo+ICAgCQkJICBm
b3IgZGV0YWlscy4KPiArc3RiLWdwaW9zCQk6IGdwaW8gbm9kZSB0byB0b2dnbGUgdGhlIFNUQiAo
c3RhbmRieSkgc2lnbmFsIG9uIHRoZSB0cmFuc2NlaXZlcgo+ICsKClRoZSBtX2Nhbi50eHQgaXMg
Zm9yIHRoZSBtX2NhbiBmcmFtZXdvcmsuwqAgSWYgdGhpcyBpcyBzcGVjaWZpYyB0byB0aGUgCnBs
YXRmb3JtIHRoZW4gaXQgcmVhbGx5IGRvZXMgbm90IGJlbG9uZyBoZXJlLgoKSWYgdGhlIHBsYXRm
b3JtIGhhcyBzcGVjaWZpYyBub2RlcyB0aGVuIG1heWJlIHdlIG5lZWQgYSAKbV9jYW5fcGxhdGZv
cm0udHh0IGJpbmRpbmcgZm9yIHNwZWNpZmljIHBsYXRmb3JtIG5vZGVzLsKgIEJ1dCBJIGxlYXZl
IAp0aGF0IGRlY2lzaW9uIHRvIFJvYi4KCkFsc28gSSBwcmVmZXIgeW91IHNwZWxsIG91dCBzdGFu
ZGJ5IGxpa2UgdGhlIGdwaW9zIGFyZSBzcGVsbGVkIG91dCBpbiAKdGhlIHRjYW4gYmluZGluZy4K
CkRhbgoKCj4gICBFeGFtcGxlOgo+ICAgU29DIGR0c2k6Cj4gICBtX2NhbjE6IGNhbkAyMGU4MDAw
IHsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4
LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFy
bS1rZXJuZWwK
