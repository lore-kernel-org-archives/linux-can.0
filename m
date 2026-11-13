Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.205
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794546931;
	b=xolySGEhSTc+LOvmBP82kuBVAaheXydI0eUehqMKyS9KXSujSJHyCeyg4aJRzC4zMY+N
	 etaAkGV3w6UFX7Gvqe2d8fRqpMRpGZ5CV+9VGDd+SAS8L4uruNhsdM8/QwwuIDLpuSyUF
	 FOQo2Xq05/2fxHU45Jt9K8ILFsIYYqVWKuTd23pV2NXrbv6v0spQSdeANwbL5uDyiUSTw
	 svF3zP7yiBoVkJTtsI8xnpkVRS/rbyd6kNRzkBGx6Mx1uFi+pkVOnZUEFjFxMQa8N1IX0
	 ebk1ckOZrj3QIfYdcn6X0jzqsVx3AhboKtIo6JLkyA9x+xA9TOQR9URSfn1jShv14DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794546931;
	h=DMARC-Filter:DKIM-Signature:X-QQ-XMRINFO:X-QQ-XMAILINFO:From:To:Cc:
	 Subject:Mime-Version:Content-Type:Content-Transfer-Encoding:Date:
	 X-Priority:Message-ID:X-QQ-MIME:X-Mailer:X-QQ-Mailer:References:
	 In-Reply-To:X-QQ-mid;
	bh=S3xHepTTAVm9e0c+I4Yy1yIlpEnalfmaWL87RSx29sU=;
	b=sH10naMwyJScDpOnP+JyYmJs+7Ncj3NlcFNbrH8MREmbl154/S5/HRbrrr3jvyMDKmJc
	 Md3uXKCyglDEaf/W3nDH5Kl0ymU1xw3NJquWdAoRSf6mnt6zcHAZMGnhoxBk5xcmHF6i2
	 8+Gc+sUIzQ82ynB2YUBVwCyEqUINeMVBbFUxzYL2PtDAVA9fWp1Sp/ZTKDwqGuUVo2xpv
	 USKCUz+SdSskKy3uSzfMCmeQRoa/dF8nPcYdCWBAHCHzGJypmoZCaz88jHlX00eWl+KQ5
	 bXMbGu/qOhpfJ9kmFr5Lsc7/IOryqe7/MyeJ9snY+kZYPJ0ob+064DH2pIdiXDi2YOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=cw2pXXDf;
	arc=none smtp.remote-ip=203.205.221.205
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF186606A321;
	Fri, 13 Nov 2026 05:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF186606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=cw2pXXDf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794546927; bh=S3xHepTTAVm9e0c+I4Yy1yIlpEnalfmaWL87RSx29sU=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=cw2pXXDfPczqzqVVe33/PTlkp7nwEh2+sdrjXfoN7g0xXGYK5emLGT6XiwYwDLCFM
	 MSoW+UvB0yvYeGIfS7kqJPpJ6weINYDr6mEZC+TuxGpA040y4Gl14Mma3GwphW3N57
	 COp+QGP22fihX+SruyKFyhl2e2isrChHnwNoYAr0=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-XMAILINFO: OQac6g2KrvnW2iSWwmf6ohc8qhiL9C3TsNqbroi2fdR0HWZzFA1ovpBO7LEtZX
	 rsB/1LC5019MdcWDKoCznAOiL4XGKRih3rL1/iE5Q58GB4A9v2Jg4fgbWBnCMQwqDYvfdzPMrTKcC
	 5DAMkCWrIx/aDkJLX4sBT+r0FWckcT88xnMpoR4C/69Zr6e7p/mf3zWxGbSYQHOpD+TM7e31L/uYv
	 PksXX6RJYJOsuMOqZ06ykjngEsWzGk3oDxghGjtE8X2jVdRubINKXs5ONZSK64XQk5NfFpyypgPU5
	 kouGL2bGdXWArC2BhVo+z0C4y5JMtVeavBZhJ8gKNXQgArSGWA/+oXHNWy/n71jDT6mX7JuRtWMun
	 r9S3WrobTIE7NPGG08zB9LBkyAAJ7NkHtnSL404vmXarFa1LgVmxL/tdC12Y+xfL9hL3g0Z4xZcYU
	 c9cBqNpSQkm0TyypeieJ8zYlTA7OsZfuHWLyUlWiargVvqvzXxwsRc7x8i0PTbkRCOZQWmmpXpLH8
	 8nMl9W/v6uftxZCf0gMpQSYmJgClt/eEhWyou2ePCvjPYBK6Blw+i6seyQVvKfcyKoAKoyWclyDma
	 M3Ar2Ql55jPSBGg+9HvN/aLcgmX6pbilMnAosZIGo7zmBdwFYJwBEW30XdBly4sbXmIZCWMSN9Jjm
	 vu/+icjnDSKoz6p56zYeio10SmJHOzMrERw+sBg5AhWgoJm324II8qNaQ2DnncwLi5EfAFN89EIS9
	 DsC5O3HW9E2FpfcZjmYCgcTg1C9URXl92MFoM39HKnKLeWZymSG25CUl5F/RifMc10yyEZl5LPdPD
	 HXo7/lZEM6P1kVfmU7skxUEy/6Znq/cSmEai4DYL0+60b/Kxqa1HHDC1795g9XgZBhL1M6huXHlsg
	 CjTay+JkuCfB4J5ClevHRmWJILvZaoCa+75uW+NTRK+WKwBEKNUmWu2KcJC++vmM/cQWAIvRciwLL
	 DtlwqNZSa6gzlS+CMjj7CTAgr7z6aO/hJidESPpAHzhlR23Elods0f/LcOKtl2PegD4NSIzUR+lJf
	 5lwX+/NDXTLZtod7DlmzFMRu8sjxrCpFBHhNI
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?bmV0ZGV2LWJvdCtzYXNoaWtv?=" <netdev-bot+sashiko@kernel.org>
Cc: "=?utf-8?B?bWts?=" <mkl@pengutronix.de>, "=?utf-8?B?a2VybmVs?=" <kernel@pengutronix.de>, "=?utf-8?B?bWFpbGhvbA==?=" <mailhol@kernel.org>, "=?utf-8?B?aGVpa28=?=" <heiko@sntech.de>, "=?utf-8?B?c29ja2V0Y2Fu?=" <socketcan@hartkopp.net>, "=?utf-8?B?ZGF2ZW0=?=" <davem@davemloft.net>, "=?utf-8?B?ZWR1bWF6ZXQ=?=" <edumazet@kernel.org>, "=?utf-8?B?a3ViYQ==?=" <kuba@kernel.org>, "=?utf-8?B?cGFiZW5p?=" <pabeni@redhat.com>, "=?utf-8?B?aG9ybXM=?=" <horms@kernel.org>, "=?utf-8?B?Y29yYmV0?=" <corbet@lwn.net>, "=?utf-8?B?c2toYW4=?=" <skhan@linuxfoundation.org>, "=?utf-8?B?cmR1bmxhcA==?=" <rdunlap@infradead.org>, "=?utf-8?B?d2c=?=" <wg@grandegger.com>, "=?utf-8?B?bGludXgtY2Fu?=" <linux-can@vger.kernel.org>, "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, 
	"=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?bGludXgtZG9j?=" <linux-doc@vger.kernel.org>, "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>
Subject: Re: [PATCH net v9 08/10] can: rockchip_canfd: serialize TX with bus-off and restart
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Fri, 13 Nov 2026 13:15:24 +0800
X-Priority: 3
Message-ID: <tencent_AD03F810B3FDBC9A3A69DA65641264469409@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20261111-rockchip-canfd-restart-close-v9-8-6643f3825ba3@qq.com>
	<179452273462.488853.12444870521885218967@kernel.org>
In-Reply-To: <179452273462.488853.12444870521885218967@kernel.org>
X-QQ-mid: xmsezb41-0t1794546924twb3yiq29

SGksCgo+IFtTZXZlcml0eTogTWVkaXVtXQo+IElzIGlycV9zdXNwZW5kZWQgd29ya2luZyBh
cyBhIGxvY2sgaGVyZT8KClRoZSBmbGFnIGlzIGFuIElSUSBlbnRyeSBnYXRlIHVzZWQgd2l0
aCBkZXZpY2UgaW50ZXJydXB0IG1hc2tpbmcgYW5kCnN5bmNocm9uaXplX2lycSgpLiBEdXJp
bmcgcmVzdGFydCwgdGhlIGRyaXZlciBtYXNrcyBhbmQgZmx1c2hlcyBkZXZpY2UKaW50ZXJy
dXB0cywgc2V0cyB0aGUgZmxhZywgdGhlbiBkcmFpbnMgaGFuZGxlcnMgYmVmb3JlIHJlaW5p
dGlhbGl6YXRpb24uCkluIHRoaXMgdHJlZSwgdGhlIElSUSBkZXNjcmlwdG9yIGxvY2sgdXNl
ZCBieSBzeW5jaHJvbml6YXRpb24gYW5kCmRpc3BhdGNoIG9yZGVycyB0aGUgZmxhZyBzdG9y
ZSBhZ2FpbnN0IGxhdGVyIGhhbmRsZXIgZW50cnkuIFRoZQpyZWxlYXNlLWNsZWFyIHB1Ymxp
c2hlcyB0aGUgaW5pdGlhbGl6ZWQgc3RhdGUgdG8gdGhlIGhhbmRsZXIncwphY3F1aXJlLWxv
YWQuCgpPcGVuIHNldHMgdGhlIGdhdGUgYmVmb3JlIHJlcXVlc3RfaXJxKCksIHdoZW4gbm8g
cHJldmlvdXMgaGFuZGxlciBpcwpyZWdpc3RlcmVkLCBzbyB0aGVyZSBpcyBubyBvbGQgaGFu
ZGxlciB0byBkcmFpbiB0aGVyZS4gVFggYW5kIHRpbWVjb3VudGVyCnN0YXRlIGhhdmUgdGhl
aXIgb3duIGxvY2tzLiBUaGUgQkVDIGdldHRlciBpcyBvdXRzaWRlIHRoaXMgSVJRIHByb3Rv
Y29sOwppdHMgY2FjaGUgc3luY2hyb25pemF0aW9uIGlzc3VlIHByZWRhdGVzIHRoZSBwYXRj
aC4gSSBoYXZlIG5vdCBmb3VuZCBhCmNvbmNyZXRlIG5ldyByYWNlIGluIHRoaXMgc2VxdWVu
Y2UgdGhhdCB3YXJyYW50cyByZXBsYWNpbmcgdGhlIGdhdGUgd2l0aAphbm90aGVyIGxvY2su
Cgo+IFtTZXZlcml0eTogTG93XQo+IElzIHRoZSBDQU4gY29yZSBrbm93biB0byBiZSBvdXQg
b2YgcmVzZXQgd2hlbiB0aGlzIElOVF9NQVNLIHdyaXRlCj4gYXJyaXZlcz8KPiAuLi4KPiBT
aG91bGQgdGhlcmUgYmUgYSBzaG9ydCBzZXR0bGUgZGVsYXkgYWZ0ZXIgZGVhc3NlcnRpb24s
IG9yIGEgY2hlY2sgb2YgdGhlCj4gcmVhZC1iYWNrIHZhbHVlPwoKT24gUkszNTg4IHJldjIu
MiwgSSB0ZXN0ZWQgMzAwIHJlc2V0IHNhbXBsZXMgcGVyIGNvbnRyb2xsZXIsIDYwMCBpbiB0
b3RhbCwKY292ZXJpbmcgb3BlbiwgY2xvc2UgYW5kIGRpcmVjdCByZXN0YXJ0IGNhbGxiYWNr
cyB3aGlsZSBpZGxlLiBUaGUgdGVzdHMKcHJlc2VydmVkIHRoZSBwcm9kdWN0aW9uIG9yZGVy
OiBkZWFzc2VydCwgd3JpdGUgMHg3ZmZmLCB0aGVuIGZpcnN0CnJlYWRiYWNrLCB3aXRoIG5v
IGV4dHJhIE1NSU8sIGxvZ2dpbmcgb3IgZGVsYXkgYmVmb3JlIHRoYXQgd3JpdGUuIEV2ZXJ5
CmZpcnN0IHJlYWRiYWNrIHdhcyAweDNmZmY7IGJpdCAxNCBjb25zaXN0ZW50bHkgcmVhZCBh
cyB6ZXJvIGFuZCB3YXMgbm90Cm1pc3Rha2VuIGZvciBhIGxvc3Qgd3JpdGUuCgpUaGVzZSB0
ZXN0cyBmb3VuZCBubyBsb3N0IGZpcnN0IG1hc2sgd3JpdGUgb3IgZXZpZGVuY2UgdGhhdCB0
aGlzIGNoYW5nZQppbnRyb2R1Y2VzIG9yIHdvcnNlbnMgdGhlIHN1c3BlY3RlZCBwcm9ibGVt
LgoKQmVzdCByZWdhcmRzLApDdW5oYW8gTHUK

