Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794539641;
	b=CrrNIGZECCr9UYJsbI+OTjYTqsW83P3zyazmMdTNwfb6z25irqQWywgiSYrrFvjQj9WW
	 jmC6hgYLsYqcKa1/63Ns027jyF/zzBiyXvOQZK9sJpf1i9asnmptjZnj0L8/vAlvfYjCl
	 270Vq12LaQCthfLMl6UvFgvT5auE3a/t9RsHXcqeaOepjngFpuEhFbyK+YzaCXpeaNDUQ
	 fvh0rF+gJyhqFUWnyPB3TQacg//0lGW3bBpwd7b3U327HSVSH4asnfyEd9YoAfvrjo7Z1
	 pUC0AXRzWrxxSqdtXyWosJ77L6tkrK7NTsQo8Vz6BlS1lPYhrHZGnMRTKvcuu8STA+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794539641;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=k+VTHngtUIqLSYN13mnqJruEgfstyF2MN3VfSxypVXM=;
	b=Nk4uQQqPIjgORMoo0I3r6tYNqnJFMoKfv0JGraSmBzOsSJv4k+DVx+a+jPBjGpe+Tc55
	 Ortxo73SQU1/FHsMiSvNvvUVw5HOd8wmCP5k6x7HKp15ZJ8O9BMb2ppRwlsNPSU8Z971j
	 Xgb/y9IvpPuPoLXl8OfsCVbh48f/06jk/meOlqsfcdGPMzaq1S9uRO00yUR0RzRNBPtB/
	 GndNJA4jSWuKlNbM3Jx9vy+2PBI1KPPNv9Pg+QhCRlc+posQRAkX5w5cQquwMbxB82Sgi
	 ejsDL3GA8Rhb7iWVHzZcGg9a0OfrjT53BD1dU7HHDXuS4p5XaVj47xZ8fWrtuOReneQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=jDblbLzw;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF35960A2605;
	Fri, 13 Nov 2026 03:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF35960A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=jDblbLzw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=k+VTHngtUIqLSYN13mnqJruEgfstyF2MN3VfSxypVXM=;
	b=jDblbLzwstp+KSl+WelTtjRdcrn5VKTtXXHsutQ7hvl3u1CgcZXRW+StxmAZFn
	WuQataDb3E8jcRE0J9VRcLfPYho8mq3etBdJecQu5Hq44H5TLHumDB/tz4Y4ugWm
	CziMYb6s89jJxf+sW+GKf8cvn3ZrpkQNCZhYaHB0c4mvw=
From: Chaosheng Qu <quchaosheng000406@163.com>
To: netdev-bot+sashiko@kernel.org
Cc: Robin van der Gracht <robin@protonic.nl>, Oleksij Rempel <o.rempel@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net v7 1/4] can: j1939: arm the abort timer under the session list lock
Date: Fri, 13 Nov 2026 11:11:13 +0800
Message-ID: <179453947397.30993.11677929413398880016@163.com>
In-Reply-To: <179452017919.488853.15478724062923628521@kernel.org>
References: <179410166345.60581.16722127854597502548@163.com> <179452017919.488853.15478724062923628521@kernel.org>
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
X-CM-TRANSID:QCgvCgBn+qFUgPZq0TtuFg--.7318S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFyDKrWxXr15Cw13tw1fZwb_yoW8uFyUpw
	43Kry3trs8WF4ay3ykXFW8WrWIvrnxZFZ7tF17K34SyrsxCF48tFZrKFW2ga9xtwna93ya
	9w17Wrn8Xa18ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U5uciUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC4xaNA2r2gFYZEgAA36

Hi,

1/4 was rewritten in v8 and v9 is current, but both High findings were real
in v7 as posted.

The commit message claim was wrong. Only j1939_session_cancel() took
active_session_list_lock; j1939_tp_set_rxtimeout() still did cancel, get and
start without it, so the lock only serialized the cancels against each other.

The double-arm is the same problem, and the WAITING_ABORT re-arm is what made
it reachable: the second caller found the state already changed and armed on
top of the timer the first one had queued. Two gets, one expiry, one put, so
the session and its netdev reference leak and unregister_netdevice() waits.

v8 moves the lock into j1939_tp_set_rxtimeout() and routes both armers
through one helper:

	if (hrtimer_try_to_cancel(&session->rxtimer) == 1)
		j1939_session_put(session);
	j1939_session_get(session);
	hrtimer_start(&session->rxtimer, ms_to_ktime(msec),
		      HRTIMER_MODE_REL_SOFT);

and drops the WAITING_ABORT re-arm, so only the ACTIVE -> WAITING_ABORT
transition arms the abort timer.

Still open: try_to_cancel() returns -1 while the callback runs and does not
dequeue a timer requeued from it, so an arm that races the expiry can still
take a reference it cannot pair. Your review of v9 1/4 says the same thing.
The next version needs an armed flag taken under the list lock.

The Medium was real too. On a receiver the second timers_cancel()/cancel()
pair re-armed the abort timer, then deactivate_activate_next() moved the
session to DONE without cancelling it, so the expiry skipped the
WAITING_ABORT branch, took the generic else and queued RX_ABORT for a
finished session. v9 has no re-arm and j1939_xtp_rx_rts_session_active()
deactivates for both roles.

Lows, all accepted: the subject was retitled in v8; the Fixes should be
d966635b384b, not 9d71dd0c7009; abort_sent never distinguished anything,
since __j1939_session_cancel() always sets WAITING_ABORT and skips the abort
for broadcasts; and restarting the 500ms deadline on every cancel is a real
behaviour change the v7 message did not describe.

Thanks,
Chaosheng

pw-bot: cr

