Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.181.97.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793619220;
	b=PrbxIZRZTM7G+kVAj7zQbDLdAfK5OskZbg80Vy+eMy7omRCWqpvilzXegIN0v+fRPc0h
	 wnlG50WN4P0ybitJDG79hGDXkJirGcTaX/D0LuTpvfA4bfTH3W0FZOOfvNBkUh6SvymGu
	 y7ochDOKOfiPYGRWVl6ldXz4rJXA0dzQWVjUD58QMiBliaRrbJ4Kz615JHyFAd2FE9Lpm
	 dAilC96nyYF2zwNA7pj58l3vM27vPHTsgf8pztwiqwqZwNeepan4QC4ju/fMAKtPmz9iz
	 7encb/QwAt1NIe2VX1yatvZVHAsxYhMj5jeIGos+51N1jugVqjNduTI5jSaEPAu/T7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793619220;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Content-Language:To:From:Subject:Content-Type:
	 Content-Transfer-Encoding:X-Anti-Virus-Server:X-Virus-Status;
	bh=MBVZKcktkuzCX6oBhhf+RAoUvUaSUHFA5Ca/6N69yTE=;
	b=0YopTq5VOdvx9zgx3/RgKZ5Dt6WG4gDmKuzatWecGOkWUAH4txAdVRJ1ZUV446hU2ty/
	 zKDTT2PKEOEswY0SrVelNHOHxji6lq3cbhVDXGYllsaJRrJMSmSssn4t0AgeTXfGOTvjV
	 G4GaJKxzHoU+8Hj0mQPBEDlByhGWDiTC5Hi/I3P9IvnGUJf3ll7qm7KWD03KqenPo1OWK
	 ZLQPQcWTAPOAieWJSgcDjRu56kaBh0dY7gTwhlLh3FLMBp6PddHkvXOwp93rUTIMpsWXf
	 G+Z4pryALr6lgtgaeC6sduvTB52txtAxOJgBKKqdPvfiXZewEGpVd42vcW11Cu2Tu/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=I-love.SAKURA.ne.jp;
	spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp;
	arc=none smtp.remote-ip=202.181.97.72
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6550A606A326
	for <linux-can@vger.kernel.org>; Mon,  2 Nov 2026 11:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6550A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 6A2BXatY062282
	for <linux-can@vger.kernel.org>; Mon, 2 Nov 2026 20:33:36 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 6A2BXaaT062279
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO)
	for <linux-can@vger.kernel.org>; Mon, 2 Nov 2026 20:33:36 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <5455488f-7a99-4aa9-9d8c-b23660c63ea2@I-love.SAKURA.ne.jp>
Date: Mon, 2 Nov 2026 20:33:35 +0900
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
Content-Language: en-US
To: linux-can@vger.kernel.org
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] can: j1939: mark j1939_ecu_find_by_addr_locked() as static
 function
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav413.rs.sakura.ne.jp
X-Virus-Status: clean

Called from only net/can/j1939/bus.c file.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 net/can/j1939/bus.c        | 16 ++++++++--------
 net/can/j1939/j1939-priv.h |  2 --
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
index ed60258619e6..346c27321b8e 100644
--- a/net/can/j1939/bus.c
+++ b/net/can/j1939/bus.c
@@ -57,6 +57,14 @@ static __must_check bool j1939_ecu_valid(struct j1939_ecu *ecu)
 	return kref_read(&ecu->kref);
 }
 
+static struct j1939_ecu *j1939_ecu_find_by_addr_locked(struct j1939_priv *priv,
+						       u8 addr)
+{
+	lockdep_assert_held(&priv->lock);
+
+	return priv->ents[addr].ecu;
+}
+
 static bool j1939_ecu_is_mapped_locked(struct j1939_ecu *ecu)
 {
 	struct j1939_priv *priv = ecu->priv;
@@ -195,14 +203,6 @@ struct j1939_ecu *j1939_ecu_create_locked(struct j1939_priv *priv, name_t name)
 	return ecu;
 }
 
-struct j1939_ecu *j1939_ecu_find_by_addr_locked(struct j1939_priv *priv,
-						u8 addr)
-{
-	lockdep_assert_held(&priv->lock);
-
-	return priv->ents[addr].ecu;
-}
-
 struct j1939_ecu *j1939_ecu_get_by_addr_locked(struct j1939_priv *priv, u8 addr)
 {
 	struct j1939_ecu *ecu;
diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index ee85b36e122d..2090d909685c 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -129,8 +129,6 @@ void j1939_ecu_unmap_locked(struct j1939_ecu *ecu);
 void j1939_ecu_unmap(struct j1939_ecu *ecu);
 
 u8 j1939_name_to_addr(struct j1939_priv *priv, name_t name);
-struct j1939_ecu *j1939_ecu_find_by_addr_locked(struct j1939_priv *priv,
-						u8 addr);
 struct j1939_ecu *j1939_ecu_get_by_addr(struct j1939_priv *priv, u8 addr);
 struct j1939_ecu *j1939_ecu_get_by_addr_locked(struct j1939_priv *priv,
 					       u8 addr);
-- 
2.56.0

