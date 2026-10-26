Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793000713;
	b=J2hslApzUR6iLVP+WAFZOKDojqKYYjxAzxVy2JFXEcNZ08ryXcM13W0T1QbkMqacd7st
	 e/l+hBq/rGeE3LwGX9E38wnCD29k96aaEIkiTlTKxBde0x23daLgbKaVxP5pSz0MyOoov
	 PzrCwaT+osERAOMkw40AZF9v7jg+Ew2S1FPkdPxw6tsVqCT/1ZY423USn4n1PDPZh51Iv
	 aDr7wEnMmHox6+DNFKlQfYqFfzqSxxVMJCiN/TQfXVS2kh8hrxr1mEFZ0m96YVZ2hm3Jj
	 Nf56NLQbDXFOlJi+KSKHXQ2H/cmXGtvpBEALJjLxBurcZtFPAKFMpXpHqhcOLHXf4BQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793000713;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=FMoHyZk+rS5Hs34bS+7NR0VXf96oQN0+aVJQBDrC5Vs=;
	b=vRsF9zVoWydbFD66dmHDln//ELV4xkJ/zvSWTy+dTGtm36x2q0JjwQ/3f+l7E2aJjrU4
	 qAIZinSJh4eXIB/AxniMWPLuW5Kb/C2hTUB5C+NL8ltgQRhDsT9k4Mul+qzSpRSaZIT2E
	 5ew5YgoPs38OVl/Z81zbyHA1+oRuZgyaqadPhydtrOLpdo40nney+Wfx05zRZD1GHyjp2
	 RwuKa/1OeJBANXWu4C9mxrYW6xBGWKdxl6GyGKnDvWaCThqPRSVvScSqQ3S6k3pfaUphK
	 PBnCUVztJ1H7F1yxlOLvoCLNnpHSMuwuQXLU2hJrjV06ll0Op9WFCJcqihFS9bswu5A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=M8PePwja;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F85C606A31D
	for <linux-can@vger.kernel.org>; Mon, 26 Oct 2026 07:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F85C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=M8PePwja
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 735DF200AD1;
	Mon, 26 Oct 2026 08:45:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793000708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FMoHyZk+rS5Hs34bS+7NR0VXf96oQN0+aVJQBDrC5Vs=;
	b=M8PePwjaWVO/jIL7cWbYl5yuLXT1ySyaS7c0lJWrq8iFc7C2y177luGTvnaXBzA8gHwkzU
	RZnqhrSBmhVOnO5ZPiZeEE1l1nSU8IyrzBb44Rsf/7E/vEkyiwVDw4WiyQ7W4Dd8tT2S2t
	ysMPl9xuMgoQM6KIzCOk/i/rJzpJtZjAdhRrsc1JkSJxOmXyiHgW8nJ+DiRXVrDfJLjfPY
	X8xLzR5/yDe6rjYZKixI7z9N8r4bRJIcICyjRNSugJEHUI5L8NKEWaSPxndODGxk/d+K1b
	svUjWgPNjz2yUgnBg/4LRTX4Oy3cb4MHpX5VHgKCTuhMMAZBcBpAnjzg15MWsg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793000708; a=rsa-sha256;
	cv=none;
	b=d5Z93inl8nTeJQTGLSIGAHUBNz+HV0iCi34k2NKaeLL/ZLQz+RHAN4LvsutD8b0Wa+xJE6
	cCFGc4dJU00Buoiw1XA8jsuifeo+Sd7A0OhizqFFoqX51VzkOznNrCRt2wfUfCabMzb6YY
	GZpwG/BTIQNRNGMSRDak9bkd8dOKjuhub1Z1Un0YtHniIgoRnhNNuAoT7XNw7ry8PSsS0Y
	0lYmO93h5C7l5wwrmxIP3fJsicKwDNM18LrdfEvruTyQhZPTv/llsiNaj/HAAWFGQZuLVG
	9+YfG8aNIwWmHtCQJzPUBm3h1xBXsKGe/vZyjM0zO/wVgNLaYuA1/kMlHZxoVg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793000708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FMoHyZk+rS5Hs34bS+7NR0VXf96oQN0+aVJQBDrC5Vs=;
	b=fzskScmzPoD8nOPvTcqK/CBCcdKA8qkFWqzA6Q6Q1VTRQCmQseYp2bkcOHPc5yVcgYwcAL
	38XXUpyFibgAlyFUA18zcCaofixyoHghOhoOY9vz0x17axqM7SHUNghYWkHrfYJIn1bVAm
	Mv7gfBqkHQ4JwWwPrMzLvZLc+chfL3itjqlryOe8tBzT8WFOcUI57Vq5WdUL+PInhQKaOk
	/jxMVCyZYoMqviTYxCIJmfJxfYRKIH09CP8aXuOCKindrjV83NBqd6N3F1mKZvkLK7lE3d
	fBgquak9SRgxxr51TERVpOrMnEYgnHSadciioYIGjnmS3aH310rSpa2nDKJkZQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xLFOG-001FVK-18;
	Mon, 26 Oct 2026 08:45:08 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 101B35D46A9;
	Mon, 26 Oct 2026 07:45:08 +0000 (UTC)
Date: Mon, 26 Oct 2026 08:45:02 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Zihan Xi <zihanx@nebusec.ai>
Cc: linux-can@vger.kernel.org, robin@protonic.nl, o.rempel@pengutronix.de, 
	kernel@pengutronix.de, socketcan@hartkopp.net, lkp@intel.com, ecathinds@gmail.com, 
	dev.kurt@vandijck-laurijssen.be, vega@nebusec.ai
Subject: Re: [PATCH 1/1] can: j1939: fix session reference leak on TX timer
 restart
Message-ID: <20261026-smiling-aloof-perch-f8368d-mkl@pengutronix.de>
References: <cover.1792979091.git.zihanx@nebusec.ai>
 <6bbcca411ac9433ae4ed8b8e64f56ff16dfc20b0.1792979091.git.zihanx@nebusec.ai>
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
	protocol="application/pgp-signature"; boundary="tqbxsa5ykv2oym3l"
Content-Disposition: inline
In-Reply-To: <6bbcca411ac9433ae4ed8b8e64f56ff16dfc20b0.1792979091.git.zihanx@nebusec.ai>


--tqbxsa5ykv2oym3l
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/1] can: j1939: fix session reference leak on TX timer
 restart
MIME-Version: 1.0

On 26.10.2026 07:02:48, Zihan Xi wrote:
> The TX timer holds a session reference while it is queued. Restarting an
> active timer only changes its expiry, so taking another reference for each
> restart can leak sessions.
>
> Serialize TX timer rearming and reuse the queued timer reference. Take a
> new reference when no queued timer owns one, including if a callback is
> running.
>
> Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
>

Drop the newline after the Fixes: tag.

> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Link: https://bugtracker.nebusec.ai/f/11143
> Assisted-by: LLM

Please remove the Assisted-by: tag, it's obsolete. Instead, please state
in your cover letter that LLM were used to create the patch. See commit
1e035297ffda ("docs: remove Assisted-by references") for details.

> Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
> ---

What about the txtimer in transport.c?

| net/can/j1939/transport.c:306:31: warning: passing pointer to variable 't=
xtimer' requires holding spinlock '&j1939_session::txtimer_lock' [-Wthread-=
safety-pointer]
|   306 |         if (hrtimer_cancel(&session->txtimer))
|       |                                      ^
| net/can/j1939/transport.c:1552:26: warning: passing pointer to variable '=
txtimer' requires holding spinlock '&j1939_session::txtimer_lock' [-Wthread=
-safety-pointer]
|  1552 |         hrtimer_setup(&session->txtimer, j1939_tp_txtimer, CLOCK_=
MONOTONIC, HRTIMER_MODE_REL_SOFT);
|       |                                 ^
| net/can/j1939/transport.c:2254:40: warning: passing pointer to variable '=
txtimer' requires holding spinlock '&j1939_session::txtimer_lock' [-Wthread=
-safety-pointer]
|  2254 |                         if (hrtimer_try_to_cancel(&session->txtim=
er) =3D=3D 1)
|       |                                                             ^


>  net/can/j1939/j1939-priv.h |  3 +++
>  net/can/j1939/transport.c  | 11 ++++++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
> index cf26352d1d8c..6c46dec73bbb 100644
> --- a/net/can/j1939/j1939-priv.h
> +++ b/net/can/j1939/j1939-priv.h
> @@ -10,6 +10,7 @@
>  #define _J1939_PRIV_H_
>
>  #include <linux/can/j1939.h>
> +#include <linux/spinlock.h>
>  #include <net/sock.h>
>
>  /* Timeout to receive the abort signal over loop back. In case CAN
> @@ -290,6 +291,8 @@ struct j1939_session {
>  		unsigned int dpo;
>  	} pkt;
>  	struct hrtimer txtimer, rxtimer;

Add __guarded_by to the txtimer:

| struct hrtimer txtimer __guarded_by(&txtimer_lock);

and switch on context analysis for j1939:

--- a/net/can/j1939/Makefile
+++ b/net/can/j1939/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0

+CONTEXT_ANALYSIS :=3D y
+
 obj-$(CONFIG_CAN_J1939) +=3D can-j1939.o

 can-j1939-objs :=3D \

=2E..and compile with clang-23. See
Documentation/dev-tools/context-analysis.rst for more details.

regards,
Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--tqbxsa5ykv2oym3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCat8E+wAKCRDMOmT6rpmt
0uVOAP906Pb6EE4RpfC83bJSfd8Rz4OVwsOpQ4qpqf1OU98FlAD+OnpwfxFbzhYn
WGjPp6X3KXiTHq4E1Wpo42zuGWVmnA0=
=gbcC
-----END PGP SIGNATURE-----

--tqbxsa5ykv2oym3l--
