Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD83480346;
	Thu,  3 Sep 2026 10:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.161
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788430352; cv=pass; b=dRhtI4DWEOdLdfKmemMrF8DDOydHyOWnWUHHR8spCCyG874Am8tM/+BfDS/3in4/zapsqzmzumr9o8Aaj7JcbbpdKZt6Ond2bSrS6Yr6DQieYzYCJFOC2a7Rl9CF3qWBUp/jMdXx8uD+w3EUKfOW8jz3+zIun3DN8batT1cB/kM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788430352; c=relaxed/simple;
	bh=mwTFjoIgf8sqFt9apBZc0tzxCLwrRddrq6K4Jpc1m4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JJf68CK0e10Gv+pOAV2exLCyD4pdtjXteFYB++lCsF+MvLATElwM+lZz50fMVp6XOSnAdztRqtj5UjhEwEMToFFZJ0H7ZpRx/eBgvcSJmGErTwsr9U5EsDQN/D0B0xaXS3bqq6pFi7E0za3xR96/JWs0gs7L6k+hss1odRrmS+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=HhGvRRmu; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=cA+JpdCA; arc=pass smtp.client-ip=81.169.146.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="HhGvRRmu";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="cA+JpdCA"
ARC-Seal: i=1; a=rsa-sha256; t=1788430151; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ODk/QYCQt2YUy7HihRFPOSXMl7mFu7yVFcWOPo0wgsvbr5OjMOXsGRfRIKfOVxiLa7
    DJeE0BFKJCcGuoU9V1r8vYfaJEaa2hIK5zDGUaZNRgSBIIuzzPKeQXSCA7VZxJZq1vZY
    CucogDLaDK4S1KjXLFLvnM4y5a8qx1W/23fDkYlKeEYG06Q7nAK11QpxCxlZvIruDtGo
    UHyhLiaj3s74nCmN8A7Rr7QlRix5IpO2wSbt5MFKUMD+/G5U1VqcnHcbT3Zv0qnzhne6
    m2c+9wu+eekSKGC5JAaNyWAODP5l3jaOQ1mz0ILbCuPIT4LicnsaHuCnRVqTa1rWqi1u
    BFCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1788430151;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=lhRWoZDMoaf8nnUg/Y8/ei90nF7avPayq8dOMIGkEC8=;
    b=dFPGbHn2ifNFPNM1NEr6H8zzTBKTRZJ4ukm1AmnEXyO2wS1RagT8mX/x/v2B7OP4Ut
    dD0Ta2xu2VPknJDBRhqODWsOm5A0JDuskyK6Ny/BinxvyrtkEaCr6G/CtyCzm4eN1M5F
    auPqL3g1uRQe5iMVFv+bPVwOYSPfqKY3xjMbaIpKQMiu5wA+aIwoUfHKGxtK0MyP3Oen
    WaXMbzhPSdx02LHaGxTafpAsSfZUedJXDB+jBSPadtUIMYjwoY8Sxh3L4LQYNM2SwgWK
    mgTfWOS18iOPNiqyL1kBiqsosVwNcX0zNm2HBak73aC+KWVJiBYWt4YMEi5/2FFyVIvX
    Rvpw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1788430151;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=lhRWoZDMoaf8nnUg/Y8/ei90nF7avPayq8dOMIGkEC8=;
    b=HhGvRRmuTxd1f/K3prQwQQfBdkqMz/vvoomfdzNbICSMU21b/tyVxQAIIefw7AwzRa
    XnkkqcVHVsTFZAC/WcDaqNyGNDmW7RXaxVDWQmtLS12n//5LciJV6C+bJPLTFrtoCR2E
    UNBlfIHVALpD7yJqIAiRtAFDxvQk4vZNlnkHuaKwwYtvqVfRKEMUF529V6VXskk6x4jc
    4vJ0P8ptxvURpXFSWTsHdHk36hlNd5WVH5mQF9kfZrlBs6zGZvOtnpgARG+wSyrIy4fl
    nDj4Z8817kie+abvNoAuYK5NbE+FNe9l5zCH6GGIbEdix4UfmTQCO9SDIkAvsmQRU4c+
    s/hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1788430151;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=lhRWoZDMoaf8nnUg/Y8/ei90nF7avPayq8dOMIGkEC8=;
    b=cA+JpdCALIJ2uL9CXetKN5yq8V2kynfoQEVPxkpR4kCraOJbtAtYj5puqRWVwniDnT
    99l24GaSaGS15Puk1VAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K171b7283A9BVZX
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 3 Sep 2026 12:09:11 +0200 (CEST)
Message-ID: <6ca3c6f6-91c4-4f0b-9136-9345dbaac1e0@hartkopp.net>
Date: Thu, 3 Sep 2026 12:09:06 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: isotp: implement N_Ar timeout handling for FC
 transmission
To: yewentian395 <yewentian395@gmail.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <eb5e9618-3dbf-42cb-a635-752ff9fbcb99@hartkopp.net>
 <20260903093809.1894919-1-yewentian395@gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260903093809.1894919-1-yewentian395@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Wentian,

On 03.09.26 11:38, yewentian395 wrote:

> Just a gentle ping on the frame_txtime addition to rxtimer you
> mentioned. Happy to help with a patch if that saves you time.

This is my current patch which is sitting on my dev machine:

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 130a0dbec78c..5119afc2f67d 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -125,10 +125,11 @@ MODULE_PARM_DESC(max_pdu_size, "maximum isotp pdu 
size (default "
  #define ISOTP_FC_WT 1		/* wait */
  #define ISOTP_FC_OVFLW 2	/* overflow */

  #define ISOTP_FC_TIMEOUT 1	/* 1 sec */
  #define ISOTP_ECHO_TIMEOUT 2	/* 2 secs */
+#define ISOTP_MAX_FRAME_TXTIME_NS (100 * NSEC_PER_MSEC) /* max N_Ar/N_As */

  /* so->tx_result[so->tx_gen % ISOTP_TX_RESULT_SLOTS] holds the packed 
value
   * (err << ISOTP_TX_RESULT_GEN_BITS | gen) for each tx generation 
slot, so it
   * can be handled with a single READ_ONCE()/WRITE_ONCE() access.
   */
@@ -346,11 +347,12 @@ static int isotp_send_fc(struct sock *sk, int ae, 
u8 flowstatus)

  	/* reset last CF frame rx timestamp for rx stmin enforcement */
  	so->lastrxcf_tstamp = ktime_set(0, 0);

  	/* start rx timeout watchdog */
-	hrtimer_start(&so->rxtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
+	hrtimer_start(&so->rxtimer,
+		      ktime_set(ISOTP_FC_TIMEOUT, so->frame_txtime),
  		      HRTIMER_MODE_REL_SOFT);
  	return 0;
  }

  static void isotp_rcv_skb(struct sk_buff *skb, struct sock *sk)
@@ -1304,11 +1306,11 @@ static int isotp_sendmsg(struct socket *sock, 
struct msghdr *msg, size_t size)
  		wake_up_interruptible(&so->wait);
  		return -EADDRNOTAVAIL;
  	}
  	/* WAIT_FIRST_FC for standard FF, else stays ISOTP_SENDING */
  	WRITE_ONCE(so->tx.state, new_state);
-	hrtimer_start(tx_hrt, ktime_set(hrtimer_sec, 0),
+	hrtimer_start(tx_hrt, ktime_set(hrtimer_sec, so->frame_txtime),
  		      HRTIMER_MODE_REL_SOFT);
  	spin_unlock_bh(&so->rx_lock);

  	/* send the first or only CAN frame */
  	cf->flags = so->ll.tx_flags;
@@ -1711,10 +1713,12 @@ static int isotp_setsockopt_locked(struct socket 
*sock, int level, int optname,

  		/* check for frame_txtime changes (0 => no changes) */
  		if (so->opt.frame_txtime) {
  			if (so->opt.frame_txtime == CAN_ISOTP_FRAME_TXTIME_ZERO)
  				so->frame_txtime = 0;
+			else if (so->opt.frame_txtime > ISOTP_MAX_FRAME_TXTIME_NS)
+				return -EINVAL;
  			else
  				so->frame_txtime = so->opt.frame_txtime;
  		}
  		break;


But this patch will be part of a big chunk of patches to introduce the 
CAN XL support for ISO 15765-2 Ed.5 here:

https://github.com/hartkopp/canxl-isotp

And the latest patch set is here:
https://github.com/hartkopp/xl-isotp/tree/claude/can-isotp-patches-rebase-v3

There are currently stable fixes on the fly that always have impacts on 
the isotp code. An it is really annoying to rebase and rebase and 
rebase. Especially the code split(!) into different .c and .h files 
always has to be checked by hand. Therefore I'll wait for all the 
current stable patches to be landed in mainline and stable and then add 
this patch here to the series of cleanup and enhancement patches.

Best regards,
Oliver

