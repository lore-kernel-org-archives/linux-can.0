Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A36470840
	for <linux-can@vger.kernel.org>; Mon, 19 Oct 2026 14:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421397; cv=pass; b=mc/8BhyESO09YwMhOc5GBp4lNKezIZ31lkMTx/AfcL5rUR9Ciavv5AqpIFM8ltrkXlYuLV1c7tbFHKrGeDxcUMNGLLd8A58T+XZFoB54TviyocAUoUhnF/0CO7nfll7ATjedc/BeXCpo4RT/+CPhj2qmzXgcGcY53g07xN9RPgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421397; c=relaxed/simple;
	bh=SbNc36q98kM9CjGehvMgT5qeCtf31EGdsegR9SVO0J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyxthDRhh637FKbqdSlUzJ0AxFL9u/duBfSPjj0YlQUGDDZa59i4wbEmwIzZyvkb3f67IIvFboE8euCT4o4aODvxb4juUCOnWTFQFR7Ag2WNVB5P/KoJJ96M9Uj3of3d2Eadk58yK00rwc+OBG40151WgEV6Y1srIO90g0VYZkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=KMA3FPyO; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="KMA3FPyO"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 73DE92017C1;
	Mon, 19 Oct 2026 16:49:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792421392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mCSAOmPKSu4VHijSBA/0xwr+7KIt9zpgJULKg6Ig5z8=;
	b=KMA3FPyOsrZuBOjDNFxAoPNKfQVjGGgOR/F++jhSRU8V7VpOcPUILwQemrOO86VRV8mp/R
	2v3NCVWV6zZPw1+Dru3CFEZyT8dUhIH2rJp6F4d90x+G816pt8Acr22vWXUSwoR1jgmCC5
	/eRjdVQuN5ESW9+9txPzwKP2AKXmc69oK2OXySFmyN22VPMqj8hwSc8PK8OXT9kr3krHGD
	YJaiQRKiBc17JNpPu8qmFhKcYzbMsg3fCgredpPCZn2wOMfkG6TSYS37gcVawDD50sa5Xn
	q9EZx3IuMmEOTTmjXsVG7iUKBey26zUXRNBoloCgj8NRiP8bNxuheZeh4TnG/Q==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792421392; a=rsa-sha256;
	cv=none;
	b=JnH0FDIzokc+crspbzEdXpTzYHItcmRN+29pu4GkYeTYOQnWKi5bEArGufnjvmfntKAmui
	Rpb9AUH0FZ3JLJyRFryRoddH7ye9evcybj8Kn48L/jVl0kW3QdJZSChj7o24hASgQyfe6A
	Z/Ye7Xyo1Ctrew9nVe3ezeX5Zj1P5Q9rNI+k9qYmZTQRZdnWzEu4TIU3fG44CJnII71WD6
	kERmlpmu5EfZBI10+OWjrjtkpobFzjECbFL0BhcSOEf5fvnSffPPUsHOFK7mYnRaxOVhqS
	FhfB8AoigQMOlxrXCrlnFYdwLUq36+/WqoRqjh70d3AZRb0Mbx9jvT46ooaSWg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792421392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mCSAOmPKSu4VHijSBA/0xwr+7KIt9zpgJULKg6Ig5z8=;
	b=cChaIe5kbzNVj++FO+NULvxkIVoWIEDaxgbE374e9ZxKjZmtwNiWYpG2Kmo6UhQ3sLODSx
	vWn92MRBOl5mNaNQYOJOs9mhQA9Kk9alVX6j3bO0R9eUaV22qnsoeDOcoAFHbDk7sFcja4
	8LDw84jATkg88N+qhURUTUod1Hauc7yslxin6iKtL/ufmV6LIrRvc6hwAjknMbLWaeaRWN
	lX1cFNv287+KViyF4ShBXUhbZXsuirlng/QYel5FgYSV3fy/X91tJQZAuu570rdiml0eJ8
	0QmKxBQc0uzkJEsA58cehH21mcCTgK3S22dajG6SphcSAEsADQKnkfjaa/puaA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xIogS-000ErM-1D;
	Mon, 19 Oct 2026 16:49:52 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1B3095C933F;
	Mon, 19 Oct 2026 14:49:52 +0000 (UTC)
Date: Mon, 19 Oct 2026 16:49:51 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH can-next v3 0/4] can: protect the receive lists with a
 per-device lock
Message-ID: <20261019-supportive-coyote-of-efficiency-797bb1-mkl@pengutronix.de>
References: <20261019074244.50391-1-socketcan@hartkopp.net>
 <20261019-premium-anaconda-of-education-723479-mkl@pengutronix.de>
 <4c81a8e3-431b-4d18-814b-e09cdcff0b18@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6ewwsahzf4akldje"
Content-Disposition: inline
In-Reply-To: <4c81a8e3-431b-4d18-814b-e09cdcff0b18@hartkopp.net>


--6ewwsahzf4akldje
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next v3 0/4] can: protect the receive lists with a
 per-device lock
MIME-Version: 1.0

On 19.10.2026 16:46:20, Oliver Hartkopp wrote:
>
>
> On 19.10.26 16:12, Marc Kleine-Budde wrote:
> > On 19.10.2026 09:42:39, Oliver Hartkopp wrote:
> > > This series fixes a use-after-free in CAN_ISOTP and CAN_BCM that can =
be
> > > triggered when a CAN device is moved to another network namespace whi=
le
> > > a socket bound to this device is released [1].
> > >
> > > Only patch 4 is new. Patches 1-3 are already on their way to net-next
>
> As these three patches "1-3" are not in your current tree anymore you can
> simply apply this complete series as-is.
>
> And on top if this series you can also apply this
>
> https://lore.kernel.org/linux-can/20261019115231.93550-1-socketcan@hartko=
pp.net/
>
> to fix this sashiko-bot remark:
>
> https://lore.kernel.org/linux-can/sashiko-outbox-176764@kernel.org/

It doesn't work for me. Please send a _single_ series on top of the
testing branch, which includes _all_ patches.

regards,
Marc

| $ b4 shazam -s -k -l -H --merge-base=3D@ https://lore.kernel.org/linux-ca=
n/20261019115231.93550-1-socketcan@hartkopp.net/
| Looking up 20261019115231.93550-1-socketcan@hartkopp.net
| Checking for newer revisions
| Grabbing search results from lore.kernel.org
| Analyzing 1 messages in the thread
| Looking for additional code-review trailers on lore.kernel.org
| Analyzing 0 code-review messages
| Checking attestation on all messages, may take a moment...
| Retrieving patchwork CI status, may take a moment...
| ---
|   =E2=9C=93 [PATCH] can: proc: skip stats calculation after reset in can_=
stat_update()
|     + Link: https://patch.msgid.link/20261019115231.93550-1-socketcan@har=
tkopp.net
|     + Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
|     =E2=97=8F checkpatch.pl: passed all checks
|   ---
|   =E2=9C=93 Signed: DKIM/hartkopp.net
| ---
| Total patches: 1
| ---
|  Base: attempting to guess base-commit...
|  Base: remotes/net-next/HEAD-5-gfdb32e6b9bdc (exact match)
|  Base: @
| Magic: Preparing a sparse worktree
| Unable to cleanly apply series, see failure log below
| ---
| Applying: can: proc: skip stats calculation after reset in can_stat_updat=
e()
| Using index info to reconstruct a base tree...
| M       net/can/proc.c
| Falling back to patching base and 3-way merge...
| Auto-merging net/can/proc.c
| CONFLICT (content): Merge conflict in net/can/proc.c
| Patch failed at 0001 can: proc: skip stats calculation after reset in can=
_stat_update()
| Recorded preimage for 'net/can/proc.c'
| error: Failed to merge in the changes.
| hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
| ---
| Not fetching into FETCH_HEAD
| Use --resolve to enable conflict resolution

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--6ewwsahzf4akldje
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatYuDQAKCRDMOmT6rpmt
0rHkAP4vU2rX+cw+tZyBdy2PEcQpBYyeU1xqjX7W5t2ZCvm5tAEAtD5o/vh1YmFT
Q8eNMVrVIhwVk/5Q+6tnVkRC9vnyCwo=
=5n8l
-----END PGP SIGNATURE-----

--6ewwsahzf4akldje--
