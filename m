Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537D6309EEB
	for <linux-can@vger.kernel.org>; Thu, 15 Oct 2026 02:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792031280; cv=none; b=DNhmKSSaBAE/9xdVU7f/TNMHeX2MQwvN+Q+DHcMMhh1CzvRHejLN+mLKd1RnJ+PCWJEbgue1F67xPmn6thhcUf4ZmuOyw0XTAym3ski+AhazzzNC2yhM+BQWE7rsApzQr0DAo5jrOKuOyIpHfSJGiWCWIEFTpn4y2lK7wKB3m/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792031280; c=relaxed/simple;
	bh=GgOTyh0ivfRKnbdnhRU81a0JflLC850s3Kt03iYc0lY=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=dZblrZIm+fJNiOYE1GX4H3s9FCNbaujadS9XYIttH3PelSGOuBUyWVD3QGqGFJLBIWJ/eWUVlLeCv9gRAKY3T9LY1UD/0sLY6aqH6brKBL1V2UDiq5t6PlRvxfOa/SMhLg5hGh8NMVScuNDZdlhA0eJ4Csnza3/vrJV99bScxko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=GDwzYYkP; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="GDwzYYkP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792031270; bh=GgOTyh0ivfRKnbdnhRU81a0JflLC850s3Kt03iYc0lY=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=GDwzYYkPEfjVHbnvRWVZHO+MH/mEsjBTjtDtlmb0KhLd3U3hJMGF8V1p1mnKudvIA
	 Yceol8BrOTCgem6BB6oX4fZ/SDdbUiFXCYRacntZOob0J+wveZPA8tnoTp1mB9NpcC
	 C/jHD2F/ISEC39o5OknGISiQyiT+YKkVUpH66Ht0=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-XMAILINFO: OQac6g2KrvnWm5wX4uDdgn+yLX4+FKSgNrC+kuaqYTZj8bME5fIWT4A7FPKvoM
	 PSmIsSd3xO++RJObTUpDVYGzoGeSbb8ruKTxAUMpuxRgM6isR3ds1CeSLseT2+obpfp1V2QtXZTw1
	 8wffFVkReisREr+o8DjuqmxUGNaDiXv7GldpwmGnJibAiyL2gSGXGQa+JJcnfs2u6ewZWbOx04xxi
	 ChNDcaSBSySPbDKUES+P+7/J+YbkB5s1sFebZOSurBf2jXtIvE6yFvKQgA/a97H0RQKTcqMoXtEaz
	 GZdHsJBjJ8YcRERxHUBHxuUwOLCS7G0P1/dq7Cw6BKnk5k12ovLG/HIWV2+OtNd07Oij/4E/gByDD
	 UK36C56UdBe7gH1WdW5Ify/NzINhElGaZytO58rV6ZalBaGvMItzdrf0FTsFmIg54ks5FDRr5hO7e
	 j5xb+3GRrJs59NlP0LElXHDZPzOoWNkPwt8tYvMdKrSKfmuw8TGBsTG74e7WrZ80/JHvs0JLOlJBE
	 udpFL6/wfeRyDLXT74XDy512jokH/le8ZQpKeLubTgTKk7uQCuXHizFaCExpl/34cXihScGyfnOrH
	 qHeOFvcMNsm1nXsmzEgeg9xaDaQdLA3JrkXkKhutW8iGmzw701ZRhCaYPrE2iGAJt7lTmdVa5VkFG
	 UoUnOwZ9jIRn2oOf8rSddwBvS6wzktksuVgg2uOQm0cs5Ei4iSMmokcd0Zd1j7VBOYpygE143hT2m
	 mTqCeE3paKrEgEgfFXmADtBKDWW7E4qXPoMFeAJ9u7vFtpl0peSpYlrAQGGn6Y8VNquETOo00TTqg
	 nfwYjmLjAG/ZnMF0zSb0nd/Tm4K4p8OtPbAQWwnALMjoGK7bYi2BEYftqFNARaJRWE8qhRrB+1lhf
	 KivX7mx2In2LCmw57tI4hDPiPjvKULdL9D9Z2Nbsr79xMhUNuCsSc3eNjwGDivASD/mAhGmXxLtEU
	 5Z1iDPHbLFkeGXfbh6CzrMNA4OWetVPr7xsV1sIHB/q/9q1X7AeZ9lz4W6Yx59cu6Y5OJ/zEFZOkB
	 tARmp9trq53xSOZLco6V6UVRdlX9wSl6KJZbJ
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?c2FzaGlrby1yZXZpZXdz?=" <sashiko-reviews@lists.linux.dev>
Cc: "=?utf-8?B?bGludXgtY2Fu?=" <linux-can@vger.kernel.org>, "=?utf-8?B?TWFyYyBLbGVpbmUtQnVkZGU=?=" <mkl@pengutronix.de>, "=?utf-8?B?T2xpdmVyIEhhcnRrb3Bw?=" <socketcan@hartkopp.net>, "=?utf-8?B?VmluY2VudCBNYWlsaG9s?=" <mailhol@kernel.org>, "=?utf-8?B?T2xla3NpaiBSZW1wZWw=?=" <o.rempel@pengutronix.de>
Subject: Re: [PATCH net v3 4/5] can: rockchip_canfd: prevent timestamp work from rearming after bus-off
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Thu, 15 Oct 2026 10:27:48 +0800
X-Priority: 3
Message-ID: <tencent_2F44303F8C26511A3199B30497919F806407@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20261014-rockchip-canfd-restart-close-v3-0-f0eb41090242@qq.com>
 <20261014-rockchip-canfd-restart-close-v3-4-f0eb41090242@qq.com>
	<sashiko-outbox-171361@kernel.org>
In-Reply-To: <sashiko-outbox-171361@kernel.org>
X-QQ-mid: xmsezb41-0t1792031268tnc11h8de

SGksCgo+IFtTZXZlcml0eTogTWVkaXVtXQo+IERvZXMgdGhpcyBsZWF2ZSBhIGRhdGEgcmFj
ZSB3aXRoIGRhdGFwYXRoIHJlYWRlcnM/Cj4gCj4gVGhlIHdvcmtlciB0aHJlYWQgdXBkYXRl
cyB0aGUgdGltZWNvdW50ZXIgc3RhdGUgaGVyZSB3aGlsZSBob2xkaW5nCj4gdGltZXN0YW1w
X2xvY2suIEhvd2V2ZXIsIHRoZSBSWC9UWCBkYXRhcGF0aCBjYWxscwo+IHJrY2FuZmRfc2ti
X3NldF90aW1lc3RhbXAoKSB3aGljaCByZWFkcyB0aGUgdGltZWNvdW50ZXIgbG9ja2xlc3Ns
eToKPiAKPiBya2NhbmZkX3NrYl9zZXRfdGltZXN0YW1wKCkgewo+ICAgICAuLi4KPiAgICAg
bnMgPSB0aW1lY291bnRlcl9jeWMydGltZSgmcHJpdi0+dGMsIHRpbWVzdGFtcCk7Cj4gICAg
IC4uLgo+IH0KPiAKPiBTaW5jZSB0aW1lY291bnRlcl9yZWFkKCkgbW9kaWZpZXMgdGhlIHRp
bWVjb3VudGVyIHN0YXRlIG5vbi1hdG9taWNhbGx5LAo+IGNhbiB0aGUgY29uY3VycmVudCBs
b2NrbGVzcyByZWFkIHJlc3VsdCBpbiB0b3JuIHJlYWRzIG9yIGFuIGluY29uc2lzdGVudAo+
IG9ic2VydmF0aW9uIG9mIHRoZSBjeWNsZSBjb3VudGVyIGFuZCBuYW5vc2Vjb25kcywgZXNw
ZWNpYWxseSBvbiAzMi1iaXQKPiBwbGF0Zm9ybXM/CgpZZXMsIHRoZSByYWNlIHJlbWFpbnMu
IFRoZSBkcml2ZXIgc3VwcG9ydHMgNjQtYml0IHBsYXRmb3JtcywgYnV0IGF0b21pYwphY2Nl
c3NlcyB0byBpbmRpdmlkdWFsIGZpZWxkcyBkbyBub3QgZ3VhcmFudGVlIGEgY29uc2lzdGVu
dCBzbmFwc2hvdCBvZgp0aGUgdGltZWNvdW50ZXIgc3RhdGUuIEEgZGF0YXBhdGggcmVhZGVy
IGNhbiBvYnNlcnZlIHRoZSB1cGRhdGVkCmN5Y2xlX2xhc3QgdG9nZXRoZXIgd2l0aCB0aGUg
b2xkIG5zZWMgd2hpbGUgdGltZWNvdW50ZXJfcmVhZCgpIGlzIGluCnByb2dyZXNzLCByZXN1
bHRpbmcgaW4gYW4gaW5jb3JyZWN0IHRpbWVzdGFtcC4KClRoZSByYWNlIHByZWRhdGVzIHRo
aXMgcGF0Y2guIFRoZSB0aW1lc3RhbXBfbG9jayBhZGRlZCBoZXJlIHNlcmlhbGl6ZXMKdGhl
IHdvcmtlcidzIGFjdGl2ZSBjaGVjaywgY291bnRlciB1cGRhdGUgYW5kIHJlcXVldWUgd2l0
aCBkZWFjdGl2YXRpb24sCmJ1dCB0aGUgbG9ja2xlc3MgdGltZWNvdW50ZXJfY3ljMnRpbWUo
KSBjYWxsIGlzIHN0aWxsIHVucHJvdGVjdGVkLgoKSSB3aWxsIGFkZCBhIHNlcGFyYXRlIGZp
eCBpbiB2NC4KClRoYW5rcyBmb3IgcG9pbnRpbmcgdGhpcyBvdXQuCgpSZWdhcmRzLApDdW5o
YW8gTHUK

