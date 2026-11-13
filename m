Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794558026;
	b=EzBJVXnNhwXJ2ZVH+eK5F03Hkbl+GgACLCHGDh/pvpIZDm4KidDW/VrsIBjAngGorBJn
	 2BqkjLzTAWCY2dPIwCQJI8k0E8QORtAQWdvk5HRff6Y2ofThXwLerEB5qAqZC5pg8/SIi
	 d9aLSbSx6ikDC1QxnpPiJ+KlNqgP3dD1m9RiPOaOV0R0LDphG9aG6a65K2JFikA8Lml5j
	 TmbV8HDuJ9uc7allBp4pz581DEhPx/oe09th3d78nKr4uhMB6+RQ29cEh5fCXz/DMnX32
	 2pJxizNa8kK4j9LAsgVSk4it7OulGD6ZVNJ1yjmkcHF6upCW6qH5OJaktgPMO+ZH1YA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794558026;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:X-Sent-From:
	 X-URL:X-Accept-Language:X-Accept-Content-Type;
	bh=f+STttU8DY+1QnHIs6fxG2bkNqb0eUBXzAOCFZnnc8Q=;
	b=jVJbyjmBzzyCq5cV8ef548vOjOPzf2fNnk1RjA0rojxhhl0CFTle4ovkIUjhWH+jLupc
	 +oMm9DjloIBgHD7kXWymngcaL9QA6WxBvbKTRTqYYCPimCssLMfOAByLJVSysUwubdJSg
	 pJeblzVx6CzQdgqjb69QomhzZzUkm09I8pa9r2qtsBqMGBdKU+Rc9xB6GUQcmuCMTQ0Ed
	 SnCKeEjPbZkqtxWWvnplWXrdKw2S4KNk1XZxOcf7jhbYVXMGaWENDLqn8cenIqEpGrZUu
	 H4wTPD7yM2JxO/oX0gQzbrHHUVhU02flzXlZvY9ttnPnvw9hCQOaXamqTzzNnm3p8Kw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=JIZRH8zc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A240606A323;
	Fri, 13 Nov 2026 08:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A240606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=JIZRH8zc
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id A48E620041D;
	Fri, 13 Nov 2026 09:20:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794558022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f+STttU8DY+1QnHIs6fxG2bkNqb0eUBXzAOCFZnnc8Q=;
	b=JIZRH8zcElq2hNQz9Z2idMOUOkn1yIusSqFpWEDmkm0E0fI2rJYs7o98s4VIA19Jmjksw8
	Cnh0eZEONRtD/QxcrlwT0GtTzInVoVe6b1V734AgFF09C0uuIl6XjMqasmfn4CtyEKknYO
	lxay2QKg6f5pOircB/NIrfXy1VpNGbDHWTwYmYDSSZ+vuR/OCRpolCKcZSBVLMYOTTgMgf
	D3KqyPepw3jn3M/60A2qeAAVQCbeoD0LdeZaGIagzgPVADXJeqg27glRRGmJJreszkDnMx
	pUm64r5lXwUFUYCWQ3LRuVb+uCYicWD1AqvI4QmM5/uLNm6DNiEWhOiBSQ+Mzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794558022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f+STttU8DY+1QnHIs6fxG2bkNqb0eUBXzAOCFZnnc8Q=;
	b=AfklnWRjZD3DwPzi9o3MvOKhA9/zy4sq0PwpbliN5pF3hP4e/b+VVfTE56xtIWAZneziZW
	yPzgXhX7OWVzbOVXhx7sz+NdcbGtFHkc3XH0XcczlgggFW7mg6spuZ4MiCiEH9DBMlCXBv
	XMhbEsyOTqwy2T5kAvhfbNwAvcDiUg0ZVgz6ZXqVHDC0d/nT7C+DeouU9yYHGRJk8zCPBn
	A/cr2PtsIasJ6Ssx+0d01LREO+H3FJ6NU21R2VlRRJC2gFP/XRnSpPA2hweOrrFyk5+cB2
	HvMGzQ54Ph/wJiAwbxAcBLHUv96JauRJROFw/smK3T83pxGQ6A0qyriOhDvp2Q==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794558022; a=rsa-sha256;
	cv=none;
	b=Hlu3DseJZi8vyecGAygtR2XtXTcOtnJY24oWn/WHfWCsOowL6ykmoU9xSBSSK1Ggze9gMA
	jt0tQO3lO6jQi5zqPcwYVYJZpskLcbuHeTBCQE+Nn71IemNqW6PJejErkNlB6G7B6tJfNK
	JiVyhJYG28kBIQxw4ATUrkP9SzrSLwLQR9QVfjEEKPr5jNwrvFO4ZvpciP0XDMWzd7Peos
	5sohfv1FCP3ub43z4oWFuSzxOMaEcZ/rFsVSyDAG8GzkBX636SDBKIedr8anJ/Ej4+p/iy
	VorMSbOGkG+fvn1EZRlPuW1y26sXS78Z8GEWyMK1u+YFEF7EsuqcXtV8mKl+bg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1xRmWE-003xgH-1v;
	Fri, 13 Nov 2026 09:20:22 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1xRmWE-0000000Fppw-21hX;
	Fri, 13 Nov 2026 09:20:22 +0100
Date: Fri, 13 Nov 2026 09:20:22 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: netdev-bot+sashiko@kernel.org
Cc: robin@protonic.nl, socketcan@hartkopp.net, mkl@pengutronix.de,
	shuah@kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	fmaurer@redhat.com, mailhol@kernel.org, alexander.hoelzl@gmx.net,
	quchaosheng000406@163.com, penguin-kernel@i-love.sakura.ne.jp,
	kuba@kernel.org
Subject: Re: [PATCH can-next v3 7/9] selftests: can: add J1939 TP/ETP
 multi-frame tests against CAN_RAW
Message-ID: <avbIRi9NIgi6dcEB@pengutronix.de>
References: <20261111-j1939-selftests-v3-7-5a80277ab363@pengutronix.de>
 <179454972353.488853.9453703448480835098@kernel.org>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179454972353.488853.9453703448480835098@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

On Fri, Nov 13, 2026 at 06:02:03AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The patch adds four TP/ETP tests (tp_rx_from_raw,
>   tp_tx_to_raw, etp_rx_from_raw, etp_tx_to_raw) that the author says can…

pr-bot: cr

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
