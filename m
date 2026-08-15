Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A058E31F9A6;
	Sat, 15 Aug 2026 15:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786809281; cv=pass; b=YcxbcX0xlSWaazXZq4spTUVGx4uIBqit3MjTKb2mV4KXJVFSb853FZQ3igJ5Xfcr4GJIOKxDzoO1RmFnAdaCrhr8kMT/pfkW9zMq3ML/Zc+7ntOoLZrj7c/+Ffm0Cy7P/jUpFdsKBBuftY3j1tXdVpYpFfu0pTkN3G+q5uCf0YY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786809281; c=relaxed/simple;
	bh=9GJ8tebMbhbs/xYEkTi97YFbN65MILp5d2ztt/Z+SoQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ALLAvUMmaaVqSUnFvQ56cv13r/Ae+3SBgl7fcGwzItrs2vgY+gM8iYypq6Qkf5jaI0X2cyU8DceGAop3dAQV0jrpRW5QeCDkDVbNpXh+aDBkwCptValL0hmXixdtxCY991jJJQEEvHTHvp+PFsV7aSnXX4hK7bmxG3SwUP6trgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=pO4XLcAf; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=hLI/MpTj; arc=pass smtp.client-ip=81.169.146.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="pO4XLcAf";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="hLI/MpTj"
ARC-Seal: i=1; a=rsa-sha256; t=1786809274; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=TDp1XVVFdnfK9POk4POsHjPIp9+rHro20D40mYP5EAc7FhD0CY0zgdS2m2VC1gGIZj
    hjzSXdUF3HOGF9VElBly6P4RaOcgUbnCCFmQzUKU1rydeE+8a5hBIVxgyPt+FBFdGimO
    h/2DIyXliWpzswBT6PbO42r/nu/C7BhsDrne09bOvmrWSdVv+QYQl25jkrtLpAsOgiNI
    b58oRKO4OpmWlXnBKCc4CY0CZN7vUUTwtKpk+VOoTZrKwQGfWYVthyy/r0S12LHnQDOE
    kYdA6Y+/bmSrVz6X8Rm7sm116qZDFgdrXSLz/ch0gUvK9CCo//nikCP/MP2OnCR+zXcq
    o4ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1786809274;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=0iJym6nLHti7SC43dxpp2QmBrc16a5SRi5DRHMoc8cE=;
    b=T60e4sm5ilCSyqTFauhtMtKUHiig8DsqGaGW3zD2YtNigCncM/06Y9DSvKxFRl4tgE
    WZKK716/3/P2UyOgtxZqdJzsKj1rCjRX352k0lEHvIn49bAz0eZlhCGG6ato5f1tZR8o
    8koaNwU00MDVLLdrb0RaPgBf8CHO80PF2t/75a2e2/Ln9H+I3tIr5wzuexznWOdrjIWI
    rtDEeb3YMsksev3pUOawapyqLjrOe/wl8piYpKnIiZT3+PDhxfNu6Fn7OyDyQNnrUxDg
    3QVMbMx+Nfr8KPHDYf3FZ1/B+XiUUdfh1g0S4sVYjI5eaxiUt8Od2kLSCmJo9vrpXywR
    fUPw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1786809274;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=0iJym6nLHti7SC43dxpp2QmBrc16a5SRi5DRHMoc8cE=;
    b=pO4XLcAfdkve0VR5ISM6wltmxd05FdosRJLcDL8Qd0koFpXf71mF7twYK2JnPmb/rz
    Y5chiDhoYfRc23JUJG0V928IC6SywqHSQJjd013xgjC0klz9nDPos5lcCRV8V5tY7pPh
    jFjuoWwO5vTfszScH6v4pBfYSS0snXfOHdlu7dKffy7eJl/9JWR94/6RFZ04eKLmh2qh
    io90vAMwCilizVSEaIQLPtZv78G9WT1+NeM9R0dzEGHtQ0LuBNsfeTy0sc+Foe4P1Nfq
    GVXEMOzaSIF6olysFsdfZEw/zYReGkJxjPl+CPHbzTmjx+iHCbnmnsOLrW9OqdAwUqka
    A9qQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1786809274;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=0iJym6nLHti7SC43dxpp2QmBrc16a5SRi5DRHMoc8cE=;
    b=hLI/MpTjX4TA74P8p4iNQRledtSQsOIdyxgV1yYNGwX43MwPEd+wwjDmLShCrpSXwC
    czKm1fPJYGuAsadV39Aw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6800::989]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K171b727FFsX6K9
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 15 Aug 2026 17:54:33 +0200 (CEST)
Message-ID: <4375eab3-b112-47ad-a499-4467c91b98b8@hartkopp.net>
Date: Sat, 15 Aug 2026 17:54:28 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] team: reject CAN and IEEE 802.15.4 devices in
 team_port_add
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: jiale yao <19888972804@163.com>, Jiri Pirko <jiri@resnulli.us>,
 Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <20260728151240.89434-1-yaojiale02@163.com>
 <amnESUrOtl0dXaXk@FV6GYCPJ69>
 <4d056e9f.8019.19fadc9deb5.Coremail.19888972804@163.com>
 <23268b84-a1c5-4551-91ba-0a596cff21a1@hartkopp.net>
Content-Language: en-US
In-Reply-To: <23268b84-a1c5-4551-91ba-0a596cff21a1@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 14.08.26 16:45, Oliver Hartkopp wrote:
> +CC: linux-can ML
> 
> On 29.07.26 14:11, jiale yao wrote:
>> How about adding a helper in include/linux/if_arp.h, similar to 
>> dev_is_mac_header_xmit()? Perhaps
>> something like dev_is_can_or_ieee802154()?
>>
> 
> Good idea.
> 
> But I would rather suggest some
> 
> static inline bool netdev_has_ml_priv(struct net_device *dev)
> 
> in
> 
> include/linux/netdevice.h
> 
> next to
> 
> netdev_set_ml_priv() / netdev_get_ml_priv()
> 
> Currently only the CAN subsystem properly handles the dev->ml_priv_type 
> to make sure the correct "user" of the ml_priv pointer:
> 
> /* Specifies the type of the struct net_device::ml_priv pointer */
> enum netdev_ml_priv_type {
>      ML_PRIV_NONE,
>      ML_PRIV_CAN,
> }
> 
> There are some other ethernet adapters of dev->ml_priv beyond 
> ARPHRD_IEEE802154, and ARPHRD_IEEE802154_MONITOR. Not sure if those 
> adapters need to be fixed.
> 
> But to be sure we don't run into problems with bonding or teaming we 
> should probably simply check for (dev->ml_priv != NULL) to reject them.
> No matter which netdev_ml_priv_type is set.
> 
> static inline bool netdev_has_ml_priv(struct net_device *dev) {
> 
>      return (dev->ml_priv != NULL);
> }
> 
> Would you like to provide a patch introducing this helper and directly 
> use it for bonding/team (with some updated comments, as the problem is 
> not related to CAN and IEEE 802.15.4 devices but to the use of ml_priv)?

I've sent my idea of a combined patch fixing either the bonding and the 
teaming sides by checking the use of ml_priv here:

https://lore.kernel.org/netdev/20260815153938.187073-1-socketcan@hartkopp.net/

Many thanks and best regards,
Oliver

> 
> 
>>
>> At 2026-07-29 17:15:06, "Jiri Pirko" <jiri@resnulli.us> wrote:
>>> Tue, Jul 28, 2026 at 05:12:40PM +0200, yaojiale02@163.com wrote:
>>>> Enslaving a CAN or IEEE 802.15.4 device (e.g. vxcan, wpan0) to a
>>>> team master triggers a NULL pointer dereference because these
>>>> device types use different Layer 2 architectures from Ethernet and
>>>> the team driver never initializes their private mid-layer data
>>>> structures.
>>>>
>>>> Reject ARPHRD_CAN, ARPHRD_IEEE802154, and ARPHRD_IEEE802154_MONITOR
>>>> devices in team_port_add(), mirroring the existing CAN check already
>>>> present in the bonding driver since commit 8ba68464e478 ("bonding:
>>>> refuse to enslave CAN devices").
>>>
>>> Can we perhaps have a unified helper for the check?
>>>
>>>
>>>>
>>>> Link: https://lore.kernel.org/all/b58d98e0-8fe3-4e4e-b8a5- 
>>>> c1c7e647ccca@hartkopp.net/
>>>> Fixes: 1d76efe1577b ("team: add support for non-ethernet devices")
>>>> Assisted-by: Claude:deepseek-v4-pro
>>>
>>> Looks your ai gone a bit wild here...
>>>
>>>
>>>> Signed-off-by: Jiale Yao <yaojiale02@163.com>
>>>> ---
>>>> V1 -> V2: Extended check to also reject ARPHRD_IEEE802154 and
>>>>   ARPHRD_IEEE802154_MONITOR devices per review feedback
>>>> ---
>>>> drivers/net/team/team_core.c | 11 +++++++++++
>>>> 1 file changed, 11 insertions(+)
>>>>
>>>> diff --git a/drivers/net/team/team_core.c b/drivers/net/team/ 
>>>> team_core.c
>>>> index feaa75fbf8fc..d8c46105fc8b 100644
>>>> --- a/drivers/net/team/team_core.c
>>>> +++ b/drivers/net/team/team_core.c
>>>> @@ -1224,6 +1224,17 @@ static int team_port_add(struct team *team, 
>>>> struct net_device *port_dev,
>>>>         return -EINVAL;
>>>>     }
>>>>
>>>> +        if (port_dev->type == ARPHRD_CAN ||
>>>> +            port_dev->type == ARPHRD_IEEE802154 ||
>>>> +            port_dev->type == ARPHRD_IEEE802154_MONITOR) {
>>>> +            NL_SET_ERR_MSG(extack,
>>>> +                       "CAN and IEEE 802.15.4 devices can't be 
>>>> added as a team port");
>>>> +            netdev_err(dev, "Device %s is CAN or IEEE 802.15.4. 
>>>> These device types can't be added as a team port\n",
>>>> +                   portname);
>>>> +            return -EINVAL;
>>>> +        }
>>>> +    }
>>>> +
>>>>     if (netif_is_team_port(port_dev)) {
>>>>         NL_SET_ERR_MSG(extack, "Device is already a port of a team 
>>>> device");
>>>>         netdev_err(dev, "Device %s is already a port "
>>>> -- 
>>>> 2.34.1
>>>>
> 

