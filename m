Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794288551;
	b=jwn0OYTlFTXcMq1VBMyqhi63BhdO0ZIPFV/LeIzTGS3QVafqnv9nwR7V97sUyvBGlWxH
	 ST2eqePDQ+ehsam0cQAwEZA/jRkhUIgOn8HqANmaPOmijRCjcWfwcHK8Hd/vaJDsCTU/C
	 YkKJYqnVLiO05v0bVKkpdTVNwGK9jo6mfjPumStXl61eQrVRSiDdXA3G0zyMRlqGt3CuT
	 qo8E0Wdo6/wBFtw0cj2R8XWB7LiuT5N+3jl8xUszXtEQmaW3z/yiDDnCF79WS1dukd6ku
	 Mv9WB152vxJPItuyoszR96XUdlHOSkwre8/B3GXQPo/a2qBQNZx2JhKMlFINFYxkiyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794288551;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=u8bqrC6DOLsDczSispRZZmJYENvo9IK+X+z5l4hJbzY=;
	b=msp3eQb1HRDfdajIY850BkAmpPqXn5hCmKaFX8FGrqSQl2Ib8oW78WZGbPHRZga3XxJG
	 mtqfPt0qD0UaxsFkTxMrz3xOJCW3eMEJRMCCAcLDewTfQTO7V2Z/FzR+JTS9lFREebMWp
	 qJId6zM83KQnfjQuMdp9dSG5jrBWjgGVtaGxlpQ1ScD5awjaZsljdUTqF7Te9z/I1CSlQ
	 jejqBX5rhYzia4BPNpVS7uxwcUAD2Qu4D6T9B0h07prz5SDfC5tTSSLamNs2G2dS8PL+B
	 pKve/LeoyJuxmdkxYbY+Oh916z65KXfW7MrbOwHWlKMdFWEEN9sJ5if0bAU5TDhoo0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nE1HGJWu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB2D606A32A
	for <linux-can@vger.kernel.org>; Tue, 10 Nov 2026 05:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nE1HGJWu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5752E1F0089F;
	Tue, 10 Nov 2026 05:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794288550;
	bh=u8bqrC6DOLsDczSispRZZmJYENvo9IK+X+z5l4hJbzY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nE1HGJWu3u1/28cf86GpiMaNHv5Gi5SJ2pGMlG5oETysKAF1+wKixc3RCCcwHGgP3
	 XbPXVoWu6gQyFKunoG0tBILEY4w+7e7CRI9VNJxerSwP/CpjpFxihxNltmvJ5UURSg
	 avpf3imQ0mX/aClyMcGAuPoI1MnZjBJPhteazpvIT66pKfiy7xPBw+W0wxQwmzt/Ui
	 cjVLZ43j9Q8F0V2dsUVZioFU5b0/01UJdAbyP52eTyIYahcFUTK8Q1GA1GRGtaj54c
	 JOa/I/y3G9FPpTHU/7SsmZXDWYnA0V0uMdLBGLuR536qu0IWcrMrcIPgS/0UZonywZ
	 eogILb8xQW8Lg==
Message-ID: <sashiko-outbox-206293@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] can: bcm: Account cyclic transmissions only on success
Reply-To: sashiko-reviews@lists.linux.dev
To: raoxu <raoxu@uniontech.com>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <45A9B6D8611C63C9+20261110052315.253367-1-raoxu@uniontech.com>
References: <45A9B6D8611C63C9+20261110052315.253367-1-raoxu@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 05:29:09 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] can: bcm: missing Fixes: trailer for bcm_can_tx() bookkeeping
  fix
--

commit ca441329b91ed7ef08326f38c9caaba62d3a18f6
Author: Xu Rao <raoxu@uniontech.com>

> can: bcm: Account cyclic transmissions only on success
>
> The CAN broadcast manager advances the cyclic frame index and decrements
> the initial-interval transmission count even when can_send() fails.
> For example, taking the CAN interface down makes can_send() return
> -ENETDOWN, but the timer still consumes the configured transmissions and
> can report TX_EXPIRED without sending a frame.
>
> Only update cyclic bookkeeping after can_send() succeeds. This matches
> the existing successful-send accounting of frames_abs while preserving
> the concurrent TX_RESET_MULTI_IDX check.
>
> Signed-off-by: Xu Rao <raoxu@uniontech.com>

[Severity: Low]
Since this fixes a bug in bcm_can_tx() cyclic transmission accounting,
should the commit message include a Fixes: trailer:

  Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/45A9B6D8611C63C9+20=
261110052315.253367-1-raoxu@uniontech.com?part=3D1
