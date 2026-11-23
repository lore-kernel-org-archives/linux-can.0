Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795444599;
	b=HVgdAn1GPFtRP2rfdmoAdvb9BY5akkeo8bZ1N11o5yNYYZe3irmqBFdArHhNv8thEiCs
	 JQhGybJgyGsceQQx+qOu/FqtDMwIcpZna+yXhlyY2qI+aIfKcL2p3gO7xPocy678EenG8
	 2RMlhg7Q6ZphZPEi1TVAQNNfPXfBo1gYJU6KrwNqyLXoIiSva31qrfyAiLOJkC1sCz6Tx
	 mID6mEeegD7fm2Qu6mOeBqRjpCNIErx9k/D9hSQe/1SyDhy8P9CFIjO2BWuRid7LV94aG
	 mgczRSk6jJ4uu9J3Dr4a7q7gWLmtGeZhCZPGz8mejH5jQfpvhjKZdW6uNjrfDJR1H5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795444599;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=c7RIFJ9JCRdyaG8UKVxLRWxNqNn9TfnyLCzHHvdNicM=;
	b=rX3jacE7OZg+ZIXeYRQusbzlDZy3DKuxyF4g7/3QdKMCw2AFxqcoGRixBVrzRV84MVf2
	 2Hy9DeyKvMfQgozIN6f/KXY/9i1RJ9MG+ufFKYmr0KJ2Fh2ldeM/VMykqTlunvhYP3Gy3
	 kMKHlqjazUs8MYxc9F540YDRvEHxJLU/L4LrRMCPCQfCWEzJwjS2SR8yz5ajC+mBALJbY
	 mhxifxeh/b77JT6eBpb0uQ6681wAxCF4W6WeHER5vlbontvEBe8EtRLpWPbznhhbh4Ff8
	 jwMrpqCIsFaFqwwFBPVctlF3iNVJ+TkScVk7MICr7QzJZp45qvPnH+yntWEquYjV0JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iiitd.ac.in;
	spf=pass smtp.mailfrom=iiitd.ac.in;
	dkim=pass header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=HQ61VKDz;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221A3606A327
	for <linux-can@vger.kernel.org>; Mon, 23 Nov 2026 14:36:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 221A3606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=HQ61VKDz
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2f037bc348dso27821335ad.0
        for <linux-can@vger.kernel.org>; Mon, 23 Nov 2026 06:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1795444597; x=1796049397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c7RIFJ9JCRdyaG8UKVxLRWxNqNn9TfnyLCzHHvdNicM=;
        b=HQ61VKDzJuSyLg0GiLde4RIIRMg54I5xdOttpoZvzcz3swdIwdA/eSKH7IrbCIaMFH
         1ftQy0jVuo5nXxQBRZcVdZovUXDtn1enquSp8suF8HRaLvAAz2EKh4Af0WRRUH4/wAlv
         esH1cGnI3PK8URfa4yjsw4UQA14K+y/p53Aos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795444597; x=1796049397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c7RIFJ9JCRdyaG8UKVxLRWxNqNn9TfnyLCzHHvdNicM=;
        b=O8tx0f9yPdi2cKR8Qq5+Jqf3XxAOGbHELPE70KU/ckAdKGDlBzIB297o+4Yp1a74eZ
         g0WR2TH/uwOeUPiXLWFyVanwHdR260MK87632eki+gpvufCpBoglNfS9XwcVOmql/6Hj
         FAp9SSm91ttKjZJnKG1g1cHweaGAzPU/NR45/zkrFTNAi9JcRXmjPKnTM409hde30oU+
         7lSUqOEzccKjT2vi4Kl3ft3SXCkCQJZ7zK7ZeZMwnoZol2lBOazFbDGzMajFmlufeG6Z
         uqmzkqfclFgHpho4/3mxc2ZZX+VuUJlhXhiHk4HAw+tUU+USQ75mbMWFnGuL7/SRnLOp
         X2MA==
X-Forwarded-Encrypted: i=1; AL+hErF604GAga67sawWEKbH9TNtH5D7ZymshKgBL2pyyleUnojJOQbC0gRVjysIVatQsr4vxcvqAB0iTQ0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+n5fTtPESuoQbfA0MFb5dsTG2zo3TKiv1fdyZy8p/W70VCl6EX
	k05JIKZDDKxcHM5KKdwB9Eo3/N4yZYXLHsbRzz9AOv9mgCySwCWzYeGH6jGI3xRedpM=
X-Gm-Gg: AZFdTZfyMI6nNoD9kTcHZGOPBUqoLT5RAz0Mer+Sz7LttalHhgXkyrQCdCRsP6kgOuP
	EFdo/W5zvIFT9vPxqfQoONNZOWv7kvVOt5SAmnoSBbObhbprjx4xLe6QPJnqoXCbg+aF3EHnz2y
	NZmSA9kkqLrxys9+d70BADSGzTFJjidLW7e0kEUSuzchFKh9iAqFq0fj7TEHzZlDYVa40WWQnBV
	HAU3oEcyi8fdcZjzfIw9WJdHfa0WPr7NfqwDbJwgN60Ox/iN/NoX6Y2A6xDEEuNcl7rQQXalQt2
	k/sGgDTuMtM7ix6ruNl0r5qTRC1WuI1ayvFq198cfUTzqyhYVfuQ3tvwMooayvxIw+i3bUEeEBG
	ENlOjfxq3acsjzH12jO5GAHsvS3zoCL2QhQwLlH6lAICNcxlkBQI1lIovAVAuaB/66KZxMGOCEA
	uw1txmoqKnGNQaPwCUAvSLW2oYzBG1pq6fZfkfkppOJEp4011eRHoPMJK1AUHPvKCeOkLeM0FWp
	c2BKWfFHp0yJbkGWg6tIqIBtQWpLiofFDCfucGyUMlWBhvNxkPADTnJItbxB800gu4zSsBGx1ac
	0qBHt+EJec2h3mublTT6jvcaOarL92x+IhlI7bZaTCImNK8VwRDfMjv2WvvQ87BXjqqbSsciwFU
	0kT4nxtcR/WwkwUv6GTEPiBmkMEwRIL0lJzSNXk5R0RZ4lcQuQmWndJPh2iLlGrVG3Q==
X-Received: by 2002:a17:902:ced1:b0:2f0:340d:dda4 with SMTP id d9443c01a7336-2f03f1ec3fcmr143338425ad.24.1795444597511;
        Mon, 23 Nov 2026 06:36:37 -0800 (PST)
Received: from iiitd-S2600STB.iiitd.edu.in ([103.25.231.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03ee85466sm54062085ad.4.2026.11.23.06.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 06:36:36 -0800 (PST)
From: Piyus Kedia <piyus@iiitd.ac.in>
To: Robin van der Gracht <robin@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Cc: kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Kapil Vaswani <kapil@presceralabs.ai>,
	Piyus Kedia <piyus@iiitd.ac.in>,
	stable@vger.kernel.org
Subject: [PATCH net] can: j1939: do not pass a NULL session skb to the socket layer
Date: Mon, 23 Nov 2026 20:06:25 +0530
Message-Id: <20261123143625.4021586-2-piyus@iiitd.ac.in>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261123143625.4021586-1-piyus@iiitd.ac.in>
References: <20261123143625.4021586-1-piyus@iiitd.ac.in>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

j1939_session_completed() hands the session's skb to the socket layer
without checking that there is one:

	if (!session->transmission) {
		se_skb = j1939_session_skb_get(session);
		/* distribute among j1939 receivers */
		j1939_sk_recv(session->priv, se_skb);
		consume_skb(se_skb);
	}

j1939_session_skb_get() returns the skb covering the session's current
offset, or NULL when the queue holds none, and j1939_sk_recv_one() then
dereferences it on its first statement:

	if (oskb->sk == &jsk->sk)

sk_buff::sk sits at offset 0x18, which is the address in the report below.
consume_skb() tolerates NULL, so the dereference is the only fault.

A peer reaches this by completing a transport session that has no data
queued - an EOMA for a connection whose data packets never arrived:

  BUG: KASAN: null-ptr-deref in j1939_sk_recv_one+0x34/0x170
  Read of size 8 at addr 0000000000000018 by task syz-executor
   j1939_sk_recv_one          net/can/j1939/socket.c:318
   j1939_sk_recv              net/can/j1939/socket.c:363
   j1939_session_completed    net/can/j1939/transport.c:1247
   j1939_xtp_rx_eoma_one      net/can/j1939/transport.c:1424
   j1939_xtp_rx_eoma          net/can/j1939/transport.c:1439
   j1939_tp_cmd_recv          net/can/j1939/transport.c:2153
   j1939_tp_recv              net/can/j1939/transport.c:2201
   j1939_can_recv             net/can/j1939/main.c:108

Test the skb before using it, as the two other callers of the getter in
this file already do (j1939_session_tx_dat() returns -ENOBUFS, and
j1939_xtp_rx_dat_one() warns and cancels the session).  Nothing is warned
about here: a session completed with no data queued is a peer's protocol
error rather than a kernel one, and a netdev_warn() on this path would let
a peer flood the log.

Cancelling the session instead of dropping the completion may be the more
correct protocol behaviour; that is left alone deliberately, so this stays
a fix for the dereference.

How this was found: by AI-driven fuzzing built on top of syzkaller.  Its
analysis was checked by hand against the code, the fault was reproduced on
net.git main under KASAN, and the patched kernel is clean on the same
reproducer with ordinary J1939 transport sessions unaffected.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Kapil Vaswani <kapil@presceralabs.ai>
Signed-off-by: Piyus Kedia <piyus@iiitd.ac.in>
---
 net/can/j1939/transport.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 8fcfd13e5e6f..af54e6a6bd71 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1243,9 +1243,11 @@ static void j1939_session_completed(struct j1939_session *session)
 
 	if (!session->transmission) {
 		se_skb = j1939_session_skb_get(session);
-		/* distribute among j1939 receivers */
-		j1939_sk_recv(session->priv, se_skb);
-		consume_skb(se_skb);
+		if (se_skb) {
+			/* distribute among j1939 receivers */
+			j1939_sk_recv(session->priv, se_skb);
+			consume_skb(se_skb);
+		}
 	}
 
 	j1939_session_deactivate_activate_next(session);
-- 
2.34.1

