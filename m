Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792614692;
	b=njvNCJYFxaF8DGaqHo/74OFcsT9YU7gVviiSUECSARaDFuL9zB6vEGxD4LFl001awxIw
	 75M0RQZ9ouvM79lM89F6RghDY8pAzmwaAtRjuR4yRWTcQRc3cBvBco34bvx1WKhgoUwAY
	 5shOpdMf9v5jjwSNhGqbdlY0206IEgghABldBMjmbaF8hYBJQKHpWz4xXgILU6IS7pJGC
	 8q6Z2jqkEBVSwPc5+Oc8k1VDoy2Y49sbThLx/7spmYx91rSLuFQC+4zCkZiOV/YbzLP9B
	 JsFyYyUYSeemPHqkg8+oWiMlu+dQYRJwUe0qm+yyWZS8iJ12yfa+8cU7uTn6LcREpPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792614692;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ssm0YwnEh2UcHUt8QcjyuPt/pRIf3DpHvZcSL8oz4S0=;
	b=ADuDVDwYcH1F18QpZoLMABDhwJN+9/C9Xa7hfTv8QYAEay1w+pYLpjXh7V0SqZ8rS/Cm
	 JVMKYUoEQvXPIWfaP1WyTIyPxQAXSSQgMKHu9jNswSeaBA/hWLGiH7xdsmzLa9AGYRsvR
	 RnC8OUunerSVy3unC0QO+uwEhhHspSOG0Wcri+RgaeSOV/QMl229WFQylwkxPa+KmZ3AZ
	 k5fC8lqn95/DhCazTJPK7P3fa+wIeTh4H2dzNnO3W1NtuO17XOsSczEFduPDe/W1Mjerd
	 l9dXpQj3tWbL0Bvqs2gCbVxVqIDJT+/Kj66K6bhL6HuLFiZgMpcOFm4GnJYOJkVZlcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NDLJV8No;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D96A606A31B;
	Wed, 21 Oct 2026 20:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NDLJV8No
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7891F000C3;
	Wed, 21 Oct 2026 20:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792614692;
	bh=ssm0YwnEh2UcHUt8QcjyuPt/pRIf3DpHvZcSL8oz4S0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NDLJV8NoCr5f9+TkGJJl2Hkn6h5j5Mm74AxTTyRkaG+aHi9qqOCyg6zixBH40Wopb
	 Zaj1RrO4veKx4QpZ/rHuy7QI1R35WQPf4mKaBW1yoxl/i8mwDpbpEpkeqehWkxQoJE
	 VLbThztCco0/b1N48QUrY+Nn0Lhvryvsg8Hmj+L+VWv7ohWj9UAul6QQPy7bT6teFt
	 iePvzeCRwyosmNEg5HTj7hr7lI0i/lplJKhuWyZId/PK3W6eVCKJacU8j8YfR+0Ow/
	 BaasCsW2eS8Uv4S6Z6fBwAlPu47xOmEwhkzHOo5DIDCkvscdM9nlaYzRY+PxO73OCd
	 9UEeISvpIKHCw==
Date: Wed, 21 Oct 2026 13:31:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
 <mailhol@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Nicolas
 Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/4] can: don't discard the platform_get_irq()
 error in probe
Message-ID: <20261021133130.2cf75b3c@kernel.org>
In-Reply-To: <cover.1792118040.git.chaosheng.qu.linux@gmail.com>
References: <cover.1792118040.git.chaosheng.qu.linux@gmail.com>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Oct 2026 14:11:35 +0800 Chaosheng Qu wrote:
> Four CAN platform drivers collapse every failure of platform_get_irq()
> into a fixed error code:
> 
>     sun4i_can    -ENODEV
>     at91_can     -ENODEV  (also tests irq <= 0, which cannot happen)
>     janz-ican3   -ENODEV
>     ifi_canfd    -EINVAL
> 
> sun4i_can, at91_can and ifi_canfd match through an of_match_table, so
> of_irq_get() returns -EPROBE_DEFER while the interrupt controller has not
> been probed. The probes overwrite it and the driver core stops retrying,
> leaving the device unbound even though the interrupt controller appears
> later.

Please don't CC netdev@ on run-of-the-mill CAN patches.
Follow to MAINTAINERS / get_maintainers.pl
