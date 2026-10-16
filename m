Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DC02F1FE4
	for <linux-can@vger.kernel.org>; Fri, 16 Oct 2026 01:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792115644; cv=none; b=R1wz/+fjix+0XmKHYKkK5dhdEaMj5ASwBD42YixqCWSNQmQrKsPr76ZKA5dI2H/fD8CB/qA+HRJifxs2S3JztCThhTlnOad3RUwJpOW1wlOmWL0PDiNdoKKSmhHbUCFPeMLxn/pPl6twItKjMalHSYEXL+tQX0AW4VPW+zWfYD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792115644; c=relaxed/simple;
	bh=urGEYak9/4jR3Xqw7FfNDSRc7R+twbpfZhzdODHm1Lw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ZjSD1WDFPmqQ+dhnpgg+ozSjyWjTrjvMCbJGZMT1TjFZfHyUlSsj6dl8WiytjUIdTOh/WR6ZTNWwkV0qKBSLGq9ELq587PERa8jxWjzlt/HzF6KWOD1yZB7njd9Ia1gBF6Aat7G8BwGQp5v0ha+qORe/9c23iG1fMT0gaOcmeVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOw1qUBP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOw1qUBP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE701F000C6;
	Fri, 16 Oct 2026 01:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792115643;
	bh=PZRRJIGZPkfCWUWYpnLsYQlYCHgY6Ro4kuziuXMWQeM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kOw1qUBPJmhZwmPS15JS9dIvraEk1Q0J63buNN9p6IlSz1FoUB/dpcUlxNtFQiGa9
	 cQlF7JtSErufckfLlIfGVrTIZ+dTvxj3Cf8ofik9m5UNkLxkKdc7up/X1tRSZHZhab
	 M9FkrHD31cU69/992ohnoB384j66qSmcmTbGvHaqx73diqhDsoD2VJUTz9d1GZkvy1
	 Ymf9p52nO0G9fELHJIl5P944L5OqgIwIXojUGElvmDT/5VSMoyll+k6MWkejqjkq9p
	 JOtZoV94iezPnnxeW3iyOwZHd9w4lJBkWLLOreDaOdY8AUU8hkUmyZ8eQKfIzQBX6d
	 TkttAgq0bBKEA==
Message-ID: <sashiko-outbox-173575@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 04/37] can: proc: reset pkg_stats atomics
 individually
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261015015336.816543-5-mkl@pengutronix.de>
References: <20261015015336.816543-1-mkl@pengutronix.de>
 <20261015015336.816543-5-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 01:54:02 +0000
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] can: dropped statistics updates due to unprotected atomic_long_s=
et()
--

commit a887271f48442196a8a536b23ac554282d14a9f4
Author: Runyu Xiao <runyu.xiao@seu.edu.cn>

can: proc: reset pkg_stats atomics individually

This commit replaces a whole-struct memset() in can_init_stats() with a
helper that explicitly resets individual fields. The memset() caused
non-atomic writes to atomic_long_t members when called concurrently with
hot-path statistics updates.

Link: https://patch.msgid.link/20260512133937.21957-1-runyu.xiao@seu.edu.cn

> diff --git a/net/can/proc.c b/net/can/proc.c
> index de4d05ae34597..64b3bdc2fa7e0 100644
> --- a/net/can/proc.c
> +++ b/net/can/proc.c
> @@ -76,16 +76,39 @@ static const char rx_list_name[][8] =3D {
>   * af_can statistics stuff
>   */
> =20
> +static void can_reset_pkg_stats(struct can_pkg_stats *pkg_stats)
> +{
> +	atomic_long_set(&pkg_stats->rx_frames, 0);
> +	atomic_long_set(&pkg_stats->tx_frames, 0);
> +	atomic_long_set(&pkg_stats->matches, 0);
> +
> +	pkg_stats->total_rx_rate =3D 0;
> +	pkg_stats->total_tx_rate =3D 0;
> +	pkg_stats->total_rx_match_ratio =3D 0;
> +
> +	pkg_stats->current_rx_rate =3D 0;
> +	pkg_stats->current_tx_rate =3D 0;
> +	pkg_stats->current_rx_match_ratio =3D 0;
> +
> +	pkg_stats->max_rx_rate =3D 0;
> +	pkg_stats->max_tx_rate =3D 0;
> +	pkg_stats->max_rx_match_ratio =3D 0;
> +
> +	atomic_long_set(&pkg_stats->rx_frames_delta, 0);
> +	atomic_long_set(&pkg_stats->tx_frames_delta, 0);
> +	atomic_long_set(&pkg_stats->matches_delta, 0);

[Severity: Medium]
Does unconditionally clearing the delta counters here drop concurrent
increments?

If a packet is received or transmitted concurrently during a statistics res=
et
or during the can_stat_update() calculation window in net/can/proc.c,
can_receive() in net/can/af_can.c will increment the delta counter via
atomic_long_inc(&pkg_stats->rx_frames_delta).

If atomic_long_set(..., 0) runs right after that increment, won't it
unconditionally zero the counter, dropping the increment entirely from both=
 the
current and next intervals?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015015336.8165=
43-1-mkl@pengutronix.de?part=3D4
