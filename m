Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793721725;
	b=j497ILxYQwW0ALP0qPElz/dzXuEAFMQnah/cIHRNZkk0RDkYE53Yw7wdm/TJNFpz9vGY
	 a9rr2/gzAKgBPtsscb9H2WwnzvjAF1MUk4leMcCf7ayHC+nCuoDSjWXdzpoxPyjE3WPNK
	 leKFdJWvWjqvIAPcTOL09l0ib2fr2rB8bNYQCA+YEhLFb+K/SGb8JKOos3APhs5CuzHsL
	 f4uP0tvjiQEgNYg44/G0pxYLPB4hW9pUv4jEhbylwfhDLxI0nz83iBaJPdy6axoFTnifs
	 SYUIzyBHTan5rbV2TEa/N4avL6pWHv/oHN7vR3QRFmKMRsE6SNllgbz6z1vIkEjH1Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793721725;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=j0lenUjUanC4Vq4EfJKW/Tw9JYBe2kfBDyhLqYlPYxg=;
	b=MN9EwWRMilzsYGI4TzFrjbcwzlv4jFbi54sE2A0p7J1Lwf0IThFoYv+8AP/aU06JjcKh
	 ZQ/386bdj4VpbRQjZFUUnLHMygv+TvzdExcKsOaX/DFfRaCerZc/payKLE03Ce/Udx8+A
	 LBeCDlj1fQmCAWjgNFk8vsMDaagJDBf/J+iO9xDZi21RBK7c/su1e31obcSJva9xt0pnq
	 jknjU62OY5yEPMZGvazKabMxif6W+vLSATwuiQoL5u0cd8bV24zTGW0S1n7Sh+RLcFZLh
	 ZP7jx9c6sej4NWF+bRviyYtY4QQH3DvrkoSwYCiIk1MQDUxN01EO7L42T0q7SgNaLZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=BotFruBx;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=5eIHS+v8;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB4C606A327
	for <linux-can@vger.kernel.org>; Tue,  3 Nov 2026 16:02:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FB4C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=BotFruBx;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=5eIHS+v8
Date: Tue, 3 Nov 2026 17:02:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793721722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j0lenUjUanC4Vq4EfJKW/Tw9JYBe2kfBDyhLqYlPYxg=;
	b=BotFruBxRw69zgf1dztgAvIsEwE0Brs40QvJcftAC8XsPWTrzleX9DqsZNbM/939K+zQhp
	7FzvjCSiC0TNPd+agrPIoH6izX0u3xoHzf+noGk7bpoA0b/U1OJDe0BLV/3eHK+mUpTNEQ
	oUU1UdF+sSFroIySs8PrFCXRWeeAqWUitQ0h33E9cW1xvdOLhMltKnZ8Z2tf6aOsJ6nmV4
	+xhL3IaU6XkWM0ea2jDY24UzMouZ30ZO+a7JSwrfV1dFxPnI70wJiWk+eplwSI7iCO/FFf
	ZrDCvnx2aOTJdmufvOCpz8QWPA5CKfNmCsy8RXK5Ahb6nOWTg81YYSDmVw9ZWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793721722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j0lenUjUanC4Vq4EfJKW/Tw9JYBe2kfBDyhLqYlPYxg=;
	b=5eIHS+v8c2InDb1slrOOgdrHTSmm5QGlb3QVTHWD/BEp8f6c6ZQoZFM75w+5QexhWESUx7
	YNl6/9k1GCFscMCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
	Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v12 7/7] can: proc: remove pointers from CAN specific
 proc output
Message-ID: <20261103160200.9JXGkEtP@linutronix.de>
References: <20261027-can-rx-lock-v12-0-eb5afc2d8b9b@hartkopp.net>
 <20261027-can-rx-lock-v12-7-eb5afc2d8b9b@hartkopp.net>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261027-can-rx-lock-v12-7-eb5afc2d8b9b@hartkopp.net>

my patch got merged in the meantime and should pop-up in -next tomorrow
   https://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git/commit/=
?h=3Dfor-7.5-vsprintf-kallsyms&id=3Dfd23f3c2a67c0a9d6fa78fb4f03b7d9c509984a8

This means, as of today, depending if aim for v7.4 or v7.5=E2=80=A6

On 2026-10-27 15:31:11 [+0100], Oliver Hartkopp wrote:
> --- a/Documentation/networking/can.rst
> +++ b/Documentation/networking/can.rst
> @@ -1038,21 +1038,25 @@ procfs content
> =20
>  As described in :ref:`socketcan-receive-lists` the SocketCAN core uses s=
everal filter
>  lists to deliver received CAN frames to CAN protocol modules. These
>  receive lists, their filters and the count of filter matches can be
>  checked in the appropriate receive list. All entries contain the
> -device and a protocol module identifier::
> +CAN network device, the filter (can_id/can_mask), the number of filter
> +matches, the inode number of the subscribing socket and the name of the
> +receive function. A sock_inode of 0 denotes a kernel internal subscriber
> +without a socket (e.g. CAN gateway or J1939). When the function name can
> +not be resolved (e.g. with CONFIG_KALLSYMS=3Dn) "(unknown)" is printed::

it will print a hashed pointer instead "(unknown)". I suggest you strip
that sentence because you rely on %ps implementation (more later).
=E2=80=A6
> --- a/net/can/proc.c
> +++ b/net/can/proc.c
> @@ -202,30 +202,36 @@ static void can_print_rcvlist(struct seq_file *m, s=
truct hlist_head *rx_list,
>  			      struct net_device *dev)
>  {
>  	struct receiver *r;
> =20
>  	hlist_for_each_entry_rcu(r, rx_list, list) {
> +		char symcheck[4];
>  		char *fmt =3D (r->can_id & CAN_EFF_FLAG)?
> -			"   %-5s  %08x  %08x  %pK  %pK  %8ld  %s\n" :
> -			"   %-5s     %03x    %08x  %pK  %pK  %8ld  %s\n";
> +			"  %6s  %08x  %08x  %8ld  %10llu" :
> +			"  %6s     %03x    %08x  %8ld  %10llu";
> =20
>  		seq_printf(m, fmt, DNAME(dev), r->can_id, r->mask,
> -			   r->func, r->data, atomic_long_read(&r->matches),
> -			   r->ident);
> +			   atomic_long_read(&r->matches), r->ino);
> +
> +		/* %ps falls back to the raw text address when the symbol
> +		 * can not be resolved (KALLSYMS=3Dn, stripped module symbols)
> +		 */
> +		snprintf(symcheck, sizeof(symcheck), "%ps", r->func);
> +		if (strncmp(symcheck, "0x", 2))
> +			seq_printf(m, "  %ps\n", r->func);
> +		else
> +			seq_puts(m, "  (unknown)\n");

This can go and please just rely on %ps in the former seq_printf().

There was a discussion whether a function pointer should return
"(unknown)", a hashed pointer or the actual pointer and in the end it
was agreed that the hashed pointer wins because one can compare against
other hashed pointer to check if it is the same function or not.
I would appreciate if the behaviour is the same in the kernel and CAN is
not an exception. If this is intended for v7.4 then keep it as is but
please send a follow-up for v7.5.

>  	}
>  }

Sebastian
