Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.220
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792928616;
	b=luWxaaVL+S1C2RsvE/kHZYEueONxujS+xZiqayFWwnJpIhNrZEVvv2CsRkMnvej4lIxH
	 Qc4wMDxLC57xbEVU08zF0qI9u3bw/493QEDZ2fNisLI5e1o6aZhlbT50ZU4n1QoH7n1Pz
	 J2R0ZOkwd9j6KZ6Pdx/onDMkffxEgbFFafwAO3yDixuaihL81nnl75f4SotCM6ttafBQb
	 tW0gRxGDqYs6vRmZSzvrDsjZvbsdHrkVajAvigcdDSHOg+pSkI4apVXGQKlsOZEf6C1CM
	 j2uOWNC/uG7s3rlrYPWtsZb2blUMfgPR2PkwpbxPbgV1fEiHQ+RBRmezf5XyV6PHaQQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792928616;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 References:Content-Language:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=4q0hYP+Aag5ENXlHD39/tP7SPHl5wL+4LewZvavAmVk=;
	b=zr9xKG5VWQolwODwS2Uukkmp2T/OT7XotHCzsud2Qeq18b2cjLc0BX+dCwq/Ht8j98yi
	 MKIX+P8uUa55l5UWNSxZv2Bv6NVepWGhQabb2e50MFR1Te7HWcD5C+Qre24oDLS3jLPjn
	 gkOO2NDD5d50zsgHo/F19P9hNSnA1+B379tD76laRPfmo3zQVykgMOAHLAGT/WD896ATH
	 C3rwCvFxTC/+ij2ks9sEZc5SrRpnL3z1gc4LV29sfOhxNXLUT360Xu2sPbnTkfBYWJIBj
	 DEzQpYnVED2vg/d3/23mfk8EWTOy9rpCq5FdOg1eh5zmUgvtOieyHAvJDv7tCA95rRQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=bR0CKkH2;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=winChasj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.220
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D91606A31D
	for <linux-can@vger.kernel.org>; Sun, 25 Oct 2026 11:43:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6D91606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=bR0CKkH2;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=winChasj
ARC-Seal: i=1; a=rsa-sha256; t=1792928607; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Ym6SJ+3kWT+Kj8aUdJbSvUt0WIOi4e1oqOAHNnhVMdt8bIEG2a6zod4WgV9xtW67w8
    55GNi1dXrRq137DBEm3iATw7i7uYZqeF2r8d25h+my8KoMZN4aWx5nccCN5H9+tLSRMG
    7RR4qOlFLxia9jyDXbtBQ+yvpXKm/acQu2+bjjrwWq3/3Sp5OzY4a4/s/LkQz/7asD2z
    j5oS68FVQEEyeU5MIUnDZ/Z5inhwQqTXyYuEQw0LLW9ZHR26eCtlLASDkdgQ+cDoBM9h
    mxnSHd28Fej+ZtbbDA+vNJY3uNDZuTJ1ahR/l+/FKgWqGMTSIUdTTRtifnKzkXiWEXXI
    DABw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792928607;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:Cc:References:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=4q0hYP+Aag5ENXlHD39/tP7SPHl5wL+4LewZvavAmVk=;
    b=HlhswNlUgyqXCBAsLxkqN73V09Iif3+67s6thGEDzkCoE6d36V/53eU8iM3rZfu960
    oVpHUmfdgk2L9AH7GYwSBKWvo8/KAGQI0IDAXqwJmryLWLUxDp+CGHliszY3wg9OYL02
    sz0o9FNVtkLZ14HGguNiOnXBTkEjXzCXOHKYY0SVULqy5t3QDx/Jkd+uRZZGHSip4UrJ
    kkpdmbiYycuifV1OZ77u1CGPOld2JLzu4aQxOqG8ftou6Buh5+p3Z4EaoZLgeVbGp2Ko
    cFB86VW5w9T3SzPT2LLJLIhBdgjE/tRrTGEWUABGdysMxVU190aV3Y199UKhgAsclu3K
    /Jxw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792928607;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:Cc:References:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=4q0hYP+Aag5ENXlHD39/tP7SPHl5wL+4LewZvavAmVk=;
    b=bR0CKkH2Y4iWJGpX8z26ioaJtnVX6UoCsKP8duthO2933dP2LeeNh+5E3WS2hnio3g
    hvxvAW3dGFyFrkhXEUQSrROnGOwmjYBbF2TCnYAqEzPyPLdtlitY4NsKW+k5yBJNBVKZ
    0enKdeVPDNoyqJRRUl+nacHGz8FDlbZRf0uNM88YtqMaCwT/L9wA3GDP5FQAsbCgGQnR
    KRpGn4RZcU5fc0AcFVM0FuoH7hdApbCQHUCdXL8szkjIRWaata8EM6vO+IWxmyCt2ZT0
    PG0c8Q1LqKA2Vomd1d0rV+OmxZ3K2ABLs9c+1DAzZcyx2g16LK+oOmnuwVU86ftJt1SV
    /sBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792928607;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:Cc:References:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=4q0hYP+Aag5ENXlHD39/tP7SPHl5wL+4LewZvavAmVk=;
    b=winChasjp1snmyxS/MgbsRFIVi96wjdoMTlcXkksQCFFGUPcR57Pf52Mx8vCE8bVpB
    +e66WBRWFXUuExrT0XDQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTRoMrpo2Pns16vtKmsoT3b16bLNh0YhzjPm4XMs1vBXW4E8fxBQ="
Received: from [IPV6:2003:d5:5719:e000:2277:ece7:5bca:cf73]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29PBhRy4t
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 25 Oct 2026 12:43:27 +0100 (CET)
Message-ID: <bd31fd1b-1fe7-44a5-99ee-635262a1ed33@hartkopp.net>
Date: Sun, 25 Oct 2026 12:43:21 +0100
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
Subject: Re: [PATCH v8 0/7] can: protect the receive lists with a per-device
 lock
To: Marc Kleine-Budde <mkl@pengutronix.de>
References: <20261023121801.3052075-1-socketcan@hartkopp.net>
Content-Language: en-US
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261023121801.3052075-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marc,

this latest patch set does not apply to any of those 7 "Baseline" repos 
tested by sashiko:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261023121801.3052075-1-socketcan%40hartkopp.net

The patches sashiko had problems with were

patch 4: can: replace ARPHRD_CAN type checks with can_get_ml_priv()
patch 5: can: protect the receive lists with a per-device lock

As requested I added two new patches addressing sahikos reports, which 
increases this series from 5 to 7 patches:

patch 4: can: replace ARPHRD_CAN type checks with can_get_ml_priv()
patch 5: can: isotp: check the return values of can_rx_register() in 
isotp_bind()
patch 6: can: protect the receive lists with a per-device lock
patch 7: can: raw, isotp: copy socket options outside of lock_sock()

My question: How can we get a sashiko review for this before sending a 
new net PR?

One idea would be to set linux-can-next/HEAD to contain the last commit 
before "can: replace ARPHRD_CAN type checks with can_get_ml_priv()":

b4b56efd3e30 ("can: proc: remove pointers from CAN specific proc output")

so that I would send a v9 patch set containing only the 4 updated 
patches (currently counted 4 .. 7) for review.

Best regards,
Oliver

On 23.10.26 14:17, Oliver Hartkopp wrote:
> This series fixes a use-after-free in CAN_ISOTP and CAN_BCM that can be
> triggered when a CAN device is moved to another network namespace while
> a socket bound to this device is released [1].
> 
> Patch 5 makes isotp_bind() check the return values of can_rx_register(),
> so that bind() does not succeed with missing receivers.
> 
> Patch 7 copies the CAN_RAW and CAN_ISOTP specific socket options from
> and to user space outside of lock_sock(), so that a stalled copy can not
> block raw_notify() waiting for lock_sock() under RTNL.
> 
> The code of patches 1-4 is unchanged. Only the commit message of patch 4
> has been updated after the Sashiko review of v4 to describe the actual
> NULL pointer dereference in can_rx_unregister() and the CAN_ISOTP path
> that reaches it.
> 
> The series is based on linux-can-next/testing, which also contains
> "can: raw: remove redundant NULL check before netdev_hold()" from [2].
> 
> The idea behind patch 6:
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
> Instead, patch 6 protects the receive lists where they are located: A
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
> [2] https://lore.kernel.org/linux-can/20261018164417.1540449-1-mkl@pengutronix.de/
> 
> Previous versions of patch 6:
> v7: https://lore.kernel.org/linux-can/20261022114202.180023-6-socketcan@hartkopp.net/
> v6: https://lore.kernel.org/linux-can/20261021231130.2085690-12-mkl@pengutronix.de/
> v5: https://lore.kernel.org/linux-can/20261020203257.230955-6-socketcan@hartkopp.net/
> v4: https://lore.kernel.org/linux-can/20261019152741.54854-6-socketcan@hartkopp.net/
> v3: https://lore.kernel.org/linux-can/20261019074244.50391-5-socketcan@hartkopp.net/
> v2: https://lore.kernel.org/linux-can/20261018180739.689750-1-socketcan@hartkopp.net/
> v1: https://lore.kernel.org/linux-can/20261017201935.399233-1-socketcan@hartkopp.net/
> 
> Oliver Hartkopp (6):
>    can: proc: skip stats calculation after reset in can_stat_update()
>    can: proc: remove pointers from CAN specific proc output
>    can: replace ARPHRD_CAN type checks with can_get_ml_priv()
>    can: isotp: check the return values of can_rx_register() in
>      isotp_bind()
>    can: protect the receive lists with a per-device lock
>    can: raw, isotp: copy socket options outside of lock_sock()
> 
> Runyu Xiao (1):
>    can: proc: reset pkg_stats atomics individually
> 
>   Documentation/networking/can.rst |  16 +-
>   include/linux/can/can-ml.h       |   3 +
>   include/linux/can/core.h         |   2 +-
>   include/net/netns/can.h          |   2 +-
>   net/can/af_can.c                 |  60 ++++---
>   net/can/af_can.h                 |   2 +-
>   net/can/bcm.c                    |  64 +++----
>   net/can/gw.c                     |   9 +-
>   net/can/isotp.c                  | 206 ++++++++++++++---------
>   net/can/j1939/main.c             |   2 +-
>   net/can/proc.c                   |  95 ++++++-----
>   net/can/raw.c                    | 278 ++++++++++++++++++-------------
>   12 files changed, 427 insertions(+), 312 deletions(-)
> 

