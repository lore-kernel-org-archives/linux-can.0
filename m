Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86A73A16A1
	for <linux-can@vger.kernel.org>; Tue,  1 Sep 2026 07:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788246132; cv=none; b=O51wRqYp+pTYU8OlE+RTQeCTLs+xR6yQEAO9C8IrqiDnKiqMA0FKv2ChW+zXtT4iRYt0pv6VpAI/Sq3YQ8L1Y+U4gib4QrRJNjM1UJYMNFWwiQLc5DPO793uTQQWIBePZUn+JVMoLCCw1BNoa5X14119bgFhbr5CRuyr+6kMoio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788246132; c=relaxed/simple;
	bh=1tVJVFq3W2CWu2gl2ygoskorZBUU7AtPQpGG1dkvqYw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fBcCUS/iUurpIVMLiTxkr/3LMNRaT8owS9goVwAaWxFiLkqI7ZgzukPM0gOKFbPCq7OtQhBtTIp9Cu4L47jRRYzBmv1b/g/a/zmtlM9+gGE/xD+L3Vn+rbeyBP1p7FTRP4HWZx9iXL2GdVqdXUgdQofHKUiBKDjuz4WUsvBL/Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=QvirEmVM; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="QvirEmVM"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a5f1d0af69so6939106a12.0
        for <linux-can@vger.kernel.org>; Tue, 01 Sep 2026 00:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1788246128; x=1788850928; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2M/jGXwNV+sYka8BTRloCdb7CFduDV3zUnRzw5nv/RE=;
        b=QvirEmVMZoXjAtkIMUgzgnwzeemhyp1cX1+rttLbzqJO2Y+EngedRdGs5R7hJ8UoAM
         PJfFxU0RhlBlfPGuryZGdppGiOOBPjhngItqQhaYThFlsQZb7a3+9daH3qbzcIWZvDFl
         KnlsFTEVWgOOwJUDo48jAEugurNkiflZ97LfhKJSL9H14fN5ewTowHfIJRSn0fty45QN
         IEHqQKUXtYRdEvbhPtMMg9jnH4r6nyPzqkGT61NL6au1UHFxBYuC8R+pMquI/a/cImrZ
         Hu0S/VyILqyuRq88bLSAiH+cj1eGAHyknXQEbvVU/4d16I6jRIY7FWaQUHX5vwQtuOm1
         +Aqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788246128; x=1788850928;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2M/jGXwNV+sYka8BTRloCdb7CFduDV3zUnRzw5nv/RE=;
        b=aOvwlGRVCzYpGfqcMKTbXyWLDaaS0rGurHSGDuGWKNfqEobdH4PuEEqihzbon8ko/H
         q76Xae4yrm22kl5W+Xnqv54Q72N1BggNNwaYEj6EtWuE5n1OhmeRXhsobF1Mw/3aYPh8
         aSmg27AT+NhDRjusRr1kMshjqsnnLKnkB1jKAVIxFOiLttBw4J4lEnTMzVQTGtTLBHDq
         GIoxDmuDKkc+c51OYWGtrlf1hqv35Wuqg7x7tA7kFSFhUMOV+1Bd9ggRDD2zJ86dao1o
         DE7fknN2CxrncMmVaDlkJW7WI+cSaqtYIqMnfSnj7MkSgvIK2XGO+0N3jVdY5Cd0m6OC
         xDwg==
X-Gm-Message-State: AFuF++m3qoA1g5VtV2Nb0F8J+cPYYN5LJE+sMZtsXdBfMcgYGBAzXI4X
	E0gclSDQK7sBn8AgRSI3oBnkJuqP6n0troiJbtPxN9NphhqesSeTytOhdfFL3bE5Vx9O2Ip4z/f
	tgIqhzqk=
X-Gm-Gg: AYBFou1dbwwC2Gi6OFkG3N3hGfExOtunlf+Lvp5/3ABYxL5cHPBOuEZQ/QJbRm8acN4
	6urv+Ysqj/0DRXIDezcgLS2sHNn69PKthOT1LcKzsjGhHKB76+r0NvVibSQ4xV/Dhyru0jHkMh5
	MgWWcgfajAdjqEg9bN64i9gjysmZeW+J2s8ZY0YaoWSkjJPfWuPzxHdZfSNprCEsk95xo7iqRZQ
	rwx6SDQyFppy19xtR/WgIOoNga0cgzMXjl47vh5yyyAeRpa1zzxhTbzVKhqsbibds2Ycy6Z7gKy
	KbEt/v9mpZGkNaUCQ3nt0licl8ym09uhsLmWxWClqMFDBnZ05mcavxVWQta5zLVLp75ZGRgoutX
	OM56J/jVDsTVopZZOXmBX3GA2iAlNgOWHHrtx1i76S9m697zKbPWW8kH+J708GRfmd7tc51I4dV
	ATaWiw6KSS8mySoDolRl0PPt0XcZ+ZYlXDyA4at46d5BHBhUrhXtg3BJx1v+ZqLHumeufsDCSNg
	DvLC5OERiJgf/FEKYmfV7RCpW4uTbZ/P4ne2LjtTqnoBgvwThpB
X-Received: by 2002:a05:6402:2383:b0:6a6:6389:37d5 with SMTP id 4fb4d7f45d1cf-6a6638949bfmr4028036a12.8.1788246127439;
        Tue, 01 Sep 2026 00:02:07 -0700 (PDT)
Received: from smtpclient.apple (83.10.35.35.ipv4.supernova.orange.pl. [83.10.35.35])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a66ccb753bsm364169a12.4.2026.09.01.00.02.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Sep 2026 00:02:06 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH net] can: isotp: take rtnl_lock() before leaving the
 notifier list
From: Norbert Szetei <norbert@doyensec.com>
In-Reply-To: <2c5851d3-cd83-4a16-91ed-b7323cabe7c0@hartkopp.net>
Date: Tue, 1 Sep 2026 09:01:54 +0200
Cc: linux-can@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E1633997-A167-405C-9B1D-4FFED8E4A595@doyensec.com>
References: <CEA6A38A-2646-4ADA-95B4-CBAE2F301A8E@doyensec.com>
 <2c5851d3-cd83-4a16-91ed-b7323cabe7c0@hartkopp.net>
To: Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: Apple Mail (2.3826.700.81.1.4)

Hey Oliver,

> On Aug 31, 2026, at 15:08, Oliver Hartkopp <socketcan@hartkopp.net> =
wrote:
>=20
> Hello Norbert,
>=20
> many thanks for your patch and the analysis of the unremoved filter =
lists in the case of moving a CAN device to another namespace.
>=20
> But I don't think that moving rtnl_lock() up so that it covers a busy =
loop including a schedule_timeout_uninterruptible(1) wait is not a nice =
move for other rtnl_lock() users.
>=20
> Focussing on the removal of the correct filter lists when the =
namespace is changed away from the socket's namespace I would propose =
this small change:
>=20
> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 155530aedce2..0835a4758a72 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -1490,15 +1490,15 @@ static int isotp_release(struct socket *sock)
>        /* remove current filters & unregister
>         * tracked reference so->dev is taken at bind() time with =
rtnl_lock
>         */
>        if (so->bound && so->dev) {
>                if (isotp_register_rxid(so))
> -                       can_rx_unregister(net, so->dev, so->rxid,
> +                       can_rx_unregister(dev_net(so->dev), so->dev, =
so->rxid,
>                                          SINGLE_MASK(so->rxid),
>                                          isotp_rcv, sk);
>=20
> -               can_rx_unregister(net, so->dev, so->txid,
> +               can_rx_unregister(dev_net(so->dev), so->dev, so->txid,
>                                  SINGLE_MASK(so->txid),
>                                  isotp_rcv_echo, sk);
>                netdev_put(so->dev, &so->dev_tracker);
>        }
>=20
> @@ -1846,13 +1846,10 @@ static int isotp_getsockopt(struct socket =
*sock, int level, int optname,
> static void isotp_notify(struct isotp_sock *so, unsigned long msg,
>                         struct net_device *dev)
> {
>        struct sock *sk =3D &so->sk;
>=20
> -       if (!net_eq(dev_net(dev), sock_net(sk)))
> -               return;
> -
>        if (so->dev !=3D dev)
>                return;
>=20
>        switch (msg) {
>        case NETDEV_UNREGISTER:
>=20
>=20
> Can you give it a try with your KASAN setup and maybe also ask opus =
about my idea?

I just tested your version and I was no longer able to reproduce=20
the bug. Initially, I considered it too, but moving rtnl_lock()=20
sounded simpler and I had not thought about the busy-wait sitting=20
there. Thanks for pointing this out and submitting the patch.

Regards,
Norbert

> Many thanks,
> Oliver
>=20
> On 31.08.26 10:30, Norbert Szetei wrote:
>> isotp_release() removes the socket from isotp_notifier_list before it
>> takes rtnl_lock(). The netdev notifier chain runs under RTNL, so a
>> socket that leaves the list in that window is skipped by =
isotp_notify()
>> and has to unregister its own CAN filters.
>> It cannot always do that. isotp_release() passes sock_net(sk) to
>> can_rx_unregister(), which returns early when that netns no longer
>> matches dev_net(dev), before the receiver list is searched and before
>> the "receive list entry not found" warning. Once the bound device has
>> been moved to another netns the filters are removed zero times, and
>> can_rx_register() stores rcv->sk without taking a reference, so the
>> receivers left in the device's dev_rcv_lists point at the freed =
socket
>> and travel with the device into the new netns.
>>   BUG: KASAN: use-after-free in isotp_rcv+0x1570/0x24d0
>>   Read of size 1 at addr ffff888118130552 by task isotp_ns_uaf/578
>>    can_rcv_filter+0x4af/0x8c0
>>    can_receive+0x28d/0x3c0
>>    can_rcv+0x2a9/0x310
>>    __netif_receive_skb_one_core+0x21a/0x260
>>    process_backlog+0x210/0x760
>> Take rtnl_lock() before removing the socket from the notifier list, =
so
>> that isotp_release() and isotp_notify() cannot both skip the removal.
>> Fixes: 20bab8b88baa ("can: isotp: fix use-after-free race with =
concurrent NETDEV_UNREGISTER")
>> Cc: stable@vger.kernel.org
>> Assisted-by: Claude:claude-opus-5
>> Signed-off-by: Norbert Szetei <norbert@doyensec.com>
>> ---
>> Reproducer available on request.
>>  net/can/isotp.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> diff --git a/net/can/isotp.c b/net/can/isotp.c
>> index 155530aedce2..8ca75d30360c 100644
>> --- a/net/can/isotp.c
>> +++ b/net/can/isotp.c
>> @@ -1475,6 +1475,8 @@ static int isotp_release(struct socket *sock)
>>   /* forced SHUTDOWN may have skipped IDLE (gave up on a signal) */
>>   wake_up_interruptible(&so->wait);
>>  + rtnl_lock();
>> +
>>   spin_lock(&isotp_notifier_lock);
>>   while (isotp_busy_notifier =3D=3D so) {
>>   spin_unlock(&isotp_notifier_lock);
>> @@ -1484,7 +1486,6 @@ static int isotp_release(struct socket *sock)
>>   list_del(&so->notifier);
>>   spin_unlock(&isotp_notifier_lock);
>>  - rtnl_lock();
>>   lock_sock(sk);
>>     /* remove current filters & unregister
>=20

