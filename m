Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D8744BC87;
	Fri, 14 Aug 2026 12:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786710707; cv=none; b=A+HcEITNIgc0fERFPdvZmIvQS47304T5gWSVKvxxyankBS9wc2YWkXyth+fnWktyPUo23dbcYiaOneaRUBYkNC7OIuPEFDNPgigEEqcZB4fpW9BGVexd/VZh8bi2RtTJnMjNlgke2hP3y4fHull/k0F1L2+PBGkAU3chzBY+CXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786710707; c=relaxed/simple;
	bh=xk0cP6G0Olm4ctR0A9rAJrc0qZQMQQVe/WakGt9JJd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nunhCV9Z/NSSnwvdV7tO4k899Nfo401fp7YnGCPYS/7geDd1sLkjdcDdYaWqQnW2GrZnPB4vOiTdJlCA5LCRKn4B/Q+Ce2P7FZnkjN10u6vUGb+23gCYtGdca54BfyRZRua6lXKunQZvm6YsJM+ScABt8Wyaud1iLgeRB+hDm64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=htMb5fBq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MkU21qEP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="htMb5fBq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MkU21qEP"
Date: Fri, 14 Aug 2026 14:31:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786710703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7q2YiWr34ORh103g7lswThMsgQ7+8htnnKNASOY82Vo=;
	b=htMb5fBqMdiIlrZEf2n+66Ei/DTaBbiNJEw8+0et2hQhs3YQAv89Qh4MJ9nzzprPwrnxxA
	pKxnPXFHB3BDNRHLyTugdMfxfwyj4Q+fsd76Abecb6u/wihJdoZps6toqv389jxyEfUtO0
	xvYjXFyOwpkZFBSQdjd/IQc7hIOJG5hIeRPwV0otD5lM6PYw8pjje+g9kP0fTr/dFSxJet
	+tuuYuDg76JgLwW4fFDjFqwO4+oXhiNwTdttF72tDwyxlgx9nNsIg7vvq/QYxumLqqtrmp
	lKy/qIGdnw8t+hfygJony6xYwTKHi/MwzUXFggM07piizV90XVBmg7i/ByzafA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786710703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7q2YiWr34ORh103g7lswThMsgQ7+8htnnKNASOY82Vo=;
	b=MkU21qEPaN4RHWjVSY/H+pQvaWGK7AzK6VrtYPoPolwNvrgkcQKz4addkbz2sw3GusgsGW
	Pk4P5M0wMklANTDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [can-next] can: proc: remove pointers from CAN specific proc
 output
Message-ID: <20260814123141.opZ1ZwYC@linutronix.de>
References: <20260814105438.49657-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260814105438.49657-1-socketcan@hartkopp.net>

On 2026-08-14 12:54:38 [+0200], Oliver Hartkopp wrote:
=E2=80=A6
> function names and sock inode numbers when available. As there's no known
> tooling around the CAN specific proc output breaking the ABI with this
> rework creates no issue.

I let you be the judge of that.

=E2=80=A6
> --- a/Documentation/networking/can.rst
> +++ b/Documentation/networking/can.rst
> @@ -1040,19 +1040,19 @@ As described in :ref:`socketcan-receive-lists` th=
e SocketCAN core uses several f
>  lists to deliver received CAN frames to CAN protocol modules. These
>  receive lists, their filters and the count of filter matches can be
>  checked in the appropriate receive list. All entries contain the
>  device and a protocol module identifier::
> =20
> -    foo@bar:~$ cat /proc/net/can/rcvlist_all
> +    foo@bar:~$ cat /proc/net/can/rcvlist_fil

Is this _fil a typo?

> -    receive list 'rx_all':
> -      (vcan3: no entry)
> -      (vcan2: no entry)
> -      (vcan1: no entry)
> -      device   can_id   can_mask  function  userdata   matches  ident
> -       vcan0     000    00000000  f88e6370  f6c6f400         0  raw
> +    receive list 'rx_fil':
>        (any: no entry)
> +      device   can_id   can_mask   matches     sock_inode     function
> +       vcan0  80000123  c00007ff         0  000000000000f862  raw_rcv [c=
an_raw]
> +      (vcan1: no entry)
> +      (vcan2: no entry)
> +      (vcan3: no entry)
> =20
>  In this example an application requests any CAN traffic from vcan0::
> =20
>      rcvlist_all - list for unfiltered entries (no filter operations)
>      rcvlist_eff - list for single extended frame (EFF) entries
=E2=80=A6
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -2039,11 +2038,11 @@ static int bcm_connect(struct socket *sock, struc=
t sockaddr_unsized *uaddr, int
>  	}
> =20
>  #if IS_ENABLED(CONFIG_PROC_FS)
>  	if (net->can.bcmproc_dir) {
>  		/* unique socket address as filename */
> -		sprintf(bo->procname, "%llu", sock_i_ino(sk));
> +		sprintf(bo->procname, "%016llx", sock_i_ino(sk));

snprintf() would be a bit bulletproof

>  		bo->bcm_proc_read =3D proc_create_net_single(bo->procname, 0644,
>  						     net->can.bcmproc_dir,
>  						     bcm_proc_show, sk);
>  		if (!bo->bcm_proc_read) {
>  			ret =3D -ENOMEM;
=E2=80=A6
> diff --git a/net/can/proc.c b/net/can/proc.c
> index de4d05ae3459..b7858fb66178 100644
> --- a/net/can/proc.c
> +++ b/net/can/proc.c
> @@ -189,30 +189,35 @@ static void can_print_rcvlist(struct seq_file *m, s=
truct hlist_head *rx_list,
>  			      struct net_device *dev)
>  {
>  	struct receiver *r;
> =20
>  	hlist_for_each_entry_rcu(r, rx_list, list) {
> -		char *fmt =3D (r->can_id & CAN_EFF_FLAG)?
> -			"   %-5s  %08x  %08x  %pK  %pK  %8ld  %s\n" :
> -			"   %-5s     %03x    %08x  %pK  %pK  %8ld  %s\n";
> +		char *fmt;
> =20
> +#if IS_ENABLED(CONFIG_KALLSYMS)

Please don't. I fix %ps and then there is no leak. There will be then
the 0 and everything will be fine.

> +		fmt =3D (r->can_id & CAN_EFF_FLAG)?
> +			"  %6s  %08x  %08x  %8ld  %016llx  %ps\n" :
> +			"  %6s     %03x    %08x  %8ld  %016llx  %ps\n";
>  		seq_printf(m, fmt, DNAME(dev), r->can_id, r->mask,
> -			   r->func, r->data, atomic_long_read(&r->matches),
> -			   r->ident);
> +			   atomic_long_read(&r->matches), r->ino, r->func);
> +#else
> +		fmt =3D (r->can_id & CAN_EFF_FLAG)?
> +			"  %6s  %08x  %08x  %8ld  %016llx  (unknown)\n" :
> +			"  %6s     %03x    %08x  %8ld  %016llx  (unknown)\n";
> +		seq_printf(m, fmt, DNAME(dev), r->can_id, r->mask,
> +			   atomic_long_read(&r->matches), r->ino);
> +#endif
>  	}
>  }
=E2=80=A6

So if you do this now, then I probably should remove that hunk from my
patch.

Sebastian
