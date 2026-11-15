Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794704231;
	b=ihm/Onv+Y0AEwDv8fEjgH+UXWeMsTdoY2On+0t+/8B/ZOw2x5EIh89yCq5ECi7JHASEt
	 V3u3Z4kQA45BkIZwPLLIwZNCAvEZgbEaHU+4fbLsZNWL7fNx0DrsHvelpomnottko23P1
	 W8QX+kPGkGbiZbac/prakFR8QbBCcVZ3JUFFQsPeep5MXxlJejeephIHh34EwbWYPPs9/
	 MnC0q5xBUBUmlSStdQph4OnqXXE6Q1nuf6MQ8lPOqDl2WCUED4PX+ljXso6o707hfEsTa
	 qS6ATkMzEEwxlUmNWeNIvVw+6OIFybZzTz4UpjTB9ekyGR9z1ir1JSYdYSxwApR4+AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794704231;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=SXrzECImm4m+TMHqVMSrY7sBkxrR4ZLJwjywRUk5Kkk=;
	b=aWdLHbHa9eT5YUQ2ULJMOZQKvJKWKGpfdPIXXfujKf2MBXwF9UlYqrGc/0/DIewAlIO6
	 tG0Qxk3ZvUZhD1xJL+UoTqrgEKhHS2RSjWXyNB4lQ1EHU/lPXNPiaG+NRWuR7QgDz7LVn
	 6hO6Dn78pzyibJWQX29ViqCBDpOViwepKqoBAxUPvH8G8UlgwcVo37yYCfFDKNrYkMCGP
	 JUKW9QF+Dn4b0GClHuy63g8Txxs9jFBu7pJO88ioe/bJSchX1jX1xZT3+gaUkpCMamYkH
	 T+jvxZBH+I15quyw/NBr2+m/vgaikfiv2SporNWh/vZtlzM+q/xYCn4MjB3dt2yng1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aXbT5kai;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1977E606A323
	for <linux-can@vger.kernel.org>; Sun, 15 Nov 2026 00:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aXbT5kai
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DE61F000C4;
	Sun, 15 Nov 2026 00:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794704230;
	bh=SXrzECImm4m+TMHqVMSrY7sBkxrR4ZLJwjywRUk5Kkk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aXbT5kaiHUvvhE5XSIm1paEPLmbTjbZqMxe78sLPpb4oJIEBsDTcMlycCScC9rMqu
	 cRvmbaDsb0UrbRRJVM5A8bu1r7jrF6zFr1ba35T8amtqukOagSP+umBprJWYCW5NqN
	 5BxcNQ6ywx3R0A0Gr25RRV1/h9rvMGjqSt85hLuHK9EOiKzhEEa8d//hpSij4nPj7X
	 MUA0F9UxXwR5hijhkmVze8vHLFUB2DsGzqJ7OUnrMost9j/Y1OrM2XIhc5eW2A3Oya
	 T2GYjISqaYKyQsgtvGoqcF/KKxKC9OscMDEM05tKqAhgK2xQeuFAiTbIyNryCKCOGo
	 5pl/+Hr2WeJYw==
Subject:
 Re: [PATCH can-next v4 2/3] can: store socket pointers in struct netns_can
From: netdev-bot+sashiko@kernel.org
To: fstornio@redhat.com
Cc: socketcan@hartkopp.net, mkl@pengutronix.de, robin@protonic.nl,
 o.rempel@pengutronix.de, kernel@pengutronix.de, urs.thuermann@volkswagen.de,
 pabeni@redhat.com, horms@kernel.org, linux-can@vger.kernel.org,
 dcaratti@redhat.com, kuba@kernel.org
Date: Sun, 15 Nov 2026 00:57:09 +0000
Message-ID: <179470422953.488853.14290556895490516784@kernel.org>
In-Reply-To: <20261113-feat-can-diag-v4-2-c28842c74c95@redhat.com>
References: <20261113-feat-can-diag-v4-2-c28842c74c95@redhat.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The patch adds a directory-wide `CONTEXT_ANALYSIS := y` to
  net/can/Makefile, and the commit message does not mention it.
- [Low] (Baseline decision: false positive at the series level.) At this
  commit no Kconfig defines CONFIG_CAN_DIAG.
- [Low] Some identifiers in the commit message do not match the code.

--

can: store socket pointers in struct netns_can

This commit adds a mutex-protected per-netns hlist of AF_CAN sockets to
struct netns_can, for use by the upcoming CAN diag module. Sockets are
added in can_create() and removed in the raw, bcm, isotp and j1939
release hooks, all gated on IS_ENABLED(CONFIG_CAN_DIAG).

> On socket creation (`can_create()`), add the pointer to the
> new socket to `netns_can::sk_list`. During socket release
> (`isotp_release()`, `raw_release()`, `j1939_release()`,
> `bcm_release()`), remove the corresponding pointer from
> this list.

[Severity: Low]
Two of the names here don't match the code. The new field in
struct netns_can is sklist, not sk_list:

	struct hlist_head sklist __guarded_by(&sklist_lock);

Also, the j1939 release hook this patch changes is j1939_sk_release(),
not j1939_release().

The message also leaves out a few effects of the patch:

- sk_add_node() in can_create() takes an extra sock_hold() reference.
  It is only dropped by sk_del_node_init() in each protocol's release
  hook.

- Every AF_CAN socket() and close() now takes a per-netns mutex when
  CAN_DIAG is enabled.

- lock_can_diag_mutex() and unlock_can_diag_mutex() are exported for a
  module that is added later.

Could the message be updated to cover these?

> diff --git a/net/can/Makefile b/net/can/Makefile
> index 58f2c31c1ef37..7116c8c7f331d 100644
> --- a/net/can/Makefile
> +++ b/net/can/Makefile
> @@ -3,6 +3,8 @@
>  #  Makefile for the Linux Controller Area Network core.
>  #
>  
> +CONTEXT_ANALYSIS := y
> +

[Severity: Low]
Is enabling context analysis for the whole net/can directory intended
here? The commit message doesn't mention it.

CONTEXT_ANALYSIS := y applies to every object built from this Makefile.
With CONFIG_WARN_CONTEXT_ANALYSIS=y, that means raw.o, bcm.o, isotp.o,
gw.o and proc.o are also built with the analysis, even though they have
no context annotations. The diag.o added later in "can: add can diag
interface" is covered as well.

Kbuild variables don't carry over into subdirectories, though, so
net/can/j1939/ (which has its own Makefile) is still not analyzed. That
is true even though j1939/socket.c gets the same can_remove_sock_sklist()
call as raw.c, bcm.c and isotp.c.

Would it be better to limit this to the annotated object, for example
CONTEXT_ANALYSIS_af_can.o := y? Another option is to move the
directory-wide opt-in into its own patch and describe it in the commit
message.

[ ... ]

> diff --git a/net/can/af_can.c b/net/can/af_can.c
> index b4255fc570aab..6ee035fc14afa 100644
> --- a/net/can/af_can.c
> +++ b/net/can/af_can.c
> @@ -111,6 +111,46 @@ static inline void can_put_proto(const struct can_proto *cp)
>  	module_put(cp->prot->owner);
>  }
>  
> +#if IS_ENABLED(CONFIG_CAN_DIAG)
> +void lock_can_diag_mutex(struct net *net)
> +	__acquires(&net->can.sklist_lock)
> +{
> +	mutex_lock(&net->can.sklist_lock);
> +}
> +EXPORT_SYMBOL(lock_can_diag_mutex);

[Severity: Low]
No Kconfig entry defines CONFIG_CAN_DIAG at this commit. Is everything
under IS_ENABLED(CONFIG_CAN_DIAG) compiled out here? That would cover:

- the sklist_lock and sklist members of struct netns_can
- lock_can_diag_mutex() and unlock_can_diag_mutex()
- the real can_add_sock_sklist() and can_remove_sock_sklist()
- the new blocks in can_pernet_init() and can_pernet_exit()

Only the empty stubs in include/linux/can/core.h would be built.

The next patch in the series, "can: add can diag interface", adds
config CAN_DIAG (tristate, default m) to net/can/Kconfig. It also adds
net/can/diag.c, which calls lock_can_diag_mutex() and
unlock_can_diag_mutex() and walks net->can.sklist.

So this looks like a normal infrastructure-first split that is resolved
later in the series. The only effect is that at this commit the new code
is dead and the exported helpers have no in-tree user.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113-feat-can-diag-v4-0-c28842c74c95%40redhat.com
