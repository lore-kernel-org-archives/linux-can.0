Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795109236;
	b=0ELlOlWuruCY8TlmZs4XqE754X7E0iaQA30ayt3h+S4qG7GmHv+BbwQ9nbtwq3SBkSTA
	 ElELg5nNtc1Y+6gzGTenmTwpayEs0tb/L8D68/nNlGlnFKbQ5TrAHhRYz6uzrSQEAe7D4
	 nDpMRmukqVOWpt6FedayR3lvXlI11XetlMti8n3k+X4I6+jgIuXfX+okiI1NshaFzvEja
	 Hh/2W2TzenRnj68WM5VumC8q7NN2FxjZVC1Dxqxm0Js0wO/ywvYezof9malNMbmoagpS2
	 yIRzk/+jaEdXWf1QAPGsgDEGqGOtNgc0zqaMJL2g3PLDaIPKhI8ZkePQTcVGyjqW3jA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795109236;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=zciZXY4vC8bWHy4KibC0d8i0G8WUWM+VD3GW+5FyvXA=;
	b=kC29dgdZwkMDE2GwhJi+P/bI4Foe9FpS2ruyDUPRXIBcXi9oBZU9uxZAkNDydJC+K6qu
	 8EgCRrvmqCkDnjPXxB1cREBis5EoKtF4SA4G+0y9mExzxIhLmzr4uhvFExA7OGXVc8bwT
	 MPVtXkz+irnbsd90VHGTW34kV87S7BjS9h19bYcQ08OSk2oQsepmR6RHM2fzqtG36WgR2
	 vxcuHo0UIQj1vQpK+eu1rK2Rdx4JFvVBxnDvYwAOMMfh78ZTIRs6Yl2a6sx1vbtx68Cn2
	 /SLuedpXRyxsntBfX+SCEn/kiQ1yWo/Zybq1uI+ISp65LEgQYH8XYfguvKH6KLMuCjg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=PEQkz4w+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D676B606A324;
	Thu, 19 Nov 2026 17:27:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D676B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=PEQkz4w+
Received: from pengutronix.de (ptz.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::77])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 8DA98205AD4;
	Thu, 19 Nov 2026 18:27:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795109228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zciZXY4vC8bWHy4KibC0d8i0G8WUWM+VD3GW+5FyvXA=;
	b=PEQkz4w+Nk3KebvfA2gkm7+QlDANoJyAKJ0LSiq8re7x8P/HUZIQG8dms2AstOZTBwLjX3
	x1lUD53xIM0X5gVq6YQ1dWteAa2ExX8DUovUBVEx1/MlPwS2T/fO2am2QmaOEUHnFWrxgA
	x2a+Mwp0VDbxOvvPedSMFYz2YDt+7qfqn24D0KgbHndJri2K/bmf+LLGC2Beg6/A9EbNbR
	5U30q2YqQBWWcvC4Pw8/WHgSIElieJjzDhRxYQsgcyek7X4XfwOReUF+eB0KCHkfKjmv+7
	C4Q+3GK23mZ9hK5cCSey/xi4EvW4DqDquZ0hjIAuQrcLLB9uFgoUe391kAjtAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795109228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zciZXY4vC8bWHy4KibC0d8i0G8WUWM+VD3GW+5FyvXA=;
	b=XqtUXKKB2zG+pu5Buow9EzoGuSqGSnjQ4tMBh5O3Mx4PjHjEVVqM1OfY+agcubfobTPYFl
	QbYywZJE9r/6GHwfD2ZHbxlh8SpwYPUDXCxtINVKJpCpcbQQhOx5OYBr+IcGVSDw7sfj0w
	WcKRhODTnutudKoMa8l696aA0A9u7Vd/IJLFB4upFAcMkcK4PqWR2knd/DlJo5tMT5KihQ
	2lB0KVBxCy8V9hUC/+mUFqZJZRHuYV6S/u6o7Hq3oeALsEqsqogyKx8ob+tzPT0PhWryV8
	b6W2QdqjrQtPaNEqi03eDoj+MzlQUU0Eefm63m+xGSl/WlSidQ6+2oa/BJCrMw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795109228; a=rsa-sha256;
	cv=none;
	b=AUwccUTAnnRsbhYa0DiIxKEWkrEtESMeNAWYXwHJ076IuQwBKxm2y1f1IE/g3ZWAsMIrtO
	v2sMAo2xzQrxud8TXWmVFjtT2ZrQEyZ2HXiOwNUvN/hX0tIAP4LZ81TgGYrIPULv/pQ3sN
	rBbPvLwggDN7ZhpCYZmuEht2HlMqCfWfeYMtzo2oq/eef9WUpgJ9+eLUzpo8DhRpxVXlug
	iYhppoFX9U2ccXBSIhwczq/fHdnJWp/+A9DUi0CTpLWTYTkzq+nX5GJJNmsnoBHaiSrMSB
	6qkSIEBjF3VI7j0iXcAmZP3e3VUyqe6hfsZvj6W/kw05Qk3lp0IkpyhEo8W6+g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Date: Thu, 19 Nov 2026 18:27:08 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ian Rogers <irogers@google.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, Elkin Cruz <elkin@google.com>
Subject: Re: [PATCH] can: softing: lock card->fw.lock unconditionally in
 softing_card_shutdown()
Message-ID: <20261119-magnificent-ecstatic-alligator-3f4816-mkl@pengutronix.de>
References: <20261119170722.1524088-1-irogers@google.com>
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
	protocol="application/pgp-signature"; boundary="ym6cm37bolbibfid"
Content-Disposition: inline
In-Reply-To: <20261119170722.1524088-1-irogers@google.com>


--ym6cm37bolbibfid
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: softing: lock card->fw.lock unconditionally in
 softing_card_shutdown()
MIME-Version: 1.0

On 19.11.2026 09:07:22, Ian Rogers wrote:
> softing_card_shutdown() calls mutex_lock_interruptible(&card->fw.lock)
> with an empty if-body ('{ /* return -ERESTARTSYS */; }'). Because
> softing_pdev_remove() invokes softing_card_shutdown() before
> unregistering netdevs or removing sysfs attributes, a pending signal
> while card->fw.lock is contended causes mutex_lock_interruptible() to
> return -EINTR without acquiring the lock. Execution then proceeds unlocked
> through IRQ and DPRAM teardown and calls mutex_unlock(&card->fw.lock) on a
> mutex not owned by the current task.
>
> Use mutex_lock(&card->fw.lock) in softing_card_shutdown().
>
> Found via an x86_64 LLVM=3D1 (Clang 21.1.8) allyesconfig audit with
> -Wextra-semi-stmt enabled; fix and changelog drafted with an AI coding
> assistant. Build-tested under LLVM=3D1 W=3D1 (-Werror) and -Wextra-semi-s=
tmt;
> not tested on Softing CAN hardware.
>
> Fixes: 03fd3cf5a179 ("can: add driver for Softing card")
> Fixes: 47fa0336c1b7 ("can: softing: softing_card_shutdown(): add  braces =
around empty body in an 'if' statement")
> Signed-off-by: Ian Rogers <irogers@google.com>

The driver is being removed in net-next.

https://lore.kernel.org/all/20260815103428.117201-1-socketcan@hartkopp.net/

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ym6cm37bolbibfid
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCav8xagAKCRDMOmT6rpmt
0tWqAP9cUPcev34kjMjE0SNws7hdhLWrdnycd4JQ+784eMFnqgEAmKFOGxm61/VJ
914HP6niNYA6Q5CtJhuLfRh1Mfb/HwE=
=ylIV
-----END PGP SIGNATURE-----

--ym6cm37bolbibfid--
