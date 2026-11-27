Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795777501;
	b=FM2GV+gGUa/wnSdHHe80yf9V8iTVLPEFRhAzfqiL2Z/+6hqHiw7Eijdlqy3BHu1gLihR
	 YzSj4Fr4gGLejD7Fhd+Eq4TgIsopPhsVOhqj0V3MdqVZ82eY9wPB87rzis0gvlj1eet8R
	 x2YKNCq1lnlLOC8t9BRmsCa/XZSDU+dfT3sSty17SizlGenHd1YGFp1tRXV3CWTqpuFBw
	 SfSqZjdEINfTpZ43gMmFyq1/aya934FW0FpPw8UDIDsaWKh7LGak9+OG+KfSw5z5zd0WX
	 5bRt05+adMm9LfG5SUIOlcrbuknR3ooZcYXUrJA3KpRCTPWPRMDAiCisV68vqtnA0Ew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795777501;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=BaxP2WBnGq+zPWEWfbHrMHGpcGr1/uX+HjXVQ7FgtSo=;
	b=OKvQCTf2jN8E9QfTfJ6U83IXNNLB20mZjqZI6Wphk3zvSfqvOy+U9q3vqvrKZNdtKztK
	 35EvIvOSQ6DPt+XKtNDpMcbkCqll5KEYU3iBRMo4Jf2cT92OrLJ7CO/lD6AS4tedJBQqF
	 k00vn7ZWD6uD14EMvswFI16F7DpIPOClwN39UoQS1TAyWc7ZrNdnGPcnYgDihzK8Paxeq
	 ik7D/tye77f/91Hf8jX0Wq1XDHAUSj1JQRMT1v2UW+c4Lcz7mxXWj/zEMXiZguMXk8qBJ
	 xMUMByMYGZRLPNSVKBk0uz8v14Ihj77dR6u0rk31EeD91fJasjSC4/W3+enurlNcHnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=NnR6S1op;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2891606A330
	for <linux-can@vger.kernel.org>; Fri, 27 Nov 2026 11:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2891606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=NnR6S1op
Received: from pengutronix.de (ptz.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::77])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id A2B4D205A87;
	Fri, 27 Nov 2026 12:04:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795777497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BaxP2WBnGq+zPWEWfbHrMHGpcGr1/uX+HjXVQ7FgtSo=;
	b=NnR6S1opkruu385yPYtUmHod5ZHDVcf8GXF3+FeCaX1yIQW14g+Mo8AtAijNAszIF0QyzS
	Do5vvqg9Nz0YAL1QQpDOsZa3PdjnmaUX5eq7wjClQ62bJlWb2pnwsjISeDDTV0Z1SH5aWr
	WQWbvlHZ5LOS+8WtN2SCyjaFrN+HrGD6Ua//MmKPBE+9vI5f1hw9QoEaYw0EVDIw5lfTZ0
	8560a1dEvc8Xo2HIltWAcTkCBdcB2PemW/3vBE8SznrVmJp6EOvIBF61hcDcRGylg8e5ht
	qw4Si6zyj9WT5ueApGG2yVmJpqMfquSIbSefz2zQv0l4ddfH08LTHAL+5/t1/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795777497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BaxP2WBnGq+zPWEWfbHrMHGpcGr1/uX+HjXVQ7FgtSo=;
	b=HacQ1ciG6uteWHEq80egL0ExvxkFr5Km863coMqfV9s1FTwB7wEi7Hnc3Wo69tVrpDxoxo
	W2wm8VOa0DduYwEycc/ZX/IAz5AQmaLiecOAcdKEN9kO3zkDXiWaOviFqZkxqUcpvTkNd1
	VNKlYDdAUOstJRyDlnODj60ml8hDAOfD7o3iPp0is+iXpPPO9REsKMblJuJqOF+Nm8CXBg
	/IuZsghwviGTe4EMQTvneK3oiIgHeM5ViLGI59IYHXvcKka1iaGZ/rJ6IoQaFUX1We1ZS/
	B+71KVm0IznXejLNdMG6q95lXkAy8PL1PFlmR2f92VLfs4exKCbe5fY+itPkAA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795777497; a=rsa-sha256;
	cv=none;
	b=TyYT5Fx+69qWiUc3c5MeQJ71w0kvtTe6PzgFfpB4XiCLfD5uwOEgfimc5tHH+JBKnf5NaY
	+ctfP3I9/yGICUkf9GtBV05um09I3DNT79varUxUmhcSFJlU4gzUcAORVTlqyQ1vqQuY1T
	d05eHjU18mKGVBSxjhtdXOyzaYiWE0MebOJWAfq4ZH9K7naaeq9VWqYoR4PQ7LGJ0tEq0/
	JbWGshdYYQt6ZGdVPyboGeK/1usvTcthAYAPZrcm5HSP9JTnVSXrhvVDa/QEO912Cw4pZw
	ZW2a6ZUjbVHGVfEEbkfDVeOFoBlel5LSkhsKy4ykl+85ZeXMbjeYiiIAyO35Ww==
Date: Fri, 27 Nov 2026 12:04:57 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, 
	Robin van der Gracht <robin@protonic.nl>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	linux-can@vger.kernel.org, lvc-project@linuxtesting.org, 
	syzbot+489e907b2a026a6f5fa0@syzkaller.appspotmail.com, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH RESEND v4] can: j1939: cancel all pending ECUs on device
 stop
Message-ID: <20261127-healthy-impartial-curassow-355fb8-mkl@pengutronix.de>
References: <20261126082257.491041-1-dmantipov@yandex.ru>
 <awlQJD0GXoDQQ65m@pengutronix.de>
 <6fc3db25-9bc6-47c1-9776-70a99100e6bb@yandex.ru>
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
	protocol="application/pgp-signature"; boundary="w3mqh7mxdfvibypr"
Content-Disposition: inline
In-Reply-To: <6fc3db25-9bc6-47c1-9776-70a99100e6bb@yandex.ru>


--w3mqh7mxdfvibypr
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RESEND v4] can: j1939: cancel all pending ECUs on device
 stop
MIME-Version: 1.0

On 27.11.2026 14:01:14, Dmitry Antipov wrote:
> On 11/27/26 12:40 PM, Oleksij Rempel wrote:
>
> > So I would not take this patch. Could you please test the whole v15
> > series with your syzbot reproducer and reply there, ideally with a
> > Tested-by? If v15 does not fix your leak, or I overlooked something,
> > please let me know.
>
> Yes, v15 fixes the leak reported at https://syzkaller.appspot.com/bug?ext=
id=3D489e907b2a026a6f5fa0.
> So feel free to add:
>
> Tested-by: Dmitry Antipov <dmantipov@yandex.ru>
>
> to patch 1 of v15. Most likely
>
> Closes: https://syzkaller.appspot.com/bug?extid=3D489e907b2a026a6f5fa0
>
> should be added as well.

Please reply to the patch you want to add your tag to.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--w3mqh7mxdfvibypr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCawlj1wAKCRDMOmT6rpmt
0mMEAP91AHAjayBHc1Hoapr1CDEf3YJDbzvf5w6rzaWG+cwqTwEAi5crB/rwRtb8
pWt4qMgFHqWeLnAuzKnYPS2FBEj6nw0=
=OpkD
-----END PGP SIGNATURE-----

--w3mqh7mxdfvibypr--
