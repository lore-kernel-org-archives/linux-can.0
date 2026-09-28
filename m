Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF38377AB3;
	Mon, 28 Sep 2026 18:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790619162; cv=pass; b=iHpSGXpqpU3N3Qe000UdlE4xtQYlAala3nQ2KiPhYhEQ1+S028o97AQKhv3D5dfl3eD28mTR4Hi2oz8aSr2lYr3LbHq0Y4cQqUQVTa0KDMYk+j8BO23msHA/wFx2fjRdSk+PbvPfc1dhR8qVl4SBPCztAB01ca2qPrhJGGxvOls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790619162; c=relaxed/simple;
	bh=xzss5aWqp9DrMdVNFvTUeyfpbbbhNkewJdgu7hkOytg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ueOH9s0KJyXBJ11UrMeo1HKB6oD15pBI+vQBtrVph4Po1104Waq7ygq81u6I1A7OpX5jqgyAnCImUU+fsHj7bt++frCLSkFg0dzHN/E9pZNaRfDUIn6wxJ1+5XWgW9PkEELvLCye12W8BkQLZSGTWigy/APQckkq6bUW5emxAGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Nk+zpTVO; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=bzbbevE4; arc=pass smtp.client-ip=81.169.146.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Nk+zpTVO";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="bzbbevE4"
ARC-Seal: i=1; a=rsa-sha256; t=1790617711; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kSmeEdmdnxIcj/Ml9FGDXIwVfoAS3n1pUD/DbqyfSUYXsnhD4lxtuE46CmxwFt0I08
    qTMB4tJ0PEm0+YRels12gScLih7rZJrArUhJFuGWODio48EjomQduPOJC8ta+X5kv98P
    Lxj8Zizix/UPztJ1AWqNeGd4gQG1fqqUr9i4jCFYYr5WE+SE/8FaNwZ/QTUS3yFt4wOb
    9Qzwdba9N0ypBUeD7f71vK139gOzvjh9pbS1y0RmRDcSj+AFLf89w5omwfkXpwwUdcFm
    QVRVuBBaS+fd29dondvPbIrtuvSP4jmZKiQXKWQ611pxS00Tb+iEL86Rp3Zw6zU/YZnq
    GlKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1790617711;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ctr7Fl5PXofQpgNDSgqzb4LqqsTg3MiV8kqYT/rCfaM=;
    b=WzWxeajjzt7PE9rEkgmVwRcEeyauJ2co6Mm9fliNOJ01h2I4TC28XMZOLGWuSNODMH
    NMx2rhLopuwGoTsbpCoJnoAckUW9kljCX1o6q1wxGQzy5jtUo5sWSqSZv1SzIc86iTRT
    9dYSAaUevUj3TIjVD6jzpwRDuFnD06ZIFg2ei1jpqXLVRg+ZsKAnX2wZHrKOkmm8TRAN
    7LFRqdr7Eiy4qtaWhBpjKWfBTVv6+XHvXMvfkE0qzaW5PmFIOqHwvr01NGjrUTF+dBXo
    bPtBqBBK/rgBbn1l/d2VcYH+EHcJT8NJ5WfVmdXXHkrmQhfFaaLHd9APerarvWsoB+VP
    aGEg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1790617711;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ctr7Fl5PXofQpgNDSgqzb4LqqsTg3MiV8kqYT/rCfaM=;
    b=Nk+zpTVOjlOeBcaiMgt6Idd16aAaTElSRFcZ3DcFl9oYEGIWRI3K6WuKrMvcGQ5R/L
    FfCNLYUMHkVt14zShyyX89CCAwr4mf6PSClrhiHgzCIuddkTg3wX+LnfcDBryJJ3CbGK
    gbOrvloPeXf8dl5jc8GJ218zBbdEnGVlHim9l6FAeP6CibyXIlK4rtQITR2LNyvyOT2X
    E2ORwKQFeqrxSOVYEnqC3gBjVI2bSvfCmBo66GU1OFgv1Ne79G14ehyKoReAZ9b6/tf4
    POFhWvZqAW7soADE8ZmqRZhzU6jU8ZiJ6SR8qu8GKY8OzxFZwC1fqqnjtIgLNin0tar2
    q1kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1790617711;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ctr7Fl5PXofQpgNDSgqzb4LqqsTg3MiV8kqYT/rCfaM=;
    b=bzbbevE41YCGzzC70XHE+r3Vz0UAfWMP2R/hjnjIdZep/PbIGj60mInX/LRDnT7qb8
    e5O8SuG4GYMgmr5U1IAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K04b9a28SHmVOnA
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 28 Sep 2026 19:48:31 +0200 (CEST)
Message-ID: <4a398197-402e-438b-88ca-2c53733da2be@hartkopp.net>
Date: Mon, 28 Sep 2026 19:48:31 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] can: RX frames silently dropped in raw_rcv() with RPS
 enabled since d4fb6514ff8e
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: =?UTF-8?Q?J=C3=B6rg_Willmann?= <joe@clnt.de>, linux-can@vger.kernel.org
Cc: mkl@pengutronix.de, netdev@vger.kernel.org
References: <VI1P18901MB0640EC60F0E40E18EED92A0AAA8D2@VI1P18901MB0640.EURP189.PROD.OUTLOOK.COM>
 <2859AD3D-C805-41A0-9036-C5E8EE152419@clnt.de>
 <9216a55d-957d-4f7c-b67a-6093a1917faf@hartkopp.net>
Content-Language: en-US
In-Reply-To: <9216a55d-957d-4f7c-b67a-6093a1917faf@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jörg!

I've sent out a v2 patch set where the third patch addresses your 
reported RPS related bug.

https://patchwork.kernel.org/series/1175458/

The third patch needs patch 2 as both are changing code in can*_rcv.

Can you please test the patch set in your setup?

Many thanks,
Oliver

On 28.09.26 14:16, Oliver Hartkopp wrote:
> Hi Joerg,
> 
> many thanks for the report!
> 
> On 28.09.26 13:55, Jörg Willmann wrote:
> 
>> since commit d4fb6514ff8e ("can: use skb hash instead of private
>>   variable in headroom") we are losing received CAN frames on raw sockets
>>   when RPS is enabled on the CAN interface. The problem also shows up in
>>   the stable backports (seen on [6.12.109]).
>>
>>   Setup:
>>   - Kernel: 6.12.109
>>   - Platform: OpenWrt 25.12.5, 4 CPU cores
>>   - CAN controller / driver: mcp251xfd
>>   - OpenWrt enables packet steering (RPS) by default on multi-core
>>   systems, so rps_cpus is non-zero on can0
>>
>>   Symptom:
>>   The application on a CAN_RAW socket misses frames. /proc/net/can/stats
>>   counts more RX frames than the application receives. With
>>
>>   echo 0 > /sys/class/net/can0/queues/rx-0/rps_cpus
>>
>>   the losses disappear completely. [Optional: rate/amount of loss, number
>>   of filters on the socket, whether join_filters is used.]
>>
>>   Analysis (as far as I understand it):
>>   1. RX skbs from the driver start with skb->hash == 0.
>>   2. With RPS enabled, get_rps_cpu() calls skb_get_hash() in the
>>   netif_rx() path before can_rcv() is reached. The flow dissector
>>   finds no L3/L4 headers in CAN skbs, so every CAN frame gets the
>>   same non-zero hash with sw_hash = 1.
> 
> Ouch! I wasn't aware of this.
> 
>>   3. can_set_skb_uid() only assigns a new counter value while
>>   skb->hash is 0, so the RPS hash is kept and the frame gets no
>>   unique identifier.
> 
> Correct! That's bad and not intended here.
> 
>>   4. raw_rcv() treats a frame as a duplicate when both the skb pointer
>>   and skb->hash match the per-CPU uniq entry. Since the slab
>>   allocator often returns the same address for the next skb, a new
>>   frame with the same (constant) hash is dropped as a duplicate.
> 
> Right!
> 
>>   Before d4fb6514ff8e this could not happen because the unique id was
>>   kept in can_skb_priv::skbcnt, independent of skb->hash.
> 
> Yes. We won't get can_skb_priv::skbcnt back but I will take a look at it.
> 
> Best regards,
> Oliver
> 
> 

