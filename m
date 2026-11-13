Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794555489;
	b=gNAJtDthW5OqV2CZSLUdhNxjoUScKvl6h7Ag9QTgPOJvDPi4DHclGg3QcgbhJXeVV7nU
	 uYKWjt/oIEcHpe4r1wt+cVE4osdT1z43pWkuXAu6Hb9qD7kUJb8ZhtIvwYt/waqSI+kaF
	 UxcE1zozSorDS0cbntR9XREn+cD01QOfyXUEuieLdXKkszwpTTkFbIGoHm0ddiNsTljWY
	 YQQe6lHat3DKCvxo60T/cuHOvd9FyWY++j4uxrz6xyv06EsJQsAnr1NC8mPLOhwjj1U9c
	 +3qP4RoiNLG1dVH9xNEMriTBzhpT2Ar974whn3OmmQFVLNqmGu14/AdVii4kR+qhqKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794555489;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sLTqZ9tTB1FWNNcUFV1OcGeADUr3HAfsvAbXdJKTHRc=;
	b=tIzYw0dXuui6tChLESxS5w40TtPK2TvZKyAhSKa0gY+cmTZBgi4+Uh/bGC128N2Arnoo
	 AkevsZxlz1DaZ9BJykgyq+gqAyFibm8JTXBVVuT8yokiULk6jcHdYc9x3952Jccx2k3eb
	 tdZtIO7kPUlQskhDaC6nOgGR3WZgT7OeFY0Cmp5hS7DuAsKQztSVfe17qp0U9uCRP1Iie
	 RVhORJ2XODiMwnqxrWY7JqyhigG0CRNss3boRk/5QjC8RR+cPk1nJXF2tiFlyjESoCAPG
	 n/lkQbKVuELpznpMPpdzPIfdexDTLwx0L+xdM6PI98L2DdclcqedCyHqiOX0xE5himw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EOaOOU3M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26B7606A31C
	for <linux-can@vger.kernel.org>; Fri, 13 Nov 2026 07:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EOaOOU3M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628B21F000C4;
	Fri, 13 Nov 2026 07:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794555489;
	bh=sLTqZ9tTB1FWNNcUFV1OcGeADUr3HAfsvAbXdJKTHRc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EOaOOU3MHrXW+tcUmUTqfYgUKR2XHrCI5bixvONw5HVt2oz7uI03uw/IKfusukgyB
	 2WI2YT2pnKt+Ss57IEqjof0IdJ6o4FOF958iPSPWMlS2FlpWowyHU6j/1SuX3OQdTO
	 H05jGzWiej+tDLdAjd6cy18hi4L7QWEyNweGL0C5r240kEncqTAcyPDKKUQNN17cB3
	 CJETZTX1dxB5US2tK9swTBDK+uRs3ctt95+DoPv12VC6hWP5v62QkqeNBzSC53rsM+
	 oAaKTC6q+Pvvpvz4mmgbCH/1w1q0hsBMYJfQfVOHHa1/VfhZR5TItZ0aM8tvl66RqJ
	 ipwoc5U6dFNmw==
Message-ID: <sashiko-outbox-212361@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 7/7] net: can: grcan: update the binding file
 reference in the driver comment
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261113071325.4092169-8-mkl@pengutronix.de>
References: <20261113071325.4092169-1-mkl@pengutronix.de>
 <20261113071325.4092169-8-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 07:38:07 +0000
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
- [High] net: can: grcan: single-word handle Quchaosheng in
  Signed-off-by trailer
--

commit 790597b86422386244176a3f727ee476daab6ccb
Author: Quchaosheng <quchaosheng000406@163.com>

> net: can: grcan: update the binding file reference in the driver comment
>
> grcan.txt is replaced by aeroflexgaisler,grcan.yaml.  Point the comment at
> the new file.  No functional change.
>
> Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
> Link: https://patch.msgid.link/20260929073703.2748220-3-quchaosheng000406=
@163.com
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

[Severity: High]
The Author header and Signed-off-by trailer use the single-word string
"Quchaosheng" instead of the spaced full name "Chaosheng Qu" used in commit
2c42ef8efdf2 ("net: can: cc770: update the binding file reference in the
driver comment").  Documentation/process/submitting-patches.rst requires a
real full name in Signed-off-by, and the unspaced form splits the author's
identity in git history.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113071325.4092=
169-1-mkl@pengutronix.de?part=3D7
