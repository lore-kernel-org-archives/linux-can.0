Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=85.215.255.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793205420;
	b=n+xiLitoPrqabujKwiAcjUv2aA46eQmjkax9eONvF6Y8vnZjoOPvExMwgDvItmCQoMTq
	 F49PpoFgqVYdUnzv7voWNVUspp3u7QQIge6rpqASAj9cZhPLuS7On81Pun9LDoWw1zGxo
	 cOMFwxrwFtgUArmXzmK4whk18Q7kr9froWCNlmBLbIdMrrfF1zF3yUwE3EJQMj9qTzZgO
	 m5Hb4CtKq3EraD9nYrDMBHPm+D5Y//dMxah2yMhFiwcCsCRD6/tBasXkT1L9VhfF1wWWG
	 KI6o95JE1BrLB0red2OTTM8bMoMlS+8xQ762YbqGUVhTrNNecbZ+kN1lo9D+4Jlrjqg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205420;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=937bjWjJRaoOT5/F/pB1gaFoqLsckZ2CkctKTIk8kR4=;
	b=zH1jMDjwff0cueG8GSl3U8pCWrE9+KNoKwfZW+TKQ+JQN5B6ER/AFKW+nRl+xbPXs2B6
	 uGTujSH8GAFY1yCtgLjBzKjaEzC52pzq5EBO+FAbEFAiWOD4reIWgtuCSQF+Mqv6A7dTm
	 TCF6iGhTJ7Ix1fBk+lyRso4UiFprVSq6ddowddMJhlwy4Jw0J+OKzcQG9MsKj50LME/pi
	 BtI2lwi2BLZhi46Im5LK0x/DrIa/zrWeNksEvk2efU76ZMGRsq766+2dAzzAgZ0eQygNU
	 aehoLWipL+0L+vuy6WHin9RcLeVQzRK6aoXPrcpBThxq9kyoBaq0LwkNj9j7nfq5rIQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=oAnuAjBq;
	dkim=temperror header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b="S7fk/erv";
	arc=fail smtp.remote-ip=85.215.255.53
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F7E606A329
	for <linux-can@vger.kernel.org>; Wed, 28 Oct 2026 16:36:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11F7E606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=oAnuAjBq;
	dkim=temperror header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=S7fk/erv
ARC-Seal: i=1; a=rsa-sha256; t=1793205387; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ViAGUWKg1Z1iUJQ2AbZS9JIsx5dGhFA+BcGaGP2fe0qpMhw8sBl7k0sdJjyZs4P3PE
    TI8zsm6sN1rm5mbn6syPSO96wIoOEQ/XkCxSpBxIrahSuufruNPpkE2R90OVPAz0C10P
    FUCG98XGoDmpx5iEQAoa8c4H+APiPATZybzfH3vFm8oYLvtHkZwy9RgWHxYVCDLwv8z1
    EhCawyb8qX/7WEbLs+6LZgZLG5+bmDBeLrkfinPcAYCqYoaq3mq7fwzV8ERtj0S6nbXX
    HUv5wTl9aN4Y6XQOzM0h2YDX/t3yh+9CFXnYxP1GSPyvX69W/3uTQCvRJBpjzf4gyT6n
    qZ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793205387;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=937bjWjJRaoOT5/F/pB1gaFoqLsckZ2CkctKTIk8kR4=;
    b=UYkAdHf9tq4sfZH3zwD+xaUFpTXf4r/N3st8pOwlX8vE/LPqVa9yKh/2vLe42Z2sJi
    Jf/v5Cc96N3bHtiRFcAXRiapuKCgW60oR9rXvBa2AgWCZeFtgQG2wcEqCWzbCg6/ZTnq
    lTF4VvStZo2jPef/OmXkiTvrJhCRR8uAlj07UsBwqei+VCNb9cWNfUipmkFRFnWV5Tze
    pxjFxm86A2r3ewjcBdj08aHmTwVuCSYBS+ZUHSOs+4H5/2uyMT5di0By+2Nie5CQy2mn
    bL6IRIWV9pyGk5F7qhM4cxecM2TCzSKoLa6gRDUU1rF3JDoax0oeyf9yOGZb0WXsmySs
    oMMQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793205387;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=937bjWjJRaoOT5/F/pB1gaFoqLsckZ2CkctKTIk8kR4=;
    b=oAnuAjBqy8bBsPJijGItp0UCe2efA9ZW9p1lFXG1+NTIy9FiSU5gVCSUi1lqcj23Z7
    bSUqksw4DDZnRPxku1WgyEOG5TWPA2nY5DubEf1kL/tFwI4RdtLX7wJl3j4qsQasXT0c
    MT1Ne1Bol7dfJ0+lV/Ki4q/6NZc1QejUunCMKVaPboTy+1uY/7tJY5/Mt8flS3cT8879
    DKlnz5qKrRS750G+CMVtwp9AnbLuBvjvsm6DbYIuW3HAOxH8l7oN7N7nJ3kz9jlLuoxj
    ZVnbD4eJqN0HV5fnijMug2SJKBnF+nAfOmH+M2CTmTe2teI+tKOkb4SW7RfHOhIzORhh
    JTlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793205386;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=937bjWjJRaoOT5/F/pB1gaFoqLsckZ2CkctKTIk8kR4=;
    b=S7fk/erv3C+ZPWjoxoK+R4FXh5gHJUYiVjUjqgDbtV6ctfIwiNm7/ZAlg9AuilO7Dp
    GAtde1i78iLe35HneECA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29SGaQKts
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 28 Oct 2026 17:36:26 +0100 (CET)
Message-ID: <1e9a2768-e30e-4f2d-bc71-57550d210c0a@hartkopp.net>
Date: Wed, 28 Oct 2026 17:36:26 +0100
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
Subject: Re: [PATCH v12 0/7] can: protect the receive lists with a per-device
 lock
To: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
 Norbert Szetei <norbert@doyensec.com>, Runyu Xiao <runyu.xiao@seu.edu.cn>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20261027-can-rx-lock-v12-0-eb5afc2d8b9b@hartkopp.net>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261027-can-rx-lock-v12-0-eb5afc2d8b9b@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marc,

from my side v12 is ready to be applied.

Sashiko says:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261027-can-rx-lock-v12-0-eb5afc2d8b9b%40hartkopp.net

The remaining Sashiko findings on v12 are either issues that are fixed 
by later patches of this series (as Sashiko notes itself o_O) or 
pre-existing issues that are not related to this series:

- CAN_BCM and CAN_J1939 also copy user space data under lock_sock(),
   while their netdev notifiers take lock_sock() under RTNL. This is not
   a new problem introduced by this series. I will look into this later.
   It does not affect this patch set.

- The user_reset in net/can/proc.c is denoted as not network namespace
   aware. This is on my list for a separate can-next patch too.

The only new finding is that isotp_bind() keeps so->rxid/so->txid after
a failed bind(), which is visible via getsockname(). This is intended:
As so->ifindex is reset to 0, there is no interface and therefore no
valid address. The remaining CAN IDs only show that a bind() has been
attempted and failed. No need to reset these values. Sashikos suggestion 
to assign so->rxid/so->txid only on the success path would cause a new 
race at start-up when a FirstFrame is received during the bind() process 
- which is currently solved and working.

Best regards,
Oliver

On 27.10.26 15:31, Oliver Hartkopp wrote:
> This series fixes a use-after-free in CAN_ISOTP and CAN_BCM that can be
> triggered when a CAN device is moved to another network namespace while
> a socket bound to this device is released [1].
> 
> Patch 2 makes isotp_bind() check the return values of can_rx_register(),
> so that bind() does not succeed with missing receivers.
> 
> Patch 4 copies the CAN_RAW and CAN_ISOTP specific socket options from
> and to user space outside of lock_sock(), so that a stalled copy can not
> block raw_notify() waiting for lock_sock() under RTNL.
> 
> Patches 5 and 6 fix the reset and the calculation of the CAN statistics.
> 
> Patch 7 removes the pointers from the CAN specific proc output. As it
> changes the proc output ABI it is not intended for stable and has been
> moved to the end of the series, so that patches 1-6 can be backported
> without it.
> 
> The code of patches 1 and 5-7 is unchanged since v4, apart from the
> rebase of patch 7 in v12. Only the commit message of patch 1 has been
> updated after the Sashiko review of v4 to describe the actual NULL
> pointer dereference in can_rx_unregister() and the CAN_ISOTP path that
> reaches it.
> 
> The series is based on net/main.
> 
> The idea behind patch 3:
> 
> The receive lists of a CAN device are located in the device's
> can_ml_priv and travel with the device when it is moved to another
> network namespace. But they are protected by the per-netns
> rcvlists_lock, so the lock that protects a device's lists depends on
> the namespace the caller passes to can_rx_register() and
> can_rx_unregister(). can_rx_unregister() silently returns when this
> namespace does not match dev_net(dev) anymore.
> 
> isotp_release() and bcm_release() leave the netdev notifier list before
> they can serialize against the notifier. When the device changes its
> namespace in this window, their filters are not removed and the
> remaining receivers point to the freed socket or bcm op.
> 
> Taking RTNL in these release paths is no option, as CAN_RAW already
> holds RTNL while adding and removing up to CAN_RAW_FILTER_MAX filters
> per socket, which unprivileged users can trigger repeatedly.
> 
> Instead, patch 3 protects the receive lists where they are located: A
> spinlock in struct can_dev_rcv_lists protects the lists of a CAN device
> (initialized in can_set_ml_priv()) or the 'any' CAN device lists of a
> namespace (initialized in can_pernet_init()). can_rx_unregister() then
> finds the subscription independently of the current namespace of the
> device, which is kept accessible by the tracked device references the
> protocols already hold. The per-netns rcvlists_lock only protects the
> receive list statistics, for which CAN_RAW, CAN_BCM and CAN_ISOTP pass
> the namespace that has been used for can_rx_register().
> 
> As a consequence, CAN_RAW and CAN_ISOTP do not need RTNL in bind(),
> setsockopt() and release() anymore. bind() is serialized against
> NETDEV_UNREGISTER by publishing the device inside the RCU section of
> its lookup, as unlist_netdevice() and synchronize_net() precede
> NETDEV_UNREGISTER both on unregistration and on a namespace change.
> The notifiers recheck the binding under lock_sock(). As RTNL does not
> keep NETDEV_DOWN out of bind() anymore, bind() checks IFF_UP after
> publishing the bound device, with an smp_mb() pair against the
> notifiers, so a down transition during bind() is still reported with
> ENETDOWN.
> 
> ---
> Changes in v12:
> - reordered the patches: the former patches 4-7 are now patches 1-4 and
>    the former patches 1-3 are now patches 5-7, so that "can: proc: remove
>    pointers from CAN specific proc output" (ABI change, not for stable)
>    is the last patch
> - patch 2: check IFF_UP after the successful registrations, so that a
>    bind() that fails on a down device does not report ENETDOWN (review of
>    v11)
> - patch 4: Fixes: tags point to the commits that put the user space
>    copies under lock_sock() (review of v11)
> - patch 5: note on the x86_64 test results and the architectures
>    affected by the memset() (review of v11)
> - patch 6: added Cc: stable, as patch 5 is Cc: stable (review of v11)
> - Link to v11: https://patch.msgid.link/20261026-can-rx-lock-v11-0-3b9a2b829dab@hartkopp.net
> 
> The patch numbers in the following changelogs refer to the patch order
> up to v11.
> 
> Changes in v11:
> - rebased to net/main without "can: raw: remove redundant NULL check
>    before netdev_hold()" [2]
> - patch 6: keep the NULL check of ro->dev before netdev_hold() in
>    raw_bind() as found in net/main
> - Link to v10: https://patch.msgid.link/20261026-can-rx-lock-v10-0-281c4b556a1a@hartkopp.net
> 
> Changes in v10:
> - patch 5: register the echo receiver first and the RX receiver as the
>    last step, set so->ifindex before the registrations (Sashiko review)
> - patch 6: rebased on patch 5
> 
> Changes in v9:
> - rebased to net-next/main on top of "can: raw: remove redundant NULL
>    check before netdev_hold()" [2] (no code changes)
> 
> Changes in v8:
> - new patch 5: check the return values of can_rx_register() in
>    isotp_bind() (Sashiko review)
> - patch 6 rebased on patch 5: isotp_bind() resets the published so->dev
>    again when the registration of a receiver fails and checks IFF_UP at
>    the end of a successful bind(), as raw_bind() does
> - patch 6: isotp_notify() reports NETDEV_DOWN only for a bound socket, so
>    a failing isotp_bind() can not get a needless ENETDOWN
> - patch 6: isotp_sendmsg() and isotp_recvmsg() read so->bound with
>    READ_ONCE()
> - patch 6: moved copying the user space data outside of lock_sock() in
>    raw_setsockopt() to patch 7 to keep patch 6 focused on the locking
>    changes and to ease review
> - new patch 7: copy the CAN_RAW and CAN_ISOTP socket options outside of
>    lock_sock() (Sashiko review)
> 
> Changes in v7 (details in patch 6):
> - report ENETDOWN in bind() and ENODEV for NETDEV_UNREGISTER under
>    lock_sock(), so ENODEV can not be overwritten by ENETDOWN (Sashiko
>    review)
> 
> Changes in v6:
> - isotp_bind() checks the device before publishing so->dev, so a
>    failing bind() can not get a needless ENETDOWN (Sashiko review)
> 
> Changes in v5:
> - report ENETDOWN for a down transition during bind() again (Sashiko
>    review)
> - comment and kernel-doc updates (Sashiko review)
> - patch 4: commit message describes the actual crash path (Sashiko
>    review)
> 
> [1] https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301A8E@doyensec.com/
> [2] https://lore.kernel.org/all/20260831052031.902699-1-ekffu200098@gmail.com/
> 
> Previous versions:
> v11: https://lore.kernel.org/linux-can/20261026-can-rx-lock-v11-0-3b9a2b829dab@hartkopp.net/
> v10: https://lore.kernel.org/linux-can/20261026-can-rx-lock-v10-0-281c4b556a1a@hartkopp.net/
> v9: https://lore.kernel.org/linux-can/20261025-can-rx-lock-v9-0-7ef2a2b5c2b4@hartkopp.net/
> 
> Previous versions of patch 3 (patch 6 up to v11):
> v8: https://lore.kernel.org/linux-can/20261023121801.3052075-7-socketcan@hartkopp.net/
> v7: https://lore.kernel.org/linux-can/20261022114202.180023-6-socketcan@hartkopp.net/
> v6: https://lore.kernel.org/linux-can/20261021231130.2085690-12-mkl@pengutronix.de/
> v5: https://lore.kernel.org/linux-can/20261020203257.230955-6-socketcan@hartkopp.net/
> v4: https://lore.kernel.org/linux-can/20261019152741.54854-6-socketcan@hartkopp.net/
> v3: https://lore.kernel.org/linux-can/20261019074244.50391-5-socketcan@hartkopp.net/
> v2: https://lore.kernel.org/linux-can/20261018180739.689750-1-socketcan@hartkopp.net/
> v1: https://lore.kernel.org/linux-can/20261017201935.399233-1-socketcan@hartkopp.net/
> 
> ---
> Oliver Hartkopp (6):
>        can: replace ARPHRD_CAN type checks with can_get_ml_priv()
>        can: isotp: check the return values of can_rx_register() in isotp_bind()
>        can: protect the receive lists with a per-device lock
>        can: raw, isotp: copy socket options outside of lock_sock()
>        can: proc: skip stats calculation after reset in can_stat_update()
>        can: proc: remove pointers from CAN specific proc output
> 
> Runyu Xiao (1):
>        can: proc: reset pkg_stats atomics individually
> 
>   Documentation/networking/can.rst |  16 ++-
>   include/linux/can/can-ml.h       |   3 +
>   include/linux/can/core.h         |   2 +-
>   include/net/netns/can.h          |   2 +-
>   net/can/af_can.c                 |  60 +++++----
>   net/can/af_can.h                 |   2 +-
>   net/can/bcm.c                    |  64 ++++-----
>   net/can/gw.c                     |   9 +-
>   net/can/isotp.c                  | 222 ++++++++++++++++++-------------
>   net/can/j1939/main.c             |   2 +-
>   net/can/proc.c                   |  95 +++++++------
>   net/can/raw.c                    | 278 +++++++++++++++++++++++----------------
>   12 files changed, 435 insertions(+), 320 deletions(-)
> ---
> base-commit: 6430fb7f1cc4e329e386521b7b208df443de92f2
> change-id: 20261025-can-rx-lock-cecab2ad832f
> 
> Best regards,
> --
> Oliver Hartkopp <socketcan@hartkopp.net>
> 

