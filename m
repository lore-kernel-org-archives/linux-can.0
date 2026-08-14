Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB5347668D;
	Fri, 14 Aug 2026 14:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718710; cv=pass; b=C37z2p40cYUCEMYb3nx7xSmweS+7vXXvZLtYXpB6gmFgJGnHkmIf+HyyF2yw+4MUl68R4Mh0CEVvO+CsJBM3wqfpYiomyrA6PaNUoqzr/hsOg4S9wVnsYo5UkhISHbPM26m26ZtBx8RhdjfJ7VdUvCpyelww164Q4bs/VyCdKls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718710; c=relaxed/simple;
	bh=ZA28xr+iVjgCaxfE1UtWH+qWgeVBONXZlg6K/q8kG2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CbdLiggXE4COmYTpgTRDWJzS3ZSVTgVn2qs5b4hUpr3wPuLYSvznKPBO3Wpucwf9xO9FAXMK1HAJRx2LyTrmnj/00lXBlcKrM1YL/eVqNPHI5km+8zWFl8/StAxIlYKbpUT/hhTn4qsQT3cV8Kp06Kzs+Mwf8qrRA2hlui4W9t0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ar0kp1ve; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=DmgzzMn+; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ar0kp1ve";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="DmgzzMn+"
ARC-Seal: i=1; a=rsa-sha256; t=1786718703; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=PqW6b6UDgxsXNyKAfADxsD5uPXMZU9KULHkd+EcAUOCL68AB0fHd6I8AABIhkhopZf
    HL7TBT4qed5GkkZFZ2UUbmtLrsb1oLFCgcS5LjqVwGrE6zxVAPnDcqzjf9Zzn8YSsJyw
    8uzPUJXO42UgQDSWQq2fUGMpCX8vJR9603niMME4rWP4kx3VKh5bwv1zQVuEpam7E9bY
    iM+I7t6u4b+EIjOjHrOqLSAyjy54BFvx201IlMzAdH0Ma9JnmDDLw521U+EJf4IWO6Tv
    sXTIckjDAem4s7CzwjO9FVfzC8IV2MvmWpCaaoxr8oZi7q8zEi2raNMpYST4SGXO2QNb
    AJJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1786718703;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=EsqOj8Ow7/SXlnyAiIvTkIIyt5WvYytlt6ZVXM/E3R4=;
    b=Ib3l4fScBkTFD+VyFezBqNid+js9Z857A5u6rDE5ipNTL1ALTmK2QC1mORBSCH8Rmn
    LZVTf57AjBU9gDY70vSLZQczasSQl0QtVzZc47nxdDe+HfDj/n6G1g5f2XLvDzlNGr3P
    RLTqrDEKKSZN1cO5MDNUwhdHPCOV3M7ECxiMX5MKnqKIll/ENf+iaY4dC/R8GRMq/dmQ
    dMyok+5Iz8kMD9eFZFdmUiV8pevLmh/IahalCApQovfbXma68COm70oD37mtjsjUCB+e
    8iuwzKrGPtl06cyZ5kXmb19pLM/MvE04grklRe97DoeApso/kIoVaIn+RkSFqwpAjvtM
    soYQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1786718703;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=EsqOj8Ow7/SXlnyAiIvTkIIyt5WvYytlt6ZVXM/E3R4=;
    b=ar0kp1veVR6ZZdHmvx7oLg4WqAPmMOiePhg75Klw9JKWNq5JrIFwd8efoG3scmV6C2
    uS3HsASESv2lSnsEAqKF/HmA2zivwp5czs/8c9dedwOLtYmCZ9qaiBkgo5S5QD145FnN
    hck75abvX3DQ6qE4BHjk9YKh/hmnXht1n41ZwoDcFnSlRwuNyrs9oaSxt/7KC1ecey89
    e1T+gdxljTsuHk/zYhQIBoCQXV+7j+ueZP5yeOphmROdhp1hvOlNrTRJrqmF6FkBYquJ
    8qwKhLevYzjY16ezHHtUPgq+x58hYYsj3VOPFcMeYmkXf07X1L3jmGte2bD/BOXJCeYy
    IX0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1786718703;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=EsqOj8Ow7/SXlnyAiIvTkIIyt5WvYytlt6ZVXM/E3R4=;
    b=DmgzzMn+dcd5BBdTfcQX24zm4Aj1Fw2P74Yu3QNyhR5z0kdurv3Pcnn3ZRaaV+pITd
    sVgHI4kLkozoBcYLZVAA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K171b727EEj33aj
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 14 Aug 2026 16:45:03 +0200 (CEST)
Message-ID: <23268b84-a1c5-4551-91ba-0a596cff21a1@hartkopp.net>
Date: Fri, 14 Aug 2026 16:45:02 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] team: reject CAN and IEEE 802.15.4 devices in
 team_port_add
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
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <4d056e9f.8019.19fadc9deb5.Coremail.19888972804@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

+CC: linux-can ML

On 29.07.26 14:11, jiale yao wrote:
> How about adding a helper in include/linux/if_arp.h, similar to dev_is_mac_header_xmit()? Perhaps
> something like dev_is_can_or_ieee802154()?
> 

Good idea.

But I would rather suggest some

static inline bool netdev_has_ml_priv(struct net_device *dev)

in

include/linux/netdevice.h

next to

netdev_set_ml_priv() / netdev_get_ml_priv()

Currently only the CAN subsystem properly handles the dev->ml_priv_type 
to make sure the correct "user" of the ml_priv pointer:

/* Specifies the type of the struct net_device::ml_priv pointer */
enum netdev_ml_priv_type {
	ML_PRIV_NONE,
	ML_PRIV_CAN,
}

There are some other ethernet adapters of dev->ml_priv beyond 
ARPHRD_IEEE802154, and ARPHRD_IEEE802154_MONITOR. Not sure if those 
adapters need to be fixed.

But to be sure we don't run into problems with bonding or teaming we 
should probably simply check for (dev->ml_priv != NULL) to reject them.
No matter which netdev_ml_priv_type is set.

static inline bool netdev_has_ml_priv(struct net_device *dev) {

	return (dev->ml_priv != NULL);
}

Would you like to provide a patch introducing this helper and directly 
use it for bonding/team (with some updated comments, as the problem is 
not related to CAN and IEEE 802.15.4 devices but to the use of ml_priv)?

Best regards,
Oliver


> 
> At 2026-07-29 17:15:06, "Jiri Pirko" <jiri@resnulli.us> wrote:
>> Tue, Jul 28, 2026 at 05:12:40PM +0200, yaojiale02@163.com wrote:
>>> Enslaving a CAN or IEEE 802.15.4 device (e.g. vxcan, wpan0) to a
>>> team master triggers a NULL pointer dereference because these
>>> device types use different Layer 2 architectures from Ethernet and
>>> the team driver never initializes their private mid-layer data
>>> structures.
>>>
>>> Reject ARPHRD_CAN, ARPHRD_IEEE802154, and ARPHRD_IEEE802154_MONITOR
>>> devices in team_port_add(), mirroring the existing CAN check already
>>> present in the bonding driver since commit 8ba68464e478 ("bonding:
>>> refuse to enslave CAN devices").
>>
>> Can we perhaps have a unified helper for the check?
>>
>>
>>>
>>> Link: https://lore.kernel.org/all/b58d98e0-8fe3-4e4e-b8a5-c1c7e647ccca@hartkopp.net/
>>> Fixes: 1d76efe1577b ("team: add support for non-ethernet devices")
>>> Assisted-by: Claude:deepseek-v4-pro
>>
>> Looks your ai gone a bit wild here...
>>
>>
>>> Signed-off-by: Jiale Yao <yaojiale02@163.com>
>>> ---
>>> V1 -> V2: Extended check to also reject ARPHRD_IEEE802154 and
>>>   ARPHRD_IEEE802154_MONITOR devices per review feedback
>>> ---
>>> drivers/net/team/team_core.c | 11 +++++++++++
>>> 1 file changed, 11 insertions(+)
>>>
>>> diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
>>> index feaa75fbf8fc..d8c46105fc8b 100644
>>> --- a/drivers/net/team/team_core.c
>>> +++ b/drivers/net/team/team_core.c
>>> @@ -1224,6 +1224,17 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
>>> 		return -EINVAL;
>>> 	}
>>>
>>> +		if (port_dev->type == ARPHRD_CAN ||
>>> +		    port_dev->type == ARPHRD_IEEE802154 ||
>>> +		    port_dev->type == ARPHRD_IEEE802154_MONITOR) {
>>> +			NL_SET_ERR_MSG(extack,
>>> +				       "CAN and IEEE 802.15.4 devices can't be added as a team port");
>>> +			netdev_err(dev, "Device %s is CAN or IEEE 802.15.4. These device types can't be added as a team port\n",
>>> +				   portname);
>>> +			return -EINVAL;
>>> +		}
>>> +	}
>>> +
>>> 	if (netif_is_team_port(port_dev)) {
>>> 		NL_SET_ERR_MSG(extack, "Device is already a port of a team device");
>>> 		netdev_err(dev, "Device %s is already a port "
>>> -- 
>>> 2.34.1
>>>

