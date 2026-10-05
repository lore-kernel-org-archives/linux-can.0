Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C3247D93B
	for <linux-can@vger.kernel.org>; Mon,  5 Oct 2026 11:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791198418; cv=pass; b=cGUYS8sWqMnLxjNn7+boBRkiXb1JfKoiCpdtbacQOEkKbkT9WCyofpzYCnetr+ABmM4h1MbG39KWh29jMP9iRdeONEXbfQmeWG2cG6E8puXqJn+CiY637tGUP6EWgVYY0LDymnc9guaoKRcMPkPjfnRCq2MamB8SLKS7Cu/ZSAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791198418; c=relaxed/simple;
	bh=KoJkHMuVTnmpwhdf/1IPPjijuPBDWHBkWl5mz6dwJi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDWmvB18t4sqNjnrBpkkzvRIiXUct6IppzcHbE8bQTOM5wbsEhoD5JLIwudsr/EkSg9h/YSiMjvtYAfLqmCp29Fh7Y+VS6GjyJJEDFgnPfMmIlRHUFzWwkS58ovUEGZES9BrzEx4TsTsJP8eEGwN3Dn1YIgK/NJVdlpDLu1Wz9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Mq9ro8ks; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Mq9ro8ks"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 119F92018A0;
	Mon, 05 Oct 2026 13:06:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791198407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0oyf+HRqyeuexg9Sx+ronyu4les9WMUZE472/GXp2NM=;
	b=Mq9ro8ks+UPfNF046pdOgo0g5I7QRXeJi7niyZoWReALdatMcxw3R+NLIprzcDgH+cvLfh
	uF4yXw2m/fjB1NB7tIQ3BPsIYKBowbuyKfPoxgtuWrBmnjgmcCaKcnUP45Mm2/4DkpLaFg
	lRyg1jfTwCB5CrgYz9ZGTrwUevBMW5CA6iFys//GkswbMzFjBdx4bAzztdsHW/vEOEhqJv
	5ZJPSpf73yXxm7yZwW6bWKOZyVsQg47a4LqQoyWMD2eZQRxWQOo6GMZf9MBouhB4MZgjG5
	ftitKm25Ke0lNAMfMmTR4fGxlHeLooq/6o9pyBJ3JXWg2m3cPWNTrTvEEgn2Ww==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791198407; a=rsa-sha256;
	cv=none;
	b=W51E1zrBkKK/KMN4L1zBRU4zjKXtURv7pWc8chjJkxGxXFORcMj1T1s6nzy4u4a7gYg/39
	rwflSXm08ccJKva47XWrchmbJhG4B16U1XYjx3O1deExk3GZwGV32DPD0+N+eeZkjQ44zb
	vu1VxVGg06+3lWBWN2qzpCXqKSm+yNQFVndry7zdUxIaOjRP2IKJx6EpmjbuX1WJlR6g0h
	rP3ly1FrGTo3YzRcqU2xFtzATy14s1TkiN/pdQR9F7rMYM5/CPCv8kT8NxytqBNNF3QOpp
	JtOJDOa3MwvdKhkUADiQYiWeo/XpaNIZ0MVyybpRVtgfyyUMoC6sEyLyNdIx6w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791198407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0oyf+HRqyeuexg9Sx+ronyu4les9WMUZE472/GXp2NM=;
	b=Qg7V9EN0w5FbQdeDLnD7LFbtdX6jfSCWdhjmvBODyBa7/OZWRw0b+B2V7QgW5E0VXXE0z/
	jdErHhG9Vat0HS2EKCYmGklABLwcxtqkmckmSODG+jOTXm5MvjTI+e1qsudkeE8IQKAK/s
	nIKjVZ4CtxUE6GOzzame7oa2idp6AEtNE05XHJk8qEU2RKbjQPgomfWkhOdYW7jC73V3uN
	wrDZHwYa7bS4zyB4HMl6UiFbZwlMwMjO+esuRTalTRxv6ZWcJu8Y96RoBNxuLeb2Ir+jRZ
	dFu+VbPR5pm2/oXe7rGTgeliZX/WILN6RasTnh+u/7QebBSO5Vms0cH7ZpvPvQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xDgWs-004NFg-33;
	Mon, 05 Oct 2026 13:06:46 +0200
Received: from pengutronix.de (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8B6E15BA12B;
	Mon, 05 Oct 2026 11:06:46 +0000 (UTC)
Date: Mon, 5 Oct 2026 13:06:45 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: sashiko-bot@kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] can: rx-offload:
 can_rx_offload_threaded_irq_flush(): add newfunction to be called from
 within loop of threaded interrupt handlers
Message-ID: <20261005-warm-just-vole-1100ce-mkl@pengutronix.de>
References: <20261005-upstream-can-rx-offload-batching-alternative-v1-0-4c08ccb516ec@pengutronix.de>
 <20261005-upstream-can-rx-offload-batching-alternative-v1-1-4c08ccb516ec@pengutronix.de>
 <20261005105308.878221F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mhgiotgyaxsqg3nw"
Content-Disposition: inline
In-Reply-To: <20261005105308.878221F000FF@smtp.kernel.org>


--mhgiotgyaxsqg3nw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC 1/2] can: rx-offload:
 can_rx_offload_threaded_irq_flush(): add newfunction to be called from
 within loop of threaded interrupt handlers
MIME-Version: 1.0

On 05.10.2026 10:53:08, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] can: stale flush_len causes skb_queue.qlen underflow and permane=
nt packet drops
> --
>
> commit eec89aef49a7f405effd6fda359db0f458f6f4df
> Author: Marc Kleine-Budde <mkl@pengutronix.de>
>
> can: rx-offload: can_rx_offload_threaded_irq_flush(): add newfunction to =
be called from within loop of threaded interrupt handlers
>
> This commit introduces can_rx_offload_threaded_irq_flush() to prevent
> unlimited growth of the IRQ skb queue during heavy load. It partially flu=
shes
> skb_irq_queue to the NAPI skb_queue when it reaches 3/4 of its maximum
> capacity. A portion of the elements are left behind to accommodate older
> out-of-order CAN frames.
>
> > diff --git a/drivers/net/can/dev/rx-offload.c b/drivers/net/can/dev/rx-=
offload.c
> > index 46e7b6db4a1ef..9f494ab7561ef 100644
> > --- a/drivers/net/can/dev/rx-offload.c
> > +++ b/drivers/net/can/dev/rx-offload.c
> [ ... ]
> > @@ -349,6 +351,90 @@ void can_rx_offload_threaded_irq_finish(struct can=
_rx_offload *offload)
> >  }
> >  EXPORT_SYMBOL_GPL(can_rx_offload_threaded_irq_finish);
> >
> > +/**
> > + * __skb_cut_position - cut a skb list into two
> [ ... ]
> > + */
> > +static inline void __skb_cut_position(struct sk_buff_head *list,
> > +				      struct sk_buff_head *head,
> > +				      struct sk_buff *entry,
> > +				      __u32 qlen)
> > +{
> > +	struct sk_buff *new_first =3D entry->next;
> > +	struct sk_buff *first =3D head->next;
> > +
> > +	WRITE_ONCE(list->next, first);
> > +	WRITE_ONCE(list->next->prev, (struct sk_buff *)list);
> > +	WRITE_ONCE(list->prev, entry);
> > +	WRITE_ONCE(entry->next, (struct sk_buff *)list);
> > +	list->qlen =3D qlen;
> > +
> > +	WRITE_ONCE(head->next, new_first);
> > +	WRITE_ONCE(new_first->prev, (struct sk_buff *)head);
> > +	head->qlen -=3D qlen;
>
> [Severity: High]
> Could this lead to list->qlen undercounting the elements passed to NAPI?
>
> If an older out-of-order CAN frame is inserted into skb_irq_queue before
> offload->flush_skb after flush_len has been cached, the physical list
> splice moves more than qlen elements up to entry. Statically updating the
> length counters using the stale qlen will cause an eventual underflow in =
NAPI
> dequeue.
>
> > +}
> > +
> > +/**
> > + * can_rx_offload_threaded_irq_flush() - partially flush the rx_offloa=
d queue
> [ ... ]
> > + */
> > +void can_rx_offload_threaded_irq_flush(struct can_rx_offload *offload)
> > +{
> > +	struct sk_buff_head tmp_queue;
> > +	unsigned long flags;
> > +	u32 irq_queue_len, queue_len;
> > +
> > +	irq_queue_len =3D skb_queue_len(&offload->skb_irq_queue);
> > +	if (irq_queue_len < offload->skb_queue_len_max / 2)
> > +		return;
> > +
> > +	if (!offload->flush_skb) {
> > +		offload->flush_skb =3D skb_peek_tail(&offload->skb_irq_queue);
> > +		offload->flush_len =3D irq_queue_len;
>
> [Severity: High]
> Is it possible for the number of elements preceding the tail to change af=
ter
> being cached here?
>
> The commit message mentions that older out-of-order CAN frames may arrive=
 from
> independent mailboxes and be sorted into skb_irq_queue. If an older frame=
 is
> subsequently received, it would be inserted before flush_skb, physically
> increasing the number of elements before flush_skb to flush_len + 1.
>
> > +	}
> > +
> > +	if (irq_queue_len < offload->skb_queue_len_max * 3 / 4)
> > +		return;
> > +
> > +	__skb_cut_position(&tmp_queue, &offload->skb_irq_queue,
> > +			   offload->flush_skb, offload->flush_len);
>
> [Severity: High]
> Does passing the stale flush_len to the slice operation hide out-of-order
> inserted frames from queue length accounting?
>
> When __skb_cut_position is called, it physically moves flush_len + 1
> elements into tmp_queue, but assigns tmp_queue.qlen the stale flush_len.
> After splicing, skb_queue receives flush_len + 1 elements but its qlen
> only increases by flush_len.
>
> When NAPI dequeue consumes all elements, skb_queue.qlen would drop below 0
> and underflow to 0xFFFFFFFF. Since this exceeds skb_queue_len_max, would =
all
> future frames be permanently rejected with -ENOBUFS?

I see 2 options:
- update __skb_queue_add_sort to update offload->flush_len if needed
- skip __skb_cut_position() + skb_queue_splice_tail_init() altogether
  and move/sort one element by one from the skb_irq_queue to the
  skb_queue?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--mhgiotgyaxsqg3nw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCasOEwwAKCRDMOmT6rpmt
0pPmAP9+ouf9Gdi2d7hR/ofxpJfPN2Gy9HA4/uwWbAvGIy6VogEA/jx3ju8LJ9t8
djYqQCbNfSWHbfFb3/IEhr/zogsw/gM=
=/+pU
-----END PGP SIGNATURE-----

--mhgiotgyaxsqg3nw--
