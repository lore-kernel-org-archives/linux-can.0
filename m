Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.181.97.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793144029;
	b=sdTPHxr/PRObo0deHFXxTUl5wUZa98VKRGpIZQD22Gzcp8/mIvlsDvh1HTsitfA6Uzl/
	 QukElfeJVA4lqo8hPby9GzJW4W5ylor9Mxp/eXRUlEAex7Kwia34ek7HLSpPN5J3bOPzl
	 ktrBYWQfZuPkHiaRRJENhDpcl6jZ6AneQll0GrEBKWpeAv5hQx4/uuIaAki0keGlhtkQa
	 BT7TCugsDCw80TXB5nQCU9chUUB7cpaIPe8Z+GHxNNCn2T0ladTPEDprAc8cVzYLy3Qnh
	 rZ4zdyg9R8dX840whei39zuZoyN+EKLFgk4jMcy8BHDLF/Abc0UIv7UhLF9zguRaBWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793144029;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:From:To:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Anti-Virus-Server:
	 X-Virus-Status;
	bh=BsyAyFYj8egP+FwvhAurh8aH/KVjA4hGAJGYO8v1qXk=;
	b=R9Na2qHm71pzkpNl08jteBhBL8viAm7ok1nXWp/jDiUGw+tmYmr/miblVAY1PS1poyhH
	 HMhtDMZeBLwgLSi5j/J+KnwRRvvGkWefNS2krCbSOQswxIEtzv+qAEv5KvSO1Bx5w8a3A
	 IsrGiD7J4wXU03Cspa1Sl4dvhFGd+wzNxDst1XJ7dSNypCNEuEksBTo//pGVVJS2UxvFw
	 ucVNSkFitxoEtVs/dQDPK+5kY06rANRFX8Z+SQtIEstFgKTcQGB9+dor/yl7yIU9pzncM
	 mtLDwfXGTAOZJPBJgjWXhzwswm0+VgGi0xSQBgVakNF2/lXP7ZMAeQHygED9UO1GvxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=I-love.SAKURA.ne.jp;
	spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp;
	arc=none smtp.remote-ip=202.181.97.72
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EDA606A31D
	for <linux-can@vger.kernel.org>; Tue, 27 Oct 2026 23:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9EDA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 69RNXOnU098941;
	Wed, 28 Oct 2026 08:33:24 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 69RNXN5N098938
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 28 Oct 2026 08:33:23 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <7d194c9a-c89d-4e2d-8eba-b2bf5d4ebde7@I-love.SAKURA.ne.jp>
Date: Wed, 28 Oct 2026 08:33:23 +0900
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
Subject: Re: [PATCH v4] can: j1939: fix j1939_ecu refcount leak
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
        Oliver Hartkopp <socketcan@hartkopp.net>
References: <4b2c8d95-d17e-4f36-a340-abf84693d24a@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <4b2c8d95-d17e-4f36-a340-abf84693d24a@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav413.rs.sakura.ne.jp
X-Virus-Status: clean

Sashiko mentioned that there is a garbage comment in the v4 patch.
Please fold below diff if applying the v4 patch.

 net/can/j1939/bus.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
index 63210da8b7a8..e97ea2a51f65 100644
--- a/net/can/j1939/bus.c
+++ b/net/can/j1939/bus.c
@@ -134,8 +134,7 @@ void j1939_ecu_unmap_all(struct j1939_priv *priv)
 	write_lock_bh(&priv->lock);
 	/* Cancel all pending address claim timers before unmapping.
 	 * This prevents an orphaned late-firing timer from re-mapping
-	 * an ECU after the spaces are cleared. Since j1939_ecu_put()
-	 * might make , we need to skip invalid ECUs.
+	 * an ECU after the spaces are cleared.
 	 */
 	list_for_each_entry(ecu, &priv->ecus, list) {
 		/* It is OK to call j1939_ecu_timer_stopped() even if there is
-- 
2.55.0
