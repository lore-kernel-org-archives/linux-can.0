Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793980842;
	b=ot+1RwD9HKhXiI8moZXG18jhaZ812DLB8jpkDTM14stsv3In7XtURWqbF/fNUyDWa8dV
	 fp/1+sE/r3nVLiU/H3mwOUVkA+CRHz5D6j3QvCwkMYoNt70BMlmvfsrLKPDK4jh0izvRi
	 ETobJ3X/nxzQXbgMsyzdTde4UTMQXXX9RJjmPe+tL5Dt/q8a60N2ia1ta/f9VAPM8TBoA
	 GLpTCdKRzHzIiI3rxBjyL2XU7HYWY49Xg5cXJoGUhYGYZRdWmWkRnX57hY4znc7tp42o5
	 ABvJ+kne55Xs9CVhubLKeCA31baV2x9y+V+cquSTJPR9BHmagK138ti7MYA/RAbPtFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793980842;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MXVXv79FtB1kEJVMXAyO5vSqrHBTFMIN03ddvhdNs60=;
	b=sH8fZMzy4hTAc50S1Obpgg7UXD5kdgq0Ly3eTRnjRqpEsxmbXMeQCeVJTBEQ+DAFkl3w
	 QIWCTpWJuTB2jouhuh+FRKGlzay0n26Snktj+80MXsCUlNAwU9s5HIBZfQd07YoGTMOwU
	 PyLYcSfPbxR3zY/v6ZwrvnXgdQpEFZ2/iNEYJDDyfbftNKX0i75OcIvVmZqxCDPY9f6Hv
	 4IouJOTNpEy3K61Qj7rc4DqCGVM2ajZG7As0UKP0+9Dm30yat9CVve8qiEx5Ue7wOHhai
	 Rbb1hoNejA7WYp/I/ETQU7Cff5ek0FOwESn9dDh5Wwfc2O31o+ZvWPnYSQfMEqUbA1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R9fsS3Ke;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED24606A326
	for <linux-can@vger.kernel.org>; Fri,  6 Nov 2026 16:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R9fsS3Ke
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE22F1F008A1;
	Fri,  6 Nov 2026 16:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793980842;
	bh=MXVXv79FtB1kEJVMXAyO5vSqrHBTFMIN03ddvhdNs60=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R9fsS3Ke4sDdExCwlwWvuZnMMimXwZBtiPUCCHrb/LXP61fU2aYSBo9DCG1hXRSeV
	 pZBXDZPdfOgAy/oGHIIRs5aWJO69yh1/kdcOtAytpicVZo/P2QGyov8CR+RGx9+gHy
	 ta3ZNGwFMPJHOHj02w8Xnxkj7w6rCXFfvgB3KMAF1ZHseO51w25oWCH7BY5OuEhG81
	 84yrh5L6NYdg0yJWoDdujJ4pHaBiOaNamxyLNKc/ZCScgg0kPEAID2s/leUOIQX1j2
	 gkDFJtXDjXUkUlpU4az+p9PBQVM0MM8cOmZMRZFMFoIZIZReL1CMCy3V/Mv4gJat/n
	 aYMmWZw1bbg4g==
Message-ID: <sashiko-outbox-201756@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/2] can: j1939: fix possibility of list corruption
 in __j1939_ecu_release()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tetsuo Handa" <penguin-kernel@I-love.SAKURA.ne.jp>, linux-can@vger.kernel.org
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <396b5de7-3fe0-474f-9194-b4816fde7182@I-love.SAKURA.ne.jp>
References: <396b5de7-3fe0-474f-9194-b4816fde7182@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 16:00:41 +0000
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
- [Low] can: j1939: missing Fixes trailer in commit message
--

commit 7c4d9fd75a33f174106e559336bfc8df216a8f66
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

> can: j1939: fix possibility of list corruption in __j1939_ecu_release()
>
> Since not all callers are calling j1939_ecu_put() with priv->lock held
> for write, list corruption might happen if the last user called
> j1939_ecu_put() without priv->lock held for write.
>
> Fix this problem by deferring release steps to WQ context where we can
> unconditionally hold priv->lock for write.
>
> By deferring to WQ context, readers might find ECUs which have already
> reached __j1939_ecu_release(). Therefore, allow using an ECU only when
> __j1939_ecu_release() is not yet called (indicated by ecu->kref > 0).
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

[Severity: Low]
Since this fixes unlocked list removal in __j1939_ecu_release(), should
the commit message include a Fixes tag:

  Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/396b5de7-3fe0-474f-=
9194-b4816fde7182@I-love.SAKURA.ne.jp?part=3D1
