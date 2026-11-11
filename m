Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418431;
	b=G2sg1WKbEaEnjqb5oPCv+5q+/BsLSnRgpA6cyRGK3oDN4/gNLnfgJF+EHSXpfBbCRMr3
	 p6Wb89OGVancL6ypzcRXEmW6SiaQfDY2zwb1RlFTgSwQMly5rqh2C2kmY8JNOFyj4Zia0
	 9Db4CgsERTIt6ZhHGLZsOr+f1iDomyEjnY/Ovb/dD8DUI4uH4QXteX7hgu3VBEHL2JTGf
	 MBpQpAZ0l3eW4AXlZ2HJEBl/FTShPfmkWNAYPoLnQUB6z5rH7Iqyob6Mh+jcvFb3UdheM
	 iUtiwDEcJA++q6Vak4/fxTnHGUD8qC86UAQbZMn1rRrFDPbY3FtgK0Pq3Dho2s2gdUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418431;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=YvexIMYqiMiz1q4JNqaiQjkR3iTnjNBJbrIGwBNzjEU=;
	b=K9oz7tD37eOyjsa9hK0/MCXVbGqRDOQTUksLjbE3gaWwcZk/jecb62ED35I+6mfnnZk4
	 2P86fGuk51h6VrPxer4DgB4liVUWrLy1qC77eYRDPQzrgXG9FGUarceEtkohId2L6H+my
	 Lxx+fvMYHbMdrxTl6UzLgkqQBXcLUtCMvknLIpSVPZRW+2JObvPqd731O2OLF6g4b6tq8
	 6jd4+DFdnNH5o9seHdgBpJ02p4QKAtsMt16wi3TreZBhBzxAwhxAS8oMCI677FfwVVyr0
	 wc8fhB32/v58JSE9v4n7JhpEBl+g7C0MRHKcTgKemmpkfK+CRw3mqPRtUw45vMfVFEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=inicpcHI;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518ED606A324
	for <linux-can@vger.kernel.org>; Wed, 11 Nov 2026 17:33:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 518ED606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=inicpcHI
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a2d6d01ecbso21771795e9.0
        for <linux-can@vger.kernel.org>; Wed, 11 Nov 2026 09:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794418429; x=1795023229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YvexIMYqiMiz1q4JNqaiQjkR3iTnjNBJbrIGwBNzjEU=;
        b=inicpcHIZnCmcEzzbQ3MmS+YvAq5Scx+eJ9EP0DS5vSfJefOX+7im3R61WEtmbEGl+
         dQYNLm4/6io+doNd9QANIQ6WylX4hduah5G4JDStbFnEWoV7P84iUQF85tuo0xJNCzNw
         aN3V9JTnWA60LAX3s+/huqc4XN5Ns1yt4BpdYMf8A0yraHLiQTVM47EhyXSISbGtnFBD
         yHlXYVmCDGP3L3un4HqqS8xbEzkjU/Iq6t3mMA2sgks6KILzghfpJ9AblOFId4RbNlm9
         uAlIC0j7fn+700Zw+nQvMXzWSW9GLuHq2IuV6bR8sm70AUw5ZcaB+j09j1imryd9SPzk
         gPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794418429; x=1795023229;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YvexIMYqiMiz1q4JNqaiQjkR3iTnjNBJbrIGwBNzjEU=;
        b=LgRg0f4SK0cXwi1sl+GkAOCE3131MorKk1MYsim96aCcSqvsDoNqa9i0uzoF+xNdHi
         6J2+hMz0Xx1jpIlkqxpFZ/v7jvlguj8dBdYjVtxMQLjxqlFRZPFYd4v90j2kL1o4phU3
         TgjI35ejLJ26mJXW05RvDqR7X4O8W7TJayK5pZgvOJANFZZmYzChIwZDugZMG5k9VPDF
         FZxRMR1W2j82LWnUpkNzc8/BcWqbqydtxUfION7hvP3GiOrssFmWU1sXK5W2zluaGRlp
         N4uHhGWxiGV2muA+Y4BAwzi7pt/ZbCoS/kafyyiH4R3hSQB1HPbsTYaTJtR+YjXZJtPU
         sYtg==
X-Forwarded-Encrypted: i=1; AL+hErH6BaHhFjnJkk3nnDp7egu+tEZA3XlQY83fDMvu8i2mgXR5YnMc1tc/Tl/H7d/+E8JPaWzEsJxpol0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9D7kBiiKU00LPBUs4FEM6bsuFj9pmYJRDZR+QpX9MJ+t8/Fjr0
	Tiij87FVPgxWvUs6YPVQw4zW+lDXkg6XEtwuI59LTVmdQdbo8DTf5fitBeIOoMB0Yoo=
X-Gm-Gg: AYBFou3uyG47TLH4F3mR1hSeCU48yKH3+kx4A1cWa3clHOckI8hCPXKn/d0SUjBOtDO
	5o8pZpJsal+9sSbgNC0C+kEcik9DKR+cbSke4AuZo+BCjQUwhKGuNzKKE6EMlEmJzL51+YwhOtz
	lP8pCExBaKoCOnQ2409RnSGcHWvGoa8rzYpyY3zQynwdqdFRUR7j8gZS85qP3q4HZa+R7XhmmKe
	XkG44hEQ1viumIUtAu8juJs9D6kjo4QbdGz7PGPzer5bGygsSe5bt/PN/S5Twg+/l+Of3lWQIla
	98GV7vTL9k5UWxiVRXIH3CEld2ynBmmTa3YEWlOq/BzUYRTup/a0oYo/lgZp3mBoZNT7lo/69Z3
	KRnDSR+axT85jPJ9PLqK72MlzvDpuTm0qtGpgJUG92/TIw3aDRAyHdsq30ZprCDqSApuq15rlU+
	vLu6pm3wMZ9MNchwLLYRBYpXfm+pOmMPnK1ITu33cB6WyJkEe0vkRF5+uG+gsoWbi1uCJmtpoNf
	+B4UOgbt/CTWsItPaHBvOssTfAKb0uMJ/lI3DL+ROds8oj3unQmWoL5yykGUcOA0aldSXIZzCxD
	uy67ZONa3NJU6lySGhNx3x/uXDjuMaOXDtPenHfMzAFF8O8jJP1jONinL2c62MzA0IMrECCQGDH
	5Cxn3BcV+X8my6gx/y+VNWvIcC3b/YhYG6qIp6g==
X-Received: by 2002:a05:600c:81c5:b0:4a1:d087:f6ab with SMTP id 5b1f17b1804b1-4ba09376cc2mr50842555e9.18.1794418428621;
        Wed, 11 Nov 2026 09:33:48 -0800 (PST)
Received: from localhost (p200300f65f19a9045674a4e2f3db58c3.dip0.t-ipconnect.de. [2003:f6:5f19:a904:5674:a4e2:f3db:58c3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4ba0951bf2asm51567095e9.4.2026.11.11.09.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 09:33:47 -0800 (PST)
Date: Wed, 11 Nov 2026 18:33:46 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] can: flexcan: Fix probing for m68k/coldfire
Message-ID: <avSmq-LRKgRWDfxH@monoceros>
References: <20260618140147.142489-2-u.kleine-koenig@baylibre.com>
 <akfoYuyHMAxIfalD@monoceros>
 <al4lxVud4_6NTZQG@monoceros>
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
	protocol="application/pgp-signature"; boundary="4hfc67dntoyzrou5"
Content-Disposition: inline
In-Reply-To: <al4lxVud4_6NTZQG@monoceros>


--4hfc67dntoyzrou5
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net] can: flexcan: Fix probing for m68k/coldfire
MIME-Version: 1.0

Hello,

On Mon, Jul 20, 2026 at 03:43:09PM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> On Fri, Jul 03, 2026 at 06:53:16PM +0200, Uwe Kleine-K=F6nig (The Capable=
 Hub) wrote:
> > On Thu, Jun 18, 2026 at 04:01:47PM +0200, Uwe Kleine-K=F6nig (The Capab=
le Hub) wrote:
> > > When determining the device details was reworked in commit 5e6c3454b4=
05
> > > ("net: can: Use device_get_match_data()") there was no replacement for
> > > the previous handling of non-of instantiated devices via the device's
> > > id_entry which then results in a NULL pointer exception. The only
> > > in-tree provider of such a device is arch/m68k/coldfire/device.c.
> > >=20
> > > Given the id_table only contains a single entry just hardcode the res=
ult
> > > of `platform_get_device_id(pdev)->driver_data` and drop the unused
> > > assignment to .driver_data from the table.
> > >=20
> > > While touching the id table, drop the unusual comma after the termina=
tor
> > > entry.
> > >=20
> > > Fixes: 5e6c3454b405 ("net: can: Use device_get_match_data()")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@=
baylibre.com>
> >=20
> > Given this fixes a crash (NULL pointer exception), it would be great to
> > get this applied. The issue is already old (Sept 2023, v6.8-rc1), so
> > there is probably no urge to get this in before 7.2, but getting it into
> > next and then 7.3-rc1 would be good.
>=20
> This still stands. Marc, do you have this patch still on your radar?

For a fix it takes quite some time to get applied. The patch now missed
7.4-rc1 ...

Is someone reading this ping?

Best regards
Uwe

--4hfc67dntoyzrou5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmr0pvYACgkQj4D7WH0S
/k4bNwgAsQchSshsvcSs/c8msQEUeFLmy38NQ5NvYG9rkvtJ5DGZBJZCWbiMnvQN
UxxEUyz189PGDh41YHwkGDS1NMvdFvrl9uptRZGvbI/iB6fJP38y+ves8Dp1BBUQ
CiGoYQ2oqm2R2WnYwsUzdVL3E9R7zMvkueC0YW5h6BerQroVMVDLtclvQ8iXMMou
Ko+Dpwg76ba2xYTAHwNhyrNxQraVOp+o6+IlCIcKCK8hCwV7AFS6VU9zwEgLsUms
X3yeTFHRNc3aZGjulbY35I7d0ujF5iRrEFLzI8MIUcCUiIXqCkFSGGV9450s+uz9
RcNFp/Rrj1+U4tKfnch8QGtgmLvSRw==
=5KoS
-----END PGP SIGNATURE-----

--4hfc67dntoyzrou5--
