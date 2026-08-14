Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F35212542;
	Fri, 14 Aug 2026 13:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786715574; cv=none; b=aJsh+VUukw6jVkDCjl4VO/knuBOumK6Ty8hvWKD8gPBQIS5YvbdKWjtyQr6kI4Po1YenE+TQA3HTsML604YIMzPvslHhxq/Z1gKY9U7wQRrqV7vbDjdZOSRhqrDA0Ls48R2DL4KRyO5ElbG6qXQ9yu2ykv0BLe/HP+Udj6QYd/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786715574; c=relaxed/simple;
	bh=wPXoqhzSaxAzjhZkCdbQ58rnhOZSWUc8IWKgR9+pLvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tU/uzWPMbTV+ycUvHZautw2bgL/vQPqVD+f9RUT/rOyCXYYbGF0P2L45jYhPdzkWQ+EqnWmbtQxplW8AF8UVXteUba7c7z3oUidoIMK9oAqW4GSflEq08UU6XVmcpiEg65LOKJ86XUWM0s/3bpJq4yPNouNjIaZnXv/PS554VQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YaYoHRw9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z8mKd+5w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YaYoHRw9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z8mKd+5w"
Date: Fri, 14 Aug 2026 15:52:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786715570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=76XUJ71ry8h8hl+4GuXYm+aO5XM9sE7Y4Jg5AzH8Gow=;
	b=YaYoHRw9gAz/UXX1gEwRzT7Nb/yua1p6Wzb5We5INfKig3Kq0mzB35wiv04/VY2oYS0CYK
	vka9NRL2Y1odVuIyM8mnUhC1DV6q+p8glZwOQlAtUk+R6OKM7SXsNcja+agwAIUSUkAbYM
	2Empx1EHBf5/6hB0z6Mp+p/Uc3IwcTFYxM/M5YjOSojmrZAtW4NV8JutId1CZbUSYzaK7b
	LPsJI8QA6Q8plcA9m7bTF6iNadBj/PAE9wRuIxMkFZYsP0w7daPTKQQhnp2UrpZ0unqccO
	CROfV1BW4jZvUTMZ7tR2pwmcZfNAOhP+PHvrumEyqJlraXDiidh/fn9sef7ZWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786715570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=76XUJ71ry8h8hl+4GuXYm+aO5XM9sE7Y4Jg5AzH8Gow=;
	b=z8mKd+5wGIZE0JqR5MeoYWkY38sJGMytV3E/vf5NLVc9zxKOJg69A0iIDOFk2KzRbXKprj
	E1DBt/tmwu6lXJAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [can-next] can: proc: remove pointers from CAN specific proc
 output
Message-ID: <20260814135248.OO4H1uIt@linutronix.de>
References: <20260814105438.49657-1-socketcan@hartkopp.net>
 <20260814123141.opZ1ZwYC@linutronix.de>
 <7b538342-0914-409c-a679-87a567d4150e@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7b538342-0914-409c-a679-87a567d4150e@hartkopp.net>

On 2026-08-14 15:36:03 [+0200], Oliver Hartkopp wrote:
> > > --- a/Documentation/networking/can.rst
> > > +++ b/Documentation/networking/can.rst
> > > @@ -1040,19 +1040,19 @@ As described in :ref:`socketcan-receive-lists=
` the SocketCAN core uses several f
> > >   lists to deliver received CAN frames to CAN protocol modules. These
> > >   receive lists, their filters and the count of filter matches can be
> > >   checked in the appropriate receive list. All entries contain the
> > >   device and a protocol module identifier::
> > > -    foo@bar:~$ cat /proc/net/can/rcvlist_all
> > > +    foo@bar:~$ cat /proc/net/can/rcvlist_fil
> >=20
> > Is this _fil a typo?
>=20
> No, it's a slightly different example.
okay then.

> > > diff --git a/net/can/proc.c b/net/can/proc.c
> > > index de4d05ae3459..b7858fb66178 100644
> > > --- a/net/can/proc.c
> > > +++ b/net/can/proc.c
> > > @@ -189,30 +189,35 @@ static void can_print_rcvlist(struct seq_file *=
m, struct hlist_head *rx_list,
> > >   			      struct net_device *dev)
> > >   {
> > >   	struct receiver *r;
> > >   	hlist_for_each_entry_rcu(r, rx_list, list) {
> > > -		char *fmt =3D (r->can_id & CAN_EFF_FLAG)?
> > > -			"   %-5s  %08x  %08x  %pK  %pK  %8ld  %s\n" :
> > > -			"   %-5s     %03x    %08x  %pK  %pK  %8ld  %s\n";
> > > +		char *fmt;
> > > +#if IS_ENABLED(CONFIG_KALLSYMS)
> >=20
> > Please don't. I fix %ps and then there is no leak. There will be then
> > the 0 and everything will be fine.
> >=20
>=20
> I can wait for your changes before the v2 posting.
>=20
> Btw. do you think "0" is a good return value, when people expect a functi=
on
> name?
>=20
> What about "(unknown)" or something similar?

Yeah, that '(unknown)' looks slightly better.

> > > +		fmt =3D (r->can_id & CAN_EFF_FLAG)?
> > > +			"  %6s  %08x  %08x  %8ld  %016llx  %ps\n" :
> > > +			"  %6s     %03x    %08x  %8ld  %016llx  %ps\n";
> > >   		seq_printf(m, fmt, DNAME(dev), r->can_id, r->mask,
> > > -			   r->func, r->data, atomic_long_read(&r->matches),
> > > -			   r->ident);
> > > +			   atomic_long_read(&r->matches), r->ino, r->func);
> > > +#else
> > > +		fmt =3D (r->can_id & CAN_EFF_FLAG)?
> > > +			"  %6s  %08x  %08x  %8ld  %016llx  (unknown)\n" :
> > > +			"  %6s     %03x    %08x  %8ld  %016llx  (unknown)\n";
> > > +		seq_printf(m, fmt, DNAME(dev), r->can_id, r->mask,
> > > +			   atomic_long_read(&r->matches), r->ino);
> > > +#endif
> > >   	}
> > >   }
> > =E2=80=A6
> >=20
> > So if you do this now, then I probably should remove that hunk from my
> > patch.
>=20
> IMHO these /proc/net/can changes go far beyond replacing the pointer valu=
es
> with "0".
>=20
> I hope the
> Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> is ok for your attribution?!?

That is fine. I just mean I should drop that hunk and repost to avoid
the pointless collision here.

> Best regards,
> Oliver

Sebastian
