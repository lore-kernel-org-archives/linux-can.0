Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770D8376BD6
	for <linux-can@vger.kernel.org>; Tue, 21 Jul 2026 14:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784644845; cv=none; b=I8UAWQmVSv/0qKgHSd3I3YLy6mMmm7gxvkX68pw/SA1UdLAuXq8lrp9Y+uAYif+WIOp+pkd5Hy8JYAtadacsHHcArinlcmv8mkA7ZCdF3oaIzbX1Mt927Iqk7kkN9lNOxsv5iVRG0NUdc+xrn0RCUK4Q7qB1P5KphIcGlGSt5BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784644845; c=relaxed/simple;
	bh=PH/lmrUSvpd9yRLjrCwgtC80CnKsNVNvOnWB4Ku94Eg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mFTsFX1YHKHTFf1jPCc8Y47nkQm0B1J7AvyXKycgMXWI3odDZXPJNMcKaXrvjPbX3dGhxyIh7aPaUz9uE4XurO/SsctGmLQsG7pdHQ3qKbfYJGG+wfPwvrwsmnvvgjQAv87ogTlGiWYPMPv6x3AwEUaGLhjmJh4AGgQ6+uPmVds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmZ6lGz8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmZ6lGz8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96EA1F000E9;
	Tue, 21 Jul 2026 14:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784644844;
	bh=0mu55DA0qwa64cqudx2we8OTtDyqMNDtK1aWa1lJkDY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KmZ6lGz8wEk5JIpG5RgbqCnMzj+UL8mLg/O4rNnQOeetmf/3ldmllu7icfBxe3lvQ
	 uM3FHzVLdKchtAMKbNEuLlIkCegdk6fhJy7itYykWcwrLpkj9HtgdYjBKkFxuO8ol+
	 Ubt9HN/EfNSiUVGI4Te44Rvc6Yx6UwKhRWXx56mw8oAavhPmaRX4F5mU0UnlxrayZ3
	 GU1KKGhc1gBMlVa1ypKji8lvCRo9KBjchubFwF29oLOw+bo5gy8C/3eTrFRztYnO+p
	 hZNFYdfeYXaR09COIkn8CxikSvTYISbyauLKzNGiOnU5QfsCJ9vlEDJWECCReetM6B
	 cGm51y+5NuRGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2] net: Replace %pK output with 0
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>
In-Reply-To: <20260720144031.oU6azheV@linutronix.de>
References: <20260720144031.oU6azheV@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 14:40:43 +0000
Message-Id: <20260721144043.B96EA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Missing placeholder for `%pK` in `/proc/net/tcp6` for TIME_WAI=
T sockets breaks column count.
- [Low] The format string for CAN EFF frames uses `%ps` without a width spe=
cifier, breaking column alignment.
--

--- Patch [1]: [PATCH net-next v2] net: Replace %pK output with 0 ---
commit 43254de7fd1d6d9709d84bcd9bfd332145fe505b
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

net: Replace %pK output with 0

Replace the %pK annotation with a 0 value to avoid exposing socket pointers,
and correct spacing for cases where the pointer is at the beginning.

> diff --git a/net/can/proc.c b/net/can/proc.c
> index de4d05ae34597..cc3050f4c8e75 100644
> --- a/net/can/proc.c
> +++ b/net/can/proc.c
> @@ -192,12 +192,11 @@ static void can_print_rcvlist(struct seq_file *m, s=
truct hlist_head *rx_list,
> =20
>  	hlist_for_each_entry_rcu(r, rx_list, list) {
>  		char *fmt =3D (r->can_id & CAN_EFF_FLAG)?
> -			"   %-5s  %08x  %08x  %pK  %pK  %8ld  %s\n" :
> -			"   %-5s     %03x    %08x  %pK  %pK  %8ld  %s\n";
> +			"   %-5s  %08x  %08x  %ps %8u %8ld  %s\n" :
> +			"   %-5s     %03x    %08x  %-20ps %8u %8ld  %s\n";

[Severity: Low]
Does the missing %-20 width specifier in the CAN_EFF_FLAG branch break colu=
mn
alignment?=20

The non-EFF branch uses %-20ps, but the EFF branch only uses %ps, which mig=
ht
cause subsequent columns to be misaligned depending on the length of the sy=
mbol
name when reading /proc/net/can/rcvlist_*.

[ ... ]

> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 522ba45ce9b75..bc45e647c4956 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
[ ... ]
> @@ -2209,7 +2209,7 @@ static void get_timewait6_sock(struct seq_file *seq,
> =20
>  	seq_printf(seq,
>  		   "%4d: %08X%08X%08X%08X:%04X %08X%08X%08X%08X:%04X "
> -		   "%02X %08X:%08X %02X:%08lX %08X %5d %8d %d %d %pK\n",
> +		   "%02X %08X:%08X %02X:%08lX %08X %5d %8d %d %d\n",

[Severity: Critical]
Does removing this %pK placeholder completely instead of replacing it with =
a 0
break the column count in /proc/net/tcp6 for TIME_WAIT sockets?=20

Unlike other socket states and the IPv4 equivalent where the pointer is
replaced with 0, this drops the column entirely. Could this cause userspace
parsers relying on whitespace separation to fail or parse incorrect data?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720144031.oU6a=
zheV@linutronix.de?part=3D1
