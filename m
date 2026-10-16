Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2B43A6B77
	for <linux-can@vger.kernel.org>; Fri, 16 Oct 2026 10:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792147407; cv=none; b=X7pkOuDRJqFUq9/AcZNANxp37Bh92hbAHRMSVcoB3DaBBqJuT98sx00cuyHwg896NmUbPq/MxrSfte8qUUKRIm8unF78xVBLPeffLNxpoN2+q7HlT2MhsicZxC70kqQBzzmQbIyaycr1ZiYhCgXGVkMFgvNkgneDAH0nCi3yT7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792147407; c=relaxed/simple;
	bh=+NM7orLNXuqBht3pdFspxWYgl5mCHOtAR5jfxjqHHzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMkOC9fiemYLVHxcYHDXFpjHNQ7ilWA99rTnv5CVlsFWHTf8Zm16titLnbzuqI+zQwrJfU2I1G2p2ZMvGUXc15J2sc6zqAjvLOWp9UEk2Ay8vOLj3fBX2eXDN7W8zYDfDOxdK3PJujo0SR9MzhwB34KD+hlpINQ/yxEZBPGcNxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3GVraj2W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+IPpqNrp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3GVraj2W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+IPpqNrp"
Date: Fri, 16 Oct 2026 12:43:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792147403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F9AScJevSbEL8Xl6voqVipKYQGuQWq0Os6kKvCpOELA=;
	b=3GVraj2WmzWD1kb4mEBvBMy/vAjYseP1Xr0EKEYC0nR94ujFSeNcp4lNiZH9d8sAjvYAvb
	6mqfJiG24WDiEs5u12LuEIoJG6x2iqDmap4cRLKmmLEwxPavq09yjcEcfkMht7d9OcqJ3f
	27axUzjC8yct23TQ0n1tXNwyjW+NVVNptpMgw/MiCh1m4i27oXVcYbbF5gFg3+D7GKgPEN
	WpbPgf4ZyhEeY23B19SDMurG5Rp2/KjmEu4s+oXhUxzouzCJO1UDOzgP9ulO+YFMIflWea
	/UrmMymP4QtVOEQIZ4z/ghvhs0ddShQM86YBkYBXovkAgJXLYT6Hp1RK2TaWJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792147403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F9AScJevSbEL8Xl6voqVipKYQGuQWq0Os6kKvCpOELA=;
	b=+IPpqNrp/ZggjyCTkIxL0YWKpc4suucr9SirlNoctsCwTceis8MZAspTOnY6W8TSk5IJ/f
	WJgQHrCGY2tZzvAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH can-next v3] can: proc: remove pointers from CAN specific
 proc output
Message-ID: <20261016104321.Z9OEG9m_@linutronix.de>
References: <20261016103706.410678-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261016103706.410678-1-socketcan@hartkopp.net>

On 2026-10-16 12:37:06 [+0200], Oliver Hartkopp wrote:
> The proc content in /proc/net/can/ and /proc/net/can-bcm/ is intended to
> check the internal filter lists (af_can, can_raw) and the efficiency and
> functionality of can_bcm jobs. While exposing kernel addresses was
> acceptable when this code was written the times have changed and multiple
> attempts have been made to hash or remove such now sensitive data.
>=20
> This patch removes the disclosure of pointers and instead provides the
> function names and sock inode numbers when available. When the function
> name can not be resolved (e.g. KALLSYMS=3Dn or stripped module symbols)
> %ps would fall back to the raw text address. Therefore (unknown) is
> printed instead in this case. As there's no known tooling around the CAN
> specific proc output breaking the ABI with this rework creates no issue.
>=20
> Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

I am all fine with this \o/

> --- a/net/can/proc.c
> +++ b/net/can/proc.c
> @@ -189,30 +189,36 @@ static void can_print_rcvlist(struct seq_file *m, s=
truct hlist_head *rx_list,
>  			      struct net_device *dev)
=E2=80=A6
> +
> +		/* %ps falls back to the raw text address when the symbol
> +		 * can not be resolved (KALLSYMS=3Dn, stripped module symbols)
> +		 */
> +		snprintf(symcheck, sizeof(symcheck), "%ps", r->func);
> +		if (strncmp(symcheck, "0x", 2))
> +			seq_printf(m, "  %ps\n", r->func);
> +		else
> +			seq_puts(m, "  (unknown)\n");

If you want to keep this because the bot said so, fine. I will let you
know once my side projects gets through
	https://lore.kernel.org/all/20261015-vsprintf_kallsym-v3-1-c175c27f38b7@li=
nutronix.de/

;)

>  	}
>  }
> =20

Sebastian
