Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794223763;
	b=qMDWznCtrcbYdg9O+8yLYq0or9Pc8vq77jBNIPLfgPenUAHIzusDbQyQJvjfyxI+j/NT
	 Fu3bMXw9yHy8UfUkS3iiiNNHXK2B+CDKMNVWTyx7XuBY07sOZns7i69uJupqAgO2639nt
	 5t9By0jdg7FC2tamHiK3gwX/TvYMYzSNO9mwc4rZcSjGDK02ynIMOSzOSUBF7pO8PPPcp
	 rDFAA4LfSfIjP31MxGjGmG9QzIy2kvIKeQlmqfZ1uGK9EfBSOM4YfqGPwfhboXeGVJQSw
	 hzk+/zw1R6Rgv+s+jAubS123P2B/tN93tpXuRl416Mw93ddADwzaaxoiPTxh9Z4fu1Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794223763;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=mGqeOW5shF/VPy+URpXCnf6WYH1rvTjA0kOSE7JTQV8=;
	b=fB9S/SrFVxqsKXv0bWhnUmqGb9cjQAjwum2fA8hZQrCXkHTl5gL6g13Z9/R3NLgAuMKG
	 O+qDXD8f5Gyaz05wZCgEdQiCbqE1sd0x9Kx1fIztuYHNEiPOJQXgjI6zL2Q0VN6drqkbz
	 IrgwFJ46JQ7q4tklHRdiyqcqKTNuQwcbonXowKEisAXNo0EAUdiZdfF10Dk/uaUnGUotB
	 1+v7jmxJudsriBHqpFFoX0k7fnoqZkKEoYVdSMAeHk38Y8y+rFtvVx5ukxmLll+6jOMNS
	 KCx+0jnlT17L4kY0L04h6/EOaL7V+sbhRDKdgz78cz6muKwI1zZHi605hmr7rcMF6pA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=A4wZH6LT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D135606D810
	for <linux-can@vger.kernel.org>; Mon,  9 Nov 2026 11:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D135606D810
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=A4wZH6LT
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 49A31200B9E;
	Mon, 09 Nov 2026 12:29:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794223760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mGqeOW5shF/VPy+URpXCnf6WYH1rvTjA0kOSE7JTQV8=;
	b=A4wZH6LTP7uHRYx3DM0q7dvzxt2HmrRZnyPHgLqWi3qWKbIwvgfJmDXbgZe221cSQQqKqh
	xqgtm1iADBs7dII14D69F74saF4uLK2IQpRJf+oEFzF41J2DVT6QEfx+DVlCb2gPYkG93k
	dKSqQjWdBb+r7Npa79JUJdVUFnR11tM9YPW74TYaE2dct1hgIpjq69H1iObk4vpseVvXxA
	/eZCxvA2MhJqGrFX9MZ5TKay2QOCOr+wHjPI8OSHOjP8hxd+xdJIwNca2rwPyfo/uulShF
	pPc5hJMs5vtHEBeGGlPtkFREBmM1FOleWjwaAnGa5WsjsLcCK7qUpMeG3j7Vjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794223760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mGqeOW5shF/VPy+URpXCnf6WYH1rvTjA0kOSE7JTQV8=;
	b=NcPm9IPPDl5KsEZpDo5zunpCURMbTmicYFk3K5Nd4FHb8FM5+UYubTu+cmRF4TfeyL1fnG
	1bu6snBOdM2XZ2n8LLUax/Ngthw9CJwrXDKX60X3PlXiNxc2D9qxQP2yQ1hxVQrCm6WWB6
	Mns/EVkpjbSqyCrQLzzoC/JBZIyFOhdYTnmxRkbppFbZGOAaakp7usTz418tTcEemerxw/
	EBfovdRusBmBjINIeZArw7hrB38YchPbxmNgQ3NbETfpN0EzOnb409e+NDiLwvA/0/Hw5u
	foSMheZIBbIfEaY+m+iGK3RhPOEn/l2GNh7GnLgX6f7N89uby4Rb2D/gwngANw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794223760; a=rsa-sha256;
	cv=none;
	b=P/7GtUs/sxhstAH8i6H3DU4Mb9pT4Nrw7Sk49Gq7SxWixoKgyHADQTB6lHTQgR2BmK8RIC
	k5MqY36nDXjWey/57Rn8rS42r/CR9vx0JEeFOVLrCKi/w2lpW8Ak0B8hm2reRlxkZ066WY
	JSU9iEEhUWGGbe4BHRa28Bkpnht09tydhmayha354B/PAVs0xtATzqrHwhWKE677JVPWSZ
	NI7sZzNKkSlcrBA/olF2cJXT5roV8e60A5SRBNHPYt7RfVOHKtw4FLRe+VxRs7JrwHtEO0
	J/B6ewFETbykF17qIBd/StZ8S52tPTnFw6yBlvK6UU7vDe7KTNQiO3veskf6cQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xQNYu-003KpM-0f;
	Mon, 09 Nov 2026 12:29:20 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E6B3D5E537D;
	Mon, 09 Nov 2026 11:29:19 +0000 (UTC)
Date: Mon, 9 Nov 2026 12:29:18 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: sashiko-bot@kernel.org
Cc: Mike Looijmans <mike.looijmans@topic.nl>, linux-can@vger.kernel.org, 
	Oliver Hartkopp <socketcan@hartkopp.net>, Vincent Mailhol <mailhol@kernel.org>, 
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH] can: mcp251xfd: Always stop on BUS_OFF and call
 netif_stop_queue
Message-ID: <20261109-ambitious-purple-myna-49ba4f-mkl@pengutronix.de>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.12523541-9b07-4081-b2ca-c8093468f69e@emailsignatures365.codetwo.com>
 <20261109070605.9761-1-mike.looijmans@topic.nl>
 <sashiko-outbox-204540@kernel.org>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uzw4ch4mpcbjvnq2"
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-204540@kernel.org>


--uzw4ch4mpcbjvnq2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: mcp251xfd: Always stop on BUS_OFF and call
 netif_stop_queue
MIME-Version: 1.0

On 09.11.2026 07:24:53, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [Medium] can: mcp251xfd: netif_stop_queue() race in
>   mcp251xfd_handle_cerrif()
> - [Low] can: mcp251xfd: missing Fixes trailer for
>   mcp251xfd_handle_cerrif() fix
> --
>
> commit 04d0094bdd9ffb626b769cf55b6bbc25e504875f
> Author: Mike Looijmans <mike.looijmans@topic.nl>
>
> can: mcp251xfd: Always stop on BUS_OFF and call netif_stop_queue
>
> This commit changes mcp251xfd_handle_cerrif() on bus-off to log an error
> instead of aborting when reading the BER counter fails, and calls
> netif_stop_queue() after stopping the chip and invoking can_bus_off().
>
> [Severity: Low]
> In the commit message, since this is a bug fix for the bus-off handling
> in mcp251xfd_handle_cerrif(), please consider adding a Fixes: trailer:
>
>   Fixes: 55e5b97f003e ("can: mcp25xxfd: add driver for Microchip MCP25xxF=
D SPI CAN")
>
> [Severity: Medium]
> In drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c, inside
> mcp251xfd_handle_cerrif() (around line 1138), can calling
> netif_stop_queue(priv->ndev) after mcp251xfd_chip_stop() and
> can_bus_off() race with concurrent transmissions and bus-off recovery?
>
> CPU0 (threaded IRQ)               CPU1 (kworker / restart)
> mcp251xfd_handle_cerrif()
>   mcp251xfd_chip_stop()
>   can_bus_off()
>     schedule_delayed_work()
>                                   can_restart_work()
>                                     can_restart()
>                                       mcp251xfd_set_mode()
>                                         netif_wake_queue(ndev)
>   netif_stop_queue(priv->ndev)
>     <-- TX queue left stopped
>
> can_bus_off() schedules priv->can.restart_work, which runs can_restart()
> and mcp251xfd_set_mode(), reinitializing the TX ring to empty and calling
> netif_wake_queue(ndev).  If the threaded IRQ handler is preempted after
> can_bus_off(), netif_stop_queue() runs after mcp251xfd_set_mode() wakes
> the queue.  With an empty TX ring, no TEF completion interrupt will fire
> to wake the queue again, leaving TX permanently stopped until the
> interface is cycled down and up.
>
> In addition, mcp251xfd_chip_stop() performs sleeping SPI transfers while
> disabling interrupts and entering configuration mode.  Leaving the TX
> queue active until after mcp251xfd_chip_stop() returns allows
> mcp251xfd_start_xmit() to submit new frames concurrently while the chip
> is shutting down.
>
> Calling netif_stop_queue(priv->ndev) at the start of the
> CAN_STATE_BUS_OFF block before mcp251xfd_chip_stop() and can_bus_off()
> (matching the order in mcp251xfd_stop()) avoids both races.

Please fix the race condition, the suggestion looks good to me.

Marc

pr-bot: cr

--
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--uzw4ch4mpcbjvnq2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCavGujAAKCRDMOmT6rpmt
0heGAQCdsakTK1DGHT0iMp/cu+ejUr6nCW75VPosYH5mbT688gD/dOZDWXcppOqe
wmvUjJC11rGGfE2HeMLWX+x+tZq/Nw0=
=B2G4
-----END PGP SIGNATURE-----

--uzw4ch4mpcbjvnq2--
