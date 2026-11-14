Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794661401;
	b=vAWB7sDZEGQd5uJibjsYbjKz9f2tYlHeB/hWnkg4RUbFX+Pcp5voLU/QhgZtd9h8P368
	 7a10Oh1QLQ7uv5ZVdpHl0bkaptuOEZdk76bDrXhUQSGH1qeCYQp7Isq4ZCPTPoNpo9LB9
	 WJwYscGHFVCTBaprhRLH2XcEx2wKgY98pHniiHRg5hB9eB0sUdyAFyBwfwXt7ceIICW21
	 X7bB7s+gqRzSEIqATMLgOkrX784zAiERVZbgZwCKMQG6oeELzziiWTPSNi+DuJgVJt6rV
	 nBSG1iYTXLj3Z3GZBz59wiQfb/n4q2GNtJjh3ffCKbPK33CKWm0+92FlTErVA2TIVFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794661401;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=U81FFK6nLKyjakzpBFyubwPj+eJQmEhxCy8nzqys5Bk=;
	b=jZEWuR356D2XmoTtzLXYHWordx0BDtnf66PLXSlKR8n0Ruar+ecuGGoNusengsWCXhtK
	 ZlCiXRaEGsacXwr8HPGezS6aKjCc4iJc1FDAYasxzur01MquhpCbq3vh6hcsBis63Hifp
	 L0P2QpJ36mQ9I875EM5K8Yjq6SxlU2X4y7xk6C7e3d+4wonjWKMMGxESEPjsnBdvU9VyV
	 4w4+H9tBvWJ+xTw3N5JH8AmL1SA+VGTI+3rDqSYUmHiiChVDuLmEJ7z8o/ZG7+YvQOhNo
	 ABDSKbzNwVDpD+jYZ9Ecl1yCZZHZrgfHcE+z+tP/fs/e0HYqyL17GVKnjUMaSwT+IDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="dzd/oqbe";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE22B606A329
	for <linux-can@vger.kernel.org>; Sat, 14 Nov 2026 13:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dzd/oqbe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8321F000C7;
	Sat, 14 Nov 2026 13:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794661400;
	bh=U81FFK6nLKyjakzpBFyubwPj+eJQmEhxCy8nzqys5Bk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dzd/oqbeYEoM5B3t5m9jqmH9e1OZXGdqxxeUfZYgPN4rdyGECT+zTnpPYamGERjp3
	 xB4vREMxyeLppoizfkO0BL7ZelskeJ9V164qEgzzeuOMG0bwdCsW336b2JY9rbZspW
	 pYxOwSlgzCrqWZU760nQZVPK8rdqbH/nbDsbaBhErj5ZJfePTusTKzfZEZ5MFnE6rQ
	 0yjc2qMXGtIYfKwi/aqqThfKeUxQ0ZZshh8FO4uQn3+yn9NTUrUOvtJuigkiShy81+
	 At0H7Z6dPhwjOIkI9CSYtIW5V8Tsytb1cwMnLHyy9DKXkt9xMUPPgst1x6Van8yXPL
	 KoZlWMkyy7pHg==
Message-ID: <sashiko-outbox-214520@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH can 4/4] can: rcar_canfd: rcar_canfd_probe(): reject
 devices without match data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, wsa+renesas@sang-engineering.com
In-Reply-To: <20261114-fix-device_get_match_data-v1-4-2d82025e9646@pengutronix.de>
References: <20261114-fix-device_get_match_data-v1-0-2d82025e9646@pengutronix.de>
 <20261114-fix-device_get_match_data-v1-4-2d82025e9646@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:03:20 +0000
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
- [Low] can: rcar_canfd: missing Fixes trailer in rcar_canfd_probe() fix
--

commit cdc806522e3e7626b43c3c2411bfae563ed95e04
Author: Marc Kleine-Budde <mkl@pengutronix.de>

> can: rcar_canfd: rcar_canfd_probe(): reject devices without match data
>
> A device bound through driver_override need not match an entry in
> of_match_table. In that case device_get_match_data() returns NULL, but
> rcar_canfd_probe() dereferences the result.
>
> Reject devices without match data before continuing probe.
>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

[Severity: Low]
Since commit ce7c5382758b ("can: rcar_canfd: rcar_canfd_probe: Add struct
rcar_canfd_hw_info to driver data") changed the match data from an enum
value to a struct rcar_canfd_hw_info pointer and dereferenced info
without checking for NULL, should this include a Fixes tag?

  Fixes: ce7c5382758b ("can: rcar_canfd: rcar_canfd_probe: Add struct rcar_=
canfd_hw_info to driver data")

Also, rcar_canfd_probe() calls of_device_get_match_data() rather than
device_get_match_data().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-fix-device=
_get_match_data-v1-0-2d82025e9646@pengutronix.de?part=3D4
