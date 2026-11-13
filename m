Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794539641;
	b=ikYsQOLGFeyA6J6vMzywfq+SsfdCI5Nf45L6dEU+1JtRuYTYt0XFRLo9SlUnUix9SbxY
	 HQmYXhHkEyJ/JjHNcJPwF9SBgBShqvehYjFVY78k8ziXXS+tvNYNXefP2xXWuF45qfCOs
	 ZyXdt+QodF1+VbJE5QrpLHENSe68vJitquayvynR6NJ4/8fsoHYFu0nhLVqtL7p/3H2Ou
	 gZ1MGFw/Dzcy+Cv3RCP/jkESQGUZMREw9x5lui859aLD//NB0DFP7Ei08nnAM/bBNveJD
	 SKLDKq5+1xmlfr3F7ldo4n1fe1OhiiRlLusowuu0e8HHcqRLq8zEVyXb4Wpgtl/4/8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794539641;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=IaVog86Jm/7BPHoJKA6L79YCvmTQudSwcC4bCe/+BNI=;
	b=UX1L4xS9FPjklQEZcoKbnmRUvyJj2MQFAEQRSn9V4jySEiiGdfZ+ONiHi2ukTC5jsT+N
	 +KUywcvBP0TMenirufWLqdngYSFSa3g9FNFdOomC6CBmkl4WBfER2d0rC+ZaNL2YgIdJy
	 Snr29UadPDvAiH9Cw6Aam1T+5YpqwXdIjnYOLPz0Y0oRgEFxoyIU7p89lEIc1LMKJnXti
	 uCM2NjvhP2pODA0Bo6cE3YFKkrZmNviQZb9AOnzi7TZSCReI4/BI/vKui9N2ng7J3KQbT
	 OR9ir8Mu0cdTpZsE649/Nr08Q9BvxuuF0SCsmN8q3L5l1bQ3TO+EzPmKM+NvdV1j9yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=J1DcfFIG;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D66606A897;
	Fri, 13 Nov 2026 03:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3D66606A897
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=J1DcfFIG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=IaVog86Jm/7BPHoJKA6L79YCvmTQudSwcC4bCe/+BNI=;
	b=J1DcfFIGyv6FyIl8xuWO5hvAqglRDa+C0KNa8KD0SiUEWugAqg5Mo97IKNu+xr
	fXKl7iS+CVgV/n9andCb3C26Ca1ZjqByabCQOokCILxTw2HbCbzO3PJQLoK/sXSg
	N9fzv8ify+0Nq70q/dg0xdghtSwadQID92kNMdogxSs88=
From: Chaosheng Qu <quchaosheng000406@163.com>
To: netdev-bot+sashiko@kernel.org
Cc: Robin van der Gracht <robin@protonic.nl>, Oleksij Rempel <o.rempel@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net v7 2/4] can: j1939: validate the EDPO packet number
Date: Fri, 13 Nov 2026 11:11:13 +0800
Message-ID: <179453947398.30993.18128641012782298880@163.com>
In-Reply-To: <179452018139.488853.4180903963444412204@kernel.org>
References: <179410166345.60581.5430129940541091934@163.com> <179452018139.488853.4180903963444412204@kernel.org>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHzxNYgPZqFCfaHA--.11325S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruFyrtF4xtr48ur1fZF1xAFb_yoWDuFg_ua
	4vq3W8Jw18t3ZrKayUWrn8Zay7GFyjyr15tryqqa4IkryvkF47Zry0qa4fuw1jgr4YqF95
	Crnxt3y7Kwn0qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_hFx3UUUUU==
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbDABmOBGr2gFmtugAA3B

Hi,

The Medium is right. j1939_session_cancel() only touches the rxtimer, so the
txtimer stayed armed on the aborting session. On the transmitter the
-ENOBUFS retries ran up to J1939_XTP_TX_RETRY_LIMIT and replaced session->err
with -ENETUNREACH; on the receiver they sent a CTS or an EOMA, and each of
those ends in j1939_tp_set_rxtimeout(session, 1250), which replaces the abort
timeout. v8 adds j1939_session_timers_cancel() before the abort, and v9 has
it.

Fixes: 9d71dd0c7009 and Cc: stable are in since v8.

Two things I got wrong in this patch, from your review of it on v9. Once
j1939_xtp_rx_cts_one() bounds the CTS, an out-of-range EDPO on the
transmitter side can only come from a frame this host did not build, since
J1939_ECU_LOCAL_SRC is set from the source address alone. ECTS_TOO_BIG blames
a responder CTS that was valid in that case, so the next version uses
BAD_EDPO_OFFSET for both roles. And the comment refers to "4/4", which means
nothing after merge; it will name j1939_xtp_rx_cts_one() instead.

Thanks,
Chaosheng

