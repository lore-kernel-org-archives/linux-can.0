Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792895277;
	b=Qhi/L/ieRfvPB5tLQB12EGmhN+oug8BWGLvMFIxdHbRM8wzMac0XHvq+7KNTfHKQ6PUz
	 sKoKQ0VaJNhicVz7vF2EShlg0ZEl9k8OckJnuQzleArpSQ6f2pboNE03TYNuZgPkBvKjJ
	 l6SqOR/alRdhc6NnROs1HrV7qzgpIzAg8gUGhJ7bcZc4e4V7YDZYOYTMI1Pgq5XzyEJJE
	 EoJMDlVe2HT80s3vY5c/M+B8RfjSgZ/vfkb3GA/mMteQaK3+IcUVFlMFV3mynJJeJcL8b
	 /iW2krQfgGnUzHahok3bNfYzd8n3UwpxT8ChlercLJ9oAOHheYgfGfDD7h8WU5P5t2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792895277;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=EvF7rEWk+JuhVj0wUXpvNZcsprHBGpNHWv+AUrNAiEA=;
	b=Fgorj/B0Rei7r77m647XQkLK6UhSXAO4N6/B2bVFqxBtAHyHR8/JCdQ/G+iHWyB2e+O0
	 +lFvgDSo4TumpRwNOGyqgKDz9iMsE261ztUped3sV3MQaRYq9zlznuQ62zrZmNX/oGdti
	 UiFdltqbhEX5pk7EFe79Pn3catj/8xuWYeN6IOUxRe81X4tGqyPbSzBBqEyFXCSJtII4L
	 QFFcmwKrVP+38irjs9+5HGy3O64q0otZYVPFqmbhBJ8egvO+8uAHwSYdwHfQFrzkJA8CI
	 TXfn+9VyjlYGVS0lV+rmLsOmo4bCFvKnvkJ+04TgetJKaxXMMDVqQlwkATSHRWUoh6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GAcik1h9;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD96606A31A
	for <linux-can@vger.kernel.org>; Sun, 25 Oct 2026 02:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAD96606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GAcik1h9
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1438d9363fbso1456940c88.0
        for <linux-can@vger.kernel.org>; Sat, 24 Oct 2026 19:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792895276; x=1793500076; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EvF7rEWk+JuhVj0wUXpvNZcsprHBGpNHWv+AUrNAiEA=;
        b=GAcik1h9VA8a1CPUGnqcRbNRxlpt50Hk4nTeCiUsX4GkgZcigzYVReZssr/TDqU2AW
         mbFhFW6jA5azdy+gowOQ8uLL51JxMcJil+alChRbBXUkRaq54icBWv/EUYUvFY32TbMO
         Hcje6hNpQ6xiXf6b8uaAuJeY/dJoHJ4bFZdRhZkjvdheE9K4wwe1S42qNDtasGzz8jQP
         gjk0TEA3tlY8g9WpNooNVzYXMuyWQUFcDL6QiDCbeIZ8kpZedTw1YI2ZcI8jz9o5MCyK
         jULfH7qRyKOrXGLHZ+34o67tKU+MLsgmGwZldYRTijEmBZ9T9LnDZ+HiIgiz7ElAjOgm
         nZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792895276; x=1793500076;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EvF7rEWk+JuhVj0wUXpvNZcsprHBGpNHWv+AUrNAiEA=;
        b=CMoBkCdOAlOIU95ijx5kPIutU1pFP+/j9HcQAABjHy1hZHUMv8v2O+R6Q7kQWIYaOW
         VD283YCQmnObxVY/WV4y6o3ssN/jh4DdflNnosnaTpisWKWP6UvWFVB7HDkrBrhIBCBH
         VP5kmPJYW/6dsPjxq7NgJskYoNCT1Mh8SH+eNc47k+Qb8wqMtTRvrutQNNYnY2UEIxWX
         ifwO6KltHJqb/RsrJUMj1sNPVLLKNMBgPF5eZRC4GJmtb33omSn7wcDE02RknuHsS/5J
         0CB9T99qBHmedUO6y2jOIaDVH8/d2O9hk0cwbHUmM2IUNnFoQWz8BWt9wvnPu+zEbaWs
         /Gsg==
X-Gm-Message-State: AFq9FYIt4zjE8qpZb+zXVK5OAzDQAgjyEzvc+sdrcN0e+Ap1Ks1d2jm3
	1cF9ujUmTvNV7F+u5/AEMkByT19HUtgKno/+7r+/0zuZbaWF2LUk4OnFJqHESYIswKM=
X-Gm-Gg: AYBFou2gt+gIaCukPM7EWqxGHNS/mvpmnNEY4wBF/vq2ryEgoYfxTtSynC8gHBL5YUn
	qbQkU6Y1++XU9SjK//3XJANwOQVU7KYva+9yMVL5eMScqpX2sZhI7MES/B0xMRX0nw1wkJi8XbN
	yYdo8vYSA+Qphf60LnhqAFYOVveE4+N+ga2vFWP7WhnqG2SMmUS85QjBW810zy0XB3jmkc0UwHf
	qk+6ZzqwwHo+lbCtwYpo6qh/3+GWReC5rDk+Zci0uKmToX+/TLR9vfpeeKTA/1Pxhl1g+yTzC/9
	TkQ6A2KB8m4tGuQkiPqUq95WQyrRz5kUB0TfYNeVO7csiDsS8whAoYOswlUe5K0/vx63qM0BSp8
	h/TE30HMD28fZNsIVV7vqlp1K1/2NlJqXGSjR1CLJiag+w2Z02dkRmLBuWaK2eJk3hdD0cL68yL
	4TuKRMrkW1HXvAXBtJqxl5E/G6THMECxKk/cVNVUybbG+rVJP8W6cc1mPQJIphlRfhv49l4MDiG
	mDsBa5spSpC4q4XYVNZ1+8ZUqu9lWYHWVauY6mHkPlp/7BGmx4WKb7VEKAy55+nYE4ZGyC8gme/
	IM8Oj8CUwiAOR0I=
X-Received: by 2002:a05:7022:eb57:10b0:181:8948:f022 with SMTP id a92af1059eb24-1994fa65429mr4664326c88.21.1792895275864;
        Sat, 24 Oct 2026 19:27:55 -0700 (PDT)
Received: from [127.0.1.1] ([183.242.161.82])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a0d98660sm11569291c88.9.2026.10.24.19.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:27:55 -0700 (PDT)
From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
To: sashiko-bot@kernel.org
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, Oliver Hartkopp <socketcan@hartkopp.net>, Oleksij Rempel <o.rempel@pengutronix.de>, Max Staudt <max@enpas.org>
Subject: Re: [PATCH net-next 2/2] can: can327: publish tty->disc_data only after register_candev()
Date: Sun, 25 Oct 2026 10:18:45 +0800
Message-ID: <179289472575.8393.17187271051946169028@gmail.com>
In-Reply-To: <sashiko-outbox-175333@kernel.org>
References: <cover.1792118038.git.chaosheng.qu.linux@gmail.com> <e02d5a1d31bb8dbc6397e3469cd0578b85d78970.1792118038.git.chaosheng.qu.linux@gmail.com> <sashiko-outbox-175333@kernel.org>
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

The mechanism is the same one I confirmed in the reply to 1/2, but I do not
think the outcome is: can327 does not restart its transmit queue from
`write_wakeup`.

`can327_ldisc_tx_worker()` only drains `elm->txleft` and clears
`TTY_DO_WRITE_WAKEUP` once the buffer is empty -- there is no
`netif_wake_queue()` in it. The queue is restarted from
`can327_handle_prompt()`, after the `ATMA` read command has been answered and
the controller is back in the default state, and again from the
`CAN327_TX_DO_CAN_DATA` branch of `can327_parse_rxbuf()`. Both run off the
receive path, and receive is not blocked by `ldisc_sem`: `flush_to_ldisc()`
takes no ldisc reference at all, it stops at the `buf->priority` check while the
ldisc is being changed, and `tty_set_ldisc()` restarts it with
`tty_buffer_restart_work()` after the unlock. So a wakeup lost inside
`can327_ldisc_open()` delays the queue restart until the next prompt is parsed,
but does not strand it.

What the patch is actually for is the failure path: when `register_candev()`
fails, `can327_ldisc_open()` returns without ever setting `tty->disc_data`, so
the `can327_ldisc_tx_wakeup()` that dereferences it unchecked can never be
reached with a stale pointer. Before the patch the pointer was published above
`register_candev()` and `free_candev()` dropped it out from under the tty.

On the suggestion to defer the registration: as in the 1/2 reply, `.open()`
cannot release `ldisc_sem` -- `tty_set_ldisc()` holds it across
`tty_ldisc_open()` and unlocks only after `.open()` returns -- so "after the
semaphore is released" can only be reached via a work item, at the cost of
`.open()` no longer being able to fail on registration.

Thanks,

Chaosheng

