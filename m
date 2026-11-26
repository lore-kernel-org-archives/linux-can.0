Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.81
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795727160;
	b=ij4y1HftXoTGq7sugC6djN9TSto3V8Z4FkS+Ro9eNagGj17Q/veIBep8JEKZU/Odd/LS
	 vFjCjR5o/KtsdanRRRGdBB4HEKDR6WQ3vRaDYdU4Mui16WrHAs/f+aC4QEp6xwI7A+VQE
	 +lcRhaMle0Lp9Bd8fY9FNIlwXu8Kk3iaLuZx6tLxoMmol8ISh8lXS8lI8nWrS7NWzRFoJ
	 SrTCnXwTLp/Jci5yjwCdPpHDDxLGHLkSDDnvWxkCFxnID07hW1ETnCi5RPc75fQbUKQsC
	 epNgFZQ5uXuYMViz3ox1akOyXW8gTYoFdqlaMp+9ZNXt1IA/pUgyKSWTDolSUKsGpHw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795727160;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=GGpKiiJq65jDAXRHRVCtgEc6blUW92rMDqBlyMD10wE=;
	b=HkCtye3gk/bxSV16U65/9RGkWWGZnRXEovQ9KPbPUTSnKbM1ryjSNVCmhAMSD50hHTHG
	 YOYyUx/YM/YmVIZf0E7MwsG4T0F0s0oEDFnzNKaNHo2jOvGnV9zpUUQ+JLrX20DLBm/x5
	 n7LecGunW/SYwpXbotD7PfAMudUFb7N5TW1ZyvOxrEHxYB4yXWQHx/IqE5Rjr8slNo3Ys
	 dqwvF/9IS3b9FCNu5B/kr78hpDKhmOXJ967BKqqC6NzyXrfns2SBw2E1k68Wtef/YrYup
	 O00z2c/gcO2EZwEjwHtlgTPcrvDlhP5pL4y6Sg1/fAA/ZrMt6BALletLU748OMUwTSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=IFD7AsgP;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b="t+pQ6T/m";
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.81
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AF6606A321
	for <linux-can@vger.kernel.org>; Thu, 26 Nov 2026 21:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49AF6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=IFD7AsgP;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=t+pQ6T/m
ARC-Seal: i=1; a=rsa-sha256; t=1795727151; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=pzjg2monv5bdQPIiZwk+DMR1izSrj7s7P/xCa0Q8B+EqlIOjzajjKS1dF/CT4o3ia8
    6OFud/sNJ4nrlD766H1tisZy0LMuuVbsnwdGr+7S9JXw05VWOzKYrwztLkG3G9xWoG8g
    vtFFxVh6Wsc74ChtqD8DrDl6/wmCpcuwjy+C/xY5X11fyhMeYq6i311v8u432YSG771m
    dcl1pLPSb4c+Swihwiz9UBKpj4yYBmik9rmMqHjiOyV56VD67EIKLK0Knp4XMbiCQDFN
    +0FPkEELwCKiy/QvHGoQHNd7mxx/HBEYDBcragPWGUfmowFK0tdb26gO8OSJZjnGTHza
    Wvzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795727151;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=GGpKiiJq65jDAXRHRVCtgEc6blUW92rMDqBlyMD10wE=;
    b=ENR8cmnCBqLvPnxj0e7A5GtKyngn61ufQAJP4V6sGDRajLHukSLM7kmwS3LNsLHkv2
    uBAesS05zxSsIkzuGgnyp8oxsLCSEn7zrkHkFIZYqsAT1nK4z2eeNana1FR5OFBkg1US
    2x48+Ar1EpVEjXlljXJTrrfbzOYLLfDLiuFUEDbgGjoSyjgOMyYoJL+QHIDHFuOc6/B6
    T3qqaqa2NtOB/kSM+pOPoZyQM6b/dDUrvh2LnK+ZBscZS1CcMsjPF9Gc7nC8DJeQ18F1
    FoCxYSE3wykcBwDN12CvDmS9dkTTZW5jR/cmc+F4ActM5Au6LtpSV+jBdTnQV62EQSzj
    +bGQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795727151;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=GGpKiiJq65jDAXRHRVCtgEc6blUW92rMDqBlyMD10wE=;
    b=IFD7AsgPkOwHLUNko7g/4IOqfqGNCIDsr58BNlZxWiu4Je1XCGMPq71i9AwooR0Plg
    UtJQ92K52+q4em0xuNm32MEUeJnI9abcAZdcI/r1OJ397ylR7d/0OEGzeOaNSDxVW62c
    na2aENQH4UA5FxxVC3zgDAKCgPa1NLqhU8H/RVKsFTU84JUCl/lR3EdDejcK5HoGiAXy
    dvOhFdMW+1uIbRAC1UDx5cqPxNLvj1Im2OvX+hpPe6leCm4lDmfIHHH6vVO0M4uLn5Gc
    L8yi8HetiWjUcxMjW/dtYsmOvmCS6ODc8S8XsPlcv2WTRUof6dXCIKdtHW9ZVVQaMoQv
    Kfnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795727151;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=GGpKiiJq65jDAXRHRVCtgEc6blUW92rMDqBlyMD10wE=;
    b=t+pQ6T/mMF7FQUWaRMP45YXtRARtoevV2wu8OkwpaWvmVCL13szPGerr2C084/J6dj
    fcjKeeEKB+VmQFYQYNAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AQL5ptUc
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 26 Nov 2026 22:05:51 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Thu, 26 Nov 2026 22:05:48 +0100
Subject: [PATCH can-next 06/22] can: isotp: check the CAN FD tx_flags in
 CAN_ISOTP_LL_OPTS
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-getsockopt-memcg-isotp-v1-6-681ef8d8c2c9@hartkopp.net>
References: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
In-Reply-To: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795727150; l=1282;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=g3wyKwSpif5dJkrLL28kC4UgHAYK0zOCXjGCA7fxUJM=;
 b=vtfxCamstO6OMwygzGeQkWVX/wvGfAXNf+eNPliF5c99WsCjq77mgRu8PG/WMVYsG830Lkk4Q
 qVqKSrMrFX0AU3m+FARivkY1jfqm9CtDYwbICRk23z4tOSJ5gsVErac
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

The tx_flags of struct can_isotp_ll_options are set into the flags of
the created CAN FD frames. For CAN CC they have to be zero but for CAN
FD any value was accepted, so that CANFD_ESI and undefined flags were
sent in the CAN FD frames.

As CANFD_ESI is generated by the transmitting CAN controller only
CANFD_BRS is relevant for the transmission. Accept CANFD_BRS and the
CANFD_FDF marker (which is set by the CAN core anyway) and reject other
tx_flags with -EINVAL.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 197dc7bdb6ec..6ec7b10d7136 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1798,10 +1798,15 @@ static int isotp_setsockopt_locked(struct socket *sock, int optname,
 
 		if (ll->mtu == CAN_MTU &&
 		    (ll->tx_dl > CAN_MAX_DLEN || ll->tx_flags != 0))
 			return -EINVAL;
 
+		/* only CANFD_BRS (and the CANFD_FDF marker) for CAN FD frames */
+		if (ll->mtu == CANFD_MTU &&
+		    (ll->tx_flags & ~(CANFD_BRS | CANFD_FDF)))
+			return -EINVAL;
+
 		memcpy(&so->ll, ll, sizeof(*ll));
 
 		/* set ll_dl for tx path to similar place as for rx */
 		so->tx.ll_dl = ll->tx_dl;
 		break;

-- 
2.53.0

