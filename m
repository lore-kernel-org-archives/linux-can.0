Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794209095;
	b=rgSfdR0I2WlYvsZ/SWm1U5zbrC0xKdTjmUPgPN/q9/m/6OVVkaeqHp+ZOT2rCEW2s3DE
	 cEQ5yeyJg3efkt3HeQe9W93ohh76WnYqThP9dcWyv19dsY6mQkiYa97R+WAR7sFmgu1Dn
	 iFgIyw/WGxxoyxIP/of/t1K+E+uIoY7fFWQItNGT0G9+t4QdWMnzQbAx+lYdYFg2ZiaoF
	 g5mFckHqaoO/6FUe4VK5PACLqGtB5ubkbG6LZm2hUL1IxHOGtGzqrWKWxgnLRQG5m7Izx
	 aUWZA8QXGE59rThalpb8t4vq8f45ZdSOMDhni7gOMl8p7a1cr0rUPyM8qvRXzJOvOyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794209095;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UVv8maznjKbZ308mihG4BncoCNmylEz9VAKJEPu4to0=;
	b=0othjnaCXUUbpPI2gYEAVfMp2l1x41RoIwO33AY3JcWGxCajV3EZxVO4p6ypPyhaZAoH
	 x4N2HfZCKCzSxmuuLmtgqHo8R+A5sKC0xl1Vi0NcB1RUIPsnHZ3i0A2jpqrGWRbIfOYws
	 MDA3Um7ij6FK1R2Gkc1cua3dbQRQQ+SAQxQZTbuP696vWEfYNImRaCH9NoAzC76hcV8Qq
	 0sUQId1KmGPefnyrjMCIJRvAuHaOxkBvb/s1+xRgjfh6lXYz0GDEeE0fyzUO9+E6PzqQI
	 AafCG169fFiXFmwY6yAWyL21WWTrNwznL7auYlcz0NElBgh9BdfjWwdnEkwaaAtfuWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k+Ye70yd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC469606A321
	for <linux-can@vger.kernel.org>; Mon,  9 Nov 2026 07:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k+Ye70yd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7991F0089F;
	Mon,  9 Nov 2026 07:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794209094;
	bh=UVv8maznjKbZ308mihG4BncoCNmylEz9VAKJEPu4to0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k+Ye70ydKUo+fTGDpaIXqBtdAWXBZGkTcqr3MFLvnmCrETTr4Zc/2q89SwWDQuM1j
	 hCKGVJsGGcp3HZ9X0HyshOZUel6FVYrU6pLG1OaMAgJ+rbrL0d+Fhg6lbcEuYdMra0
	 aDygSoLDszv/PDJQFhnee22u0rx8QivjtZKKwpqGGgI/blMlFFhLvOcct8HrOO3TWu
	 apiCxBhmqXwCFgH+9ZAYUi/98lnMNyML5456WhMnRTGeUXoZPDVFmXiAAzaiDQK4L9
	 YaH2Jyc2VHhCtPP+M5sR96k1zTWX1+q94dPCeKLdxxyRYk9AV62JV+KCn0x16IZH4g
	 cktc/c9H5N9+g==
Message-ID: <sashiko-outbox-204540@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] can: mcp251xfd: Always stop on BUS_OFF and call
 netif_stop_queue
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mike Looijmans" <mike.looijmans@topic.nl>, linux-can@vger.kernel.org
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261109070605.9761-1-mike.looijmans@topic.nl>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.12523541-9b07-4081-b2ca-c8093468f69e@emailsignatures365.codetwo.com>
 <20261109070605.9761-1-mike.looijmans@topic.nl>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 07:24:53 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] can: mcp251xfd: netif_stop_queue() race in
  mcp251xfd_handle_cerrif()
- [Low] can: mcp251xfd: missing Fixes trailer for
  mcp251xfd_handle_cerrif() fix
--

commit 04d0094bdd9ffb626b769cf55b6bbc25e504875f
Author: Mike Looijmans <mike.looijmans@topic.nl>

can: mcp251xfd: Always stop on BUS_OFF and call netif_stop_queue

This commit changes mcp251xfd_handle_cerrif() on bus-off to log an error
instead of aborting when reading the BER counter fails, and calls
netif_stop_queue() after stopping the chip and invoking can_bus_off().

[Severity: Low]
In the commit message, since this is a bug fix for the bus-off handling
in mcp251xfd_handle_cerrif(), please consider adding a Fixes: trailer:

  Fixes: 55e5b97f003e ("can: mcp25xxfd: add driver for Microchip MCP25xxFD =
SPI CAN")

[Severity: Medium]
In drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c, inside
mcp251xfd_handle_cerrif() (around line 1138), can calling
netif_stop_queue(priv->ndev) after mcp251xfd_chip_stop() and
can_bus_off() race with concurrent transmissions and bus-off recovery?

CPU0 (threaded IRQ)               CPU1 (kworker / restart)
mcp251xfd_handle_cerrif()
  mcp251xfd_chip_stop()
  can_bus_off()
    schedule_delayed_work()
                                  can_restart_work()
                                    can_restart()
                                      mcp251xfd_set_mode()
                                        netif_wake_queue(ndev)
  netif_stop_queue(priv->ndev)
    <-- TX queue left stopped

can_bus_off() schedules priv->can.restart_work, which runs can_restart()
and mcp251xfd_set_mode(), reinitializing the TX ring to empty and calling
netif_wake_queue(ndev).  If the threaded IRQ handler is preempted after
can_bus_off(), netif_stop_queue() runs after mcp251xfd_set_mode() wakes
the queue.  With an empty TX ring, no TEF completion interrupt will fire
to wake the queue again, leaving TX permanently stopped until the
interface is cycled down and up.

In addition, mcp251xfd_chip_stop() performs sleeping SPI transfers while
disabling interrupts and entering configuration mode.  Leaving the TX
queue active until after mcp251xfd_chip_stop() returns allows
mcp251xfd_start_xmit() to submit new frames concurrently while the chip
is shutting down.

Calling netif_stop_queue(priv->ndev) at the start of the
CAN_STATE_BUS_OFF block before mcp251xfd_chip_stop() and can_bus_off()
(matching the order in mcp251xfd_stop()) avoids both races.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109070605.9761=
-1-mike.looijmans@topic.nl?part=3D1
