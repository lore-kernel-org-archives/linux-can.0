Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795705435;
	b=EISgByt76OHpRZNEjvvmsA6TBn5TVIllpNfLT8IVJUtb7ejEha5BfUuv/O58ozf/rN50
	 LO/CheCdmNi6elTFjBi4U80a8BKFbciHZ2APqfvUG1bHIxhL8W2uDs88qcZ06EQMop1Ax
	 CWqC6HewGNKAFUfDP23Sl69636nF1/3FdSVhbpNXNmepdmU3s+tOrrMlSf9GxLfUrxWgr
	 xw9OoTg59G1wyYBVFT5m3NKdH9zuzfIQFjvCJfvyjiz4OW8LFPuhUkUMF3TCmKBS3zusp
	 0nc+1bw7zmg6xOQg+qvUyVQtks5YqVProMmDzq+01s7RsOCkpFutrZg5ah8vcfQZrkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705435;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PJOfhzzym9DT0EIFhuMmQjcHheutHEEjTA2C5YGcm5c=;
	b=CDpRVBVEMfLc69B2uFQcBo6724Bx9E++JxohhsGmauXtZEoJCDwbH7FseU5FwRJ10HOb
	 RDzqLbgnAduAfqBFJxUHJbhsZ1A4ykoF3t9+DSnApWGk6YlLDzm7RO0GMa1OdNBSk0tCf
	 eyG+lGnI77qG8o4X9MY/B2J6hz3xjoD408YjdXI1gh7hhCx26e8d95eNenBOX+yyupQtu
	 +qZhcR+0LojK3ecgruL7OX1Q/i7W6zXwqUIcUD07AqLXeAlQeIH81TIXCyUQcfgdBgTgp
	 qBW33rwY6LBhHfwjb/7YcabvtaIoSY53uHpilzrhjnAtLIWVGFOKzB1TAT940aROwsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iiitd.ac.in;
	spf=pass smtp.mailfrom=iiitd.ac.in;
	dkim=pass header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=CUz4qxTa;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB5C606A329
	for <linux-can@vger.kernel.org>; Thu, 26 Nov 2026 15:03:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BB5C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=CUz4qxTa
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3863db981d4so10015275eec.0
        for <linux-can@vger.kernel.org>; Thu, 26 Nov 2026 07:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1795705433; x=1796310233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PJOfhzzym9DT0EIFhuMmQjcHheutHEEjTA2C5YGcm5c=;
        b=CUz4qxTaHsZSn2Z5cIKiNHsqeDxLJG/OyCSgr3La1Dixk2LDnNf5+nfaTHtvhyDTki
         lpqxJEz7tK+ko9GG1vyJt9DtBaX1QKnq4kQtrtvZQg3T81fa95rO3R2ZCdRcB6iiKNiQ
         IVwLcJMXE6thEag8L9KzHtYzg+mDZCmIF4Cow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795705433; x=1796310233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PJOfhzzym9DT0EIFhuMmQjcHheutHEEjTA2C5YGcm5c=;
        b=TJSXapzMZ39mTm4BKAS0ricXQ88xLDPLCsELGeTHje4b1aBvDTbYqnUnvezOcvd3wl
         7yuTBe+p9GFP/lRfRf+aeKOHx6L4ybSQsPB9u1aqvUFPaM2cFW1a1q/4xs4olpmufuee
         7xh+UblQ/mbZjz5LdezW9BiXU3BjopQiXBmnPzghb1dHpA+yoS8gjYevUK0nkXBOUEcs
         KVTgB5wPik2aPk8b+CePg0wfkLkqt1gDg/EdMzaaUT1QlwI8Sn7eHeU0We6oGdx1IFp8
         pXfvAbaw9cqnbXC253q7GI4cCkPaRAFUPwH8VU/EJ3vc5zNhvxjgxepUehg82y1yfYTg
         cPHA==
X-Forwarded-Encrypted: i=1; AL+hErE608GpH5ubR7FE5QdddoBzSPs84igi8jERYVj3e5t6z4IuU9W/bRGLmym1xGYrqFSLNfoxuTbxKP0=@vger.kernel.org
X-Gm-Message-State: APuU4Z80aPbdvhJA+GvGfS40YYNpdmsa5tqLy15XjK9lppOMnRC1VZjY
	rwUwJRg2v16vJisZCBFAr0AJMeJpi6eqr6XhNGnGI+MfN41/J+nMSiTgXr3J7kwZj70=
X-Gm-Gg: AZFdTZeswxBYmZxdCz2kAoou3KX74Ow/JKiKAKh+IgHI9sDR/dH/yhweNxzhYpgWQ9C
	nx8CR0KzWDpPMUa5vGnLEFlned8IbWY7qCWFb3W1hsA+PwdkPuM/AmOjHCM7kZb4Lt+6pSyFx2w
	x5oRee8vPbkKwNUg/zlEFO3OVVvJi7d/OPXUDGMKpTei947pu8RnLTZIYlcVuIMo1DpbFhBU6fZ
	xgVRkyjxu7N/CEgW8Q8LoAd5/mq+36Z7lr59EQDuA1LUCDXaEaoJHSlzru1ynZH95XMMPejoJ99
	juNqpu9Ya+WicnypH8cgwidtEQBKZILXDnrNrNxVU2AHtAxlclIbuP5dNASvzA1xcg3NnDrmrcL
	42bpLFYl0SxeRZurKO6JfhLz3bdVPsgwCDrvB5Jrv2OSvoaWElxG9lQtdJo5maVjfxIo2C/Lyzm
	CpXxqIsmD4gUlJOlM0c5LNPMEa3bst8lB3AKG7Xzm56k/fAU4EsTzDYrk01+Eai8UbgWnQ0nv3l
	F0+bzWsGK5cHlwwp9OmOH/zYbIwE6HovUb53193xUoSGNrCqNplBBn0sOks9rxxcNw19fAgPAIC
	XfD8/OqPB2C0ckocQcz5wduZc7FM+NKD28af8f6ZbRWd6/z18fx0Pov16kfWYgskWFiyppHRxJV
	UQ9c/PzAM3BdP3/Os20xR7fiMr/tjBRsKq+3/bQGR1FpfqE64MKqc4ZCxqoHruwpb
X-Received: by 2002:a05:7301:78c1:b0:386:a3fe:44de with SMTP id 5a478bee46e88-386a3fe4616mr15220865eec.28.1795705433115;
        Thu, 26 Nov 2026 07:03:53 -0800 (PST)
Received: from iiitd-S2600STB.iiitd.edu.in ([103.25.231.160])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567cafec4sm72602013eec.26.2026.11.26.07.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 07:03:52 -0800 (PST)
From: Piyus Kedia <piyus@iiitd.ac.in>
To: Robin van der Gracht <robin@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Vincent Mailhol <mailhol@kernel.org>,
	linux-can@vger.kernel.org
Cc: kernel@pengutronix.de,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kapil@presceralabs.ai,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH net v2] can: j1939: reject an out-of-range data packet offset
Date: Thu, 26 Nov 2026 20:33:46 +0530
Message-Id: <20261126150346.2110171-1-piyus@iiitd.ac.in>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <sashiko-outbox-233959@kernel.org>
References: <sashiko-outbox-233959@kernel.org>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you - both findings are right, and I have read each mechanism in the
tree rather than reasoning from the patch.  v3 fixes both and is posted
separately.

[High] session leak in j1939_xtp_rx_dpo_one() on repeated invalid DPO

Correct, and the leak is as described.  j1939_session_cancel() only acts
below J1939_SESSION_WAITING_ABORT:

	if (session->state >= J1939_SESSION_ACTIVE &&
	    session->state < J1939_SESSION_WAITING_ABORT) {
		j1939_tp_set_rxtimeout(session, J1939_XTP_ABORT_TIMEOUT_MS);
		__j1939_session_cancel(session, err);
	}

so on a second out-of-range DPO it does nothing, while the
j1939_session_timers_cancel() in front of it has already cancelled the
500 ms timeout unconditionally.  The session is then on
priv->active_session_list in WAITING_ABORT with no timers, holding its
receive skb and its netdev references, and unregister_netdevice() waits
behind them.

v3 deactivates the session in exactly that case, as
j1939_xtp_rx_rts_session_active() already does for a second RTS.  It tests
the state before the cancel, so the first bad DPO still cancels and lets
the abort frame go out with its timeout running, and only the session that
was already dying is deactivated here.

[Medium] aborted session completed in j1939_session_completed() on EOMA

Correct.  j1939_xtp_rx_eoma_one() checks the PGN and the message size and
not session->state, so an EOMA arriving inside the abort window completes
the session.

One clarification on where it comes from: j1939_session_completed() has
always called j1939_sk_recv() on a receive session, so an aborted session's
data could reach the sockets before this series too.  What v2 changed is
the extent - looking the message up at offset 0 hands over the whole
reassembled message rather than one window - and the second
J1939_ERRQUEUE_RX_ABORT you describe is queued either way.  Since v2 made
the delivery whole, the state test belongs with it: v3 returns from
j1939_xtp_rx_eoma_one() when the session is at or past WAITING_ABORT and
leaves the session to the abort path.

Tested on 7.3.1 with KASAN.  The reproducer from the v1 posting still ends
with the session rejected and no fault, and net/can/j1939/transport.o
builds
clean.

pw-bot: cr
