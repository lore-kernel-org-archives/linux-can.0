Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795080751;
	b=4W1urIbOkaYOWc8txAn0uzwBFjKeGQv/J5vEu3hF8amxyabw28XCwM7wV/SE9tOVSOty
	 Q52xjMnzs/dCjNiEmtfH+QCUkgOHzjDfmJ99KMNcKE9D4MSQfsbz2Rv2N+h17hiqQQgwY
	 24B+HBVs2VIMesnPglnV3q4N+6oQT8Fof05G1IwhGb3n27p7w/+YTgzn93PxSe++ofc9s
	 SbZ6NM/JBsimyrUwkGe8ujq6USBTDoTDgf30tBl5DF4ric+YL7+gwNvrUd58hW9a79h3O
	 Y05W/Bu7w87edz6/N4Swi7LSF7lqiW+f6lYTEOlpkQS1etfVstFTLY6Qo6aCxZ709pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795080751;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VLBjx/M4f/CXYHrDMbrhUZMeJtsaGrzScOG8FVHjYeg=;
	b=OUTpJLqnAdEQtB2gh8eQeljEA9wF+AnrL3KDOejBdAQSOPQaJ2/V5wFF0nns/tj0I0rV
	 Ufc7kyM/lGh3nwfFftjLqYbnkyTUJcxu0H5lmrltVw3vNo36qwuQyjpeYvE+a80dTlpEn
	 EznAHkUvwQuh6lUmoOWdYT/3RJD+HdmJvfNgcRUTGauCwFcTmSk2bRNA23F0a8TQV5klc
	 g5oHlmorKao8c3ZAZ1J7s7qd9tQwoDRxqqHAOUJ351LP1qsjf2CBzdZvuk60pdaAhPQOw
	 1unn78NTpy37AycvadcfV6FCGso2MSrEy7+SSQrJLYwyMN9jfMtv+EmAJsFfQqo+5Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MI01AjAl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7514606A330
	for <linux-can@vger.kernel.org>; Thu, 19 Nov 2026 09:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MI01AjAl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AAAF1F000C5;
	Thu, 19 Nov 2026 09:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795080751;
	bh=VLBjx/M4f/CXYHrDMbrhUZMeJtsaGrzScOG8FVHjYeg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MI01AjAlElZc8yJsLQ2yZhBsNqn+GpbzzfC+3b+4K0EiZ2y+88p8HdYDaTV48gzJj
	 oNsLah3zEh9uAVeR0UcHFrIBScgtf5bj8oZY/KPKVJaWdtLwv1gSnll7FD4Y4IHAam
	 VqbQKuhuAwrP97920Xg+E4PurADyblLr0R/efMqd7tfFkFw7lsn3/9x67hbzFaPVPP
	 wSivwgOEv/RUVEUFEcGXROO/ELxTMy4rItPdBREUS2UEYgijJXaDEiDagmA+YUhXpL
	 u1rmmHiiBaXUsUz1bkN79pg30RfWUG8vjuFQyqcAqn+C0TjLj2awbKUkTrVQDCmQ1N
	 iK6JxT65y9Rzg==
Message-ID: <sashiko-outbox-222854@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 12/12] can: xilinx_can: set CAN FD flags on
 received frames
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261118092955.1283165-13-mkl@pengutronix.de>
References: <20261118092955.1283165-1-mkl@pengutronix.de>
 <20261118092955.1283165-13-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 09:32:30 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] can: xilinx_can: uninitialized data leak in xcanfd_rx() [1]
--

commit d0681f7cdc97d2a1c4872665c855ad2b34da35d9
Author: Maximilian Zimmermann <maxz@spacecubics.com>

can: xilinx_can: set CAN FD flags on received frames

This commit adds the ESI register mask and sets the CANFD_BRS and
CANFD_ESI flags in struct canfd_frame when receiving CAN FD frames.

Link: https://patch.msgid.link/20260921-fix-xilinx-canfd-flags-v1-1-a371c90=
b4e7c@spacecubics.com

> diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
> index 43d7f22820b88..52661e0882054 100644
> --- a/drivers/net/can/xilinx_can.c
> +++ b/drivers/net/can/xilinx_can.c

[ ... ]

> @@ -959,6 +960,11 @@ static int xcanfd_rx(struct net_device *ndev, int fr=
ame_base)
> =20
>  	/* Check the frame received is FD or not*/
>  	if (dlc & XCAN_DLCR_EDL_MASK) {
> +		if (dlc & XCAN_DLCR_BRS_MASK)
> +			cf->flags |=3D CANFD_BRS;
> +		if (dlc & XCAN_DLCR_ESI_MASK)
> +			cf->flags |=3D CANFD_ESI;
> +
>  		for (i =3D 0; i < cf->len; i +=3D 4) {
>  			dw_offset =3D XCANFD_FRAME_DW_OFFSET(frame_base) +
>  					(dwindex * XCANFD_DW_BYTES);

[Severity: Critical]
This problem wasn't introduced by this patch, but can the payload copy
loops in xcanfd_rx() and xcan_rx() leak residual hardware register bytes to
userspace [1]?

alloc_can_skb() and alloc_canfd_skb() zero-initialize cf->data, but both
receive paths write full 32-bit words into cf->data:

drivers/net/can/xilinx_can.c:xcanfd_rx() {
	...
		for (i =3D 0; i < cf->len; i +=3D 4) {
			dw_offset =3D XCANFD_FRAME_DW_OFFSET(frame_base) +
					(dwindex * XCANFD_DW_BYTES);
			data[0] =3D priv->read_reg(priv, dw_offset);
			*(__be32 *)(cf->data + i) =3D cpu_to_be32(data[0]);
			dwindex++;
		}
	...
}

When cf->len is not a multiple of 4 bytes, the final 32-bit store
overwrites the zeroed trailing padding with leftover bytes from the
hardware register, which are then copied to userspace on raw CAN socket
reads.

[1] https://sashiko.dev/#/bug/linux-32f289b3-a2b0-4d94-a883-7cfaa1d3ff70

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118092955.1283=
165-1-mkl@pengutronix.de?part=3D12
