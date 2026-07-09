Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ECC3EFFDB
	for <linux-can@vger.kernel.org>; Thu,  9 Jul 2026 08:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783585868; cv=none; b=s71vBHuvbXGIbmoCu/4SeQMNliWv+mllWxti5lNOM367PwZDXXNvqC9EYF7lRj3/G9FXnsSWM2mFcV9t5dG6p67XXLKfpczSOtBMLeuGIsGqVfi3nGCPtrLxahtEh1cFNqCxg5RagfR4pMx+a+0tKBxOwRP+tmUcLAbTlwkgTR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783585868; c=relaxed/simple;
	bh=2wNAEJNdIIVtHsTEdmTXTc43MQad3CQmgeEdZU+JjYQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JjQ404afLUUCqkFJ1U4keK8UVXxYLZooux2W0oY/uagbQ16lmxElwzw71SdAtmALdwSCoXLAwM1MUtVT6Id9aH1wpo5FSXrmXX9K43QfFViSgeC38/L95yHWwicck3AYbBAHb3u0YvykOQAXSlfPUtV3jRHGBIhFjCJ0yK/cPgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEZ+9/Ir; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEZ+9/Ir"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0901F000E9;
	Thu,  9 Jul 2026 08:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783585866;
	bh=90R0JYPLmPLGiXqQkvx+2bnj7Y/7Y6ARBzsEU1S7+WE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZEZ+9/IrK2EVrBd+BjY6oVCxnCYhJTclbCRywFCdDn5lAkhXNh4wczojGUCB4EoEr
	 /uUaGjEpr6cRsO8o67lRJJZ/dupzZkms86nMaHeUSabZp21vdNrwGReADzooDdI3ZT
	 kSRjR/ei9SH0skVP/6IMOEQ+7bmbA988ehPBpR3SSmpiYi0RyjAJhk3HCf7/zc5Fy4
	 dRE8XFs3Aaz2fzFpmRVqv8w0u5+dDP+mlSlhGpyZTtnll1ItLsOTSs2NGbJ00ZYNo/
	 /fVko1l5e9yeqPMSk8tkzkKF8gXZqM5+X0W+PazfCrQMkA2IXGbJj/w5fBPLEzw5yr
	 u+J9pfWtvo0nw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 03/10] can: bcm: add locking when updating filter and
 timer values
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260709-bcm_fixes-v9-3-6eebb78ccfb2@hartkopp.net>
References: <20260709-bcm_fixes-v9-0-6eebb78ccfb2@hartkopp.net>
 <20260709-bcm_fixes-v9-3-6eebb78ccfb2@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 08:31:06 +0000
Message-Id: <20260709083106.7E0901F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Lockless updates of RX metadata (`rx_stamp`, `rx_ifindex`, `fram=
es_abs`) lead to torn reads, lost increments, and corrupted timestamps.
--

--- Patch [3]: [PATCH v9 03/10] can: bcm: add locking when updating filter =
and timer values ---
commit 10b4ca432b89b6bdfb7aab7948a13f81a6bc41ed
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: add locking when updating filter and timer values

This commit introduces bcm_rx_update_lock to protect the filter and timer
configurations of a bcm_op structure from concurrent accesses. It ensures
that updates via bcm_rx_setup and usages in Rx and timeout handlers do not
race.

Link: https://lore.kernel.org/linux-can/6975d5cf.a00a0220.33ccc7.0022.GAE@g=
oogle.com/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index b612135b017d1..af4bb4182bc29 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -729,9 +751,18 @@ static void bcm_rx_handler(struct sk_buff *skb, void=
 *data)
>  	/* update statistics */
>  	op->frames_abs++;
> =20
> -	if (op->flags & RX_RTR_FRAME) {
> +	/* snapshot the flag under lock: op->flags/op->frames may be updated
> +	 * concurrently by bcm_rx_setup().
> +	 */
> +	spin_lock_bh(&op->bcm_rx_update_lock);

[Severity: Medium]
This is a pre-existing issue, but should the update to op->frames_abs be
protected by the new bcm_rx_update_lock?

If a bcm_op is configured to listen on all interfaces (ifindex =3D=3D 0) and
receives frames concurrently on multiple CAN interfaces, bcm_rx_handler()
can execute simultaneously on different CPUs.

Because op->frames_abs is updated outside the lock, concurrent writes can
occur, potentially leading to lost statistical increments. Additionally, on
32-bit systems, concurrent writes to 64-bit metadata fields like
op->rx_stamp could lead to torn reads when userspace retrieves them.

Could these metadata fields be moved inside the lock to prevent data
races?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-bcm_fixes-=
v9-0-6eebb78ccfb2@hartkopp.net?part=3D3
