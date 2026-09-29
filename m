Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F25523785;
	Tue, 29 Sep 2026 14:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790693373; cv=pass; b=a+S1zl8Idd3P6s8ZJtAZashvLdHU1vRiKz1S2pMTEIlY+47Q3nB2z758+TpbfnzAhG3pWEyEAJ9zQzXDN0Ogu0XU3BWDKlY5ox8TK7J2C4QMG3iEIeJChX4ujzDzUD3K3eBcjLTHyRoHfdluF8T+RDtkAxIWUxqv31vHLJaFdDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790693373; c=relaxed/simple;
	bh=TaqxQzJdb/h4+8/Ys3HoOegEqZZ4kXLBC6w/iwIKyOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pseBjJmlwmdp3gX0YC4NWaw/LjBDn3aC4WSTsDcQXwur20jU1atOK2upESVKmfDJmxcoSgCO61TJ9SUhSa6pKUh/55aKrHL0+x7Ywr/mXA5eYYA8TVpilPwvoZ+CP+3EJkIKpkGYO84VPNHHjIMb4K0q72ralcObtSR7wZ8aKm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=aXyLxl1L; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="aXyLxl1L"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id E59AC2007CD;
	Tue, 29 Sep 2026 16:49:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790693363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bPUEHERCZ6LDzfLIoin3oQMo59FUmux2pr8dzqcDHSM=;
	b=aXyLxl1LElftUDxMAFOlOqRX0r2jvt0Nu65HaO48rTuFhNEyP2hC5J9bt5SI3YeJ+iqq8b
	MFfONcOoc8BSHmlNT+iZdpdLY1h+hbCzZd0DgC7HNrkQb57eDIHy6B4Jg/D8lhS/q1Ep8D
	lHM14UP8DzTYS7Q1ATi1+itFIweDkr86fCVNaowWn30WQit18ovJHGUF3Mbc8iF1HXrO8c
	0ajvOgWh78WejjpfybXZP0hloEtBMnORawFdkEU6hqUEOPlaljvhor5JA0ImlQsMAQ3NXO
	5yJdD/Wk3XrKmuetcrMfX2GSTGXV+TBeaQMXG2hHjnZC4FMQYq+xGuEixTVi8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790693363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bPUEHERCZ6LDzfLIoin3oQMo59FUmux2pr8dzqcDHSM=;
	b=Y/YwporjMwqvNKm0seNf+EaYRV9NaSZrfoHTkqvuYsctH+0RXH/Jstz9tkEAq74zwH425l
	z+z0q3gPc853E/oaF+T2zxZ7frSOwgnHWLCzbrRgZlxZOHTrEBXgII9IX/P1HOUVhnEB79
	jobsaEQesAEgJ3DMOz+p7DZXwEywjI8pf4xhnPrkSdmN+c9dkLscdX4uoqNXpzNxuMRpiP
	U3WK7LQdsqZ4Q9YtY0CSg6wKKwu+G462wDCHE1oMqF/iWkciaJTMwS4W1KEqRff/F9BRJ+
	OGle59X8GymhqzoMOig7/OlDx4u7Xq19apV7pCmEDZte1EXPGnhwrMqcPavuSw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790693363; a=rsa-sha256;
	cv=none;
	b=CkZraLE1oRMDRSCpvi+ry3BTDxPdbJFfe9Ec0h3aeX846jcaxCjeX+nkNht/r86k+LT51l
	XCSqd13qWiFPf6PgzELm9e5E2yhYSgsZyStFUHCINIhc+3HLoOZw5WQ3ZffPdNjBFgzTqk
	EbVSMHie6zsuhOahwjhc2h8j0j2XfZJjgyWrOh++hnqay7ueKj/W87eY/rCvE5+zeB3uTY
	0DTA7VB60i12/bDqSbj0KS/9evZuI9DyHYFFgT5dz78gXqf4Jvaxbmw5CNcOILKfm0hN8Q
	/wytvfa71jfbF2ZrGVA0+L7xCEFaLUIIgbODJIJFZfUHfLf/luwdtRF/SnNbkQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBZ91-003PNQ-2f;
	Tue, 29 Sep 2026 16:49:23 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8863B5B4988;
	Tue, 29 Sep 2026 14:49:23 +0000 (UTC)
Date: Tue, 29 Sep 2026 16:49:23 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Chris Strong via B4 Relay <devnull+chris.strong.flocksafety.com@kernel.org>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Thomas Kopp <thomas.kopp@microchip.com>, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chris Strong <chris.strong@flocksafety.com>
Subject: Re: [PATCH net] can: mcp251xfd: flush RX offload queue during long
 IRQs
Message-ID: <20260929-intrepid-hopping-ibex-f5349c-mkl@pengutronix.de>
References: <20260922-upstream-can-rx-offload-batching-v1-1-099e7ca12c91@flocksafety.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gnihgytx26xrye4l"
Content-Disposition: inline
In-Reply-To: <20260922-upstream-can-rx-offload-batching-v1-1-099e7ca12c91@flocksafety.com>


--gnihgytx26xrye4l
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net] can: mcp251xfd: flush RX offload queue during long
 IRQs
MIME-Version: 1.0

On 22.09.2026 00:01:06, Chris Strong via B4 Relay wrote:
> From: Chris Strong <chris.strong@flocksafety.com>
>
> Under sustained receive traffic, the threaded interrupt handler can
> continue draining the controller indefinitely. Received SKBs accumulate
> in skb_irq_queue, but can_rx_offload_threaded_irq_finish() only splices
> them into the NAPI-visible skb_queue when the handler finishes.
>
> The RX-offload overflow checks inspect skb_queue rather than
> skb_irq_queue. If the handler does not return, the IRQ-local queue can
> therefore grow without bound while NAPI remains unscheduled. This can
> exhaust memory and prevent received frames from reaching the networking
> stack.
>
> Add a small RX-offload predicate that reports when the IRQ-local queue
> has reached the NAPI weight. Use it to stop the dedicated RX interrupt
> loop, process TEF and the other pending interrupt sources, and then
> publish the batch. Publish additional batches from the main interrupt
> loop while the controller remains busy. Since one RX pass can enqueue a
> complete hardware ring, this keeps each splice near the NAPI weight
> rather than enforcing a strict limit.
>
> Keep this policy in mcp251xfd because its controller-draining loops are
> the source of the unbounded handler. Accounting for skb_irq_queue in the
> generic overflow check would cap memory use by dropping frames, but
> would still leave NAPI unscheduled.
>
> Publishing smaller batches narrows the timestamp sorting window.
> Ordering across batches is already best-effort; RX and TEF events from
> each controller-status pass are processed before the batch is published.
>
> Fixes: c757096ea103 ("can: rx-offload: add skb queue for use during ISR")
> Assisted-by: LLM
> Signed-off-by: Chris Strong <chris.strong@flocksafety.com>
> ---
> Hi all,
>
> This is my first upstream Linux kernel patch submission, so feedback on b=
oth
> the implementation and the submission format would be appreciated.

You're using b4, this is a good choice and the best tool for this job.

Please split the changes into 2 patches, first add the rx-offload
helper, then the mcp251xfd changes.

The changes look pretty good to me! Good Work!

If you want to improve you can shorten the patch description. The
subject already states what you do, the patch description should explain
in more detail (if needed) and why. Finish with describing your changes
in imperative mood. See [1] for details.

[1] https://github.com/torvalds/linux/blob/master/Documentation/process/sub=
mitting-patches.rst#describe-your-changes

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--gnihgytx26xrye4l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCarvP8QAKCRDMOmT6rpmt
0uauAQC2PcALnd2PIzvRWvzVO0xtfBqU+ewwvy6Q88UdXtA4VwD/Zq3jdiG+BMH4
x8+FL5fgQPIEMSlRKwyXFhrCvPr+rQw=
=J1qn
-----END PGP SIGNATURE-----

--gnihgytx26xrye4l--
