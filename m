Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5B738E119;
	Tue, 13 Oct 2026 10:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791887811; cv=pass; b=C5zSQEIzo7Ifr3URsI5Kb5HodwdfZn2OGnnqXBINuxyGVMqgj5XKzrdIednvvh5w+ewQv9V6YW6sX+/K8VvS03TrkB213/sJFk9UO8hCDNQG7yw00haJxjGJYBGJB2J2MetI80PCa9EAvEpypY8xpqE2RzhNyilzBsKwqcYaJtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791887811; c=relaxed/simple;
	bh=UXDIZJErLdPkmwivo36gFvniDggci+KdBCnz3+5yCcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TjkLafYT5yvM+Lzaz0aXQ9/GwBA6iSTr3vwSlJ1PWDyS6d53lB+hl8mssBPT8ZItEfq4KbeW/EdrDsHNSxHhS3TvDiiqMbdX5I6f33lCa5dGGiflo2mCVo72vOW+sRolbj5f6cmIWrYuFCWpf5FfJL/wx0+tlzhTBqvzeU4iEQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=gBgHeU2L; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="gBgHeU2L"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id EC12F201E26;
	Tue, 13 Oct 2026 12:36:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791887799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OdWpvL+iWbfFMKPIXpaPQN0Lmso0BTxWzPGqeVm1vJc=;
	b=gBgHeU2LfPJFwcNnJPf/87/EI0F0vckoDjjNWXCu9SEqNvtIotoG+L3Hrze0po+Q3SgWwn
	Z+Z+eyiaavZYcGLoLBZj1BTyG1I55gVMiAaGz8b9hHz8r+F+ki2g4Wsd107xC0mMPkcZoZ
	iUPet3ii2miWOFkip5nJkiO87ng4OLcKogCCo28+LMSFZvPDL2gnloXnDlg6BWIqX3Zmzk
	KnqibLg72xusYHpnKDMjxuOHfTC1ntylefXxLTiMNU+St1GDoGJHcQRywUQIX4QProe+xO
	P2fZZ2LoNbSKk8S8XKA0hZ7z5A6uNJA8TAzWkdmrMwOV28ZINn1ITY/99tHZ8g==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791887799; a=rsa-sha256;
	cv=none;
	b=ZeOGVaJiEwVP0ZlFcFBeFYFuMntOJ+r9e0ZEYODoNup0JJDfEQwl0Cl8okoajfl6LybkeA
	SqfLB+RzhMXQ2f3+7jmc13HtNUeRjPJ7O5bxV31KkzCMUayl3TVbMUOMoaL+ODQm34GdM3
	0QBlGHoQLRIovIvupfgHz4cXHrJhlR7f40aNQzMcayqtSzWeEYVtCAy8k/TUljyHvmYss2
	9YqtKEAfrVg6DQj59GBOVkl/bfng/7rKiGiLLaQ324rYZE+YuGHABg94T1V9VwrttSql1u
	VUJqZoG4RfZ6sg47pB/BSDYoQxNWdHzRZbWyhVqXiLit2IbCp6muaOS2gN/nQA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791887799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OdWpvL+iWbfFMKPIXpaPQN0Lmso0BTxWzPGqeVm1vJc=;
	b=cd/sDaGrV1sMR36H8LFru4bTmIRHCnbyvv3IWiNjtX57QCWyWo37GXTjQ7TpREjyjhwvPN
	Ngl9OlPm2fbAGl97AUsURyqcy1pKZCLTgRbtU+RfAcqb6v/zKa83TGcHz1Ym7NZgXIPstn
	h/RUm2AbyyCNiVgVAYuGtQ5T+w+/y79E5mku0NN+vo2udo+90QYvLm4VURVibspb1qDLVs
	y1sMzoIg9CVb2fliCMZqc2ziKYsS54vePwqA6u90CBx0PcrtfRFLzYvWQPL5RsZXjyPPhi
	30W3VIzxuFDSTghGxKI6N8f/2a5zh3iNiCi2mNipM/izbj6qVW0R4EKKG6LeLA==
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1xGZs7-005g6d-2l;
	Tue, 13 Oct 2026 12:36:39 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1xGZs7-00000001xEj-38Ik;
	Tue, 13 Oct 2026 12:36:39 +0200
Date: Tue, 13 Oct 2026 12:36:39 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: =?utf-8?B?SMO2bHpsLA==?= Alexander <alexander.hoelzl@gmx.net>
Cc: netdev-bot+sashiko@kernel.org, robin@protonic.nl,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	linux-can@vger.kernel.org, kuba@kernel.org
Subject: Re: [PATCH v3] can: j1939: fix potential race condition in BAM
 segmentation
Message-ID: <as4JtwJObdkyUvZF@pengutronix.de>
References: <20261011153119.120302-1-alexander.hoelzl@gmx.net>
 <179186737069.1406898.4501392866752412525@kernel.org>
 <fda0ca77-ecfe-4f95-a469-05cbc416944a@gmx.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fda0ca77-ecfe-4f95-a469-05cbc416944a@gmx.net>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

On Tue, Oct 13, 2026 at 11:35:24AM +0200, Hölzl, Alexander wrote:
> > [Severity: Medium]
> > Could this cancel then re-arm sequence leak session references if two DT
> > frames for the same BAM session are processed at the same time?
> > 
> > j1939_tp_schedule_txtimer() always takes a reference:
> > 
> > 	j1939_session_get(session);
> > 	hrtimer_start(&session->txtimer, ms_to_ktime(msec),
> > 		      HRTIMER_MODE_REL_SOFT);
> > 
> > Nothing serialises j1939_xtp_rx_dat_one() calls for the same session.
> > j1939_session_get_by_addr() holds active_session_list_lock only during the
> > lookup.
> > 
> > Two CPUs could handle TP.DT frames for this session at once. One example is
> > the af_can loopback netif_rx() for a device without IFF_ECHO, racing a
> > frame from the bus or an injected one. Another is two CAN_RAW injectors on
> > vcan. The interleaving would be:
> > 
> > CPU1                              CPU2
> > j1939_session_txtimer_cancel()
> >    hrtimer_cancel() == 1, put
> >                                    j1939_session_txtimer_cancel()
> >                                      hrtimer_cancel() == 0
> > j1939_tp_schedule_txtimer()
> >    j1939_session_get()
> >    hrtimer_start()
> >                                    j1939_tp_schedule_txtimer()
> >                                      j1939_session_get()
> >                                      hrtimer_start()
> > 
> > When the timer fires, only one reference is dropped. The rxtimer has the
> > same problem through j1939_tp_set_rxtimeout().
> > 
> > A leaked session never reaches j1939_session_destroy(). Its j1939_priv
> > reference and priv_dev_tracker netdev reference are then never released,
> > and unregistering the CAN netdev would hang waiting for the device to
> > become free.
> > 
> > j1939_xtp_rx_cts_one() already uses the same unlocked pattern for directed
> > sessions. Before this patch, though, the RX path never touched the txtimer
> > for BAM transmitter sessions.
> > 
> This also sounds plausible, how should this be fixed? Should additional
> locks be added? The session list lock is probably not the correct one to use
> as this is a global lock over all sessions.
> Additionally is the same type of race condition then found in
> j1939_tp_set_rxtimeout? It does basically the same thing and could also be
> called concurrently while e.g. receiving a can frame and handling a timer
> callback?
> 
> CPU 1 callstack:
> j1939_tp_recv -> j1939_xtp_rx_dat -> j1939_xtp_rx_dat_one ->
> j1939_tp_set_rxtimeout
> 
> CPU 2 callstack:
> j1939_tp_txtimer -> j1939_xtp_txnext_transmiter -> j1939_session_tx_dat ->
> j1939_tp_set_rxtimeout
> 
> Could this cause a similar leak as described above?

Can you please take a look here:
https://docs.kernel.org/dev-tools/context-analysis.html

I hope it will help to resole some of the locking issues.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
