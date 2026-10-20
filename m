Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792483478;
	b=WJoEWRURt735GDCe/A1ziT5hKok0R4RD+HnVjoNFMYzfNKbZZcQ2jSyZmmm8rrWZg8CH
	 hTEzQepL/ZQtbqlgP6Krn0GceXPxSp98i3zAUxpaxBxPak72fvDD3RsTqLc3IZrWgBakV
	 TMR5YHd6LHfqOm5f+Zbjx2fgt2UN3BsnfbUaxr+D0zpONGzYmBTKQ8y8ruGrlt4lN3Ir7
	 eSrANiTWLMvAUHGLlNbdpGbRUY3dgISYFpQ34HJ3zVu8D6lZ2ZUyaNAbiY2tO+fWK1vBo
	 FmNmLAFEDRmS3SyOFtKYjyjIwuJlimQNv14MN+c7BjzPwbLAN09sjy3SNAuPuuRAGEg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792483478;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=RsPUpmXJkjhxaSiSdamMeh8eU/v++wxZwE9nUKEw08g=;
	b=FiIrbmZPY3aryfwS4wrWxigXV335xywtdr+/u6rnBzSVjqEEm/2WidkPySPrs0yizeKp
	 ksO2fa1N3teCXkDGKrF8ibTpueZ2sq2R2sPi4bo/imS2v0TX/VFcr82AFTtfOFzhU8fNl
	 gFhl1M+IZW2yi4+R3qGoyBq/WhkAyKG4o2C+Oo3fdEZEyLmQvFJ1/T3vZWEYBbbqtn1Q2
	 Naa07MtjVimBrugYP/OUqzD+IxsSxcJASN0Kag7TB4ES28vIck0cJQ+3UQ+bYFAwnlaDh
	 KLJSjs2Wrl8DMJ7D6PUkdXV17Jg6oPS5/x7zYJlovv4jcWhrvZgUCgVy/4Z8hTnUkpw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=MFmxFV3P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BC8606A319;
	Tue, 20 Oct 2026 08:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6BC8606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=MFmxFV3P
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 9CB68200758;
	Tue, 20 Oct 2026 10:04:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792483473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RsPUpmXJkjhxaSiSdamMeh8eU/v++wxZwE9nUKEw08g=;
	b=MFmxFV3P1TI8jUpSDeAW49gnO2abLO9fDSBFR6L8J0zRRRoSupw60IA3giiOJfOuRwZuVO
	FYyPwDxSPGz7QhNB0ic5ZMWMGMARYaQWRFbJ5TvZ6UzxYbsqFqG+yXKOAYxk6oLV51/Ewj
	T0zUudSch+3ygRqc32rjOVYzJBRLMvUVoa2CgP24IFPQ3Ed9h9Mhvjwd6tqBkawoXragew
	HyartKiAtkjn+zTznFjzR7qqzpvkDPJfLy4TxL3Ju1vwftLadG/zTewKVXp/9JM6aRpuTN
	99ZfQxE1s/0wdogxWYyamcEi7DmtElzaxm0hf0RAihJ0JIGGIrjY1UnauhStKA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792483473; a=rsa-sha256;
	cv=none;
	b=bPKGaWdO+WxMzcXeOie56ENJoaaTaWJRtq2sYNrC0RN+v9SHhDwhPwELwJ7QLTYY+yE9A6
	jCrzVZGUCvZPdv98srVOC7lbR2hS4BABUJIgefyIei1pqbQPUFBG/PLBJCoFm00u+q569u
	r8z2pEiyfqh8F3B6nXkaotmIElZgiJuGPYjPIjxIhWeDRYc52C1vbtB1nulPlVp4TlBCz/
	T14bS2aGfddkDrZxKr5cURS7wwumHad7lMJ2Xevn0IdRU0frKqtMIYvtKvLO35tc/fK2Wo
	dSk/rDbriBoC9G8oQf3NMktkicwlLx635KClHcHAIDVHV9xnuZUlflPokW3xwg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792483473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RsPUpmXJkjhxaSiSdamMeh8eU/v++wxZwE9nUKEw08g=;
	b=F3wiYBFuGeRG12gPsEzAOGaARhyYdA3qflmyl1uRG7D7J23DmsgCdXk3RITR2QDj/PIClO
	KB2sBd5htv6XoewwNqOi2WzjjDVe0mP7HbmaI3htXrwDo/Mcbfph8Kwq+l1xFWvJf4k+sy
	xYLuuoW96z9YakZ+BCSlQb/9ahPlfa+xTNXG4Fv7S+4SJJtd8JkZYqqR94nNdRwVo6S9hP
	d2d9yoPTdDYXc8y8wFtMHsP9wbMh/Ez0HSpXgmQc75F3hXSELnfE6B/BH7gpbB496/aLqI
	IGCgY3ZQQuftQ0s83cVVkOpaASI6bwDnJeAVij7SzLwPwf3kAWjVOtUGMwkctA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJ4pl-000LAF-1g;
	Tue, 20 Oct 2026 10:04:33 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3A9E55C9CAB;
	Tue, 20 Oct 2026 08:04:33 +0000 (UTC)
Date: Tue, 20 Oct 2026 10:04:33 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Chaosheng Qu <quchaosheng000406@163.com>
Cc: Robin van der Gracht <robin@protonic.nl>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH net v5] can: j1939: validate the EDPO packet number
Message-ID: <20261020-brilliant-caiman-of-fertility-df8245-mkl@pengutronix.de>
References: <20261020025036.74454-1-quchaosheng000406@163.com>
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
	protocol="application/pgp-signature"; boundary="yu4uwihbrfjcxii7"
Content-Disposition: inline
In-Reply-To: <20261020025036.74454-1-quchaosheng000406@163.com>


--yu4uwihbrfjcxii7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net v5] can: j1939: validate the EDPO packet number
MIME-Version: 1.0

On 20.10.2026 10:50:36, Chaosheng Qu wrote:
> ETP.CM_DPO is peer controlled and its packet number is accepted without
> any validation.  It names the packet a transmission window starts at, and
> j1939_xtp_rx_dat_one() places incoming data at "dat[0] - 1 + pkt.dpo", so
> a value past the end of the message moves pkt.dpo beyond the reassembled
> buffer.
>
> The transfer can still complete in that case.  With pkt.dpo =3D=3D pkt.to=
tal,
> a closing ETP.DT frame with dat[0] =3D=3D 0 evaluates to packet pkt.total=
 - 1,
> which is the last in-order packet, so pkt.rx reaches pkt.total and the
> receiver emits its own EOMA.  The local loopback of that EOMA runs
> j1939_session_completed(), which asks j1939_session_skb_get() for offset
> "pkt.dpo * 7".  That offset is past the end of the queued skb, so the
> lookup returns NULL.  Before this patch the NULL was passed to
> j1939_sk_recv(), which dereferenced oskb->sk.
>
>   ETP.CM_RTS (size 1786)  -> total =3D 256 packets
>   ETP.CM_DPO (packet 0)
>   ETP.DT seq 1..255       -> packets 0..254, pkt.rx =3D 255
>   ETP.CM_DPO (packet 256) -> pkt.dpo =3D 256, unvalidated
>   ETP.DT seq 0            -> packet 255 =3D=3D pkt.rx, completes the tran=
sfer
>
> Reject an EDPO that names a packet at or past pkt.total and abort the
> session with J1939_XTP_ABORT_BAD_EDPO_OFFSET, the SAE J1939-21 abort code
> for this case.  The check has to be ">=3D" and not ">": pkt.total is a
> packet count, so the last valid packet is pkt.total - 1.
>
> The EDPO is also looped back to the transmitter session.  A peer can make
> that role see an out-of-range EDPO too by putting an oversized packet
> number in ETP.CM_CTS: j1939_xtp_rx_cts_one() only rejects packet 0, and
> stores "packet - 1" in pkt.tx_acked without comparing it to pkt.total.
> j1939_session_tx_dpo() then copies pkt.tx_acked into the EDPO.  Rejecting
> the looped-back EDPO aborts the transmission instead of letting it run
> with an offset that cannot be encoded.  Validating ETP.CM_CTS is a
> separate change.
>
> The abort branch must not strand a session that is already waiting for
> an abort.  j1939_session_cancel() re-arms the abort timer only while the
> state is below J1939_SESSION_WAITING_ABORT.  On a second out-of-range
> EDPO the first call has already moved the session to that state, so
> j1939_session_timers_cancel() removes the pending timer and the second
> j1939_session_cancel() does nothing.  Make j1939_session_cancel() report
> whether it started the abort, and force-deactivate the receiver when it
> did not.  This is the same recovery used by the second-RTS path.
>
> Guard j1939_session_completed() against a NULL skb as defense in depth,
> so a future regression in the offset arithmetic degrades to a dropped
> message instead of a kernel panic.
>
> Tested on v7.3.0-rc5 under QEMU, with the reproducer below:
>
>   - an unpatched kernel panics in j1939_sk_recv()
>   - the guard alone does not fix the bug: it drops the message but the
>     transfer still completes, so it is not the fix for the bad offset
>   - the range check alone survives the single-EDPO reproducer
>   - two out-of-range EDPOs followed by two RTS frames leave the receiving
>     session deactivated; no netdev reference remains stuck
>   - a full 1786 byte ETP transfer between two J1939 sockets still
>     completes with the payload intact.  Its last EDPO announces
>     pkt.total - 1, one below the rejected boundary, and exercises both
>     the receiver and the transmitter loopback
>
> Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260928193312.553632-1-mkl@pengutro=
nix.de?part=3D3
> Assisted-by: LLM
> Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>
> ---
> v5:
>  - Make j1939_session_cancel() report whether it armed the abort timer.
>    A second out-of-range EDPO now force-deactivates a receiver that is
>    already waiting for an abort instead of leaving it without a timer.
>  - Drop the claim that the range check and the NULL guard are both
>    required for the original reproducer.  Both survive that sequence;
>    the guard is defense in depth, while the range check is the fix for
>    the bad offset.
>  - Drop the incorrect "one full packet past the end" description.  The
>    offset starts six bytes past a 1786 byte reassembly skb.
>  - Correct the transmitter-role statement.  An oversized ETP.CM_CTS can
>    make the looped-back EDPO out of range, because the CTS path does not
>    validate its packet number against pkt.total.
>  - Add the Fixes tag.

Thanks for sticking with it and continuing to work on the patch. A few
remarks regarding the process:

- only send the series/patch once

Some comments regarding the change log:

- keep it short and dense
- bullet points are preferred over prose text
- only add description of changes compared to the last version
- the rationale for those changes are not that important, as the
  motivation for the whole patch should be explained in the patch
  description

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--yu4uwihbrfjcxii7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatcgjgAKCRDMOmT6rpmt
0jcpAP9/1LG7+Bh3+PB0U7Vqmrz7EREpSzWgRAGxRhjEUSFPIgD9F8xcE+uttZnQ
5LJEBRp4u7jM8MkUPu1ojZDIOf+JhAQ=
=S90W
-----END PGP SIGNATURE-----

--yu4uwihbrfjcxii7--
