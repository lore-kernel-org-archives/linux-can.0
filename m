Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E4817A300
	for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 10:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025156; cv=none; b=A+M4wKyxaiZn5bQIGIfPJXp/vIJhQEyT2V3xcrcdl+qsvSRbk/20GMIGbQnmmztfJNp8YNoXpFmd2pllYyHMeGpJIOkUin+cEDzWnCyb+9/6iBsxNB/vF4T0vaCM/gHFqZGYWJUDj1Az5CVpfiudSD34L5XJ/UDiByRU0GLcQOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025156; c=relaxed/simple;
	bh=bpI1l3bx2NOCA/kFitj3iOFzhLD5waiLK6UjFHnE8iA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qiTsYUzbsXJjSlpoACmB7SPVEBt1gHfU+YJRoPwOdM+eVRfEj6AEpGeYJ+mrwSa+JkBmoeH+2Aqz/t/9yD4O9KMQjZ+XBvBwyOV9aMXWBdpCJ4hvm1DHbt3Y7z1APIv77cuWRKQ+cAbBs7vKNT9OpMORmmM+zTZt72DwgVjH8UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXJru0zX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXJru0zX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1681F000E9;
	Tue, 14 Jul 2026 10:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784025154;
	bh=BWsyL7v0J2ibj8EBWf6ItOjuKmec0QmFYYde7GPiXc0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PXJru0zX3BPP7LsRcAUy2k96BMy+JDKQph8wyYEcRlyx7J/DkWcSiCvyTRN0878gD
	 TmqEU66eF3ZXWMSmbyLc+p8H0c8wqb4P53HAkUbCMdmaKjuynr6vmnqIzR3OgclEDc
	 u0oKgk87yfyJvTJy4qmPsb2g4MDsIcwQuzjdT7RxR3tQxFfmlKw3muWSIb+g+s2Pbe
	 Mwrs49wLs/1tmE2S48fHXHnZHBwgJPuDUnCW05JmFF7elVw1vwuiNtxjy14+f8oV9a
	 Lq2OdatHVJ+QJPl9rY2tl921E3PcNOiMS+ISMvDKk4G2wL8k6huGuyMtCV6Yh44Did
	 hon2lnwfa7yOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 05/11] can: bcm: add missing rcu list annotations
 and operations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260714-bcm_fixes-v13-5-fd667c61099a@hartkopp.net>
References: <20260714-bcm_fixes-v13-0-fd667c61099a@hartkopp.net>
 <20260714-bcm_fixes-v13-5-fd667c61099a@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 10:32:33 +0000
Message-Id: <20260714103234.2F1681F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] In `bcm_tx_setup()`, when updating an existing `bcm_op`, the CAN f=
rames array (`op->frames`) is overwritten directly from userspace data usin=
g `memcpy_from_msg` without holding `bcm_tx_lock` and without using a stagi=
ng buffer. This introduces a data race with concurrent transmission. Crucia=
lly, the direct overwrite stores user-provided frames into the active array=
 before length validation. If an invalid length is provided, the function s=
ubsequently returns an error, but the corrupted frame remains active in `op=
->frames`. Concurrent or subsequent timer executions will transmit this mal=
formed frame to the CAN driver, leading to out-of-bounds accesses and kerne=
l panics.
- [Medium] Timer values in `bcm_tx_setup()` (`op->kt_ival1` and `op->kt_iva=
l2`) are updated directly without holding `bcm_tx_lock`. Concurrently, `bcm=
_tx_timeout_handler()` running in softirq context reads these 64-bit `ktime=
_t` values without locks. On 32-bit architectures, this leads to torn reads=
, causing unpredictable timer behavior.
--

--- Patch [5]: [PATCH v13 05/11] can: bcm: add missing rcu list annotations=
 and operations ---
commit 74409df5d31bac1c2081de9ebaae45419726cd9c
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: add missing rcu list annotations and operations

This commit addresses missing list_add_rcu() and list_del_rcu() calls in
the CAN broadcast manager to properly initialize and clean up bcm_op
structures. The operations are updated to protect concurrent procfs
traversals that use rcu_read_lock().

Link: https://lore.kernel.org/linux-can/20260610094654.A1FFE1F00893@smtp.ke=
rnel.org/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 38c3f690c1cd0..940cd9df1cca3 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -1009,6 +1009,7 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_he=
ad, struct msghdr *msg,
>  	struct bcm_sock *bo =3D bcm_sk(sk);
>  	struct bcm_op *op;
>  	struct canfd_frame *cf;
> +	bool add_op_to_list =3D false;
>  	unsigned int i;
>  	int err;

[Severity: High]
This is a pre-existing issue, but does this code overwrite the CAN frames
directly from userspace before validating their lengths?

In bcm_tx_setup() when updating an existing bcm_op, the frames array is
updated directly without holding bcm_tx_lock and without a staging buffer:

bcm_tx_setup() {
    ...
    err =3D memcpy_from_msg((u8 *)cf, msg, op->cfsiz);
    if (op->flags & CAN_FD_FRAME) {
        if (cf->len > 64)
            err =3D -EINVAL;
    ...
}

If an invalid length is provided, the function returns -EINVAL but the
corrupted frame remains active in op->frames.

Could concurrent or subsequent timer executions transmit this malformed fra=
me
to the CAN driver, potentially triggering out-of-bounds accesses and panics?

[Severity: Medium]
This is a pre-existing issue, but are the timer values updated locklessly?

bcm_tx_setup() updates the 64-bit ktime_t variables kt_ival1 and kt_ival2
directly without holding bcm_tx_lock:

bcm_tx_setup() {
    ...
    op->kt_ival1 =3D bcm_timeval_to_ktime(msg_head->ival1);
    op->kt_ival2 =3D bcm_timeval_to_ktime(msg_head->ival2);
    ...
}

Concurrently, bcm_tx_timeout_handler() in softirq context reads these
values locklessly:

bcm_tx_timeout_handler() {
    ...
    if (op->kt_ival1 && (op->count > 0)) {
    ...
}

On 32-bit architectures, a 64-bit read/write is not atomic.

Could this result in torn reads where the timer handler sees a mix of old
and new 32-bit halves, leading to unpredictable timer behavior and erratic
transmission intervals?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-bcm_fixes-=
v13-0-fd667c61099a@hartkopp.net?part=3D5
