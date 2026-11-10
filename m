Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794299901;
	b=F8S9yuK1lDSSA2omfDdLhukykKaNN5U/dI5MKLfRd6+nOw6BhHh4T0REUr8tBllFv2z+
	 zO8yVrHGsyULDM1Y92/GCm+A/lbvDKMdbUNXSRlHr5hY8Ri8IN7Q15iVR6UHOJQjkXN+2
	 JXUdAyNPUvEunwmjloWOjUtfB1Te319Six2J0TXc50Cm6z1eDbd0vtvc+RX5JmtPlEGno
	 +CUGmCEeHeoJUwlrPc0L5lXJQJ7MLCcb3TPAFdk6zRubGXFCDkZs4KccUPcej8gYjfci1
	 G3ZYuXuY/TJHQqJaMKa4UAivqpegtcFORU1CS3IWm0+3kp3xgvBQ2rtxVsuWpnHl5kA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794299901;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=FtBVWp7IfTZa2B4qEChR/Tm/Wz6nqQjMtb4BDTNUelM=;
	b=neOZ/IjVn2eVE32pj2a2xqLwqS1lSLT/UjPlaBpsMRTzcRyGAIx6l8nTIW3BjzW4NbJB
	 5VdxrGkID7arCioXj0Ww/UvCwjzt+PZq36kWwn7qm0jTqX6FmG3uLL7Jurn6QB+huYwyW
	 PwJKVE4ZQjySuZptS9IKsqog9jAEWcKg7Za3OfOOqyc+sGiKHywg5Hj0b0BShRR9DG7+N
	 oRB3mysO5KHW5RfgGtxw3s3iXa3xwhzDJWH9mm1I2w8f+0R+m41fMxi9qH0XTK+RBU4Sl
	 d3goF+7JVvb9gfTGOKhvCXXqSDCcS/qOYD4GEB0Ry2mPy/RBzhSFlJxaoPm7x1OpXNA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=K4IRRMkv;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b="54K7wU/l";
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.54
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EB1606A325;
	Tue, 10 Nov 2026 08:38:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3EB1606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=K4IRRMkv;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=54K7wU/l
ARC-Seal: i=1; a=rsa-sha256; t=1794299897; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=rF/jZaXZooc4QGQIShzxRisw3MOImSFty7+jEvO+UZmbeOx10EPnxUj+zAdk+tkfkn
    RuZLe4odc9KWvUkWWljuwA5ScheCTEQS9oBnAy8zJlwD22EfKzAMphHurBfi7gza5dg1
    qBnm1eQj1riotr797kTfdg5Fo4br/AibRLNUqEV9+9uFs/oX7XJHIx0R4imeeRSyAi7X
    h5aE0WV/M4HLZwtiHVHw/FBiN5q2mPRESTXgZXZu5evCXnfSloqEgsposPMkT+P8F2fR
    APdfoMnXSyl/E7xcodRWIcSxugB9D9rLIXTvptCGEcYZmkCSRCd4atv5f2VfVmnnbv+G
    Wh5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794299897;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=FtBVWp7IfTZa2B4qEChR/Tm/Wz6nqQjMtb4BDTNUelM=;
    b=LIXehTy8A9Flf7MUNDMHUrrkinvZp2qyEXMhVF9fwkdm9fYXhsAL+eX+hmi1G+NkNU
    84cGHol3H7m4DxUy//vDXX4ZsWRCkspIv0YKAtE478rKURX7ot8xhoFMANKIoXwy+Xoa
    eWYk/J+HpyAaWcPx7ZeQEoef+xtS2kDGxMcLJeTO+an/EoJ49mqNHJPOvmf2wnc/A41B
    Uf0aPttzfn2WpWpFZCez9BT7rUinF0Up5SR9ZTNIBHZDrbqtgQ8+gGN+3OPzlz6kToJh
    owz3pyKijUjhsq84M2UNja3FFYqJawqWezlx3hAOKu2cqkXB/iA2NwiKhGuLR3YaeLNi
    kEPw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794299897;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=FtBVWp7IfTZa2B4qEChR/Tm/Wz6nqQjMtb4BDTNUelM=;
    b=K4IRRMkvAhUlDEPkpvyRxUubGSxh8MCK9EgcHoHdxbYgwjHVINGAtQPcuKRo6cp9v5
    FR//MKn07DnXhJK5EGfuGkuX9L1LEFJvzM+ULQYf/vsacKw9m08P9vNI6Y0aTohiptPL
    yF9HUr+RNFaTbbVzVFr2WmHUkuPuUo2UdIh3p4/Tlw7+y2caWmxSgUiPcuTZPt6xKcSK
    zr7LItn4LchH7CsRuBta1yZ+sQ2wyydmt1mhdjLi6EjK2ne+YoQ2LldhhEeWgkc+SQMi
    JEWXFXFO+KP8cg9kb0e1MsQMv+5PEOmUyWxoNX0GUY4o72gh+S0f1ZaTxs9DqkGLLQEG
    MEVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794299897;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=FtBVWp7IfTZa2B4qEChR/Tm/Wz6nqQjMtb4BDTNUelM=;
    b=54K7wU/lJDA6ifTMXpki02gy1gl818vDs9Cz/wdkoIGekNrpTkd0VjDX03m59Nc+kX
    lKj+zkSWJ4wiom6xMfAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AA8cHy5s
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 10 Nov 2026 09:38:17 +0100 (CET)
Message-ID: <c90c1c35-7f0a-4694-9d29-0a6448d9a327@hartkopp.net>
Date: Tue, 10 Nov 2026 09:38:16 +0100
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
Subject: Re: [PATCH] can: bcm: Account cyclic transmissions only on success
To: raoxu <raoxu@uniontech.com>
Cc: mkl@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <45A9B6D8611C63C9+20261110052315.253367-1-raoxu@uniontech.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <45A9B6D8611C63C9+20261110052315.253367-1-raoxu@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Xu Rao,

thanks for looking into this, but I don't think this change is the
right approach.

On 10.11.26 06:23, raoxu wrote:
> From: Xu Rao <raoxu@uniontech.com>
> 
> The CAN broadcast manager advances the cyclic frame index and decrements
> the initial-interval transmission count even when can_send() fails.
> For example, taking the CAN interface down makes can_send() return
> -ENETDOWN, but the timer still consumes the configured transmissions and
> can report TX_EXPIRED without sending a frame.

This is intended behaviour. The BCM cyclic transmission is designed as
a time-driven "fire and forget" mechanism: 'count' defines the number
of ival1 time slots before switching to ival2. It does not define the
number of successfully transmitted frames. The timer schedule must
not depend on the state of the CAN interface.

With your patch, if the interface is down (or the tx queue is full
with -ENOBUFS, e.g. no ACK or bus-off), the following happens:

- bcm_tx_set_expiry() still sees 'kt_ival1 && count' and re-arms the
   timer with ival1 forever. The op never switches to ival2 and
   TX_EXPIRED is never sent.

- For setups with ival2 == 0 ("send 'count' frames and stop") the
   hrtimer now never stops and keeps firing at ival1 until the op is
   deleted.

- When the interface comes back up, the remaining ival1 burst is sent
   with a delay that can be arbitrarily long. This defeats the purpose
   of the initial ival1 phase, which is usually a short burst right
   after a content change.

- In the ival2 phase, currframe no longer advances on errors. A
   multiplex sequence then gets stuck repeating the same frame while
   the tx queue is full. Losing one frame and continuing with the next
   mux index in the next time slot is the expected behaviour of a
   time-triggered sender.

> Only update cyclic bookkeeping after can_send() succeeds. This matches
> the existing successful-send accounting of frames_abs while preserving
> the concurrent TX_RESET_MULTI_IDX check.

frames_abs is a statistic that counts what was actually sent.
currframe and count are control data for the transmission schedule.
They intentionally follow different rules.

The cyclic path has no way to report can_send() errors back to the
user. Simply following the timing schedule, the same way a sender
without bus access would, is the consistent behaviour here.

If an application needs "N successfully sent frames", it should
monitor the interface state (e.g. via rtnetlink) in user space and
re-issue TX_SETUP with SETTIMER|STARTTIMER after the interface is up
again.

Therefore I would prefer to keep the current behaviour. So NAK from my 
side for this patch.

If the current semantics are not clear enough from the documentation,
I would be happy to take a patch for
Documentation/networking/can.rst that states explicitly that 'count'
refers to ival1 timer events and not to successful transmissions.

Best regards,
Oliver

> 
> Signed-off-by: Xu Rao <raoxu@uniontech.com>
> ---
>   net/can/bcm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 7bd2aa39777a..cd66b23bf95c 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -375,7 +375,7 @@ static void bcm_can_tx(struct bcm_op *op, struct canfd_frame *cf)
>   	 * we were sending - a concurrent TX_RESET_MULTI_IDX means this
>   	 * frame's bookkeeping belongs to a sequence that no longer exists
>   	 */
> -	if (!cyclic || op->currframe == idx) {
> +	if (!err && (!cyclic || op->currframe == idx)) {
>   		op->currframe++;
> 
>   		/* reached last frame? */
> --
> 2.50.1
> 

