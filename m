Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EF747ECE6;
	Thu,  2 Jul 2026 12:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996411; cv=none; b=h/FlKdh0+jShIAnK+ZQjrfQU2H8kf02v7/hmddcf2SYxIyhhL4iuSRrZX0e/NsSsQDS+jW4wFoWDlQaZ66801IwWeOUpCTeNbAQmB+or0t7jJPnQBQr89woWVkTqgza2m4z7XaoeiiIyi0NTypXgdmYzEUDvdviuylfct1oy1ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996411; c=relaxed/simple;
	bh=cZ82wpzG4dEDpgB0onYrYhbBV1XpTLYDCKUM8jFjHJ8=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID; b=b/Lh3JRpg9zQ64dx/iQAbOxq828oBBBEZyICOEWbWjFTOLGXFjFhE1w8Jds81L7QCHpa3e9A29X62iBEv0gT0mbgJ/tB2MkzU/CztDmbr3dbgvRQZd2G0q+cVxoIadf5yLeAwECB5bsyM+pEAdyoFTSDQaIwQol9QKFzXQD6wIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=azV2hz4t; arc=none smtp.client-ip=203.205.221.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="azV2hz4t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1782996401; bh=cZ82wpzG4dEDpgB0onYrYhbBV1XpTLYDCKUM8jFjHJ8=;
	h=From:To:Cc:Subject:Date;
	b=azV2hz4tgzVRPzqUT1cmejO8zhXMUF+PRp5a0TeWOS3nj3nJsAknPEBmkV5OcSaza
	 tYWDF9PoWx2dX14KRA/UHEOCKBwVCZ5bWPc52ThbhhOaXk8Rm5agePaGLplcsDS7Em
	 7kAYtamYNHRiwhXD7rahRxO1sCW4NaNaqmnXH1iE=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-XMAILINFO: McF9JvsryK5JD7mWECZX57rL5Rprn8Mk7XTA5UJtsp7kYfow6fxNMQoWuwoNn4
	 tVNny0O4V2vpwvGzR8je738IRA73nQ9hA5I5rcMIdTzKVx9EGI1zSQxUlfeg6uNX6coG0Lu0rFrZM
	 Gc2hC1WBmGJS+vZOXQnEEGnrm3PJhaq8gTjLC79BGpyYMM6oSPKeefpCufewFwvgu816KhSivasKC
	 68Zm4+ENlNp2iAdgXSsvyjHmLAhVgSS5v5+CYo38hQpEHAmCY2sDnrhqddBJdT7NNRIGbixFpLUjD
	 7NjyU0kZnFNrO+mnW28uCsZf5ezJwS7kFne5/aQb7ulFhvU9VtxmokbMXBZtQmtMjKf/CtnlPUcRc
	 QMa8jw7A4oA0xECBhNx5+oZqpPVFqOX7uBs1MkcJqDhCl+1pA8y129xhO6bP4x+iCk+kkoh1P70/Y
	 xflsNu4w6e6HRkDFDjzwxHKVdlW7H9IoqWwEslXZxxqYOOnqe3SyMTwZNW3w0CVtKtToykPYHT0Yn
	 kLqkw4s2narZarifHngjrPdFqkge1/1F5HLpjdTxMC2oE3M49xXGn/5M4203ckggz17/d+QEl7IGX
	 mO1VZSp2i1skxVN+4QK+AgcRnH+1jGkdpv8yh4aBSkxfrcn2MMaYhahjahYtxpyrmR8ZovLKRFd3q
	 Gw+/UVFPGGE0JAqe1dLgGYJRRDaCe14wQdiBGlCfzqsqN18MDsA3EU33ecHvh6ggTce5K1E5sLzNB
	 lcvu2q5VJ08cW4lhqGpEchzKAobjVkEltnK4ZZozgEzKxT3UaHIpH2OBBXolwM6/U/m/lp4VJJq8y
	 2tzifYVJXW9X/BPK6fNpVd7iiMmbIrOYzhtAmTETMByvXutnrPpEJ02/pu3/sUS6wB0iW0B/MbO1c
	 OKm6WYyr4dBRmA7AMjJtV/fifAnIdaE8R9gqLQPfD/nqsI2TxO2XU1iRkEeiMQ9JwlJB2QEIgdVWh
	 ix/6ITZu4TUSDeQcfFBcwXRnTzupl1aSIoKu0GS6FBL8kFlI3DzzZBijXcnkyg4in4sDL6FxBxPT5
	 ddNgfrREJIzrdxV1gFatoJa7EzOOHwf6iAM/phNxLQMe3rNzg+YD+R9SdvA==
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?TWFyYyBLbGVpbmUtQnVkZGU=?=" <mkl@pengutronix.de>
Cc: "=?utf-8?B?aGVpa28=?=" <heiko@sntech.de>, "=?utf-8?B?bGludXgtY2Fu?=" <linux-can@vger.kernel.org>, "=?utf-8?B?bWFpbGhvbA==?=" <mailhol@kernel.org>, "=?utf-8?B?a2VybmVs?=" <kernel@pengutronix.de>, "=?utf-8?B?cm9iaA==?=" <robh@kernel.org>, "=?utf-8?B?a3J6aytkdA==?=" <krzk+dt@kernel.org>, "=?utf-8?B?Y29ub3IrZHQ=?=" <conor+dt@kernel.org>, "=?utf-8?B?ZGV2aWNldHJlZQ==?=" <devicetree@vger.kernel.org>, "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, "=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] can: rockchip: add RK3588 CAN-FD support
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Thu, 2 Jul 2026 20:45:27 +0800
X-Priority: 3
Message-ID: <tencent_2AA2119D8067447DBFA826619A5419878407@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-mid: xmsezb41-0t1782996327t5ajzis1k

SGkgTWFyYywKCnRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLgoKPiBUaGVuIENBTi1GRCBpcyBi
cm9rZW4uIDovCj4KPiBNYXliZSBpbiBhIGxhdGVyIHBhdGNoIHdlIGNhbiBoYWNrIHNvbWV0
aGluZywgdG8gYWxsb3cgd29ya2luZwo+IGNvbmZpZ3VyYXRpb25zLgoKVW5kZXJzdG9vZC4g
SSB3aWxsIGtlZXAgQ0FOLUZEIGRpc2FibGVkIGZvciBSSzM1ODggaW4gdjIuCgpJIHdpbGwg
YWxzbyB0cnkgdG8gaW52ZXN0aWdhdGUgd2hldGhlciB0aGUgZmFpbGluZyBCUlMvZGF0YS1w
aGFzZSBzZXR1cApjYW4gYmUgZml4ZWQuIElmIEkgY2FuIGZpbmQgYSBwcm9wZXIgZml4LCBJ
IHdpbGwgc2VuZCBpdCBhcyBhIGZvbGxvdy11cApwYXRjaCBpbnN0ZWFkIG9mIG1peGluZyBp
dCBpbnRvIHRoaXMgdjIgc2VyaWVzLgoKPiBDYW4geW91IHVwZGF0ZSB0aGUgZGVzY3JpcHRp
b24gb2YgdGhlIHF1aXJrIGZvciB0aGUgcmszNTg4IGFuZCBhZGQgaG93Cj4gdG8gcmVwcm9k
dWNlIGl0PwoKWWVzLiBJIHdpbGwgdXBkYXRlIHRoZSBSSzM1ODggcXVpcmsgZGVzY3JpcHRp
b24gYW5kIGFkZCB0aGUgcmVwcm9kdWNlCnN0ZXBzIGZvciB0aGUgQlJTL2RhdGEgYml0cmF0
ZSBpc3N1ZS4KCj4gUGxlYXNlIGtlZXAgaXQgZGlzYWJsZWQgZm9yIG5vdy4KCkkgd2lsbCBr
ZWVwIFJLQ0FORkRfUVVJUktfQ0FORkRfQlJPS0VOIGVuYWJsZWQgZm9yIFJLMzU4OCBpbiB2
Miwgc28KQ0FOLUZEIHN0YXlzIGRpc2FibGVkIGZvciBub3cuCgpUaGFua3MsCkN1bmhhbyBM
dQ==

