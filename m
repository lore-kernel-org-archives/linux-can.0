Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C66318EC1;
	Thu,  2 Jul 2026 16:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010541; cv=none; b=qeeSxv/yAJY3V2yw2iYC1cMrA9qEZpDaQ3y8eUeRPKcn6OceLF05GXAAkabQeybLjJ3tlvlGHgG0u2xOypG8VkzXqgIZOWs0paT9I7oZZV7NWGBk8NkvYwRzOimL30bmLRd/yI8fmGqL6T+7eoOAVl9GB3Gnkn8gaR6xiRbY7t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010541; c=relaxed/simple;
	bh=19tSqHTiXThbwMokl1+GXrVaAiFggpQsx8rgNAxcl/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IAwx54JImtIOdYrPLi00U8tWigfluaeKGL/86941VVrjne0N6QMM0vh9hyhihMUkWUsXhYXCssvxMPXLdXphNBZJU9Z/VEWFc6flWlW/DcgKWyzj8JnvrMx1m8XxIBH3KsKmiaAFHekgBYwknJN1F6FvYykcsFvp17QCICN3sMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Gh4yA0Cj; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Gh4yA0Cj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=8BWKyXVtcU1aypz3TbPj5gFArFFOSYSIbmVQ2MSXUbc=; b=Gh4yA0CjfBzQMYw+w02KsUA+fF
	ztrApVsVi2MusGUVZp4iEF/Gk+GJukF8T4u7eAYy/511gB2XClPj4s3M5/wVq9Qk0QhuW0kXT6ITz
	LNrQhfcTLIDpfIfIU7iCGG89Qnav9aVloi3J/qh8nVGLmFWgCDmnLNmuvlzbwuR895lhl9OGm3OxR
	qwi/6W+EzNVi4+jgoXdfTarwbjr+VvyPDA0ORr7/8JuynSvQg/+dLgaD8sc5Zdk4UH1MNX51o6pqk
	gTyfm2326qpd8JQzoYc8t0fk77XGNSFJgun8WSgBnaTAlM3kLui18eNUP2ChiQelzRjz6Low3KX5M
	0JpUaBBg==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 linux-can <linux-can@vger.kernel.org>, 1579567540@qq.com,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, kernel <kernel@pengutronix.de>,
 Conor Dooley <conor+dt@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Shengjiu Wang <shengjiu.wang@nxp.com>, Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Russell King <rmk+kernel@armlinux.org.uk>,
 Eric Biggers <ebiggers@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Karl Mehltretter <kmehltretter@gmail.com>, Yixun Lan <dlan@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, devicetree <devicetree@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-rockchip <linux-rockchip@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject:
 Re: [PATCH v2 1/4] dt-bindings: can: rockchip: add rk3588 CAN-FD compatible
Date: Thu, 02 Jul 2026 18:42:06 +0200
Message-ID: <4310510.6PsWsQAL7t@diego>
In-Reply-To: <636d10c0-670d-4586-b604-7559d2a24185@kernel.org>
References:
 <20260702140654.2961561-1-1579567540@qq.com> <2459655.BjyWNHgNrj@diego>
 <636d10c0-670d-4586-b604-7559d2a24185@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Donnerstag, 2. Juli 2026, 18:39:53 Mitteleurop=C3=A4ische Sommerzeit sch=
rieb Krzysztof Kozlowski:
> On 02/07/2026 18:01, Heiko St=C3=BCbner wrote:
> > Am Donnerstag, 2. Juli 2026, 16:06:51 Mitteleurop=C3=A4ische Sommerzeit=
 schrieb 1579567540@qq.com:
> >> From: Cunhao Lu <1579567540@qq.com>
> >>
> >> RK3588 integrates a Rockchip CAN-FD controller variant that is not
> >> fully compatible with RK3568v2. The RX FIFO count register field is
> >> encoded in bits 7:5 on RK3588, while RK3568v2 uses bits 6:4.
> >>
> >> Add a dedicated rockchip,rk3588-canfd compatible to describe this
> >> variant. Do not use rockchip,rk3568v2-canfd as a fallback, because that
> >> would describe a register layout that does not match the hardware.
> >>
> >> Changes in v2:
> >> - Use enum for the single-compatible entries, as suggested by Krzyszto=
f.
> >> - Reword the commit message to explain the hardware difference instead
> >>   of referring to Linux driver match data.
> >>
> >> Signed-off-by: Cunhao Lu <1579567540@qq.com>
> >=20
> > after fixing  Krzysztof's comment:
> > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> >=20
> > and doing dtbscheck of the binding against the dt-patches:
> > Tested-by: Heiko Stuebner <heiko@sntech.de>
>=20
> Makefile/build level steps are not testing. Please don't provide such
> tags for bindings. Otherwise all bindings would carry Rob's tag, because
> he wrote the bot which does such testing.

ok ... will keep that in mind for the future


Heiko


