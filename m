From: Maxime Jayat <maxime.jayat@mobile-devices.fr>
Subject: [PATCH] can-j1939: fix ecu allocation at bad time
Date: Thu,  9 Mar 2017 10:33:04 +0100
Message-ID: <20170309093304.31542-1-maxime.jayat@mobile-devices.fr>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:34222 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752797AbdCIJd6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 9 Mar 2017 04:33:58 -0500
Received: by mail-wr0-f180.google.com with SMTP id l37so40879491wrc.1
        for <linux-can@vger.kernel.org>; Thu, 09 Mar 2017 01:33:43 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc: linux-can@vger.kernel.org, Maxime Jayat <maxime.jayat@mobile-devices.fr>

In _j1939_ecu_get_register, create_if_necessary was ignored, which
lead to memory corruption (because of a bad refcount) when rebinding a
socket to a NAME corresponding to an ecu which had been unregistered
by an external address claim.

During the bind, in j1939_name_local_put, the ecu was reallocated, added
to the list of ecus and then freed immediately. So the list contained an
invalid item.

For instance, this created the problem:

- Bind a J1939 socket to source address 0x80 with name
    0x7777777777777777
- Send an address claim for this source address
- Another "external" ECU sends an address claim for 0x80 with name
    0x1111111111111111 (which has higher priority, so "wins" the source
    address).
- Re-bind the J1939 socket to source address 0x81.

Signed-off-by: Maxime Jayat <maxime.jayat@mobile-devices.fr>
---

After mentioning the problem on the mailing list six months ago
without much interest, I fixed it, but forgot to share the patch.
Sorry about that!

This applies on top of j1939d-v4.7 but it is probably necessary for
all j1939d branches.

 net/can/j1939/bus.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
index 651de574a3c5..a4d5877c8e0a 100644
--- a/net/can/j1939/bus.c
+++ b/net/can/j1939/bus.c
@@ -62,6 +62,10 @@ struct j1939_ecu *_j1939_ecu_get_register(struct j1939_priv *priv, name_t name,
 		if (dut->name == name)
 			return dut;
 	}
+
+	if (!create_if_necessary) {
+		return ERR_PTR(-ENODEV);
+	}
 	/* alloc */
 	ecu = kzalloc(sizeof(*ecu), gfp_any());
 	if (!ecu)
-- 
2.9.3

