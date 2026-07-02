Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992A030BF69;
	Thu,  2 Jul 2026 16:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783008098; cv=none; b=da6RqwaLMKUxZsw470yDV7dCAIeLCcuS1J3v6/4aU0Sbi0F11SM8ugmcSryIiLwGtrLiodL8cjSSne0F3Ks3uDihr54W3cwXNc286kyGHLTCvlBlcGx650B/pqZE3MuZk8VoPF3kOqeBMSeWBFQu8M2TsahKUJV1VJ+gnnQnKp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783008098; c=relaxed/simple;
	bh=HJO9Vc1JV3HJgPXPr1kg9YbyWutgBqcKBd83/RCllPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aO2fqW/Fhy32HzjhkjYSx3YnggjNRqf8SuoBeNmwpEnRagWIA1pbifhxlQX9I78zuMUz3b2fdn+1iO7OnnQZyn0tdVxwQJJEMu+8cABYunM6FFNU5BccGuxQewykaW2Vo4kLo0SOibiM+b9WZM7TVBiIiHQGOQUu0sA4OVGxTY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=RqesHXHX; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="RqesHXHX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=r+wrJuVhFDbFHGAbhIGnA2cIJXtpLd/P8h4Mv8rR6ZU=; b=RqesHXHXaYOPCKhUf9LBqc52Pd
	Nx8ajwVcRXhNtLf33JzWPlsmGpA6yjCpfX1JTkYxG2/dnhV69dQsPFzEMpcZLFYA0W6SuXklLRkg/
	UPtKVC7irgrR+C1Dd07QhNbeQAqMonruQ2vBXPY+pBx/HIOWgm/WONwB6BAwPGqvkl7tfZ1A4pqBj
	cY+uvDNZz5eiPgIbRoDBIu/q1rW13g40ZAu/2OI4k7QuIeFd+67dJzQ0K6tdBU8hnSGOtrE0N1rfn
	z5l/Htbn3wRbSBIpd/Enf1ZiZJe12ef5FuwDawa1pvfNzUcczyQfJnH/Wqyf4AfRA/48dqMgF3GHZ
	2MfYmDMw==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 linux-can <linux-can@vger.kernel.org>, 1579567540@qq.com
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
 linux-kernel <linux-kernel@vger.kernel.org>, Cunhao Lu <1579567540@qq.com>
Subject:
 Re: [PATCH v2 1/4] dt-bindings: can: rockchip: add rk3588 CAN-FD compatible
Date: Thu, 02 Jul 2026 18:01:06 +0200
Message-ID: <2459655.BjyWNHgNrj@diego>
In-Reply-To: <tencent_3B2B6003D1DE4FB7A984665A062581766405@qq.com>
References:
 <20260702140654.2961561-1-1579567540@qq.com>
 <tencent_3B2B6003D1DE4FB7A984665A062581766405@qq.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Donnerstag, 2. Juli 2026, 16:06:51 Mitteleurop=C3=A4ische Sommerzeit sch=
rieb 1579567540@qq.com:
> From: Cunhao Lu <1579567540@qq.com>
>=20
> RK3588 integrates a Rockchip CAN-FD controller variant that is not
> fully compatible with RK3568v2. The RX FIFO count register field is
> encoded in bits 7:5 on RK3588, while RK3568v2 uses bits 6:4.
>=20
> Add a dedicated rockchip,rk3588-canfd compatible to describe this
> variant. Do not use rockchip,rk3568v2-canfd as a fallback, because that
> would describe a register layout that does not match the hardware.
>=20
> Changes in v2:
> - Use enum for the single-compatible entries, as suggested by Krzysztof.
> - Reword the commit message to explain the hardware difference instead
>   of referring to Linux driver match data.
>=20
> Signed-off-by: Cunhao Lu <1579567540@qq.com>

after fixing  Krzysztof's comment:
Reviewed-by: Heiko Stuebner <heiko@sntech.de>

and doing dtbscheck of the binding against the dt-patches:
Tested-by: Heiko Stuebner <heiko@sntech.de>




