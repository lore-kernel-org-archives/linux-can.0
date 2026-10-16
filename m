Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611A439CCF8;
	Fri, 16 Oct 2026 02:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792118226; cv=none; b=rMwG6bAcrcDFTXMFkG3FvQ+eyycvhUJAFexdQiLUgaQw43g97jmJ0VWv1FFvJJErPj5saAGtMT0S4Qi8raAmJWoNL5KS09vtKw2pHfq1Bl9pdMDLsJGwyFVdNsF0opCoQzjhijEdEIZqvTwdXjWwohXPeUCwcnsXBy5aE99Dxp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792118226; c=relaxed/simple;
	bh=wPt2RZPQIXJnAUGvMQclOnH5shOqkeKEehrtnCKarPg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VJlsaQSJn47gIPzkiXRZ18kUujW0U6X2sa49AFFaN5HQ4Q1tY/uNQ2t5IqBTGe2YiaOdcczSAKoORfG7EtxsJy1v0Xu2dzngMDRyx038yWAyiiPmrDVpOY85MiCuJDeebXPgMtKW2buqytMmhGq8LGUfpouzLNtl3mw6388Dpq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tc8f1lWy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tc8f1lWy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB1D1F000C4;
	Fri, 16 Oct 2026 02:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792118225;
	bh=owwLA+k7cnLYtAuDdILFsNmU2kiAx/CAT1qDUgFozOU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Tc8f1lWy6FPfIFJyWuUDnY92BjjqxxmDJeYMvELqnxY0SCXMIskbyfO+X6O/moucP
	 CTEO9VTAHoeVQ0oA+C6SYdGh37x1qdUzukv+mu5XzfLNaUECtE27/oZzeFIRqXHQes
	 etkqm9oTWZUuAB+FahvQ5S+UGLTF8Kr2BGwqxmWfmshf4CA0aj8plTgomjJ0fplrHq
	 sti56y4U9tS4ZRKg1WXRajiiVpjQYKMeZIMMLk4oDwop+DpL5yOC+PIAtlx1AVOzvn
	 eQM9AuqASErp8TY9x0zlp5+7X6dLRK1BSFh8EfB386jx5CLWnvwnGiISG1qkIjpn4n
	 FHLCi9qt+XrxA==
Subject: Re: [PATCH net-next 05/37] can: proc: remove pointers from CAN
 specific proc output
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, socketcan@hartkopp.net,
 kurt.van.dijck@eia.be
Date: Fri, 16 Oct 2026 02:37:04 +0000
Message-ID: <179211822419.434549.2749733586204077125@kernel.org>
In-Reply-To: <20261015015336.816543-6-mkl@pengutronix.de>
References: <20261015015336.816543-6-mkl@pengutronix.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new CONFIG_KALLSYMS guard in can_print_rcvlist()
  (net/can/proc.c) does not stop the receiver callback address from…
- [Low] The updated text in Documentation/networking/can.rst says every
  rcvlist entry contains 'the CAN network device and the subscribed…

--

can: proc: remove pointers from CAN specific proc output

This patch stops printing kernel pointers in the /proc/net/can/ and
/proc/net/can-bcm/ output. The rcvlist entries now show the receiver
callback name via %ps (or "(unknown)" when CONFIG_KALLSYMS=n) and the
socket inode number. can_rx_register() now takes an inode number in
place of the ident string.

Link: https://patch.msgid.link/20261012115851.3412-1-socketcan@hartkopp.net

> diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
> index 536ff411da1d..908c199cf6ad 100644
> --- a/Documentation/networking/can.rst
> +++ b/Documentation/networking/can.rst
> @@ -1040,17 +1040,17 @@ As described in :ref:`socketcan-receive-lists` the SocketCAN core uses several f
>  lists to deliver received CAN frames to CAN protocol modules. These
>  receive lists, their filters and the count of filter matches can be
>  checked in the appropriate receive list. All entries contain the
> -device and a protocol module identifier::
> +CAN network device and the subscribed function name::

[Severity: Low]
Is this sentence accurate for every configuration?

With CONFIG_KALLSYMS=n, can_print_rcvlist() prints the literal string
"(unknown)" in place of the function name. The commit message mentions
this, but the documentation does not.

The new sock_inode column is also not explained. Kernel-internal
subscribers pass ino=0:

net/can/gw.c:cgw_register_filter()
    gwj, 0, NULL);

net/can/j1939/main.c:j1939_can_rx_register()
    j1939_can_recv, priv, 0, NULL);

Could the text mention the "(unknown)" case and say that a sock_inode of
0 means there is no associated socket?

>  
>      foo@bar:~$ cat /proc/net/can/rcvlist_all

[ ... ]

> diff --git a/net/can/proc.c b/net/can/proc.c
> index 64b3bdc2fa7e..64994ab48541 100644
> --- a/net/can/proc.c
> +++ b/net/can/proc.c
> @@ -215,25 +215,27 @@ static void can_print_rcvlist(struct seq_file *m, struct hlist_head *rx_list,
>  
>  	hlist_for_each_entry_rcu(r, rx_list, list) {
>  		char *fmt = (r->can_id & CAN_EFF_FLAG)?
> -			"   %-5s  %08x  %08x  %pK  %pK  %8ld  %s\n" :
> -			"   %-5s     %03x    %08x  %pK  %pK  %8ld  %s\n";
> +			"  %6s  %08x  %08x  %8ld  %10llu" :
> +			"  %6s     %03x    %08x  %8ld  %10llu";
>  
>  		seq_printf(m, fmt, DNAME(dev), r->can_id, r->mask,
> -			   r->func, r->data, atomic_long_read(&r->matches),
> -			   r->ident);
> +			   atomic_long_read(&r->matches), r->ino);
> +
> +		/* without kallsyms %ps would print the raw text address */
> +		if (IS_ENABLED(CONFIG_KALLSYMS))
> +			seq_printf(m, "  %ps\n", r->func);

[Severity: Medium]
Can %ps still print the raw callback address when CONFIG_KALLSYMS=y?

The IS_ENABLED() check covers only the config option. It does not check
whether the symbol lookup succeeds. When kallsyms_lookup_buildid()
fails, the %ps path falls back to an unhashed address:

symbol_string()
  sprint_symbol_no_offset()
    __sprint_symbol()
      kallsyms_lookup_buildid()
        module_address_lookup()
          find_kallsyms_symbol()

kernel/module/kallsyms.c:find_kallsyms_symbol() {
    ...
	if (!best)
		return NULL;
    ...
}

kernel/kallsyms.c:__sprint_symbol() {
    ...
	if (!len)
		return sprintf(buffer, "0x%lx", address - symbol_offset);
    ...
}

The callbacks registered here are all static functions in modules:
raw_rcv, bcm_rx_handler, isotp_rcv, isotp_rcv_echo, can_can_gw_rcv and
j1939_can_recv.

scripts/Makefile.modinst passes custom INSTALL_MOD_STRIP values straight
to strip, so a module installed with something like
INSTALL_MOD_STRIP="--strip-unneeded" or "-x" can lose these local
symbols. If no named symbol comes before the callback in that module's
text, the lookup fails. This depends on section layout, which has not
been fully confirmed.

The rcvlist files are created 0644 in can_init_proc(), so any local user
can read them. The old %pK output applied kptr_restrict. In this
configuration the new output would show the real module text address.

Would it be safer to resolve the name explicitly, for example with
sprint_symbol_no_offset() or lookup_symbol_name(), check that the lookup
succeeded, and print "(unknown)" on any failure? The commit message says
the patch "removes the disclosure of pointers", so it seems worth closing
this case too.

> +		else
> +			seq_puts(m, "  (unknown)\n");
>  	}
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015015336.816543-2-mkl%40pengutronix.de
