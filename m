Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF53E438013;
	Mon, 17 Aug 2026 16:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786983927; cv=none; b=IDYeYGLIoUTjSPdnAHGXtRsexAjOJouOct74tYwcnLOpKFDbfhdRyUZ1Lk3Vj1zBeEI3PkBW1NHGcg+kT2wPMAJ43buFsM0hVmZ/1UGeejFCaiXn6jA7ytIa/zdmhzrXynl3d8HUbBcO8347SF7+4jP+yI0d+93MpFuxwAO8/4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786983927; c=relaxed/simple;
	bh=kwoXrp8C+hruNmgyiPm4UUSVNFsKcKB8oPebQhmaEjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hCyPvMqi2+BSxyrJM6/tuwMNGFm9d3+9tBz1sAM9BDN2Uw/MNUY5x8mezbXn1pfYtXwCtSNbCr/FrjNFlR27BN5tkyWIjp6gMFZBhfuKAtoYhjdgHuV1ts+fauG6VGPp1xidqxTmlgTZGyubuVXeiFPfMP4uUdsLtSbWixtrL6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=AYFPdpef; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="AYFPdpef"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=itpN6ATWZzDI6Gf6iahFT31A2k/lQeZZFl4EfK17TNQ=; b=AYFPdpefVLE763eFsrJfYx22tO
	4KsmLt40V3mczAZnJV//laYr/5Djz88BSJNiThqm01+FoW5aaVex2wIvTfYao+UgMlWsIsWMeMOTy
	CC0wKFXxE/l/i8nSi4l862JXjOnc0F/edk8ShneewT8MdwNnoqvLJ+xrCNBogA3MTt8VYCNe+yePg
	O9jLvtg+6cfb17mJ3slNFscQzK+MEHXTj2LHX1JTrhtCTpYsmEmXEoj/qHIs0UhPpyIZ+5ur0jFSM
	gcmHfwvd1C8YeNIAw/dwl55BNk6qq/sSq6x/7ZUCVCQGQyN9sf6R/yAvdxQv1ZEtxlm7NW3stGjRx
	/s24wrcg==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Cunhao Lu <1579567540@qq.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: kernel@pengutronix.de, Vincent Mailhol <mailhol@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v6 0/4] can: rockchip: add RK3588 CAN support
Date: Mon, 17 Aug 2026 18:25:02 +0200
Message-ID: <6011470.tIAgqjz4sF@diego>
In-Reply-To:
 <20260817-guillemot-of-premium-saturation-6b893d-mkl@pengutronix.de>
References:
 <tencent_7BAA0052C402BFFD26291A64198084E39107@qq.com>
 <20260817-guillemot-of-premium-saturation-6b893d-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Montag, 17. August 2026, 18:23:03 Mitteleurop=C3=A4ische Sommerzeit schr=
ieb Marc Kleine-Budde:
> On 30.07.2026 22:34:01, Cunhao Lu wrote:
> > Add support for the RK3588 CAN controller.
> >
> > RK3588 integrates three CAN-FD controllers that are closely related to
> > the existing Rockchip CAN-FD IP already supported in the kernel. The
> > RK3588 variant is not fully compatible with RK3568v2 because the RX
> > FIFO count register field has a different layout.
> >
> > This series therefore:
> >
> > - extends the existing Rockchip CAN-FD binding with the
> >   rockchip,rk3588-canfd compatible
> > - adds a dedicated RK3588 match entry and devtype in the driver
>=20
> I'll take the first 2 patches.
>=20
> > - describes the three CAN controller nodes in rk3588-base.dtsi
> > - enables CAN on the RK3588 Tiger Haikou board
>=20
> The DT changes should probably go via the rockchip tree.

yep :-) .

I'll pick those up after the merge-window.


Heiko


