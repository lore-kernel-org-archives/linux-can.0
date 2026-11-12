Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794462711;
	b=qQIp8HPVyJpTNnz/8CpJ/yWpdQ5pWHV0XNMjO95n4M1G3xDUBi6OmrsFRShaOs8siHI8
	 tQLwUlXNLco/EQ2A4hgYS7cF0gJfUtLbj3GWC9McgtNKk539CsBih0pNhtARPwiBi5F0r
	 /kgd6NR/DbuNxd+6/va8knQ91tJL7PvCAdFVYWDLZC0grU/TlfBbJ4CbYI043m6OJEWNQ
	 ZIZTHr6YXtNV33GS8YwU/IXt5Nz6Z6F5J6tDcrzIIy94hSC6ZkuqUAHZo32f76RwzGund
	 VxhqAgrF5ZLzRcIZC8ZtrBp3vJcVb+h1K2G/uxHPZP0uCU1msEBfAmWCNM3T6hZ9Eog==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794462711;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=3NTxadOVq9q3/kjBdhZTjDycpZICzYHF9v07pA6aeQ0=;
	b=JCabUoXKss1cBD2CCB6f2N1ELiw+32XMBAfDIAY7qHiVDVTMwHse9puKz0/Yb6oyHJt7
	 ZmMtBumiPoikg2u478Cw+CmwqVETLPv+6xI/aU9u05P/ahw/GM+lBL5djhlFGuv/KKm7O
	 gumbGsOJQSspGyevy083eCBiUyD9BF0WfU0fk2E3dwC4yJwkPKCz5vFpji5/41Nnwhw+L
	 Cbw0sSp9ScYlbfIbEUik3AgFr3AnvTEv36jV7PzDLBcJd34a5XvjpL7/TSi6PsX7gHKZg
	 sutTo7TtEEtcEYsEC9IXCMun4zAFppj9aUOj3pcb+IEvNAjKDqLCfO9/vltoyNbTsbA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EanUsimx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6466F606A327;
	Thu, 12 Nov 2026 05:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EanUsimx
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794462711;
	b=KtfJOUz45rXqTYdTrLiM4ukYefsESBjtR4E677kEni32NbR8eatYk/xyu2eJwlegShkO
	 5KfEakUkGJya2YMCVgeYNi5RQ2zIFkST532Xjtrkwv35E6P5XRuN2Z2SpnZJZWh2m3qWf
	 DALXJBQX3c2X46zUCBiqTlGUuypL61M4uJZ3v/yW6lqz/nCldoZxCJP29JuDb7irWHcem
	 cGX2cDcaAicCqxNYVCH3q5CYxQSEFg54/01GbyTJOQu9En6WCfYFnHrB115/uvbMaVRRv
	 kHii/S4OEFxh4ItYEN/gq/48OOk4Oka/TeL38ayUtLOiP0wC6g1NfX/1w0ooVM7jsKg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794462711;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=3NTxadOVq9q3/kjBdhZTjDycpZICzYHF9v07pA6aeQ0=;
	b=DrGAtbxrO16gTL0HuZ2+Rp92WcfS58lDEt/pvmUc/h/Oq2Z5yP0/mkIPlNLlzqV7DkHS
	 YMZyu0IJ9manxqhSfq5uGl1MvuuTMVPq0kFva25grfI81P0hmS2SVYhq1ixWqCuxw8zgM
	 B51E7laRqSeaGTjXi0ILlAuEIuoFJXwY1Us3JT4ZK2W0kXV5Jmis6a/Vp1MCVB25vEvrQ
	 MLVq3VqlOv6geV4Pr5B5yTwwZfRHPjkwAylo0b0OjF/MfvPaak+CiecJpnXdiqhQAUjo3
	 1NPBSc8791Yx/RFNfaKFF4w2i6AczbUnCDYLLHPjkiJQjzq9vGbuatlMn5e4y+iyQLw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 895891F00A05;
	Thu, 12 Nov 2026 05:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794462711;
	bh=3NTxadOVq9q3/kjBdhZTjDycpZICzYHF9v07pA6aeQ0=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=EanUsimxt0InyFP44QTwfRXLRH0MPC5SnEMZ06JbewDWWjcpHoujV0931lFOEYI1l
	 nmSO+1ZiiDDOp5t8pqo9W0Jx+qA1nO9hecJ1+RAXDTfY/Qf3qGcB/URt9mDB0tJ2Ee
	 Li4TsbPN/LwTggvpWIhbXh6aSgfnmoCo/5gr4HI0cSEdBEVYYU5ofstcU7gwGfr7td
	 Z8xXrBAxC89CON1O4vOU6oN9KVauoObXBvscHUsX+PTm+kEKy0kToQMkcSLD7DZDUB
	 fxZ1N7ldhfCYwoBHs7PNbTcPm3TfcdoB9Ti8AfF42VxxW0XqRkK/dk6jev30u5DnJE
	 LOqbhm0wLpRXQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E2A82492D7;
	Thu, 12 Nov 2026 05:51:49 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Thu, 12 Nov 2026 13:50:25 +0800
Subject: [PATCH net] MAINTAINERS: exclude CAN documentation from general
 networking
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
Message-Id: <20261112-exclude-can-docs-from-netdev-v1-1-b5eb3ba4ae86@qq.com>
X-B4-Tracking: v=1; b=H4sIAKBT9WoC/yXMUQrCMBCE4auUfXbBBFrRq4gPcXeiK5pI0pZC6
 d2N+vgPw7dSRTFUOnUrFcxWLacWbteR3EO6gU1bk9/7wTnnGYs8JwVLSKxZKseSX5wwKmbuB3c
 4KrSPIVIj3gXRlh9/pvahy3+s0/UBGb8wbdsH5nMmjYUAAAA=
X-Change-ID: 20261112-exclude-can-docs-from-netdev-56179ded5faf
To: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, 
 horms@kernel.org, mkl@pengutronix.de, mailhol@kernel.org, 
 socketcan@hartkopp.net, robin@protonic.nl, o.rempel@pengutronix.de, 
 kernel@pengutronix.de, max@enpas.org, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Cunhao Lu <1579567540@qq.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794462709; l=1751;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=EDE/G8F7AsHZZC8XTFKoaDp+CkrXlJxUORBA2UZXClg=;
 b=1DDz/uZh0nk8aI17NVbPmWi9JCFjTJQ/qWJIX9P0DEMRV0wFBnfzmYfFxSeDqYtgfSoQg8n9H
 L7iZDPtorTZCgDjFoc9QuX6mdVSyBwZeXDXJGtstOy++hpamR+plokM
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

The SocketCAN, ISO-TP, J1939 and ELM327 documents are already covered by
CAN maintainer entries, but also match the broad Documentation/networking/
pattern in NETWORKING [GENERAL]. This makes get_maintainer.pl select
netdev and the general networking maintainers for these CAN-specific
documentation changes.

Exclude these four documents from NETWORKING [GENERAL], as is already
done for net/can/ and the CAN selftests.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/all/20261111161459.4879a82d@kernel.org/
Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
CAN documentation changes currently match NETWORKING [GENERAL], causing
get_maintainer.pl and b4 prep --auto-to-cc to select general networking
recipients for CAN-specific changes.

This patch excludes the SocketCAN, ISO-TP, J1939 and ELM327 documents from
that entry. All four already have CAN maintainer entries.
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 222b7fc2c3aa..cb1fec8ec5f5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19600,6 +19600,10 @@ F:	samples/pktgen/
 F:	tools/net/
 F:	tools/testing/selftests/net/
 X:	Documentation/networking/batman-adv.rst
+X:	Documentation/networking/can.rst
+X:	Documentation/networking/device_drivers/can/can327.rst
+X:	Documentation/networking/iso15765-2.rst
+X:	Documentation/networking/j1939.rst
 X:	Documentation/networking/mac80211-injection.rst
 X:	Documentation/networking/mac80211_hwsim/
 X:	Documentation/networking/regulatory.rst

---
base-commit: 79eb6679ef6a0d5ea68da53a8321fb1dc72299b9
change-id: 20261112-exclude-can-docs-from-netdev-56179ded5faf

Best regards,
--  
Cunhao Lu <1579567540@qq.com>


