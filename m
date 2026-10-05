Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17F0478868;
	Mon,  5 Oct 2026 10:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791196863; cv=pass; b=qUUCM/pAXOFWFxgzu59LqgwK6eBVli9l5TPdke6ufjFNAdpIz8VNrrigWB/TSBqrmgp5IiQCyTv23nRpyfPTX2sj+iSYB4wLEiqHEze16nX9CIyRrdtE6+GU37grk5hvGIy4jpWsx1iuRyuhRYcw/U/posjs7MtHypnjrxGBJQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791196863; c=relaxed/simple;
	bh=fez5MolD/eNQHEEtgkVlyPhDwureqrwC7iVwSLwTdLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EvZVen6QHzKqkIed8CkJu6v1vPuQLPvph42J1Nmc1PJ5DBt32AniVgu+N6a+XKV1BYGu1DezcDGVRtsl56uUpF97pZbnty0DrSI/8v13zSl0RQykBNUoaeKkiI+d0+NuwHVwY9XrZ/E9oYOb2BHI1x6Ay5s6GBXIZUD/ZPQr/T0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=VmXJroTd; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="VmXJroTd"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 034F6202013;
	Mon, 05 Oct 2026 12:40:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791196859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DB4N/7Jka3x/wS0GhUJwRJxTuncGdqkY0NyC8QMQFRg=;
	b=VmXJroTds39QWJ71+FAXtmaS+8Qnw21pkdwMaGWxtVQKaIQurtFwpVOShyYHDgN1AlsOXZ
	p9mm9bIwix+Ftah7zNBHDPT6esqb8T26WVrt10erskYWnqbNWwC9Vyirk7JmGz+DSHgP1b
	XiyMtfxVB794kd+NgXdit/Y9aW0B4AUHUdrjr66fL4yB8ViOKgleJZ65KvxflgUoLBrmpa
	UDg+ereVpPUY5/i1M1pbNl0RrKuwVCpCGAHCesBUwFelxUDpAhNEjAm3Yq5UFfB5gm/dk9
	Rw25mFL8CXDFYs7JjMAdBVu4zMMG0ZOSg30LK2LRN7IG+6PJUbR9E24asYeHRA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791196859; a=rsa-sha256;
	cv=none;
	b=K6miemu1fnExvtrqcapiVs9OjmxSIqq71jY8bmPrtY2+91UT5bV5xZuIBwdf41rGBOC0/8
	AccehmfFF2CZm2CPQYBqy4ZFm4SBkxBX66HZiNkvS9pQgqsZXPXyBzJnx0bbBVkrVyvPHS
	VreR7x7bEIjzPQPykdbe2r+iidIKPV6YCH8gBHt7wNxYVArFMjiyYT86uFEXIyw7ZwGZ4f
	D0596eEEZue2rmrZhL+6Os+tPk/G+fiwW/Fp2Q/vPzWOgNfgEO+7UBkdAMN0pu2ODdbUNq
	KwpwC9OJsLiSRZJparZvUJ3WAX3amXdGMysGNl8kgQF+LVC9UCZTcK5NhX3AhA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791196859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DB4N/7Jka3x/wS0GhUJwRJxTuncGdqkY0NyC8QMQFRg=;
	b=djysBMWysKST8XH38y9S97Ms7e0/2AKLcNAGB53rQId7gstpvrzeq7FwrNFq4tEY6co0LY
	6c4cxRXAAUUAFhexyfQ+gcPF/COoK7ggOY6oaygxFL1Ar3ItxkCcC3Aa9wWrmikL4AREje
	bYRz8k5uACojcW4WpZ4sl/2T31vPhPPjvPnFalDvR3A5VsMs94ca9zQ6lGJCNnvC7Ivvmo
	0Oz02b8uA/mS/yjjgq6BkZWhKru1RpnSU2hS29W8GNWK9xb+NqWnYlk0py+ab/72j+JCrm
	+joWoKAq5/M04OSyZC48K3ey0Ph3CHx/C7avzV4TRaVgpr3VmXneDN6o3VjBnQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xDg7u-004Mx9-2x;
	Mon, 05 Oct 2026 12:40:58 +0200
Received: from hardanger.blackshift.org (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 82EA25BA0DE;
	Mon, 05 Oct 2026 10:40:58 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 05 Oct 2026 12:40:25 +0200
Subject: [PATCH RFC 2/2] can: mcp251xfd: mcp251xfd_irq(): add call to
 can_rx_offload_threaded_irq_flush()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-upstream-can-rx-offload-batching-alternative-v1-2-4c08ccb516ec@pengutronix.de>
References: <20261005-upstream-can-rx-offload-batching-alternative-v1-0-4c08ccb516ec@pengutronix.de>
In-Reply-To: <20261005-upstream-can-rx-offload-batching-alternative-v1-0-4c08ccb516ec@pengutronix.de>
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Thomas Kopp <thomas.kopp@microchip.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=893; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=fez5MolD/eNQHEEtgkVlyPhDwureqrwC7iVwSLwTdLo=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsg6XLf97vEjc7SzNFQd9Hpb7C+f2GdS06dZxzoncFua0
 zUe9qcXO0pZGMS4GGTFFFmW/jihKBDoUNr7MmESzBxWJpAhDFycAjCRPbsYGTawejE/W/du6k7G
 5tbLVY7tv78ytcWWufTLvLhi9uZchg/Df+/LSsX2tw+sPLSmf/KyA5cXWSw6U7L09OVFt48pzwn
 a/4gRAA==
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

Under certain load situations, the threaded IRQ handler will not exit
the while loop, resulting in unlimited growth of the
offload->skb_irq_queue.

Call into the newly added function can_rx_offload_threaded_irq_flush()
to flush parts of the offload->skb_irq_queue.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index f441f2265299..208595c0cc46 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -1615,6 +1615,7 @@ static irqreturn_t mcp251xfd_irq(int irq, void *dev_id)
 			}
 		}
 
+		can_rx_offload_threaded_irq_flush(&priv->offload);
 		handled = IRQ_HANDLED;
 	} while (1);
 

-- 
2.53.0

