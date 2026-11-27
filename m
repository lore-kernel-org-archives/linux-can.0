Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795778389;
	b=MgJQhN6zt9KLm+OEuqMt1rZZhz47QXJy1eDEXreeMbT+1kXW1h5yqOnwKyYhsUO59bMl
	 Eb9GiTaNKPhKrXfjcOhi+xnBpxSewEV97Bxq6Aeb6/hsFqH5dlGhCM4DGubDEuvN65ae1
	 RFauyjkDe+rUtJSktldi7ZR50GiPbHv7NAyB3uFM3o/fjovRtSegrSa58+fYUT5Edj5A0
	 SNjeNXetLRaUL/LraDvm8ixGu4I+4JyfS0FeJAz/hMmyC6lKMOklJ7lYmvIHXQwzBndNf
	 CF5etP/1406N8B0CVKQhE2/Gjx2Atc7XoJ+IwJtifZylTVXaC19qHYaQZ2uaIVUHiVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795778389;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=rRork88nwVcPoZLZ8YOGPPsgLg0KW2kZByQIjPw7eqA=;
	b=xr3EyH2f3/hFWbaKQ5i7HmBhUiVRSPk5f/iTbRTCULXwibqOgjUL8maG9kiZy7ysYYCx
	 OjkOEhEjPwoH9yVUKx8K8DxnQNhfGf3DHl5zvmYoKT3o0Q0gBIRckE7vHgAyCTuvSaqqn
	 ApwKgy7XwwsuXttBCfYo17f5wCpYyTWoLSCs6zLdN68S/Mze+SQ+bynTqvNCK6YfyT3m5
	 jbKQtjvOcZOfp3NsP4YCcz8XrSlWIEab87+85XeK4385ryGy8bUKCAvQFfB1KzvCE18rN
	 Re12A0V9T+n1nZvnUH41IcRbJLuqCxlea91lKkg1ssXGJSkg98NXVWaGJaux0MIZxfA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=GZeDJ47k;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843D4606A31E;
	Fri, 27 Nov 2026 11:19:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 843D4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=GZeDJ47k
Received: from ptx.office.stw.pengutronix.de (ptx.office.stw.4.pengutronix.de [10.9.0.3])
	(Authenticated sender: relay-from-ptx.office.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 9A6D32058CE;
	Fri, 27 Nov 2026 12:19:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795778386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rRork88nwVcPoZLZ8YOGPPsgLg0KW2kZByQIjPw7eqA=;
	b=GZeDJ47kB2nbC0ZjqBXm1F5FDJG9PuuSfDNNJYrIEz8Vt5sJw86f59AgJrLpzqgYwj75E+
	U+Xtfx44mpPPbb9pV9ABCFnNM1RhI3IFnV092/BdlJqG1oIVPUrHaUkg0OHiCJVjbV0xRg
	pdW6hC01CXu/lbPXu+/j1NMQc/j05rLdVqqpnG05EoptVdhgVY8wc18HR0rMFkbeNdQbbH
	O4xpAHDiHM8RPwMsnL8d7ppgjZ8FuXcjLFI5GGyUCkk6eZgVskd1y54V/pQinWW4darjtL
	8PpfXn5Ivc6FGTRB11aiQ8WtYBGufB1gLGtZ/dcvfeiBMFYJPx8ecU1SjdcTfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795778386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rRork88nwVcPoZLZ8YOGPPsgLg0KW2kZByQIjPw7eqA=;
	b=EYd1BEl9s3PL36MDS4nqYHQocch6KfVbbqC0tDjlPBp78vG/3/WFKXWRbhGwAoXPoGgExh
	jcloKECu8H6g8D6PtI5IXXh0eTbkrVxbyPNkZyIOKJt0tCHhVeXVsSY75hsoJSkTEhIiZs
	kMbO9bFsbrzxG0K0u4zZTFpaaOSSvghz9ToZard0MnxQ2fQT3HiZH3IYvcYb885ovAG6xP
	H/HMqHS5EBPAJzNQm65QdXuNFUFKt6jruvC54qBa0KQROhF6pdgnB2zVBAV0HCc+I50dnJ
	GZ9QMztdR989+xfLvEBgjzROlE0wkU4fr9iHv/lgLu76CE8lru674InBe8dcRA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-ptx.office.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795778386; a=rsa-sha256;
	cv=none;
	b=MoZI2zEqVMdN2h5RaVJb/Nkot/DcqzJRXpdrWZkQ/tS+dzoTAtwNkeiv5eg+s/RSTLdlqs
	Hp8XW9p/2aV92fmThC5CzFsgtefQUPDGrnnmUb8zptVwJVnaLc4G1/ytpoVRTrJd78oYPf
	69+TvSXOS5Kx7K/v0TEH43kqZg/be4WtSghx8N4dNwszSjdqM3espRb8iF3PdV4dimJFku
	CpvHP6v8NnkIuNkHjcToo1uHhU0dAk05SWU/WdW4BDq+sLR75iNYxctbh9qFCxtF589/MI
	4GJcTrRMIuiBr84FqbyKzK6rdzaPLD6OE9MoCCKll7qkPf6YzIsdJ3du8NRowg==
Received: by ptx.office.stw.pengutronix.de (Postfix, from userid 1058)
	id 7D9371BF7BF; Fri, 27 Nov 2026 12:19:46 +0100 (CET)
Date: Fri, 27 Nov 2026 12:19:46 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Hui Peng <benquike@gmail.com>
Cc: robin@protonic.nl, mkl@pengutronix.de, mailhol@kernel.org,
	kernel@pengutronix.de, socketcan@hartkopp.net,
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: j1939: return 0 instead of user value in
 j1939_sk_setsockopt_flag()
Message-ID: <awlnUrAP4PGtg4OO@pengutronix.de>
References: <20260919213632.3313825-1-benquike@gmail.com>
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
In-Reply-To: <20260919213632.3313825-1-benquike@gmail.com>

Hi Hui,

thank you, and sorry for the long silence.

On Sat, Sep 19, 2026 at 09:36:32PM +0000, Hui Peng wrote:
> In `j1939_sk_setsockopt_flag()`, after copying the integer option value
> `tmp` from userspace and updating `jsk->state`, the function returns
> `tmp` instead of `0`.
>
> If a caller passes a negative integer (e.g., `-1`) to enable
> `SO_J1939_BROADCAST` or `SO_J1939_PROMISC`, `if (tmp)` sets `jsk->state
> |= flag` and then returns the negative value as an error code from
> `setsockopt()`. If a caller passes a positive non-zero integer (e.g.,
> `1`), `setsockopt()` violates POSIX by returning `1` instead of `0`.
>
> Return `0` on success in `j1939_sk_setsockopt_flag()`.
>
> Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

For next time: CAN patches go to linux-can and the CAN maintainers
only, please do not send them to netdev.

Regards,
Oleksij
