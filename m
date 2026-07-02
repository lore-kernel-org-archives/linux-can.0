Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB502D8DC4;
	Thu,  2 Jul 2026 16:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010217; cv=none; b=JmVBhv8Ap8iXnzScgurrTMOwF4NxTKKU9C7OcT+tt4QcC4ez2xOv/evr1uDzk7MsuxTM9d/GYzr5wOYQiaDj6Hq4BJmEi6feZkookjGIZGeMQ9u9x2RBGKBStdUgz8fPOS1Ogmxk4aZNjJmETdBtABijuMlIe5sTHHJBu7sgung=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010217; c=relaxed/simple;
	bh=dUpLWUSZeHCbnarM9STL88HVq9YMEGabh6ksEsFN9PE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OhyJ4ibOEv2Qzw6+M9393plybxif/jkEXHhdxR3U9PKW0P8sOzUfm32DmyxZd6MtQvbDlnMNP6dFhw0yRlu1YM5CjMrJeWFn5WU1zfpJyoEhwkjVF9LFv/Zw4VF7IIyic1CoFQx1JxNa84IVTbWxVhLJPw9h5+4R3XfhZVZUhVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Num2A+5+; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Num2A+5+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=dUpLWUSZeHCbnarM9STL88HVq9YMEGabh6ksEsFN9PE=; b=Num2A+5+4Fd1ZIrorLsEytnkVt
	9jN67/IIhlYNOJDwVyAVNKx5NjRVrouv4JpQ43ezzCpdzqHbJimO1FbKa9rDe5UJr7IorYmoo2jDo
	nUu4F/0XaZVYH8CoKWyMI1Z+GYpvY3rIWAeYPlH1hL8uHLZlN3S5gmWR8cLQwtPUTX294vlC4pFRM
	g89ajIdO2CgdqBy3kfm8zurgzeGZ893srcJ9SRbrsUI/coucNboYla5laznUD/GrmDRRcjcXylSNB
	Vhfo+wNqbk1WsOue/TX4vEah44zz3m6kv2Evow1EeCucsxhOJs1MJLQcxi5KivPCmHu/DalMxTq93
	A1IVo5ug==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 linux-can <linux-can@vger.kernel.org>, Cunhao Lu <1579567540@qq.com>
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
 linux-kernel <linux-kernel@vger.kernel.org>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH v2 2/4] can: rockchip: add RK3588 CAN support
Date: Thu, 02 Jul 2026 18:36:41 +0200
Message-ID: <6281926.UjTJXf6HLC@diego>
In-Reply-To: <tencent_8BE421601F31C26FB9E99FA6440629016D05@qq.com>
References:
 <20260702140654.2961561-1-1579567540@qq.com> <3527453.usfYGdeWWP@diego>
 <tencent_8BE421601F31C26FB9E99FA6440629016D05@qq.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Donnerstag, 2. Juli 2026, 18:34:04 Mitteleurop=C3=A4ische Sommerzeit sch=
rieb Cunhao Lu:
> > I think you might want to drop that above. If anything a Co-developed-by
> > would be applicable, but from the (small) size of the change, that also
> > isn't really necessary for me :-)
> >
> >
> > > Signed-off-by: Cunhao Lu <1579567540@qq.com>
> >
> > Tested-by: Heiko Stuebner <heiko@sntech.de>
> > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>=20
> Sorry about that. This is my first contribution to the Linux kernel, and
> I have not fully understood yet which tags are appropriate in which
> situations. Please bear with me.

no worries, I think you're doing really great for your first contribution


Heiko

> I will add your Co-developed-by tag in v3, together with your
> Signed-off-by as required for Co-developed-by.
>=20
> Best regards,
> Cunhao
>=20
>=20
>=20
>=20
>=20




