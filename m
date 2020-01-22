From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 1/3] dt-bindings: net: can: m_can: Add Documentation for
 stb-gpios
Date: Wed, 22 Jan 2020 19:54:18 +0530
Message-ID: <8fc7c343-267d-c91c-0381-60990cfc35e8@ti.com>
References: <20200122080310.24653-1-faiz_abbas@ti.com>
 <20200122080310.24653-2-faiz_abbas@ti.com>
 <c3b0eeb8-bd78-aa96-4783-62dc93f03bfe@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <c3b0eeb8-bd78-aa96-4783-62dc93f03bfe@ti.com>
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
To: Dan Murphy <dmurphy@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org
Cc: mark.rutland@arm.com, nm@ti.com, catalin.marinas@arm.com, sriram.dash@samsung.com, t-kristo@ti.com, robh+dt@kernel.org, mkl@pengutronix.de, davem@davemloft.net, wg@grandegger.com
List-Id: linux-can.vger.kernel.org

T24gMjIvMDEvMjAgNzowNSBQTSwgRGFuIE11cnBoeSB3cm90ZToKPiBGYWl6Cj4gCj4gT24gMS8y
Mi8yMCAyOjAzIEFNLCBGYWl6IEFiYmFzIHdyb3RlOgo+PiBUaGUgQ0FOIHRyYW5zY2VpdmVyIG9u
IHNvbWUgYm9hcmRzIGhhcyBhbiBTVEIgcGluIHdoaWNoIGlzCj4+IHVzZWQgdG8gY29udHJvbCBp
dHMgc3RhbmRieSBtb2RlLiBBZGQgYW4gb3B0aW9uYWwgcHJvcGVydHkKPj4gc3RiLWdwaW9zIHRv
IHRvZ2dsZSB0aGUgc2FtZS4KPj4KPj4gU2lnbmVkLW9mZi1ieTogRmFpeiBBYmJhcyA8ZmFpel9h
YmJhc0B0aS5jb20+Cj4+IFNpZ25lZC1vZmYtYnk6IFNla2hhciBOb3JpIDxuc2VraGFyQHRpLmNv
bT4KPj4gLS0tCj4+IMKgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvY2Fu
L21fY2FuLnR4dCB8IDIgKysKPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQo+
Pgo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9j
YW4vbV9jYW4udHh0Cj4+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9j
YW4vbV9jYW4udHh0Cj4+IGluZGV4IGVkNjE0MzgzYWY5Yy4uY2M4YmEzZjdhMmFhIDEwMDY0NAo+
PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2Nhbi9tX2Nhbi50
eHQKPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9jYW4vbV9j
YW4udHh0Cj4+IEBAIC00OCw2ICs0OCw4IEBAIE9wdGlvbmFsIFN1Ym5vZGU6Cj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0aGF0IGNhbiBiZSB1c2VkIGZvciBDQU4vQ0FOLUZEIG1v
ZGVzLiBTZWUKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgCj4+IERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvY2FuL2Nhbi10cmFuc2NlaXZlci50eHQKPj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZvciBkZXRhaWxzLgo+PiArc3RiLWdwaW9zwqDC
oMKgwqDCoMKgwqAgOiBncGlvIG5vZGUgdG8gdG9nZ2xlIHRoZSBTVEIgKHN0YW5kYnkpIHNpZ25h
bCBvbgo+PiB0aGUgdHJhbnNjZWl2ZXIKPj4gKwo+IAo+IFRoZSBtX2Nhbi50eHQgaXMgZm9yIHRo
ZSBtX2NhbiBmcmFtZXdvcmsuwqAgSWYgdGhpcyBpcyBzcGVjaWZpYyB0byB0aGUKPiBwbGF0Zm9y
bSB0aGVuIGl0IHJlYWxseSBkb2VzIG5vdCBiZWxvbmcgaGVyZS4KPiAKPiBJZiB0aGUgcGxhdGZv
cm0gaGFzIHNwZWNpZmljIG5vZGVzIHRoZW4gbWF5YmUgd2UgbmVlZCBhCj4gbV9jYW5fcGxhdGZv
cm0udHh0IGJpbmRpbmcgZm9yIHNwZWNpZmljIHBsYXRmb3JtIG5vZGVzLsKgIEJ1dCBJIGxlYXZl
Cj4gdGhhdCBkZWNpc2lvbiB0byBSb2IuCgpTaW5jZSB0aGlzIGlzIHRyYW5zY2VpdmVyIGVuYWJs
ZSwgc2hvdWxkIHRoaXMgbm90IGJlIGluCkRvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9uZXQvY2FuL2Nhbi10cmFuc2NlaXZlci50eHQ/CgpUaGFua3MsClNla2hhcgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBt
YWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
