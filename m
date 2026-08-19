Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166403CCFB0;
	Wed, 19 Aug 2026 05:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787118781; cv=none; b=OM35r1WBYOGP5FobLcOvbPjONhqQOxB2EwK1oLM44TRyOGPirjxcdyMW74q3auet0wr2BpgaJa7j/ODT4pf+0UDL4JCBn4nO6gf3qOnLwTRqcRpi+dnXwwUV7tR6L6O1ZKsecplWUtPCDgdGCcfsXuUEUrGWtkYdLXecVAbndxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787118781; c=relaxed/simple;
	bh=Bbewlk3dMzOJSN24IHNYqFjqfc1SMKDL6h4dpgYiL70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpRWmGvWzQd3h4aEdoUh3f8JGNR5nzkYdC1fsRx/g3NHOy02y/3k8FgYRzcSEKxQHJFRcrq4c/8I2PiFXH0HR6NDNY1RrJ7ns0LjGGFSfzPZKzQ3zY0Ylsx/8STLqiblyZYTSuQbqTjv/sjjuUbaqyfonSRyWdZuyYrmEIdY91w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 58C90201AC8;
	Wed, 19 Aug 2026 07:52:50 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wwZEI-002FAX-0s;
	Wed, 19 Aug 2026 07:52:50 +0200
Received: from pengutronix.de (unknown [89.207.172.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 770AA585FF8;
	Wed, 19 Aug 2026 05:52:49 +0000 (UTC)
Date: Wed, 19 Aug 2026 07:52:48 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Baul Lee <baul.lee@xbow.com>
Cc: max@enpas.org, mailhol@kernel.org, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, federico.kirschbaum@xbow.com
Subject: Re: [PATCH net] can: can327: Fix out-of-bounds write in
 can327_parse_frame()
Message-ID: <20260819-shapeless-peculiar-mosquito-891494-mkl@pengutronix.de>
References: <20260818215029.47758-1-baul.lee@xbow.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aotvdy4oyhpinnkw"
Content-Disposition: inline
In-Reply-To: <20260818215029.47758-1-baul.lee@xbow.com>


--aotvdy4oyhpinnkw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net] can: can327: Fix out-of-bounds write in
 can327_parse_frame()
MIME-Version: 1.0

On 19.08.2026 06:50:29, Baul Lee wrote:
> can327_parse_frame() assigns the CAN payload length from the DLC nibble
> of the adapter's ASCII frame line, hex_to_bin(elm->rxbuf[datastart - 2]),
> without validating it. A standard-format line only has to satisfy
> rxbuf[3] =3D=3D ' ' and rxbuf[5] =3D=3D ' ', so the DLC nibble rxbuf[4] c=
an be a
> space, for which hex_to_bin() returns -1, and that becomes 255 in the u8
> frame->len. A hex nibble of 9 to f is not rejected either, while
> CAN_MAX_DLEN is 8.
>
> frame->data[] is the 8-byte payload of the 16-byte struct can_frame
> returned by alloc_can_skb(), so the data-nibble loop writes up to 255
> device-controlled bytes, 247 of them past the frame and over the
> trailing skb_shared_info. The length check before the loop only requires
> the line to be frame->len * 3 + datastart bytes, which a long enough
> line of hex and spaces satisfies. Freeing the corrupted skb then faults:
>
>   pc : skb_release_data+0xf4/0x200
>   Call trace:
>    skb_release_data+0xf4/0x200 (P)
>    sk_skb_reason_drop+0x40/0xa4
>    can_rcv+0x6c/0xbc
>    __netif_receive_skb_one_core+0x40/0x4c
>    can327_ldisc_rx+0xc8/0x140
>    tty_ldisc_receive_buf+0x48/0x60
>    flush_to_ldisc+0xdc/0x1b0
>   Kernel panic - not syncing: Oops: Fatal exception in interrupt
>
> Reject the line when the nibble is not a hex digit or exceeds
> CAN_MAX_DLEN, as the parser already does for other malformed lines.
>
> Attaching the N_CAN327 line discipline requires CAP_NET_ADMIN, but the
> frame lines then come from the ELM327 device, so a malicious adapter
> reaches this path with device-controlled data.
>
> Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>

Assuming XBOW is some kind of LLM/Agent/..., you can convert this into:

Assisted-by: AGENT_NAME:MODEL_VERSION [TOOL1] [TOOL2]

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--aotvdy4oyhpinnkw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCaoVErAAKCRDMOmT6rpmt
0uPRAQDk/Eay7rLlEZFkkYHhuYi7EyiQencLuwhFbH2LjjDzcQEA5owffihFN36S
bscdNrWlLlyTjxiR0uoeo95AkzZC0gA=
=L8vv
-----END PGP SIGNATURE-----

--aotvdy4oyhpinnkw--
