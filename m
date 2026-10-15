Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABE148EC64
	for <linux-can@vger.kernel.org>; Thu, 15 Oct 2026 10:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792059771; cv=none; b=X3B4CNOYcFUJ1e0YXGWI4qIrGcfq5YzFKKp+Do6zMqQNR1kUbb9mZ8LLNHuW2fBJ2lUGHIy4aHYQ4FeZwbMCIU7lXMlFoLPaBxkWhJz8oQQLww9iqBzddpivgnjbn4z5k+16G61QUNhHVUQX3oEZoPZfaXn5bI3uCl6pQUQOAWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792059771; c=relaxed/simple;
	bh=v6Bmyc2w4oEkpViq6TYp8Wb9l9jdYl5yZANEkIwmEww=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=ZN+UZOvc77ZAoWXdqkYWDryY8fzmQ7vQ8bd4BdKLkWPYocZ5TUO6fabPisnhLte3q56ik9ftoa6as47X+0aUJ4s9IYpr6nbq72N+pvWqXZBywaH6lx42Zo+W7s2y5x84Lt2UWrA7IUzveJu1FDpH9jhEKandS8Pv6xuZHRUDY9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ftGJeu7e; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ftGJeu7e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792059765; bh=v6Bmyc2w4oEkpViq6TYp8Wb9l9jdYl5yZANEkIwmEww=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=ftGJeu7epKY3R/eBY31uIFc2XqwVSrnXnXCBqPFNcYD1zkisk1RXVG8lzJ50FgUSI
	 k4wh/AFOFKX4jqZ1upIWIx55/GZFFsqm4TQpgtqARFex4Dtx8XLgvpma7ngkDVCDI0
	 q8m+83ddKzayv7GnzuP0NAOkzrSM5b7tAEhL7FDA=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-XMAILINFO: Npv5yIQT4nxM2SC67F1GaBpuvb6NtOsDpE96lzwuFOSGkzBZH+wEn96PFBChaY
	 2qoS0aO7jOIcQW4n/Y3w+c3qOeJT/DdFhJXJQvGyYeoMn8cN9q7vClr8c+txHAC7GDkHo7zAhFeJ1
	 4iD4nSyYbhB0g6I0Fj3g9PDcN876Fb93MH8tmONb0mD+Vr36lRdNizJ2dfx+FGEzsCKTFucS1jXLi
	 QVdc/tW2M2/qzqk+Jy0fWqQ9HmSIZHP71ecntYp6n1Dc63NX4//6u1xDzg1+TXtySLOJd06y3ejEo
	 niNs9o+Zc5OB6ysFZb0Q5df9yVaTNPXItLKFKsTf3EjassAaeEI0823eSWXsHUBflhc1sJNX9ZrJC
	 nReaymulv3j/hNKCc4a+zTQG5xZPVQAfDgKD44/nKSwOOg8ILFsWeMS/WZpUrcovww4FmR9cNxUY0
	 6oaYBmprNrgipjvakdJG8RiDw8Hrc53VIa5LlSR1et6sjjaKgYvUJQpcpKorWMtx4v6H77W39GPB3
	 RrWdkzRKw92n8oERRrq+JUsJsBGcaztaPzt/0WOTTu+3vAPATykiXunCzsCldnoW/TzaySdEWmRJL
	 uL+Z4X8+GNQg9RD7OXWI2bGVbFwn96/QPSkG7eBEat8INpkhuzAZIGAopKG1hY0TqMrpZREEtAWzw
	 XmEr1VOZpCfknCklx6DrVnqJwW+yA56Bm4iyddQyX2ePcDlkEdv609mRmEO06yBw5p5WcO3riCBXS
	 5plt8+tg1b5TC4G0o8QZoJ/T3sCiMpB3YT761mfL14qtljRB2+PDoTq38m1p0CNZHimQaZ1Fa5gps
	 gF4oKibE5KR1X7/z1Cy94yneuu0YH5vpOfvSScEMT6lxrw3prPEmD31JAMUFRyb3mk8YvTum/SdKa
	 HxvY/3hk5pux0woPVlZmoidZ1lKLC1RSM2WsmlaBKBUwLzVRzslrRJH0J4H9BHEXaS25zT6hwR0EF
	 u+8VufJjG4PhJqI3Qp8goXFakXAQWMwdfCpOaTe/Imf74tYmhQleDeb+/eaIAu12HlI72U6CmWtIg
	 b2p4rJaFwyhOkzbLqM5sR5qB0TEebCGzfc7pH5hiGb3bQ1A7cKsJI82m/Lsk+ajBudMcC
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?c2FzaGlrby1yZXZpZXdz?=" <sashiko-reviews@lists.linux.dev>
Cc: "=?utf-8?B?bGludXgtY2Fu?=" <linux-can@vger.kernel.org>, "=?utf-8?B?TWFyYyBLbGVpbmUtQnVkZGU=?=" <mkl@pengutronix.de>, "=?utf-8?B?T2xpdmVyIEhhcnRrb3Bw?=" <socketcan@hartkopp.net>, "=?utf-8?B?VmluY2VudCBNYWlsaG9s?=" <mailhol@kernel.org>, "=?utf-8?B?T2xla3NpaiBSZW1wZWw=?=" <o.rempel@pengutronix.de>
Subject: Re: [PATCH net v5 1/6] can: dev: prevent bus-off recovery when the interface is not running
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Thu, 15 Oct 2026 18:22:43 +0800
X-Priority: 3
Message-ID: <tencent_53323410327509672380017F88437E714D08@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20261015-rockchip-canfd-restart-close-v5-0-ae77327037c9@qq.com>
 <20261015-rockchip-canfd-restart-close-v5-1-ae77327037c9@qq.com>
	<sashiko-outbox-172612@kernel.org>
In-Reply-To: <sashiko-outbox-172612@kernel.org>
X-QQ-mid: xmsezb41-0t1792059763t2llizoi6

SGksCgo+IFtTZXZlcml0eTrCoEhpZ2hdCj4gQ2FuwqB0aGlzwqBsb2NrbGVzc8KgY2hlY2vC
oGNyZWF0ZcKgYcKgdGltZS1vZi1jaGVja8KgdG/CoHRpbWUtb2YtdXNlwqAoVE9DVE9VKQo+
IHJhY2XCoHRoYXTCoHJlc3VsdHPCoGluwqBhY2Nlc3NpbmfCoGhhcmR3YXJlwqB3aXRowqBk
aXNhYmxlZMKgY2xvY2tzPwo+IAo+IElmwqBhwqBidXMtb2ZmwqBldmVudMKgc2NoZWR1bGVz
wqB0aGXCoGRlbGF5ZWTCoHJlc3RhcnTCoHdvcmsswqBjYW5fcmVzdGFydCgpCj4gY291bGTC
oGNoZWNrwqBuZXRpZl9ydW5uaW5nKCnCoGFuZMKgZXZhbHVhdGXCoHRvwqB0cnVlLsKgSWbC
oHRoZcKgd29ya3F1ZXVlwqB0aHJlYWQKPiBpc8KgcHJlZW1wdGVkwqBpbW1lZGlhdGVsecKg
YWZ0ZXLCoHRoaXPCoGNoZWNrLMKgYW5kwqBjb25jdXJyZW50bHnCoHRoZcKgaW50ZXJmYWNl
Cj4gaXPCoGJyb3VnaHTCoGRvd246Cj4gCj4gZGV2X2Nsb3NlKCnCoGNsZWFyc8KgX19MSU5L
X1NUQVRFX1NUQVJUwqBhbmTCoGNhbGxzwqBuZG9fc3RvcCgpLgo+IEluwqBkcml2ZXJzwqBs
aWtlwqBhdDkxX2NhbsKgYW5kwqByY2FyX2NhbizCoG5kb19zdG9wKCnCoGRpc2FibGVzwqBo
YXJkd2FyZQo+IGNsb2Nrc8KgYmVmb3JlwqBjYWxsaW5nwqBjbG9zZV9jYW5kZXYoKcKgdG/C
oGNhbmNlbMKgdGhlwqByZXN0YXJ0wqB3b3JrOgo+IAo+IGRyaXZlcnMvbmV0L2Nhbi9hdDkx
X2Nhbi5jOmF0OTFfY2xvc2UoKcKgewo+IMKgwqDCoMKgLi4uCj4gwqDCoMKgwqBjbGtfZGlz
YWJsZV91bnByZXBhcmUocHJpdi0+Y2xrKTsKPiDCoMKgwqDCoHBoeV9wb3dlcl9vZmYocHJp
di0+dHJhbnNjZWl2ZXIpOwo+IAo+IMKgwqDCoMKgY2xvc2VfY2FuZGV2KGRldik7Cj4gwqDC
oMKgwqAuLi4KPiB9Cj4gCj4gU2luY2XCoGNsb3NlX2NhbmRldigpwqBibG9ja3PCoG9uwqBj
YW5jZWxfZGVsYXllZF93b3JrX3N5bmMoKSzCoGl0wqB3YWl0c8KgZm9yCj4gY2FuX3Jlc3Rh
cnQoKcKgdG/CoGZpbmlzaC7CoFdoZW7CoHRoZcKgcHJlZW1wdGVkwqB3b3JrcXVldWXCoHRo
cmVhZMKgcmVzdW1lcywKPiBpdMKgaGFzwqBhbHJlYWR5wqBwYXNzZWTCoHRoZcKgY2hlY2vC
oGFuZMKgd2lsbMKgcHJvY2VlZMKgdG/CoGNhbGwKPiBwcml2LT5kb19zZXRfbW9kZSgpLgo+
IAo+IFdpbGzCoHRoaXPCoGF0dGVtcHTCoHRvwqBhY2Nlc3PCoGhhcmR3YXJlwqByZWdpc3Rl
cnPCoHdoaWxlwqB0aGVpcsKgYmFja2luZ8KgY2xvY2tzCj4gYXJlwqBkaXNhYmxlZCzCoHBv
dGVudGlhbGx5wqBjYXVzaW5nwqBhwqBzeW5jaHJvbm91c8KgZXh0ZXJuYWzCoGFib3J0wqBv
csKgc3lzdGVtCj4gcGFuaWM/CgpUaGlzIGlzIHRoZSBzYW1lIG1pc3NpbmcgaW50ZXJydXB0
LW1hc2sgcmVhZGJhY2sgaXNzdWUgcmVwb3J0ZWQgaW46CiAgaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvYWxsL3Nhc2hpa28tb3V0Ym94LTE3MjYxM0BrZXJuZWwub3JnLwoKVGhlIHNlcXVl
bmNlIG9mIG1hc2tpbmcgdGhlIGRldmljZSBpbnRlcnJ1cHRzIGFuZCB0aGVuIGNhbGxpbmcg
ZnJlZV9pcnEoKQp3aXRob3V0IGEgcmVhZGJhY2sgcHJlZGF0ZXMgdGhpcyBwYXRjaC4gSXQg
aXMgaW5kZXBlbmRlbnQgb2YgdGhlCnJlc3RhcnQvY2xvc2UgcmFjZSBhZGRyZXNzZWQgaGVy
ZSBhbmQgaXMgbm90IGludHJvZHVjZWQgYnkgdGhpcyBjaGFuZ2UuCgpJIHdpbGwgbGVhdmUg
dGhpcyBpc3N1ZSBvdXQgb2YgdGhlIGN1cnJlbnQgc2VyaWVzLiBXaGVuIEkgaGF2ZSB0aW1l
LApJIHdpbGwgZm9sbG93IHVwIHdpdGggYSBzZXBhcmF0ZSBwYXRjaCB0byBmaXggaXQuCgpS
ZWdhcmRzLApDdW5oYW8gTHUK

