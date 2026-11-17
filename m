Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.160
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794941910;
	b=uMoLD93Sznuvq3vyf4MOxuMZWXbWqWtHDCTcz5BuJVTzpD8bX0mAi5P20gYSOaPn8SBM
	 EeXqlhrPZgighzPyTnXEoHEVhgAcx35LspUkKNYpTT8VeBeLeWdHd/vjg3TG6R4+jviop
	 aZaV8pABz2/sX8dEaAAu0Y3sFOJ2UenMVHArUlKdTIjQ/Q6SDxyQ+Dhdzs8PHGupVwAiR
	 1F88mg1fAcBwbcZGBxglovrQtZ/BJSbxbvqPKphkElEbruZqaxxBm9+CLBzhLVFt+SXZg
	 6dTbCjWsl7qAObnQ/jNf1AtMUf7FqZmE8tq72rCXdoIPnTZYUXPTj87ljR3rKZK6Tlg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941910;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=abeeiL8Dbe80hP0nuwbVTQJC0NDs8w3aH4HoUGnX56c=;
	b=YJpLnEe91MCe1X6vCt+eN3/5vmdw/95TJ/0zT/TUG3FP3/Bpmbhi/rOz8kAfYsIvvFon
	 uY8uwTjUxlHQlqJHw93ALoz0/JAT7/fMct3f98awmuLYUw4X61M9uD4m1ZOxHeJWnsQig
	 JMePaBv82acsVYpsbUuEiYlsMIaTSgfS5CriQCvev4AUuxOtoB+Kw+l2U3yoY3hY8J0r5
	 63eISrBkVeSzt5ZnR/2USTRd5TjTFC7qvN7zjNbaDlHu6D4OCR/c2snKdjB/JTg528m97
	 faOsRJIilGKqGjG38R7i6O8ZR/uO0LccKd18vE0Rrsf1LrR2kEe+aw3g0KJfkN6Lv4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=kZIbDAi7;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=9hVfWJym;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.160
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.160])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360D7606A32A
	for <linux-can@vger.kernel.org>; Tue, 17 Nov 2026 18:58:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 360D7606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=kZIbDAi7;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=9hVfWJym
ARC-Seal: i=1; a=rsa-sha256; t=1794941891; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=MOxCghFH8qbQ4Ggu3P2kBp+RlGP0b+ZKqvqyBJ7c4rWTsszDZa2JepTFIFxloqCgAG
    SALuqZNfPXta1QS88Mj9Q/mVI4XtqQM0jzhFBvKil0YQVdVfCKy8bUwB7CSeVbWAlXwo
    cxY1wfGv7CvrIVaFqHDWVyWBPj7jlgtf8ljvBXqrdURb71ji8TUrC3qpGbsbvK9t8qzN
    DQ+FQ4j+nNIuMp1iCUU/38Xs1jMZc5E7WyXk72R9CkqLJfP+HH0x2yHjyWMzCmCExCnj
    USogbxZjDyT9zIjPdq4+OUYW1bail3JES03oaIztvjHp7zXZWLiVjfadfJ25xqKPoLYp
    sbvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794941891;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=abeeiL8Dbe80hP0nuwbVTQJC0NDs8w3aH4HoUGnX56c=;
    b=eqTyl4aniA2+m0fjvrW/hBtdvRQEflZ6N5L29rci3BImBNNxaABjOgbW5jarhieZb4
    aMNQIpm/LvkxRf7m4s3nC6Ifi809CvqGFLHVI/8oDorNsl8Qje3GLqn6RNe8Q/lK7/Rj
    KO5gfw3NoEgGqA3A+byS3pKOmM8cVym8nPSqHopDioJgpR7w4lQC+f2r261i6jLA8qIM
    ew919WKwl4WQO1flatD4zcwqmYeoA9t+OTvfjRI1B8nk/8yrx/fScswiDC3dUcIsrvL7
    1sGbsHLRn6s1B6AToHgRPfJaivnBISrPF8KC4MFygU0hAJdwc9oxtbRunjSjwb+vxCpn
    nfuQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794941891;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=abeeiL8Dbe80hP0nuwbVTQJC0NDs8w3aH4HoUGnX56c=;
    b=kZIbDAi7KZurJ3JBA6lBe4HXtG5AX8Aw7shWqcl64A8ptRsflouc0AgC+OCO7VGVRU
    NOvBPGGKf1nfpVUDJjao4zVI8AneRVZ3rDxHpcRPuZgNukYYCocSKnadJnw2sB6zqbpL
    tMmaVJHWScBovzuEKUkdXCE0kdLDS2av6P69bhjOFG5qfXdiMuWYlNEcucSAJ3FlBdQU
    5/HDMs778/ANLg6iC+11u3FOGnBHl4fCG1imcpqqgNacI3byuliVJjxRylQOQ9gff9BK
    J6aE8TlqWUNb3PBEa2EEt3mhn6m+8ldyD8n4W2DIXo4Nn7bCwCN5ogvl7AKYwrpVdcL+
    XQOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794941891;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=abeeiL8Dbe80hP0nuwbVTQJC0NDs8w3aH4HoUGnX56c=;
    b=9hVfWJymeNMf73BAouQcc9bPnylxWn2auOuVeotWD0gKRFvNegei10plaFpuM2w36y
    3BaGckiQ3WuYkWkP6CBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AHIwAqxa
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 17 Nov 2026 19:58:10 +0100 (CET)
Message-ID: <ae174988-93be-453b-a790-6f175f96ae1c@hartkopp.net>
Date: Tue, 17 Nov 2026 19:58:05 +0100
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
Subject: Re: [PATCH v6 7/8] can: isotp: reject socket options while a transfer
 is active
To: sashiko-reviews@lists.linux.dev, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>
References: <20261117-can-bcmlock-memcg-v6-0-6826a6227d36@hartkopp.net>
 <20261117-can-bcmlock-memcg-v6-7-6826a6227d36@hartkopp.net>
 <sashiko-outbox-219222@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <sashiko-outbox-219222@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17.11.26 18:17, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] can: isotp: race in isotp_setsockopt_locked() while rx.state
>    is ISOTP_IDLE
> --
> 
> commit 2bbcd6c26df0af71086da24b238251d946bf05f7
> Author: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> can: isotp: reject socket options while a transfer is active
> 
> This commit rejects changing CAN_ISOTP socket options in
> isotp_setsockopt_locked() when so->tx.state or so->rx.state is not
> ISOTP_IDLE.
> 
>> diff --git a/net/can/isotp.c b/net/can/isotp.c
>> index 0293d590186c4..32c88749d75e7 100644
>> --- a/net/can/isotp.c
>> +++ b/net/can/isotp.c
>> @@ -1725,6 +1725,14 @@ static int isotp_setsockopt_locked(struct socket *sock, int optname,
>>   	if (so->bound)
>>   		return -EISCONN;
>>   
>> +	/* A transmission or reception that outlived a previous binding
>> +	 * (unbound by NETDEV_UNREGISTER) may still be draining and uses the
>> +	 * socket options, see isotp_bind().
>> +	 */
>> +	if (READ_ONCE(so->tx.state) != ISOTP_IDLE ||
>> +	    READ_ONCE(so->rx.state) != ISOTP_IDLE)
>> +		return -EAGAIN;
> 
> [Severity: Medium]
> Can isotp_setsockopt_locked() still race with an in-flight isotp_rcv()
> handler while so->rx.state is ISOTP_IDLE?
> 
> isotp_notify() clears so->bound on NETDEV_UNREGISTER without waiting for
> an RCU grace period or acquiring so->rx_lock.  Meanwhile, isotp_rcv_ff()
> resets so->rx.state to ISOTP_IDLE before sending an overflow Flow Control
> frame or transitioning to ISOTP_WAIT_DATA, and isotp_rcv_cf() sets
> so->rx.state to ISOTP_IDLE before checking padding options.  Because
> isotp_setsockopt_locked() and isotp_bind() check so->rx.state without
> holding so->rx_lock, a concurrent setsockopt() can still modify so->ll.mtu
> between alloc_skb() and skb_put_zero() in isotp_send_fc():
> 
> CPU0 (<softirq>)                  CPU1
> isotp_rcv()
>    spin_lock(&so->rx_lock)
>    isotp_rcv_ff()
>      WRITE_ONCE(so->rx.state, ISOTP_IDLE)
>                                    isotp_notify(NETDEV_UNREGISTER)
>                                      so->bound = 0
>      isotp_send_fc(..., ISOTP_FC_OVFLW)
>        alloc_skb(so->ll.mtu, ...)
>        /* allocated with CAN_MTU (16) */
>                                    isotp_setsockopt_locked(CAN_ISOTP_LL_OPTS)
>                                      /* rx.state is ISOTP_IDLE */
>                                      so->ll.mtu = CANFD_MTU (72)
>                                    isotp_bind()
>                                      so->ifindex = ...
>        dev = dev_get_by_index(...)
>        skb_put_zero(nskb, so->ll.mtu)
>          <-- skb_over_panic (72 > 16)
Nope.

The normal sequence for a CAN_ISOTP socket is setsockopt() -> bind() ->
release(). Only an attacker would change the socket options while the
bound CAN device vanishes. The attacker needs CAP_NET_ADMIN for the CAN
device, e.g. a vcan device in an own user and network namespace.

What the attacker gets at most, for the four (in-flight) frame types:

- Single Frame: the PDU is delivered to the own socket or dropped with
   EBADMSG, depending on partly updated padding options.

- Consecutive Frame: only handled in ISOTP_WAIT_DATA state, where
   setsockopt() is rejected with -EAGAIN. No mixed socket options.

- Flow Control: only handled while a transmission waits for it, where
   setsockopt() is rejected with -EAGAIN. No mixed socket options.

- First Frame: the rx state goes to ISOTP_WAIT_DATA and the rx timeout
   resets it with ETIMEDOUT after one second. The flow control frame is
   not sent as so->ifindex is 0. Only with a concurrent bind() to another
   device a single flow control frame with partly updated options is sent
   on this device. With an increased max_pdu_size the rx buffer may be
   allocated, which is freed on close().

On unregistration the netdev core runs flush_all_backlogs() and
synchronize_net() before calling the NETDEV_UNREGISTER notifiers, so an
isotp_rcv() call can only be in flight for a frame from the backlog on a
namespace change. In the First Frame case the following sequence can
then happen:

CPU0 (softirq)                      CPU1 (attacker)
isotp_rcv()                         ip link set vcanX netns ...
   (frame from the backlog)            NETDEV_UNREGISTER
   spin_lock(&so->rx_lock)               isotp_notify()
   isotp_rcv_ff()                          so->bound = 0, so->ifindex = 0
     rx.state = ISOTP_IDLE           setsockopt(CAN_ISOTP_LL_OPTS)
                                       rx/tx state is ISOTP_IDLE
                                       so->ll is updated
                                     [optional] bind() to another device
                                       so->ifindex = new device
     isotp_send_fc()
       alloc_skb(old so->ll.mtu)
       dev_get_by_index(so->ifindex)
         ifindex 0: free skb, return
         new device: skb_put_zero(new so->ll.mtu)
                     send the FC frame

CAN_MTU is 16 bytes and CANFD_MTU is 72 bytes. The skb_put_zero() with a
bigger new MTU does not overflow the skb, as alloc_skb() does not limit
skb->end to the requested size: for the GFP flags used in
isotp_send_fc() small skb heads are taken from the skb_small_head_cache,
which provides at least MAX_TCP_HEADER bytes. MAX_TCP_HEADER is
L1_CACHE_ALIGN(128 + MAX_HEADER), which is at least 160 bytes in every
configuration. __finalize_skb_around() sets skb->end to the size that
has really been allocated, so a skb that has been allocated for CAN_MTU
also has room for CANFD_MTU.

There is no memory corruption, no persistent state and no effect on
other sockets or on RTNL. Everything stays on the attacker's own socket
and CAN device.

TL;DR The worst case is a single flow control frame on the newly bound
CAN device that is built with partly updated socket options. There is
no memory corruption and the rx timeout resets the rx state afterwards.
I do not see a reason to add more locking to the reception path for
this attacker-only scenario.

Best regards,
Oliver

