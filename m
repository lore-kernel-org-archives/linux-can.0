Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903F83D6CD3
	for <linux-can@vger.kernel.org>; Thu, 30 Jul 2026 08:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785401153; cv=none; b=nvnlWr13il+8qHL9LV1Jv9eBOq5L6lhazOz4yvkTb2Cx9ppn4IJNu9sRAhbNcV+QemjIB/jdZUYDRSwdWb5/o2kHDjMqCQC87rhzTPJ9bFxyWFvK6Sk0v3Hie3fF2LHbRaqCg7NsOzTg9WcCl88aT4kW9l/vspyraChXMDSnmfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785401153; c=relaxed/simple;
	bh=O51rQS5p2urgyaYAMA/UAKGxud1F/++H+9dAXOeqbRs=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=MyQdt14PjnBazKUuDxyKAishLHF9QzhYqAVWmKh9YIt4lvbrf0YB4MKV6+qWgL5/Gi/3SmaJf1dxUE2vCC2urmVNABjwQjrwdDeuy6G1m/jekbE1LeNAb7zcX5a7i84d0alMB+xtMuqj8y1dbobBiwECQm1PINbTIhwfCf21j44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=a9YECFVP; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="a9YECFVP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1785401140; bh=O51rQS5p2urgyaYAMA/UAKGxud1F/++H+9dAXOeqbRs=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=a9YECFVPLrHnBoSYQQgYr4FRPrOIZlHOKN+xMxHFTYiTmfnhTAL5oZCyf6/U+gL+0
	 IUaLSxTqUMy9pJsWEd6w+EKcwr0nzmbxGquIAz89aqm/oG7M0BOtB5LTz6MPNH/3Mv
	 9o9jCFPZBM2/Pbwb5VEu1G/VJMNlSpeBzOB27ZaQ=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-XMAILINFO: OM3nRSNxLK50soCgZhBegPOGUOMeJ2rPx3rGlk29g8vGPqzEyJVeLwhTpO8B0y
	 hT5P+IgxViFt6s+Ou8qMW/BnW9ThINn40P3bCftxc9wQMDYkmTdlAGayc4KKH6kCBeIXX/ukZusGM
	 FZuRoH2/jv3JqGszaiXwWAWIX3cy8ltsshJEf6cOcnJb3uvF7e8p/I0yLPWEGSI0SZTMRyzT1zdcl
	 kT69P4UYYbP0zfaXdZDzLxUQc8sosyRZQOhBV+FyTyc+MpR4Fr138I157WpsYxJLMggVu+9U9eupA
	 yYiQcL1QIj52DKy/qwDkgLqEEEXHV4Kbca7JfLHRlaRpFXPwTabWZmobu8+FvJHIqrSvLCC0SGrGn
	 Gl2lmS0eTMzcChr7nJf7DSecefn7gkdwVoBtbtxqbe2OU7OJrFSbl3e9tMFEdIqFOignYqP+NtUIz
	 FcHpt6qfccecA6OpJ1WEtz8dAgNLoH5EQ9u3egNgVpwxnr0EyoIh/4AK6PvBebxlQj5q9uqgikV+j
	 QkTtzxvjTDPW2YRyPsKIpBVNN4lc0PAmo1DSS87nJn4YdwZyf10qQ0YmGzkmivADk573YVd8LHkYJ
	 KLx5ic/Zi4x1xcMNhGosP891SZ5DGXQaCTmq7VBZpCIRyoTS4TYIvLWSZEWEdxh7Gv+cxbjE5EhlN
	 wP95dplG3D9rB+aGUAvIf/2kPn7WLGSwD5PYCaK4aTahT509Pf68O+hZN1toOgCr8e266BrgD+thU
	 12bbjaamxjumlrs48WujwCPIklFBifU1jeSGgXVPyTTJdGx7VJgwbqZPj0P1zLzoWlOf6FCHLVHwM
	 hjdVEDWNsrGNeste+rcU2QmwhnKBcgNYiEl/qBCrCIljfNS5uuiycxMt4GyHno9R9lKjCTjMPxQIU
	 jnPD5vuXR6JKqoH+aASGWzNA+gWwQ4vGY898yPX6XqPZacHLMdxhNUu8UzBcyNVwrZMHxVxE/+ZK1
	 uVWygSGZcdts40NnehldPfpcV1+CIS97usRNGbE+cob8YXoTL3ex8EE4DKeXgmy6JLdO5VoI+BRSc
	 S9CSnXj7YrXH+RAu+V1DN7bkekA==
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?c2FzaGlrby1yZXZpZXdz?=" <sashiko-reviews@lists.linux.dev>
Cc: "=?utf-8?B?TWFyYyBLbGVpbmUtQnVkZGU=?=" <mkl@pengutronix.de>, "=?utf-8?B?VmluY2VudCBNYWlsaG9s?=" <mailhol@kernel.org>, "=?utf-8?B?T2xla3NpaiBSZW1wZWw=?=" <o.rempel@pengutronix.de>, "=?utf-8?B?T2xpdmVyIEhhcnRrb3Bw?=" <socketcan@hartkopp.net>, "=?utf-8?B?bGludXgtY2Fu?=" <linux-can@vger.kernel.org>
Subject: Re: [PATCH 2/3] can: rockchip_canfd: retry the outstanding TX buffer
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Thu, 30 Jul 2026 16:45:38 +0800
X-Priority: 3
Message-ID: <tencent_26432634E160C43C600A71D46FA64982E605@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20260730-master-v1-0-6945fdd4f0ff@qq.com>
 <tencent_803FA8A6621A5D198504BC91BE003D442007@qq.com>
	<20260730062632.6DF4E1F000E9@smtp.kernel.org>
In-Reply-To: <20260730062632.6DF4E1F000E9@smtp.kernel.org>
X-QQ-mid: xmsezb41-0t1785401138tvzydsrzc

SGksCgpUaGFuayB5b3UgZm9yIHBvaW50aW5nIHRoaXMgb3V0LgoKPiA+wqBkaWZmwqAtLWdp
dMKgYS9kcml2ZXJzL25ldC9jYW4vcm9ja2NoaXAvcm9ja2NoaXBfY2FuZmQtdHguY8KgYi9k
cml2ZXJzL25ldC9jYW4vcm9ja2NoaXAvcm9ja2NoaXBfY2FuZmQtdHguYwo+ID7CoGluZGV4
wqBkMmNiZTI1YzQ2ZDZjLi5jNGVjZGM5NDExY2M2wqAxMDA2NDQKPiA+wqAtLS3CoGEvZHJp
dmVycy9uZXQvY2FuL3JvY2tjaGlwL3JvY2tjaGlwX2NhbmZkLXR4LmMKPiA+wqArKyvCoGIv
ZHJpdmVycy9uZXQvY2FuL3JvY2tjaGlwL3JvY2tjaGlwX2NhbmZkLXR4LmMKPiA+wqBAQMKg
LTU3LDjCoCs1Nyw4wqBAQMKgc3RhdGljwqB2b2lkwqBya2NhbmZkX3N0YXJ0X3htaXRfd3Jp
dGVfY21kKGNvbnN0wqBzdHJ1Y3TCoHJrY2FuZmRfcHJpdsKgKnByaXYsCj4gPsKgwqAKPiA+
wqDCoHZvaWTCoHJrY2FuZmRfeG1pdF9yZXRyeShzdHJ1Y3TCoHJrY2FuZmRfcHJpdsKgKnBy
aXYpCj4gPsKgwqB7Cj4gPsKgLSBjb25zdMKgdW5zaWduZWTCoGludMKgdHhfaGVhZMKgPcKg
cmtjYW5mZF9nZXRfdHhfaGVhZChwcml2KTsKPiA+wqAtIGNvbnN0wqB1MzLCoHJlZ19jbWTC
oD3CoFJLQ0FORkRfUkVHX0NNRF9UWF9SRVEodHhfaGVhZCk7Cj4gPsKgKyBjb25zdMKgdW5z
aWduZWTCoGludMKgdHhfdGFpbMKgPcKgcmtjYW5mZF9nZXRfdHhfdGFpbChwcml2KTsKPiA+
wqArIGNvbnN0wqB1MzLCoHJlZ19jbWTCoD3CoFJLQ0FORkRfUkVHX0NNRF9UWF9SRVEodHhf
dGFpbCk7Cj4gPsKgwqAKPiA+wqDCoCBya2NhbmZkX3N0YXJ0X3htaXRfd3JpdGVfY21kKHBy
aXYswqByZWdfY21kKTsKPiAKPiBbU2V2ZXJpdHk6wqBIaWdoXQo+IFRoaXPCoGlzbid0wqBh
wqBidWfCoGludHJvZHVjZWTCoGJ5wqB0aGlzwqBwYXRjaCzCoGJ1dMKgZG9lc8KgdGhpc8Kg
Y2FsbMKgZXhwb3NlwqBhwqByYWNlCj4gY29uZGl0aW9uwqBvbsKgdGhlwqBoYXJkd2FyZcKg
cmVnaXN0ZXJzwqBiZXR3ZWVuwqBzb2Z0aXJxwqBhbmTCoGhhcmRpcnHCoGNvbnRleHRzPwo+
IAo+IHJrY2FuZmRfc3RhcnRfeG1pdCgpwqBydW5zwqBpbsKgc29mdGlyccKgY29udGV4dMKg
YW5kwqBjYWxscwo+IHJrY2FuZmRfc3RhcnRfeG1pdF93cml0ZV9jbWQoKSzCoHdoaWNowqBw
ZXJmb3Jtc8Kgbm9uLWF0b21pY8KgcmVnaXN0ZXLCoHdyaXRlcwo+IHRvwqBSS0NBTkZEX1JF
R19NT0RFLsKgSWbCoGHCoGhhcmR3YXJlwqBSWMKgaW50ZXJydXB0wqBwcmVlbXB0c8KgZXhl
Y3V0aW9uwqBiZXR3ZWVuCj4gdGhlc2XCoHdyaXRlcyzCoHJrY2FuZmRfaXJxKCnCoChoYXJk
aXJxKcKgd2lsbMKgY2FsbMKgcmtjYW5mZF94bWl0X3JldHJ5KCkKPiB3aGljaMKgYWxzb8Kg
Y2FsbHPCoHJrY2FuZmRfc3RhcnRfeG1pdF93cml0ZV9jbWQoKS4KPiAKPiBUaGXCoGhhcmRp
cnHCoHdpbGzCoHJlc3RvcmXCoHByaXYtPnJlZ19tb2RlX2RlZmF1bHQswqBzb8Kgd2hlbsKg
dGhlwqBzb2Z0aXJxCj4gcmVzdW1lcyzCoFJLQ0FORkRfUkVHX0NNRMKgaXPCoHdyaXR0ZW7C
oHdpdGhvdXTCoHRoZcKgcmVxdWlyZWTCoFNQQUNFX1JYX01PREUKPiBiaXTCoHNldCzCoGJ5
cGFzc2luZ8KgdGhlwqBSSzM1NjjCoEVycmF0dW3CoDEywqB3b3JrYXJvdW5kLsKgQ291bGTC
oHRoaXPCoGxlYWTCoHRvCj4gaGFyZHdhcmXCoG1pc2JlaGF2aW9ywqB1bmRlcsKgaGVhdnnC
oGxvYWQ/CgpZZXMsIHRoZSBNT0RFL0NNRCBzZXF1ZW5jZSBoYXMgYSBwcmUtZXhpc3Rpbmcg
c2VyaWFsaXphdGlvbiBwcm9ibGVtLiBPbiBhCmRldmljZSBhZmZlY3RlZCBieSBib3RoIGVy
cmF0dW0gNiBhbmQgZXJyYXR1bSAxMiwgYHJrY2FuZmRfc3RhcnRfeG1pdCgpYCBjYW4KYmUg
aW50ZXJydXB0ZWQgYWZ0ZXIgZW5hYmxpbmcgYFNQQUNFX1JYX01PREVgLiBUaGUgcmV0cnkg
cGF0aCBjYW4gdGhlbiB3cml0ZQppdHMgb3duIE1PREUvQ01EL01PREUgc2VxdWVuY2UgYW5k
IHJlc3RvcmUgdGhlIGRlZmF1bHQgbW9kZSBiZWZvcmUgdGhlCm9yaWdpbmFsIHBhdGggd3Jp
dGVzIENNRC4gVGhhdCBDTUQgd291bGQgY29uc2VxdWVudGx5IGJlIGlzc3VlZCB3aXRob3V0
CmBTUEFDRV9SWF9NT0RFYCBlbmFibGVkLgoKV2l0aCB0aGUgY3VycmVudCBxdWlyayB0YWJs
ZSB0aGlzIGNvbWJpbmF0aW9uIGFwcGxpZXMgdG8gUkszNTY4djIuIFJLMzU4OCBpcwphZmZl
Y3RlZCBieSBlcnJhdHVtIDYgYnV0IG5vdCBlcnJhdHVtIDEyLCBzbyB0aGlzIHNwZWNpZmlj
IGhhcmR3YXJlIGZhaWx1cmUKY2Fubm90IGJlIHJlcHJvZHVjZWQgb24gbXkgUkszNTg4IHRl
c3QgYm9hcmQuCgpQQVRDSCAzLzMgYWxyZWFkeSBwcmV2ZW50cyB0aGUgaW50ZXJsZWF2aW5n
OiBib3RoCmBya2NhbmZkX3N0YXJ0X3htaXQoKWAgYW5kIHRoZSBJUlEgcmV0cnkgcGF0aCBj
YWxsCmBya2NhbmZkX3N0YXJ0X3htaXRfd3JpdGVfY21kKClgIHdoaWxlIGhvbGRpbmcgdGhl
IHNhbWUgYHR4X2xvY2tgIHdpdGggSVJRcwpzYXZlZC4gSSB3aWxsIHVwZGF0ZSBQQVRDSCAz
LzMgaW4gdjIgdG8gZXhwbGljaXRseSBkb2N1bWVudCB0aGF0IHRoZSBsb2NrIGFsc28KcHJv
dGVjdHMgdGhlIE1PREUvQ01EIHRyYW5zYWN0aW9uLCBhZGQgYSBsb2NrZGVwIGFzc2VydGlv
biB0bwpgcmtjYW5mZF9zdGFydF94bWl0X3dyaXRlX2NtZCgpYCwgYW5kIGluY2x1ZGUgdGhl
IGVycmF0dW0gMTIgY29tbWl0IGluIHRoZQpmaXggZGVzY3JpcHRpb24uCgpSZWdhcmRzLApD
dW5oYW8K

