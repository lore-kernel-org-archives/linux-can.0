Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.160
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794665173;
	b=lYL7PADJzz0W1lakoN19PMpJ4W1/0dmNjHgPTE3wSopKuHl60O4A83q2IRCySqlcNVos
	 AzUZcajT+vbMKMp8CajFWyjbPag8Wv/fjq6+95tyHsypOivlWQ4i3GemXLmO1rTkW3g+T
	 IaR1O9hjhheCFz2Gxg5nxYi81SOGwf3zoq+bLMlxk2So9JGJ4RRJ2H9GWQLxscI9kC5uP
	 caZjK3I5K5jbEXzfBxgAQqRO90EsvwgpzlJCnXdNEjcXFJDhxzQQx5oCcsI/+594aN8WF
	 A7hobmp9fuNFGOtgB8DEzpgBHru9Az04mizKDtwPcgXLt1EZztlJ6QjhNA2AfCivd+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794665173;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=5ReYr7OoTp9pdPXQ0UtFjFzT1mH8r1Xkp4Yb3h64Evc=;
	b=Q016ijje2qCFpEzsZ2G3ZRt8kWMTk/LMuJbikyudjOGaU4O8ZNPOWzQOfWPJF+/fjw9f
	 CAjPlnebuZEpad+rCPeQwdvcXB8KgFdStmB5lokI4C0g/DbhpXn9sS9h1OvBkm3qJi/oF
	 lbZott1PIbygU0Xjsr82XGDb294bZmE76BC5sjSrwQZfhrA0c3UzLL/hE/AgCR2w90xen
	 BpjLy/pljfTGnZfKmN+ZrVN1MLi8f50kHoLiyTk+eGGh6qKQRnO+RfQfkHADo5298lOFl
	 QAOLaJS1ZP7/8WpyzduwqfvtnUU9BS7KLSEi0lgsZ9+fuej5GX1IK3hwFAk7wql6YwA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=YMrtGEOV;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=mwAlbqSL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.160
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.160])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9BE606A32D
	for <linux-can@vger.kernel.org>; Sat, 14 Nov 2026 14:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A9BE606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=YMrtGEOV;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=mwAlbqSL
ARC-Seal: i=1; a=rsa-sha256; t=1794665164; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=WfOKxwtotLZUC6Xx8Jx5xyl6CgX5+smO2KVBUrpewbUqqIcDZULcqp+TvZHXzcCKq8
    dEtgcnGmlLSF4AuxwIKINttmw5f6+Upt2eL0IsFDO2dF09ENijeEFfCQmxyqhPtCkDGz
    UlsK88q3MLNa1O0x6miU5cJMiCw3nUVfIVUB9bmUA2T98Zt8TkwSMswGx4En2SvQ5FAg
    B8/NbsZcRO/+4MXapCgJcNbFi0inZGms0XEI4k3dkIIE47NvQRT903u6OzvCnzjUUagC
    roFyr50b0cupKXqL3+8IYYSNyR2jS2/FoWveh3Tox2XEzJlhRz8/zPNrWyqpMZGeomX6
    DZvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794665164;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=5ReYr7OoTp9pdPXQ0UtFjFzT1mH8r1Xkp4Yb3h64Evc=;
    b=hklNMW+YBZsh5JnDhk0+xNgOiiQ2+LGvbpHl4c0HpfJcR/rjphP55N9CgUlZXDFYcE
    qICojoBP6n2Op+2h2GQ7a87M7dtp1NDQbBW+nCG9ZDp4eqAh4+jEJrtk7coG5JaR4f+t
    Y5gRo5FlND90FDKqF0X0Z/MkR5SI3hFgX5S351qUo6L+YOUddg0nfbxZcnoRzFu/teKB
    H9i6OBu8tA0x5xxTyioC8SqhfGnftqXdcugjicjIhXhR2rDhr0FEccrR/+ssg0xfRWin
    j3Rjsy5soIR9xJzFqtTEpsAPYLj86/qTR4ItjlZ3hzX9s2BUYV/Zm7Yu6QMFcx8CdZ25
    7lhA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794665164;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=5ReYr7OoTp9pdPXQ0UtFjFzT1mH8r1Xkp4Yb3h64Evc=;
    b=YMrtGEOVO7s8GaBwEtjrowxnw+ZSmQPZZirED77vJOiHRy58mYMGpRw0DGc+YRqH4d
    gIIg/nCygHqki1r1QPKYKC0oFJkzckvnoZjFWrPnuZGY2mcrtiZgEfhdgW4VmYhRW93y
    Bnq99fiZ2/wK4YDoxKi9C1Vm3Rc2Ybq9drIJ6fGVXGZ+WhHNu8ZirpjPI8gughcKP2vs
    hR7BwbZqP3Sf9mYYVsDMU/q5Y1FmQpa2T5MhPk5/ZsTubv899pVX4ZL11b3NNmRftyfD
    GDUF6ca3vUoEqsXdBPf5e3E7ON+0a9ox04hs4ZeC+yM9ZJ6Pkrh3Pr5S3fm0XLgkStiU
    CH+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794665164;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=5ReYr7OoTp9pdPXQ0UtFjFzT1mH8r1Xkp4Yb3h64Evc=;
    b=mwAlbqSLHEdG+Un8kFKX/+jpdxqjPLdpOJeRv2mdNAHo0PXvwDYqVZlEQxyOwmWuou
    v/7+yStEEoJJ0uGAqCAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AEE63Mna
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 14 Nov 2026 15:06:03 +0100 (CET)
Message-ID: <4858e8ad-d369-42bb-bc6b-71c5eb6a4168@hartkopp.net>
Date: Sat, 14 Nov 2026 15:05:58 +0100
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] can: avoid RTNL stalls in CAN_RAW, CAN_ISOTP and
 CAN_BCM
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>
References: <20261113-can-bcmlock-memcg-v5-0-634c0e04bc72@hartkopp.net>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261113-can-bcmlock-memcg-v5-0-634c0e04bc72@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marc,

my stable patches are reviewed now and only have the missing J1939 bla 
bla and remark for a later patch in the same series. So nothing to see 
here ;-)

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113-can-bcmlock-memcg-v5-0-634c0e04bc72%40hartkopp.net

I'll start the other improvements for raw/isotp_getsockopt() and memcg 
for can-next once these patches are in mainline/net.

Best regards,
Oliver

On 13.11.26 11:33, Oliver Hartkopp wrote:
> This series addresses issues that allow unprivileged users to block
> RTNL for the whole system through CAN sockets.
> 
> Patch 1 copies the CAN frames in bcm_sendmsg() outside of lock_sock(),
> so that a stalled copy from user space can not block bcm_notify(),
> which takes lock_sock() under RTNL.
> 
> Patch 2 keeps the procfs entry of a CAN_BCM socket until bcm_release(),
> as remove_proc_entry() in bcm_notify() waits for stalled procfs readers
> while holding RTNL.
> 
> Patches 3 to 5 replace lock_sock() with a private mutex in CAN_RAW,
> CAN_ISOTP and CAN_BCM. The netdev notifiers of these protocols take the
> socket lock under RTNL, while the generic SOL_SOCKET options in
> sk_setsockopt() and sk_getsockopt() access user space under the same
> lock, e.g. for SO_ATTACH_FILTER. As the generic socket options do not
> take the new mutex, they can not block the notifiers anymore. The
> patches for CAN_RAW and CAN_ISOTP depend on commit 43c973a0887d ("can:
> raw, isotp: copy socket options outside of lock_sock()"), the patch for
> CAN_BCM depends on patches 1 and 2.
> 
> All patches are fixes and marked for stable. The following changes are
> not part of this series anymore and will be sent for can-next:
> 
> - "can: enable memcg accounting for user triggered allocations", which
>    has no Fixes: tag and has not been marked for stable
> - follow-up patches for raw_getsockopt() and isotp_getsockopt(), which
>    read the socket options under the new mutex and copy them to user
>    space afterwards. The socket options have been read without a lock
>    before, so this is no fix and goes beyond the lock replacement.
> 
> The series has been tested on a kernel with PROVE_LOCKING and KASAN:
> A stalled SO_ATTACH_FILTER or SO_LINGER on a bound CAN_RAW, CAN_ISOTP or
> CAN_BCM socket blocks RTNL without patches 3 to 5 and does not block it
> with them. Generic and CAN specific socket options have been run
> concurrently on shared sockets while sending and while the CAN device
> was set down, deleted and moved between network namespaces.
> 
> CAN_J1939 still takes lock_sock() under RTNL in its netdev notifier and
> has the same issue with the generic socket options. This is not
> addressed by this series and will be handled separately once the
> currently discussed j1939 patches have been merged.
> 
> ---
> Changes in v5:
> - removed patch 6 "can: enable memcg accounting for user triggered
>    allocations" from this series, it will be sent for can-next
> - patches 3 and 4: the comment for conf_lock names setsockopt, as most
>    options are read without the mutex in getsockopt() like before. The
>    commit messages point to the follow-up patches (Sashiko review)
> - Link to v4: https://patch.msgid.link/20261111-can-bcmlock-memcg-v4-0-5428607a608f@hartkopp.net
> 
> Changes in v4:
> - new patches 3 to 5: replace lock_sock() with a private mutex in
>    CAN_RAW, CAN_ISOTP and CAN_BCM, so that the generic SOL_SOCKET options
>    can not block the netdev notifiers under RTNL anymore
> - patch 6 (was patch 3): charge the isotp RX buffer to the memory
>    cgroup of the socket with set_active_memcg() (Sashiko review)
> - Link to v3: https://patch.msgid.link/20261109-can-bcmlock-memcg-v3-0-2d798ca30578@hartkopp.net
> 
> Changes in v3:
> - patch 2: read bo->bound and bo->ifindex with READ_ONCE() for NETDEV_DOWN
>    and shortened the bcm_notify() comment (Sashiko review)
> - Link to v2: https://patch.msgid.link/20261108-can-bcmlock-memcg-v2-0-19fafdfc9d12@hartkopp.net
> 
> Changes in v2:
> - patch 1: fixed the description of the stack buffer and described the
>    remaining generic SOL_SOCKET paths (Sashiko review)
> - patch 2: read and write bo->ifindex with READ_ONCE()/WRITE_ONCE() for
>    the lockless access in bcm_proc_show() (Sashiko review)
> - patch 3: keep the GFP_USER | __GFP_NOWARN flags of memdup_sockptr()
>    for the filters and describe the local j1939 ECUs (Sashiko review)
> - Link to v1: https://patch.msgid.link/20261107-can-bcmlock-memcg-v1-0-482d9f5be1fd@hartkopp.net
> 
> ---
> Oliver Hartkopp (5):
>        can: bcm: copy the CAN frames outside of lock_sock()
>        can: bcm: do not remove the procfs entry in bcm_notify()
>        can: raw: use a private mutex instead of lock_sock()
>        can: isotp: use a private mutex instead of lock_sock()
>        can: bcm: use a private mutex instead of lock_sock()
> 
>   net/can/bcm.c   | 114 ++++++++++++++++++++++++++++++++++++++++----------------
>   net/can/isotp.c |  28 ++++++++------
>   net/can/raw.c   |  41 ++++++++++----------
>   3 files changed, 119 insertions(+), 64 deletions(-)
> ---
> base-commit: 30c71476d842b094651bd7712f6c8ee8716147d0
> change-id: 20261107-can-bcmlock-memcg-2d8ae7361838
> 
> Best regards,
> --
> Oliver Hartkopp <socketcan@hartkopp.net>
> 

