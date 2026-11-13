Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794537209;
	b=HBQrQzJ/bCviJp2Sk1OYIS+9OOIgEgQQfIznp32cLFloFMtoC5oLrt7AUkoFr9fkcOOc
	 IwOmL3Te3T5hE5JPpYtnX47iMuznt3Ect9WgzOZICLFbS+blrLWqnxcE8mOQSQ9zvyf5O
	 EwaTAuO7LTaRpgnR7ol2KRQvP51XrR1QbcWkTiePYPn11Pj7cBDLcC9VoMO1AA/W4nIcj
	 pnH6mSYcfKoY+Yh720GI+WkpRNLSntzbAAmuQuvEu+cjam6g1iCz2jGq4pdlcGXrkUL3J
	 hDLGeIXIF7WWOZIv/g3cu51lcbqbQw9nOzFYwjmDSSXjMckJBWj6Iqokf7/52QrIiIQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537209;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wbZST1vJA+sptBoHxkIdeWy6DfjF7+YldX5KdzSx3ck=;
	b=wFDdnbyxuLImXFJzQl8kgZGukeC8QuIGLChl680PMlQ5a3o6c7P6UwWb1fyxtZD+G8QB
	 yeYQBIkCB49ySzOAVDDfKBxlnedQqnG1gBFYhaqm9dQcBcI5JEToWzpC7EjtD49PNhOxl
	 6scjFtUREYh5f5j3gff/Te+GSUsjyxH8TUl+zeuzz0i/gNKtydviM0gwC4kC7gF0BubKO
	 98QtdzPdgsZCufEey+47cqveIhtwLKUirVS+YK7u/b5xUD+6FmOwcvWyJqGwvRsGFW7r7
	 pvG6tvZ2PyOq+2tgsMI+IHpiPZEM24eULO4S9VgpO5BKNZ32GXbGTyqE1XE2lehC6Aw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Bk//eMyK";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7B5606A31C;
	Fri, 13 Nov 2026 02:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bk//eMyK
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794537209;
	b=UXDneyPLPnevzirqf6KFZMT3WEXEzisvg+0ywYbIko466JpF158Dnsm7ZVLeylgIhzTO
	 0mLN/kDIKOwtKaDd0JbUZMFOvhWxBrvVsHxtyFeRqFd5Btl2p0q2610XmlHYqWDk9+4Ez
	 7h9fceeJz6o4PP3/270u7tsMn2vqnE656syqtG2Z6hYfWdCD/2ld4IN+LiAFQOs1Oe2UE
	 mDtmnJM+CoSjXdpRHUzeDGcS+EMC4N8hkX87VQetMGE156Uftnr2XA1n+X3KL2EqVwFBe
	 PXLXk63EPQTbmEQQ9muCWeZvJmS89NnwhrTepmFIciIhESD+n9AaRtPuVQpPmuZZIUA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794537209;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wbZST1vJA+sptBoHxkIdeWy6DfjF7+YldX5KdzSx3ck=;
	b=1J1pfgJluYOX7JsZc87hQPCw53GEyWj6rC3c65LQdqkP4VYAVIP5f84kcm14WBHC19VK
	 dvuJoo/85ixEwrGYLi30t7088kmIzgNPhtSyxpAC4J4sfh4aooSKzYgCcsVhuUw8tWOvb
	 I7m3KWl9Qusu0oJkcmgE5hcwPqVOJ3ifYTk0fsN3ythdxZZL81DFPb0CdkP37Se9m/MvZ
	 I74dLL8ANNZitIDwm0WLKMwJ9kdN5FFqQbq4/OwsxVduuobLWldlHdDeAjz7rPgxB3qD3
	 i5ZkFnWi0y603yMpe7KJEvBvtGdDhmEuqoKxQo1JN15gcqYnVMHb9g0pNBTnRaFoDUg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C8E991F000C4;
	Fri, 13 Nov 2026 02:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794537209;
	bh=wbZST1vJA+sptBoHxkIdeWy6DfjF7+YldX5KdzSx3ck=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=Bk//eMyKXviKKSlBZK0/pOjrbmGfKGOrlxsgWGmYo/1TOuK2BrJE6RydCcmqq0/py
	 nerXqx01/eW+6wV27/usnDCdClzruGVIbRy0BS/cuoBZ8O3GULPm0JOiATBGyFQDXA
	 ZD2F4fLUkrVkWHYmby3CiA5tuZebznLBpKz7cTuB3wHLpM7c+2A+XGPPYb3WhDqH1h
	 5tH0Wne+EfPskOelEKBL7XbuxTYsFRZoo1eAgWJI29r1J46GNa2w9DgXd3xOXMztv8
	 5q5QPrDBGfyuriIcrTdwI+KWkFMqE8zYfZI5ByDPpz9O5FUodhDsjmQ7AkodnwI5sc
	 mzwDJGzPo2OWA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 30BDD475B4;
	Fri, 13 Nov 2026 02:33:28 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Fri, 13 Nov 2026 10:33:06 +0800
Subject: [PATCH net v2] MAINTAINERS: exclude CAN documentation from general
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
Message-Id: <20261113-exclude-can-docs-from-netdev-v2-1-8ae9dc553024@qq.com>
X-B4-Tracking: v=1; b=H4sIAOF29moC/42OTQ6CMBSEr0Le2mdsFVRW3sOw6M+r1EgrLTQYw
 t0teAGXM/nyzcwQKViKUBczBEo2Wu9y4LsCVCvcg9DqnIEfeMUY40iTeo2aUAmH2quIJvgOHQ2
 aEpYVO1816dIIA1nxDmTstOnvkBlofmUc5ZPUsIpXrLVx8OGznUhsg//bSwwZypLkUYqToEt16
 /u98h00y7J8AU3Z2VncAAAA
X-Change-ID: 20261112-exclude-can-docs-from-netdev-56179ded5faf
To: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, 
 horms@kernel.org, mkl@pengutronix.de, mailhol@kernel.org, 
 socketcan@hartkopp.net, robin@protonic.nl, o.rempel@pengutronix.de, 
 kernel@pengutronix.de, max@enpas.org, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Cunhao Lu <1579567540@qq.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794537207; l=2171;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=6F5YqxvMaIs1hwfEFbyXKXtIGxmZw++Ht0ooa1sJl88=;
 b=2DNpMdnz/83Syn6nW0AH1yBI48kZvv0cu5uv4pbBSxBZT83lgUHpn/v33Y0qTCpn1Mcz1CPHd
 ojULR3hSGccDOvJWX+jBOA9x/rKs40M64/FX5tRwWQHC5CmFIX0Z7LZ
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

The SocketCAN, ISO-TP and J1939 documents and the CAN driver documentation
directory match the broad Documentation/networking/ pattern in
NETWORKING [GENERAL]. This makes get_maintainer.pl select netdev and the
general networking maintainers for these CAN-specific documentation
changes.

Exclude these paths from NETWORKING [GENERAL], as is already done for
net/can/ and the CAN selftests. Add the driver documentation directory
to CAN NETWORK DRIVERS to cover files without a dedicated CAN entry.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/all/20261111161459.4879a82d@kernel.org/
Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
Changes in v2:
- Exclude the whole CAN driver documentation directory instead of only
  can327.rst, and add it to CAN NETWORK DRIVERS.
- Link to v1: https://patch.msgid.link/20261112-exclude-can-docs-from-netdev-v1-1-b5eb3ba4ae86@qq.com
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 222b7fc2c3aa..152771314140 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5992,6 +5992,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git
 F:	Documentation/devicetree/bindings/net/can/
 F:	Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
+F:	Documentation/networking/device_drivers/can/
 F:	drivers/net/can/
 F:	drivers/phy/phy-can-transceiver.c
 F:	include/linux/can/bittiming.h
@@ -19600,6 +19601,10 @@ F:	samples/pktgen/
 F:	tools/net/
 F:	tools/testing/selftests/net/
 X:	Documentation/networking/batman-adv.rst
+X:	Documentation/networking/can.rst
+X:	Documentation/networking/device_drivers/can/
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


