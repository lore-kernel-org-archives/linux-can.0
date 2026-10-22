Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792678497;
	b=UZbrjk5c4ZG8GGJ1ZdXEWffpXA5FWNeBN0XmpxWJILHaYiWm6D1YxdqSuQEzyyw1/Nxb
	 dtazb1L6dsFF9RMrSFH5HQ2OQm2tuKsA0rGl/epuChaHIv6cyg1Zj3Fx1K4kvBnpYJEzI
	 zC0ups7zugnaOEjpqbuH7eDAXRWh2769C+SiziscIPdNu/Sx5w+DV1Wx3v6hHJvbMCDb/
	 l8Iz14e0yo6+DrszNxCTk8IEZLEBhvpBE3CsQ6voNyG0NR2gT6Yt0bRyIWxbMWdfiedGx
	 FKW+/R9D65KxmcK3GVUy9I3JcFNgn96GHSGsXFfehPvBwwrMqkZsVgbIHcpaiM8bKTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792678497;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aUAsBe58vjJoSWr3z0ocsdPiHgrUDfhN/DsjzzMI6Lo=;
	b=pPBaOyPPfmS/LVKVktZkMzS9y2vKhuoZ5CjFI6JYAzFqUFZ6OmQJqKQiZnYSCdLCp3hL
	 Us5PmATxhvG87nG2CQywfqRHY9DBUymYvtqdhA8KioODPxFzSYsHDPJXFpBQqeNM6UC+s
	 WjPVktqdX3q5q/g3C84JLTg6lHicfq0FDFHQ/uwTePZNrUSY4VwM28CYt/sEgDb5tMKWW
	 whd91w6d6IbHrqJnDTZ62rzyMoTPASq23wz82k7mknnLSSTezKrm9EIqDoF5HnctTNM1t
	 1RUiOckTpDLzIWaINfIwSWNg0ZfLrTiVygU+sBcM019S+Ak92SSyxggT3QfBFoPt0sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=free.fr;
	spf=pass smtp.mailfrom=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=nXYxF03s;
	arc=none smtp.remote-ip=212.27.42.1
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9B6606A31A;
	Thu, 22 Oct 2026 14:14:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A9B6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=nXYxF03s
Received: from stf-laptop (unknown [IPv6:2a02:8424:8fef:6e01:68ea:cb82:d40f:9275])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id AEE84B0059B;
	Thu, 22 Oct 2026 16:14:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1792678495;
	bh=aUAsBe58vjJoSWr3z0ocsdPiHgrUDfhN/DsjzzMI6Lo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nXYxF03smpD7V+zYuz6Cp/b81U/VFxJcnkD5qPK/IqCRXlSBXQNpJiBkQAST3voHs
	 Hu0XIspdUQp+dfgE3xxWHLYrhG3Yh6BywO6NcoxSfXGI1Ifw+lg+i5FKFtqLusKh5M
	 S6dX52kkeco4cNMpbPRGelZfSUTaB7THvzoQu6Qq59ZxLN+i2aH69YgM5L/LI95Xay
	 G5K/SVGEYCSBC5vZSwvfGKW8xnc+OP0pjwfNxavnig+cYFKGayvy17TP04HaQiY7p5
	 EcEmR8ELKlhzbFWzVtUeMFWvPaWJeFP4UDph8zJKPIoXsfpzv7SsE1emWNvbBHCpcb
	 a0FmVQ7LPTdoA==
From: =?UTF-8?q?St=C3=A9phane=20Grosjean?= <stephane.grosjean@free.fr>
To: netdev-bot+sashiko@kernel.org
Cc: mkl@pengutronix.de,
	mailhol@kernel.org,
	error27@gmail.com,
	wg@grandegger.com,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kuba@kernel.org
Subject: Re: [PATCH v5 09/10] can: peak_usb: register the netdevs only once all channels are set up
Date: Thu, 22 Oct 2026 16:14:37 +0200
Message-ID: <20261022141437.222645-1-stephane.grosjean@free.fr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179264020017.3131.2617691177294766125@kernel.org>
References: <20261020-canfd_check_channel_idx-v5-9-a62b35b867f0@peak-system.fr> <179264020017.3131.2617691177294766125@kernel.org>
Content-Type: text/plain; charset="utf-8"
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

On 22/10/2026 05:36, netdev-bot+sashiko@kernel.org wrote:
[...]
> [Severity: Low]
> The comment says this also runs during probe, before the netdev is
> registered. The helpers this function calls still log through
> netdev_err(), though. Was the conversion meant to stop here?
[...]
> Should those helpers be converted as well?

These helpers are mostly used at run time, where the interface name is
useful, and during probe their messages still start with the driver and
USB device names. So I'd rather leave them as they are in this fix, and
clean them up later on, if needed.

[...]
> [Severity: Medium]
> This is a pre-existing issue, not introduced by this patch, but can
> args[0] be read here without ever being initialized?

Confirmed. v6 adds a new patch, "can: peak_usb: don't return an
uninitialized PCAN-USB CAN channel ID", which initializes args[]. The
PCAN-USB Pro and FD versions of this callback aren't affected.

[...]
> [Severity: Low]
> peak_usb_disconnect() now also cleans up netdevs that were never
> registered. The PCAN_USB_STATE_REGISTERED test only guards
> unregister_candev(). The name is still copied and printed for every
> sibling:
[...]
> Will each unregistered channel then log
> a literal "can%d removed"?

Right, on a failed probe only. This is cosmetic, so I'll fix it along
with the teardown issues below rather than in this series.

> [Severity: Medium]
> This isn't a bug introduced by this patch, but does the bus-off command
> sent on close ever reach the device on this path?
[...]
> [Severity: Low]
> This is a pre-existing issue, but the hardware state set by dev_init()
> does not seem to be undone on this path.

Both are right, and both predate this series: CONNECTED was already
cleared before ndo_stop, and dev_exit() is only called at module
unload. They only matter when the adapter stays plugged in (unbind, or
probe failure), and fixing them means sending commands to the device
once its RX is stopped, which needs some care. I'll address them in a
separate series.

> [Severity: High]
> This isn't a bug introduced by this patch, but can this teardown lead to
> a use-after-free? Neither this error path nor peak_usb_disconnect()
> drains the asynchronous restart URBs or cancels the PCAN-USB
> restart_timer before free_candev().

Confirmed: the restart URBs aren't anchored, and the PCAN-USB
restart_timer is never deleted. The window already exists on unplug
without this series, so I'll fix it in that same separate series, which
is about the teardown, rather than grow this one further.

> [Severity: High]
> This is a pre-existing issue in pcan_usb_pro.c and is not related to the
> code changed here. Can pcan_usb_pro_handle_canmsg() copy past the end of
> the record and past can_frame->data[]?

Yes, fixed by a new patch in v6, see my reply to patch 8.

Thanks!

Stéphane
