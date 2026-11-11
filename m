Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794381514;
	b=qAmHmkUYEbv8ezZ4s5ZaskvNLJiVQX/q//og7cZblbB6HskNhkQ81cyLHmuw6p9V6Yu9
	 zo0typMAqNn0aKuamNKE5mErpB4QwBAqQlwg79x5avNEVyMvuonQmv2uXUsEPxF2OCW+k
	 Y8dZ0zZzOsKo5E++2GwVyLKl6rDyPbjgzPDJ3zzakTpsSrKlsRG3GzJu9kcMzvLUBcXnV
	 IT6V7fPW39cBIuZTA9osRp8xdqRGEyd4/ivVOgh2k6CcZviF1Glkc8WcZwWGkB8T2ImYX
	 jZoNgWw/gJdRY7izZJD0yZe8zvwruKR0tkYkzz6rso9oALCRN/cB2qIOpOFGNaYHqWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794381514;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=NXrfmHI5m7P6Ka/WZtyj2dVnXi1+V6LgIXrMbsaEdd0=;
	b=Rt5umbi9jD8SOW2KTD96/8IiW5KuhZLMSWhtS4LoXLtjSkdua4pr9wWKzoI2HOa26RwU
	 /jR9h55Cq4uysy16jsu6L2n+Pgr+1CSUe9anFL1DxPMBEJ5yUS/ITSdKRs7T4Ph6xTJOM
	 iC2YWVk710HLg1E6HkZniKGY2sobTDGzL7d697HPyihlTAwhqYxK872jvntsgpxhpaJ2K
	 MT70HpT8m9VKqB4U0YkWf+VmgmwDahb0DjLbCo0+WdBVYhg6TeXJ+dnvztDEL3KImHhoC
	 oJPdJIMcGGlWaAwJ/JBguqAa1ovMTXTUJl/O6Osb7Z6LjKPzEwGaPJZ1qg3vZ8+sbZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=EmgzznpL;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB13A606A320;
	Wed, 11 Nov 2026 07:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB13A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=EmgzznpL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=NXrfmHI5m7P6Ka/WZtyj2dVnXi1+V6LgIXrMbsaEdd0=;
	b=EmgzznpLQefOSiFNRSApwZ7UvYvdqyH6I3n9neTV+tMky8aawjhv+UC6lidcG+
	gehXfZFLXngb40rZdM+ypfYDD/wOHjq6sRl8iacuWe3uuMtzT0utkJkHtqPTgrR8
	Ehop7REIwVEnETz0KkZ15LqnrQJ12s7doUfRfAWkBfJHo=
From: Chaosheng Qu <quchaosheng000406@163.com>
To: Robin van der Gracht <robin@protonic.nl>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH net v8 0/4] can: j1939: fix the abort timer and bound EDPO
Date: Wed, 11 Nov 2026 15:20:00 +0800
Message-ID: <1794300100.11111.1000000@163.com>
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
X-CM-TRANSID:PigvCgBn8zitFvRqUahNFQ--.11610S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFy7WFy3JF43WF13Wr18AFb_yoW8Ww4Dpr
	Wagry5Jr1DJF429ws3JF4DXFy5Zr4ftay5Jrnag34xAay5GF15KFyUG3sIgFZrA3ykC3y2
	9rsFgw15Cr4qv37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jomhrUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC4w6I-Wr0Fq7HOgAA3D

v8 addresses the three findings from the sashiko review of v7.

1/4 is rewritten.  The v7 version cancelled the receive timer before
taking active_session_list_lock and started it again under the lock, so
two concurrent callers could both reach hrtimer_start(): the second one
reprograms an already armed timer and the reference taken for the first
arm is never dropped, leaking the session and its netdev reference.  The
new j1939_tp_arm_rxtimer_locked() uses hrtimer_try_to_cancel(), which
never waits for a running callback, so the cancel and the start happen
together under the lock.  j1939_tp_set_rxtimeout() and the rx timeout
branch of j1939_tp_rxtimer() use the same helper, so there is one arming
path instead of three.

2/4 now calls j1939_session_timers_cancel() before aborting on an
out-of-range EDPO, as the other receive-path abort handlers do.
j1939_session_cancel() only rearms the abort timer, so the transmit timer
stayed armed on an aborting session: on the transmitter path the retries
kept firing until J1939_XTP_TX_RETRY_LIMIT and overwrote session->err with
-ENETUNREACH, on the receiver path they sent CTS or EOMA and clobbered the
abort timeout.  It also carries the Fixes tag for the NULL dereference.

3/4 and 4/4 are unchanged from v7.


Chaosheng Qu (4):
  can: j1939: serialize cancel and rearm of the receive timer
  can: j1939: validate the EDPO packet number
  can: j1939: drop the message when the reassembled skb is gone
  can: j1939: reject a CTS that names more packets than the message has

 net/can/j1939/transport.c | 119 +++++++++++++++++++++++++++++++-------
 1 file changed, 97 insertions(+), 22 deletions(-)

-- 
2.43.0


