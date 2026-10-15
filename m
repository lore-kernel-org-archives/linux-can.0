Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF344E56C6;
	Thu, 15 Oct 2026 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792076728; cv=pass; b=Vv35qWRc0kJjGrBbp+ChFzyWGYgl9SiHn9fNjuXJy5cd+aTw2Yi/0a5pNrBkhyKyXpdLJN/enKxqrqap/WTUXY8/yZpuQcIwFYS1Ks94SVI14a1s6UrU+djN4P2LyA3ssXPN1Z782evJ6UtsBnt//tMFtxEsIZHkb3gIpMmTJe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792076728; c=relaxed/simple;
	bh=yOUdyLoJbgngqAiK5WpuKQJyz6Ta5+CI0sQ7w8XL28g=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=hA1PQ1oKdekok2mPh6o/IBpAVoK391+YJKsvM0y0zbkU3E3d13/vZb3qS2N+S7e8Ly+7PGnf0eGdKlGNeYorsJnd1Yw01m6t57sq8WdxQCSKvpctrhY+RABo+0VGHo8YheyAJfotIp6i19lQZsBwRwiCkkFQOr6f/9OSfTBoTdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Eie4RBsx; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Eie4RBsx"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 422C72027F6;
	Thu, 15 Oct 2026 17:05:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792076716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TYdla+PqI3wsjHkd5101uWBVNz379TLzIPl97+TUntY=;
	b=Eie4RBsxT/AEhNd2oF/h9gdiTlZWNDMc0G4zhnIK5bGNjr0QtfGRR3YKrgui1MmVdVdfqj
	WJK3qzO+jhM7AvdsrQyPYmIIJTu/eRgFuWRiJbmtCDKxhavjAzFFc2f3E8EzYpNVchzlps
	CAt7JfiQKqQq6f5hMD44D1Y9w8Uia7TFW1rafowgvyJ0iMGDJwY2ECPTgpecmNWR45HIFQ
	xrW1jQU0Vh4bA7+y5XcMEwNQpUY7SZso5MUbZ77KEm3gR9KLtmorRYlX+61cxKS68OcRlI
	i6tPys2xs5YHLxid+816v7daAdc2CsOuEnMyDx+PSZP2K0cXuT4JzvWcYwliww==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792076716; a=rsa-sha256;
	cv=none;
	b=JexLc8E+Sh4lxtRILA9yZ3Q4d+9LAR1ILfCCqeHuobTWY3ZtutuKcL7nqwmplWOJrLspfr
	KcFe43TyKz3K9um9N4PXD5kB4fSgm46B1PIjWk2tlKKo8HseInjiiuVoGL65wjmCGhYoyg
	uvzutLhlk+PMO2iB6cnVyhMxkgRnBJ0wi5B0JqQVITmm4a8+2IJE/YFqOTLRQvFSuJkamw
	8FvOtvMJX42o2y+tZo3tv0/Jtx5gMjli0nIMWSDwubMO5MnPyvtlYJBY27DiGJtg+AByiw
	OVH0dONli55YgYQ1fY3MJwg6nGdJFko9nii4AXFYGlkofhjFUo8UIua4rMtpAw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792076716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TYdla+PqI3wsjHkd5101uWBVNz379TLzIPl97+TUntY=;
	b=X3UotEYCcgYDFMoGzJHklnyRW+SMXIBPsiVaB+T1Vhzqmp0H4a7h2IVoI+d0l/dWoQtDUV
	W2zyLG3ItsgE1Y5xdJ7RSsJWbtVWUtx6oRJ5crNE4ngbx/0Vtcz5hK80P4QApdwsLr+xuY
	gvZSDO4GGlyxVsTz9knVjv7aE9Z+riNVR99K+tZ9P1SIRKfBn+WNk0KSo0ZQGOQzCK+yqa
	HZtLKjAucDIiK0Rl0JaA3nrAQHwowDwDoTJKq/ftTR8opivPf7hQHzVor6CTyFymLRm6Ex
	hs0nyKyAnV/TUfv8pVvIQQjTS80uqL/jz+6SD3Qiw++h/QYcWhyC2XfuiItBtA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHN1A-0062cg-0Q;
	Thu, 15 Oct 2026 17:05:16 +0200
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D52DD5C51FE;
	Thu, 15 Oct 2026 15:05:15 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net v3] can: flexcan: flexcan_get_berr_counter: don't
 wakeup controller if interface is down
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, mkl@pengutronix.de, 
 kernel@pengutronix.de, haibo.chen@oss.nxp.com, shawnguo@kernel.org, 
 imx@lists.linux.dev
In-Reply-To: <20260930062738.30145-1-chunyuzhiqiang@yinhe.ht>
References: <20260930062738.30145-1-chunyuzhiqiang@yinhe.ht>
Date: Thu, 15 Oct 2026 17:05:09 +0200
Message-Id: <179207670996.973975.6070771111462330170.b4-review@b4>
X-Mailer: b4 0.17-dev-6be7c
X-Developer-Signature: v=1; a=openpgp-sha256; l=814; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=yOUdyLoJbgngqAiK5WpuKQJyz6Ta5+CI0sQ7w8XL28g=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsi68HrF0hk3cyQF56pYJPHoiZ05o3h10xPtFp7ApNo5e
 z/NMg3b01HKwiDGxSArpsiy9McJRYFAh9LelwmTYOawMoEMYeDiFICJCJxlZJgUdiHn87UE/ZOm
 izbEMZwSL85Vuhm67E7HBNazN8OaH21lZDhaYv3r5Se/3xFH3F+4HAxT4Pbq0Z21XPTIFYmk9zP
 WTmEBAA==
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

> [ ... 25 lines skipped ... ]
> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
> index 30ae7c344a05..5903f450d30c 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
> @@ -765,6 +765,9 @@ static int flexcan_get_berr_counter(const struct net_device *dev,
>  	const struct flexcan_priv *priv = netdev_priv(dev);
>  	int err;
>
> +	if (!netif_running(dev))
> +		return 0;
> +

What about fixing it on the CAN netlink level? As far as I can see,
can_fill_info() is called with RTNL lock, so it should be fine to move
the check for netif_running() there.

>  	err = pm_runtime_resume_and_get(priv->dev);
>  	if (err < 0)
>  		return err;

regards,
Marc

-- 
Marc Kleine-Budde <mkl@pengutronix.de>
