Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793961045;
	b=ufDuCJz7viSC7bjZqgNyjhe1jrmr/sgCmfZ5/8CSytDOV9HpOuYl2gDZ8hzzziukhDrG
	 wvUrTrAtEYnTFRy0Nu2uVprZnHpf0ta7b74w20ZvYV9Usb7LyALyJ07GljcX7JFNukzig
	 e4x5GEvNlaV4GZewZQUfptXXZGI4lWp1JOPAqjo1kT6pmmeozVc7V3/YGOM913Rb1kiv4
	 0okD2r41AhsCQaO7OMuS1f/sPHJ7oTyim0EPWViejvJE6HcvMfA8+CDltAd1zc1diMzyb
	 B2lCL100B+3ZL9Zjp+jYp++j1WvYHTafya/5m/AMJCbKRvXGqVDZXpWaBSJqTaQPfRg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793961045;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Sent-From:X-URL:X-Accept-Language:
	 X-Accept-Content-Type;
	bh=alorjCB2vLHR6tDixDHf4C5Wx5SHAKCg+N4icCofI2g=;
	b=Tc/3+RP7E0lpWWbb7Eaw7FkJ+Vg6vUuZR5WONJIDRxQVvkHMLZe0GD32Pub0SreMqITX
	 eon43ZSSRVLFiuoeZ7WR68NC0TTFTGHD4FiR9lxg961nVH1JC64JdX7L6y3qcmQb7bhp8
	 na6uezrq+StUTeiTWGPMO8PnMWZNAyLgosvQfj12g05L9X3C9RloIQfbcVRlF5e2+kvD2
	 1V435OZwoyVtcpS2MG0QQCqC0rvRflH3i+jDuYOJxs+cvMaKcguJxZ4sWXto1FK9zmw/t
	 MgPWAXCf0HnS9C8bhngWYQB7X0f2fw/AP5jAOAn9rh6HDpsClzd8YwWUAxeAV2OYddg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=MTm4++4z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78715606A32F;
	Fri,  6 Nov 2026 10:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78715606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=MTm4++4z
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 6BC0F201899;
	Fri, 06 Nov 2026 11:30:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793961041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=alorjCB2vLHR6tDixDHf4C5Wx5SHAKCg+N4icCofI2g=;
	b=MTm4++4zZE3cF1bOPL3ASaUqGTo6ro/Xt7aV+HqQGT6TDPKKzxILbk8w5srELvLTixOUby
	UhPQ9j60INfrSW3vWEMME9G1Kv0QV8Qaa2j7VYk/KKcId5SzJa0RO6m4ztdCvFNziUpNT6
	oaD8H4fEWOgg9QObT5Up0AyTryqAWUVTkVS06rLfOaU4QeylEacQm/HBrOysiovbzhjxhi
	fhPkwRIGVUKICC1iEPvKdbfD9GYVzpNDRokt4/fQR3YTFHvWRoabchTCXFxXJRyElNjSJx
	KfMLhXduKjP3U4KTJUsFqJxpd6WvjAC86YeGNrXCzdJarCEEiCACt2AObJ23dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793961041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=alorjCB2vLHR6tDixDHf4C5Wx5SHAKCg+N4icCofI2g=;
	b=PosyiYm7UHZONqYtYGXHZm4XWtbr6hTilcrjnEBL8USdD+m5gVkucQFToAOOhoPOwuV+X6
	iEunG9y3l5L+aOud9I+RKHOjFM1djR+vFlew9lspfc0yjQgaW/WqT75HrJoeVk28u80C8o
	S04Jdo2wtg7d4g0glc2Ml7ISuNMWGj2b1a07Sn5RNVuie6/IpI5cgRoTw4Hxe4aZmL1ffV
	YrYojE+u26I9rGuAyBjctSLJoalm3V0u9xqalR2h2a4QypvAqioZ8bZUbnYU/sTAD5sJwH
	zMb/FLgcx2iAzXMkJoMTQ8nufrN1ttACC3k6jUZDi7RkLKOMF1NsMDloQqjcfw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793961041; a=rsa-sha256;
	cv=none;
	b=gbDjEEhNkPCdFqLdqwmi71d8wOvqb9Ehq1DFF5jYeATA9ZPue/hOPLv5OPOvR2KlmUS1yR
	rWDdbPpa7NrbfaikMOZBpNJiVS+wKG6trDig7k43wJsJJASUuZfeRZ90JC3UlBUvd5Fk0c
	ikJvLlQ6HZ73dCh+fgMFyC2A5tYWLieCDBHbKKLPGz11brvPoGloc/ndc4t0vPp8TadL0n
	rAyPvOGk9KkV0LoHN+xCIBEyhmDrJJrK61tcehksvnq/gkUZItz68pWDQoPdsHPeZmR49F
	aUWRyrL8ewoOWblQQrrXdXkI9rashonzWQlfH3taSbrSvy33u/lZDtHKBdGZeQ==
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1xPHDV-002tDr-1A;
	Fri, 06 Nov 2026 11:30:41 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1xPHDV-00000000JsL-12s1;
	Fri, 06 Nov 2026 11:30:41 +0100
Date: Fri, 6 Nov 2026 11:30:41 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Robin van der Gracht <robin@protonic.nl>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Shuah Khan <shuah@kernel.org>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Felix Maurer <fmaurer@redhat.com>,
	Vincent Mailhol <mailhol@kernel.org>,
	Alexander =?utf-8?B?SMO2bHps?= <alexander.hoelzl@gmx.net>,
	Quchaosheng <quchaosheng000406@163.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH can-next v2 0/9] selftests: can: add J1939 socket and
 transport tests
Message-ID: <au2sUdymftKrvVEv@pengutronix.de>
References: <20261104-j1939-selftests-v2-0-cf797c83317b@pengutronix.de>
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
In-Reply-To: <20261104-j1939-selftests-v2-0-cf797c83317b@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

On Wed, Nov 04, 2026 at 05:17:15PM +0100, Oleksij Rempel wrote:
> net/can/j1939 has had no in-tree selftests. This series adds a kselftest
> suite for the J1939 socket layer and the TP/ETP transport, run on vcan with
> a CAN_RAW socket as an independent on-the-wire peer.
> 
> The timer checks are relaxed by default, for slow CI machines;
> J1939_STRICT_TIMING selects tight bounds. Not covered yet: the ETP abort
> and timeout paths, and a received Connection Abort on a kernel TX
> session, which the stack currently ignores.
> 
> Known issue: the stack updates a session from the loopback echo of its
> own CTS, RTS and DT frames, and a CAN_RAW peer can see that echo before
> the stack does. A peer frame that follows quickly can then cancel the
> session and fail a multi test. I have not seen this in QEMU runs. The fix
> belongs in the stack, not in these tests.
> 
> I used an LLM coding assistant to write most of the test code and to
> review it. I have read, edited and run all of it myself, on vcan under
> QEMU.
> 
> v1: https://lore.kernel.org/all/20261014154435.3577983-1-o.rempel@pengutronix.de/

pw-bot: cr

Changes requested by both sashiko instances

Thank you!

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
