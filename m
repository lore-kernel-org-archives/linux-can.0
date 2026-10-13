Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F024F93B7
	for <linux-can@vger.kernel.org>; Tue, 13 Oct 2026 11:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791892752; cv=pass; b=S4RczWYQxJBcVebI9YCCV3fNCcGhTilMCGzBJtyMSsuXYKBHQzT7Oq5dU9gWCN4jyNQwyLcRBKUh0CV0iMiG0G6FKY2xDoWs7gvJ6FuQwx2sZfEY0Ja+Vc78ck6qp6YF9kvAbQ+AllXQa8x2Bbi+e6x690KL/yOuOwaa/xsUixs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791892752; c=relaxed/simple;
	bh=kYo6i7vXxrCImDfL76t3BplfMNfU+Jqm5mA49GAIl9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oo5sOP1RPFKBngQzZDuW6NwoSxInMjrIoHTZk8D82LacCp1c5M55Po8V8EGcj29dB3l71Mic+oYFAuaId1EVzhmzkrjglkagv2hrzmqJdZnIFCKBci2N8q9tpFddTKAY6owXgeGgwXZ078fLkJ3PQwwTnaWL8eqVccovvfpRqQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=QQ1MDVcF; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=mf9+Ur3u; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="QQ1MDVcF";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="mf9+Ur3u"
ARC-Seal: i=1; a=rsa-sha256; t=1791892563; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Xasjs70Wa1RWmc1pGWmtV0K2tVWklKQQ7G4Ee2wibI4hLrbcjUZUOIow7zZn8B1Wvk
    YmnECXNwN2EJ/rWothcZM+o/xbQMWw4MCWLBoyoz8mwS8vZmLEkSU5xxCPARmz12Y5SN
    ZbPpfs3vF9JwtQeOqlLrzJW1MAr5x05zdq0LgBc6QRtroqg97uUMJYxNSsRAggat4mqb
    PhUd9L6a8G9xJBCIOup+8n2mWO0VelUYuZil7FGy7TuKRugGWi1/Gk68Xfgtyp5Amtfl
    abT3tTaioRV7la9eb6vY9otjRRkaRMbQs/Ar6F/Tx0KjdAJZbojw8uwp5201BMnIQH44
    PY5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1791892563;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=HoRlw8tGqML2awUueJ8JXaaunEdVdDLQM9faHt1sTm0=;
    b=P5cyGjEYWikZqK0qQXeYhvJhY5F63CWgF/hA56yfzrHXa5vqIYNh+5a7NCPjUrnWFg
    Y9xenulSzrDRPh0tVHN1hm1ujGjP68RWvJmqRxiwf4DrMaMhMixoNJce8wwqipze0XQR
    Q1Ctef3wCJM+pIcShcNZA32v2DwAl0VfJPgFmyNMUFE5e02ajwABaIky4RwAXtq0Co3C
    qOUhrxQB8OJTT8T+3MRQ2+C/wVEVIqrjMBr7W2qgguLLSIBJrRikChp3NO0sTJwENim8
    1oh6S0ZVSdul6k3CerqvgQiZtpuw6FxNVM+5H1Y1mC6+ugZoTcu46ZwTINkbYLveQHMZ
    a34g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1791892563;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=HoRlw8tGqML2awUueJ8JXaaunEdVdDLQM9faHt1sTm0=;
    b=QQ1MDVcF8i+N/Ftnj6utPsStnTeCNy9C15FhXD4uyBckLTQzodUFOsqdUfr2yb1l+E
    6Xdj3vQ4DaFraZ3dU+S/q6kI+yxYzJ1N7O4KKw1WMIq5IqQkvqH/rulpipZAYTuZm9W7
    gIyDXonUMYd7zWRIFsmTJUqRwWOoInWAmq1f2fB3J0HrHpvn3kDlPhBqqpxRehhcmeVY
    uin5wxlpzFDOQ/8J/SZqxLP0yQOxJOzect+DumRsHXQmHQ+IxNycpl4zO0G+PySWTHJ3
    erT81unsHiee7PfW3HpA0+5Tqy7ftRiWlcf4uy/sdzzjJ+wpsIEsyB6UjhH9anYZiHXY
    n39A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1791892563;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=HoRlw8tGqML2awUueJ8JXaaunEdVdDLQM9faHt1sTm0=;
    b=mf9+Ur3uFD+0fAzuUQ5Y2VLuY5+/LCs5WlKH79MuVvbZLMKoVf/bIZxbX5nPz0znG8
    CWapWYfcmFV6mFK3XPBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29DBu36Cw
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 13 Oct 2026 13:56:03 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH can-next] can: raw: take rtnl_lock() before leaving the notifier list
Date: Tue, 13 Oct 2026 13:55:57 +0200
Message-ID: <20261013115557.114582-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

raw_release() removes the socket from raw_notifier_list before it takes
rtnl_lock(). As the netdev notifier chain runs under RTNL, a socket that
leaves the list in this window is skipped by raw_notify(). This is not
harmful for raw as the filters are removed with dev_net(ro->dev) under
RTNL, but the receivers may briefly remain on a device that has already
been moved to another namespace.

Align raw_release() with the isotp and bcm fixes for the same window and
take rtnl_lock() before removing the socket from the notifier list. As
raw_busy_notifier can not point to the released socket under RTNL,
replace the busy-wait loop with a WARN_ON_ONCE().

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/raw.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index 0acd4f6c6dd6..925c0c1d243f 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -420,20 +420,21 @@ static int raw_release(struct socket *sock)
 		return 0;
 
 	ro = raw_sk(sk);
 	net = sock_net(sk);
 
+	rtnl_lock();
+
+	/* The netdev notifier chain runs under RTNL, so raw_notifier() can't
+	 * be walking raw_notifier_list and point to this socket. The spinlock
+	 * is still needed as raw_init() adds sockets without holding RTNL.
+	 */
 	spin_lock(&raw_notifier_lock);
-	while (raw_busy_notifier == ro) {
-		spin_unlock(&raw_notifier_lock);
-		schedule_timeout_uninterruptible(1);
-		spin_lock(&raw_notifier_lock);
-	}
+	WARN_ON_ONCE(raw_busy_notifier == ro);
 	list_del(&ro->notifier);
 	spin_unlock(&raw_notifier_lock);
 
-	rtnl_lock();
 	lock_sock(sk);
 
 	/* remove current filters & unregister */
 	if (ro->bound) {
 		if (ro->dev) {
-- 
2.53.0

