Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA82341B8D5
	for <linux-can@vger.kernel.org>; Thu,  6 Aug 2026 15:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786029364; cv=pass; b=eHQM1f34sksUSZ0k6sL9AFapr8o3r37mRusacEDRQ4sJunezrG64yF9vTHQq/nrWgg89QgGUsMSp3k4OAA6ODP372cWjRkwghOrxDZDAOMYYE48g1AUAIeGaAGdvU717+jwt0oH6Vcg+EhhU6qNrZuAGKD0Io2rK5hD8C9YDb5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786029364; c=relaxed/simple;
	bh=Zy1eOSJNc5zllNCY1ethRIjKCgVLQKpzZ/QOA+3PPEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HGlRWJGgmMN6sIhJh6/zbGZPdqChJuqwRuqZDgcGx+VFASGcJHistygaedD1a52SWl3I2b9e6t5p3ogmigrSPZaA5VLsBjt01eIo39mq9NxGAPI0DavAHhEhviiqWdK+Su5WihQ1cpij9Yntpw/PrSImp1KcsNBp6juG3VmhS4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ht1/B+SK; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=vdGYlWE9; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ht1/B+SK";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="vdGYlWE9"
ARC-Seal: i=1; a=rsa-sha256; t=1786029357; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Q4ttwxUW0TkRoO3WwaNWazCfQzMbEmZt0e4eFWdUHo3dgBITTyiRO6s3Hckx9L5Ra8
    V0E0A499YbvtFybbDP84h0KaQVXqL0bFXK4ylCTN3lID1rMheU7PKpI1Ubb4Xk4lKJMh
    Q09mg9XZK86/OkLv8L9Zc8waQV0FnxydURHYqRokFw02up4YjdVcGw5qnEjV7nvcBSYT
    nHTeNJmkrBota1fA31NwWQofPx0kkacF5rh5Q35ZqeooMkcXeg0dwXQDAqQKmDSW2yF5
    Z74kqQawH8WTrWF+L6GYgWI9SMvkNEm2BK69uVyIPpPsRTcdfvfIEKflyPMUtfOrEgft
    LqEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1786029357;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ED0Su14fqB7C6rmTrqW2lwiqn4X/2JTVsuJBYEa6UhQ=;
    b=Z8l7i+w43C7GI7Ulc2/10gsyk8YUKCSOWqoSxJhdQGJWZeZswGd3TPe6X6KVzecbcj
    rEh8+4KgCxRAhP3wopnB/vvbDr6OkrdtHhp2gJeEFfyeEMvZzF7FSfeXC9L4QMdty/EI
    hMfcwBjmJHnFr0s7wj3VwsmDGy7I9oKu2tXu3PsaxL9ZCVcCEizOQzoqIO7LtHN2x5pQ
    ifycRNBecPfqu16aEAi00pF2eZlzwKLSGt7XbJZjjSpECoTwCKfDb7JYb5B0A2tegxfn
    63Osr1dgvAwg7ndNKFjQhS9Zyl0igePW3ruxYFgm89xaPHyZGWZ79zNpZhtWv9WCltl8
    BwNw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1786029357;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ED0Su14fqB7C6rmTrqW2lwiqn4X/2JTVsuJBYEa6UhQ=;
    b=ht1/B+SKWfrdBDRqDuiHUFEuV/8SKL5kvwwEAxrx0m6Z8faqOtL6m1Z4HNI5iZgSow
    IV18IB62NjRZplGygRRlkkL3g9QagvmSg4B8tQA3QoWcL1gXfWZ3uag29XTMtA2YpJKi
    bv84DwaG9DJam2+spYNqC1UqkVvDKqbbnT4CpFXf1D1NzU26Dv4gNFRAuWlKGV3cSv9a
    qcIbu2BrUWt4/4ZlTIx3G83IdjWQt2Ip4rJ1C6WxLiXvjksEpA9RpkeERYTrQRRYEbIj
    ZhaeOEWziAWjUjCQ5YYkHc9qEpEqaVOOpoGb/u92/oQ5xDoFjIQTGDPZ8R0g5M1WoEAG
    O6ZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1786029357;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ED0Su14fqB7C6rmTrqW2lwiqn4X/2JTVsuJBYEa6UhQ=;
    b=vdGYlWE9SUjEmmwolpmMbFHrK0U2wb6jssh/lw0km8+CdeXkGaZms4j+z1rcVjTFjL
    Q17NYppR+sAfNmp5VaCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.231]
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id K52819276FFuBe4
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 6 Aug 2026 17:15:56 +0200 (CEST)
Message-ID: <f89084c5-b98d-442c-8f70-59f07e3b926c@hartkopp.net>
Date: Thu, 6 Aug 2026 17:15:51 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH can-next v2 2/3] af_can: store socket pointers in struct
 netns_can
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Filippo Storniolo <fstornio@redhat.com>
Cc: Robin van der Gracht <robin@protonic.nl>,
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
 Urs Thuermann <urs.thuermann@volkswagen.de>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-can@vger.kernel.org
References: <20260806-feat-can-diag-v2-0-832597ee4cb9@redhat.com>
 <20260806-feat-can-diag-v2-2-832597ee4cb9@redhat.com>
 <20260806-eminent-shark-of-patience-1f612d-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260806-eminent-shark-of-patience-1f612d-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 06.08.26 16:16, Marc Kleine-Budde wrote:
> On 06.08.2026 15:14:14, Filippo Storniolo wrote:
>> AF_CAN sockets need to be stored in the netns_can structure
>> in order to be retrieved by the CAN diagnostic module when
>> a netlink request message is issued by the userspace.
>>
>> On socket creation (`can_create()`), add the pointer to the
>> new socket to `netns_can::sk_list`. During socket release
>> (`isotp_release()`, `raw_release()`, `j1939_release()`,
>> `bcm_release()`), remove the corresponding pointer from
>> this list.
>>
>> Since this is a prerequisite of the CAN diagnostic module,
>> deletes and insert operations are conditioned by
>> IS_ENABLED(CONFIG_CAN_DIAG).
>>
>> Signed-off-by: Filippo Storniolo <fstornio@redhat.com>
>> ---
>>   include/linux/can/core.h | 11 +++++++++++
>>   include/net/netns/can.h  |  6 ++++++
>>   net/can/af_can.c         | 50 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   net/can/bcm.c            |  2 ++
>>   net/can/isotp.c          |  2 ++
>>   net/can/j1939/socket.c   |  2 ++
>>   net/can/raw.c            |  2 ++
>>   7 files changed, 75 insertions(+)
>>
>> diff --git a/include/linux/can/core.h b/include/linux/can/core.h
>> index 3287232e3cad..5132f5c89b7c 100644
>> --- a/include/linux/can/core.h
>> +++ b/include/linux/can/core.h
>> @@ -61,4 +61,15 @@ extern int can_send(struct sk_buff *skb, int loop);
>>   void can_set_skb_uid(struct sk_buff *skb);
>>   void can_sock_destruct(struct sock *sk);
>>
>> +/* function prototypes for the CAN diag module */
>> +#if IS_ENABLED(CONFIG_CAN_DIAG)
>> +void lock_can_diag_mutex(struct net *net);
>> +void unlock_can_diag_mutex(struct net *net);
>> +void can_add_sock_sklist(struct sock *sk);
>> +void can_remove_sock_sklist(struct sock *sk);
>> +#else
>> +#define can_add_sock_sklist(sk)
>> +#define can_remove_sock_sklist(sk)
> 
> Please add static inline functions for these.

AFAIK "inline" is not wanted anymore and checkpatch complains about it.

Best regards,
Oliver

> 
>> +#endif
>> +
>>   #endif /* !_CAN_CORE_H */
>> diff --git a/include/net/netns/can.h b/include/net/netns/can.h
>> index 48b79f7e6236..bcafff5e6669 100644
>> --- a/include/net/netns/can.h
>> +++ b/include/net/netns/can.h
>> @@ -36,6 +36,12 @@ struct netns_can {
>>
>>   	/* CAN GW per-net gateway jobs */
>>   	struct hlist_head cgw_list;
>> +
>> +#if IS_ENABLED(CONFIG_CAN_DIAG)
>> +	/* CAN diag support */
>> +	struct mutex		sklist_lock;
>> +	struct hlist_head	sklist;
> 
> nitpick:
> Please indent with only 1 space as in the rest of this struct.
> 
> regards,
> Marc
> 
> --
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung Nürnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

