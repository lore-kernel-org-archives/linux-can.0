Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD140242D65
	for <linux-can@vger.kernel.org>; Thu, 30 Jul 2026 07:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785395086; cv=none; b=DGWN8Ub+d4MM8RgiwAbMpwUGBLz5VX7LxKm7m2b0setSjkuoyAYfDakjd9OW6FIJWSIVj63w5PKCowROq3MOf7h7rkp9+oxJSQk2UrN8cTCMuI+LvDmv96K9kJTDNn05NCiqTTl6NVZ7vjctOWJMu8sG1azp73egJDQsSoxZZhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785395086; c=relaxed/simple;
	bh=HiO/PBOOwNp/oSvnT9r3yr375HQt7/lQIdPhFCs/79I=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=M1O+bTpViNDwXllRflK6TTnnSGzL8OD1vFYBU4zusLzOsTxNDvfkiTcbDuWHGeM3+ixdTo5ErFMo9x3pQL4o++9t5wSCOT32Iv6FEwUXHebflH2bYR0nD6vizCxgq2hsyAWa/UzEa/JNyhiOxkFSVhGLQ/SPY3a9nR2nzf3E50A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=EMEEzq2+; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="EMEEzq2+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1785395054; bh=HiO/PBOOwNp/oSvnT9r3yr375HQt7/lQIdPhFCs/79I=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=EMEEzq2+Gc50qAU2FQVVuh+5oePFlbgrOriPzmShEjdpvBNx6lcF38fDxhJ8Zje6Q
	 XjvO7rpscvTTRLxPZdiC+1YmNjIs9dAukBcEZ8yTHo3gdWvEbjQTbK3usMXeLYVyG0
	 k0osbNHvieQcVcjSJbClCG/mASxvrONg2BPUFT6A=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-XMAILINFO: MiMbQr1sY9IHdrNTOHvcz87HItx5NRH96sMqie5EVsJ87R6ykdmxOP1vwXuoK4
	 o1wsQtfEm1Y50HGwK9e+YdCzIwyACLF2h/xmLaJpmMVGdo/pauA2mKx1bIzMw4kIPEcT9t05KZyAx
	 3hXbJQslkSKos8UHMKgFKO3wULXIZJBwRcuivTTSGkEqX6uEhqHp+gidtOtmI/wp0XQMBIU/zMnbY
	 nl4WGTPPlONtC46cXv4V1mwa6SEh/q5fJQu3p9nHdsVBqpnq/TB3f00RePumWCsNGu3ebkmSfh2KV
	 eQUEeyTBhOa1CWqrug4ao9/CZlAUKydGKXWpIynjjxOJOk0lVwa5Q/HoFppijL5p2abYLCQ/7ZSt7
	 xwMsgBDpA8ZFi3N1PQBm523OVwTx7tE+9EuwFjsC0NCDkSTAEKTjXGhM3nkoEWnQivPjOrd0plYR+
	 Ea1HjtwvIkBQKYqpDKJxCHFN/FY8dR/qr/tbs8GQ0YeJXJq6vjPvu7TiG1/ujg/DRyolYfgLOjMV7
	 9f6dDVtMiMtIL+FjIT4cLP9/oiaK9GEDGfu9QTDPpVkLyRmP3Uo++xdNz87LSAsL2zUx9Mux1hM1k
	 RNgJQZC4RffQms+hOAhk7Z2SXXoAkIvp29UbEs5Sv2wK8oFywKdkKxThoZIltx9uvoTwuoMJT7aOH
	 gaTPRl4erA5NLILQuqQAlA+nbKfzNmM2esk9yp3SN9zt7wIZIianJ2PdSp8+g28PMB2d4m6b1Ex81
	 8NH7GRo1GjvyPHmWCa5THybxRLS0c61EW02dMpWR+ZyMWQyd1qc9M/dVMzl0Lr5Cug5rOPT4hBsxD
	 Wz9FJatFLThEzA8ZrlCNGPA4txeLunVIS9N4Es6IokaqURUW33Tqt5bOKLx9fuGhVa7I0GIrNAztW
	 SKi3y5fb4epojre28qmcxtZJIginJKsy+HNhXtU/TC+BPALXYZjq0NkiM9H11hnVsf9eioaomye2b
	 haG1KFXQMehb3RJ5kCYTYc6cV7RvnZwwPF0xbZmJY4Edab4/M8Gyrl31AIH1PgSXw8vUfoNzhKhd6
	 6e40zQ5JkldDxV+0UXRj3a5jwxg==
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?c2FzaGlrby1yZXZpZXdz?=" <sashiko-reviews@lists.linux.dev>
Cc: "=?utf-8?B?T2xpdmVyIEhhcnRrb3Bw?=" <socketcan@hartkopp.net>, "=?utf-8?B?VmluY2VudCBNYWlsaG9s?=" <mailhol@kernel.org>, "=?utf-8?B?T2xla3NpaiBSZW1wZWw=?=" <o.rempel@pengutronix.de>, "=?utf-8?B?TWFyYyBLbGVpbmUtQnVkZGU=?=" <mkl@pengutronix.de>, "=?utf-8?B?bGludXgtY2Fu?=" <linux-can@vger.kernel.org>
Subject: Re: [PATCH 1/3] can: rockchip_canfd: prevent TX stall on echo skb failure
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Thu, 30 Jul 2026 15:04:12 +0800
X-Priority: 3
Message-ID: <tencent_F699A504CB11E2803BC41ABF9F262F9A7F07@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20260730-master-v1-0-6945fdd4f0ff@qq.com>
 <tencent_D2D30ECD988C5C82D18863401362835F7606@qq.com>
	<20260730062555.D32E31F000E9@smtp.kernel.org>
In-Reply-To: <20260730062555.D32E31F000E9@smtp.kernel.org>
X-QQ-mid: xmsezb41-0t1785395052ta8gbpfjx

SGksCgpUaGFuayB5b3UgZm9yIHRoZSByZXZpZXcuCgo+ID7CoGRpZmbCoC0tZ2l0wqBhL2Ry
aXZlcnMvbmV0L2Nhbi9yb2NrY2hpcC9yb2NrY2hpcF9jYW5mZC10eC5jwqBiL2RyaXZlcnMv
bmV0L2Nhbi9yb2NrY2hpcC9yb2NrY2hpcF9jYW5mZC10eC5jCj4gPsKgaW5kZXjCoDEyMjAw
ZGNmZDMzODkuLmQyY2JlMjVjNDZkNmPCoDEwMDY0NAo+ID7CoC0tLcKgYS9kcml2ZXJzL25l
dC9jYW4vcm9ja2NoaXAvcm9ja2NoaXBfY2FuZmQtdHguYwo+ID7CoCsrK8KgYi9kcml2ZXJz
L25ldC9jYW4vcm9ja2NoaXAvcm9ja2NoaXBfY2FuZmQtdHguYwo+ID7CoEBAwqAtMTI1LDjC
oCsxMjUsMTjCoEBAwqBuZXRkZXZfdHhfdMKgcmtjYW5mZF9zdGFydF94bWl0KHN0cnVjdMKg
c2tfYnVmZsKgKnNrYizCoHN0cnVjdMKgbmV0X2RldmljZcKgKm5kZXYpCj4gPsKgwqAKPiA+
wqDCoCBmcmFtZV9sZW7CoD3CoGNhbl9za2JfZ2V0X2ZyYW1lX2xlbihza2IpOwo+ID7CoMKg
IGVycsKgPcKgY2FuX3B1dF9lY2hvX3NrYihza2IswqBuZGV2LMKgdHhfaGVhZCzCoGZyYW1l
X2xlbik7Cj4gPsKgLSBpZsKgKCFlcnIpCj4gPsKgLSBuZXRkZXZfc2VudF9xdWV1ZShwcml2
LT5uZGV2LMKgZnJhbWVfbGVuKTsKPiA+wqArIGlmwqAoZXJyKcKgewo+ID7CoCsgaWbCoChl
cnLCoD09wqAtRUlOVkFMKQo+ID7CoCsgZGV2X2tmcmVlX3NrYl9hbnkoc2tiKTsKPiA+wqAr
Cj4gPsKgKyBuZGV2LT5zdGF0cy50eF9kcm9wcGVkKys7Cj4gPsKgKyBpZsKgKG5ldF9yYXRl
bGltaXQoKSkKPiA+wqArIG5ldGRldl9lcnIobmRldizCoCIlczrCoGZhaWxlZMKgdG/CoHB1
dMKgZWNob8Kgc2tiOsKgJXBlXG4iLAo+ID7CoCsgwqDCoMKgX19mdW5jX18swqBFUlJfUFRS
KGVycikpOwo+ID7CoCsKPiA+wqArIHJldHVybsKgTkVUREVWX1RYX09LOwo+ID7CoCsgfQo+
ID7CoCsgbmV0ZGV2X3NlbnRfcXVldWUocHJpdi0+bmRldizCoGZyYW1lX2xlbik7Cj4gCj4g
W1NldmVyaXR5OsKgSGlnaF0KPiBUaGlzwqBpc8KgYcKgcHJlLWV4aXN0aW5nwqBpc3N1ZSzC
oGJ1dMKgScKgbm90aWNlZMKgYcKgcG90ZW50aWFswqB1c2UtYWZ0ZXItZnJlZQo+IHJlbGF0
ZWTCoHRvwqBlY2hvX3NrYsKgYWNjZXNzZXPCoGluwqBya2NhbmZkX3R4X3RhaWxfaXNfZWZm
KCnCoHdoZW7CoGNhbGxlZMKgZnJvbQo+IHJrY2FuZmRfc3RhcnRfeG1pdCgpwqB2aWHCoHJr
Y2FuZmRfZ2V0X2VmZmVjdGl2ZV90eF9mcmVlKCkuCj4gCj4gRG9lc8KgcmtjYW5mZF90eF90
YWlsX2lzX2VmZigpwqBuZWVkwqBsb2NraW5nwqB0b8Kgc2FmZWx5wqBhY2Nlc3PCoGVjaG9f
c2tiPwo+IAo+IGRyaXZlcnMvbmV0L2Nhbi9yb2NrY2hpcC9yb2NrY2hpcF9jYW5mZC10eC5j
OnJrY2FuZmRfdHhfdGFpbF9pc19lZmYoKcKgewo+IMKgwqDCoMKgLi4uCj4gdHhfdGFpbMKg
PcKgcmtjYW5mZF9nZXRfdHhfdGFpbChwcml2KTsKPiBza2LCoD3CoHByaXYtPmNhbi5lY2hv
X3NrYlt0eF90YWlsXTsKPiBpZsKgKCFza2IpwqB7Cj4gwqDCoMKgwqDCoMKgwqDCoC4uLgo+
IH0KPiAKPiBjZmTCoD3CoChzdHJ1Y3TCoGNhbmZkX2ZyYW1lwqAqKXNrYi0+ZGF0YTsKPiDC
oMKgwqDCoC4uLgo+IH0KPiAKPiBJZsKgYcKgY29uY3VycmVudMKgVFjCoGNvbXBsZXRpb27C
oGludGVycnVwdMKgb27CoGFub3RoZXLCoENQVcKgZXhlY3V0ZXMKPiBya2NhbmZkX3J4c3R4
X2ZpbHRlcigpwqBhbmTCoHJrY2FuZmRfaGFuZGxlX3R4X2RvbmVfb25lKCkswqB3b3VsZG4n
dMKgaXQKPiBjb25zdW1lwqB0aGlzwqBzYW1lwqBTS0LCoGFuZMKgc2V0wqBlY2hvX3NrYlt0
eF90YWlsXcKgdG/CoE5VTEw/Cj4gCj4gSWbCoHRoZcKgU0tCwqBpc8KgdGhlbsKgcXVldWVk
wqB0b8KgdGhlwqBOQVBJwqBvZmZsb2FkwqBzdWJzeXN0ZW3CoGFuZMKgaW1tZWRpYXRlbHkK
PiBwcm9jZXNzZWTCoGFuZMKgZnJlZWTCoG9uwqB0aGXCoHJlbW90ZcKgQ1BVLMKgY291bGTC
oHRoZcKgb3JpZ2luYWzCoHRocmVhZMKgY29udGludWUKPiBhbmTCoGRlcmVmZXJlbmNlwqB0
aGXCoG5vdy1mcmVlZMKgU0tCwqB3aGVuwqBhY2Nlc3NpbmfCoHNrYi0+ZGF0YT8KClllcywg
dGhpcyBpcyBhIHJlYWwgcHJlLWV4aXN0aW5nIHJhY2UuIFRoZSBUWCBjb21wbGV0aW9uIHBh
dGggcmVtb3ZlcyB0aGUKZWNobyBza2IgZnJvbSBgY2FuLmVjaG9fc2tiW11gIGFuZCBxdWV1
ZXMgaXQgdG8gdGhlIFJYIG9mZmxvYWQgcGF0aCwgd2hpbGUKYHJrY2FuZmRfdHhfdGFpbF9p
c19lZmYoKWAgY2FuIGNvbmN1cnJlbnRseSByZXRhaW4gdGhlIG9sZCBwb2ludGVyIGFuZApk
ZXJlZmVyZW5jZSBgc2tiLT5kYXRhYC4gSXQgY2FuIHRoZXJlZm9yZSBvYnNlcnZlIGluY29u
c2lzdGVudCBUWCBzdGF0ZSBvcgphY2Nlc3MgYW4gc2tiIGFmdGVyIGl0IGhhcyBiZWVuIGNv
bnN1bWVkIGJ5IHRoZSBjb21wbGV0aW9uIHBhdGguCgpUaGlzIGlzIGFkZHJlc3NlZCBieSBQ
QVRDSCAzLzMuIEl0IGFkZHMgYHR4X2xvY2tgIGFuZCB1c2VzCmBzcGluX2xvY2tfaXJxc2F2
ZSgpYCB0byBwcm90ZWN0IGB0eF9oZWFkYCwgYHR4X3RhaWxgLCBhbmQgdGhlIGVjaG8gc2ti
IHJpbmcgYXMKb25lIHN0YXRlLiBCb3RoIHRoZSBsb29rdXAgYW5kIGRlcmVmZXJlbmNlIGlu
CmBya2NhbmZkX3R4X3RhaWxfaXNfZWZmKClgIGFuZCB0aGUgZWNobyByZW1vdmFsIHBsdXMg
YHR4X3RhaWxgIHVwZGF0ZSBpbiB0aGUKY29tcGxldGlvbiBwYXRoIGFyZSBwZXJmb3JtZWQg
d2hpbGUgaG9sZGluZyB0aGlzIGxvY2suCgpJIHdpbGwgbWFrZSB0aGlzIHJlbGF0aW9uc2hp
cCBjbGVhcmVyIGluIHRoZSB2MiBjb3ZlciBsZXR0ZXIgYW5kIFBBVENIIDMvMwpkZXNjcmlw
dGlvbi4KClJlZ2FyZHMsCkN1bmhhbwoK

