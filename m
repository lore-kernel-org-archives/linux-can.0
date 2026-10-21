Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792578034;
	b=FicKcI6gYTZgtED8M13vYpZJxU4v/esnfKcyTVc4zqGLnyEA7eVm4Hw772VbXE36ENOY
	 vFot26H0s58UgV+wg3UwJYgfwaSTE2l5CI5crSXavNHrQIzrhDuyHmjRa6W1pMYPpmvHw
	 jXf2oQ3KEfikqkkTtk4v+ApXclK/TFK3ytCUXQzaBH/SBAQylUZazZ5IanhHIy6fZc4Du
	 eg4B+hYQ814j+N0LGJbiIhXsisMbw0BUxuPtQUJD6bH8i+s2mCfvUx1r+xXW2x4pxgcgE
	 m2a2JLVs+3/1zvfxRAvXklyp5UGNQWkYAuWuPgLz5z+Jwkw+o4PS49Z/jAf6pLqmANw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792578034;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Message-ID:
	 In-Reply-To:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-Mailer:
	 X-Authenticated-User;
	bh=9pFhfcV00oJEJQFN/3lguD9gsSxLp2OeXDi7RJYbI5Q=;
	b=SjR7NSS8d+c8LvnjquqECkF6udwq0TQbYaAigcrzJg8Ga86/k4Ul1cvEQuhBo+N9nghB
	 27Zz1sdeBypZ2hshIFgwFFaZ8QrREYzfRR5vNLQollzHiNPhvmL6IfckItuk5ZyNL43n9
	 816gvqvEzl5DVNOeVVozlQ6Z9EBD5di0syAJVwH7ZwbU7cabo1ba6SB+VBPstfDVzli2u
	 sjD6asAbv77JMKqJx0+3tBvuHisM4o0B45TE6tvQyVw/m50ffMN7/l3tLcWxHIJAl2i50
	 LMkfgHLOupEfMxbudrqXwQX/9IHZCsuIZBmoJnXLbxovHwIqo81UuRkz6f/PKyBiM7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=free.fr;
	spf=pass smtp.mailfrom=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=EhJ0XhV7;
	arc=none smtp.remote-ip=212.27.42.3
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44485606A328;
	Wed, 21 Oct 2026 10:20:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44485606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=EhJ0XhV7
Received: from zimbra65-e11.priv.proxad.net (unknown [172.20.243.215])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 0AC5C13F89C;
	Wed, 21 Oct 2026 12:20:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1792578031;
	bh=UaxqiMpEEGmZ50v/CvqoyOgfJ41T2J5xAaT4f0Fh3wY=;
	h=Date:From:To:Cc:In-Reply-To:Subject:From;
	b=EhJ0XhV75VcmDBYkByTEv5mn5ysqlc6ceqiVXxhhpgHn1Nq5Fn6znjrS5AZZt1sxp
	 bY+ZfgLHkbMIVBeIxdkj4HxBUjXjdg0CaNX6WXmfmbvMMBabbzA72ecK1ovVUYhfct
	 tUHrawYSyA9SaGo7s2kVvxgrJTv01FQvhmjunzrXQ2CIPDPV5gY4IYuaU7X/d4wAvh
	 a5ktkmEov4WuUxpIp5pYeBwFJaNfmjlDSE3MTgnuuVp5GZMVdpqWg7avnyBvp1gIbM
	 gh6e8BMZjoMCB6JlZScbjCeHw+YwV8W0BZ8Rsc+MpkUz153vrMOYW9Q3CPiTV9m4nq
	 K/c5ZCHjGa70A==
Date: Wed, 21 Oct 2026 12:20:29 +0200 (CEST)
From: =?utf-8?Q?St=C3=A9phane?= Grosjean <stephane.grosjean@free.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, 
	Pengpeng Hou <pengpeng@iscas.ac.cn>, linux-kernel@vger.kernel.org, 
	=?utf-8?Q?St=C3=A9phane?= Grosjean <s.grosjean@peak-system.fr>, 
	Liu Changjie <liucj1228@outlook.com>
Message-ID: <942111184.1248111675.1792578029862.JavaMail.root@zimbra65-e11.priv.proxad.net>
In-Reply-To: <20261021-hospitable-gentle-sheep-a15164-mkl@pengutronix.de>
Subject: Re: [PATCH net] can: peak_usb: accept short uCAN end-of-list
 records
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
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - GC154 (Linux)/7.2.0-GA2598)
X-Authenticated-User: stephane.grosjean@free.fr

Hi Marc,

On 19.10.2026 00:46:34, Liu Changjie wrote:
> A PCAN-USB FD v2 running firmware 3.2.0 sends a 16-byte status
> record followed by a four-byte zero-size end marker. These transfers
> cause repeated receive-buffer dumps while the interface is up.
>
> pcan_usb_fd_decode_buf() requires a complete 12-byte struct pucan_msg
> before checking the size field, so it rejects the end marker with
> -EBADMSG.

Right: the firmware may terminate a list of records with a short null
record, and it doesn't need to be a full struct pucan_msg. Only its size
field matters.

The patch keeps all the record length checks added by 93fcab2c6968 and
only accepts the end marker earlier, so:

Reviewed-by: St=C3=A9phane Grosjean <s.grosjean@peak-system.fr>

Marc, since 93fcab2c6968 has been backported to the 6.6, 6.12 and 7.1
stable trees, could you add "Cc: stable@vger.kernel.org" when applying?

Thanks,

St=C3=A9phane

----- Mail original -----
> St=C3=A9phane,
>=20
> can you have a look at this?
>=20
> On 19.10.2026 00:46:34, Liu Changjie wrote:
> > A PCAN-USB FD v2 running firmware 3.2.0 sends a 16-byte status
> > record followed by a four-byte zero-size end marker. These
> > transfers
> > cause repeated receive-buffer dumps while the interface is up.
> >
> > pcan_usb_fd_decode_buf() requires a complete 12-byte struct
> > pucan_msg
> > before checking the size field, so it rejects the end marker with
> > -EBADMSG.
> >
> > Check that the size field is present before testing for an end
> > marker.
> > Require the full header for nonzero-size records and keep the
> > remaining
> > record and payload length checks.
> >
> > Fixes: 93fcab2c6968 ("can: peak_usb: validate uCAN receive record
> > lengths")
> > Assisted-by: LLM
> > Signed-off-by: Liu Changjie <liucj1228@outlook.com>
>=20
> Marc
>=20
> --
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |
>=20
