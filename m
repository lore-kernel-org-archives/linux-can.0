Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B8430DEB2
	for <linux-can@vger.kernel.org>; Tue,  7 Jul 2026 14:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783435728; cv=none; b=b64vqh53OTQBjxe1yX0HLOl9MKBcXxOrzG1qcKmmB3XVXbx8GTVK3EMgxqFZcbNk0PGtVopiZ7URgzMyEzg9n2FbYxyHqnt08lyfMYJ05OSnhBPtKvTU8o+oY2sK47GhtZngRtysnc7QGIb+p+FZcBGYemmR1Drmx10EyW0+bd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783435728; c=relaxed/simple;
	bh=LrcYt3NqdXItuCTPMKGUKlc2EiAisVDhpbvW0rLXums=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ofkCJSItk02ub6AqCeMuOM9slfy+NfRcrugg3aB1Po55eokaT4iwhXXti45QT8FjiHVOKGDwjrh+Hk+46+Te3hbtVbFIHcJtxlc0Hkw/TWeHBeyRzNnCe9bF+B36DtITOtB9q89LMrR4xR+t/8x99amLPoE+dy4TPcbR3/1ZC4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuiYcZu3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuiYcZu3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559ED1F00A3D;
	Tue,  7 Jul 2026 14:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783435726;
	bh=dXZ5+QgzrBacS+qmB3BlLMKzTVlYuQuSlcAVoY/nXO4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WuiYcZu36lqo3KY3UflwL+A8nWbi4EH/3m9AKIXOaI/EAkAiDR5KP47LzKEuEdCgw
	 Q+mZaZzWRALTBRWmILvM3GbpbPi7fA3qekNnu96w9ZOGzWxROiHBNb9xmCmWxHS10e
	 KU/jCEPnatCQ9IqdGKWKNcT7xmzO6FhcJ5PZk+rvnDALbo3ADNhutzjrZZMnleKyft
	 gljswTLBFWIkNMy1uzivC5N7Uc6ePmk0F6lV17svrGpX8ac9tWHoHT1mWY7Av3LxRv
	 SSaZthhtwsZuxZp3i41lvT7/lET8ZtXqSlLqvHjl9M6oidYhGdIRwWOaqpvTC3Vt/D
	 OST/Uez2pOkrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/7] can: bcm: add locking when updating filter and
 timer values
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260707-bcm_fixes-v4-3-aa87b8b9d33f@hartkopp.net>
References: <20260707-bcm_fixes-v4-0-aa87b8b9d33f@hartkopp.net>
 <20260707-bcm_fixes-v4-3-aa87b8b9d33f@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 14:48:45 +0000
Message-Id: <20260707144846.559ED1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless reads of timer and state variables in `bcm_tx_timeout_han=
dler()` cause torn reads and TOCTOU bugs.
--

--- Patch [3]: [PATCH v4 3/7] can: bcm: add locking when updating filter an=
d timer values ---
commit 59929132ac1eda994b23441375ebf1eecf8fc14d
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: add locking when updating filter and timer values

KCSAN detected a simultaneous access to timer values that can be
overwritten in bcm_rx_setup() when updating timer and filter content
while bcm_rx_handler(), bcm_rx_timeout_handler() or bcm_rx_thr_handler()
run concurrently on incoming CAN traffic.

Reported-by: syzbot+75e5e4ae00c3b4bb544e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-can/6975d5cf.a00a0220.33ccc7.0022.GAE=
@google.com/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index b612135b017d1..b9b6f1b7bb03b 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -461,7 +466,7 @@ static enum hrtimer_restart bcm_tx_timeout_handler(st=
ruct hrtimer *hrtimer)
>  	struct bcm_msg_head msg_head;
> =20
>  	if (op->kt_ival1 && (op->count > 0)) {

[Severity: High]
This is a pre-existing issue, but while the patch adds locking to protect
timers in the RX path, it looks like a similar data race might exist here
in the TX path.

Can lockless reads of op->kt_ival1, op->kt_ival2, and op->count in
bcm_tx_timeout_handler() lead to torn reads on 32-bit systems?

Since bcm_tx_setup() updates these 64-bit timer intervals locklessly:

net/can/bcm.c:bcm_tx_setup() {
    ...
    if (op->flags & SETTIMER) {
        ...
        op->kt_ival1 =3D bcm_timeval_to_ktime(msg_head->ival1);
        op->kt_ival2 =3D bcm_timeval_to_ktime(msg_head->ival2);
    }
    ...
}

And bcm_tx_set_expiry() also reads them locklessly:

net/can/bcm.c:bcm_tx_set_expiry() {
    ...
    if (op->kt_ival1 && op->count)
        ival =3D op->kt_ival1;
    else if (op->kt_ival2)
        ival =3D op->kt_ival2;
    ...
}

Would it be possible for the hrtimer softirq context to see torn ktime_t
values if it preempts or runs concurrently with bcm_tx_setup()?

Could this lead to wildly incorrect timer expiry values that might stall
the cyclic transmission, or corrupt user notifications?

> -		bcm_can_tx(op);
> +		bcm_can_tx(op, NULL);
>  		if (!op->count && (op->flags & TX_COUNTEVT)) {
> =20
>  			/* create notification to user */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-bcm_fixes-=
v4-0-aa87b8b9d33f@hartkopp.net?part=3D3
