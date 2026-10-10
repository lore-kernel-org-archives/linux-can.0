Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62C7380FF4;
	Sat, 10 Oct 2026 14:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791640971; cv=none; b=Jt0nlz8FYjBBgjCSt0zlXPr23uo0idXRKTKnPzAA5i4HsZTyDhFGVj+/NDA+hFkp9Fpbs0mJFqETsTEevQrlwkXyvi4DSDpOVtteRQtCBqUiUA0cE8rJxvEKPdeIW34BM1/KL6LVmdy56m5umqnxy96kZ++QEvlYnUOnfXrA0aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791640971; c=relaxed/simple;
	bh=aB4WjRCDG9m2F9NeUE7VoRFz8OaqQR50l293JV0whkY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p1QZ9O8XhtgIyUhpUy69u18YEvAb9JculHUdhWikYrNB8uzQ5lfyI8HD7nJnOqIn4Iw9T1tJAseFZNiLWQUSkrJhrVRWhh49T3bnILe/GYodaDYHBP1gqvyHrUSbIE4Nmx0ITVk4yHygwsNG9UaWiulb77qb020nI4DOs4ydoIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7bzP3Tn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7bzP3Tn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EEEC1F00893;
	Sat, 10 Oct 2026 14:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791640970;
	bh=+T0IC1u0ZcbC1ZTR766vG8nVIotZiLxAA+HEGaD6ieI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=N7bzP3TnmndPCLfQKcYi5vQ1HZAyMdoU83I9yGBYLEH/drvBjHB56dOGlp6859WYH
	 Vy7zYIuLmiV1IyOPvl6Cdg7RbLzvp2CIGJti2fgaKLr4F+frpHlacvXGfrrAmld5Zb
	 jjzSnIC3nUWJE26m+Pz4Hkx8fmPtXChsCkKfWElbdjGSTHsLgDuo0CE9pvxzOm4NYo
	 gZLwb5EegxKlVbKukI0rFxrSNN8BHV3foMvvAS0h0LGFHFUT2pxVxLDmXXBsyN1TPK
	 24fxCEZ8CmyCQVJY6fQ8P3iXi/jdXScbnTf6EjL7nsz2/k9voEHFz9orf5b41+UhJD
	 4JzgKdNlzTKmA==
Subject: Re: [PATCH net-next 05/37] can: proc: remove pointers from CAN
 specific proc output
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, hemanth.selam@gmail.com
Date: Sat, 10 Oct 2026 14:02:49 +0000
Message-ID: <179164096953.434549.17541028335124817965@kernel.org>
In-Reply-To: <20261009134323.64064-6-mkl@pengutronix.de>
References: <20261009134323.64064-6-mkl@pengutronix.de>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The commit says it stops /proc/net/can/ from leaking kernel
  pointers, but on some builds it now leaks a raw kernel text address.
- [Low] The procfs example in Documentation/networking/can.rst was
  replaced, but the text around it was not updated.

--

can: proc: remove pointers from CAN specific proc output

This patch stops printing kernel pointers in /proc/net/can/rcvlist_* and
/proc/net/can-bcm/. It prints socket inode numbers and %ps callback names
instead. The ident string argument of can_rx_register() becomes a u64
inode number, and the bcm proc file name is now the inode number in hex.

Link: https://patch.msgid.link/20260815103400.117175-1-socketcan@hartkopp.net

> diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
> index 536ff411da1d1..7bdb27a22a0ea 100644
> --- a/Documentation/networking/can.rst
> +++ b/Documentation/networking/can.rst
> @@ -1042,15 +1042,15 @@ receive lists, their filters and the count of filter matches can be
>  checked in the appropriate receive list. All entries contain the
>  device and a protocol module identifier::
>  
> -    foo@bar:~$ cat /proc/net/can/rcvlist_all
> +    foo@bar:~$ cat /proc/net/can/rcvlist_fil
>  
> -    receive list 'rx_all':
> -      (vcan3: no entry)
> -      (vcan2: no entry)
> -      (vcan1: no entry)
> -      device   can_id   can_mask  function  userdata   matches  ident
> -       vcan0     000    00000000  f88e6370  f6c6f400         0  raw
> +    receive list 'rx_fil':
>        (any: no entry)
> +      device   can_id   can_mask   matches     sock_inode     function
> +       vcan0  80000123  c00007ff         0  000000000000f862  raw_rcv [can_raw]
> +      (vcan1: no entry)
> +      (vcan2: no entry)
> +      (vcan3: no entry)
>  
>  In this example an application requests any CAN traffic from vcan0::

[Severity: Low]
This isn't a bug, but the text around the new example still describes the
old one. The sentence after the example says:

  In this example an application requests any CAN traffic from vcan0::

That matched the old rx_all entry, which had can_id 000 and mask 00000000.
The new entry is in rx_fil with can_id 80000123 and can_mask c00007ff. It
only matches non-RTR EFF frames whose low 11 ID bits are 0x123.

The sentence before the example also still says every entry contains "a
protocol module identifier". The new function column is the %ps name of
the callback. It only shows a "[can_raw]" style tag when the protocol is
built as a module, and it is a plain number on !KALLSYMS builds.

Should this text be updated to match the new output?

[ ... ]

> diff --git a/net/can/proc.c b/net/can/proc.c
> index 64b3bdc2fa7e0..33d99543e3fe2 100644
> --- a/net/can/proc.c
> +++ b/net/can/proc.c
> @@ -215,25 +215,21 @@ static void can_print_rcvlist(struct seq_file *m, struct hlist_head *rx_list,
>  
>  	hlist_for_each_entry_rcu(r, rx_list, list) {
>  		char *fmt = (r->can_id & CAN_EFF_FLAG)?
> -			"   %-5s  %08x  %08x  %pK  %pK  %8ld  %s\n" :
> -			"   %-5s     %03x    %08x  %pK  %pK  %8ld  %s\n";
> +			"  %6s  %08x  %08x  %8ld  %016llx  %ps\n" :
> +			"  %6s     %03x    %08x  %8ld  %016llx  %ps\n";
>  
>  		seq_printf(m, fmt, DNAME(dev), r->can_id, r->mask,
> -			   r->func, r->data, atomic_long_read(&r->matches),
> -			   r->ident);
> +			   atomic_long_read(&r->matches), r->ino, r->func);
>  	}
>  }

[Severity: High]
On CONFIG_KALLSYMS=n builds, does can_print_rcvlist() now print a raw
kernel text address?

The old format printed r->func with %pK. %pK follows kptr_restrict, so
unprivileged readers saw a hashed or zeroed value. With %ps, symbol_string()
falls back to the raw value when kallsyms is not built in:

lib/vsprintf.c:symbol_string() {
    ...
#else
	return special_hex_number(buf, end, value, sizeof(void *));
#endif
}

In that case the plain address of raw_rcv, bcm_rx_handler, isotp_rcv,
isotp_rcv_echo, can_can_gw_rcv or j1939_can_recv would be printed.

can_init_proc() creates the rcvlist_* files with mode 0644. An unprivileged
user can also add an entry by opening a CAN_RAW socket, through
raw_enable_filters()->can_rx_register(). CAN has no KALLSYMS dependency in
net/can/Kconfig, and KALLSYMS can be turned off under EXPERT.

Those builds also lose the old r->ident string ("raw", "bcm", "isotp",
"gw", "j1939"). The column then shows only a number, not a protocol
identifier.

Would a fixed per-protocol name work better here? Another option is to
print a placeholder, or keep %pK, when CONFIG_KALLSYMS is off.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009134323.64064-2-mkl%40pengutronix.de
