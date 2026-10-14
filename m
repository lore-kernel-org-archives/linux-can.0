Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362362D5925
	for <linux-can@vger.kernel.org>; Wed, 14 Oct 2026 04:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791952546; cv=none; b=jiJ3lA0AIX8sRsmrcgZj9tnxM4PclstbFAxDmmURjVTDX5BWX5tbV5lWctm7O8A6KMUkJ7DtoVlgOSvp3tsYDi8ft/TIuiAL6pbNMx3AwBcu3SeAC0IKY9Sz3Huu+GfTYpBfEFRFeLq2wSUbli24wwduZY7vpPQA+VO7mqsoX+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791952546; c=relaxed/simple;
	bh=6ujtAJlGmqR5wqVhWDRituefF2TemEcF244dZ9ui1nk=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=S01dSz1ZkxCkeVyu1gSMzjf6iagV9Me5cx1Gg6R9ch0yCm8ECyK5BiA8EqRiERpf/kOEeaXLmeCyhlP20Qfs39x7NfyT1rx70luQSYDNYo1wg+j0yAGcf+i/pt2SDSVWzGtO+cAf7q4eAPfeYd0yDCT+iwvuNqNd5tVlQtLlDMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=bhCSWMmZ; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="bhCSWMmZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1791952535; bh=6ujtAJlGmqR5wqVhWDRituefF2TemEcF244dZ9ui1nk=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=bhCSWMmZrMh46WAZ4Zn+/7n+5VMA9aygPQKNpJv8jLqgAFi33zkvF4d2CkpRNvgGS
	 ttkE3TzEDT4UUJ3tF7BGxW79hFeVtxk5v+C/6JwBSfxCNru9BD2MFLl8KO1jNkdwob
	 Nit9volqUEYpu1RZ7ZzUiRm3jeOSN1WMFylCbW+4=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-XMAILINFO: M7n9VusxZAlPbKpGXT+gLDlP4d9Xq1lq4eob0AwV0Sb0fVjn/OilceMXWXZ2um
	 r1pFtgqOs6ss+cOji0kTbqdQ2CebYmuL2d+hj1hDWffek7Gl0KcvIAMJ4AezGW6FqkqKLUN/08QKN
	 PBLmdAnsdAUy/DLepnCsbdts2M+UFcx18/YhCkVsR5nZwWjwqdvJd4yT8VHlKXXPvm2+j4aV8AmIW
	 96L3fON5LMxktnLV7UL4GdAGigBNd2Tttfu+a209v7V9+use+XWSsJVbH6MmZGUBNroT4UQUscSwQ
	 6TCzBQZSTZXamvMkQmW42vLxTsboRGLKzIOPk8pCfhbNLmDlOXgfT2AmtYjOknGMlO77c3sEgd5Vp
	 +1hSLGdqvMa8mCLEj5jU2RkTr1tbobWrM67OwFpEgeXMzxnOuAaEZzdj881jin8BH7NYqYoQ++que
	 BZzpuG+CUKU1qYTDajP1UOF8RiBiWrpPzXXjOEHw+pOBHdBFr6AfBquyo7GOyEzBuNVARG9vwBREd
	 0JH8yrl34VAs2CaRUfxNCIOGvvw0cxlJN723HO8ExPNQYIM5NEvTDgp2qMcIiz0pFFE25CSjWvSGp
	 w6xhce5TTO98Yd+LHSciiI9lg/zS/gNeNIsvJzjKoUZTqEl/zOOnKr94rsrcp4EBio4B2cZcXpE3p
	 Cw3PyvnVwKTtJKSRWB7GksM7dAzegHqWcOjZ7I1ZBhgVXxQBFfFsUOgy1z21qTTB8aEC53GAy4kHm
	 0XwazqM57t0Fg4xAtM3daOf7kT6y1xIfNALRDsK44CWjoTXhSFKAkCpPOuyVkk3Uvpjd/MYj3tzCD
	 luesG5vhZ7FpWNhMQdgZ2TtbPAVVUFlMNbBFNGdPGQyKYIWnHqu/alK/dNDkLKatuEDy45pSSMzDb
	 9TQKK+wTQrPRWzBpcCdE+5WXS/vMqYOsFLI7Agh2iCujmAbT6DqMJMBtev6diGbidolFdVghEQQfO
	 swp0nyj5MYElCZMOUAbnTvPr74TchqH5r3Uj0LXPNnf7/u8QQLECvpgJqVb2VNUKmrCTAJRul2EYK
	 YYp2dIi7VIt3exkYzQoEbSZ12+NFgjgLLBoQPuAt7jBnzdesACZPEH27ia3bQsb/c6MY4
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?c2FzaGlrby1yZXZpZXdz?=" <sashiko-reviews@lists.linux.dev>
Cc: "=?utf-8?B?bGludXgtY2Fu?=" <linux-can@vger.kernel.org>, "=?utf-8?B?TWFyYyBLbGVpbmUtQnVkZGU=?=" <mkl@pengutronix.de>, "=?utf-8?B?T2xpdmVyIEhhcnRrb3Bw?=" <socketcan@hartkopp.net>, "=?utf-8?B?VmluY2VudCBNYWlsaG9s?=" <mailhol@kernel.org>, "=?utf-8?B?T2xla3NpaiBSZW1wZWw=?=" <o.rempel@pengutronix.de>
Subject: Re: [PATCH net v2 3/3] can: rockchip_canfd: cancel bus-off restart before closing the device
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Wed, 14 Oct 2026 12:35:33 +0800
X-Priority: 3
Message-ID: <tencent_B9EC467C023611B7FC189AA06892648C1209@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20261014-rockchip-canfd-restart-close-v2-0-c8fbdfad1803@qq.com>
 <tencent_B15E13184DA04C4382F48848C006A2B51F06@qq.com>
	<sashiko-outbox-170754@kernel.org>
In-Reply-To: <sashiko-outbox-170754@kernel.org>
X-QQ-mid: xmsezb41-0t1791952533td804daax

SGksCgo+IFtTZXZlcml0eTogTWVkaXVtXQo+IElzIGl0IHNhZmUgdG8gY2FsbCBkaXNhYmxl
X2lycSgpIGhlcmUgb24gYSBzaGFyZWQgaW50ZXJydXB0IGxpbmU/Cj4gCj4gSW4gcmtjYW5m
ZF9vcGVuKCksIHRoZSBJUlEgaXMgZXhwbGljaXRseSByZWdpc3RlcmVkIGFzIHNoYXJlZDoK
PiAKPiAgICAgZXJyID0gcmVxdWVzdF9pcnEobmRldi0+aXJxLCBya2NhbmZkX2lycSwgSVJR
Rl9TSEFSRUQsIG5kZXYtPm5hbWUsIHByaXYpOwo+IAo+IE1hc2tpbmcgYSBzaGFyZWQgSVJR
IGxpbmUgZ2xvYmFsbHkgZGVsYXlzIG9yIGRyb3BzIGludGVycnVwdHMgZm9yIGFsbCBvdGhl
cgo+IGRldmljZXMgc2hhcmluZyB0aGF0IGxpbmUuCj4gCj4gQ291bGQgdGhpcyBkcml2ZXIg
aW5zdGVhZCB1c2UgYSBzb2Z0d2FyZSBmbGFnIHBhaXJlZCB3aXRoIHN5bmNocm9uaXplX2ly
cSgpCj4gb3Igc3BpbmxvY2tzIHRvIGV4Y2x1ZGUgdGhlIGhhbmRsZXIsIHJhdGhlciB0aGFu
IGRpc2FibGluZyB0aGUgcGh5c2ljYWwgbGluZT8KPiAKPiA+ICAgcmtjYW5mZF9jaGlwX3N0
YXJ0KHByaXYpOwo+ID4gICBya2NhbmZkX2NoaXBfaW50ZXJydXB0c19lbmFibGUocHJpdik7
Cj4gPiArIGVuYWJsZV9pcnEobmRldi0+aXJxKTsKPiA+ICAgbmV0aWZfd2FrZV9xdWV1ZShu
ZGV2KTsKPiA+ICAgYnJlYWs7CgpJIGFncmVlIHRoYXQgZGlzYWJsZV9pcnEoKSBhZmZlY3Rz
IGFsbCB1c2VycyBvZiB0aGUgc2hhcmVkIElSUSBhbmQKc2hvdWxkIGJlIGF2b2lkZWQgaGVy
ZS4KClRoZSBpbnRlbnQgd2FzIHRvIGV4Y2x1ZGUgdGhlIElSUSBoYW5kbGVyIHdoaWxlIHJl
aW5pdGlhbGl6aW5nIHRoZQpjb250cm9sbGVyLiBNYXNraW5nIHRoZSBjb250cm9sbGVyJ3Mg
b3duIGludGVycnVwdCBzb3VyY2VzIGFuZCBjYWxsaW5nCnN5bmNocm9uaXplX2lycSgpIGFs
b25lIHdvdWxkIG5vdCBiZSBzdWZmaWNpZW50OiBhbm90aGVyIGRldmljZSBvbiB0aGUKc2hh
cmVkIGxpbmUgY291bGQgc3RpbGwgaW52b2tlIHJrY2FuZmRfaXJxKCkgZHVyaW5nIHJlaW5p
dGlhbGl6YXRpb24uCgpJIHdpbGwgZml4IHRoaXMgaXNzdWUgaW4gdjMuCgpSZWdhcmRzLApD
dW5oYW8gTHUK

