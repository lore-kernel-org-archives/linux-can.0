Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795861220;
	b=Mj3JczLEj5FwJTGpNEgduJss1AaAaVqkH3OTfqElbM/m1HjnLhQba4ORBpRgQB45b6Ls
	 XORgJUKct/FB77E0eeYbE7nu+hDnUqjTvIZzGPkYBU0JrA/IEEO3ox0cSQ6mwE/eGqLag
	 EHx23ARf1SC9UdDRyyGUBB/BXP+jMZsedJl2sLkphttDnMXTnsnxiXjZBdb4RFuc9tOYZ
	 bw2fdh/r9wXEWksn+9vukqNjB6EkXIu7DtHAavuEJU/JYu5q34I8RU1CzbaJzVV4+Xqe0
	 eiiDypZmEojhj9JDkxqVbKyk6sD2wtRmPwkVO0h7V8fq0OOH2LyAN5jHSbGFfyqiWFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795861220;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=wW25UtAi9550o7VS4vHtatvoAygmSe0XQlRnDzFnZyQ=;
	b=YuWvymuspPqUglfEFLZ0E+x8SEFHVXJSh9L9q/hhsZjT2j+Z6DlOGnsgAFlwOcn0IsGO
	 MwxG7zXRRuPCszU/I7cxeXLKHTyzfiPcEVeAM9MVZg+V8HuerE/qA7HRMJsGoCXrXuD+a
	 fJXrngjwUsxKaYxk2ohA8clAci4G3Dvdrx3eN7/aBfE94iyJemvs8loX7tj0IRvEEoMx9
	 JKzF6OfMqqVIcq+O4vlDpjY4k6Q3r0mlTH0YeRXU2V75FCKzFPdBryU7APVnac9dgFB8x
	 hNIHTsCLUu4qsgQ2aIok3KQXijKBy/PqJmbkeFKb6IqBFaDtrVbYGZAIL7SoiADjFiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B96dCcfm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF087606A31C
	for <linux-can@vger.kernel.org>; Sat, 28 Nov 2026 10:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B96dCcfm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ABFC1F000C1;
	Sat, 28 Nov 2026 10:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795861220;
	bh=wW25UtAi9550o7VS4vHtatvoAygmSe0XQlRnDzFnZyQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=B96dCcfmwticMLNg5d2iQKpoSJUBwtg/t9xZJQchVtZI+0Ehs3PvtOcrIZarMsX8T
	 IzVkFTqMAnQAzPPlT067CjSADeDT7aNmW1WpE43A7aL7Y40sLLWBdYNxdSu8VtGP3f
	 zgQ0D//xSTE3Az+0xZQwsq6V3l7nv7x5QofyeoEzrX1GSFqMGqW1DEiRVbP9U8vWDB
	 klHZJXqy8ucLoBVzcsU6lAZ3lROppBxK/ssDbIEEsVBXATl/VbtenQ/P2anj926LLN
	 OTaIjdxMc3wSIbzhRDWSOhn9gDyAxwG6kwC7j4xEQGem4tb/TM0DZWpD0fRq7g1H+Y
	 ilsJIzKyvBA3w==
Subject: Re: [PATCH can-next 11/22] can: isotp: check the minimum FF_DL
From: netdev-bot+sashiko@kernel.org
To: socketcan@hartkopp.net
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, sashiko-bot@kernel.org,
 zihanx@nebusec.ai, o.rempel@pengutronix.de, yewentian395@gmail.com,
 kuba@kernel.org
Date: Sat, 28 Nov 2026 10:20:19 +0000
Message-ID: <179586121974.3131.16556762186745483612@kernel.org>
In-Reply-To: <20261126-getsockopt-memcg-isotp-v1-11-681ef8d8c2c9@hartkopp.net>
References: <20261126-getsockopt-memcg-isotp-v1-11-681ef8d8c2c9@hartkopp.net>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message for "can: isotp: check the minimum FF_DL"
  describes the old receive check in isotp_rcv_ff() (net/can/isotp.c)…
- [Low] "can: isotp: check the minimum FF_DL" fixes a receive-path
  protocol bug in isotp_rcv_ff() (net/can/isotp.c) but has no Fixes: tag.

--

can: isotp: check the minimum FF_DL

This commit replaces the FF_DL lower bound check in isotp_rcv_ff() with a
check against the maximum SF_DL for the sender LL_DL. A PDU that would fit
into a SF is then no longer accepted as a FF, which matches what
isotp_sendmsg() does on the tx path.

> ISO 15765-2 requires FF_DL >= FF_DLmin: a PDU that fits into a SF must
> not be segmented. The rx check only ensured that a CF is needed and
> contained a SF_DL escape offset for LL_DL > 8 which is only required on
> the tx side. So e.g. FF_DL 7 was accepted for LL_DL 8.

[Severity: Low]
Does this describe the old check accurately? This was the old check in
isotp_rcv_ff() in net/can/isotp.c:

    off = (so->rx.ll_dl > CAN_MAX_DLEN) ? 1 : 0;

    if (so->rx.len + ae + off + ff_pci_sz < so->rx.ll_dl)
        return 1;

It only rejected FF_DL < LL_DL - ae - off - ff_pci_sz. That means it did
not guarantee that a CF was needed.

For CAN CC (LL_DL 8, ae 0, off 0, FF_PCI_SZ12), only FF_DL < 6 was
rejected. FF_DL 6 was accepted even though the FF already carries all 6
bytes.

For CAN FD (LL_DL 64, ae 0, off 1), FF_DL 61 and 62 were accepted. The FF
copy loop is bounded by ll_dl, not rx.len:

    for (i = ae + ff_pci_sz; i < so->rx.ll_dl; i++)
        so->rx.buf[so->rx.idx++] = cf->data[i];

So for FF_DL 61 it copied 62 bytes and left rx.idx > rx.len.

In both cases the receiver still moved to ISOTP_WAIT_DATA and sent FC CTS
for a CF that a compliant sender never sends.

Could the commit message say that the old check also accepted FFs whose
whole FF_DL already fits into the FF? The FF_DL 7 at LL_DL 8 example
understates what was accepted. The code change itself looks correct.

> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

[Severity: Low]
Should this have a Fixes: tag? Without this patch, kernels accept FFs below
FF_DLmin in isotp_rcv_ff(). They then arm the rx timer and send FC CTS on
the bus. ISO 15765-2 says such FFs should be ignored.

git blame shows that the replaced check and the off computation come from
the original isotp commit, so this tag might fit:

Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")

Without it, the stable trees won't pick this up.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9%40hartkopp.net
