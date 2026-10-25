Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792895223;
	b=ZTxcyxIAet7PqjoGOYtQjSwWEE7Set6VsyooSVyE3bWTZioC3d2CSkoJFv/tm7fXGdo2
	 i+Wq4GG4Xd1g+6lLBitBZEOOP32KcJW4thdOhT3QzOMqXSbLI/BD92qsD4B+7pYH4cXmj
	 bQqVkTRhiPgdeGPzrBFEsHsjPVK+gnywFfvGoBXjRD5DK0Z7ubGcl78g1p/mdi8GO6Ib+
	 U+Hf+y1Gu13gaNdwU/JA4lA7p2iAL74+wYLhL9ri5vKdKWIJLadDJFSXz2eNChCCNij/P
	 ApAJf3GMwPSdOVn9As3yIAeO7BFiAqZLKzmmC4oVxfL8rtyDqEHYcmTtcJAeYnbQmfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792895223;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ATCK/wf05PnAiPqsKVWL6TJleCCGebvZE4TRERap5gw=;
	b=hkP2JqWT9cMKlWF2G3uhcRPF/WaKTaQu52KlqHygp1BzqmoESTfiQ/qHo8hAeziT7xUs
	 F6QdXjNaSm/Li3lR5j0XJvPJegzmaszNfNRTyuyKT5YpuHfjZWGINLN7CG8+iTzW0neCj
	 z3qRI40F0pOzoLQoeNxkuvJSmg7w+34bnt+3ZcO9zFZKketKMQ5UESN4+U2il0oVMhp8F
	 /KeG8nHIJLIDgmS9iBxyPo92Xe87/q0EXl7/OZvR8Vp3ABslzS/b02bsQL3KZ2erZPR56
	 ToFGstB7XpFv6J3Coyt9JAwcVeNQ2sS8fd7cQZwLBbXL5tS4BctPbS6DGPKuBG4xwVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LpWnlcZ2;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B019606A31A
	for <linux-can@vger.kernel.org>; Sun, 25 Oct 2026 02:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B019606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LpWnlcZ2
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1846bc43c28so2068630c88.0
        for <linux-can@vger.kernel.org>; Sat, 24 Oct 2026 19:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792895222; x=1793500022; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ATCK/wf05PnAiPqsKVWL6TJleCCGebvZE4TRERap5gw=;
        b=LpWnlcZ2SEGeKTw25poqISr5oQF360E7YNQyj1+HvB/izvAXBwzrEW7cZ2qieJtFzj
         IKS8l8vm+eA5pyTs1YtjHhTzm1K7YJQv5qq0PjqAHdm5s+gXubwkst0WQYyivH+dhLQ0
         oh33bInhRmXxrPhZGnnrcTDEbc8/Lt0cGiJdDHe/V0ejr11Ppv+HJWRlAyrcAVQmFQc/
         V1f8CCPVJV413h4Rw3wV6BlmvUeYgOTHk/5NRzxOLPGF8ttTWOFsHK+2P8DnvALRORMO
         jbG3WNHjz37+XdXQcgcgNDGjvt4KxhatL6ZBIzVN16iRtacjnQTxzdzY7wH8QTIDF75N
         DMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792895222; x=1793500022;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ATCK/wf05PnAiPqsKVWL6TJleCCGebvZE4TRERap5gw=;
        b=0bAaEKDyqYZT/jqH3/afdKSWMUk+biW8xPjFp4v/lUS9z19eP4dsQ0MJ9Lg8up+YP2
         IGKTRayL+1dQdop+FCbTa5Yt7j99NPR64h63TQpQ3+1wE+Kic467F4xi0jyH7VM++hre
         WK9q68nKpAFT24ny3sY+2AJG2X+kA84EE2olINk0P3X/QyDiHlFLS+VvznLzbFBJtPlN
         3Es2pKA9534K7YeWPilo0X19wrzKiWvERVOsBXrh7BrGD6CNmJq7PgUq/zZV+h/thRU4
         3qJgyV7qOkNRgq4FoJmlHQqZAUWooSp5h6WZTMjX9SAJebEczBAHC1cpG+OmMWCYV8cN
         Lo1Q==
X-Gm-Message-State: AFq9FYJuKmRMUvnL3xYhTHqZVrqzay6tTZuXG+g6BzV92yRfOsaxb72L
	NpplTWUxchZAchPaKNQrFqY+D1Hl3VcoC8FdE3xfQbnpKORq7eveJUIw9FJuCxGoylI=
X-Gm-Gg: AYBFou0oSlLrwg+L/PhDsEtiDBrj9Hju/C90dDcqxw0jtya/5WP8/4JWEoIpa/hMsKF
	+cUUGvSxtXgMVONbwYoofc53/L+bVzXHbOzbcZr2+9gJwXKVTDgHhqlBqacHeo4YR9gdx5kSJ1P
	oLKW/sz+1Q6Cl+Zv4eKr01wSbW9GZ+J0f5eMb+xqqHMvFNx9WDp+AqoIqUJpw8n6x50mUW1dQNi
	RgEuXkKpDgWrDJ+HeYsUPQzm5Md/PXHnmNeHLUnY4C32zR2wKVaJvKYeok75Bhjg/50UwftSE+i
	rMgkgfmfG2Fi6PgyXFfVZx1oka4baf6+5S6W/JQzpgtiv92NQkYrN38Ye3+xXoY0gfC1AxfY17v
	teUNsqYZX8Y0TK9pgsGayD7Tq/eLVBlXP0XiudUZaC1DiTPk7FHPtB40T//eJA7LO0BznPg3Fjs
	X/IeDD0Pi57TXCtB5Aq93W6AQ8JkEDTrDhuUSWwfvGvAozTvL8qadJ7AxA3UVefavqGa+JkE4SG
	eLk+cRtKLbcIga096DSJzNOthTI6eL/QBt/1XcSYqQrJ01L0HCutKu6StFHE4AXG9mR
X-Received: by 2002:a05:701b:2719:b0:14c:c947:6afb with SMTP id a92af1059eb24-1993505eb6fmr3911969c88.15.1792895221864;
        Sat, 24 Oct 2026 19:27:01 -0700 (PDT)
Received: from [127.0.1.1] ([183.242.161.82])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2a5937dsm11561347c88.20.2026.10.24.19.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:27:01 -0700 (PDT)
From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
To: sashiko-bot@kernel.org
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, Oliver Hartkopp <socketcan@hartkopp.net>, Oleksij Rempel <o.rempel@pengutronix.de>, Dario Binacchi <dario.binacchi@amarulasolutions.com>
Subject: Re: [PATCH net-next 1/2] can: slcan: publish tty->disc_data only after register_candev()
Date: Sun, 25 Oct 2026 10:18:45 +0800
Message-ID: <179289472574.8393.6822604769258631913@gmail.com>
In-Reply-To: <sashiko-outbox-175332@kernel.org>
References: <cover.1792118038.git.chaosheng.qu.linux@gmail.com> <afc724d533dc3e7d6d423a641ecb6ca5b40451f7.1792118038.git.chaosheng.qu.linux@gmail.com> <sashiko-outbox-175332@kernel.org>
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

Hi sashiko,

Thanks -- the mechanism is real and the cover letter is wrong about it. Let me
confirm what you describe, then be precise about what this series does and does
not fix.

The lost callback is real. `tty_wakeup()` is the only caller of
`ld->ops->write_wakeup`, and it takes the ldisc reference with
`tty_ldisc_ref()`, which is a `ldsem_down_read_trylock()`. While `slcan_open()`
runs we hold `ldisc_sem` for writing (`tty_set_ldisc()` takes it around
`tty_ldisc_open()`), so the trylock fails, `tty_ldisc_ref()` returns NULL, and
the callback is silently skipped:

```c
	if (test_bit(TTY_DO_WRITE_WAKEUP, &tty->flags)) {
		ld = tty_ldisc_ref(tty);
		if (ld) {
			if (ld->ops->write_wakeup)
				ld->ops->write_wakeup(tty);
			tty_ldisc_deref(ld);
		}
	}
	wake_up_interruptible_poll(&tty->write_wait, EPOLLOUT);
```

So a UART `write_wakeup()` arriving inside that window loses
`slcan_write_wakeup()` -> `schedule_work(&sl->tx_work)` never happens ->
`slcan_transmit()` never runs -> `netif_wake_queue()` is never reached and the
queue stays stopped. The only other thing `tty_wakeup()` does is wake the
`write_wait` pollers, so nothing else notices. `slcan_transmit_cmd()` has the
same hole: it waits on `xcmd_wait` for the `SLF_XCMD` completion that only
`slcan_transmit()` can clear, so a wakeup lost there ends in `-ETIMEDOUT` after
one second.

Two caveats, in the interest of accuracy rather than defence:

1. This window is not introduced by the series. Pre-series the pointer is
   stored even earlier, just above `register_candev()`, so the same race exists
   in the tree today. What the patch fixes is the other half: the dangling
   `tty->disc_data` left behind when `register_candev()` fails, which both
   `slcan_write_wakeup()` and `slcan_netdev_xmit()` dereference without a NULL
   check.

2. Deferring `register_candev()` until after the semaphore is released is not
   expressible from `ldisc->open()`. `tty_set_ldisc()` holds `ldisc_sem` across
   `tty_ldisc_open()` and only unlocks it at the `out:` label after `.open()`
   has returned, and `tty_ldisc_setup()` opens the primary tty with `ldisc_sem`
   already held. The only way to publish after the unlock is to move
   `register_candev()` onto a work item queued at the end of `.open()` -- which
   also means `.open()` can no longer report a registration failure:
   `slcan_close()` would have to handle a not-yet-registered device, and the
   ldisc change would succeed before we know whether the netdev exists.

The failure is also bounded and recoverable: the window lasts only as long as
`slcan_open()`, and afterwards a bring-down/bring-up of the interface (or a tty
hangup) goes through `slcan_netdev_close()`/`slcan_open()`, which clear
`TTY_DO_WRITE_WAKEUP`, `flush_work(&sl->tx_work)` and start the queue again. It
needs the UART wakeup to land exactly inside the tail of `.open()`, so this is a
narrow race, not a stall from normal use.

For the next revision I will drop the "the stale pointer is not observable
today" sentence from the cover letter -- you are right that it is wrong for the
`write_wakeup` path -- and state the above instead. If you think moving the
registration to a work item is the right trade-off, I would rather do it as a
separate patch on top: folding an error-handling change into a two-line
ordering fix is not something I want to hide in this series.

Thanks,

Chaosheng

